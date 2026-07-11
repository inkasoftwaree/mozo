///<summary>
///
///</summary>
///<remarks>
///</remarks>
///<history>
/// t[Jonatan Abregu]	18/09/2022	Created
///</history>
namespace Mozo.Domain.Catalogo;



[Serializable()]
public partial class ProductoImpuestoEntity : BaseEntity
{
    public int? CoProductoImpuesto { get; set; }
    public int? CoProducto { get; set; }
    public int? CoImpuesto { get; set; }
    public int? CoImpuestoHijo { get; set; }
    public decimal? PqTaza { get; set; }
}
public partial class ProductoImpuestoEntity
{


}