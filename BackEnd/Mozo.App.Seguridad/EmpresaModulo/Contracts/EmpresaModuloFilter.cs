using Mozo.Shared.Contract;

namespace Mozo.App.Seguridad.EmpresaModulo.Contracts;

public record EmpresaModuloFilter : BaseFilter
{
    public int? CoEmpresa { get; set; }
    public int? CoEmpresaModulo { get; set; }
    public int? CoModulo { get; set; }
    public int? FlEmpresaNotKey { get; set; }

}