using Mozo.Shared.Contract;

namespace Mozo.App.Maestro.PersonaJuridica.Contracts;

public record PersonaJuridicaFilter : BaseFilter
{
    public int? CoEntidad { get; set; }
    public int? CoModulo { get; set; }
    public int? CoRolNegocio { get; set; }
}
