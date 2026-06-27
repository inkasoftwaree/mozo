using Microsoft.AspNetCore.Mvc;
using Mozo.ApiSeguridad.Helper;
using Mozo.ApiSeguridad.HelperWeb.Exceptions;
using Mozo.Helper.Global;
using Mozo.HelperWeb.Cripto;
using Mozo.HelperWeb.Token;
using Mozo.LoginBusiness;
using Mozo.Model.Seguridad;
using Mozo.Model.Seguridad.Auth;
using System.Data;
using System.IdentityModel.Tokens.Jwt;
using System.Net;
using System.Security.Claims;
using static Mozo.Helper.Enu.EnuTipoGeneral.FormatoArchivo.Maestro;
namespace Mozo.Api.Login;

///<summary>
/// Endpoints para gestión de Permiso
///</summary>
///<history>
/// Create by Jonatan Abregu
///</history>
public static partial class UsuarioEndPoints
{
    /// <summary>
    /// Mapea todas las rutas de Permiso
    /// </summary>
    public static RouteGroupBuilder MapUsuario(this RouteGroupBuilder g)
    {
        g.WithSecurity();
        
        g.MapPost("/", LoginAsync)
            .AllowAnonymous()
            .WithResponses<GlobalCredencialModel>(StatusCodes.Status200OK)           
            .WithDescription("Realiza el login del usuario");

        g.MapPost("/login/empresa", LoginEmpresaAsync)        
          .WithResponses<GlobalCredencialModel>(StatusCodes.Status200OK)      
          .WithDescription("Realiza el login del usuario - para los que tiene mas de una empresa");

        g.MapGet("/check", LoginCheck)
            .WithResponses<GlobalCredencialModel>(StatusCodes.Status200OK)
            .WithDescription("Verifica si el login es válido");

        g.MapPatch("/language", UpdateLanguageAsync)
            .WithResponses<GlobalCredencialModel>(StatusCodes.Status200OK)
            .WithDescription("Actualiza el idioma del app");

        return g;
    }
}
public static partial class UsuarioEndPoints
{

    private static async Task<IResult> LoginEmpresaAsync(
     [FromBody] UsuarioFilterDto f,
     IJwtService jwtService,
     IUsuarioBusiness IUsuario,
     IIngresoBusiness IIngreso,
     ILoggerFactory loggerFactory,
     UserContext user)
    {
        ILogger logger = loggerFactory.CreateLogger("Mozo.Api.Login");
        //ClaimsPrincipal user, HttpContext httpContext
        // CoUsuario y CoPersona vienen del token temporal
        int coUsuario = user.CoUsuarioRequired;
        int coPersona = user.CoPersonaRequired;


        // Validar que la empresa pertenece al usuario
        UsuarioModel? usuario = await IUsuario.SelByEmpresaAsync(
            new() { 
                    CoEmpresa = f.CoEmpresa, 
                    CoUsuario = coUsuario 
            });

        if (usuario is null)
            throw new UnauthorizedException("La empresa no pertenece al usuario.");

        string refreshToken = jwtService.GenerateRefreshToken();

        IngresoModel ingreso = new()
        {
            CoUsuario = usuario.CoUsuario,
            NoRefreshToken = refreshToken,
            NoIp = jwtService.GetUserIp(),
            NoUserAgent = jwtService.GetUserAgent(),
            FeRefreshTokenExpire = jwtService.GetRefreshTokenExpiration()
        };

        ingreso.CoIngreso = await IIngreso.InsertAsync(ingreso);

        CredencialModel credential = new()
        {
            CoEmpresa = usuario.CoEmpresa,
            CoPersona = usuario.CoPersona,
            CoUsuario = usuario.CoUsuario,
            NoUsuario = usuario.NoUsuario,
            NoNombreCompleto = usuario.NoPersona,
            CoIngreso = ingreso.CoIngreso
        };

        string token = jwtService.GenerateToken(credential);

        return Results.Ok(new GlobalCredencialModel
        {
            Credencial = credential,
            NoToken = token,
            NoTokenRefresh = refreshToken
        });
    }



