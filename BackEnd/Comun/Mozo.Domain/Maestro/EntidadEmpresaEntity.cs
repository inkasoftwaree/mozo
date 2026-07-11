///<summary>
///
///</summary>
///<remarks>
///</remarks>
///<history>
/// t[Jonatan Abregu]	18-04-2020	Created
///</history>
namespace Mozo.Domain.Maestro;



[Serializable]
public partial class EntidadEmpresaEntity : BaseEntity
{
    public int? CoEntidad { get; set; }
    public int? CoEmpresa { get; set; }
    public int? FlDefault { get; set; }

}
