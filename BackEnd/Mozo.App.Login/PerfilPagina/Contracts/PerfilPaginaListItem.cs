using Mozo.Shared.Contract;

namespace Mozo.App.Login.PerfilPagina.Contracts;

public partial class PerfilPaginaListItem : BaseListItem
{
    public int? CoModulo { get; set; }
    public int? CoMenu { get; set; }
    public int? CoPagina { get; set; }
    public int? NuOrden { get; set; }
    public string? NoMenu { get; set; }
    public int? CoTipoPagina { get; set; }
    public string? NoArea { get; set; }
    public string? NoControlador { get; set; }
    public string? NoAccion { get; set; }
    public string? NoOpcion { get; set; }

}
