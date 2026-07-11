namespace Mozo.Domain.Maestro;



[Serializable]
public partial class PersonaNaturalEntity : BaseEntity
{
    public int? CoEntidad { get; set; }
    public string? NoPersona { get; set; } = null!;
    public string? NoApellidoP { get; set; }
    public string? NoApellidoM { get; set; }
    public int? CoEstadoCivil { get; set; }
    public int? CoProfesion { get; set; }
    public int? CoSexo { get; set; }
    public DateTime? FeNacimiento { get; set; }
}
public partial class PersonaNaturalEntity
{
    public EntidadEntity? Entidad { get; set; }

}
