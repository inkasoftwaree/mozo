namespace Mozo.App.Seguridad.ModuloUsuario.Contract;

[Serializable]
public partial class ModuloUsuarioEditResponse
{
    public int? CoEmpresa { get; set; }
    public int? CoModuloUsuario { get; set; }
    public int? CoModulo { get; set; }
    public int? CoUsuario { get; set; }
    public int? CoEntidad { get; set; }
    public int? CoPerfil { get; set; }
    public DateTime? FeExpiracion { get; set; }
    public string? NoPerfil { get; set; }
    public string? NoModulo { get; set; }
}