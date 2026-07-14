using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Http.Features;
using Microsoft.AspNetCore.Http.Json;
using Microsoft.AspNetCore.ResponseCompression;
using Microsoft.Extensions.FileProviders;
using Microsoft.Extensions.Options;
using Microsoft.OpenApi;
using Mozo.Api.Abstractions;
using Mozo.Api.Helper;
using Mozo.App.Catalogo;
using Mozo.App.Login;
using Mozo.App.Maestro;
using Mozo.App.Seguridad;
using Mozo.Infrastructure.Persistence;
using Mozo.Shared.Exceptions;
using Mozo.Shared.Services;
using Mozo.Shared.Services.Storage;
using Mozo.Shared.Token;
using Npgsql;
using Scalar.AspNetCore;
using Serilog;
using Serilog.Events;
using Serilog.Exceptions;
using System.Data;
using System.Data.Common;
using System.IO.Compression;
using System.Text.Json.Serialization;

Log.Logger = new LoggerConfiguration()
    .MinimumLevel.Information()
    .MinimumLevel.Override("Microsoft", LogEventLevel.Warning)
    .MinimumLevel.Override("Microsoft.AspNetCore", LogEventLevel.Warning)
    .MinimumLevel.Override("System", LogEventLevel.Warning)
    .Enrich.FromLogContext()
    .Enrich.WithExceptionDetails()
    .Enrich.WithMachineName()
    .Enrich.WithEnvironmentName()
    .Enrich.WithProperty("Application", "Mozo.Api")
    .WriteTo.Console(
        outputTemplate: "[{Timestamp:HH:mm:ss} {Level:u3}] {Message:lj} {Properties:j}{NewLine}{Exception}")
    .WriteTo.File(
        path: "logs/mozo-api-.log",
        rollingInterval: RollingInterval.Day,
        outputTemplate: "{Timestamp:yyyy-MM-dd HH:mm:ss.fff zzz} [{Level:u3}] {Message:lj} {Properties:j}{NewLine}{Exception}",
        retainedFileCountLimit: 30,
        fileSizeLimitBytes: 10_485_760) // 10MB
    .CreateLogger();


Log.Information("=== Iniciando Mozo API ===");

WebApplicationBuilder builder = WebApplication.CreateBuilder(args);

// Valida el grafo de dependencias al arrancar (en TODOS los entornos, no solo Development):
// si falta un registro (AddScoped olvidado) la app no inicia y reporta el servicio exacto,
// en vez de fallar en runtime ante el primer request en Production.
builder.Host.UseDefaultServiceProvider((_, options) =>
{
    options.ValidateOnBuild = true;
    options.ValidateScopes = true;
});

builder.Services.AddPersistence();

// ✅ Usar Serilog como proveedor de logging
builder.Host.UseSerilog();

#region Servicios


builder.Configuration.AddJsonFile("appsettingsapishared.json", optional: false);

string allowedOrigins = builder.Configuration.GetSection("AppSettings").GetSection("AllowedHosts").Value!;
builder.Services.AddCors(opt => opt.AddDefaultPolicy(config =>
{
    config.WithOrigins(allowedOrigins)
    .AllowAnyHeader()
    .AllowAnyMethod();
}));


builder.Services.AddSingleton<JwtKeyProvider>();
builder.Services.AddScoped<IJwtService, JwtService>();

var storage = builder.Configuration.GetSection("Storage");

Directory.CreateDirectory(storage["FolderDocument"]!);
Directory.CreateDirectory(storage["FolderResource"]!);
Directory.CreateDirectory(storage["FolderTemporary"]!);

builder.Services.AddEndpointsApiExplorer();

builder.Services.AddOpenApi(options =>
{
    options.AddDocumentTransformer((doc, context, ct) =>
    {
        doc.Info = new OpenApiInfo
        {
            Title = "Sistema Mozo API",
            Version = "v1"
        };
        return Task.CompletedTask;
    });

    options.AddDocumentTransformer<BearerSecuritySchemeTransformer>();
});


builder.Services.Configure<JsonOptions>(options =>
{
    options.SerializerOptions.DefaultIgnoreCondition = JsonIgnoreCondition.WhenWritingNull;
});

builder.Services.AddScoped<Authentication>();

builder.Services
    .AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddJwtBearer(opt =>
    {
        opt.TokenValidationParameters =
            JwtService.TokenParametro(builder.Configuration);

        opt.EventsType = typeof(Authentication);
    });

builder.Services.AddAuthorization();

builder.Services.AddCustomProblemDetails();

