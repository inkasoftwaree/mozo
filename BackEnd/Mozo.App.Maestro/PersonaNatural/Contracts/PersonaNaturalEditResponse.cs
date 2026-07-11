namespace Mozo.App.Maestro.PersonaNatural.Contracts;

/// <summary>
/// DTO plano para traer una Persona Natural a editar (GET SelById).
/// PK + campos editables, sin objetos anidados.
/// </summary>
public sealed class PersonaNaturalEditResponse
{
    public int? CoEntidad { get; set; }
    public string? NoPersona { get; set; }
    public string? NoApellidoP { get; set; }
    public string? NoApellidoM { get; set; }
    public int? CoEstadoCivil { get; set; }
    public int? CoProfesion { get; set; }
    public int? CoSexo { get; set; }
    public DateTime? FeNacimiento { get; set; }
}
