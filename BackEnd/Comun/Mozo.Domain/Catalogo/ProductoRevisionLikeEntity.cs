///<summary>
///
///</summary>
///<remarks>
///</remarks>
///<history>
/// t[Jonatan Abregu]	12/08/2022	Created
///</history>
namespace Mozo.Domain.Catalogo;


[Serializable()]
public class ProductoRevisionLikeEntity : BaseEntity //<ProductoRevisionLikeModel>
{
    public int? CoProductoRevisionLike { get; set; }
    public int? CoProductoRevision { get; set; }
    public int? NuYes { get; set; }
    public int? NuNot { get; set; }
}