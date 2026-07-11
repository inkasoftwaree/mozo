using Mozo.Shared.Contract;
namespace Mozo.App.Maestro.EntidadEmpresa;

public record EntidadEmpresaFilter : BaseFilter
{
    public int? CoEntidad { get; set; }
}