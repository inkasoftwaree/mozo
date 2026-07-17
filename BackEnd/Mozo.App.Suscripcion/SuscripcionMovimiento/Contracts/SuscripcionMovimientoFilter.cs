using Mozo.Shared.Contract;

namespace Mozo.App.Suscripcion.SuscripcionMovimiento.Contracts;

public record SuscripcionMovimientoFilter : BaseFilter
{
    public int? CoSuscripcion { get; set; }
}
