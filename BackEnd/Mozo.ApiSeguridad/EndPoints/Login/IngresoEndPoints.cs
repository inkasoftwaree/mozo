using Microsoft.AspNetCore.Mvc;
using Mozo.ApiSeguridad.Helper;
using Mozo.ApiSeguridad.HelperWeb.Exceptions;
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
        IPermisoBusiness IPermiso,
        IIngresoBusiness IIngreso
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

        PermisoModel? permiso = await IPermiso.SelByIdAsync(new() { CoEmpresa = ingresoActual.CoEmpresa, CoPermiso = ingresoActual.CoPermiso });

        if (permiso == null)
            throw new NotFoundException("Usuario no encontrado");


        string? noTokenRefresh = jwtService.GenerateRefreshToken();

        IngresoModel nuevoIngreso = new()
        {
            CoEmpresa = permiso.CoEmpresa,
            CoPersona = permiso.CoPersona,
            CoPermiso = permiso.CoPermiso,
            NoRefreshToken = noTokenRefresh,
            NoIp = jwtService.GetUserIp(),
            NoUserAgent = jwtService.GetUserAgent(),
            FeRefreshTokenExpire = jwtService.GetRefreshTokenExpiration()
        };
        nuevoIngreso.CoIngreso = await IIngreso.InsertAsync(nuevoIngreso);


        CredencialModel credential = new()
        {
            CoEmpresa = permiso.CoEmpresa,
            CoPersona = permiso.CoPersona,
            CoPermiso = permiso.CoPermiso,
            NoUsuario = permiso.NoUsuario,
            NoNombreCompleto = permiso.NoNombreCompleto,
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