using Mozo.Shared.Contract;

namespace Mozo.App.Maestro.EntidadDocumento.Contracts;

/// <summary>
/// DTO plano para el listado de Documentos de una entidad (SelAll).
/// FlEstReg y RowsCount vienen de BaseListItem.
/// </summary>
public sealed class EntidadDocumentoListItem : BaseListItem
{
    public int? CoEntidadDocumento { get; set; }
    public int? CoEntidad { get; set; }
    public int? CoDocumentoIdentidad { get; set; }
    public string? NuDocumento { get; set; }
    public int? FlDefault { get; set; }
}
