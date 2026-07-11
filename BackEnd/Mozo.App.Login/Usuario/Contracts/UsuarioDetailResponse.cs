using System.Text.Json;

namespace Mozo.App.Login.Usuario.Contracts;

public partial class UsuarioDetailResponse
{
    public int? CoEntidad { get; set; }
    public int? CoUsuario { get; set; }
    public string? NoUsuario { get; set; }
    public string? NoClave { get; set; }
    public string? NoEntidad { get; set; }
    public int? FlSuperAdmin { get; set; }

    public string? EmpresaLstJson { get; set; }
    public List<EmpresaDetailResponse>? EmpresaLst => JsonSerializer.Deserialize<List<EmpresaDetailResponse>>(EmpresaLstJson!,
        new JsonSerializerOptions
        {
            PropertyNameCaseInsensitive = true
        });

}

public partial class EmpresaDetailResponse
{
    public int? CoEmpresa { get; set; }
    public string? NoRazonSocial { get; set; }

}
