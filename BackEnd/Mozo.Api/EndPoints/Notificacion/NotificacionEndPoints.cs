using Mozo.Api.Abstractions;
using Mozo.App.Notificacion.Notificacion;
using Mozo.App.Notificacion.Notificacion.Contracts;
using Mozo.Shared.Models;

namespace Mozo.Api.Notificacion;

/// <summary>
/// Endpoints de la bandeja de notificaciones del usuario autenticado.
/// No expone emision: emitir es interno (otros modulos via INotificacionService).
/// </summary>
public sealed partial class NotificacionEndPoints : IEndpoint
{
    public string Prefix => "/notificacion";

    public void MapEndpoint(RouteGroupBuilder g)
    {
        g.WithSecurity();

        g.MapGet("/all", SelAllAsync)
            .WithResponses<PagedResult<NotificacionListItem>>(StatusCodes.Status200OK)
            .WithDescription("Bandeja paginada de notificaciones del usuario");

        g.MapGet("/count", CountNoLeidasAsync)
            .WithResponsesValue<int>(StatusCodes.Status200OK)
            .WithDescription("Cantidad de no leidas (badge de la campanita)");

        g.MapPatch("/read", MarcarLeidoAsync)
            .WithResponsesValue<int>(StatusCodes.Status200OK)
            .Produces(StatusCodes.Status404NotFound)
            .WithDescription("Marcar una notificacion como leida");

        g.MapPatch("/read-all", MarcarTodoLeidoAsync)
            .WithResponsesValue<int>(StatusCodes.Status200OK)
            .WithDescription("Marcar todas como leidas");

        g.MapDelete("/", DeleteByIdAsync)
            .WithResponsesValue<int>(StatusCodes.Status200OK)
            .Produces(StatusCodes.Status404NotFound)
            .WithDescription("Eliminar una notificacion (corregir un registro emitido por error)");
    }
}

public partial class NotificacionEndPoints
{
    private static async Task<IResult>
        SelAllAsync(
            [AsParameters] NotificacionFilter f,
            INotificacionService INotif)
    {
        return Results.Ok(await INotif.SelAllAsync(f));
    }

    private static async Task<IResult>
        CountNoLeidasAsync(
            INotificacionService INotif)
    {
        return Results.Ok(await INotif.CountNoLeidasAsync());
    }

    private static async Task<IResult>
        MarcarLeidoAsync(
            [AsParameters] NotificacionFilter f,
            INotificacionService INotif)
    {
        int filas = await INotif.MarcarLeidoAsync(f);
        return filas > 0 ? Results.Ok(filas) : Results.NotFound();
    }

    private static async Task<IResult>
        MarcarTodoLeidoAsync(
            INotificacionService INotif)
    {
        return Results.Ok(await INotif.MarcarTodoLeidoAsync());
    }

    private static async Task<IResult>
        DeleteByIdAsync(
            [AsParameters] NotificacionFilter f,
            INotificacionService INotif)
    {
        int filas = await INotif.DeleteByIdAsync(f);
        return filas > 0 ? Results.Ok(filas) : Results.NotFound();
    }
}
