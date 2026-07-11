namespace Mozo.App.Seguridad.Empresa.Contracts;

/// <summary>
/// DTO plano para el combo/dropdown de Empresas activas (SelAllActive).
/// Solo id + nombre para mostrar. Sin objetos anidados ni splitOn.
/// </summary>
public sealed class EmpresaOption
{
    public int CoEmpresa { get; set; }
    public string? NoRazonSocial { get; set; }
}
