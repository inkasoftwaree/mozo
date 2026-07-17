namespace Mozo.App.Suscripcion.Suscripcion.Contracts;

/// <summary>
/// DTO plano para las suscripciones de una empresa (fn_suscripcion_sel_by_empresa),
/// usado para resolver a qué plan/módulos tiene acceso.
/// </summary>
public sealed class SuscripcionEmpresaItem
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
}
