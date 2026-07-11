using Mozo.Infrastructure.Persistence.Objects;

namespace Mozo.App.Seguridad.Perfil;

public static class PerfilDbObjects
{
    private const string Schema = "seguridad";
    private static readonly DbObjectFactory.StandardDbObjects _std = DbObjectFactory.Standard(Schema, "perfil");

    public static DbObject Insert => _std.Insert;
    public static DbObject UpdateById => _std.UpdateById;
    public static DbObject UpdateStateById => _std.UpdateStateById;
    public static DbObject DeleteById => _std.DeleteById;
    public static DbObject SelById => _std.SelById;
    public static DbObject SelAll => _std.SelAll;

    public static readonly DbObject SelAllActive =
        new(Schema, "fn_perfil_sel_all_active", DbExecutionType.Select, DbReturnType.List);

    public static readonly DbObject SelDefault =
        new(Schema, "fn_perfil_sel_default", DbExecutionType.Select, DbReturnType.Single);
}
