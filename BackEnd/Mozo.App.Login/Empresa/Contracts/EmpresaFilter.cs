using Mozo.Shared.Contract;

namespace Mozo.App.Login.Empresa.Contracts;

public record EmpresaFilter : BaseFilter
{
    public int? CoEmpresa { get; set; }
    public string? NoRazonSocial { get; set; }
    public string? NuDocumento { get; set; }
}
