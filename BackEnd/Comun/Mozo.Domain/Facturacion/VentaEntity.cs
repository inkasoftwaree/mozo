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
namespace Mozo.Domain.Facturacion;


[Serializable]
public partial class VentaEntity : BaseEntity
{

    public int? CoVenta { get; set; }
    public int? CoLocal { get; set; }
    public int? CoComprobantePago { get; set; }
    public string? NuSerie { get; set; }
    public int? NuDocumento { get; set; }
    public string? FeVenta { get; set; }
    public string? FeVencimiento { get; set; }
    public int? CoMoneda { get; set; }
    public int? CoTipoCambio { get; set; }
    public int? CoCliente { get; set; }
    public decimal? SsPrecio { get; set; }
    public decimal? SsImpuesto { get; set; }
    public decimal? SsDescuento { get; set; }
    public int? NuNotaSalida { get; set; }
    public int? CoModoPago { get; set; }
    public int? CoMedioPago { get; set; }
    public string? TxDescripcion { get; set; }

}
public partial class VentaEntity
{
    public string? NoModoPago { get; set; }
    public string? NoMedioPago { get; set; }
    public string? NoMoneda { get; set; }
    public string? NoMonedaSigla { get; set; }

    public TipoCambioEntity? TipoCambio { get; set; }
    public EntidadEntity? Cliente { get; set; }

}