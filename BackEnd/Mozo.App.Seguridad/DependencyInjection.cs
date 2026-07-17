using Microsoft.Extensions.DependencyInjection;
using Mozo.App.Seguridad.Empresa;
using Mozo.App.Seguridad.EmpresaModulo;
using Mozo.App.Seguridad.Menu;
using Mozo.App.Seguridad.Modulo;
using Mozo.App.Seguridad.ModuloUsuario;
using Mozo.App.Seguridad.Pagina;
using Mozo.App.Seguridad.Perfil;
using Mozo.App.Seguridad.PerfilPagina;
using Mozo.App.Seguridad.Usuario;

namespace Mozo.App.Seguridad;

public static class DependencyInjection
{
    public static IServiceCollection AddSeguridad(this IServiceCollection services)
    {
        services.AddScoped<IModuloService, ModuloService>();
        services.AddScoped<IUsuarioService, UsuarioService>();
        services.AddScoped<IPerfilService, PerfilService>();
        services.AddScoped<IMenuService, MenuService>();
        services.AddScoped<IPaginaService, PaginaService>();
        services.AddScoped<IPerfilPaginaService, PerfilPaginaService>();
        services.AddScoped<IModuloUsuarioService, ModuloUsuarioService>();
        services.AddScoped<IEmpresaModuloService, EmpresaModuloService>();
        services.AddScoped<IEmpresaService, EmpresaService>();
        //services.AddScoped<IEmpresaBusiness, EmpresaBusiness>();

        return services;
    }
}
