///<summary>
///
///</summary>
///<remarks>
///</remarks>
///<history>
/// t[Jonatan Abregu]	26/09/2022	Created
///</history>
namespace Mozo.Domain.Empresa;



[Serializable()]
public partial class ServicioCaracteristicaEntity : BaseEntity
{

    public int? CoServicioCaracteristica { get; set; }
    public int? CoServicio { get; set; }
    public int? NuOrden { get; set; }
    public string? NoTitulo { get; set; }
    public string? TxDescripcion { get; set; }

}

public partial class ServicioCaracteristicaEntity
{


}