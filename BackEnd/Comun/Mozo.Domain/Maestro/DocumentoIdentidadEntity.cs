namespace Mozo.Domain.Maestro;


/// <summary>
/// Entidad que representa la tabla "trfdocumentoidentidad".
/// </summary>
/// 
[Serializable]
public class DocumentoIdentidadEntity
{
    public int? CoDocumentoIdentidad { get; set; }
    public int? CoPais { get; set; }
    public int? CoAmbito { get; set; }
    public string? NoCodigo { get; set; }
    public string? NoDocumentoIdentidad { get; set; }
    public string? NoDocumentoIdentidadSigla { get; set; }
}
