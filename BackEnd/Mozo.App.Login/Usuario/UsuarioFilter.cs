using Mozo.Shared.Contract;
namespace Mozo.App.Login.Usuario;

public record UsuarioFilter : BaseFilter
{
    public int? CoUsuario { get; set; }
    public int? CoEmpresa { get; set; }
    public string? NoUsuario { get; set; }
    public string? NoClave { get; set; }

    public string? NoIp { get; set; }


}
