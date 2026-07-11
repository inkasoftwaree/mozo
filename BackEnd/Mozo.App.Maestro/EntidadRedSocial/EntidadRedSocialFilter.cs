using Mozo.Shared.Contract;

namespace Mozo.App.Maestro.EntidadRedSocial;

public record EntidadRedSocialFilter : BaseFilter
{
    public int? CoEmpresa { get; set; }
    public int? CoEntidadRedSocial { get; set; }
    public int? CoTipoRedSocial { get; set; }
    public int? CoEntidad { get; set; }
}