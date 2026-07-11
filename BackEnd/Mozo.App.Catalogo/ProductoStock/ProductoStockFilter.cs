using Mozo.Shared.Contract;

namespace Mozo.App.Catalogo.ProductoStock;

public record ProductoStockFilter : BaseFilter
{
    public int? CoProductoStock { get; set; }
}
