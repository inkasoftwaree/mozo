using Mozo.Infrastructure.Persistence.Objects;

namespace Mozo.App.Maestro.EntidadRol;

public static class EntidadRolDbObjects
{
    private const string Schema = "maestro";
    private static readonly DbObjectFactory.StandardDbObjects _std = DbObjectFactory.Standard(Schema, "entidadrol");

    public static DbObject Insert => _std.Insert;
    public static DbObject UpdateById => _std.UpdateById;

    public static readonly DbObject SelAllActiveByPersona =
        new(Schema, "fn_entidadrol_sel_all_active_by_persona", DbExecutionType.Select, DbReturnType.List);

    public static readonly DbObject SelAllActiveByModuloPersona =
       new(Schema, "fn_entidadrol_sel_all_active_by_modulo_persona", DbExecutionType.Select, DbReturnType.List);

    public static readonly DbObject SelAllActive =
       new(Schema, "fn_entidadrol_sel_all_active", DbExecutionType.Select, DbReturnType.List);

}
