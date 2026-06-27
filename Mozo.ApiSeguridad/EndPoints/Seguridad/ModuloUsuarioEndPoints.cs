using Mozo.ApiSeguridad.Helper;
using Mozo.Model.Seguridad;
using Mozo.SeguridadBusiness;

namespace Mozo.Api.Seguridad;

///<summary>
/// Endpoints para gestión de ModuloUsuario
///</summary>
///<history>
/// Create by Jonatan Abregu
///</history>
public static partial class ModuloUsuarioEndPoints
{
    ///<summary>
    /// Mapea todas las rutas de ModuloUsuario
    ///</summary>
    ///<history>
    /// Create by Jonatan Abregu
    ///</history>
    public static RouteGroupBuilder MapModuloUsuario(this RouteGroupBuilder g)
    {
        g.WithSecurity();

        g.MapPost("/", InsertAsync)
             .WithResponsesValue<int>(StatusCodes.Status200OK)
             .WithDescription("Insertar un ModuloUsuario");

        g.MapPut("/", UpdateAsync)
             .WithResponsesValue<int>(StatusCodes.Status200OK)
             .WithDescription("Actualizar un ModuloUsuario");

        g.MapPatch("/configuracion", UpdateConfiguracionAsync)
             .WithResponsesValue<int>(StatusCodes.Status200OK)
             .WithDescription("Actualizar configuración de ModuloUsuario");

        g.MapDelete("/byid", DeleteByIdAsync)
            .WithResponses(StatusCodes.Status204NoContent)
            .WithDescription("Eliminar una ModuloUsuario");

        g.MapGet("/byid", SelByIdAsync)
             .WithResponses<ModuloUsuarioModel>(StatusCodes.Status200OK)
            .Produces(StatusCodes.Status404NotFound)
            .WithDescription("Obtener un ModuloUsuario");

        g.MapGet("/modulos", SelAllByModuloAsync)
             .WithResponses<IEnumerable<ModuloUsuarioModel>>(StatusCodes.Status200OK)
            .WithDescription("Obtener los todos los ModuloUsuario por Módulo");

        g.MapGet("/modulos/personas", SelByModuloAndUsuarioAsync)
              .WithResponses<ModuloUsuarioModel>(StatusCodes.Status200OK)
            .WithDescription("Obtener los todos los ModuloUsuario por Módulo y Usuario");

        g.MapGet("/personas", SelAllByUsuarioAsync)
               .WithResponses<IEnumerable<ModuloUsuarioModel>>(StatusCodes.Status200OK)
            .WithDescription("Obtener los todos los ModuloUsuario por Usuario");

        return g;
    }

}


public partial class ModuloUsuarioEndPoints
{
    private static async Task<IResult>
        InsertAsync(
            ModuloUsuarioModel m,
            IModuloUsuarioBusiness IModuloUsuario
        )
    {

        m.CoModuloUsuario = await IModuloUsuario.InsertAsync(m);
        return TypedResults.Created($"/{m.CoModuloUsuario}", m.CoModuloUsuario);
    }

    private static async Task<IResult>
        UpdateAsync(
            ModuloUsuarioModel m,
            IModuloUsuarioBusiness IModuloUsuario
       )
    {

        await IModuloUsuario.UpdateAsync(m);
        return TypedResults.Ok(m.CoModuloUsuario);
    }

    private static async Task<IResult>
        UpdateConfiguracionAsync(
            ModuloUsuarioModel m,
            IModuloUsuarioBusiness IModuloUsuario
       )
    {
        await IModuloUsuario.UpdateConfiguracionAsync(m);
        return TypedResults.Ok(m.CoModuloUsuario);
    }

    private static async Task<IResult>
        DeleteByIdAsync(
            [AsParameters] ModuloUsuarioFilterDto f,
            IModuloUsuarioBusiness IModuloUsuario
       )
    {

        await IModuloUsuario.DeleteByIdAsync(f);
        return TypedResults.NoContent();
    }
    private static async Task<IResult>
        SelByIdAsync(
            [AsParameters] ModuloUsuarioFilterDto f,
            IModuloUsuarioBusiness IModuloUsuario
        )
    {
        ModuloUsuarioModel? i = await IModuloUsuario.SelByIdAsync(f);
        if (i == null)
            return TypedResults.NotFound();
        return TypedResults.Ok(i);
    }

    private static async Task<IResult>
        SelByModuloAndUsuarioAsync(
            [AsParameters] ModuloUsuarioFilterDto f,
            IModuloUsuarioBusiness IModuloUsuario
         )
    {

        ModuloUsuarioModel? i = await IModuloUsuario.SelByModuloAndUsuarioAsync(f);
        if (i is null)
            return TypedResults.NotFound();
        return TypedResults.Ok(i);
    }

    private static async Task<IResult>
            SelAllByUsuarioAsync(
                [AsParameters] ModuloUsuarioFilterDto f,
                IModuloUsuarioBusiness IModuloUsuario
        )
    {

        IEnumerable<ModuloUsuarioModel> r = await IModuloUsuario.SelAllByUsuarioAsync(f);
        return TypedResults.Ok(r);
    }

    private static async Task<IResult>
        SelAllByModuloAsync(
            [AsParameters] ModuloUsuarioFilterDto f,
            IModuloUsuarioBusiness IModuloUsuario
        )
    {
        IEnumerable<ModuloUsuarioModel> r = await IModuloUsuario.SelAllByModuloAsync(f);
        return TypedResults.Ok(r);
    }

}