using Mozo.Infrastructure.Persistence.Objects;

namespace Mozo.App.Suscripcion.PlanModulo;

public static class PlanModuloDbObjects
{
    private const string Schema = "suscripcion";

    public static readonly DbObject Insert =
        new(Schema, "fn_planmodulo_insert", DbExecutionType.Select, DbReturnType.Scalar);

    public static readonly DbObject DeleteById =
        new(Schema, "fn_planmodulo_delete_by_id", DbExecutionType.Select, DbReturnType.Scalar);

    public static readonly DbObject SelAllByPlan =
        new(Schema, "fn_planmodulo_sel_all_by_plan", DbExecutionType.Select, DbReturnType.List);
}
