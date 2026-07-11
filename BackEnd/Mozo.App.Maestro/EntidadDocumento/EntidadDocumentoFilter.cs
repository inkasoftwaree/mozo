using Mozo.Shared.Contract;
namespace Mozo.App.Maestro.EntidadDocumento;

public record EntidadDocumentoFilter : BaseFilter
{
    public int? CoEntidadDocumento { get; set; }
    public int? CoEntidad { get; set; }
}