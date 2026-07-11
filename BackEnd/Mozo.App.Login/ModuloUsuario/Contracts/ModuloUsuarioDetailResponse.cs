namespace Mozo.App.Login.ModuloUsuario.Contracts;

public partial class ModuloUsuarioDetailResponse
{
    public int? CoModuloUsuario { get; set; }
    public int? CoEmpresa { get; set; }
    public int? CoModulo { get; set; }
    public int? CoUsuario { get; set; }
    public int? CoPerfil { get; set; }
    public DateTime? FeExpiracion { get; set; }
    public string? NoModulo { get; set; }
}
