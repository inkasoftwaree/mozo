namespace Mozo.Domain.Soporte;


[Serializable]
public class EstadisticaEntity : BaseEntity
{
    public string? NoEstado { get; set; }
    public string? NoTipoSoporte { get; set; }

    public string? NoClasificacion { get; set; }

    // public string? TxDescripcion { get; set; }
    public string? TxProblema { get; set; }


    public string? NoSubClasificacion { get; set; }

    public string? NoGrupo { get; set; }
    public string? FeIngreso { get; set; }



    public int? CoClasificacion { get; set; }



    public int? CoSoporteDetalle { get; set; }



    public int? CoSubClasificacion { get; set; }



    public int? QtGrupoSoporte { get; set; }



    public int? QtGrupoDesarrollo { get; set; }



    public int? QtGrupoEstadistica { get; set; }



    public int? CoGrupo { get; set; }



    public int? CoGrupoDesarrollo { get; set; }



    public int? CoGrupoSoporte { get; set; }



    public int? CoGrupoEstadistica { get; set; }



    public int? QtDia { get; set; }



    public int? QtSoporte { get; set; }

    public List<SoporteEntity>? AreaCol { get; set; }


    public List<SoporteEntity>? ClasificacionCol { get; set; }

    public List<SoporteEntity>? DiaCol { get; set; }

    public List<SoporteEntity>? DuracionCol { get; set; }
    public List<SoporteEntity>? EstadoCol { get; set; }

    public List<SoporteEntity>? ProblemaCol { get; set; }

    public List<SoporteEntity>? TipoSoporteCol { get; set; }
}