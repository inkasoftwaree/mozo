namespace Mozo.Domain.Suscripcion;

[Serializable]
public partial class SuscripcionPagoEntity : BaseEntity
{
    public int? CoSuscripcionPago { get; set; }
    public int? CoSuscripcion { get; set; }
    public int? CoEmpresa { get; set; }
    public DateTime? FePeriodoInicio { get; set; }
    public DateTime? FePeriodoFin { get; set; }
    public decimal? SsMonto { get; set; }
    public int? CoMoneda { get; set; }
    public DateTime? FePago { get; set; }
    public int? CoEstado { get; set; }
    public string? NoReferenciaPago { get; set; }
    public string? TxNota { get; set; }
}
