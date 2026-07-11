namespace Mozo.Domain.Maestro;




[Serializable]
public partial class PersonaJuridicaEntity : BaseEntity
{

    public int? CoEntidad { get; set; }
    public string? NoRazonSocial { get; set; } = null!;
    public string? NoComercial { get; set; }
    public int? CoRubro { get; set; }
}
public partial class PersonaJuridicaEntity
{
    public EntidadEntity? Entidad { get; set; }
}
