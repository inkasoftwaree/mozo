using Mozo.Infrastructure.Persistence.Objects;

namespace Mozo.App.Suscripcion.SuscripcionPago;

public static class SuscripcionPagoDbObjects
{
    private const string Schema = "suscripcion";

    public static readonly DbObject Insert =
        new(Schema, "fn_suscripcionpago_insert", DbExecutionType.Select, DbReturnType.Scalar);

    public static readonly DbObject SelAllBySuscripcion =
        new(Schema, "fn_suscripcionpago_sel_all_by_suscripcion", DbExecutionType.Select, DbReturnType.List);

    public static readonly DbObject UpdateEstadoById =
        new(Schema, "fn_suscripcionpago_update_estado_by_id", DbExecutionType.Select, DbReturnType.Scalar);
}
