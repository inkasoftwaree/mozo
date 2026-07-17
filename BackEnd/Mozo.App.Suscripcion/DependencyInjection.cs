using Microsoft.Extensions.DependencyInjection;
using Mozo.App.Suscripcion.AccesoModulo;
using Mozo.App.Suscripcion.Plan;
using Mozo.App.Suscripcion.PlanModulo;
using Mozo.App.Suscripcion.PlanPrecio;
using Mozo.App.Suscripcion.Suscripcion;
using Mozo.App.Suscripcion.SuscripcionMovimiento;
using Mozo.App.Suscripcion.SuscripcionPago;

namespace Mozo.App.Suscripcion;

public static class DependencyInjection
{
    public static IServiceCollection AddSuscripcion(this IServiceCollection services)
    {
        services.AddScoped<IPlanService, PlanService>();
        services.AddScoped<IPlanModuloService, PlanModuloService>();
        services.AddScoped<IPlanPrecioService, PlanPrecioService>();
        services.AddScoped<ISuscripcionService, SuscripcionService>();
        services.AddScoped<ISuscripcionMovimientoService, SuscripcionMovimientoService>();
        services.AddScoped<ISuscripcionPagoService, SuscripcionPagoService>();
        services.AddScoped<IAccesoModuloService, AccesoModuloService>();

        return services;
    }
}
