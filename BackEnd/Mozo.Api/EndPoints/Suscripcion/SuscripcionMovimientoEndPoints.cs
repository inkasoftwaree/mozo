using Mozo.Api.Abstractions;
using Mozo.App.Suscripcion.SuscripcionMovimiento;
using Mozo.App.Suscripcion.SuscripcionMovimiento.Contracts;

namespace Mozo.Api.Suscripcion;

///<summary>
/// Endpoints de consulta del historial de movimientos de una Suscripción
///</summary>
public sealed partial class SuscripcionMovimientoEndPoints : IEndpoint
{
    public string Prefix => "/suscripcion/suscripcionmovimiento";

    public void MapEndpoint(RouteGroupBuilder g)
    {
        g.WithSecurity();

        g.MapGet("/all", SelAllBySuscripcionAsync)
            .WithResponses<IEnumerable<SuscripcionMovimientoListItem>>(StatusCodes.Status200OK)
            .WithDescription("Obtener el historial de movimientos de una Suscripción");
    }
}

public sealed partial class SuscripcionMovimientoEndPoints
{
    private static async Task<IResult>
        SelAllBySuscripcionAsync([AsParameters] SuscripcionMovimientoFilter f, ISuscripcionMovimientoService ISuscripcionMovimiento)
    {
        var r = await ISuscripcionMovimiento.SelAllBySuscripcionAsync(f);
        return Results.Ok(r);
    }
}
