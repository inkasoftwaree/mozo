namespace Mozo.App.Maestro.Pais.Contracts;

/// <summary>
/// DTO plano para el combo/dropdown de Países activos (SelAllActive).
/// Incluye la Moneda asociada (join) como objeto anidado.
/// </summary>
public sealed class PaisOption
{
    public int? CoPais { get; set; }
    public string? NoPais { get; set; }
    public string? NoCodigoIso2 { get; set; }
    public string? NoCodigoIso3 { get; set; }
    public string? NoPrefijoTelefono { get; set; }
    public int? CoMoneda { get; set; }
    public MonedaOption? Moneda { get; set; }
}
