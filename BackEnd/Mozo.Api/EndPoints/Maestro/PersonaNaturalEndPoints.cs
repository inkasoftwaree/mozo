using Microsoft.AspNetCore.OutputCaching;
using Mozo.Api.Abstractions;
using Mozo.App.Maestro.PersonaNatural;
using Mozo.Domain.Maestro;
using Mozo.Shared.Exceptions;

namespace Mozo.Api.Maestro;

///<summary>
/// Endpoints para gestión de PersonaNatural
///</summary>
///<history>
/// Create by Jonatan Abregu
///</history>
public sealed partial class PersonaNaturalEndPoints : IEndpoint
{
    public string Prefix => "/maestro/persona-natural";

    /// <summary>
    /// Mapea todas las rutas de PersonaNatural
    /// </summary>
    public void MapEndpoint(RouteGroupBuilder g)
    {
        g.DisableAntiforgery().RequireAuthorization();
        g.MapPost("/", InsertAsync);
        g.MapPut("/", UpdateAsync);
        g.MapGet("/", SelByIdAsync);
        g.MapGet("/all", SelAllAsync);
        g.MapGet("/active", SelAllActiveAsync).CacheOutput(x => x.Expire(TimeSpan.FromHours(24)).Tag("PersonaNatural_SelAllActive"));
    }

}
public partial class PersonaNaturalEndPoints
{
    private static async Task<IResult>
        InsertAsync(
            PersonaNaturalEntity m,
            IOutputCacheStore outputCacheStore,
            IConfiguration configuration,
            IPersonaNaturalBusiness IPersona
        )
    {
        if (m.NoPersona == null)
            throw new ValidationException("Ingrese nombre de la persona");

        m.CoEntidad = await IPersona.InsertAsync(m);
        return Results.Created($"/{m.CoEntidad}", m.CoEntidad);
    }


    private static async Task<IResult>
        UpdateAsync(
            PersonaNaturalEntity m,
            IOutputCacheStore outputCacheStore,
            IConfiguration configuration,
            IPersonaNaturalBusiness IPersona)
    {

        if (m.NoPersona == null)
            throw new ValidationException("Ingrese nombre de la persona");

        int filas = await IPersona.UpdateByIdAsync(m);
        return filas > 0 ? Results.Ok(filas) : Results.NotFound();
    }


    private static async Task<IResult>
        SelAllActiveAsync(
            [AsParameters] PersonaNaturalFilter f,
            IPersonaNaturalService IPersona)
    {
        IEnumerable<PersonaNaturalEntity> r = await IPersona.SelAllActiveAsync(f);
        return Results.Ok(r);
    }


    private static async Task<IResult>
    SelByIdAsync(
          [AsParameters] PersonaNaturalFilter f,
        IPersonaNaturalService IPersona)
    {
        PersonaNaturalEntity? i = await IPersona.SelByIdAsync(f);
        if (i == null)
            return TypedResults.NotFound();
        return Results.Ok(i);
    }

    private static async Task<IResult>
        SelAllAsync(
            [AsParameters] PersonaNaturalFilter f,
            IPersonaNaturalService IPersona)
    {
        var r = await IPersona.SelAllAsync(f);
        return Results.Ok(r);
    }







}


