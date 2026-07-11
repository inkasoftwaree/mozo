///<summary>
///
///</summary>
///<remarks>
///</remarks>
///<history>
/// t[Jonatan Abregu]	02/03/2022	Created
///</history>
namespace Mozo.Domain.Urbano;



[Serializable]
public partial class DocPagoEntity : BaseEntity
{
    public int? CoProyecto { get; set; }
    public int? CoDocPago { get; set; }
    public int? CoTipoDocumento { get; set; }
    public int? Co { get; set; }
    public string? FePago { get; set; }
    public int? CoMedioPago { get; set; }



    public int? CoBanco { get; set; }

    public string? NuOperacion { get; set; }



    public int? CoDocumentoTributario { get; set; }

    public string? FeDocumento { get; set; }
    public string? NuDocumento { get; set; }
    public string? TxDescripcion { get; set; }
}

public partial class DocPagoEntity
{
    public string? NoMedioPago { get; set; }
    public string? NoBanco { get; set; }


    public string? NoTipoDocumentoTributario { get; set; }


}