using Mozo.Shared.Contract;

namespace Mozo.App.Login.Pagina;

public record PaginaFilter : BaseFilter
{
    public int? CoModulo { get; set; }
    public int? CoUsuario { get; set; }
    public int? CoTipoPagina { get; set; }
}
