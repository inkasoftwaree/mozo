///<summary>
///
///</summary>
///<remarks>
///</remarks>
///<history>
/// t[Jonatan Abregu]	18-04-2020	Created
///</history>
namespace Mozo.Model.Maestro;

public record EntidadRoFilterDto : BaseFilterDto //PersonaTipoFilter>
{
    public int? CoModulo { get; set; }
    public int? CoEntidad { get; set; }
    public int? CoEmpresa { get; set; }
    public int? CoRolNegocio { get; set; }
}
[Serializable]
public partial class EntidadRolModel : BaseModel //<PersonaTipoModel>
{
    public int? CoEntidadRol { get; set; }
    public int? CoEmpresa { get; set; }    
    public int? CoEntidad { get; set; }
    public int? CoModulo { get; set; }
    public int? CoRolNegocio { get; set; }
   
}
public partial class EntidadRolModel
{

}