using Mozo.Shared.Contract;

namespace Mozo.App.Maestro.TipoParticular;

public record TipoParticularFilter : BaseFilter
{
    public int? CoModulo { get; set; }
    public int? CoGrupo { get; set; }
    public int? CoGrupoPadre { get; set; }
    public int? CoTipoParticularPadre { get; set; }
    public int? CoTipoParticular { get; set; }

}