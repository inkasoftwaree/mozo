using Mozo.Api.Abstractions;
using Mozo.App.Maestro.EntidadDireccion;
using Mozo.Domain.Maestro;

namespace Mozo.Api.Maestro;
///<summary>
/// Endpoints para gestión de EntidadDireccion
///</summary>
///<history>
/// Create by Jonatan Abregu
///</history>
public sealed partial class EntidadDireccionEndPoints : IEndpoint
{
    public string Prefix => "/maestro/entidad-direccion";

    /// <summary>
    /// Mapea todas las rutas de EntidadDireccion
    /// </summary>
    public void MapEndpoint(RouteGroupBuilder g)
    {
        g.WithSecurity();

        g.MapPost("/", InsertAsync)
         .WithResponsesValue<int>(StatusCodes.Status200OK)
         .WithDescription("Insertar una Dirección");

        g.MapPut("/", UpdateByIdAsync)
          .WithResponsesValue<int>(StatusCodes.Status200OK)
          .Produces(StatusCodes.Status404NotFound)
          .WithDescription("Actualizar una Dirección");

        g.MapPatch("/state", UpdateStateByIdAsync)
        .WithResponsesValue<int>(StatusCodes.Status200OK)
        .Produces(StatusCodes.Status404NotFound)
        .WithDescription("Actualizar estado una Dirección");

        g.MapPatch("/default", UpdateDefaultAsync)
      .WithResponsesValue<int>(StatusCodes.Status200OK)
      .Produces(StatusCodes.Status404NotFound)
      .WithDescription("Marcar una Dirección como default");

        g.MapDelete("/", DeleteByIdAsync)
             .WithResponsesValue<int>(StatusCodes.Status200OK)
             .Produces(StatusCodes.Status404NotFound)
             .WithDescription("Eliminar una  Dirección");

        g.MapGet("/", SelByIdAsync)
            .WithResponses<EntidadDireccionEntity>(StatusCodes.Status200OK)
            .Produces(StatusCodes.Status404NotFound)
            .WithDescription("Obtener una Dirección");

        g.MapGet("/all", SelAllAsync)
          .WithResponses<IEnumerable<EntidadDireccionEntity>>(StatusCodes.Status200OK)
          .WithDescription("Obtener todas las Dirección");

        g.MapGet("/active", SelAllActiveAsync)
     .WithResponses<IEnumerable<EntidadDireccionEntity>>(StatusCodes.Status200OK)
     .WithDescription("Obtener todas las Dirección activas");
    }
}
public partial class EntidadDireccionEndPoints
{
    private static async Task<IResult>
        InsertAsync(
            EntidadDireccionEntity m,
            IEntidadDireccionService IEntidadDireccion)
    {

        m.CoEntidadDireccion = await IEntidadDireccion.InsertAsync(m);
        return Results.Created($"/{m.CoEntidadDireccion}", m.CoEntidadDireccion);
    }

    private static async Task<IResult>
        UpdateByIdAsync(
            EntidadDireccionEntity m,
            IEntidadDireccionService IEntidadDireccion
        )
    {
        int filas = await IEntidadDireccion.UpdateByIdAsync(m);
        return filas > 0 ? Results.Ok(filas) : Results.NotFound();
    }


    private static async Task<IResult>
      UpdateStateByIdAsync(
          EntidadDireccionEntity m,
          IEntidadDireccionService IEntidadDireccion
      )
    {
        int filas = await IEntidadDireccion.UpdateStateByIdAsync(m);
        return filas > 0 ? Results.Ok(filas) : Results.NotFound();
    }

    private static async Task<IResult>
        UpdateDefaultAsync(
            EntidadDireccionEntity m,
            IEntidadDireccionService IEntidadDireccion
        )
    {
        int filas = await IEntidadDireccion.UpdateDefaultAsync(m);
        return filas > 0 ? Results.Ok(filas) : Results.NotFound();
    }

    private static async Task<IResult> DeleteByIdAsync(
        [AsParameters] EntidadDireccionFilter f,
        IEntidadDireccionService IEntidadDireccion)
    {
        int filas = await IEntidadDireccion.DeleteByIdAsync(f);
        return filas > 0 ? Results.Ok(filas) : Results.NotFound();
    }

    private static async Task<IResult>
        SelAllAsync(
            [AsParameters] EntidadDireccionFilter f,
            IEntidadDireccionService IEntidadDireccion
       )
    {
        IEnumerable<EntidadDireccionEntity> r = await IEntidadDireccion.SelAllAsync(f);
        return Results.Ok(r);
    }

    private static async Task<IResult>
    SelAllActiveAsync(
        [AsParameters] EntidadDireccionFilter f,
        IEntidadDireccionService IEntidadDireccion
   )
    {
        IEnumerable<EntidadDireccionEntity> r = await IEntidadDireccion.SelAllActiveAsync(f);
        return Results.Ok(r);
    }


    private static async Task<IResult>
        SelByIdAsync(
        [AsParameters] EntidadDireccionFilter f,
        IEntidadDireccionService IEntidadDireccion
    )
    {
        EntidadDireccionEntity? i = await IEntidadDireccion.SelByIdAsync(f);
        if (i == null)
            return Results.NotFound();
        return Results.Ok(i);
    }

}



