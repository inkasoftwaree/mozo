using Mozo.Shared.Contract;
namespace Mozo.App.Maestro.DocumentoIdentidad;

public record DocumentoIdentidadFilter : BaseFilter
{
    public int? CoPais { get; set; }
    public int? CoAmbito { get; set; }
}