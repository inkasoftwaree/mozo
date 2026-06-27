using Mozo.Helper.Services;

namespace Mozo.Helper.Global;

public sealed class UserContext
{
    private int? CoUsuario { get; }
    private int? CoPersona { get; }
    private int? CoEmpresa { get; }
    private int? CoIngreso { get; }

    private string? NoUsuario { get; }

    public bool IsAuthenticated { get; }

    public bool IsValid =>
        IsAuthenticated &&
        CoUsuario is > 0 &&
        CoPersona is > 0;

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
        CoPersona = claimsService.GetInt32("CoPersona");
        CoEmpresa = claimsService.GetInt32("CoEmpresa");
        CoIngreso = claimsService.GetInt32("CoIngreso");
        NoUsuario = claimsService.GetString("NoUsuario");
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

    public int CoPersonaRequired
    {
        get
        {
            ValidateAuthentication();
            return CoPersona!.Value;
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
