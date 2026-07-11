using Mozo.Shared.Contract;

namespace Mozo.App.Maestro.TipoGeneral.Contracts;

/// <summary>
/// DTO plano para los combos de Tipo General activos (SelAllActive / SelAllActiveByModulo).
/// Id + textos + orden para mostrar. FlEstReg viene de BaseListItem.
/// </summary>
public sealed class TipoGeneralOption : BaseListItem
{
    public int? CoTipoGeneral { get; set; }
    public int? CoGrupo { get; set; }
    public string? NoTipo { get; set; }
    public string? NoSigla { get; set; }
    public string? Valor { get; set; }
    public int? NuOrden { get; set; }
    public int? FlDefault { get; set; }
}
