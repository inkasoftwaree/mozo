using Mozo.Domain.Contabilidad;
using Mozo.Domain.Maestro;

///<summary>
///
///</summary>
///<remarks>
///</remarks>
///<history>
/// t[Jonatan Abregu]	21/09/2021	Created
///</history>
namespace Mozo.Domain.Catalogo;


public partial class ProductoEntity : BaseEntity
{
    public int? CoProducto { get; set; }
    public string? NoProducto { get; set; }
    public string? NoModelo { get; set; }
    public int? CoMarca { get; set; }
    public int? CoLaboratorio { get; set; }
    public int? CoUnidadMedidaInventario { get; set; }
    public int? CoUnidadMedidaCompra { get; set; }
    public int? CoUnidadMedidaVenta { get; set; }
    public int? CoProveedorPrincipal { get; set; }
    public decimal? SsFactorVenta { get; set; }
    public decimal? SsFactorCompra { get; set; }
    public string? NoCodigoFiscal { get; set; }
    public string? NoCodigoInterno { get; set; }



    public int? CoTipo { get; set; }
    public int? CoCategoria { get; set; }
    public int? CoCategoriaHijo { get; set; }
    public int? FlImpuesto { get; set; }
    public int? FlInventario { get; set; }
    public int? FlImpuestoExento { get; set; }
    public string? TxDescripcionCorta { get; set; }


}

public partial class ProductoEntity
{
    #region Field join table primary


    public string? NoEstadoAlmacen { get; set; }



    public string? NoMarca { get; set; }
    public string? NoLaboratorio { get; set; }
    public string? NoMoneda { get; set; }
    public string? NoMonedaSigla { get; set; }
    public string? NoImpuesto { get; set; }
    public string? NoImpuestoSigla { get; set; }
    public string? NoUnidadInventario { get; set; }
    public string? NoUnidadCompra { get; set; }
    public string? NoUnidadVenta { get; set; }
    public string? NoTipoPrecio { get; set; }
    public decimal? SsPrecioVenta { get; set; }
    public decimal? SsPrecioVentaMinimo { get; set; }


    public string? NoProductoCompleto =>
        (NoProducto != null ? "/ " + NoProducto : "") +
        (NoMarca != null ? "/ " + NoMarca : "") +
        (NoModelo != null ? "/ " + NoModelo : "");



    public string? NoProductoCompletoCorto =>
      (NoProducto != null ? NoProducto : "") +
      (NoMarca != null ? "/ " + NoMarca : "") +
      (NoModelo != null ? "/ " + NoModelo : "");

    #endregion

    public EntidadEntity? Proveedor { get; set; }
    public ProductoStockEntity? ProductoStock { get; set; }
    public List<ProductoPrecioEntity>? ProductoPrecioLst { get; set; }

    public TipoCambioEntity? TipoCambio { get; set; }




}