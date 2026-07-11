using Mozo.Api.Abstractions;
using Mozo.Api.Helper;
using Mozo.App.Login.ModuloUsuario;
using Mozo.App.Login.PerfilPagina;
using Mozo.Domain.Seguridad;
using Mozo.Shared.Services;

namespace Mozo.Api.Login;

///<summary>
/// Endpoints para gestión de Menu
///</summary>
///<history>
/// Create by Jonatan Abregu
///</history>
public sealed partial class MenuEndPoints : IEndpoint
{
    public string Prefix => "/login/menu";

    /// <summary>
    /// Mapea todas las rutas de Menu
    /// </summary>
    public void MapEndpoint(RouteGroupBuilder g)
    {
        g.WithSecurity();

        g.MapGet("/modulos", SelAllModuloAsync)
            .WithResponses<List<ModuloUsuarioEntity>>(StatusCodes.Status200OK)
            .WithDescription("Obtener las opciones del sistema");
    }
}

public partial class MenuEndPoints
{
    private static async Task<IResult>
        SelAllModuloAsync(
            IModuloUsuarioService IModuloUsuario,
            IPerfilPaginaService IPerfilPagina,
           UserContext user
        )
    {
        return Results.Ok(
            await MenuLogin.SelAllModuloAsync(
                new() { CoUsuario = user.CoUsuarioRequired },
                IModuloUsuario, IPerfilPagina
         ));
    }
}