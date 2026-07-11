///<summary>
///
///</summary>
///<remarks>
///</remarks>
///<history>
/// t[Jonatan Abregu]	22/05/2022	Created
///</history>
namespace Mozo.Domain.Catalogo;



[Serializable]
public class ProductoTerminadoEntity : BaseEntity //<ProductoTerminadoModel>
{
    public int? CoProductoTerminado { get; set; }
    public int? NuOrden { get; set; }
    public int? CoProductoPadre { get; set; }
    public int? CoProducto { get; set; }
    public int? QtProducto { get; set; }
}