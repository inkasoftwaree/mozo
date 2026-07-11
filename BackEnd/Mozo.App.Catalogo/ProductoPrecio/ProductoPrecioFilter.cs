using Mozo.Shared.Contract;

namespace Mozo.App.Catalogo.ProductoPrecio;

public record ProductoPrecioFilter : BaseFilter
{
    public int? CoProductoPrecio { get; set; }
}
