using Mozo.Shared.Contract;

namespace Mozo.App.Maestro.TipoParticular.Contracts;

/// <summary>
/// DTO plano para los listados paginados de Tipo Particular (SelAll y SelAllChildren).
/// SelAll (fn_tipoparticular_sel_all) llena todos los campos; SelAllChildren
/// (fn_tipoparticular_sel_all_hijo) no trae CoModulo/CoGrupoHijo/QtHijo (quedan null).
/// RowsCount y FlEstReg vienen de BaseListItem.
/// </summary>
public sealed class TipoParticularListItem : BaseListItem
{
    public int? CoEmpresa { get; set; }
    public int? CoModulo { get; set; }
    public int? CoTipoParticular { get; set; }
    public int? CoGrupo { get; set; }
    public string? NoTipo { get; set; }
    public string? NoSigla { get; set; }
    public int? FlDefault { get; set; }
    public int? NuOrden { get; set; }
    public int? CoTipoParticularPadre { get; set; }
    public int? CoGrupoHijo { get; set; }
    public int? QtHijo { get; set; }
}
