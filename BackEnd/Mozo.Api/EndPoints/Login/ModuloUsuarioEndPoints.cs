using Mozo.Api.Abstractions;
using Mozo.App.Login.ModuloUsuario;
using Mozo.App.Login.ModuloUsuario.Contracts;
using Mozo.Domain.Seguridad;

namespace Mozo.Api.Login;

///<summary>
/// Endpoints para gestión de ModuloUsuario
///</summary>
///<history>
/// Create by Jonatan Abregu
///</history>
public sealed partial class ModuloUsuarioEndPoints : IEndpoint
{
    public string Prefix => "/login/modulo-usuario";

    /// <summary>
    /// Mapea todas las rutas de ModuloUsuario
    /// </summary>
    public void MapEndpoint(RouteGroupBuilder g)
    {
        g.WithSecurity();

        g.MapGet("/modulo", SelByModuloAsync)
             .WithResponses<ModuloUsuarioEntity>(StatusCodes.Status200OK)
             .Produces(StatusCodes.Status404NotFound)
             .WithDescription("Obtener todos los Módulo del usuario por Módulo");

        g.MapGet("/usuario", SelAllByUsuarioAsync)
            .WithResponses<IEnumerable<ModuloUsuarioEntity>>(StatusCodes.Status200OK)
             .WithDescription("Obtener todos los Módulos del usuario por Usuario");
    }
}

public partial class ModuloUsuarioEndPoints
{

    static async Task<IResult>
        SelByModuloAsync(
            [AsParameters] ModuloUsuarioFilter f,
            IModuloUsuarioService IModuloUsuario
       )
    {
        ModuloUsuarioDetailResponse? i = await IModuloUsuario.SelByModuloAsync(new());

        return i is null ?
         Results.NotFound() :
         Results.Ok(i);
    }

    static async Task<IResult>
        SelAllByUsuarioAsync(
            [AsParameters] ModuloUsuarioFilter f,
            IModuloUsuarioService IModuloUsuario
            )
    {
        IEnumerable<ModuloUsuarioListItem> r = await IModuloUsuario.SelAllByUsuarioAsync(f);
        return Results.Ok(r);
    }


}