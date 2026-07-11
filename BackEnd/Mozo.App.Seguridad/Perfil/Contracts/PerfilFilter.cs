using Mozo.Shared.Contract;

namespace Mozo.App.Seguridad.Perfil.Contracts;

public record PerfilFilter : BaseFilter
{
    public int? CoModulo { get; set; }
    public int? CoPerfil { get; set; }
}
