using Mozo.Api.Abstractions;
using Mozo.App.Suscripcion.Suscripcion;
using Mozo.App.Suscripcion.Suscripcion.Contracts;
using Mozo.Domain.Suscripcion;
using Mozo.Shared.Models;

namespace Mozo.Api.Suscripcion;

///<summary>
/// Endpoints para gestión de Suscripciones
///</summary>
public sealed partial class SuscripcionEndPoints : IEndpoint
{
    public string Prefix => "/suscripcion/suscripcion";

    public void MapEndpoint(RouteGroupBuilder g)
    {
        g.WithSecurity();

        g.MapPost("/", InsertAsync)
             .WithResponsesValue<int>(StatusCodes.Status201Created)
             .WithDescription("Crear una Suscripción");

        g.MapGet("/", SelByIdAsync)
            .WithResponses<SuscripcionEditResponse>(StatusCodes.Status200OK)
            .Produces(StatusCodes.Status404NotFound)
            .WithDescription("Obtener una Suscripción");

        g.MapGet("/all", SelAllAsync)
            .WithResponses<PagedResult<SuscripcionListItem>>(StatusCodes.Status200OK)
            .WithDescription("Obtener todas las Suscripciones");

        g.MapGet("/byempresa", SelByEmpresaAsync)
            .WithResponses<IEnumerable<SuscripcionEmpresaItem>>(StatusCodes.Status200OK)
            .WithDescription("Obtener las Suscripciones de una empresa");

        g.MapPatch("/estado", UpdateEstadoByIdAsync)
             .WithResponsesValue<int>(StatusCodes.Status200OK)
             .Produces(StatusCodes.Status404NotFound)
             .WithDescription("Cambiar el estado de una Suscripción");

        g.MapPost("/cancelar", CancelarAsync)
             .WithResponsesValue<int>(StatusCodes.Status200OK)
             .Produces(StatusCodes.Status404NotFound)
             .WithDescription("Cancelar una Suscripción");

        g.MapPost("/renovar", RenovarAsync)
             .WithResponsesValue<int>(StatusCodes.Status200OK)
             .Produces(StatusCodes.Status404NotFound)
             .WithDescription("Renovar una Suscripción");

        g.MapPost("/procesarvencimientos", ProcesarVencimientosAsync)
             .WithResponsesValue<int>(StatusCodes.Status200OK)
             .WithDescription("Procesar suscripciones vencidas (job)");
    }
}

public sealed partial class SuscripcionEndPoints
{
    private static async Task<IResult>
        InsertAsync(SuscripcionEntity m, ISuscripcionService ISuscripcion)
    {
        m.CoSuscripcion = await ISuscripcion.InsertAsync(m);
        return Results.Created($"/{m.CoSuscripcion}", m.CoSuscripcion);
    }

    private static async Task<IResult>
        SelByIdAsync([AsParameters] SuscripcionFilter f, ISuscripcionService ISuscripcion)
    {
        SuscripcionEditResponse? i = await ISuscripcion.SelByIdAsync(f);
        if (i is null)
            return Results.NotFound();
        return Results.Ok(i);
    }

    private static async Task<IResult>
        SelAllAsync([AsParameters] SuscripcionFilter f, ISuscripcionService ISuscripcion)
    {
        var r = await ISuscripcion.SelAllAsync(f);
        return Results.Ok(r);
    }

    private static async Task<IResult>
        SelByEmpresaAsync([AsParameters] SuscripcionFilter f, ISuscripcionService ISuscripcion)
    {
        var r = await ISuscripcion.SelByEmpresaAsync(f);
        return Results.Ok(r);
    }

    private static async Task<IResult>
        UpdateEstadoByIdAsync(SuscripcionEntity m, ISuscripcionService ISuscripcion)
    {
        int filas = await ISuscripcion.UpdateEstadoByIdAsync(m);
        return filas > 0 ? Results.Ok(filas) : Results.NotFound();
    }

    private static async Task<IResult>
        CancelarAsync(SuscripcionEntity m, ISuscripcionService ISuscripcion)
    {
        int filas = await ISuscripcion.CancelarAsync(m);
        return filas > 0 ? Results.Ok(filas) : Results.NotFound();
    }

    private static async Task<IResult>
        RenovarAsync(SuscripcionEntity m, ISuscripcionService ISuscripcion)
    {
        int filas = await ISuscripcion.RenovarAsync(m);
        return filas > 0 ? Results.Ok(filas) : Results.NotFound();
    }

    private static async Task<IResult>
        ProcesarVencimientosAsync(ISuscripcionService ISuscripcion)
    {
        int filas = await ISuscripcion.ProcesarVencimientosAsync();
        return Results.Ok(filas);
    }
}
