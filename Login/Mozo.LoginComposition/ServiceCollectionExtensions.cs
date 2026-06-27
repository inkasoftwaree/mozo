using Microsoft.Extensions.DependencyInjection;

using Mozo.LoginBusiness;
using Mozo.LoginData;

namespace Mozo.LoginComposition;

public static class ServiceCollectionExtensions
{
    public static IServiceCollection LoginComposition(this IServiceCollection services)
    {
        services.AddScoped<IEmpresaData, EmpresaData>();
        services.AddScoped<IEmpresaBusiness, EmpresaBusiness>();

        services.AddScoped<IIngresoData, IngresoData>();
        services.AddScoped<IIngresoBusiness, IngresoBusiness>();

        services.AddScoped<IMenuData, MenuData>();
        services.AddScoped<IMenuBusiness, MenuBusiness>();

        services.AddScoped<IModuloData, ModuloData>();
        services.AddScoped<IModuloBusiness, ModuloBusiness>();

        services.AddScoped<IModuloUsuarioData, ModuloUsuarioData>();
        services.AddScoped<IModuloUsuarioBusiness, ModuloUsuarioBusiness>();

        services.AddScoped<IPaginaData, PaginaData>();
        services.AddScoped<IPaginaBusiness, PaginaBusiness>();

        services.AddScoped<IPerfilPaginaData, PerfilPaginaData>();
        services.AddScoped<IPerfilPaginaBusiness, PerfilPaginaBusiness>();

        services.AddScoped<IUsuarioData, UsuarioData>();
        services.AddScoped<IUsuarioBusiness, UsuarioBusiness>();

        return services;
    }
}

