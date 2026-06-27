using Mozo.Model.Seguridad;
using static Mozo.Helper.Enu.EnuTipoGeneral.Maestro;
using static Mozo.Helper.Enu.EnuTipoParticular.Maestro;
using static Mozo.Helper.Enu.EnuTipoParticular.Matricula;

namespace Mozo.Model.Maestro;

public record PersonaNaturalFilter : BaseFilterDto {
    public int? CoEntidad { get; set; }
}


[Serializable]
public partial class PersonaNaturalModel : BaseModel 
{
    public EntidadModel? Entidad { get; set; }
    public int? CoEntidad { get; set; }   
    public string? NoPersona { get; set; } = null!;
    public string? NoApellidoP { get; set; }
    public string? NoApellidoM { get; set; }
    public int? CoEstadoCivil { get; set; }        
    public int? CoProfesion { get; set; }
    public int? CoSexo { get; set; }
    public string? FeNacimiento { get; set; }
}
public partial class PersonaNaturalModel 
{

}