builder.Services.AddOutputCache(options =>
{
    // Sin filtro — 1 sola entrada en caché
    options.AddPolicy("pais", p => p.Expire(TimeSpan.FromHours(24)).Tag("pais"));
    options.AddPolicy("empresa", p => p.Expire(TimeSpan.FromHours(24)).Tag("empresa"));
    options.AddPolicy("modulo", p => p.Expire(TimeSpan.FromHours(24)).Tag("modulo"));

    // Con filtro — varía por querystring
    options.AddPolicy("docidentidad", p => p
        .Expire(TimeSpan.FromHours(24))
        .SetVaryByQuery("copais")
        .Tag("docidentidad"));

    options.AddPolicy("tipogeneral", p => p
        .Expire(TimeSpan.FromHours(24))
        .SetVaryByQuery("comodulo", "cogrupo")
        .Tag("tipogeneral"));

    options.AddPolicy("tipoparticular", p => p
        .Expire(TimeSpan.FromMinutes(60))
        .SetVaryByQuery("coempresa", "comodulo", "cogrupo", "cogrupopadre", "cotipopadre", "flestreg")
        .SetVaryByHeader("Authorization")
        .Tag("tipoparticular"));
});



builder.Services.ConfigureHttpJsonOptions(options =>
{
    options.SerializerOptions.WriteIndented = true;
    options.SerializerOptions.IncludeFields = true;
});


builder.Services.AddResponseCompression(options =>
{
    options.EnableForHttps = true;
    options.Providers.Add<BrotliCompressionProvider>();
    options.Providers.Add<GzipCompressionProvider>();
});

builder.Services.Configure<BrotliCompressionProviderOptions>(options =>
{
    options.Level = CompressionLevel.Fastest;
});

builder.Services.Configure<GzipCompressionProviderOptions>(options =>
{
    options.Level = CompressionLevel.SmallestSize;
});




string connectionString = builder.Configuration.GetSection("ConnectionStrings").GetSection("WebLog").Value!;
builder.Services.AddScoped<DbConnection>(_ => new NpgsqlConnection(connectionString));
builder.Services.AddScoped<IDbConnection>(sp => sp.GetRequiredService<DbConnection>());

builder.Services.AddHttpContextAccessor();
builder.Services.AddScoped<IClaimsService, ClaimsService>();
builder.Services.AddScoped<UserContext>();
// Registro de módulos de aplicación (cada feature expone su propia extensión AddXxx)
builder.Services.AddSeguridad();
builder.Services.AddMaestro();
builder.Services.AddLogin();
builder.Services.AddCatalogo();


// ===== Configuración =====
builder.Services.Configure<StorageOptions>(
    builder.Configuration.GetSection("Storage")
);

builder.Services.Configure<ImageStandardOptions>(
    builder.Configuration.GetSection("ImageStandard")
);


// Tamaño máximo del request (debe ser >= MaxFileSizeBytes)
builder.Services.Configure<FormOptions>(opts =>
{
    var storageOpts = builder.Configuration
        .GetSection("Storage")
        .Get<StorageOptions>();

    opts.MultipartBodyLengthLimit = storageOpts?.MaxFileSizeBytes ?? 10485760;
});

// ===== Servicios =====
builder.Services.AddScoped<IImageProcessor, ImageProcessor>();
builder.Services.AddScoped<IFileStorageService, LocalFileStorageService>();


#endregion


WebApplication app = builder.Build();

#region Middleware

app.UseResponseCompression();

// ✅ AGREGAR: Request Logging (DEBE IR ANTES de UseExceptionHandler)
app.UseMiddleware<RequestLoggingMiddleware>();

StorageOptions storageOpts = app.Services
    .GetRequiredService<IOptions<StorageOptions>>().Value;

if (Directory.Exists(storageOpts.FolderDocument))
{
    app.UseStaticFiles(new StaticFileOptions
    {
        FileProvider = new PhysicalFileProvider(storageOpts.FolderDocument),
        RequestPath = "/uploads",
        OnPrepareResponse = ctx =>
        {
            ctx.Context.Response.Headers.Append(
                "Cache-Control", "public,max-age=2592000");
        }
    });
}



if (app.Environment.IsDevelopment())
{
    app.UseHttpsRedirection();
    app.MapOpenApi();           // expone el JSON en /openapi/v1.json
    app.MapScalarApiReference(options =>
    {
        options.Title = "Sistema Mozo API";
    });
}



app.UseExceptionHandler();
app.UseStatusCodePages();



app.UseCors();

app.UseAuthentication();
app.UseAuthorization();

app.UseOutputCache();
#endregion


// Registro de endpoints por auto-descubrimiento: toda clase que implemente IEndpoint
// se mapea con su Prefix + auto-tag (ver Abstractions/EndpointExtensions.cs).
//   • Activar un endpoint  → que su clase implemente IEndpoint (Prefix + MapEndpoint).
//   • Desactivar un endpoint → quitarle la interfaz IEndpoint.
app.MapEndpoints();


await app.RunAsync();
