using Mozo.Shared.Contract;

namespace Mozo.App.Seguridad.Usuario.Contracts;

public record UsuarioFilter : BaseFilter
{
    public int? CoEntidad { get; set; }
    public int? CoUsuario { get; set; }
    public int? CoEmpresa { get; set; }
    public string? NoIp { get; set; }
    public string? NoUsuario { get; set; }
    public string? NoClave { get; set; }
    public string? NoUserAgent { get; set; }
}
