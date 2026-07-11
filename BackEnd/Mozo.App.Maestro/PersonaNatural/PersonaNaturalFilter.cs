using Mozo.Shared.Contract;

namespace Mozo.App.Maestro.PersonaNatural;

public record PersonaNaturalFilter : BaseFilter
{
    public int? CoEntidad { get; set; }
    public int? CoModulo { get; set; }
    public int? CoRolNegocio { get; set; }
    public int? NoImputSearch { get; set; }

}
