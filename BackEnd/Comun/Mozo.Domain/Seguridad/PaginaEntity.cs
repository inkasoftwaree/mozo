namespace Mozo.Domain.Seguridad;



[Serializable]
public partial class PaginaEntity : BaseEntity //<PaginaModel>
{
    public int? CoModulo { get; set; }
    public int? CoTipoPagina { get; set; }
    public int? CoPagina { get; set; }
    public int? CoMenu { get; set; }
    public int? CoArea { get; set; }
    public string? NoControlador { get; set; }
    public string? NoAccion { get; set; }
    public string? NoOpcion { get; set; }
    public int? NuOrden { get; set; }
}
