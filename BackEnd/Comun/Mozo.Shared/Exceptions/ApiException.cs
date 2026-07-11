using Microsoft.AspNetCore.Http;

namespace Mozo.Shared.Exceptions;
/// <summary>
/// Códigos de error de la API.
/// </summary>
public enum ErrorCode
{
    Unknown = 0,
    ValidationError,
    RequiredField,
    InvalidValue,
    UniqueConstraint,
    ForeignKeyViolation,
    RestrictViolation,
    NotFound,
    Unauthorized,
    Forbidden,
    DatabaseError,
    InternalServerError,
    DocumentAlreadyExists
}
/// <summary>
/// Excepción base para la API
/// </summary>
/// <summary>
/// Excepción base para la API
/// </summary>
public class ApiException : Exception
{
    public ErrorCode Code { get; }
    public int StatusCode { get; }
    public string? Field { get; }

    public ApiException(
      ErrorCode code,
      string message,
      int statusCode,
      string? field = null)
      : base(message)
    {
        Code = code;
        StatusCode = statusCode;
        Field = field;
    }
}

public sealed class ValidationException : ApiException
{
    public ValidationException(
        string field,
        string message,
        ErrorCode code = ErrorCode.ValidationError)
        : base(
            code,
            message,
            StatusCodes.Status400BadRequest,
            field)
    {
    }

    public ValidationException(
     string message,
     ErrorCode code = ErrorCode.ValidationError)
     : base(
         code,
         message,
         StatusCodes.Status400BadRequest)
    {
    }
}
/// <summary>
/// Excepción de no autorizado
/// </summary>
public class UnauthorizedException : ApiException
{
    public UnauthorizedException(string message = "No autorizado")
        : base(ErrorCode.Unauthorized, message, 401)
    {
    }
}

/// <summary>
/// Excepción de acceso denegado
/// </summary>
public class ForbiddenException : ApiException
{
    public ForbiddenException(string message = "Acceso denegado")
        : base(ErrorCode.Forbidden, message, 403)
    {
    }
}

/// <summary>
/// Excepción de recurso no encontrado
/// </summary>
public class NotFoundException : ApiException
{
    public NotFoundException(string message = "Recurso no encontrado")
        : base(ErrorCode.NotFound, message, 404)
    {
    }
}

/// <summary>
/// Excepción de error interno
/// </summary>
public class InternalServerException : ApiException
{
    public InternalServerException(string message = "Error interno del servidor")
        : base(ErrorCode.InternalServerError, message, 500)
    {
    }
}

