namespace Mozo.Shared.Services;

public sealed class UserContext
{
    private int? CoUsuario { get; }
    private int? CoEntidad { get; }
    private int? CoEmpresa { get; }
    private int? CoIngreso { get; }
    private string? NoUsuario { get; }
    private bool FlSuperAdmin { get; }

    public bool IsAuthenticated { get; }

    public bool IsValid =>
        IsAuthenticated &&
        CoUsuario is > 0 &&
        CoEntidad is > 0;

    public bool HasCompanyContext =>
        IsValid &&
        CoEmpresa is > 0;

    public bool HasIngreso =>
        CoIngreso is > 0;

    public bool HasWorkContext =>
        HasCompanyContext &&
        HasIngreso;

    public UserContext(IClaimsService claimsService)
    {
        ArgumentNullException.ThrowIfNull(claimsService);

        IsAuthenticated = claimsService.IsAuthenticated;

        CoUsuario = claimsService.GetInt32("CoUsuario");
        CoEntidad = claimsService.GetInt32("CoEntidad");
        CoEmpresa = claimsService.GetInt32("CoEmpresa");
        CoIngreso = claimsService.GetInt32("CoIngreso");
        NoUsuario = claimsService.GetString("NoUsuario");
        FlSuperAdmin = claimsService.GetInt32("FlSuperAdmin") == 1;

    }

    #region Propiedades requeridas

    public int CoUsuarioRequired
    {
        get
        {
            ValidateAuthentication();
            return CoUsuario!.Value;
        }
    }

    public int CoEntidadRequired
    {
        get
        {
            ValidateAuthentication();
            return CoEntidad!.Value;
        }
    }

    public int CoEmpresaRequired
    {
        get
        {
            ValidateCompany();
            return CoEmpresa!.Value;
        }
    }

    public int CoIngresoRequired
    {
        get
        {
            ValidateWorkContext();
            return CoIngreso!.Value;
        }
    }

    public string NoUsuarioRequired
    {
        get
        {
            ValidateAuthentication();

            return NoUsuario
                ?? throw new UnauthorizedAccessException("Usuario inválido.");
        }
    }

    #endregion

    #region Multi-empresa

    /// <summary>
    /// Resuelve la empresa efectiva para una operación:
    /// - Si flEmpresaNotKey != 1: usa la empresa del contexto del usuario autenticado (caso normal).
    /// - Si flEmpresaNotKey == 1: el llamador pide operar sobre una empresa específica.
    ///   Solo se permite si el usuario tiene FlSuperAdmin; de lo contrario se rechaza.
    /// </summary>
    public int ResolveEmpresa(int? flEmpresaNotKey, int? coEmpresaSolicitada)
    {
        ValidateAuthentication();

        if (flEmpresaNotKey != 1)
            return CoEmpresaRequired;

        if (coEmpresaSolicitada is null or <= 0)
            throw new ArgumentException(
                "CoEmpresa es requerido cuando FlEmpresaNotKey = 1.", nameof(coEmpresaSolicitada));

        if (!FlSuperAdmin)
            throw new UnauthorizedAccessException(
                "El usuario no tiene permiso para operar sobre una empresa distinta a la suya.");

        return coEmpresaSolicitada.Value;
    }

    #endregion


    #region Validaciones

    public void ValidateAuthentication()
    {
        if (!IsValid)
            throw new UnauthorizedAccessException("Usuario no autenticado.");
    }

    public void ValidateCompany()
    {
        ValidateAuthentication();

        if (!HasCompanyContext)
            throw new UnauthorizedAccessException("No existe una empresa seleccionada.");
    }

    public void ValidateWorkContext()
    {
        ValidateCompany();

        if (!HasIngreso)
            throw new UnauthorizedAccessException("No existe una sesión activa.");
    }

    #endregion
}
