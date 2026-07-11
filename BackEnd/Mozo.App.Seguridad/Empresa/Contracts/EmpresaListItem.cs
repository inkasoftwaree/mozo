using Mozo.Shared.Contract;
namespace Mozo.App.Seguridad.Empresa.Contracts;

public sealed class EmpresaListItem : BaseListItem
{
    public int CoEmpresa { get; set; }
    public string? NoRazonSocial { get; set; }
    public string? NoComercial { get; set; }
}
