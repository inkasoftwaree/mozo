namespace Mozo.App.Maestro.PersonaNatural.Contracts;

/// <summary>
/// DTO plano para el combo/dropdown de Personas Naturales activas (SelAllActive).
/// Id + nombres para mostrar. Sin objetos anidados.
/// </summary>
public sealed class PersonaNaturalOption
{
    public int? CoEntidad { get; set; }
    public string? NoPersona { get; set; }
    public string? NoApellidoP { get; set; }
    public string? NoApellidoM { get; set; }
}
