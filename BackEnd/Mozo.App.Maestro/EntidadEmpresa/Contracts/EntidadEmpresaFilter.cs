using Mozo.Shared.Contract;

namespace Mozo.App.Maestro.EntidadEmpresa.Contracts;

public record EntidadEmpresaFilter : BaseFilter
{
    public int? CoEntidad { get; set; }
}
