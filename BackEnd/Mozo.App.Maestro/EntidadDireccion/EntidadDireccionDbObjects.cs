using Mozo.Infrastructure.Persistence.Objects;
namespace Mozo.App.Maestro.EntidadDireccion;

public static class EntidadDireccionDbObjects
{
    private const string Schema = "maestro";
    public static readonly DbObjectFactory.StandardDbObjects _std = DbObjectFactory.Standard(Schema, "entidaddireccion");

    public static DbObject Insert => _std.Insert;
    public static DbObject UpdateById => _std.UpdateById;
    public static DbObject DeleteById => _std.DeleteById;
    public static DbObject SelById => _std.SelById;
    public static DbObject SelAll => _std.SelAll;
    public static DbObject UpdateStateById => _std.UpdateStateById;

    public static readonly DbObject UpdateDefault =
        new(Schema, "fn_entidaddireccion_default", DbExecutionType.Select, DbReturnType.Scalar);

    public static readonly DbObject SelAllActive =
       new(Schema, "fn_entidaddireccion_sel_all_active", DbExecutionType.Select, DbReturnType.List);
}
