namespace Mozo.Domain.Suscripcion;

[Serializable]
public partial class SuscripcionEntity : BaseEntity
{
    public int? CoSuscripcion { get; set; }
    public int? CoEmpresa { get; set; }
    public int? CoPlan { get; set; }
    public int? CoPlanPrecio { get; set; }
    public int? CoEstado { get; set; }
    public DateTime? FeInicio { get; set; }
    public int? FlAutoRenovar { get; set; }
}
