using Mozo.Infrastructure.Persistence.Objects;

namespace Mozo.App.Maestro.EntidadDocumento;

public static class EntidadDocumentoDbObjects
{
    private const string Schema = "maestro";
    private static readonly DbObjectFactory.StandardDbObjects _std = DbObjectFactory.Standard(Schema, "entidaddocumento");

    public static DbObject Insert => _std.Insert;
    public static DbObject UpdateById => _std.UpdateById;
    public static DbObject DeleteById => _std.DeleteById;
    public static DbObject SelById => _std.SelById;
    public static DbObject SelAll => _std.SelAll;

    public static readonly DbObject UpdateDefault =
        new(Schema, "fn_entidaddocumento_default", DbExecutionType.Select, DbReturnType.Scalar);

}