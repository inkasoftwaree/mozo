namespace Mozo.Model.Maestro;

public record EntidadRedSocialFilterDto : BaseFilterDto
{
    public int? CoEmpresa { get; set; }
    public int? CoEntidadRedSocial { get; set; }
    public int? CoTipoRedSocial { get; set; }
    public int? CoEntidad { get; set; }
}

public partial class EntidadRedSocialModel : BaseModel //<RedSocialModel>
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

public partial class EntidadRedSocialModel
{  
    public string? NoEtiqueta { get; set; }
    public string? NoTipoRedSocial { get; set; }
    public string? NoTipoUrl { get; set; }

    public List<TipoGeneralModel>? EtiquetaLst { get; set; }
    public List<TipoGeneralModel>? TipoUrlLst { get; set; }
}