using Mozo.App.Seguridad.Menu;
using Mozo.App.Seguridad.Menu.Contracts;
using Mozo.App.Seguridad.Pagina;
using Mozo.App.Seguridad.Pagina.Contract;


namespace Mozo.Api.Helper;

public static class MenuSeguridad
{
    public static async Task<List<MenuListItem>> SelAllArbolAsync(
        MenuFilter c, IMenuService IMenu, IPaginaService IPagina
    )
    {
        List<MenuListItem> MenuLst = new();
        List<PaginaListItem> PaginaLst = new();
        //List<SubPaginaEntity>? SubPaginaLst;
        //List<PaginaFlotanteModel>? PaginaFlotanteLst;
        if (c.FlEstReg == 1)
        {
            MenuLst = (await IMenu.SelAllActiveAsync(c)).ToList();
            PaginaLst = (await IPagina.SelAllAsync(new() { CoModulo = c.CoModulo, FlEstReg = c.FlEstReg })).ToList();
            //SubPaginaLst = (await IPagina.SelAllActiveSubPaginaAsync(new() { CoModulo = c.CoModulo })).ToList();
            //PaginaFlotanteLst = (await IPagina.SelAllActivePaginaFlotanteAsync(new() { CoModulo = c.CoModulo })).ToList();
        }
        else
        {
            MenuLst = (await IMenu.SelAllAsync(c)).ToList();
            PaginaLst = (await IPagina.SelAllAsync(new() { CoModulo = c.CoModulo, FlEstReg = c.FlEstReg })).ToList();
            //SubPaginaLst = (await IPagina.SelAllSubPaginaAsync(new() { CoModulo = c.CoModulo })).ToList();
            //PaginaFlotanteLst = (await IPagina.SelAllPaginaFlotanteAsync(new() { CoModulo = c.CoModulo })).ToList();
        }

        MenuLst = MenuLst.OrderBy(x => x.NuOrden).ToList();
        PaginaLst = PaginaLst.OrderBy(x => x.NuOrden).ThenBy(b => b.NoControlador).ThenBy(c => c.NoAccion).ToList();
        //SubPaginaLst = SubPaginaLst.OrderBy(x => x.NuOrden).ThenBy(b => b.NoControlador).ThenBy(c => c.NoAccion).ToList();
        foreach (MenuListItem Menu in MenuLst ?? [])
        {
            Menu.PaginaLst = PaginaLst.Where(x => x.CoMenu == Menu.CoMenu && x.CoTipoPagina == 1).ToList();
            /*
            foreach (PaginaEntity Pagina in Menu.PaginaLst ?? new())
            {
                Pagina.SubPaginaLst = SubPaginaLst.FindAll(x => x.CoMenu == Pagina.CoMenu && x.CoPaginaPadre == Pagina.CoPagina);

                Pagina.PaginaFlotanteLst = PaginaFlotanteLst.FindAll(x => x.CoMenu == Pagina.CoMenu && x.CoPaginaPadre == Pagina.CoPagina);


            }
            */
        }

        return MenuLst;

    }
}