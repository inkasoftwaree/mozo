using Mozo.Shared.Contract;

namespace Mozo.App.Suscripcion.PlanPrecio.Contracts;

public sealed class PlanPrecioListItem : BaseListItem
{
    public int CoPlanPrecio { get; set; }
    public int? CoPlan { get; set; }
    public int? CoMoneda { get; set; }
    public int? NuCicloMeses { get; set; }
    public decimal? SsPrecio { get; set; }
    public int? FlVigente { get; set; }
}
