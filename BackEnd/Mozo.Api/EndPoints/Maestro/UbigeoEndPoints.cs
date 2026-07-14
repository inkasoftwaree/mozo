using Mozo.Api.Abstractions;
using Mozo.App.Maestro.Ubigeo;
using Mozo.App.Maestro.Ubigeo.Contracts;
using Mozo.Domain.Maestro;

namespace Mozo.Api.Maestro;

public sealed partial class UbigeoEndPoints : IEndpoint
{
    public string Prefix => "/maestro/ubigeo";

    public void MapEndpoint(RouteGroupBuilder group)
    {
        group.MapGet("/nivel1", SelAllNivel1Async)
            .RequireAuthorization()
             .CacheOutput(x => x.Expire(TimeSpan.FromHours(24)).Tag("Ubigeo_nivel1")); ;

        group.MapGet("/nivel2", SelAllNivel2Async)
             .RequireAuthorization();

        group.MapGet("/nivel3", SelAllNivel3Async)
      .RequireAuthorization();
    }

}
public partial class UbigeoEndPoints
{
    private static async Task<IResult> SelAllNivel1Async([AsParameters] UbigeoFilter f, IUbigeoService IUbigeo)
    {
        IEnumerable<UbigeoOption> r = await IUbigeo.SelAllNivel1Async(f);
        return Results.Ok(r);
    }

    private static async Task<IResult> SelAllNivel2Async([AsParameters] UbigeoFilter f, IUbigeoService IUbigeo)
    {
        IEnumerable<UbigeoOption> r = await IUbigeo.SelAllNivel2Async(f);
        return Results.Ok(r);
    }

    private static async Task<IResult> SelAllNivel3Async([AsParameters] UbigeoFilter f, IUbigeoService IUbigeo)
    {
        IEnumerable<UbigeoOption> r = await IUbigeo.SelAllNivel3Async(f);
        return Results.Ok(r);
    }







}

