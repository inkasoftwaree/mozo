using Mozo.Shared.Contract;

namespace Mozo.App.Catalogo.Producto;

public record ProductoFilter : BaseFilter
{
    public int? CoProducto { get; set; }
    public int? CoProveedorPrincipal { get; set; }
    public int? CoMarca { get; set; }

    // Paginación por cursor (SelAllActive)
    public int? CursorId { get; set; }
    public int? Direction { get; set; }
}
