using System.Text.Json;

namespace Mozo.Model.Seguridad;

public record UsuarioFilterDto : BaseFilterDto
{
    public int? CoEntidad { get; set; }
    public int? CoUsuario { get; set; }
    public int? CoEmpresa { get; set; }
    public string? NoIp { get; set; }
    public string? NoUsuario { get; set; }
    public string? NoClave { get; set; }
    public string? NoUserAgent { get; set; }

}

[Serializable]
public partial class UsuarioModel : BaseModel
{
    public int? CoUsuario { get; set; }
    public int? CoEntidad { get; set; }
    public string? NoUsuario { get; set; }
    public string? NoClave { get; set; }
}


public partial class UsuarioModel
{
    public int? CoEmpresa { get; set; }
    public string? NoEntidad { get; set; }

    public string? EmpresaLstJson { get; set; }
    public List<EmpresaModel>? EmpresaLst => JsonSerializer.Deserialize<List<EmpresaModel>>(EmpresaLstJson!,
        new JsonSerializerOptions
        {
            PropertyNameCaseInsensitive = true
        });

}


