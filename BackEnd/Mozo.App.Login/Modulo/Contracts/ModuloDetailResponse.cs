namespace Mozo.App.Login.Modulo.Contracts;

/// <summary>
/// DTO plano para el detalle de un módulo en el login (SelById).
/// Alineado con login.fn_modulo_sel_by_id: comodulo, nomodulo, nomodulodescripcion, noarea, noicono, nuorden, flarea.
/// </summary>
public sealed class ModuloDetailResponse
{
    public int CoModulo { get; set; }
    public string? NoModulo { get; set; }
    public string? NoModuloDescripcion { get; set; }
    public string? NoArea { get; set; }
    public string? NoIcono { get; set; }
    public int? NuOrden { get; set; }
    public int? FlArea { get; set; }
}
