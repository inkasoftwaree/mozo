namespace Mozo.App.Maestro.Pais.Contracts;

/// <summary>
/// DTO plano de la Moneda anidada dentro de <see cref="PaisOption"/> (join del SelAllActive).
/// </summary>
public sealed class MonedaOption
{
    public int? CoMoneda { get; set; }
    public string? NoCodigoIso { get; set; }
    public int? NuCodigoIso { get; set; }
    public string? NoMoneda { get; set; }
    public string? NoSimbolo { get; set; }
}
