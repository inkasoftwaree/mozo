using Mozo.Infrastructure.Persistence.Objects;

namespace Mozo.App.Suscripcion.Plan;

public static class PlanDbObjects
{
    private const string Schema = "suscripcion";
    private static readonly DbObjectFactory.StandardDbObjects _std = DbObjectFactory.Standard(Schema, "plan");

    public static DbObject Insert => _std.Insert;
    public static DbObject UpdateById => _std.UpdateById;
    public static DbObject UpdateStateById => _std.UpdateStateById;
    public static DbObject DeleteById => _std.DeleteById;
    public static DbObject SelById => _std.SelById;
    public static DbObject SelAll => _std.SelAll;

    public static readonly DbObject SelAllActive =
        new(Schema, "fn_plan_sel_all_active", DbExecutionType.Select, DbReturnType.List);
}
