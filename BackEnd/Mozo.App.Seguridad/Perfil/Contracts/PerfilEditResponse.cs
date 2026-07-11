namespace Mozo.App.Seguridad.Perfil.Contracts;

/// <summary>
/// DTO plano para traer un Perfil a editar (GET SelById / SelDefault). PK + campos editables + FK id.
/// </summary>
public sealed class PerfilEditResponse
{
    public int CoPerfil { get; set; }
    public int? CoModulo { get; set; }
    public string? NoPerfil { get; set; }
    public bool? FlDefault { get; set; }
    public bool? FlAdmin { get; set; }
}
