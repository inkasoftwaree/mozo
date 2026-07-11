using Mozo.Api.Abstractions;
using Mozo.App.Login.Ingreso;
using Mozo.App.Login.Ingreso.Contracts;
using Mozo.App.Login.Usuario;
using Mozo.App.Login.Usuario.Contracts;
using Mozo.Domain.Seguridad;
using Mozo.Shared.Exceptions;
using Mozo.Shared.Services;
using Mozo.Shared.Token;
using Mozo.Shared.Token.Model;

namespace Mozo.Api.Login;

///<summary>
/// Endpoints para gestión de Ingreso
///</summary>
///<history>
/// Create by Jonatan Abregu
///</history>
public sealed partial class IngresoEndPoints : IEndpoint
{
    public string Prefix => "/login/ingreso";

    /// <summary>
    /// Mapea todas las rutas de Ingreso
    /// </summary>
    public void MapEndpoint(RouteGroupBuilder g)
    {
        g.WithSecurity();

        g.MapPost("/renew", RenewAsync)
            .AllowAnonymous()
            .WithResponses<GlobalCredencialModel>(StatusCodes.Status200OK)
            .WithDescription("Renueva el token");

        g.MapPost("/revoke", RevokeAsync)
            .AllowAnonymous()
            .WithResponsesValue<int>(StatusCodes.Status200OK)
            .WithDescription("Cerrar sessión. Idempotente: devuelve 0 si ya estaba revocada");

        g.MapPost("/revoke-all", RevokeAllAsync)
         .WithResponsesValue<int>(StatusCodes.Status200OK)
         .WithDescription("Cerrar todas las sessiones. Devuelve la cantidad revocada");
    }
}

public partial class IngresoEndPoints
{

    private static async Task<IResult>
        RevokeAsync(
            IngresoEntity m,
            IIngresoService IIngreso
        ) => Results.Ok(await IIngreso.RevokeAsync(m));


    private static async Task<IResult>
    RevokeAllAsync(
        IngresoEntity m,
        IIngresoService IIngreso
    ) => Results.Ok(await IIngreso.RevokeAllAsync(m));


    private static async Task<IResult>
    RenewAsync(
         IngresoFilter f,
        IJwtService jwtService,
        IUsuarioService IUsuario,
        IIngresoService IIngreso,
         UserContext user
    )
    {
        if (string.IsNullOrWhiteSpace(f?.NoRefreshToken))
            throw new ValidationException("NoRefreshToken", "Refresh token requerido");

        IngresoDetailResponse? ingresoActual = await IIngreso.SelByRefreshTokenAsync(new() { NoRefreshToken = f.NoRefreshToken });
        if (ingresoActual == null)
            throw new UnauthorizedException("Refresh token inválido o expirado");

        int rows = await IIngreso.ReplaceAsync(new() { NoRefreshToken = f.NoRefreshToken });
        if (rows == 0)
            throw new UnauthorizedException("Refresh token ya utilizado o revocado");

        UsuarioDetailResponse? usuario = await IUsuario.SelByIdAsync(new() { CoUsuario = ingresoActual.CoUsuario });

        if (usuario == null)
            throw new NotFoundException("Usuario no encontrado");

        int coEmpresa = user.CoEmpresaRequired;
        string? noTokenRefresh = jwtService.GenerateRefreshToken();

        IngresoEntity nuevoIngreso = new()
        {
            CoUsuario = usuario.CoUsuario,
            NoRefreshToken = noTokenRefresh,
            NoIp = jwtService.GetUserIp(),
            NoUserAgent = jwtService.GetUserAgent(),
            FeRefreshTokenExpire = jwtService.GetRefreshTokenExpiration()
        };
        nuevoIngreso.CoIngreso = await IIngreso.InsertAsync(nuevoIngreso);


        CredencialModel credential = new()
        {
            CoEmpresa = coEmpresa,
            CoEntidad = usuario.CoEntidad,
            CoUsuario = usuario.CoUsuario,
            NoUsuario = usuario.NoUsuario,
            CoIngreso = nuevoIngreso.CoIngreso
        };

        string token = jwtService.GenerateToken(credential);

        GlobalCredencialModel globalCredencial = new()
        {
            Credencial = credential,
            NoToken = token,
            NoTokenRefresh = noTokenRefresh
        };


        return Results.Ok(globalCredencial);
    }



}