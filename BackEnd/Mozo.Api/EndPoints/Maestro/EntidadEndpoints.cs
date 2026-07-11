using Mozo.Api.Abstractions;
using Mozo.App.Maestro.Entidad;
using Mozo.Domain.Maestro;


namespace Mozo.Api.Maestro;


///<summary>
/// Endpoints para gestión de Entidad
///</summary>
///<history>
/// Create by Jonatan Abregu
///</history>
public sealed class EntidadEndpoints : IEndpoint
{
    public string Prefix => "/maestro/entidad";

    public void MapEndpoint(RouteGroupBuilder g)
    {
        g.WithSecurity();

        g.MapPatch("/state", UpdateStateByIdAsync)
            .WithResponsesValue<int>(StatusCodes.Status200OK)
            .Produces(StatusCodes.Status404NotFound)
            .WithDescription("Activar o desactivar una Entidad");

        g.MapDelete("/", DeleteByIdAsync)
            .WithResponsesValue<int>(StatusCodes.Status200OK)
            .Produces(StatusCodes.Status404NotFound)
            .WithDescription("Eliminar una Entidad");
    }



    private static async Task<IResult>
    UpdateStateByIdAsync(
       EntidadEntity m,
       IEntidadService service)
    {
        int filas = await service.UpdateStateByIdAsync(m);
        return filas > 0 ? Results.Ok(filas) : Results.NotFound();
    }

    private static async Task<IResult> DeleteByIdAsync(
        [AsParameters] EntidadFilter f,
        IEntidadService service)
    {
        int filas = await service.DeleteByIdAsync(f);
        return filas > 0 ? Results.Ok(filas) : Results.NotFound();
    }


}