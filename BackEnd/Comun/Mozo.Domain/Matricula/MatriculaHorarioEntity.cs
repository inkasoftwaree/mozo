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
public partial class MatriculaHorarioEntity : BaseEntity //<MatriculaHorarioModel>
{


    public int? CoProgramaHorario { get; set; }



    public int? CoMatriculaHorario { get; set; }



    public int? CoMatricula { get; set; }



    public int? CoPrograma { get; set; }




    public int? CoPaquete { get; set; }


    public int? FlAsistio { get; set; }

    public string? NoAlumno { get; set; }

    public string? NoTipoHorario { get; set; }


    public int? NuOrdenTipoHorario { get; set; }

    public int? CoTipoHorario { get; set; }
}

public partial class MatriculaHorarioEntity
{
    public string? NoPaquete { get; set; }
    public string? NoPrograma { get; set; }
}