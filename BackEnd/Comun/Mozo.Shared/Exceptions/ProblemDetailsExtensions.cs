using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Npgsql;
using System.Diagnostics;
namespace Mozo.Shared.Exceptions;

/// <summary>
/// Extensiones para ProblemDetails
/// </summary>
public static class ProblemDetailsExtensions
{
    public static IServiceCollection AddCustomProblemDetails(this IServiceCollection services)
    {
        services.AddProblemDetails(options =>
        {
            options.CustomizeProblemDetails = context =>
            {
                var httpContext = context.HttpContext;
                var exception = context.Exception;

                if (exception is null)
                    return;

                var problemDetails = context.ProblemDetails;

                var traceId =
                    Activity.Current?.Id ??
                    httpContext.TraceIdentifier;

                var loggerFactory =
                    httpContext.RequestServices.GetRequiredService<ILoggerFactory>();

                var logger =
                    loggerFactory.CreateLogger("Mozo.Api.ExceptionHandler");

                switch (exception)
                {
                    case PostgresException pgEx:
                        HandlePostgres(
                            pgEx,
                            httpContext,
                            problemDetails,
                            logger);
                        break;

                    case ApiException apiEx:
                        HandleApi(
                            apiEx,
                            httpContext,
                            problemDetails,
                            logger);
                        break;

                    case NpgsqlException npgsqlEx:
                        HandleNpgsql(
                            npgsqlEx,
                            httpContext,
                            problemDetails,
                            logger);
                        break;

                    case ArgumentNullException argEx:
                        HandleArgument(
                            argEx,
                            httpContext,
                            problemDetails,
                            logger);
                        break;

                    default:
                        HandleDefault(
                            exception,
                            httpContext,
                            problemDetails,
                            logger);
                        break;
                }

                problemDetails.Extensions["timestamp"] = DateTime.UtcNow;
                problemDetails.Extensions["traceId"] = traceId;

                IWebHostEnvironment environment =
                    httpContext.RequestServices.GetRequiredService<IWebHostEnvironment>();

                if (environment.IsDevelopment())
                {
                    problemDetails.Extensions["exception"] =
                        exception.GetType().Name;

                    problemDetails.Extensions["stackTrace"] =
                        exception.StackTrace;
                }
            };
        });

        return services;
    }

    private static void HandlePostgres(
    PostgresException ex,
    HttpContext httpContext,
    ProblemDetails problemDetails,
    ILogger logger)
    {
        var apiException = PostgreSqlExceptionMapper.Map(ex);

        SetProblemDetails(
            problemDetails,
            apiException);

        logger.Log(
            apiException.StatusCode >= 500
                ? LogLevel.Error
                : LogLevel.Warning,
            ex,
            "[POSTGRES] Usuario:{Usuario} Empresa:{Empresa} Metodo:{Metodo} Ruta:{Ruta} SqlState:{SqlState} Constraint:{Constraint} Tabla:{Tabla} Columna:{Columna}",
            GetUser(httpContext),
            GetEmpresa(httpContext),
            httpContext.Request.Method,
            httpContext.Request.Path,
            ex.SqlState,
            ex.ConstraintName,
            ex.TableName,
            ex.ColumnName);
    }

    private static void HandleApi(
        ApiException ex,
        HttpContext httpContext,
        ProblemDetails problemDetails,
        ILogger logger)
    {
        SetProblemDetails(
            problemDetails,
            ex);

        logger.Log(
            ex.StatusCode >= 500
                ? LogLevel.Error
                : LogLevel.Warning,
            ex,
            "[API] Usuario:{Usuario} Empresa:{Empresa} Metodo:{Metodo} Ruta:{Ruta} Codigo:{Codigo}",
            GetUser(httpContext),
            GetEmpresa(httpContext),
            httpContext.Request.Method,
            httpContext.Request.Path,
            ex.Code);
    }


    private static void HandleNpgsql(
    NpgsqlException ex,
    HttpContext httpContext,
    ProblemDetails problemDetails,
    ILogger logger)
    {
        var apiException = new InternalServerException(
            "No fue posible establecer comunicación con la base de datos.");

        SetProblemDetails(
            problemDetails,
            apiException);

        logger.LogError(
            ex,
            "[DATABASE] Usuario:{Usuario} Empresa:{Empresa} Metodo:{Metodo} Ruta:{Ruta}",
            GetUser(httpContext),
            GetEmpresa(httpContext),
            httpContext.Request.Method,
            httpContext.Request.Path);
    }

    private static void HandleArgument(
        ArgumentNullException ex,
        HttpContext httpContext,
        ProblemDetails problemDetails,
        ILogger logger)
    {
        var apiException = new ValidationException(
            ex.ParamName ?? "parameter",
            $"El parámetro '{ex.ParamName}' es obligatorio.");

        SetProblemDetails(
            problemDetails,
            apiException);

        problemDetails.Extensions["field"] = ex.ParamName;

        logger.LogWarning(
            ex,
            "[ARGUMENT] Usuario:{Usuario} Empresa:{Empresa} Metodo:{Metodo} Ruta:{Ruta} Parametro:{Parametro}",
            GetUser(httpContext),
            GetEmpresa(httpContext),
            httpContext.Request.Method,
            httpContext.Request.Path,
            ex.ParamName);
    }

    private static void HandleDefault(
        Exception ex,
        HttpContext httpContext,
        ProblemDetails problemDetails,
        ILogger logger)
    {
        var apiException = new InternalServerException(
            "Ocurrió un error inesperado.");

        SetProblemDetails(
            problemDetails,
            apiException);

        logger.LogError(
            ex,
            "[UNHANDLED] Usuario:{Usuario} Empresa:{Empresa} Metodo:{Metodo} Ruta:{Ruta}",
            GetUser(httpContext),
            GetEmpresa(httpContext),
            httpContext.Request.Method,
            httpContext.Request.Path);
    }


    private static void SetProblemDetails(
    ProblemDetails problemDetails,
    ApiException apiException)
    {
        problemDetails.Status = apiException.StatusCode;
        problemDetails.Title = GetTitle(apiException.StatusCode);
        problemDetails.Detail = apiException.Message;
        problemDetails.Extensions["code"] = apiException.Code;
    }

    private static string GetTitle(int statusCode)
    {
        return statusCode switch
        {
            StatusCodes.Status400BadRequest => "Solicitud inválida",

            StatusCodes.Status401Unauthorized => "No autorizado",

            StatusCodes.Status403Forbidden => "Acceso denegado",

            StatusCodes.Status404NotFound => "Recurso no encontrado",

            StatusCodes.Status409Conflict => "Conflicto",

            StatusCodes.Status422UnprocessableEntity => "Error de validación",

            StatusCodes.Status500InternalServerError => "Error interno del servidor",

            _ => "Error"
        };
    }


    private static string GetUser(HttpContext context)
    {
        return context.User?
            .FindFirst("NoUsuario")?
            .Value
            ?? "Anonymous";
    }

    private static string GetEmpresa(HttpContext context)
    {
        return context.User?
            .FindFirst("CoEmpresa")?
            .Value
            ?? "N/A";
    }
    private static string GetTraceId(HttpContext context)
    {
        return Activity.Current?.Id ??
               context.TraceIdentifier;
    }

    private static string GetIp(HttpContext context)
    {
        return context.Connection.RemoteIpAddress?.ToString()
               ?? "Unknown";
    }

}