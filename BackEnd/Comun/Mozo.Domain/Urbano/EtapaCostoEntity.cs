///<summary>
///
///</summary>
///<remarks>
///</remarks>
///<history>
/// t[Jonatan Abregu]	21/12/2021	Created
///</history>
namespace Mozo.Domain.Urbano;


[Serializable]
public class EtapaCostoEntity : BaseEntity
{


    public int? CoProyecto { get; set; }



    public int? CoEtapa { get; set; }



    public int? CoEtapaCosto { get; set; }

    public string? NoCaracteristica { get; set; }
    public decimal? SsCosto { get; set; }
    public string? NoColor { get; set; }
}