namespace Mozo.Domain.Suscripcion;

[Serializable]
public partial class PlanModuloEntity : BaseEntity
{
    public int? CoPlanModulo { get; set; }
    public int? CoPlan { get; set; }
    public int? CoModulo { get; set; }
}
