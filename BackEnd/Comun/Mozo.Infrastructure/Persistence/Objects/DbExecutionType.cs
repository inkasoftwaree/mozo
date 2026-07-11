namespace Mozo.Infrastructure.Persistence.Objects;

/// <summary>
/// Forma en que debe ejecutarse un objeto de PostgreSQL.
/// </summary>
public enum DbExecutionType
{
    /// <summary>
    /// CALL schema.procedure(...)
    /// </summary>
    Call,

    /// <summary>
    /// SELECT schema.function(...)
    /// </summary>
    Select
}