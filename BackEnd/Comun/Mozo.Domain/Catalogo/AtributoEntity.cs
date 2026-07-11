

///<summary>
///
///</summary>
///<remarks>
///</remarks>
///<history>
/// t[Jonatan Abregu]	19/07/2022	Created
///</history>
namespace Mozo.Domain.Catalogo;



[Serializable]
public partial class AtributoEntity : BaseEntity
{
    public int? CoAtributo { get; set; }
    public int? NuOrden { get; set; }
    public string? NoAtributo { get; set; }
    public int? CoTipoDato { get; set; }
    public int? CoCategoria { get; set; }
    public int? FlObligatorio { get; set; }
    public int? FlFiltrable { get; set; }
    public int? FlDescriptivo { get; set; }
}

//NoFamilia
public partial class AtributoEntity
{

}