using Mozo.Api.Abstractions;
using Mozo.App.Suscripcion.AccesoModulo;
using Mozo.App.Suscripcion.AccesoModulo.Contracts;

namespace Mozo.Api.Suscripcion;

///<summary>
/// Endpoints de consulta de acceso a módulos según la suscripción vigente de la empresa
///</summary>
public sealed partial class AccesoModuloEndPoints : IEndpoint
{
    public string Prefix => "/suscripcion/accesomodulo";

    public void MapEndpoint(RouteGroupBuilder g)
    {
        g.WithSecurity();

        g.MapGet("/habilitado", HabilitadoAsync)
            .WithResponsesValue<bool>(StatusCodes.Status200OK)
            .WithDescription("Verificar si un módulo está habilitado para la empresa");

        g.MapGet("/all", SelHabilitadosAsync)
            .WithResponses<IEnumerable<AccesoModuloItem>>(StatusCodes.Status200OK)
            .WithDescription("Obtener los módulos habilitados para la empresa");
    }
}

public sealed partial class AccesoModuloEndPoints
{
    private static async Task<IResult>
        HabilitadoAsync([AsParameters] AccesoModuloFilter f, IAccesoModuloService IAccesoModulo)
    {
        bool habilitado = await IAccesoModulo.HabilitadoAsync(f);
        return Results.Ok(habilitado);
    }

    private static async Task<IResult>
        SelHabilitadosAsync([AsParameters] AccesoModuloFilter f, IAccesoModuloService IAccesoModulo)
    {
        var r = await IAccesoModulo.SelHabilitadosAsync(f);
        return Results.Ok(r);
    }
}
