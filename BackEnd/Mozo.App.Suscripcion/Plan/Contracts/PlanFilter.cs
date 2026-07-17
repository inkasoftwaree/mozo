using Mozo.Shared.Contract;

namespace Mozo.App.Suscripcion.Plan.Contracts;

public record PlanFilter : BaseFilter
{
    public int? CoPlan { get; set; }
}
