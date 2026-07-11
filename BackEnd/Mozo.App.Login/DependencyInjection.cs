using Microsoft.Extensions.DependencyInjection;
using Mozo.App.Login.Empresa;
using Mozo.App.Login.Ingreso;
using Mozo.App.Login.Menu;
using Mozo.App.Login.Modulo;
using Mozo.App.Login.ModuloUsuario;
using Mozo.App.Login.Pagina;
using Mozo.App.Login.PerfilPagina;
using Mozo.App.Login.Usuario;

namespace Mozo.App.Login;

public static class DependencyInjection
{
    public static IServiceCollection AddLogin(this IServiceCollection services)
    {
        services.AddScoped<IModuloService, ModuloService>();
        services.AddScoped<IUsuarioService, UsuarioService>();
        services.AddScoped<IIngresoService, IngresoService>();
        services.AddScoped<IMenuService, MenuService>();
        services.AddScoped<IEmpresaService, EmpresaService>();
        services.AddScoped<IPaginaService, PaginaService>();
        services.AddScoped<IModuloUsuarioService, ModuloUsuarioService>();
        services.AddScoped<IPerfilPaginaService, PerfilPaginaService>();

        return services;
    }
}
