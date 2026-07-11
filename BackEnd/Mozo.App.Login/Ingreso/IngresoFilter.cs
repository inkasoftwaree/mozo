using Mozo.Shared.Contract;

namespace Mozo.App.Login.Ingreso;

public record IngresoFilter : BaseFilter
{
    public int? CoIngreso { get; set; }
    public string? NoRefreshToken { get; set; }
}
