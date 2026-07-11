namespace Mozo.Infrastructure.Persistence.Objects;

/// <summary>
/// Representa una función o procedimiento almacenado.
/// </summary>
public sealed record DbObject
{
    public string Schema { get; }
    public string Name { get; }
    public DbExecutionType Execution { get; }
    public DbReturnType ReturnType { get; }

    public DbObject(
        string schema,
        string name,
        DbExecutionType execution,
        DbReturnType returnType)
    {
        ArgumentException.ThrowIfNullOrWhiteSpace(name);

        Schema = schema;
        Name = name;
        Execution = execution;
        ReturnType = returnType;
    }

    public override string ToString() => Schema + "." + Name;

}