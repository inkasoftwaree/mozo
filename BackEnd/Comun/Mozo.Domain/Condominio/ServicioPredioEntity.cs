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
public class ServicioPredioEntity : BaseEntity //<ServicioPredioModel>
{
    public int? CoCondominio { get; set; }
    public int? CoEdificio { get; set; }
    public int? CoTipoServicio { get; set; }
    public int? CoTipoServicioPadre { get; set; }
    public int? CoTipoPredio { get; set; }
    public int? CoCuenta { get; set; }
    public int? NuOrden { get; set; }
    public string? NoTipoServicio { get; set; }
    public string? NoTipoServicioPadre { get; set; }
    public string? NoCalculo { get; set; }
    public int? CoCalculo { get; set; }
    public int? FlComprobantePago { get; set; }
    public int? CoPeriodo { get; set; }
    public int? CoServicioPredio { get; set; }
    public int? CoServicio { get; set; }
    public int? CoPredio { get; set; }
    public decimal? NuLecturaInicial { get; set; }
    public decimal? SsMontoConsumo { get; set; }
    public int? FlAcordadoInquilino { get; set; }

    public EdificioProcesoEntity? EdificioProceso { get; set; }
    public PredioProcesoEntity? PredioProceso { get; set; }

    // public int? NuPiso { get; set; }
    // public string? NuPredio { get; set; }
    // public string? NoCondominio { get; set; }
    // public string? NoEdificio { get; set; }
}