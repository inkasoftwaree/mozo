using Mozo.Api.Abstractions;
using Mozo.App.Suscripcion.PlanPrecio;
using Mozo.App.Suscripcion.PlanPrecio.Contracts;
using Mozo.Domain.Suscripcion;

namespace Mozo.Api.Suscripcion;

///<summary>
/// Endpoints para gestión de precios de un Plan
///</summary>
public sealed partial class PlanPrecioEndPoints : IEndpoint
{
    public string Prefix => "/suscripcion/planprecio";

    public void MapEndpoint(RouteGroupBuilder g)
    {
        g.WithSecurity();

        g.MapPost("/", InsertAsync)
             .WithResponsesValue<int>(StatusCodes.Status201Created)
             .WithDescription("Insertar un precio de Plan");

        g.MapPut("/", UpdateByIdAsync)
             .WithResponsesValue<int>(StatusCodes.Status200OK)
             .Produces(StatusCodes.Status404NotFound)
             .WithDescription("Actualizar un precio de Plan");

        g.MapDelete("/", DeleteByIdAsync)
             .WithResponsesValue<int>(StatusCodes.Status200OK)
             .Produces(StatusCodes.Status404NotFound)
             .WithDescription("Eliminar un precio de Plan");

        g.MapGet("/all", SelAllByPlanAsync)
            .WithResponses<IEnumerable<PlanPrecioListItem>>(StatusCodes.Status200OK)
            .WithDescription("Obtener los precios de un Plan");
    }
}

public sealed partial class PlanPrecioEndPoints
{
    private static async Task<IResult>
        InsertAsync(PlanPrecioEntity m, IPlanPrecioService IPlanPrecio)
    {
        m.CoPlanPrecio = await IPlanPrecio.InsertAsync(m);
        return Results.Created($"/{m.CoPlanPrecio}", m.CoPlanPrecio);
    }

    private static async Task<IResult>
        UpdateByIdAsync(PlanPrecioEntity m, IPlanPrecioService IPlanPrecio)
    {
        int filas = await IPlanPrecio.UpdateByIdAsync(m);
        return filas > 0 ? Results.Ok(filas) : Results.NotFound();
    }

    private static async Task<IResult>
        DeleteByIdAsync([AsParameters] PlanPrecioFilter f, IPlanPrecioService IPlanPrecio)
    {
        int filas = await IPlanPrecio.DeleteByIdAsync(f);
        return filas > 0 ? Results.Ok(filas) : Results.NotFound();
    }

    private static async Task<IResult>
        SelAllByPlanAsync([AsParameters] PlanPrecioFilter f, IPlanPrecioService IPlanPrecio)
    {
        var r = await IPlanPrecio.SelAllByPlanAsync(f);
        return Results.Ok(r);
    }
}
