using Mozo.Api.Abstractions;
using Mozo.App.Seguridad.Perfil;
using Mozo.App.Seguridad.Perfil.Contracts;
using Mozo.Domain.Seguridad;

namespace Mozo.Api.Seguridad;

///<summary>
/// Endpoints para gestión de Perfil
///</summary>
///<history>
/// Create by Jonatan Abregu
///</history>
public sealed partial class PerfilEndPoints : IEndpoint
{
    public string Prefix => "/seguridad/perfil";

    /// <summary>
    /// Mapea todas las rutas de Perfil
    /// </summary>
    public void MapEndpoint(RouteGroupBuilder g)
    {
        g.WithSecurity();

        g.MapPost("/", InsertAsync)
             .WithResponsesValue<int>(StatusCodes.Status201Created)
             .WithDescription("Insertar un Perfil");

        g.MapPut("/", UpdateByIdAsync)
             .WithResponsesValue<int>(StatusCodes.Status200OK)
             .Produces(StatusCodes.Status404NotFound)
             .WithDescription("Actualizar un Perfil");

        g.MapDelete("/", DeleteByIdAsync)
             .WithResponsesValue<int>(StatusCodes.Status200OK)
             .Produces(StatusCodes.Status404NotFound)
             .WithDescription("Eliminar una Perfil");

        g.MapPatch("/state", UpdateStateByIdAsync)
              .WithResponsesValue<int>(StatusCodes.Status200OK)
              .Produces(StatusCodes.Status404NotFound)
             .WithDescription("Activar o desactivar un Perfil");

        g.MapGet("/default", SelDefaultAsync)
             .WithResponses<PerfilEditResponse>(StatusCodes.Status200OK)
            .Produces(StatusCodes.Status404NotFound)
            .WithDescription("Obtener un Perfil por defecto");

        g.MapGet("/", SelByIdAsync)
            .WithResponses<PerfilEditResponse>(StatusCodes.Status200OK)
            .Produces(StatusCodes.Status404NotFound)
            .WithDescription("Obtener un Perfil");

        g.MapGet("/all", SelAllAsync)
            .WithResponses<IEnumerable<PerfilListItem>>(StatusCodes.Status200OK)
            .WithDescription("Obtener todas los Perfiles");


        g.MapGet("/active", SelAllActiveAsync)
            .WithResponses<IEnumerable<PerfilOption>>(StatusCodes.Status200OK)
            .WithDescription("Obtener todas los Perfiles activos");
    }

}
public partial class PerfilEndPoints
{
    private static async Task<IResult>
         InsertAsync(
            PerfilEntity m,
            IPerfilService IPerfil
        )
    {
        m.CoPerfil = await IPerfil.InsertAsync(m);
        return Results.Created($"/{m.CoPerfil}", m.CoPerfil);
    }
    private static async Task<IResult>
         UpdateByIdAsync(
             PerfilEntity m,
             IPerfilService IPerfil
        )
    {
        int filas = await IPerfil.UpdateByIdAsync(m);
        return filas > 0 ? Results.Ok(filas) : Results.NotFound();
    }
    private static async Task<IResult>
         DeleteByIdAsync(
          [AsParameters] PerfilFilter f,
             IPerfilService IPerfil
        )
    {
        int filas = await IPerfil.DeleteByIdAsync(f);
        return filas > 0 ? Results.Ok(filas) : Results.NotFound();
    }


    private static async Task<IResult>
             UpdateStateByIdAsync(
                 PerfilEntity m,
                 IPerfilService IPerfil
        )
    {
        int filas = await IPerfil.UpdateStateByIdAsync(m);
        return filas > 0 ? Results.Ok(filas) : Results.NotFound();
    }

    private static async Task<IResult>
         SelAllAsync(
             [AsParameters] PerfilFilter f,
             IPerfilService IPerfil
        )
    {

        var r = await IPerfil.SelAllAsync(f);
        return Results.Ok(r);
    }
    private static async Task<IResult>
         SelByIdAsync(
             [AsParameters] PerfilFilter f,
             IPerfilService IPerfil
        )
    {
        PerfilEditResponse? i = await IPerfil.SelByIdAsync(f);
        if (i is null)
            return Results.NotFound();
        return Results.Ok(i);
    }

    private static async Task<IResult>
             SelAllActiveAsync(
                 [AsParameters] PerfilFilter f,
                 IPerfilService IPerfil
       )
    {

        var r = await IPerfil.SelAllActiveAsync(f);
        return Results.Ok(r);
    }

    private static async Task<IResult>
         SelDefaultAsync(
             [AsParameters] PerfilFilter f,
             IPerfilService IPerfil
        )
    {

        PerfilEditResponse? i = await IPerfil.SelDefaultAsync(f);
        if (i is null)
            return Results.NotFound();
        return Results.Ok(i);
    }


}