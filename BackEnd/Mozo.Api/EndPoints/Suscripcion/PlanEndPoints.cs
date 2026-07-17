using Microsoft.AspNetCore.OutputCaching;
using Mozo.Api.Abstractions;
using Mozo.App.Suscripcion.Plan;
using Mozo.App.Suscripcion.Plan.Contracts;
using Mozo.Domain.Suscripcion;
using Mozo.Shared.Models;

namespace Mozo.Api.Suscripcion;

///<summary>
/// Endpoints para gestión de Plan
///</summary>
public sealed partial class PlanEndPoints : IEndpoint
{
    private const string CacheTag = "plan";

    public string Prefix => "/suscripcion/plan";

    public void MapEndpoint(RouteGroupBuilder g)
    {
        g.WithSecurity();

        g.MapPost("/", InsertAsync)
             .WithResponsesValue<int>(StatusCodes.Status201Created)
             .WithDescription("Insertar un Plan");

        g.MapPut("/", UpdateByIdAsync)
             .WithResponsesValue<int>(StatusCodes.Status200OK)
             .Produces(StatusCodes.Status404NotFound)
             .WithDescription("Actualizar un Plan");

        g.MapPatch("/state", UpdateStateByIdAsync)
             .WithResponsesValue<int>(StatusCodes.Status200OK)
             .Produces(StatusCodes.Status404NotFound)
             .WithDescription("Activar o desactivar un Plan");

        g.MapDelete("/", DeleteByIdAsync)
             .WithResponsesValue<int>(StatusCodes.Status200OK)
             .Produces(StatusCodes.Status404NotFound)
             .WithDescription("Eliminar un Plan");

        g.MapGet("/", SelByIdAsync)
            .WithResponses<PlanEditResponse>(StatusCodes.Status200OK)
            .Produces(StatusCodes.Status404NotFound)
            .WithDescription("Obtener un Plan");

        g.MapGet("/all", SelAllAsync)
            .WithResponses<PagedResult<PlanListItem>>(StatusCodes.Status200OK)
            .WithDescription("Obtener todos los Planes");

        g.MapGet("/active", SelAllActiveAsync)
            .AllowAnonymous()
            .CacheOutput(CacheTag)
            .WithResponses<IEnumerable<PlanOption>>(StatusCodes.Status200OK)
            .WithDescription("Obtener todos los Planes activos (público, para la página de registro)");
    }
}

public sealed partial class PlanEndPoints
{
    private static async Task<IResult>
        InsertAsync(PlanEntity m, IOutputCacheStore cacheStore, IPlanService IPlan)
    {
        m.CoPlan = await IPlan.InsertAsync(m);
        await cacheStore.InvalidateCacheAsync(CacheTag);
        return Results.Created($"/{m.CoPlan}", m.CoPlan);
    }

    private static async Task<IResult>
        UpdateByIdAsync(PlanEntity m, IOutputCacheStore cacheStore, IPlanService IPlan)
    {
        int filas = await IPlan.UpdateByIdAsync(m);
        if (filas == 0) return Results.NotFound();

        await cacheStore.InvalidateCacheAsync(CacheTag);
        return Results.Ok(filas);
    }

    private static async Task<IResult>
        UpdateStateByIdAsync(PlanEntity m, IOutputCacheStore cacheStore, IPlanService IPlan)
    {
        int filas = await IPlan.UpdateStateByIdAsync(m);
        if (filas == 0) return Results.NotFound();

        await cacheStore.InvalidateCacheAsync(CacheTag);
        return Results.Ok(filas);
    }

    private static async Task<IResult>
        DeleteByIdAsync([AsParameters] PlanFilter f, IOutputCacheStore cacheStore, IPlanService IPlan)
    {
        int filas = await IPlan.DeleteByIdAsync(f);
        if (filas == 0) return Results.NotFound();

        await cacheStore.InvalidateCacheAsync(CacheTag);
        return Results.Ok(filas);
    }

    private static async Task<IResult>
        SelByIdAsync([AsParameters] PlanFilter f, IPlanService IPlan)
    {
        PlanEditResponse? i = await IPlan.SelByIdAsync(f);
        if (i is null)
            return Results.NotFound();
        return Results.Ok(i);
    }

    private static async Task<IResult>
        SelAllAsync([AsParameters] PlanFilter f, IPlanService IPlan)
    {
        var r = await IPlan.SelAllAsync(f);
        return Results.Ok(r);
    }

    private static async Task<IResult>
        SelAllActiveAsync(IPlanService IPlan)
    {
        var r = await IPlan.SelAllActiveAsync();
        return Results.Ok(r);
    }
}
