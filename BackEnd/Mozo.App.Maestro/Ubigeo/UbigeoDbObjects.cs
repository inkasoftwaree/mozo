using Mozo.Infrastructure.Persistence.Objects;

namespace Mozo.App.Maestro.Ubigeo;

public static class UbigeoDbObjects
{
    private const string Schema = "maestro";
    private static readonly DbObjectFactory.StandardDbObjects _std = DbObjectFactory.Standard(Schema, "ubigeo");

    public static DbObject SelById => _std.SelById;

    public static readonly DbObject SelAllNivel1 =
        new(Schema, "fn_ubigeo_sel_all_nivel1", DbExecutionType.Select, DbReturnType.List);

    public static readonly DbObject SelAllNivel2 =
        new(Schema, "fn_ubigeo_sel_all_nivel2", DbExecutionType.Select, DbReturnType.List);

    public static readonly DbObject SelAllNivel3 =
        new(Schema, "fn_ubigeo_sel_all_nivel3", DbExecutionType.Select, DbReturnType.List);
}