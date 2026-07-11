using Mozo.Infrastructure.Persistence.Objects;

namespace Mozo.App.Maestro.TipoGeneral;

public static class TipoGeneralDbObjects
{
    private const string Schema = "maestro";
    private static readonly DbObjectFactory.StandardDbObjects _std = DbObjectFactory.Standard(Schema, "tipogeneral");

    public static DbObject SelById => _std.SelById;

    public static readonly DbObject SelAllActive =
        new(Schema, "fn_tipogeneral_sel_all_active", DbExecutionType.Select, DbReturnType.List);

    public static readonly DbObject SelAllActiveByModulo =
        new(Schema, "fn_tipogeneral_sel_all_active_by_modulo", DbExecutionType.Select, DbReturnType.List);


}