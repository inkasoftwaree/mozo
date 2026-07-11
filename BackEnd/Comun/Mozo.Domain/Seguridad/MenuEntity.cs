namespace Mozo.Domain.Seguridad;


[Serializable]
public partial class MenuEntity : BaseEntity
{
    public int? NuOrden { get; set; }
    public int? CoMenu { get; set; }
    public string? NoMenu { get; set; }
    public int? CoUsuario { get; set; }
    public int? CoModulo { get; set; }
    public string? NoModuloDescripcion { get; set; }
    public int? CoPerfil { get; set; }

}
public partial class MenuEntity
{
    public List<PaginaEntity>? PaginaLst { get; set; }

}