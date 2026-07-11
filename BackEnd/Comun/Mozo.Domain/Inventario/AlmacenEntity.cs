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
public partial class AlmacenEntity : BaseEntity
{
    public int? CoAlmacen { get; set; }
    public string? NoAlmacen { get; set; }
    public int? CoLocal { get; set; }
    public int? FlPrincipal { get; set; }
}
public partial class AlmacenEntity
{
    public string? NoLocal { get; set; }
}