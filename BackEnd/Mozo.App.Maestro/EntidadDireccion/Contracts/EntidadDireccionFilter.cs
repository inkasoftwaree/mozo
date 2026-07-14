using Mozo.Shared.Contract;

namespace Mozo.App.Maestro.EntidadDireccion.Contracts;

public record EntidadDireccionFilter : BaseFilter
{
    public int? CoEntidadDireccion { get; set; }
    public int? CoEntidad { get; set; }
}
