using Mozo.Shared.Contract;

namespace Mozo.App.Notificacion.Notificacion.Contracts;

public record NotificacionFilter : BaseFilter
{
    public long CoNotificacion { get; set; }
    public int? SoloNoLeidas { get; set; }   // 1 = solo no leidas, 0/null = todas
}
