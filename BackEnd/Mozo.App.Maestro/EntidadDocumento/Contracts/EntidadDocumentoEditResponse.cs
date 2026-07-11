namespace Mozo.App.Maestro.EntidadDocumento.Contracts;

/// <summary>
/// DTO plano para traer un Documento de una entidad a editar (GET SelById).
/// PK + FK ids + número, sin objetos anidados.
/// </summary>
public sealed class EntidadDocumentoEditResponse
{
    public int? CoEntidadDocumento { get; set; }
    public int? CoEntidad { get; set; }
    public int? CoDocumentoIdentidad { get; set; }
    public string? NuDocumento { get; set; }
    public int? FlDefault { get; set; }
}
