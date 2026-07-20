namespace Mozo.App.Notificacion.Notificacion.Contracts;

/// <summary>
/// Canal de entrega de una notificacion. Cada valor dirige logica de envio distinta
/// (cada canal tiene su propio sender), por eso se modela como enum en vez de texto
/// libre. El codigo (<see cref="ToSigla"/>) espeja la NoSigla del catalogo en
/// maestro.trftipogeneral.
/// </summary>
public enum CanalNotificacion
{
    InApp,
    Email,
    Whatsapp,
    Push
}

public static class CanalNotificacionExtensions
{
    public static string ToSigla(this CanalNotificacion c) => c switch
    {
        CanalNotificacion.InApp => "CANAL_IN_APP",
        CanalNotificacion.Email => "CANAL_EMAIL",
        CanalNotificacion.Whatsapp => "CANAL_WHATSAPP",
        CanalNotificacion.Push => "CANAL_PUSH",
        _ => throw new ArgumentOutOfRangeException(nameof(c))
    };
}
