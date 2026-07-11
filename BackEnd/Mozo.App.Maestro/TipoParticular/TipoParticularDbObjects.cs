using Mozo.Infrastructure.Persistence.Objects;

namespace Mozo.App.Maestro.TipoParticular;

public static class TipoParticularDbObjects
{
    private const string Schema = "maestro";
    private static readonly DbObjectFactory.StandardDbObjects _std = DbObjectFactory.Standard(Schema, "tipoparticular");

    public static DbObject Insert => _std.Insert;
    public static DbObject UpdateById => _std.UpdateById;
    public static DbObject UpdateStateById => _std.UpdateStateById;
    public static DbObject DeleteById => _std.DeleteById;
    public static DbObject SelById => _std.SelById;
    public static DbObject SelAll => _std.SelAll;


    public static readonly DbObject UpdateDefault =
        new(Schema, "fn_tipoparticular_update_default", DbExecutionType.Select, DbReturnType.Scalar);

    public static readonly DbObject SelAllChildren =
        new(Schema, "fn_tipoparticular_sel_all_hijo", DbExecutionType.Select, DbReturnType.List);

    public static readonly DbObject SelOrderNext =
        new(Schema, "fn_tipoparticular_sel_orden_next", DbExecutionType.Select, DbReturnType.Scalar);

    public static readonly DbObject SelByIdGroup =
        new(Schema, "fn_tipoparticular_sel_by_grupo", DbExecutionType.Select, DbReturnType.Single);

    public static readonly DbObject SelAllActive =
        new(Schema, "fn_tipoparticular_sel_all_active", DbExecutionType.Select, DbReturnType.List);

    public static readonly DbObject SelAllActiveChildren =
        new(Schema, "fn_tipoparticular_sel_all_active_hijo", DbExecutionType.Select, DbReturnType.List);

    public static readonly DbObject SelAllActiveFatherAndChildren =
        new(Schema, "fn_tipoparticular_sel_all_active_padre_e_hijo", DbExecutionType.Select, DbReturnType.List);

    public static readonly DbObject SelAllActiveGroupsByModulo =
        new(Schema, "fn_tipoparticular_sel_all_grupo_by_modulo", DbExecutionType.Select, DbReturnType.List);

    public static readonly DbObject SelDefault =
        new(Schema, "fn_tipoparticular_sel_default", DbExecutionType.Select, DbReturnType.Single);
}