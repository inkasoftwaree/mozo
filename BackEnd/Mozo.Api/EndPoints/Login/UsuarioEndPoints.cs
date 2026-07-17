using Microsoft.AspNetCore.Mvc;
using Mozo.Api.Abstractions;
using Mozo.App.Login.Ingreso;
using Mozo.App.Login.Usuario;
using Mozo.App.Login.Usuario.Contracts;
using Mozo.Domain.Seguridad;
using Mozo.Shared.Cripto;
using Mozo.Shared.Exceptions;
using Mozo.Shared.Services;
using Mozo.Shared.Token;
using Mozo.Shared.Token.Model;
using System.Data;
namespace Mozo.Api.Login;

///<summary>
/// Endpoints para gestión de Permiso
///</summary>
///<history>
/// Create by Jonatan Abregu
///</history>
public sealed partial class UsuarioEndPoints : IEndpoint
{
    public string Prefix => "/login/usuario";

    /// <summary>
    /// Mapea todas las rutas de Permiso
    /// </summary>
    public void MapEndpoint(RouteGroupBuilder g)
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

        //g.MapPatch("/language", UpdateLanguageAsync)
        //    .WithResponses<GlobalCredencialModel>(StatusCodes.Status200OK)
        //    .WithDescription("Actualiza el idioma del app");
    }
}
public partial class UsuarioEndPoints
{

    private static async Task<IResult> LoginEmpresaAsync(
     [FromBody] UsuarioFilter f,
     IJwtService jwtService,
     IUsuarioService IUsuario,
     IIngresoService IIngreso,
     ILoggerFactory loggerFactory,
     UserContext user)
    {
        ILogger logger = loggerFactory.CreateLogger("Mozo.Api.Login");
        //ClaimsPrincipal user, HttpContext httpContext
        // CoUsuario y CoPersona vienen del token temporal
        int coUsuario = user.CoUsuarioRequired;
        int coEntidad = user.CoEntidadRequired;


        // Validar que la empresa pertenece al usuario
        UsuarioDetailResponse? usuario = await IUsuario.SelByEmpresaAsync(
            new()
            {
                CoEmpresa = f.CoEmpresa,
                CoUsuario = coUsuario
            });

        if (usuario is null)
            throw new UnauthorizedException("La empresa no pertenece al usuario.");

        string refreshToken = jwtService.GenerateRefreshToken();

        IngresoEntity ingreso = new()
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
            CoEmpresa = f.CoEmpresa,
            CoEntidad = usuario.CoEntidad,
            CoUsuario = usuario.CoUsuario,
            NoUsuario = usuario.NoUsuario,
            CoIngreso = ingreso.CoIngreso,
            FlSuperAdmin = usuario.FlSuperAdmin
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
        [FromBody] UsuarioFilter f,
        IJwtService jwtService,
        IUsuarioService IUsuario,
        IIngresoService IIngreso,
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


        UsuarioDetailResponse? usuario = await IUsuario.SelByUserAsync(f);
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

        List<EmpresaDetailResponse> empresas = usuario.EmpresaLst ?? [];
        int qtEmpresas = empresas.Count;

        switch (qtEmpresas)
        {
            case 0:
                logger.LogInformation(
                "[SECURITY] LOGIN_FAILED | Usuario: {Usuario}, Sin empresa",
                usuario.NoUsuario);
                throw new ValidationException("El usuario no tiene empresa");
            case 1:
                EmpresaDetailResponse empresa = empresas[0];
                string noTokenRefresh = jwtService.GenerateRefreshToken();

                IngresoEntity ingresoNew = new()
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
                    CoEntidad = usuario.CoEntidad,
                    CoUsuario = usuario.CoUsuario,
                    NoUsuario = usuario.NoUsuario,
                    NoNombreCompleto = usuario.NoEntidad,
                    CoIngreso = ingresoNew.CoIngreso,
                    FlSuperAdmin = usuario.FlSuperAdmin
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
                 "[SECURITY] LOGIN_SUCCESS | Usuario: {Usuario} | Empresa: {CoEmpresa} | Ingreso: {CoIngreso} | IP: {IP} | Agent: {Agent}",
                     usuario.NoUsuario,
                     empresa.CoEmpresa,
                     ingresoNew.CoIngreso,
                     ingresoNew.NoIp,
                     ingresoNew.NoUserAgent);

                return Results.Ok(globalCredencial);

            default:
                GlobalCredencialModel globalCredencialMayor1 = new()
                {
                    
                    NoToken = jwtService.GenerateAuthenticationToken(
                                                                    new()
                                                                        {
                                                                            CoEntidad = usuario.CoEntidad,
                                                                            CoUsuario = usuario.CoUsuario,
                                                                            NoUsuario = usuario.NoUsuario,
                                                                            NoNombreCompleto = usuario.NoEntidad,
                                                                        }
                    ),
                    EmpresaLst = empresas.Select(e => new GlobalCredentialEmpresaModel
                                                     {
                                                         CoEmpresa = e.CoEmpresa,
                                                         NoRazonSocial = e.NoRazonSocial
                                                     }
                                                ).ToList(),
                    FlRequiereSeleccionEmpresa = 1
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
        int? CoEntidad = user.CoEntidadRequired;
        int? coUsuario = user.CoUsuarioRequired;
        int? coIngreso = user.CoIngresoRequired;
        string? noUsuario = user.NoUsuarioRequired;
        //string? noUsuario2 = user.FindFirst(JwtRegisteredClaimNames.Sub)?.Value;

        if (coEmpresa == null || CoEntidad == null || coUsuario == null)
            throw new UnauthorizedException("Claims inválidos");

        // string token = httpContext.Request.Headers["Authorization"].ToString().Replace("Bearer ", "");


        GlobalCredencialModel globalCredencial = new()
        {
            Credencial = new()
            {
                CoEmpresa = coEmpresa,
                CoEntidad = CoEntidad,
                CoUsuario = coUsuario,
                NoUsuario = noUsuario,
                CoIngreso = coIngreso
            }
        };

        return Results.Ok(globalCredencial);
    }



    //static async Task<IResult>
    //    UpdateLanguageAsync(
    //    UsuarioEntity m,
    //    IUsuarioService IUsuario
    //    )
    //{
    //    if (m is null)
    //        throw new ArgumentNullException(nameof(m));

    //    await IUsuario.UpdateLanguageAsync(m);
    //    return Results.Ok(m);
    //}


}


