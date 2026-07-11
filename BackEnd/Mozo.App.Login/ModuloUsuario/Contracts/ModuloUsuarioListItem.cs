using Mozo.App.Login.Menu.Contracts;

namespace Mozo.App.Login.ModuloUsuario.Contracts;

public partial class ModuloUsuarioListItem
{
    public int? CoModulo { get; set; }
    public int? NuOrden { get; set; }
    public int? CoPerfil { get; set; }
    public string? NoModulo { get; set; }
    public string? NoIcono { get; set; }
}
public partial class ModuloUsuarioListItem
{
    public List<MenuListItem>? MenuLst { get; set; }
}


