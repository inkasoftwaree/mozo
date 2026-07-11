using Mozo.Shared.Contract;

namespace Mozo.App.Maestro.EntidadDireccion;

public record EntidadDireccionFilter : BaseFilter
{
    public int? CoEntidadDireccion { get; set; }
    public int? CoEntidad { get; set; }
}