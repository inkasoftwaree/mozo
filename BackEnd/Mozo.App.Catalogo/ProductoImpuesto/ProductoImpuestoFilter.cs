using Mozo.Shared.Contract;
namespace Mozo.App.Catalogo.ProductoImpuesto;

public record ProductoImpuestoFilter : BaseFilter
{
    public int? CoProductoImpuesto { get; set; }
}
