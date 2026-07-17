namespace Mozo.Domain.Suscripcion;

[Serializable]
public partial class PlanPrecioEntity : BaseEntity
{
    public int? CoPlanPrecio { get; set; }
    public int? CoPlan { get; set; }
    public int? CoMoneda { get; set; }
    public int? NuCicloMeses { get; set; }
    public decimal? SsPrecio { get; set; }
    public int? FlVigente { get; set; }
}
