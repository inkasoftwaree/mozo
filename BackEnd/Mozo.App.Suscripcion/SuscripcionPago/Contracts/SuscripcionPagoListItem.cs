namespace Mozo.App.Suscripcion.SuscripcionPago.Contracts;

public sealed class SuscripcionPagoListItem
{
    public int CoSuscripcionPago { get; set; }
    public int? CoSuscripcion { get; set; }
    public DateTime? FePeriodoInicio { get; set; }
    public DateTime? FePeriodoFin { get; set; }
    public decimal? SsMonto { get; set; }
    public int? CoMoneda { get; set; }
    public DateTime? FePago { get; set; }
    public int? CoEstado { get; set; }
    public string? NoReferenciaPago { get; set; }
}
