using Microsoft.Extensions.DependencyInjection;
using Mozo.App.Notificacion.Notificacion;

namespace Mozo.App.Notificacion;

public static class DependencyInjection
{
    public static IServiceCollection AddNotificacion(this IServiceCollection services)
    {
        services.AddScoped<INotificacionService, NotificacionService>();
        return services;
    }
}
