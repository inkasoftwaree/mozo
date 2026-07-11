using Microsoft.AspNetCore.OutputCaching;
using Mozo.Api.Abstractions;
using Mozo.App.Seguridad.Empresa;
using Mozo.App.Seguridad.Empresa.Contracts;
using Mozo.Domain.Seguridad;
using Mozo.Shared.Models;

namespace Mozo.Api.Seguridad;

///<summary>
/// Endpoints para gestión de Empresa
///</summary>
///<history>
/// Create by Jonatan Abregu
///</history>
public sealed partial class EmpresaEndPoints : IEndpoint
{
    private const string CacheTag = "empresa";

    public string Prefix => "/seguridad/empresa";

    /// <summary>
    /// Mapea todas las rutas de Empresa
    /// </summary>
    public void MapEndpoint(RouteGroupBuilder g)
    {
        g.WithSecurity();

        g.MapPost("/", InsertAsync)
             .WithResponsesValue<int>(StatusCodes.Status200OK)
             .WithDescription("Insertar una Empresa");

        g.MapPut("/", UpdateByIdAsync)
             .WithResponsesValue<int>(StatusCodes.Status200OK)
             .Produces(StatusCodes.Status404NotFound)
             .WithDescription("Actualizar una Empresa");

        g.MapPatch("/state", UpdateStateByIdAsync)
             .WithResponsesValue<int>(StatusCodes.Status200OK)
             .Produces(StatusCodes.Status404NotFound)
             .WithDescription("Activar o desactivar una Empresa");

        g.MapGet("/", SelByIdAsync)
            .WithResponses<EmpresaEditResponse>(StatusCodes.Status200OK)
            .Produces(StatusCodes.Status404NotFound)
            .WithDescription("Obtener una Empresa");


        g.MapGet("/all", SelAllAsync)
            .WithResponses<PagedResult<EmpresaListItem>>(StatusCodes.Status200OK)
            .WithDescription("Obtener todas las Empresas");

        g.MapGet("/active", SelAllActiveAsync)
            .CacheOutput(x => x.Expire(TimeSpan.FromHours(24)).Tag(CacheTag))
            .WithResponses<IEnumerable<EmpresaOption>>(StatusCodes.Status200OK)
            .WithDescription("Obtener todas las Empresas activas");
    }

}


public sealed partial class EmpresaEndPoints
{
    private static async Task<IResult>
         InsertAsync(
             EmpresaEntity m,
             IOutputCacheStore cacheStore,
             IEmpresaBusiness IEmpresa
      )
    {
        m.CoEmpresa = await IEmpresa.InsertAsync(m);
        await cacheStore.InvalidateCacheAsync(CacheTag);
        return Results.Created($"/{m.CoEmpresa}", m.CoEmpresa);
    }


    private static async Task<IResult>
        UpdateByIdAsync(
            EmpresaEntity m,
            IOutputCacheStore cacheStore,
            IEmpresaBusiness IEmpresa
    )
    {
        int filas = await IEmpresa.UpdateByIdAsync(m);
        if (filas == 0) return Results.NotFound();

        await cacheStore.InvalidateCacheAsync(CacheTag);
        return Results.Ok(filas);
    }

    private static async Task<IResult>
        UpdateStateByIdAsync(
            EmpresaEntity m,
            IEmpresaService IEmpresa,
            IOutputCacheStore cacheStore
            )
    {
        int filas = await IEmpresa.UpdateStateByIdAsync(m);
        if (filas == 0) return Results.NotFound();

        await cacheStore.InvalidateCacheAsync(CacheTag);
        return Results.Ok(filas);
    }

    private static async Task<IResult>
        SelByIdAsync(
            [AsParameters] EmpresaFilter f,
            IEmpresaService IEmpresa
    )
    {
        EmpresaEditResponse? i = await IEmpresa.SelByIdAsync(f);
        if (i is null)
            return Results.NotFound();
        return Results.Ok(i);
    }

    private static async Task<IResult>
     SelAllAsync(
         [AsParameters] EmpresaFilter f,
         IEmpresaService IEmpresa)
    {
        var r = await IEmpresa.SelAllAsync(f);
        return Results.Ok(r);
    }


    private static async Task<IResult>
        SelAllActiveAsync(
            IEmpresaService IEmpresa
    )
    {
        var r = await IEmpresa.SelAllActiveAsync();
        return Results.Ok(r);
    }

}