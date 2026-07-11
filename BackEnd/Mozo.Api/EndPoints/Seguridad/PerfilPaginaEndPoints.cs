using Mozo.Api.Abstractions;
using Mozo.Api.Helper;
using Mozo.App.Seguridad.Menu;
using Mozo.App.Seguridad.Menu.Contracts;
using Mozo.App.Seguridad.Pagina;
using Mozo.App.Seguridad.Pagina.Contract;
using Mozo.App.Seguridad.PerfilPagina;
using Mozo.App.Seguridad.PerfilPagina.Contracts;
using Mozo.Domain.Seguridad;

namespace Mozo.Api.Seguridad;

///<summary>
/// Endpoints para gestión de PerfilPagina
///</summary>
///<history>
/// Create by Jonatan Abregu
///</history>
public sealed partial class PerfilPaginaEndPoints : IEndpoint
{
    public string Prefix => "/seguridad/perfil-pagina";

    /// <summary>
    /// Mapea todas las rutas de PerfilPagina
    /// </summary>
    public void MapEndpoint(RouteGroupBuilder g)
    {
        g.WithSecurity();

        g.MapPost("/", SaveAsync)
             .WithResponsesValue<int>(StatusCodes.Status200OK)
             .WithDescription("Insertar una PerfilPagina");

        g.MapGet("/", SelAllAsync)
            .WithResponses<IEnumerable<MenuEntity>>(StatusCodes.Status200OK)
            .WithDescription("Obtener todas los PerfilPagina");
    }

}

public partial class PerfilPaginaEndPoints
{

    private static async Task<IResult>
          SaveAsync(
              PerfilEntity m,
              IPerfilPaginaService IPerfilPagina
          )
    {
        await IPerfilPagina.DeleteByModuloAndPerfilAsync(new() { CoModulo = m.CoModulo, CoPerfil = m.CoPerfil });
        foreach (PerfilPaginaEntity item in m.PerfilPaginaLst ?? new())
        {
            item.CoModulo = m.CoModulo;
            item.CoPerfil = m.CoPerfil;
            await IPerfilPagina.InsertAsync(item);
        }
        return Results.Created($"/{m.CoPerfil}", m.CoPerfil);
    }

    static async Task<IResult>
        SelAllAsync(
            [AsParameters] PerfilPaginaFilter f,
            IMenuService IMenu,
            IPaginaService IPagina,
            IPerfilPaginaService IPerfilPagina
     )
    {

        List<MenuListItem> MenuLst = (await MenuSeguridad.SelAllArbolAsync(new() { CoModulo = f.CoModulo, FlEstReg = 1 }, IMenu, IPagina)) ?? new();


        List<PerfilPaginaListItem> PrivilegioPerfilLst = (await IPerfilPagina.SelAllAsync(new() { CoModulo = f.CoModulo, CoPerfil = f.CoPerfil })).ToList();

        PerfilPaginaListItem? tmp = null;

        foreach (MenuListItem Menu in MenuLst ?? new())
        {

            tmp = PrivilegioPerfilLst.FirstOrDefault(x => x.CoModulo == Menu.CoModulo && x.CoMenu == Menu.CoMenu);
            if (tmp != null)
                Menu.FlEstReg = 1;
            else
                Menu.FlEstReg = 0;


            foreach (PaginaListItem Pagina in Menu.PaginaLst ?? new())
            {
                tmp = PrivilegioPerfilLst.FirstOrDefault(x => x.CoModulo == Pagina.CoModulo && x.CoMenu == Pagina.CoMenu && x.CoPagina == Pagina.CoPagina);
                if (tmp != null)
                    Pagina.FlEstReg = 1;
                else
                    Pagina.FlEstReg = 0;
                /*
                foreach (PaginaFlotanteModel Flotante in Pagina.PaginaFlotanteLst ?? new())
                {
                    tmp = PrivilegioPerfilLst.FirstOrDefault(x => x.CoModulo == Flotante.CoModulo && x.CoMenu == Flotante.CoMenu && x.CoPagina == Flotante.CoPagina);
                    if (tmp != null)
                        Flotante.FlEstReg = 1;
                    else
                        Flotante.FlEstReg = 0;
                }
                */

                //foreach (ServicioWebModel WebService in Pagina.ServicioWebLst ?? new())
                //{
                //    tmp = PrivilegioPerfilLst.FirstOrDefault(x => x.CoModulo == WebService.CoModulo && x.CoMenu == WebService.CoMenu && x.CoPagina == WebService.CoPagina);
                //    if (tmp != null)
                //        WebService.CoEstReg = 1;
                //    else
                //        WebService.CoEstReg = 0;
                //}


                //foreach (SubPaginaModel SubPagina in Pagina.SubPaginaLst ?? new())
                //{
                //    tmp = PrivilegioPerfilLst.FirstOrDefault(x => x.CoModulo == SubPagina.CoModulo && x.CoMenu == SubPagina.CoMenu && x.CoPagina == SubPagina.CoPagina);
                //    if (tmp != null)
                //        SubPagina.FlEstReg = 1;
                //    else
                //        SubPagina.FlEstReg = 0;


                //foreach (PaginaFlotanteModel Flotante in SubPagina.PaginaFlotanteLst ?? new())
                //{
                //    tmp = PrivilegioPerfilLst.FirstOrDefault(x => x.CoModulo == Flotante.CoModulo && x.CoMenu == Flotante.CoMenu && x.CoPagina == Flotante.CoPagina);
                //    if (tmp != null)
                //    {
                //        Flotante.CoEstReg = 1;
                //        Flotante.CoEstReg2 = true;
                //    }
                //    else
                //    {
                //        Flotante.CoEstReg = 0;
                //        Flotante.CoEstReg2 = false;
                //    }
                //}

                //foreach (var WebService in SubPagina.ServicioWebLst.AsNotNull())
                //{
                //    tmp = PrivilegioPerfilLst.FirstOrDefault(x => x.CoModulo == WebService.CoModulo && x.CoMenu == WebService.CoMenu && x.CoPagina == WebService.CoPagina);
                //    if (tmp != null)
                //        WebService.CoEstReg = 1;
                //    else
                //        WebService.CoEstReg = 0;
                //}
                //}
            }
        }
        return Results.Ok(MenuLst);
    }

}