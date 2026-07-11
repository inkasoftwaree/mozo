using Mozo.Shared.Contract;

namespace Mozo.App.Seguridad.Modulo.Contracts;

/// <summary>
/// DTO plano para el listado/grid de Módulos (SelAll, no paginado).
/// Campos alineados con seguridad.fn_modulo_sel_all: comodulo, nuorden, nomodulo, flestreg.
/// </summary>
public sealed class ModuloListItem : BaseListItem
{
    public int CoModulo { get; set; }
    public string? NoModulo { get; set; }
    public int? NuOrden { get; set; }
}
