using Mozo.Api.Abstractions;
using Mozo.App.Seguridad.Pagina;
using Mozo.App.Seguridad.Pagina.Contract;
using Mozo.Domain.Seguridad;

namespace Mozo.Api.Seguridad;

///<summary>
/// Endpoints para gestión de Pagina
///</summary>
///<history>
/// Create by Jonatan Abregu
///</history>
public sealed partial class PaginaEndPoints : IEndpoint
{
    public string Prefix => "/seguridad/pagina";

    ///<summary>
    /// Mapea todas las rutas de Pagina
    ///</summary>
    ///<history>
    /// Create by Jonatan Abregu
    ///</history>
    public void MapEndpoint(RouteGroupBuilder g)
    {
        g.WithSecurity();

        g.MapPost("/", InsertAsync)
             .WithResponsesValue<int>(StatusCodes.Status201Created)
             .WithDescription("Insertar una Pagina");

        g.MapPut("/", UpdateByIdAsync)
            .WithResponsesValue<int>(StatusCodes.Status200OK)
            .Produces(StatusCodes.Status404NotFound)
            .WithDescription("Actualizar una Pagina");

        g.MapDelete("/", DeleteByIdAsync)
            .WithResponsesValue<int>(StatusCodes.Status200OK)
            .Produces(StatusCodes.Status404NotFound)
             .WithDescription("Eliminar una Pagina");

        g.MapPatch("/state", UpdateStateByIdAsync)
            .WithResponsesValue<int>(StatusCodes.Status200OK)
            .Produces(StatusCodes.Status404NotFound)
             .WithDescription("Activar o desactivar una Pagina");

        g.MapGet("/", SetByIdAsync)
             .WithResponses<PaginaEntity>(StatusCodes.Status200OK)
            .Produces(StatusCodes.Status404NotFound)
            .WithDescription("Obtener una Pagina");
    }

}
public partial class PaginaEndPoints
{
    private static async Task<IResult>
         InsertAsync(
             PaginaEntity m,
             IPaginaService IPagina
        )
    {

        m.CoPagina = await IPagina.InsertAsync(m);
        return Results.Created($"/{m.CoPagina}", m.CoPagina);
    }
    private static async Task<IResult>
         UpdateByIdAsync(
             PaginaEntity m,
             IPaginaService IPagina
      )
    {
        int filas = await IPagina.UpdateByIdAsync(m);
        return filas > 0 ? Results.Ok(filas) : Results.NotFound();
    }

    private static async Task<IResult>
         DeleteByIdAsync(
             [AsParameters] PaginaFilter f,
             IPaginaService IPagina
         )
    {
        int filas = await IPagina.DeleteByIdAsync(f);
        return filas > 0 ? Results.Ok(filas) : Results.NotFound();
    }


    private static async Task<IResult>
         UpdateStateByIdAsync(
             PaginaEntity m,
             IPaginaService IPagina
         )
    {
        int filas = await IPagina.UpdateStateByIdAsync(m);
        return filas > 0 ? Results.Ok(filas) : Results.NotFound();
    }

    private static async Task<IResult>
         SetByIdAsync(
              [AsParameters] PaginaFilter f,
             IPaginaService IPagina
          )
    {
        PaginaEditResponse? i = await IPagina.SelByIdAsync(f);
        if (i is null)
            return Results.NotFound();
        return Results.Ok(i);
    }


}