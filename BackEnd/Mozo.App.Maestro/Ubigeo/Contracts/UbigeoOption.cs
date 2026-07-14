namespace Mozo.App.Maestro.Ubigeo.Contracts;

/// <summary>
/// DTO plano para los combos de Ubigeo por nivel (SelAllNivel1/2/3) y el detalle (SelById).
/// Según el nivel consultado se llenan los campos correspondientes; el resto queda null.
/// </summary>
public sealed class UbigeoOption
{
    public int? CoUbigeo { get; set; }
    public int? CoPais { get; set; }
    public string? NoCodigo { get; set; }
    public string? CoNivel1 { get; set; }
    public string? CoNivel2 { get; set; }
    public string? CoNivel3 { get; set; }
    public string? NoNivel1 { get; set; }
    public string? NoNivel2 { get; set; }
    public string? NoNivel3 { get; set; }
}
