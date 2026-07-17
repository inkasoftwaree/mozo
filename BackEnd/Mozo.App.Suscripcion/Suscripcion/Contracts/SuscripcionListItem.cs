using Mozo.Shared.Contract;

namespace Mozo.App.Suscripcion.Suscripcion.Contracts;

public sealed class SuscripcionListItem : BaseListItem
{
    public int CoSuscripcion { get; set; }
    public int? CoEmpresa { get; set; }
    public int? CoPlan { get; set; }
    public string? NoPlan { get; set; }
    public DateTime? FeInicio { get; set; }
    public DateTime? FeFin { get; set; }
    public DateTime? FeRenovacion { get; set; }
    public int? CoEstado { get; set; }
    public decimal? SsPrecio { get; set; }
    public int? FlVigente { get; set; }
}
