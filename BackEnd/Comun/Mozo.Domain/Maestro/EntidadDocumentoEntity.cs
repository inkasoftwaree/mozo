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
public partial class EntidadDocumentoEntity : BaseEntity
{
    public int? CoEntidadDocumento { get; set; }
    public int? CoEntidad { get; set; }
    public int? CoDocumentoIdentidad { get; set; }
    public string? NuDocumento { get; set; }
    public int? FlDefault { get; set; }

}
