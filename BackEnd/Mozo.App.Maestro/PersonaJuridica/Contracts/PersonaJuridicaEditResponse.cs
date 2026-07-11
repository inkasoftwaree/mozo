namespace Mozo.App.Maestro.PersonaJuridica.Contracts;

/// <summary>
/// DTO plano para traer una Persona Jurídica a editar (GET SelById).
/// PK + campos editables, sin objetos anidados.
/// </summary>
public sealed class PersonaJuridicaEditResponse
{
    public int? CoEntidad { get; set; }
    public string? NoRazonSocial { get; set; }
    public string? NoComercial { get; set; }
    public int? CoRubro { get; set; }
}
