namespace Mozo.Domain.Maestro;



[Serializable]
public partial class ArchivoEntity : BaseEntity
{

    public int? CoEmpresa { get; set; }
    public int? CoArchivo { get; set; }
    public int? CoTipoEntidad { get; set; }
    public int? CoEntidad { get; set; }
    public int? CoTipo { get; set; }
    public string? NoArchivo { get; set; }
    public string? NoExtension { get; set; }
    public string? NoRuta { get; set; }

    public int? NuOrden { get; set; }
    public string? TxDescripcion { get; set; }
    public int? FlDefault { get; set; }
    public long? NuBytes { get; set; }
    public int? NuAlto { get; set; }
    public int? NuAncho { get; set; }
    public string? NoTitulo { get; set; }

}

public partial class ArchivoEntity
{
    public int? FlGaleria { get; set; }
    public string? Url { get; set; }
    public string? ContentType { get; set; }



}

