namespace Mozo.App.Maestro.DocumentoIdentidad.Contracts;

/// <summary>
/// DTO plano para el combo/dropdown de Documentos de Identidad activos (SelAllActive).
/// Id + textos para mostrar. Sin objetos anidados.
/// </summary>
public sealed class DocumentoIdentidadOption
{
    public int? CoDocumentoIdentidad { get; set; }
    public int? CoPais { get; set; }
    public int? CoAmbito { get; set; }
    public string? NoCodigo { get; set; }
    public string? NoDocumentoIdentidad { get; set; }
    public string? NoDocumentoIdentidadSigla { get; set; }
}
