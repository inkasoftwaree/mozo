using Mozo.Shared.Contract;

namespace Mozo.App.Seguridad.Pagina;

public record PaginaFilter : BaseFilter
{
    public int? CoModulo { get; set; }
    public int? CoTipoPagina { get; set; }
    public int? CoUsuario { get; set; }
    public int? CoPagina { get; set; }


}