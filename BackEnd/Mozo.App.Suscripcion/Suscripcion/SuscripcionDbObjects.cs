using Mozo.Infrastructure.Persistence.Objects;

namespace Mozo.App.Suscripcion.Suscripcion;

public static class SuscripcionDbObjects
{
    private const string Schema = "suscripcion";

    public static readonly DbObject Insert =
        new(Schema, "fn_suscripcion_insert", DbExecutionType.Select, DbReturnType.Scalar);

    public static readonly DbObject SelById =
        new(Schema, "fn_suscripcion_sel_by_id", DbExecutionType.Select, DbReturnType.Single);

    public static readonly DbObject SelAll =
        new(Schema, "fn_suscripcion_sel_all", DbExecutionType.Select, DbReturnType.List);

    public static readonly DbObject SelByEmpresa =
        new(Schema, "fn_suscripcion_sel_by_empresa", DbExecutionType.Select, DbReturnType.List);

    public static readonly DbObject UpdateEstadoById =
        new(Schema, "fn_suscripcion_update_estado_by_id", DbExecutionType.Select, DbReturnType.Scalar);

    public static readonly DbObject Cancelar =
        new(Schema, "fn_suscripcion_cancelar", DbExecutionType.Select, DbReturnType.Scalar);

    public static readonly DbObject Renovar =
        new(Schema, "fn_suscripcion_renovar", DbExecutionType.Select, DbReturnType.Scalar);

    public static readonly DbObject ProcesarVencimientos =
        new(Schema, "fn_suscripcion_procesar_vencimientos", DbExecutionType.Select, DbReturnType.Scalar);
}
