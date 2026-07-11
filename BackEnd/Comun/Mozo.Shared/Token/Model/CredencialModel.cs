namespace Mozo.Shared.Token.Model;

public class CredencialModel
{
    public string? NoUsuario { get; set; }
    public string? NoNombreCompleto { get; set; }
    public int? CoEntidad { get; set; }
    public int? CoUsuario { get; set; }
    public int? CoIngreso { get; set; }

    public int? CoEmpresa { get; set; }

    public int? FlSuperAdmin { get; set; }



    //public long? FeExpiration { get; set; }

    //public TokenModel? Token { get; set; }
    // public GlobalCredentialEmpresaModel? Empresa { get; set; }
    // public GlobalCredentialPermisoModel? Permiso { get; set; }
    // public GlobalCredentialIngresoModel? Ingreso { get; set; }
}

public class GlobalCredencialModel
{
    public CredencialModel? Credencial { get; set; }
    public List<GlobalCredentialEmpresaModel>? EmpresaLst { get; set; }

    public string? NoToken { get; set; }
    public string? NoTokenRefresh { get; set; }

    public int? FlRequiereSeleccionEmpresa { get; set; }
}

//[Serializable]
//public class GlobalCredentialIngresoModel
//{
//     public int? CoIngreso { get; set; }
//}


public class GlobalCredentialEmpresaModel
{
    public string? NoRazonSocial { get; set; }
    public int? CoEmpresa { get; set; }
}

