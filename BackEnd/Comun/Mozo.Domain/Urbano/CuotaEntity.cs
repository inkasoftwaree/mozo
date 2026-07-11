using Mozo.Domain.Maestro;

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
public partial class CuotaEntity : BaseEntity //<CuotaModel>
{
    public int? CoProyecto { get; set; }
    public int? CoCredito { get; set; }

    public int? CoCuota { get; set; }
    public int? CoCuotaAnterior { get; set; }

    public int? NuPeriodo { get; set; }

    public decimal? SsSaldoCapital { get; set; }
    public decimal? SsAmortizacion { get; set; }
    public decimal? SsInteres { get; set; }
    public decimal? SsCuota { get; set; }
    public decimal? SsComision { get; set; }
    public decimal? SsCuotaTotal { get; set; }
    public decimal? SsAbono { get; set; }
    public string? FeVencimiento { get; set; }
    public string? TxDescripcion { get; set; }
    public decimal? SsCuotaPago { get; set; }

    public int? CoEtapa { get; set; } /*Campo que falta añadir - error de diseño*/
}

/*Reporte*/
public partial class CuotaEntity
{
    public EntidadEntity? Cliente { get; set; }
    public CreditoResumenEntity? CreditoResumen { get; set; }
    public CuotaResumenEntity? CuotaResumen { get; set; }

    public LoteEntity? Lote { get; set; }


    public DocPagoEntity? DocCuotaDetalle { get; set; }
    public CuotaDetalleEntity? CuotaDetalle { get; set; }
    public List<CuotaDetalleEntity> CuotaDetalleLst { get; set; } = new();





}

