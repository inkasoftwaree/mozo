namespace Mozo.Domain.Maestro;


[Serializable]
public partial class TipoGeneralEntity : BaseEntity
{

    public string? TxDescripcion { get; set; }
    public int? CoTipoGeneral { get; set; }
    public int? CoModulo { get; set; }
    public string? NoTipo { get; set; }
    public int? CoGrupo { get; set; }
    public string? NoSigla { get; set; }
    public int? FlDefault { get; set; }
    public int? NuOrden { get; set; }
    public string? NoComando { get; set; }
    public string? Valor { get; set; }

}
