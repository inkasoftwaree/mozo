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
public partial class InventarioEntity : BaseEntity //<InventarioModel>
{
    public int? CoInventario { get; set; }

    public int? CoCompra { get; set; }

    public int? CoVenta { get; set; }

    public int? CoTipoMovimiento { get; set; }

}
public partial class InventarioEntity
{


}