///<summary>
///
///</summary>
///<remarks>
///</remarks>
///<history>
/// t[Jonatan Abregu]	10-04-2020	Created
///</history>
namespace Mozo.Domain.Condominio;



[Serializable]
public class CondominioEntity : BaseEntity
{
    public int? CoCondominio { get; set; }
    public string? NoCondominio { get; set; }
    public string? NoDireccion { get; set; }
    public int? CoTipoPredio { get; set; }
    public List<EdificioEntity>? EdificioCol { get; set; }
}