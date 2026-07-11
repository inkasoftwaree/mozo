using Mozo.App.Login.Menu.Contracts;
using Mozo.App.Login.ModuloUsuario;
using Mozo.App.Login.ModuloUsuario.Contracts;
using Mozo.App.Login.Pagina.Contracts;
using Mozo.App.Login.PerfilPagina;
using Mozo.App.Login.PerfilPagina.Contracts;
using Mozo.Domain.Seguridad;
using Mozo.Shared.Enu;

namespace Mozo.Api.Helper;


public static class MenuLogin
{

    //, IModuloUsuarioService _serviceModuloUsuario
    //  , IMenuService _serviceMenu
    //  , IPaginaService _servicePagina

    public static async Task<List<ModuloUsuarioListItem>> SelAllModuloAsync(
     MenuEntity c, IModuloUsuarioService IModuloUsuario, IPerfilPaginaService IPerfilPagina
    )
    {

        List<ModuloUsuarioListItem> moduloUsuarioLst = (await IModuloUsuario.SelAllByUsuarioAsync(new() { CoUsuario = c.CoUsuario })).ToList();
        moduloUsuarioLst = moduloUsuarioLst.OrderBy(x => x.NuOrden).ToList();

        List<PerfilPaginaListItem> perfilPaginaLst = new();

        foreach (ModuloUsuarioListItem moduloUsuario in moduloUsuarioLst)
        {
            perfilPaginaLst.AddRange((await IPerfilPagina.SelAllByModuloAndPerfilAsync(new()
            {
                CoModulo = moduloUsuario.CoModulo,
                CoPerfil = moduloUsuario.CoPerfil
            })).ToList());
        }
        perfilPaginaLst = perfilPaginaLst.OrderBy(x => x.NuOrden).ToList();

        foreach (ModuloUsuarioListItem moduloUsuario in moduloUsuarioLst)
        {

            List<PerfilPaginaListItem> menuTmpLst = perfilPaginaLst.Where(x => x.CoModulo == moduloUsuario.CoModulo & x.CoTipoPagina == EnuTipoGeneral.Seguridad.Pagina.Menu).ToList();

            if (menuTmpLst.Count() > 0)
            {
                moduloUsuario.MenuLst = new();
                foreach (PerfilPaginaListItem menu in menuTmpLst)
                {
                    moduloUsuario.MenuLst.Add(new() { CoMenu = menu.CoMenu, NoMenu = menu.NoMenu, NuOrden = menu.NuOrden });
                }

                foreach (MenuListItem menu in moduloUsuario.MenuLst)
                {
                    List<PerfilPaginaListItem> paginaTmpLst = perfilPaginaLst.Where(x => x.CoModulo == moduloUsuario.CoModulo & x.CoMenu == menu.CoMenu && x.CoTipoPagina == EnuTipoGeneral.Seguridad.Pagina.Paginaa).ToList();
                    if (paginaTmpLst.Count() > 0)
                    {
                        menu.PaginaLst = new();
                        foreach (PerfilPaginaListItem pagina in paginaTmpLst)
                        {
                            menu.PaginaLst.Add(new() { CoMenu = pagina.CoMenu, CoPagina = pagina.CoPagina, NuOrden = pagina.NuOrden, NoArea = pagina.NoArea, NoControlador = pagina.NoControlador, NoAccion = pagina.NoAccion, NoOpcion = pagina.NoOpcion });
                        }


                        /*
                        foreach (PaginaModel pagina in menu.PaginaLst)
                        {

                            List<PerfilPaginaEntity> subPaginaTmpLst = perfilPaginaLst.Where(x => x.CoModulo == moduloUsuario.CoModulo & x.CoMenu == menu.CoMenu && x.CoPaginaPadre == pagina.CoPagina && x.CoTipoPagina == EnuTipoGeneral.Seguridad.Pagina.SubPagina).ToList();

                            if (subPaginaTmpLst.Count() > 0)
                            {
                                pagina.SubPaginaLst = new();
                                foreach (PerfilPaginaEntity subPagina in subPaginaTmpLst)
                                {
                                    pagina.SubPaginaLst.Add(new() { CoMenu = subPagina.CoMenu, CoPagina = subPagina.CoPagina, CoPaginaPadre = subPagina.CoPaginaPadre, NuOrden = subPagina.NuOrden, NoArea = subPagina.NoArea, NoControlador = subPagina.NoControlador, NoAccion = subPagina.NoAccion, NoOpcion = subPagina.NoOpcion });
                                }
                            }


                            List<PerfilPaginaEntity> paginaFlotanteTmpLst = perfilPaginaLst.Where(x => x.CoModulo == moduloUsuario.CoModulo & x.CoMenu == menu.CoMenu && x.CoPaginaPadre == pagina.CoPagina && x.CoTipoPagina == EnuTipoGeneral.Seguridad.Pagina.VistaFlotante).ToList();

                            if (paginaFlotanteTmpLst.Count() > 0)
                            {
                                pagina.PaginaFlotanteLst = new();
                                foreach (PerfilPaginaEntity paginaFlotante in paginaFlotanteTmpLst)
                                {
                                    pagina.PaginaFlotanteLst.Add(new() { CoMenu = paginaFlotante.CoMenu, CoPagina = paginaFlotante.CoPagina, CoPaginaPadre = paginaFlotante.CoPaginaPadre, NoArea = paginaFlotante.NoArea, NoControlador = paginaFlotante.NoControlador, NoAccion = paginaFlotante.NoAccion });
                                }
                            }




                        }
                        */
                    }
                }
            }


        }






        foreach (ModuloUsuarioListItem moduloUsuario in moduloUsuarioLst)
        {
            moduloUsuario.CoModulo = null;
            moduloUsuario.CoPerfil = null;
            moduloUsuario.NuOrden = null;

            foreach (MenuListItem menu in moduloUsuario.MenuLst ?? new())
            {
                menu.CoMenu = null;
                menu.NuOrden = null;


                foreach (PaginaListItem pagina in menu.PaginaLst ?? new())
                {
                    pagina.CoMenu = null;
                    pagina.CoPagina = null;
                    pagina.NuOrden = null;

                }


            }



        }













        return moduloUsuarioLst;

    }



}