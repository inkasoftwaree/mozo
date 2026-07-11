namespace Mozo.Domain.Seguridad;


[Serializable]
public partial class ModuloUsuarioEntity : BaseEntity
{
    public int? CoModuloUsuario { get; set; }
    public int? CoEmpresa { get; set; }
    public int? CoModulo { get; set; }
    public int? CoUsuario { get; set; }
    public int? CoPerfil { get; set; }
    public DateTime? FeExpiracion { get; set; }
    public string? Valor { get; set; }
}

