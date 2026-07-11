namespace Mozo.Domain.Maestro;


/// <summary>
/// Entidad que representa la tabla "trfpais".
/// </summary>
public partial class PaisEntity : BaseEntity
{
    public string? NoPais { get; set; }
    public string? NoCodigoIso2 { get; set; }
    public string? NoCodigoIso3 { get; set; }
    public string? NoPrefijoTelefono { get; set; }
    public int? CoPais { get; set; }
    public int? CoMoneda { get; set; }
}

public partial class PaisEntity
{
    public MonedaEntity? Moneda { get; set; }
}
