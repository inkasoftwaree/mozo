using Mozo.ApiSeguridad.Helper;
using Mozo.ApiSeguridad.HelperWeb.Exceptions;
using Mozo.Model.Seguridad;
using Mozo.SeguridadBusiness;

namespace Mozo.Api.Seguridad;

///<summary>
/// Endpoints para gestión de Permiso
///</summary>
///<history>
/// Create by Jonatan Abregu
///</history>
public static partial class UsuarioEndPoints
{
    /// <summary>
    /// Mapea todas las rutas de Usuario
    /// </summary>
    public static RouteGroupBuilder MapUsuario(this RouteGroupBuilder g)
    {
        g.WithSecurity();

        g.MapPost("/", InsertAsync)
            .WithResponsesValue<int>(StatusCodes.Status200OK)
             .WithDescription("Insertar un Usuario");

        g.MapPut("/", UpdateAsync)
            .WithResponsesValue<int>(StatusCodes.Status200OK)
            .WithDescription("Actualizar un Usuario");

        g.MapPatch("/state", UpdateStateAsync)
            .WithResponsesValue<int>(StatusCodes.Status200OK)
             .WithDescription("Activar o desactivar un Usuario");

        g.MapGet("/byid", SelByIdAsync)
            .WithResponses<UsuarioModel>(StatusCodes.Status200OK)
            .Produces(StatusCodes.Status404NotFound)
            .WithDescription("Obtener un Usuario");
        return g;
    }

}
public partial class UsuarioEndPoints
{

    private static async Task<IResult>
        InsertAsync(
                UsuarioModel m,
                IUsuarioBusiness IUsuario
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
        UpdateAsync(
            UsuarioModel m,
            IUsuarioBusiness IUsuario
       )
    {
        if (m == null)
            throw new ArgumentNullException(nameof(m));

        if (string.IsNullOrWhiteSpace(m.NoUsuario))
            throw new ValidationException("NoUsuario", "El usuario es requerido");

        if (string.IsNullOrWhiteSpace(m.NoClave))
            throw new ValidationException("NoClave", "La contraseña es requerida");

        await IUsuario.UpdateAsync(m);
        return Results.Ok(m.CoUsuario);
    }
    private static async Task<IResult>
        UpdateStateAsync(
            UsuarioModel m,
            IUsuarioBusiness IUsuario
     )
    {
        await IUsuario.UpdateStateAsync(m);
        return Results.Ok(m.CoUsuario);
    }




    private static async Task<IResult>
        SelByIdAsync(
            [AsParameters] UsuarioFilterDto f,
            IUsuarioBusiness IUsuario
    )
    {
        UsuarioModel? i = await IUsuario.SelByIdAsync(f);
        if (i is null)
            return Results.NotFound();
        return Results.Ok(i);
    }


}