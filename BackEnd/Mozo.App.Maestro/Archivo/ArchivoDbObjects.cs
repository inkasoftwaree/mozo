using Mozo.Infrastructure.Persistence.Objects;

namespace Mozo.App.Maestro.Archivo;

public static class ArchivoDbObjects
{
    private const string Schema = "maestro";
    private static readonly DbObjectFactory.StandardDbObjects _std = DbObjectFactory.Standard(Schema, "archivo");

    public static DbObject Insert => _std.Insert;
    public static DbObject UpdateById => _std.UpdateById;
    public static DbObject DeleteById => _std.DeleteById;
    public static DbObject UpdateStateById => _std.UpdateStateById;
    public static DbObject SelById => _std.SelById;
    public static DbObject SelAll => _std.SelAll;

    public static readonly DbObject SelAllActive =
        new(Schema, "fn_archivo_sel_all_active", DbExecutionType.Select, DbReturnType.List);

    public static readonly DbObject UpdateMetaDataById =
         new(Schema, "fn_archivo_update_meta_data_by_id", DbExecutionType.Call, DbReturnType.Scalar);

    public static readonly DbObject UpdateOrderMassive =
         new(Schema, "fn_archivo_update_orden_masivo", DbExecutionType.Select, DbReturnType.Scalar);

    public static readonly DbObject UpdateOrder =
        new(Schema, "fn_archivo_update_orden", DbExecutionType.Select, DbReturnType.Scalar);

    public static readonly DbObject SelMetaDataById =
      new(Schema, "fn_archivo_sel_metadata_by_id", DbExecutionType.Select, DbReturnType.Single);

    public static readonly DbObject SelMetaDataByUk =
        new(Schema, "fn_archivo_sel_metadata_by_uk", DbExecutionType.Select, DbReturnType.Single);

}

