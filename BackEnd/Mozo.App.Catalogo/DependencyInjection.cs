using Microsoft.Extensions.DependencyInjection;
using Mozo.App.Catalogo.Atributo;
using Mozo.App.Catalogo.Producto;
using Mozo.App.Catalogo.ProductoAtributo;
using Mozo.App.Catalogo.ProductoImpuesto;
using Mozo.App.Catalogo.ProductoPrecio;
using Mozo.App.Catalogo.ProductoStock;

namespace Mozo.App.Catalogo;

public static class DependencyInjection
{
    public static IServiceCollection AddCatalogo(this IServiceCollection services)
    {
        services.AddScoped<IProductoService, ProductoService>();
        services.AddScoped<IAtributoService, AtributoService>();
        services.AddScoped<IProductoAtributoService, ProductoAtributoService>();
        services.AddScoped<IProductoImpuestoService, ProductoImpuestoService>();
        services.AddScoped<IProductoPrecioService, ProductoPrecioService>();
        services.AddScoped<IProductoStockService, ProductoStockService>();

        return services;
    }
}
