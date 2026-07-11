namespace Mozo.Domain.Seguridad;



[Serializable]
public partial class ModuloEntity : BaseEntity
{
    public string? NoIcono { get; set; }
    public int? NuOrden { get; set; }
    public int? FlArea { get; set; }
    public int? CoModulo { get; set; }
    public string? NoArea { get; set; }
    public string? NoModulo { get; set; }
    public string? NoModuloDescripcion { get; set; }
}
public partial class ModuloEntity
{
    public int? CoEmpresa { get; set; }
    public IEnumerable<PerfilEntity>? PerfilCol { get; set; }

}