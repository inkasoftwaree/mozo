using Mozo.Shared.Contract;

namespace Mozo.App.Suscripcion.SuscripcionPago.Contracts;

public record SuscripcionPagoFilter : BaseFilter
{
    public int? CoSuscripcion { get; set; }
    public int? CoSuscripcionPago { get; set; }
}
