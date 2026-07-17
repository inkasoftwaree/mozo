using Mozo.Shared.Contract;

namespace Mozo.App.Suscripcion.Suscripcion.Contracts;

public record SuscripcionFilter : BaseFilter
{
    public int? CoSuscripcion { get; set; }
    public int? CoEmpresa { get; set; }
    public int? CoEstado { get; set; }
}
