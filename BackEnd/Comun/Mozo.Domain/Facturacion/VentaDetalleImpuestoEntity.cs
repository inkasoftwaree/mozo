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
public partial class VentaDetalleImpuestoEntity : BaseEntity //<VentaDetalleImpuestoModel>
{


    public int? CoVentaDetalleImpuesto { get; set; }
    public int? CoVentaDetalle { get; set; }
    public int? CoImpuesto { get; set; }
    public int? CoImpuestoHijo { get; set; }

    public decimal? SsMonto { get; set; }
    public decimal? PqTaza { get; set; }
}

public partial class VentaDetalleImpuestoEntity
{


}