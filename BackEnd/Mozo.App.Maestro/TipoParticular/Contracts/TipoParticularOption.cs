using Mozo.Shared.Contract;

namespace Mozo.App.Maestro.TipoParticular.Contracts;

/// <summary>
/// DTO plano para los listados activos de Tipo Particular
/// (SelAllActive, SelAllActiveChildren, SelAllActiveFatherAndChildren, SelAllActiveGroupsByModulo).
/// Incluye los campos del sub-tipo porque SelAllActiveChildren los devuelve y ordena por NuSubOrden.
/// FlEstReg viene de BaseListItem.
/// </summary>
public sealed class TipoParticularOption : BaseListItem
{
    public int? CoEmpresa { get; set; }
    public int? CoModulo { get; set; }
    public int? CoGrupo { get; set; }
    public int? CoTipoParticular { get; set; }
    public int? NuOrden { get; set; }
    public string? NoTipo { get; set; }
    public string? NoSigla { get; set; }
    public string? TxDescripcion { get; set; }
    public int? CoGrupoPadre { get; set; }
    public int? CoTipoParticularPadre { get; set; }
    public int? FlDefault { get; set; }
    public string? NoComando { get; set; }
    public string? NoGrupo { get; set; }
    public string? NoGrupoPadre { get; set; }
    public string? NoTipoParticularPadre { get; set; }
    public string? NoModulo { get; set; }
    public int? CoGrupoHijo { get; set; }
    public int? QtHijo { get; set; }
    public int? CoServicio { get; set; }

    // Sub-tipo
    public int? CoSubGrupo { get; set; }
    public int? CoSubTipoParticular { get; set; }
    public string? NoSubValor { get; set; }
    public string? NoSubSigla { get; set; }
    public int? NuSubOrden { get; set; }
    public string? NoSubTipo { get; set; }
}
