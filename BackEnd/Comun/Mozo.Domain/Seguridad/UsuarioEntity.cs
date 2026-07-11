namespace Mozo.Domain.Seguridad;



[Serializable]
public partial class UsuarioEntity : BaseEntity
{
    public int? CoUsuario { get; set; }
    public int? CoEntidad { get; set; }
    public string? NoUsuario { get; set; }
    public string? NoClave { get; set; }

    public int? FlSuperAdmin { get; set; }
}


//public partial class UsuarioEntity
//{   public string? NoEntidad { get; set; }

//    public string? EmpresaLstJson { get; set; }
//    public List<EmpresaEntity>? EmpresaLst => JsonSerializer.Deserialize<List<EmpresaEntity>>(EmpresaLstJson!,
//        new JsonSerializerOptions
//        {
//            PropertyNameCaseInsensitive = true
//        });

//}


