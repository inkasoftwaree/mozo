using Mozo.Shared.Contract;

namespace Mozo.App.Login.PerfilPagina;

public record PerfilPaginaFilter : BaseFilter
{
    public int? CoModulo { get; set; }
    public int? CoPerfil { get; set; }
}
