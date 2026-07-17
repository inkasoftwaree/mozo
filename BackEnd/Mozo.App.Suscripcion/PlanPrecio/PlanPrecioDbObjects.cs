using Mozo.Infrastructure.Persistence.Objects;

namespace Mozo.App.Suscripcion.PlanPrecio;

public static class PlanPrecioDbObjects
{
    private const string Schema = "suscripcion";

    public static readonly DbObject Insert =
        new(Schema, "fn_planprecio_insert", DbExecutionType.Select, DbReturnType.Scalar);

    public static readonly DbObject UpdateById =
        new(Schema, "fn_planprecio_update_by_id", DbExecutionType.Select, DbReturnType.Scalar);

    public static readonly DbObject DeleteById =
        new(Schema, "fn_planprecio_delete_by_id", DbExecutionType.Select, DbReturnType.Scalar);

    public static readonly DbObject SelAllByPlan =
        new(Schema, "fn_planprecio_sel_all_by_plan", DbExecutionType.Select, DbReturnType.List);
}
