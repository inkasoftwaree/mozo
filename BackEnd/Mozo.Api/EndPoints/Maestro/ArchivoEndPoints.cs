using Microsoft.Extensions.Primitives;
using Mozo.Api.Abstractions;
using Mozo.App.Maestro.Archivo;
using Mozo.App.Maestro.Archivo.Contracts;
using Mozo.Domain.Maestro;


namespace Mozo.Api.Maestro;
///<summary>
/// Endpoints para gestión de Archivo
///</summary>
///<history>
/// Create by Jonatan Abregu
///</history>
public sealed partial class ArchivoEndPoints : IEndpoint
{
    public string Prefix => "/maestro/archivo";

    /// <summary>
    /// Mapea todas las rutas de Archivo
    /// </summary>
    public void MapEndpoint(RouteGroupBuilder g)
    {
        g.WithSecurity();

        g.MapPost("/", InsertAsync)
         .DisableAntiforgery()
         .WithResponses<ArchivoEntity>(StatusCodes.Status200OK)
         .Produces(StatusCodes.Status400BadRequest)
         .WithDescription("Subir archivo")
         .Accepts<IFormFile>("multipart/form-data");

        g.MapPut("/", UpdateByIdAsync)
        .WithResponsesValue<int>(StatusCodes.Status200OK)
        .Produces(StatusCodes.Status404NotFound)
        .WithDescription("Actualizar descripción/título/orden de un Archivo");

        g.MapPut("/meta-data", UpdateMetaDataByIdAsync)
         .DisableAntiforgery()
         .WithResponses<ArchivoEntity>(StatusCodes.Status200OK)
         .Produces(StatusCodes.Status400BadRequest)
         .WithDescription("Reemplazar archivo existente")
         .Accepts<IFormFile>("multipart/form-data");



        g.MapDelete("/", DeleteByIdAsync)
         .WithResponsesValue<int>(StatusCodes.Status200OK)
         .Produces(StatusCodes.Status404NotFound)
         .WithDescription("Eliminar registro y archivo físico. Devuelve la cantidad de filas eliminadas");

        g.MapGet("/", SelByIdAsync)
         .WithResponses<ArchivoEntity>(StatusCodes.Status200OK)
         .Produces(StatusCodes.Status404NotFound)
         .WithDescription("Descargar archivo por id");

        g.MapGet("/uk", SelMetaDataByUkAsync)
         .WithResponses<ArchivoEntity>(StatusCodes.Status200OK)
         .Produces(StatusCodes.Status404NotFound)
         .WithDescription("Obtener archivo por UK (empresa+entidad+tipo+orden)");

        g.MapGet("/meta-data", SelMetaDataByIdAsync)
         .WithResponses<ArchivoEntity>(StatusCodes.Status200OK)
         .Produces(StatusCodes.Status404NotFound)
         .WithDescription("Obtener metadata del archivo");

        g.MapGet("/all", SelAllAsync)
         .WithResponses<IEnumerable<ArchivoEntity>>(StatusCodes.Status200OK)
         .WithDescription("Obtener todos los archivos de una entidad");

        g.MapGet("/active", SelAllActiveAsync)
         .WithResponses<IEnumerable<ArchivoEntity>>(StatusCodes.Status200OK)
         .WithDescription("Obtener archivos activos de una entidad");


        g.MapPut("/orden", UpdateOrderAsync)
         .WithResponsesValue<int>(StatusCodes.Status200OK)
         .Produces(StatusCodes.Status404NotFound)
         .WithDescription("Actualizar orden de un archivo");

        g.MapPut("/orden-masivo", UpdateOrdenMasivoAsync)
         .WithResponsesValue<int>(StatusCodes.Status200OK)
         .WithDescription("Reordenar varios archivos a la vez. Devuelve la cantidad de filas afectadas");
    }
}
public partial class ArchivoEndPoints
{
    private static async Task<IResult>
          InsertAsync(
               HttpRequest request,
              IArchivoBusiness IArchivo)
    {
        if (!request.HasFormContentType)
            return Results.BadRequest("Content-Type debe ser multipart/form-data");

        IFormCollection form = await request.ReadFormAsync();
        IFormFile? file = form.Files.GetFile("file");
        if (file == null) return Results.BadRequest("No se recibió archivo");

        ArchivoEntity parametros = ParseUploadParams(form);
        ArchivoEntity archivo = await IArchivo.InsertAsync(parametros, file);
        return Results.Ok(archivo);
    }


