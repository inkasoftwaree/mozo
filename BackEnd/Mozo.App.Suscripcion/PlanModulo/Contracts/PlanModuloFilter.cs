using Mozo.Shared.Contract;

namespace Mozo.App.Suscripcion.PlanModulo.Contracts;

public record PlanModuloFilter : BaseFilter
{
    public int? CoPlan { get; set; }
    public int? CoPlanModulo { get; set; }
}
