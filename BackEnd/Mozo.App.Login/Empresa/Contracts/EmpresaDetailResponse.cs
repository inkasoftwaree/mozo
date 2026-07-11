namespace Mozo.App.Login.Empresa.Contracts;

/// <summary>
/// DTO plano para el detalle de la Empresa en el login (SelById).
/// Alineado con login.fn_empresa_sel_by_id: novision, nomision, txquiensoy, coempresa, noentidad, coentidad.
/// Sin objetos anidados ni splitOn.
/// </summary>
public sealed class EmpresaDetailResponse
{
    public int CoEmpresa { get; set; }
    public int? CoEntidad { get; set; }
    public string? NoEntidad { get; set; }
    public string? NoVision { get; set; }
    public string? NoMision { get; set; }
    public string? TxQuienSoy { get; set; }
}
