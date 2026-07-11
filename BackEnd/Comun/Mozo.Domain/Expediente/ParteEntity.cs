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
public class ParteEntity : BaseEntity //<ParteModel>
{


    public int? CoExpediente { get; set; }



    public int? CoParte { get; set; }



    public int? CoTipoParte { get; set; }



    public int? NuOrden { get; set; }



    public int? CoPersona { get; set; }

    public string? NoTipoParte { get; set; }

    public string? NoParte { get; set; }
}