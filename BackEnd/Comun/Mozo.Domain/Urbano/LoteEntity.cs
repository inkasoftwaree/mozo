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
public partial class LoteEntity : BaseEntity
{


    public int? CoProyecto { get; set; }



    public int? CoEtapa { get; set; }



    public int? CoCredito { get; set; }



    public int? CoLote { get; set; }

    public string? NoManzana { get; set; }
    public int? NuLote { get; set; }
    public decimal? NuArea { get; set; }
    public decimal? NuAreaTechada { get; set; }
    public decimal? NuAreaLibre { get; set; }
    public decimal? SsCosto { get; set; }
    public decimal? SsBono { get; set; }
    public string? NoProyecto { get; set; }
    public string? NoEtapa { get; set; }



    public int? NuLoteIni { get; set; }



    public int? NuLoteFin { get; set; }



    public int? FlRango { get; set; }



    public decimal? NuMtFrente { get; set; }



    public decimal? NuMtDerecha { get; set; }



    public decimal? NuMtIzquierda { get; set; }



    public decimal? NuMtFondo { get; set; }



    public decimal? NuMtPerimetro { get; set; }


    public string? TxDescripcion { get; set; }



    public int? CoEtapaCosto { get; set; }

    public int? FlCostoManual { get; set; }


}

public partial class LoteEntity
{
    public string? NoCaracteristica { get; set; }
    public string? NoColor { get; set; }


    public int? FlBono { get; set; }
    public int? FlVendido { get; set; }

}