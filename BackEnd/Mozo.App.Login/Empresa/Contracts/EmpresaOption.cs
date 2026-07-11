namespace Mozo.App.Login.Empresa.Contracts;

/// <summary>
/// DTO plano para el selector de empresas del login (SelAll).
/// Alineado con login.fn_empresa_sel_all: coempresa, noentidad, coentidad. Sin splitOn.
/// </summary>
public sealed class EmpresaOption
{
    public int CoEmpresa { get; set; }
    public int? CoEntidad { get; set; }
    public string? NoEntidad { get; set; }
}
