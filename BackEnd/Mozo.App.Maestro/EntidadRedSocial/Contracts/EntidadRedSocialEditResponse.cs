namespace Mozo.App.Maestro.EntidadRedSocial.Contracts;

/// <summary>
/// DTO plano para traer una Red Social de una entidad a editar (GET SelById).
/// PK + FK ids + valor, sin objetos anidados.
/// </summary>
public sealed class EntidadRedSocialEditResponse
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
