using Mozo.Shared.Contract;

namespace Mozo.App.Maestro.PersonaJuridica.Contracts;

/// <summary>
/// DTO plano para el listado paginado de Personas Jurídicas (SelAll).
/// Alineado con maestro.fn_personajuridica_sel_all: rowscount, coempresa, coentidad, noentidad, flestreg.
/// RowsCount y FlEstReg vienen de BaseListItem.
/// </summary>
public sealed class PersonaJuridicaListItem : BaseListItem
{
    public int CoEmpresa { get; set; }
    public int CoEntidad { get; set; }
    public string? NoEntidad { get; set; }
}
