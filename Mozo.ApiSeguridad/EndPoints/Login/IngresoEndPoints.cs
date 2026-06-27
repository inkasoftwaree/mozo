using Microsoft.AspNetCore.Mvc;
using Mozo.ApiSeguridad.Helper;
using Mozo.ApiSeguridad.HelperWeb.Exceptions;
using Mozo.Helper.Global;
using Mozo.HelperWeb.Token;
using Mozo.LoginBusiness;
using Mozo.Model.Seguridad;
using Mozo.Model.Seguridad.Auth;

namespace Mozo.Api.Login;

///<summary>
/// Endpoints para gestión de Ingreso
///</summary>
///<history>
/// Create by Jonatan Abregu
///</history>
public static partial class IngresoEndPoints
{
    /// <summary>
    /// Mapea todas las rutas de Ingreso
    /// </summary>
    public static RouteGroupBuilder MapIngreso(this RouteGroupBuilder g)
    {
        g.WithSecurity();

        g.MapPost("/renew", RenewAsync)
            .AllowAnonymous()
            .WithResponses<GlobalCredencialModel>(StatusCodes.Status200OK)
            .WithDescription("Renueva el token");

        g.MapPost("/revoke", RevokeAsync)
            .AllowAnonymous()
            .WithResponses(StatusCodes.Status204NoContent)
            .WithDescription("Cerrar sessión");

        g.MapPost("/revoke-all", RevokeAllAsync)
         .WithResponses(StatusCodes.Status204NoContent)
         .WithDescription("Cerrar todas las sessiones");

        return g;
    }
}

public static partial class IngresoEndPoints
{

    private static async Task<IResult>
        RevokeAsync(
            IngresoModel m,
            IIngresoBusiness IIngreso
        )
    {
        await IIngreso.RevokeAsync(m);
        return Results.NoContent();
    }

    private static async Task<IResult>
    RevokeAllAsync(
        IngresoModel m,
        IIngresoBusiness IIngreso
    )
    {
        await IIngreso.RevokeAllAsync(m);
        return Results.NoContent();
    }

    private static async Task<IResult>
    RenewAsync(
         IngresoFilterDto f,
        IJwtService jwtService,
        IUsuarioBusiness IUsuario,
        IIngresoBusiness IIngreso,
         UserContext user
    )
    {
        if (string.IsNullOrWhiteSpace(f?.NoRefreshToken))
            throw new ValidationException("NoRefreshToken", "Refresh token requerido");

        IngresoModel? ingresoActual = await IIngreso.SelByRefreshTokenAsync(new() { NoRefreshToken = f.NoRefreshToken });
        if (ingresoActual == null)
            throw new UnauthorizedException("Refresh token inválido o expirado");

        int rows = await IIngreso.ReplaceAsync(new() { NoRefreshToken = f.NoRefreshToken });
        if (rows == 0)
            throw new UnauthorizedException("Refresh token ya utilizado o revocado");

        UsuarioModel? usuario = await IUsuario.SelByIdAsync(new() { CoUsuario = ingresoActual.CoUsuario });

        if (usuario == null)
            throw new NotFoundException("Usuario no encontrado");

        int coEmpresa = user.CoEmpresaRequired;
        string? noTokenRefresh = jwtService.GenerateRefreshToken();

        IngresoModel nuevoIngreso = new()
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
            CoPersona = usuario.CoPersona,
            CoUsuario = usuario.CoUsuario,
            NoUsuario = usuario.NoUsuario,
            NoNombreCompleto = usuario.NoPersona,
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