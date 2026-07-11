///<summary>
///
///</summary>
///<remarks>
///</remarks>
///<history>
/// t[Jonatan Abregu]	07-05-2020	Created
///</history>
namespace Mozo.Domain.Empresa;



[Serializable]
public partial class ServicioEntity : BaseEntity
{
    public int? CoServicio { get; set; }
    public int? CoTipo { get; set; }
    public int? FlMuestraImagen { get; set; }
    public int? CoSubTipo { get; set; }
    public string? NoTitulo { get; set; }
    public string? TxDescripcion { get; set; }
    public string? TxDescripcionCorta { get; set; }
}

public partial class ServicioEntity
{
    public int? NuOrden { get; set; }

    public int? NuSubOrden { get; set; }

    public string? NoDescripcionTipo { get; set; }

    public string? NoDescripcionSubTipo { get; set; }

    public string? NoSubTipo { get; set; }
    public string? NoTipo { get; set; }

    public List<ServicioCaracteristicaEntity>? ServicioCaracteristicaLst { get; set; }
    public List<PreguntaEntity>? PreguntaLst { get; set; }
}