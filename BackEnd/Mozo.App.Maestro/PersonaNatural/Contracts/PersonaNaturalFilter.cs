using Mozo.Shared.Contract;

namespace Mozo.App.Maestro.PersonaNatural.Contracts;

public record PersonaNaturalFilter : BaseFilter
{
    public int? CoEntidad { get; set; }
    public int? CoModulo { get; set; }
    public int? CoRolNegocio { get; set; }
    public int? NoImputSearch { get; set; }
}
