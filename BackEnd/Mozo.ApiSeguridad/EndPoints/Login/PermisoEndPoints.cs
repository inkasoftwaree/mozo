using Microsoft.AspNetCore.Mvc;
using Mozo.ApiSeguridad.Helper;
using Mozo.ApiSeguridad.HelperWeb.Exceptions;
using Mozo.HelperWeb.Token;
using Mozo.LoginBusiness;
using Mozo.Model.Seguridad;
using Mozo.Model.Seguridad.Auth;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
namespace Mozo.Api.Login;

///<summary>
/// Endpoints para gestión de Permiso
///</summary>
///<history>
/// Create by Jonatan Abregu
///</history>
public static partial class PermisoEndPoints
{
    /// <summary>
    /// Mapea todas las rutas de Permiso
    /// </summary>
    public static RouteGroupBuilder MapPermiso(this RouteGroupBuilder g)
    {
        g.WithSecurity();

        g.MapPost("/", LoginAsync)
            .AllowAnonymous()
            .WithResponses<GlobalCredencialModel>(StatusCodes.Status200OK)
            .Produces(StatusCodes.Status404NotFound)
            .WithDescription("Realiza el login del usuario");

        g.MapGet("/check", LoginCheck)
            .WithResponses<GlobalCredencialModel>(StatusCodes.Status200OK)
            .WithDescription("Verifica si el login es válido");


        g.MapPatch("/language", UpdateLanguageAsync)
            .WithResponses<GlobalCredencialModel>(StatusCodes.Status200OK)
            .WithDescription("Actualiza el idioma del app");


        return g;
    }
}
public static partial class PermisoEndPoints
{
    private static async Task<IResult>
        LoginAsync(
            [FromBody] PermisoFilterDto f,
            IJwtService jwtService,
            IPermisoBusiness IPermiso,
            IIngresoBusiness IIngreso,
            ILoggerFactory loggerFactory
        )
    {
        ILogger logger = loggerFactory.CreateLogger("Mozo.Api.Login");

        if (f == null)
            throw new ArgumentNullException(nameof(f));

        if (string.IsNullOrWhiteSpace(f.NoUsuario))
            throw new ValidationException("NoUsuario", "El usuario es requerido");

        if (string.IsNullOrWhiteSpace(f.NoClave))
            throw new ValidationException("NoClave", "La contraseña es requerida");




        PermisoModel? permiso = await IPermiso.SelByUserAsync(f);
        if (permiso == null)
        {
            logger.LogWarning(
               "[SECURITY] LOGIN_FAILED | Usuario: {Usuario} | IP: {IP}",
               f.NoUsuario, f.NoIp);

            throw new UnauthorizedException("Usuario o contraseña incorrectos");
        }

        string noTokenRefresh = jwtService.GenerateRefreshToken();

        IngresoModel ingreso = new()
        {
            CoEmpresa = permiso.CoEmpresa,
            CoPersona = permiso.CoPersona,
            CoPermiso = permiso.CoPermiso,
            NoRefreshToken = noTokenRefresh,
            NoUserAgent = jwtService.GetUserAgent(), //NoUserAgent = httpContext.Request.Headers.UserAgent.ToString()
            NoIp = jwtService.GetUserIp(),
            FeRefreshTokenExpire = jwtService.GetRefreshTokenExpiration()
        };
        ingreso.CoIngreso = await IIngreso.InsertAsync(ingreso);

        CredencialModel credential = new()
        {
            CoEmpresa = permiso.CoEmpresa,
            CoPersona = permiso.CoPersona,
            CoPermiso = permiso.CoPermiso,
            NoUsuario = permiso.NoUsuario,
            NoNombreCompleto = permiso.NoNombreCompleto,
            CoIngreso = ingreso.CoIngreso
        };

        string token = jwtService.GenerateToken(credential);

        GlobalCredencialModel globalCredencial = new()
        {
            Credencial = credential,
            NoToken = token,
            NoTokenRefresh = noTokenRefresh
        };

        logger.LogInformation(
         "[SECURITY] LOGIN_SUCCESS | Usuario: {Usuario} | Empresa: {CoEmpresa} | Ingreso: {CoIngreso} | IP: {IP} | Agent: {Agent}",
             permiso.NoUsuario,
             permiso.CoEmpresa,
             ingreso.CoIngreso,
             ingreso.NoIp,
             ingreso.NoUserAgent);

        return Results.Ok(globalCredencial);
    }


    private static async Task<IResult> LoginCheck(
        ClaimsPrincipal user, HttpContext httpContext
       )
    {


        if (user.Identity?.IsAuthenticated != true)
            throw new UnauthorizedException("No autorizado");

        string? coEmpresa = user.FindFirst("CoEmpresa")?.Value;
        string? coPersona = user.FindFirst("CoPersona")?.Value;
        string? coPermiso = user.FindFirst("CoPermiso")?.Value;
        string? coIngreso = user.FindFirst("CoIngreso")?.Value;
        string? noUsuario = user.FindFirst("NoUsuario")?.Value;
        string? noUsuario2 = user.FindFirst(JwtRegisteredClaimNames.Sub)?.Value;

        if (string.IsNullOrEmpty(coEmpresa) || string.IsNullOrEmpty(coPersona) ||
          string.IsNullOrEmpty(coPermiso))
            throw new UnauthorizedException("Claims inválidos");

        // string token = httpContext.Request.Headers["Authorization"].ToString().Replace("Bearer ", "");


        GlobalCredencialModel globalCredencial = new()
        {
            Credencial = new()
            {
                CoEmpresa = int.Parse(coEmpresa!),
                CoPersona = int.Parse(coPersona!),
                CoPermiso = int.Parse(coPermiso!),
                NoUsuario = noUsuario,
                CoIngreso = int.Parse(coIngreso!)
            }
        };

        return Results.Ok(globalCredencial);
    }



    static async Task<IResult>
        UpdateLanguageAsync(
        PermisoModel m,
        IPermisoBusiness IPermiso
        )
    {
        if (m is null)
            throw new ArgumentNullException(nameof(m));

        await IPermiso.UpdateLanguageAsync(m);
        return Results.Ok(m);
    }


}


