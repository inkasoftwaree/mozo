using Mozo.Shared.Contract;

namespace Mozo.App.Seguridad.Perfil.Contracts;

/// <summary>
/// DTO plano para el listado/grid de Perfiles (SelAll, no paginado).
/// </summary>
public sealed class PerfilListItem : BaseListItem
{
    public int CoPerfil { get; set; }
    public int? CoModulo { get; set; }
    public string? NoPerfil { get; set; }
    public bool? FlDefault { get; set; }
    public bool? FlAdmin { get; set; }
}
