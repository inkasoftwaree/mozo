using Mozo.Api.Abstractions;
using Mozo.App.Suscripcion.SuscripcionPago;
using Mozo.App.Suscripcion.SuscripcionPago.Contracts;
using Mozo.Domain.Suscripcion;

namespace Mozo.Api.Suscripcion;

///<summary>
/// Endpoints para gestión de pagos de una Suscripción
///</summary>
public sealed partial class SuscripcionPagoEndPoints : IEndpoint
{
    public string Prefix => "/suscripcion/suscripcionpago";

    public void MapEndpoint(RouteGroupBuilder g)
    {
        g.WithSecurity();

        g.MapPost("/", InsertAsync)
             .WithResponsesValue<int>(StatusCodes.Status201Created)
             .WithDescription("Registrar un pago de Suscripción");

        g.MapGet("/all", SelAllBySuscripcionAsync)
            .WithResponses<IEnumerable<SuscripcionPagoListItem>>(StatusCodes.Status200OK)
            .WithDescription("Obtener los pagos de una Suscripción");

        g.MapPatch("/estado", UpdateEstadoByIdAsync)
             .WithResponsesValue<int>(StatusCodes.Status200OK)
             .Produces(StatusCodes.Status404NotFound)
             .WithDescription("Cambiar el estado de un pago");
    }
}

public sealed partial class SuscripcionPagoEndPoints
{
    private static async Task<IResult>
        InsertAsync(SuscripcionPagoEntity m, ISuscripcionPagoService ISuscripcionPago)
    {
        m.CoSuscripcionPago = await ISuscripcionPago.InsertAsync(m);
        return Results.Created($"/{m.CoSuscripcionPago}", m.CoSuscripcionPago);
    }

    private static async Task<IResult>
        SelAllBySuscripcionAsync([AsParameters] SuscripcionPagoFilter f, ISuscripcionPagoService ISuscripcionPago)
    {
        var r = await ISuscripcionPago.SelAllBySuscripcionAsync(f);
        return Results.Ok(r);
    }

    private static async Task<IResult>
        UpdateEstadoByIdAsync(SuscripcionPagoEntity m, ISuscripcionPagoService ISuscripcionPago)
    {
        int filas = await ISuscripcionPago.UpdateEstadoByIdAsync(m);
        return filas > 0 ? Results.Ok(filas) : Results.NotFound();
    }
}
