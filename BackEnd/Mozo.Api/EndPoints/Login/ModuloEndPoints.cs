using Mozo.Api.Abstractions;
using Mozo.App.Login.Modulo;
using Mozo.App.Login.Modulo.Contracts;

namespace Mozo.Api.Login;

///<summary>
/// Endpoints para gestión de Modulo
///</summary>
///<history>
/// Create by Jonatan Abregu
///</history>
public sealed partial class ModuloEndPoints : IEndpoint
{
    public string Prefix => "/login/modulo";

    /// <summary>
    /// Mapea todas las rutas de Modulo
    /// </summary>
    public void MapEndpoint(RouteGroupBuilder g)
    {
        g.WithSecurity();

        g.MapGet("/", SelByIdAsync)
            .WithResponses<ModuloDetailResponse>(StatusCodes.Status200OK)
            .Produces(StatusCodes.Status404NotFound)
            .WithDescription("Obtener un Módulo");

        g.MapGet("/all", SelAllAsync)
            .WithResponses<IEnumerable<ModuloOption>>(StatusCodes.Status200OK)
            .WithDescription("Obtener todos los Módulo");
    }
}

public partial class ModuloEndPoints
{
    private static async Task<IResult>
         SelByIdAsync(
             [AsParameters] ModuloFilter f,
             IModuloService IModulo
         )
    {
        ModuloDetailResponse? i = await IModulo.SelByIdAsync(f);
        if (i is null)
            return Results.NotFound();
        return Results.Ok(i);
    }

    private static async Task<IResult>
        SelAllAsync(
            [AsParameters] ModuloFilter f,
            IModuloService IModulo
        )
    {
        var r = await IModulo.SelAllAsync();
        return Results.Ok(r);
    }

}