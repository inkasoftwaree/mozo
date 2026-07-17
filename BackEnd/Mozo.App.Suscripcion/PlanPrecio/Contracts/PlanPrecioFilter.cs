using Mozo.Shared.Contract;

namespace Mozo.App.Suscripcion.PlanPrecio.Contracts;

public record PlanPrecioFilter : BaseFilter
{
    public int? CoPlan { get; set; }
    public int? CoPlanPrecio { get; set; }
}
