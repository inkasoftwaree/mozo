///<summary>
///
///</summary>
///<remarks>
///</remarks>
///<history>
/// t[Jonatan Abregu]	18-04-2020	Created
///</history>
namespace Mozo.Model.Maestro;

public record EntidadDocumentoFilterDto : BaseFilterDto //PersonaTipoFilter>
{
    public int? CoEntidadDocumento { get; set; }
    public int? CoEntidad { get; set; }
}

[Serializable]
public partial class EntidadDocumentoModel : BaseModel //<PersonaTipoModel>
{
    public int? CoEntidadDocumento { get; set; }
    public int? CoEntidad { get; set; }    
    public int? CoDocumentoIdentidad { get; set; }
    public string? NuDocumento { get; set; }
    public int? FlDefault { get; set; }
   
}
public partial class EntidadDocumentoModel
{

}