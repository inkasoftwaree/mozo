using Mozo.Infrastructure.Persistence.Objects;

namespace Mozo.App.Suscripcion.SuscripcionMovimiento;

public static class SuscripcionMovimientoDbObjects
{
    private const string Schema = "suscripcion";

    public static readonly DbObject SelAllBySuscripcion =
        new(Schema, "fn_suscripcionmovimiento_sel_all_by_suscripcion", DbExecutionType.Select, DbReturnType.List);
}
