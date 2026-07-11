namespace Mozo.App.Maestro.PersonaJuridica.Contracts;

/// <summary>
/// DTO plano para el combo/dropdown de Personas Jurídicas activas (SelAllActive).
/// Id + nombres para mostrar. Sin objetos anidados.
/// </summary>
public sealed class PersonaJuridicaOption
{
    public int? CoEntidad { get; set; }
    public string? NoRazonSocial { get; set; }
    public string? NoComercial { get; set; }
}
