///<summary>
///
///</summary>
///<remarks>
///</remarks>
///<history>
/// t[-]	25/03/2021	Created
///</history>
namespace Mozo.Domain.Matricula;



[Serializable]
public class ProgramaNotaEntity : BaseEntity
{
    public int? CoProgramaNota { get; set; }
    public int? CoTipoNota { get; set; }
    public int? CoPrograma { get; set; }
    public decimal? PqPeso { get; set; }
    public string? NoTipoNota { get; set; }
    public string? NoTipoNotaSigla { get; set; }
    public int? NuOrdenTipoNota { get; set; }
    public string? TxDescripcion { get; set; }
    public int? NuNota { get; set; }
    public int? CoMatriculaNota { get; set; }
    public int? CoMatricula { get; set; }

}