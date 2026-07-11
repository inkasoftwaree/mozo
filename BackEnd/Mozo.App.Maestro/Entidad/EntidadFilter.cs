using Mozo.Shared.Contract;
namespace Mozo.App.Maestro.Entidad;

public record EntidadFilter : BaseFilter
{
    public int? CoEntidad { get; set; }
}