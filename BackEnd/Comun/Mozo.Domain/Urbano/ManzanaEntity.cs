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
public class ManzanaEntity : BaseEntity
{


    public int? CoProyecto { get; set; }



    public int? CoEtapa { get; set; }



    public int? CoManzana { get; set; }

    public string? NoManzana { get; set; }
}