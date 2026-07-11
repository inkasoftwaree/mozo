using Mozo.Api.Abstractions;
using Mozo.App.Seguridad.Modulo;
using Mozo.App.Seguridad.Modulo.Contracts;
using Mozo.Domain.Seguridad;

namespace Mozo.Api.Seguridad;

///<summary>
/// Endpoints para gestión de Módulos
///</summary>
///<history>
/// Create by Jonatan Abregu
///</history>
public sealed partial class ModuloEndPoints : IEndpoint
{
    private const string CacheTag = "modulo";

    public string Prefix => "/seguridad/modulo";
    ///<summary>
    /// Mapea todas las rutas de Módulos
    ///</summary>
    ///<history>
    /// Create by Jonatan Abregu
    ///</history>
    public void MapEndpoint(RouteGroupBuilder g)
    {
        g.WithSecurity();

        g.MapPost("/", InsertAsync)
            .WithResponsesValue<int>(StatusCodes.Status201Created)
            .WithDescription("Nuevo Módulo");

        g.MapPut("/", UpdateByIdAsync)
            .WithResponsesValue<int>(StatusCodes.Status200OK)
            .Produces(StatusCodes.Status404NotFound)
            .WithDescription("Editar Módulo");

        g.MapPatch("/state", UpdateStateByIdAsync)
            .WithResponsesValue<int>(StatusCodes.Status200OK)
            .Produces(StatusCodes.Status404NotFound)
            .WithDescription("Activa o desactivar Módulo");

        g.MapDelete("/", DeleteByIdAsync)
            .WithResponses(StatusCodes.Status204NoContent)
            .Produces(StatusCodes.Status404NotFound)
            .WithDescription("Eliminar Módulo");

        g.MapGet("/", SelByIdAsync)
            .WithResponses<ModuloEditResponse>(StatusCodes.Status200OK)
            .Produces(StatusCodes.Status404NotFound)
            .WithDescription("Obtener un Módulo");

        g.MapGet("/all", SelAllAsync)
            .WithResponses<IEnumerable<ModuloListItem>>(StatusCodes.Status200OK)
            .WithDescription("Obtener todos los Módulo");

        g.MapGet("/active", SelAllActiveAsync)
            .WithResponses<IEnumerable<ModuloOption>>(StatusCodes.Status200OK)
            .WithDescription("Obtener todos los Módulo activos")
            .CacheOutput(CacheTag);

        //    g.MapGet("/active-for-empresa", SelAllActiveForEmpresaAsync)
        //.WithResponses<IEnumerable<ModuloEntity>>(StatusCodes.Status200OK)
        //.WithDescription("Obtener todos los Módulo activos para seleccionar en la empresa");

        //

    }

}



public partial class ModuloEndPoints
{
    private static async Task<IResult>
        InsertAsync(
            ModuloEntity m,
            IModuloService IModulo
       )
    {
        m.CoModulo = await IModulo.InsertAsync(m);
        return Results.Created($"/{m.CoModulo}", m.CoModulo);
    }

    private static async Task<IResult>
        UpdateByIdAsync(
            ModuloEntity m,
            IModuloService IModulo
        )
    {
        int filas = await IModulo.UpdateByIdAsync(m);
        return filas > 0 ? Results.Ok(filas) : Results.NotFound();
    }


    private static async Task<IResult>
        DeleteByIdAsync(
             [AsParameters] ModuloFilter f,
            IModuloService IModulo
        )
    {
        int filas = await IModulo.DeleteByIdAsync(f);
        return filas > 0 ? Results.NoContent() : Results.NotFound();
    }


    private static async
        Task<IResult>
        UpdateStateByIdAsync(
            ModuloEntity m,
            IModuloService IModulo
        )
    {
        int filas = await IModulo.UpdateStateByIdAsync(m);
        return filas > 0 ? Results.Ok(filas) : Results.NotFound();
    }


    private static async Task<IResult>
        SelByIdAsync(
            [AsParameters] ModuloFilter f,
            IModuloService IModulo
       )
    {
        ModuloEditResponse? i = await IModulo.SelByIdAsync(f);
        if (i == null)
            return Results.NotFound();
        return Results.Ok(i);
    }

    private static async Task<IResult>
        SelAllAsync(
            [AsParameters] ModuloFilter f,
            IModuloService IModulo
        )
    {

        var r = await IModulo.SelAllAsync(f);
        return Results.Ok(r);
    }


    private static async Task<IResult>
        SelAllActiveAsync(
            IModuloService IModulo
    )
    {
        var r = await IModulo.SelAllActiveAsync();
        return Results.Ok(r);
    }

    //    private static async Task<IResult>
    //    SelAllActiveForEmpresaAsync(
    //        IModuloService IModulo
    //)
    //    {
    //        var r = await IModulo.SelAllActiveForEmpresaAsync();
    //        return Results.Ok(r);
    //    }


}