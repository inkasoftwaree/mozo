///<summary>
///
///</summary>
///<remarks>
///</remarks>
///<history>
/// t[Jonatan Abregu]	10-04-2020	Created
///</history>
namespace Mozo.Domain.Condominio;


[Serializable]
public class EdificioEntity : BaseEntity //<EdificioModel>
{
    public int? CoEdificio { get; set; }
    public int? CoCondominio { get; set; }
    public string? NoCondominio { get; set; }
    public string? NoEdificio { get; set; }
    public string? NuEdificio { get; set; }
    public IEnumerable<PeriodoEntity>? PeriodoCol { get; set; }
    public IEnumerable<ServicioEntity>? ServicioCol { get; set; }
    public int? CoTipoPredio { get; set; }
    public int? CoTabEdificio { get; set; }
}