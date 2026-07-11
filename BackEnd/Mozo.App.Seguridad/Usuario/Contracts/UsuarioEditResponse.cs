namespace Mozo.App.Seguridad.Usuario.Contracts;

/// <summary>
/// DTO plano para traer un Usuario a editar (GET). PK + campos editables + FK id.
/// NO expone NoClave (hash de contraseña): jamás vuelve al cliente.
/// </summary>
public sealed class UsuarioEditResponse
{
    public int CoUsuario { get; set; }
    public int? CoEntidad { get; set; }
    public string? NoUsuario { get; set; }
    public string? NoEntidad { get; set; }
}
