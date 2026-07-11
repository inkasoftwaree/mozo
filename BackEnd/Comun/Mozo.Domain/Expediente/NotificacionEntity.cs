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
public class NotificacionEntity : BaseEntity //<NotificacionModel>
{


    public int? CoExpediente { get; set; }



    public int? CoNotificacion { get; set; }



    public int? CoDocumento { get; set; }

    public string? TxDescripcion { get; set; }
    public string? BlNotificacion { get; set; }
    public string? FeNotificacion { get; set; }



    public int? CoNotificado { get; set; }

    public string? NoVinculo { get; set; }
    public ArchivoEntity? Archivo { get; set; }

    public string? NoNotificado { get; set; }



    public int? NuDocumento { get; set; }



    public int? NuAnnoDocumento { get; set; }



    public int? NuNotificacion { get; set; }



    public int? NuAnno { get; set; }
}