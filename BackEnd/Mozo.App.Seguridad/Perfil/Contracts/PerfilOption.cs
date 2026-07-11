namespace Mozo.App.Seguridad.Perfil.Contracts;

/// <summary>
/// DTO plano para el combo/dropdown de Perfiles activos (SelAllActive). Id + nombre.
/// </summary>
public sealed class PerfilOption
{
    public int CoPerfil { get; set; }
    public string? NoPerfil { get; set; }
}
