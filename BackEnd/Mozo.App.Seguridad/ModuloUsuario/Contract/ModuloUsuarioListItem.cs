using Mozo.Shared.Contract;

namespace Mozo.App.Seguridad.ModuloUsuario.Contracts;

/// <summary>
/// DTO plano para el listado/grid de Módulos (SelAll, no paginado).
/// Campos alineados con seguridad.fn_modulo_sel_all: comodulo, nuorden, nomodulo, flestreg.
/// </summary>
public sealed class ModuloUsuarioListItem : BaseListItem
{
    public int? CoModuloUsuario { get; set; }
    public DateTime? FeExpiracion { get; set; }
    public int? NuOrden { get; set; }
    public string? NoIcono { get; set; }
    public string? NoModulo { get; set; }
    public string? NoPerfil { get; set; }


}
