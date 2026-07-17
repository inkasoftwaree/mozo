namespace Mozo.App.Suscripcion.SuscripcionMovimiento.Contracts;

public sealed class SuscripcionMovimientoListItem
{
    public int CoSuscripcionMovimiento { get; set; }
    public int? CoTipoMovimiento { get; set; }
    public string? NoTipoMovimiento { get; set; }
    public int? CoEstadoAnterior { get; set; }
    public string? NoEstadoAnterior { get; set; }
    public int? CoEstadoNuevo { get; set; }
    public string? NoEstadoNuevo { get; set; }
    public DateTime? FeFinAnterior { get; set; }
    public DateTime? FeFinActual { get; set; }
    public DateTime? FeMovimiento { get; set; }
    public string? TxNota { get; set; }
}
