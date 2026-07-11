///<summary>
///
///</summary>
///<remarks>
///</remarks>
///<history>
/// t[-]	09/04/2021	Created
///</history>
namespace Mozo.Domain.Matricula;


[Serializable]
public class ProgramaPensionEntity : BaseEntity
{


    public int? CoProgramaPension { get; set; }



    public int? CoPrograma { get; set; }

    public decimal? SsMonto { get; set; }
    public string? FeVencimiento { get; set; }




    public int? CoTipoPension { get; set; }

    public string? NoTipoPension { get; set; }


    public int? NuOrdenTipoPension { get; set; }



    public int? FlPago { get; set; }



    public int? CoMatricula { get; set; }
}