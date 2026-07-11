///<summary>
///
///</summary>
///<remarks>
///</remarks>
///<history>
/// t[-]	19/03/2021	Created
///</history>
namespace Mozo.Domain.Matricula;



[Serializable]
public partial class PaqueteEntity : BaseEntity
{


    public int? CoPaquete { get; set; }

    public string? NoPaquete { get; set; }
    public string? FeInicio { get; set; }
    public string? FeFin { get; set; }
    public decimal? SsMatricula { get; set; }

    public int? CoCategoria { get; set; }
    public string? NoCategoria { get; set; }
    public string? TxDescripcion { get; set; }



    public int? CoGrado { get; set; }

    public string? NoGrado { get; set; }

    public List<ProgramaEntity>? ProgramaList { get; set; }


    public List<PaqueteProgramaEntity>? PaqueteProgramaList { get; set; }

    public int? FlPublicoGeneral { get; set; }
}

public partial class PaqueteEntity
{
    public decimal? SsMonto { get; set; }
}