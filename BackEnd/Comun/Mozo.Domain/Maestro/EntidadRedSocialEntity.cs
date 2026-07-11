namespace Mozo.Domain.Maestro;


public partial class EntidadRedSocialEntity : BaseEntity
{
    public int? CoEmpresa { get; set; }
    public int? CoEntidadRedSocial { get; set; }
    public int? CoEtiqueta { get; set; }
    public int? CoTipoUrl { get; set; }
    public int? CoTipoRedSocial { get; set; }
    public string? NoRedSocial { get; set; }
    public int? CoEntidad { get; set; }
    public int? FlWhatsapp { get; set; }
}
