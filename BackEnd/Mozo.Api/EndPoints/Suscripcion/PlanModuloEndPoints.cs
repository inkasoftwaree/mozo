using Mozo.Api.Abstractions;
using Mozo.App.Suscripcion.PlanModulo;
using Mozo.App.Suscripcion.PlanModulo.Contracts;
using Mozo.Domain.Suscripcion;

namespace Mozo.Api.Suscripcion;

///<summary>
/// Endpoints para gestión de módulos incluidos en un Plan
///</summary>
public sealed partial class PlanModuloEndPoints : IEndpoint
{
    public string Prefix => "/suscripcion/planmodulo";

    public void MapEndpoint(RouteGroupBuilder g)
    {
        g.WithSecurity();

        g.MapPost("/", InsertAsync)
             .WithResponsesValue<int>(StatusCodes.Status201Created)
             .WithDescription("Agregar un módulo a un Plan");

        g.MapDelete("/", DeleteByIdAsync)
             .WithResponsesValue<int>(StatusCodes.Status200OK)
             .Produces(StatusCodes.Status404NotFound)
             .WithDescription("Quitar un módulo de un Plan");

        g.MapGet("/all", SelAllByPlanAsync)
            .WithResponses<IEnumerable<PlanModuloListItem>>(StatusCodes.Status200OK)
            .WithDescription("Obtener los módulos de un Plan");
    }
}

public sealed partial class PlanModuloEndPoints
{
    private static async Task<IResult>
        InsertAsync(PlanModuloEntity m, IPlanModuloService IPlanModulo)
    {
        m.CoPlanModulo = await IPlanModulo.InsertAsync(m);
        return Results.Created($"/{m.CoPlanModulo}", m.CoPlanModulo);
    }

    private static async Task<IResult>
        DeleteByIdAsync([AsParameters] PlanModuloFilter f, IPlanModuloService IPlanModulo)
    {
        int filas = await IPlanModulo.DeleteByIdAsync(f);
        return filas > 0 ? Results.Ok(filas) : Results.NotFound();
    }

    private static async Task<IResult>
        SelAllByPlanAsync([AsParameters] PlanModuloFilter f, IPlanModuloService IPlanModulo)
    {
        var r = await IPlanModulo.SelAllByPlanAsync(f);
        return Results.Ok(r);
    }
}
