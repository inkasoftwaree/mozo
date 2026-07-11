using Microsoft.AspNetCore.OutputCaching;
using Mozo.Api.Abstractions;
using Mozo.App.Maestro.PersonaJuridica;
using Mozo.App.Maestro.PersonaNatural;
using Mozo.Domain.Maestro;
using Mozo.Shared.Exceptions;

namespace Mozo.Api.Maestro;

///<summary>
/// Endpoints para gestión de PersonaJuridica
///</summary>
///<history>
/// Create by Jonatan Abregu
///</history>
public sealed partial class PersonaJuridicaEndPoints : IEndpoint
{
    public string Prefix => "/maestro/persona-juridica";

    /// <summary>
    /// Mapea todas las rutas de PersonaJuridica
    /// </summary>
    public void MapEndpoint(RouteGroupBuilder g)
    {
        g.DisableAntiforgery().RequireAuthorization();
        g.MapPost("/", InsertAsync);
        g.MapPut("/", UpdateAsync);
        g.MapGet("/", SelByIdAsync);
        g.MapGet("/all", SelAllAsync);
        g.MapGet("/active", SelAllActiveAsync);
    }

}
public partial class PersonaJuridicaEndPoints
{
    private static async Task<IResult>
        InsertAsync(
            PersonaJuridicaEntity m,
            IOutputCacheStore outputCacheStore,
            IConfiguration configuration,
            IPersonaJuridicaBusiness IPersona
        )
    {
        if (m.NoRazonSocial == null)
            throw new ValidationException("Ingrese nombre de la Persona Jurídica");

        m.CoEntidad = await IPersona.InsertAsync(m);
        return Results.Created($"/{m.CoEntidad}", m.CoEntidad);
    }


    private static async Task<IResult>
        UpdateAsync(
            PersonaJuridicaEntity m,
            IOutputCacheStore outputCacheStore,
            IConfiguration configuration,
            IPersonaJuridicaBusiness IPersona)
    {

        if (m.NoRazonSocial == null)
            throw new ValidationException("Ingrese nombre de la Persona Jurídica");

        int filas = await IPersona.UpdateByIdAsync(m);
        return filas > 0 ? Results.Ok(filas) : Results.NotFound();
    }



    private static async Task<IResult>
        SelAllActiveAsync(
            [AsParameters] PersonaJuridicaFilter f,
            IPersonaJuridicaService IPersona)
    {
        IEnumerable<PersonaJuridicaEntity> r = await IPersona.SelAllActiveAsync(f);
        return Results.Ok(r);
    }


    private static async Task<IResult>
        SelByIdAsync(
          [AsParameters] PersonaJuridicaFilter f,
        IPersonaJuridicaService IPersona)
    {
        PersonaJuridicaEntity? i = await IPersona.SelByIdAsync(f);
        if (i == null)
            return TypedResults.NotFound();
        return Results.Ok(i);
    }

    private static async Task<IResult>
        SelAllAsync(
            [AsParameters] PersonaJuridicaFilter f,
            IPersonaJuridicaService IPersona)
    {
        var r = await IPersona.SelAllAsync(f);
        return Results.Ok(r);
    }







}