    private static async Task<IResult>
      UpdateMetaDataByIdAsync(
           HttpRequest request,
          IArchivoBusiness IArchivo)
    {
        if (!request.HasFormContentType)
            return Results.BadRequest("Content-Type debe ser multipart/form-data");

        IFormCollection form = await request.ReadFormAsync();
        IFormFile? file = form.Files.GetFile("file");
        if (file == null) return Results.BadRequest("No se recibió archivo");

        ArchivoEntity parametros = ParseUploadParams(form);
        parametros.CoArchivo = ParseInt(form["coArchivo"]) ?? 0;

        ArchivoEntity archivo = await IArchivo.UpdateMetaDataByIdAsync(parametros, file);
        return Results.Ok(archivo);
    }

    private static async Task<IResult>
        UpdateByIdAsync(
            ArchivoEntity m,
            IArchivoBusiness IArchivo
        )
    {
        int filas = await IArchivo.UpdateByIdAsync(m);
        return filas > 0 ? Results.Ok(filas) : Results.NotFound();
    }

    private static async Task<IResult> DeleteByIdAsync(
        [AsParameters] ArchivoFilter f,
        IArchivoBusiness IArchivo)
    {
        int filas = await IArchivo.DeleteByIdAsync(f);
        return filas > 0 ? Results.Ok(filas) : Results.NotFound();
    }

    private static async Task<IResult>
        SelAllAsync(
            [AsParameters] ArchivoFilter f,
            IArchivoBusiness IArchivo
       )
    {
        IEnumerable<ArchivoListItem> r = await IArchivo.SelAllAsync(f);
        r = r.OrderBy(x => x.CoTipo).ThenBy(y => y.NoTitulo);
        return Results.Ok(r);
    }


    private static async Task<IResult>
      SelMetaDataByIdAsync(
        [AsParameters] ArchivoFilter f,
        HttpContext ctx,
      IArchivoBusiness IArchivo
      )
    {
        ArchivoEditResponse? i = await IArchivo.SelMetaDataByIdAsync(f);

        return i == null ?
            Results.NotFound() :
            Results.Ok(i);
    }



    private static async Task<IResult>
        SelByIdAsync(
        [AsParameters] ArchivoFilter f,
        IArchivoBusiness IArchivo
        )
    {
        ArchivoEditResponse? i = await IArchivo.SelByIdAsync(f);
        if (i == null)
            return Results.NotFound();
        return Results.Ok(i);
    }

    private static async Task<IResult>
    SelMetaDataByUkAsync(
    [AsParameters] ArchivoFilter f,
    IArchivoBusiness IArchivo
    )
    {
        ArchivoEditResponse? i = await IArchivo.SelMetaDataByUkAsync(f);
        if (i == null)
            return Results.NotFound();
        return Results.Ok(i);
    }



    private static async Task<IResult>
     SelAllActiveAsync(
     [AsParameters] ArchivoFilter f,
     IArchivoBusiness IArchivo
     )
    {
        IEnumerable<ArchivoListItem> r = await IArchivo.SelAllActiveAsync(f);
        r = r.OrderBy(x => x.CoTipo).ThenBy(y => y.NoTitulo);
        return Results.Ok(r);
    }


    private static async Task<IResult> UpdateOrderAsync(
        ArchivoEntity m,
        IArchivoBusiness biz)
    {
        int filas = await biz.UpdateOrderAsync(m);
        return filas > 0 ? Results.Ok(filas) : Results.NotFound();
    }

    private static async Task<IResult> UpdateOrdenMasivoAsync(
        OrdenMasivoRequest req,
        IArchivoBusiness biz)
    {
        int filas = await biz.UpdateOrderMassiveAsync(req);
        return Results.Ok(filas);
    }



    private static ArchivoEntity ParseUploadParams(IFormCollection form) => new()
    {
        FlEmpresaNotKey = ParseInt(form["flEmpresaNotKey"]) ?? 0,
        CoEmpresa = ParseInt(form["coEmpresa"]),
        CoTipoEntidad = ParseInt(form["coTipoEntidad"]) ?? 0,
        CoEntidad = ParseInt(form["coEntidad"]) ?? 0,
        CoTipo = ParseInt(form["coTipo"]) ?? 0,
        FlGaleria = ParseInt(form["flGaleria"]) ?? 0,
    };

    private static int? ParseInt(StringValues value) =>
        int.TryParse(value.ToString(), out var result) ? result : null;
}


