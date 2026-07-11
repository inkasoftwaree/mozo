using Mozo.Api.Abstractions;
using Mozo.App.Maestro.EntidadDocumento;
using Mozo.Domain.Maestro;

namespace Mozo.Api.Maestro;
///<summary>
/// Endpoints para gestión de EntidadDocumento
///</summary>
///<history>
/// Create by Jonatan Abregu
///</history>
public sealed partial class EntidadDocumentoEndPoints : IEndpoint
{
    public string Prefix => "/maestro/entidad-documento";

    /// <summary>
    /// Mapea todas las rutas de EntidadDocumento
    /// </summary>
    public void MapEndpoint(RouteGroupBuilder g)
    {
        g.WithSecurity();

        g.MapPost("/", InsertAsync)
         .WithResponsesValue<int>(StatusCodes.Status200OK)
         .WithDescription("Insertar una Documento");

        g.MapPut("/", UpdateByIdAsync)
          .WithResponsesValue<int>(StatusCodes.Status200OK)
          .Produces(StatusCodes.Status404NotFound)
          .WithDescription("Actualizar una Documento");

        g.MapPatch("/default", UpdateDefaultAsync)
      .WithResponsesValue<int>(StatusCodes.Status200OK)
      .Produces(StatusCodes.Status404NotFound)
      .WithDescription("Marcar un Documento como default");

        g.MapDelete("/", DeleteByIdAsync)
             .WithResponsesValue<int>(StatusCodes.Status200OK)
             .Produces(StatusCodes.Status404NotFound)
             .WithDescription("Eliminar una  Documento");

        g.MapGet("/", SelByIdAsync)
            .WithResponses<EntidadDocumentoEntity>(StatusCodes.Status200OK)
            .Produces(StatusCodes.Status404NotFound)
            .WithDescription("Obtener una Documento");

        g.MapGet("/all", SelAllAsync)
          .WithResponses<IEnumerable<EntidadDocumentoEntity>>(StatusCodes.Status200OK)
          .WithDescription("Obtener todas las Documento");
    }
}
public partial class EntidadDocumentoEndPoints
{
    private static async Task<IResult>
        InsertAsync(
            EntidadDocumentoEntity m,
            IEntidadDocumentoService IEntidadDocumento)
    {

        m.CoEntidadDocumento = await IEntidadDocumento.InsertAsync(m);
        return Results.Created($"/{m.CoEntidadDocumento}", m.CoEntidadDocumento);
    }

    private static async Task<IResult>
        UpdateByIdAsync(
            EntidadDocumentoEntity m,
            IEntidadDocumentoService IEntidadDocumento
        )
    {
        int filas = await IEntidadDocumento.UpdateByIdAsync(m);
        return filas > 0 ? Results.Ok(filas) : Results.NotFound();
    }

    private static async Task<IResult>
        UpdateDefaultAsync(
            EntidadDocumentoEntity m,
            IEntidadDocumentoService IEntidadDocumento
        )
    {
        int filas = await IEntidadDocumento.UpdateDefaultAsync(m);
        return filas > 0 ? Results.Ok(filas) : Results.NotFound();
    }

    private static async Task<IResult> DeleteByIdAsync(
        [AsParameters] EntidadDocumentoFilter f,
        IEntidadDocumentoService IEntidadDocumento)
    {
        int filas = await IEntidadDocumento.DeleteByIdAsync(f);
        return filas > 0 ? Results.Ok(filas) : Results.NotFound();
    }

    private static async Task<IResult>
        SelAllAsync(
            [AsParameters] EntidadDocumentoFilter f,
            IEntidadDocumentoService IEntidadDocumento
       )
    {
        IEnumerable<EntidadDocumentoEntity> r = await IEntidadDocumento.SelAllAsync(f);
        return Results.Ok(r);
    }



    private static async Task<IResult>
        SelByIdAsync(
        [AsParameters] EntidadDocumentoFilter f,
        IEntidadDocumentoService IEntidadDocumento
    )
    {
        EntidadDocumentoEntity? i = await IEntidadDocumento.SelByIdAsync(f);
        if (i == null)
            return Results.NotFound();
        return Results.Ok(i);
    }

}



