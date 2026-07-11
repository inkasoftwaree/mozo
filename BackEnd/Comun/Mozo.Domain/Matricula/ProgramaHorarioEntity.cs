///<summary>
///
///</summary>
///<remarks>
///</remarks>
///<history>
/// t[-]	18/03/2021	Created
///</history>
namespace Mozo.Domain.Matricula;



[Serializable]
public class ProgramaHorarioEntity : BaseEntity //<ProgramaHorarioModel>
{


    public int? CoProgramaHorario { get; set; }



    public int? CoPrograma { get; set; }



    public int? CoTipoHorario { get; set; }

    public string? NoTipoHorario { get; set; }


    public int? NuOrdenTipoHorario { get; set; }

    public string? FeInicio { get; set; }
    public string? HoFinal { get; set; }
    public string? NoHorario { get; set; }
}