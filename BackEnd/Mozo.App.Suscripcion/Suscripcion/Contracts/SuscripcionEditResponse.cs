namespace Mozo.App.Suscripcion.Suscripcion.Contracts;

public sealed class SuscripcionEditResponse
{
    public int CoSuscripcion { get; set; }
    public int? CoEmpresa { get; set; }
    public int? CoPlan { get; set; }
    public string? NoPlan { get; set; }
    public int? CoPlanPrecio { get; set; }
    public DateTime? FeInicio { get; set; }
    public DateTime? FeFin { get; set; }
    public DateTime? FeRenovacion { get; set; }
    public int? CoEstado { get; set; }
    public int? NuCicloMeses { get; set; }
    public decimal? SsPrecio { get; set; }
    public int? CoMoneda { get; set; }
    public int? FlAutoRenovar { get; set; }
    public int? FlVigente { get; set; }
    public DateTime? FeCancelacion { get; set; }
}