    private static async Task<IResult>
     LoginAsync(
        [FromBody] UsuarioFilterDto f,
        IJwtService jwtService,
        IUsuarioBusiness IUsuario,
        IIngresoBusiness IIngreso,
        ILoggerFactory loggerFactory
    )
    {
        ILogger logger = loggerFactory.CreateLogger("Mozo.Api.Login");

        if (f == null)
            throw new ArgumentNullException(nameof(f));

        if (string.IsNullOrWhiteSpace(f.NoUsuario))
            throw new UnauthorizedException("El usuario es requerido");

        if (string.IsNullOrWhiteSpace(f.NoClave))
            throw new UnauthorizedException("La contraseña es requerida");


        UsuarioModel? usuario = await IUsuario.SelByUserAsync(f);
        if (usuario == null)
        {
            logger.LogWarning(
               "[SECURITY] LOGIN_FAILED | Usuario: {Usuario} | IP: {IP}",
               f.NoUsuario, f.NoIp);
            throw new UnauthorizedException("Usuario o contraseña incorrectos");
        }

        bool valido = ClaveHelper.Verify(
            f.NoClave,
            usuario.NoClave!
        );

        if (!valido)
            throw new ValidationException("contraseña incorrecta");

        List<EmpresaModel> empresas = usuario.EmpresaLst ?? [];
        int qtEmpresas = empresas.Count;

        switch (qtEmpresas)
        {
            case 0:
                logger.LogInformation(
                "[SECURITY] LOGIN_FAILED | Usuario: {Usuario}, Sin empresa",
                usuario.NoUsuario);
                throw new ValidationException("El usuario no tiene empresa");
            case 1:
                EmpresaModel empresa = empresas[0];               
                string noTokenRefresh = jwtService.GenerateRefreshToken();

                IngresoModel ingresoNew = new()
                {
                    CoUsuario = usuario.CoUsuario,
                    NoIp = jwtService.GetUserIp(),
                    NoRefreshToken = noTokenRefresh,
                    NoUserAgent = jwtService.GetUserAgent(),
                    FeRefreshTokenExpire = jwtService.GetRefreshTokenExpiration()
                };
                ingresoNew.CoIngreso = await IIngreso.InsertAsync(ingresoNew);

                CredencialModel credential = new()
                {
                    CoEmpresa = empresa.CoEmpresa,
                    CoPersona = usuario.CoPersona,
                    CoUsuario = usuario.CoUsuario,
                    NoUsuario = usuario.NoUsuario,
                    NoNombreCompleto = usuario.NoPersona,
                    CoIngreso = ingresoNew.CoIngreso
                };
                string token = jwtService.GenerateToken(credential);

                GlobalCredencialModel globalCredencial = new()
                {
                    Credencial = credential,
                    NoToken = token,
                    NoTokenRefresh = noTokenRefresh,
                    FlRequiereSeleccionEmpresa = 0
                };

                logger.LogInformation(
                 "[SECURITY] LOGIN_SUCCESS | Usuario: {Usuario} | Empresa: {CoEmpresa} |  Ingreso: {CoIngreso} | IP: {IP} | Agent: {Agent}",
                     usuario.NoUsuario,
                     empresa.CoEmpresa,
                     ingresoNew.CoIngreso,
                     ingresoNew.NoIp,
                     ingresoNew.NoUserAgent);

                return Results.Ok(globalCredencial);
             

            default:
                List<GlobalCredentialEmpresaModel> empresaLst = empresas
                 .Select(e => new GlobalCredentialEmpresaModel
                 {
                     CoEmpresa = e.CoEmpresa,
                     NoEmpresa = e.NoEmpresa
                 })
                 .ToList();
               

                CredencialModel credentialMayor1 = new()
                {
                    CoPersona = usuario.CoPersona,
                    CoUsuario = usuario.CoUsuario,
                    NoUsuario = usuario.NoUsuario,
                    NoNombreCompleto = usuario.NoPersona,
                };       
               
                GlobalCredencialModel globalCredencialMayor1 = new()
                {
                    //Credencial = credentialMayor1,
                    NoToken = jwtService.GenerateAuthenticationToken(credentialMayor1),
                    EmpresaLst = empresaLst,
                    FlRequiereSeleccionEmpresa=1

                };

                logger.LogInformation(
                    "[SECURITY] LOGIN_PENDING_COMPANY | Usuario: {Usuario}, varias empresas, sin escojer empresa",
                    usuario.NoUsuario);

                return Results.Ok(globalCredencialMayor1);
        }

    }


    private static async Task<IResult> LoginCheck(
       UserContext user
       )
    {


        if (user.IsValid != true)
            throw new UnauthorizedException("No autorizado");

        int? coEmpresa = user.CoEmpresaRequired;
        int? coPersona = user.CoPersonaRequired;
        int? coUsuario = user.CoUsuarioRequired;
        int? coIngreso = user.CoIngresoRequired;
        string? noUsuario = user.NoUsuarioRequired;
        //string? noUsuario2 = user.FindFirst(JwtRegisteredClaimNames.Sub)?.Value;

        if (coEmpresa == null || coPersona  == null || coUsuario == null)
            throw new UnauthorizedException("Claims inválidos");

        // string token = httpContext.Request.Headers["Authorization"].ToString().Replace("Bearer ", "");


        GlobalCredencialModel globalCredencial = new()
        {
            Credencial = new()
            {
                CoEmpresa = coEmpresa,
                CoPersona = coPersona,
                CoUsuario = coUsuario,
                NoUsuario = noUsuario,
                CoIngreso = coIngreso
            }
        };

        return Results.Ok(globalCredencial);
    }



    static async Task<IResult>
        UpdateLanguageAsync(
        UsuarioModel m,
        IUsuarioBusiness IUsuario
        )
    {
        if (m is null)
            throw new ArgumentNullException(nameof(m));

        await IUsuario.UpdateLanguageAsync(m);
        return Results.Ok(m);
    }


}


