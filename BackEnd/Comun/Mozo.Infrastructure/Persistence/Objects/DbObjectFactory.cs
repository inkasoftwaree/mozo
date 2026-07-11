namespace Mozo.Infrastructure.Persistence.Objects;

public static class DbObjectFactory
{
    public sealed record StandardDbObjects(
    DbObject Insert,
    DbObject UpdateById,
    DbObject UpdateStateById,
    DbObject DeleteById,
    DbObject SelById,
    DbObject SelAll);
    public static StandardDbObjects Standard(string schema, string entity)
    {
        string s = schema.ToLowerInvariant();
        string e = entity.ToLowerInvariant();
        return new StandardDbObjects(
            Insert: new(s, $"fn_{e}_insert", DbExecutionType.Select, DbReturnType.Scalar),
            // Update/UpdateState/Delete son FUNCTIONs que devuelven boolean (true = afectó una fila),
            // no PROCEDUREs: así el llamador puede distinguir "editó/eliminó" de "no existía".
            UpdateById: new(s, $"fn_{e}_update_by_id", DbExecutionType.Select, DbReturnType.Scalar),
            UpdateStateById: new(s, $"fn_{e}_update_state_by_id", DbExecutionType.Select, DbReturnType.Scalar),
            DeleteById: new(s, $"fn_{e}_delete_by_id", DbExecutionType.Select, DbReturnType.Scalar),
            SelById: new(s, $"fn_{e}_sel_by_id", DbExecutionType.Select, DbReturnType.Single),
            SelAll: new(s, $"fn_{e}_sel_all", DbExecutionType.Select, DbReturnType.List)
        );
    }
}