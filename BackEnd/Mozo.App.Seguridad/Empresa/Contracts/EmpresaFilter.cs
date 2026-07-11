using Mozo.Shared.Contract;

namespace Mozo.App.Seguridad.Empresa.Contracts;

public record EmpresaFilter : BaseFilter //EmpresaFilter>
{
    public string? NoRazonSocial { get; set; }
    public string? NuDocumento { get; set; }
    public int? CoEmpresa { get; set; }
    public int? CoEntidad { get; set; }

}