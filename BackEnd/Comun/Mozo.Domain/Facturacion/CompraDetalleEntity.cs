using Mozo.Domain.Catalogo;

///<summary>
///
///</summary>
///<remarks>
///</remarks>
///<history>
/// t[Jonatan Abregu]	21/09/2021	Created
///</history>
namespace Mozo.Domain.Facturacion;


[Serializable]
public partial class CompraDetalleEntity : BaseEntity
{
    public int? CoCompraDetalle { get; set; }
    public int? CoCompra { get; set; }
    public int? NuOrden { get; set; }
    public int? CoProducto { get; set; }
    public int? QtProducto { get; set; }
    public decimal? SsPrecioIngresado { get; set; }
    public decimal? SsPrecio { get; set; }
    public decimal? SsImpuesto { get; set; }
    public decimal? SsDescuento { get; set; }
    public decimal? PqDescuento { get; set; }
    public decimal? SsPrecioTotal { get; set; }
    public int? CoLocal { get; set; }
    public int? CoAlmacen { get; set; }
}

public partial class CompraDetalleEntity
{
    public string? NoImpuesto { get; set; }
    public string? NoImpuestoSigla { get; set; }
    public string? NoImpuestoValor { get; set; }
    public string? NoSerie { get; set; }
    public string? NoMonedaSigla { get; set; }
    public string? NoMoneda { get; set; }
    public ProductoEntity? Producto { get; set; }
}