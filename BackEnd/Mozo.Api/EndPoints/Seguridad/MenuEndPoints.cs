using Mozo.Api.Abstractions;
using Mozo.Api.Helper;
using Mozo.App.Seguridad.Menu;
using Mozo.App.Seguridad.Menu.Contracts;
using Mozo.App.Seguridad.Pagina;
using Mozo.Domain.Seguridad;

namespace Mozo.Api.Seguridad;
///<summary>
/// Endpoints para gestión de Menu
///</summary>
///<history>
/// Create by Jonatan Abregu
///</history>
public sealed partial class MenuEndPoints : IEndpoint
{
    public string Prefix => "/seguridad/menu";

    /// <summary>
    /// Mapea todas las rutas de Menu
    /// </summary>
    public void MapEndpoint(RouteGroupBuilder g)
    {
        g.WithSecurity();

        g.MapPost("/", InsertAsync)
            .WithResponsesValue<int>(StatusCodes.Status200OK)
            .WithDescription("Insertar un Menu");

        g.MapPut("/", UpdateByIdAsync)
             .WithResponsesValue<int>(StatusCodes.Status200OK)
             .Produces(StatusCodes.Status404NotFound)
             .WithDescription("Actualizar un Menu");

        g.MapDelete("/", DeleteByIdAsync)
             .WithResponsesValue<int>(StatusCodes.Status200OK)
             .Produces(StatusCodes.Status404NotFound)
             .WithDescription("Eliminar un Menu");

        g.MapPatch("/state", UpdateStateByIdAsync)
             .WithResponsesValue<int>(StatusCodes.Status200OK)
             .Produces(StatusCodes.Status404NotFound)
             .WithDescription("Activar o desactivar un Menu");

        g.MapGet("/", SelByIdAsync)
            .WithResponses<MenuEditResponse>(StatusCodes.Status200OK)
            .Produces(StatusCodes.Status404NotFound)
            .WithDescription("Obtener un Menu");

        g.MapGet("/arbol", SelAllArbolAsync)
            .WithResponses<List<MenuEntity>>(StatusCodes.Status200OK)
            .WithDescription("Obtener el Menu de Opciones");
    }

}
public partial class MenuEndPoints
{

    private static async Task<IResult>
         InsertAsync(
             MenuEntity m,
             IMenuService IMenu
        )
    {
        m.CoMenu = await IMenu.InsertAsync(m);
        return Results.Created($"/{m.CoMenu}", m.CoMenu);
    }

    private static async Task<IResult>
         UpdateByIdAsync(
             MenuEntity m,
             IMenuService IMenu
       )
    {
        int filas = await IMenu.UpdateByIdAsync(m);
        return filas > 0 ? Results.Ok(filas) : Results.NotFound();
    }

    private static async Task<IResult>
         DeleteByIdAsync(
             [AsParameters] MenuFilter f,
             IMenuService IMenu
      )
    {
        int filas = await IMenu.DeleteByIdAsync(f);
        return filas > 0 ? Results.Ok(filas) : Results.NotFound();
    }


    private static async Task<IResult>
         UpdateStateByIdAsync(
             MenuEntity m,
             IMenuService IMenu
        )
    {
        int filas = await IMenu.UpdateStateByIdAsync(m);
        return filas > 0 ? Results.Ok(filas) : Results.NotFound();
    }

    private static async Task<IResult>
         SelByIdAsync(
             [AsParameters] MenuFilter f,
             IMenuService IMenu
        )
    {
        MenuEditResponse? i = await IMenu.SelByIdAsync(f);
        if (i is null)
            return Results.NotFound();
        return Results.Ok(i);
    }


    private static async Task<IResult>
         SelAllArbolAsync(
             [AsParameters] MenuFilter f,
             IMenuService IMenu,
             IPaginaService IPagina
             )
    {

        return Results.Ok(await MenuSeguridad.SelAllArbolAsync(f, IMenu, IPagina));
    }

}