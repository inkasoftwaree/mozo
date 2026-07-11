using Mozo.Shared.Contract;

namespace Mozo.App.Seguridad.Menu.Contracts;

public record MenuFilter : BaseFilter
{
    public int? CoModulo { get; set; }
    public int? CoUsuario { get; set; }
    public int? CoMenu { get; set; }
}
