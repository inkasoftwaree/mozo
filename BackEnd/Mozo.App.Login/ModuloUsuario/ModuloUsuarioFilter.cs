using Mozo.Shared.Contract;

namespace Mozo.App.Login.ModuloUsuario;

public record ModuloUsuarioFilter : BaseFilter
{
    public int? CoModuloUsuario { get; set; }
    public int? CoModulo { get; set; }
    public int? CoUsuario { get; set; }
}
