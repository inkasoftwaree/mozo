using Mozo.Model.Seguridad;
using static Mozo.Helper.Enu.EnuTipoParticular.Maestro;
using static Mozo.Helper.Enu.EnuTipoParticular.Matricula;

namespace Mozo.Model.Maestro;

public record PersonaJuridicaFilter : BaseFilterDto {
    public int? CoEntidad { get; set; }
}


[Serializable]
public partial class PersonaJuridicaModel : BaseModel 
{
    public EntidadModel? Entidad { get; set; }
    public int? CoEntidad { get; set; }   
    public string? NoRazonSocial { get; set; } = null!;
    public string? NoComercial { get; set; }    
    public int? CoRubro { get; set; }   
}
public partial class PersonaJuridicaModel
{
  
}
