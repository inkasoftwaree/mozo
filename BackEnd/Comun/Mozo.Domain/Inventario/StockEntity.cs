///<summary>
///
///</summary>
///<remarks>
///</remarks>
///<history>
/// t[Jonatan Abregu]	21/09/2021	Created
///</history>
namespace Mozo.Domain.Inventario;


[Serializable]
public partial class StockEntity : BaseEntity //<StockModel>
{

    public int? CoStock { get; set; }
    public int? CoAlmacen { get; set; }
    public int? CoProducto { get; set; }
    public int? QtUnidad { get; set; }
    public int? CoLocal { get; set; }
}

public partial class StockEntity
{


}