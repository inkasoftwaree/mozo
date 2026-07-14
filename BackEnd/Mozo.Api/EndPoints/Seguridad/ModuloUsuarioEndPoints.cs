using Mozo.Api.Abstractions;
using Mozo.App.Seguridad.ModuloUsuario;
using Mozo.App.Seguridad.ModuloUsuario.Contract;
using Mozo.Domain.Seguridad;

namespace Mozo.Api.Seguridad;

///<summary>
/// Endpoints para gestión de ModuloUsuario
///</summary>
///<history>
/// Create by Jonatan Abregu
///</history>
public sealed partial class ModuloUsuarioEndPoints : IEndpoint
{
    public string Prefix => "/seguridad/modulo-usuario";

    ///<summary>
    /// Mapea todas las rutas de ModuloUsuario
    ///</summary>
    ///<history>
    /// Create by Jonatan Abregu
    ///</history>
    public void MapEndpoint(RouteGroupBuilder g)
    {
        g.WithSecurity();

        g.MapPost("/", InsertAsync)
             .WithResponsesValue<int>(StatusCodes.Status201Created)
             .WithDescription("Insertar un ModuloUsuario");

        g.MapPut("/", UpdateByIdAsync)
             .WithResponsesValue<int>(StatusCodes.Status200OK)
             .Produces(StatusCodes.Status404NotFound)
             .WithDescription("Actualizar un ModuloUsuario");

        g.MapPatch("/configuracion", UpdateConfiguracionAsync)
             .WithResponsesValue<int>(StatusCodes.Status200OK)
             .Produces(StatusCodes.Status404NotFound)
             .WithDescription("Actualizar configuración de ModuloUsuario");

        g.MapDelete("/", DeleteByIdAsync)
            .WithResponsesValue<int>(StatusCodes.Status200OK)
            .Produces(StatusCodes.Status404NotFound)
            .WithDescription("Eliminar una ModuloUsuario");

        g.MapGet("/", SelByIdAsync)
             .WithResponses<ModuloUsuarioEntity>(StatusCodes.Status200OK)
            .Produces(StatusCodes.Status404NotFound)
            .WithDescription("Obtener un ModuloUsuario");

        g.MapGet("/all", SelAllAsync)
             .WithResponses<IEnumerable<ModuloUsuarioEntity>>(StatusCodes.Status200OK)
            .WithDescription("Obtener los todos los ModuloUsuario ");


    }

}


public partial class ModuloUsuarioEndPoints
{
    private static async Task<IResult>
        InsertAsync(
            ModuloUsuarioEntity m,
            IModuloUsuarioService IModuloUsuario
        )
    {

        m.CoModuloUsuario = await IModuloUsuario.InsertAsync(m);
        return Results.Created($"/{m.CoModuloUsuario}", m.CoModuloUsuario);
    }

    private static async Task<IResult>
        UpdateByIdAsync(
            ModuloUsuarioEntity m,
            IModuloUsuarioService IModuloUsuario
       )
    {
        int filas = await IModuloUsuario.UpdateByIdAsync(m);
        return filas > 0 ? Results.Ok(filas) : Results.NotFound();
    }

    private static async Task<IResult>
        UpdateConfiguracionAsync(
            ModuloUsuarioEntity m,
            IModuloUsuarioService IModuloUsuario
       )
    {
        int filas = await IModuloUsuario.UpdateConfiguracionAsync(m);
        return filas > 0 ? Results.Ok(filas) : Results.NotFound();
    }

    private static async Task<IResult>
        DeleteByIdAsync(
            [AsParameters] ModuloUsuarioFilter f,
            IModuloUsuarioService IModuloUsuario
       )
    {
        int filas = await IModuloUsuario.DeleteByIdAsync(f);
        return filas > 0 ? Results.Ok(filas) : Results.NotFound();
    }
    private static async Task<IResult>
        SelByIdAsync(
            [AsParameters] ModuloUsuarioFilter f,
            IModuloUsuarioService IModuloUsuario
        )
    {
        ModuloUsuarioEditResponse? i = await IModuloUsuario.SelByIdAsync(f);
        if (i == null)
            return Results.NotFound();
        return Results.Ok(i);
    }

    private static async Task<IResult>
        SelAllAsync(
            [AsParameters] ModuloUsuarioFilter f,
            IModuloUsuarioService IModuloUsuario
        ) => Results.Ok(await IModuloUsuario.SelAllAsync(f));


}