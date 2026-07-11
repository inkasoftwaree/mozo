using Mozo.Domain.Maestro;

namespace Mozo.Domain.Soporte;


[Serializable]
public class SeguimientoEntity : BaseEntity
{


    public int? CoSeguimiento { get; set; }



    public int? CoSoporte { get; set; }

    public string? TxSeguimiento { get; set; }
    public int? NuDuracion { get; set; }
    public int? CoTipoTiempo { get; set; }
    public string? TxSoporte { get; set; }
    public string? FeIngreso { get; set; }
    public string? HoIngreso { get; set; }
    public string? NoDuracion { get; set; }
    public ArchivoEntity? Archivo { get; set; }
}