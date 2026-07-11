using Mozo.Shared.Contract;

namespace Mozo.App.Maestro.TipoGeneral;

public record TipoGeneralFilter : BaseFilter
{
    public int? CoGrupo { get; set; }
    public int? CoModulo { get; set; }
    public int? CoTipoGeneral { get; set; }

}