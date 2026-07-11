using Mozo.Domain.Maestro;

///<summary>
///
///</summary>
///<remarks>
///</remarks>
///<history>
/// t[Jonatan Abregu]	10-04-2020	Created
///</history>
namespace Mozo.Domain.Expediente;




[Serializable]
public class DocumentoEntity : BaseEntity //<DocumentoModel>
{
    //  public string? NoTipoDocumento { get; set; }


    public int? NuDocumento { get; set; }



    public int? NuAnno { get; set; }

    public string? FeDocumento { get; set; }



    public int? CoExpediente { get; set; }



    public int? CoDocumento { get; set; }

    // public string? FeDocumento { get; set; }


    public int? CoTipoDocumento { get; set; }

    public string? TxAsunto { get; set; }

    public ArchivoEntity? Archivo { get; set; }

    public List<NotificacionEntity>? NotificacionCol { get; set; }
}