using Mozo.Shared.Contract;

namespace Mozo.App.Seguridad.PerfilPagina;

public record PerfilPaginaFilter : BaseFilter
{
    public int? CoPerfil { get; set; }
    public int? CoModulo { get; set; }
    public int? CoPerfilPagina { get; set; }

}