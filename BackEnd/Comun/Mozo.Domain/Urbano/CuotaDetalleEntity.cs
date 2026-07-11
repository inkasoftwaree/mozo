///<summary>
///
///</summary>
///<remarks>
///</remarks>
///<history>
/// t[Jonatan Abregu]	05/02/2022	Created
///</history>
namespace Mozo.Domain.Urbano;

[Serializable]
public partial class CuotaDetalleEntity : BaseEntity
{
    public int? CoProyecto { get; set; }

    public int? CoCredito { get; set; }

    public int? CoCuota { get; set; }

    public int? CoCuotaDetalle { get; set; }

    public int? CoTipoCuotaDetalle { get; set; }

    public int? CoDocPagoCuotaDetalle { get; set; }

    public decimal? SsCuotaDetallePago { get; set; }

    public decimal? SsMora { get; set; }
    public decimal? SsSaldoCapital { get; set; }
}

public partial class CuotaDetalleEntity
{
    #region Property Query Fields

    public DocPagoEntity? DocCuotaDetalle { get; set; }

    #endregion
    #region Property Query Fields
    public string? NoTipoCuotaDetalle { get; set; }
    public int? QtCuotaDetalle { get; set; }
    public int? QtAbonoDetalle { get; set; }

    #endregion






}