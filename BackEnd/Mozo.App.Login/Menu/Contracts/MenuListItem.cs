
using Mozo.App.Login.Pagina.Contracts;
using Mozo.Shared.Contract;
namespace Mozo.App.Login.Menu.Contracts;


public partial class MenuListItem : BaseListItem
{
    public int? NuOrden { get; set; }
    public int? CoMenu { get; set; }
    public string? NoMenu { get; set; }
    public int? CoModulo { get; set; }

}

public partial class MenuListItem
{
    public List<PaginaListItem>? PaginaLst { get; set; }
}

