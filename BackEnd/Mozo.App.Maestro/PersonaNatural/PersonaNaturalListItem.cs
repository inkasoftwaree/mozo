using Mozo.Shared.Contract;

namespace Mozo.App.Maestro.PersonaNatural;

/// <summary>
/// DTO plano para el listado paginado de Personas Naturales (SelAll).
/// Alineado con maestro.fn_personanatural_sel_all: rowscount, coempresa, coentidad, noentidad, flestreg.
/// RowsCount y FlEstReg vienen de BaseListItem.
/// </summary>
public sealed class PersonaNaturalListItem : BaseListItem
{
    public int CoEmpresa { get; set; }
    public int CoEntidad { get; set; }
    public string? NoEntidad { get; set; }
}
