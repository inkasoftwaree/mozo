using Mozo.Shared.Contract;
namespace Mozo.App.Catalogo.ProductoAtributo;

public record ProductoAtributoFilter : BaseFilter
{
    public int? CoProductoAtributo { get; set; }
}
