///<summary>
///
///</summary>
///<remarks>
///</remarks>
///<history>
/// t[Jonatan Abregu]	16/11/2021	Created
///</history>
namespace Mozo.Domain.Urbano;


[Serializable]
public class ProyectoEntity : BaseEntity
{


    public int? CoProyecto { get; set; }

    public string? NoProyecto { get; set; }
    public string? NoDireccion { get; set; }
    public string? NuPartida { get; set; }
    public List<EtapaEntity>? EtapaLst { get; set; }
}