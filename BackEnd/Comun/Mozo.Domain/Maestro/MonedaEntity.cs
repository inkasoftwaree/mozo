namespace Mozo.Domain.Maestro;

/// <summary>
/// Entidad que representa la tabla "trfmoneda".
/// </summary>
public class MonedaEntity : BaseEntity
{
    public int? CoMoneda { get; set; }
    public string? NoCodigoIso { get; set; }
    public int? NuCodigoIso { get; set; }
    public string? NoMoneda { get; set; }
    public string? NoSimbolo { get; set; }
}
