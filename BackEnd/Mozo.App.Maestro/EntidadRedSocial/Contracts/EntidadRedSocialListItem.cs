using Mozo.Shared.Contract;

namespace Mozo.App.Maestro.EntidadRedSocial.Contracts;

/// <summary>
/// DTO plano para el listado de Redes Sociales de una entidad (SelAll).
/// FlEstReg y RowsCount vienen de BaseListItem.
/// </summary>
public sealed class EntidadRedSocialListItem : BaseListItem
{
    public int? CoEntidadRedSocial { get; set; }
    public int? CoEmpresa { get; set; }
    public int? CoEntidad { get; set; }
    public int? CoEtiqueta { get; set; }
    public int? CoTipoUrl { get; set; }
    public int? CoTipoRedSocial { get; set; }
    public string? NoRedSocial { get; set; }
    public int? FlWhatsapp { get; set; }
}
