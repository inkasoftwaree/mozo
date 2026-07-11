using Mozo.Shared.Contract;

namespace Mozo.App.Seguridad.ModuloUsuario;

public record ModuloUsuarioFilter : BaseFilter //ModuloUsuarioFilter>
{

    public int? CoEmpresa { get; set; }
    public int? CoModulo { get; set; }
    public int? CoUsuario { get; set; }
    public int? CoModuloUsuario { get; set; }

}