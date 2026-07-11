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
public partial class CreditoResumenEntity : BaseEntity //<CreditoResumenModel>
{
    public decimal? SsCuotaPago { get; set; }
    public decimal? SsInteresPago { get; set; }
    public decimal? SsAmortizacionPago { get; set; }
    public decimal? SsAbonoPago { get; set; }
    public decimal? SsMoraPago { get; set; }
    public int? QtCuotaPago { get; set; }
    public int? QtCuotaVencido { get; set; }

}
