namespace Mozo.Domain.Seguridad;


[Serializable]
public partial class EmpresaModuloEntity : BaseEntity
{
    public int? CoEmpresaModulo { get; set; }
    public int? CoModulo { get; set; }
    public int? CoEmpresa { get; set; }
}
