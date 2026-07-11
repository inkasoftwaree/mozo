using Mozo.Api.Abstractions;
using Mozo.App.Seguridad.Usuario;
using Mozo.App.Seguridad.Usuario.Contracts;
using Mozo.Domain.Seguridad;
using Mozo.Shared.Exceptions;

namespace Mozo.Api.Seguridad;

///<summary>
/// Endpoints para gestión de Permiso
///</summary>
///<history>
/// Create by Jonatan Abregu
///</history>
public sealed partial class UsuarioEndPoints : IEndpoint
{
    public string Prefix => "/seguridad/usuario";

    /// <summary>
    /// Mapea todas las rutas de Usuario
    /// </summary>
    public void MapEndpoint(RouteGroupBuilder g)
    {
        g.WithSecurity();

        g.MapPost("/", InsertAsync)
            .WithResponsesValue<int>(StatusCodes.Status200OK)
             .WithDescription("Insertar un Usuario");

        g.MapPut("/", UpdateByIdAsync)
            .WithResponsesValue<int>(StatusCodes.Status200OK)
            .Produces(StatusCodes.Status404NotFound)
            .WithDescription("Actualizar un Usuario");

        g.MapPatch("/state", UpdateStateByIdAsync)
            .WithResponsesValue<int>(StatusCodes.Status200OK)
            .Produces(StatusCodes.Status404NotFound)
             .WithDescription("Activar o desactivar un Usuario");

        g.MapGet("/", SelByIdAsync)
            .WithResponses<UsuarioEditResponse>(StatusCodes.Status200OK)
            .Produces(StatusCodes.Status404NotFound)
            .WithDescription("Obtener un Usuario");
    }

}
public partial class UsuarioEndPoints
{

    private static async Task<IResult>
        InsertAsync(
                UsuarioEntity m,
                IUsuarioService IUsuario
        )
    {
        if (m == null)
            throw new ArgumentNullException(nameof(m));

        if (string.IsNullOrWhiteSpace(m.NoUsuario))
            throw new ValidationException("NoUsuario", "El usuario es requerido");

        if (string.IsNullOrWhiteSpace(m.NoClave))
            throw new ValidationException("NoClave", "La contraseña es requerida");


        m.CoUsuario = await IUsuario.InsertAsync(m);

        return Results.Created($"/{m.CoUsuario}", m.CoUsuario);
    }

    private static async Task<IResult>
        UpdateByIdAsync(
            UsuarioEntity m,
            IUsuarioService IUsuario
       )
    {
        if (m == null)
            throw new ArgumentNullException(nameof(m));

        if (string.IsNullOrWhiteSpace(m.NoUsuario))
            throw new ValidationException("NoUsuario", "El usuario es requerido");

        if (string.IsNullOrWhiteSpace(m.NoClave))
            throw new ValidationException("NoClave", "La contraseña es requerida");

        int filas = await IUsuario.UpdateByIdAsync(m);
        return filas > 0 ? Results.Ok(filas) : Results.NotFound();
    }
    private static async Task<IResult>
        UpdateStateByIdAsync(
            UsuarioEntity m,
            IUsuarioService IUsuario
     )
    {
        int filas = await IUsuario.UpdateStateByIdAsync(m);
        return filas > 0 ? Results.Ok(filas) : Results.NotFound();
    }




    private static async Task<IResult>
        SelByIdAsync(
            [AsParameters] UsuarioFilter f,
            IUsuarioService IUsuario
    )
    {
        UsuarioEditResponse? i = await IUsuario.SelByIdAsync(f);
        if (i is null)
            return Results.NotFound();
        return Results.Ok(i);
    }


}