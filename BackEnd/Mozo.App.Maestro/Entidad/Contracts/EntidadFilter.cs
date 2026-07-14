using Mozo.Shared.Contract;

namespace Mozo.App.Maestro.Entidad.Contracts;

public record EntidadFilter : BaseFilter
{
    public int? CoEntidad { get; set; }
}
