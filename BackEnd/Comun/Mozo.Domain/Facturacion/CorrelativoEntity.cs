///<summary>
///
///</summary>
///<remarks>
///</remarks>
///<history>
/// t[Jonatan Abregu]	21/09/2021	Created
///</history>
namespace Mozo.Domain.Facturacion;


[Serializable]
public partial class CorrelativoEntity : BaseEntity
{
    public int? CoCorrelativo { get; set; }
    public int? CoLocal { get; set; }
    public int? CoComprobantePago { get; set; }

    public string? NuSerie { get; set; }
    public int? NuDocumento { get; set; }
    public int? FlDefecto { get; set; }
}

public partial class CorrelativoEntity
{
    public string? NoLocal { get; set; }
    public string? NoComprobantePago { get; set; }
    public string? NoComprobantePagoSigla { get; set; }
}