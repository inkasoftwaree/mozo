
using Microsoft.AspNetCore.Http;
using Npgsql;

namespace Mozo.Shared.Exceptions;

public static class PostgreSqlExceptionMapper
{
    public static ApiException Map(PostgresException ex)
    {
        return ex.SqlState switch
        {
            PostgresErrorCodes.UniqueViolation =>
                new ValidationException(
                     GetColumn(ex),
                    "Ya existe un registro con los mismos datos.",
                    ErrorCode.UniqueConstraint),

            PostgresErrorCodes.NotNullViolation =>
                new ValidationException(
                    GetColumn(ex),
                    $"El campo '{GetColumn(ex)}' es obligatorio",
                    ErrorCode.RequiredField),

            PostgresErrorCodes.CheckViolation =>
               new ValidationException(
                    GetColumn(ex),
                    $"El campo '{GetColumn(ex)}' no esta asignado",
                    ErrorCode.RestrictViolation),

            PostgresErrorCodes.ForeignKeyViolation =>
                new ValidationException(
                    GetColumn(ex),
                    "No existe el registro relacionado",
                    ErrorCode.ForeignKeyViolation
                    ),

            PostgresErrorCodes.RestrictViolation =>
                new ValidationException(
                     GetColumn(ex),
                    "El registro está siendo utilizado",
                    ErrorCode.RestrictViolation
                    ),

            _ =>
                new ApiException(
                    ErrorCode.DatabaseError,
                    ex.MessageText,
                    StatusCodes.Status500InternalServerError)
        };
    }

    private static string GetColumn(PostgresException ex)
    {
        if (!string.IsNullOrWhiteSpace(ex.ColumnName))
            return ex.ColumnName;

        return "desconocido";
    }
}