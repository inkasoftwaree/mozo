using Mozo.Infrastructure.Persistence.Objects;

namespace Mozo.App.Seguridad.Empresa;

public static class EmpresaDbObjects
{
    private const string Schema = "seguridad";
    private static readonly DbObjectFactory.StandardDbObjects _std = DbObjectFactory.Standard(Schema, "empresa");
    public static DbObject Insert => _std.Insert;
    public static DbObject UpdateById => _std.UpdateById;
    public static DbObject UpdateStateById => _std.UpdateStateById;
    public static DbObject SelById => _std.SelById;
    public static DbObject SelAll => _std.SelAll;

    public static readonly DbObject SelAllActive =
        new(Schema, "fn_empresa_sel_all_active", DbExecutionType.Select, DbReturnType.List);

    public static readonly DbObject InsertAll =
        new(Schema, "fn_empresa_insert_all", DbExecutionType.Select, DbReturnType.Single);

    public static readonly DbObject UpdateAll =
      new(Schema, "fn_empresa_update_all_by_id", DbExecutionType.Select, DbReturnType.Scalar);

}
