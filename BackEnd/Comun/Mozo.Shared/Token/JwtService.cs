using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using Mozo.Shared.Token.Model;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Security.Cryptography;


namespace Mozo.Shared.Token;

public interface IJwtService
{
    string GenerateToken(CredencialModel credential);
    string GenerateAuthenticationToken(CredencialModel credential);
    string GenerateRefreshToken();
    DateTime GetRefreshTokenExpiration();

    string? GetUserIp();
    string GetUserAgent();
}
public sealed class JwtService : IJwtService
{
    private readonly JwtKeyProvider _keys;
    private readonly IConfiguration _configuration;
    private readonly IHttpContextAccessor _httpContextAccessor;
    public JwtService(
        JwtKeyProvider keys,
        IHttpContextAccessor httpContextAccessor,
        IConfiguration configuration)
    {
        _keys = keys;
        _configuration = configuration;
        _httpContextAccessor = httpContextAccessor;
    }

    public string? GetUserIp()
        => _httpContextAccessor.HttpContext?.Connection.RemoteIpAddress?.ToString();

    public string GetUserAgent()
    {
        string userAgent = _httpContextAccessor.HttpContext?.Request.Headers.UserAgent.ToString() ?? string.Empty;
        return userAgent.Length > 100
        ? userAgent[..99]
        : userAgent;
    }



    public string GenerateRefreshToken()
    {
        return Convert.ToHexString(
       RandomNumberGenerator.GetBytes(32));
    }

    public string GenerateToken(
        CredencialModel credential)
    {
        SigningCredentials signingCredentials = new(_keys.PrivateKey, SecurityAlgorithms.RsaSha256);

        // Datos del usuario
        List<Claim> claimCollection = new();

        DateTime utcNow = DateTime.UtcNow;

        claimCollection.Add(new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()));

        claimCollection.Add(new Claim(JwtRegisteredClaimNames.Iat, new DateTimeOffset(utcNow).ToUnixTimeSeconds().ToString(), ClaimValueTypes.Integer64));

        claimCollection.Add(new Claim(JwtRegisteredClaimNames.Sub, credential.NoUsuario ?? string.Empty));

        if (credential.CoEmpresa != null)
            claimCollection.Add(new Claim("CoEmpresa", credential.CoEmpresa!.ToString()!));

        if (credential.CoEntidad != null)
            claimCollection.Add(new Claim("CoEntidad", credential.CoEntidad!.ToString()!));

        if (credential.CoUsuario != null)
            claimCollection.Add(new Claim("CoUsuario", credential.CoUsuario!.ToString()!));

        if (credential.CoIngreso != null)
            claimCollection.Add(new Claim("CoIngreso", credential.CoIngreso!.ToString()!));

        if (credential.NoUsuario != null)
            claimCollection.Add(new Claim("NoUsuario", credential.NoUsuario));

        if (credential.FlSuperAdmin == 1)
            claimCollection.Add(new Claim("FlSuperAdmin", credential.FlSuperAdmin.ToString()!));


        DateTime feExpiracion = utcNow.AddMinutes(double.Parse(_configuration["JwtBearerTokenSettings:ExpiryTimeInMinute"]!));

        JwtSecurityToken jwtSecurityToken =
            new JwtSecurityToken(
                issuer: _configuration["JwtBearerTokenSettings:Issuer"],
                audience: _configuration["JwtBearerTokenSettings:Audience"],
                claims: claimCollection,
                notBefore: utcNow,
                expires: feExpiracion,
                signingCredentials: signingCredentials
            );

        string noToken = new JwtSecurityTokenHandler().WriteToken(jwtSecurityToken);

        return noToken;
    }
    public string GenerateAuthenticationToken(
      CredencialModel credential)
    {
        SigningCredentials signingCredentials = new(_keys.PrivateKey, SecurityAlgorithms.RsaSha256);

        // Datos del usuario
        List<Claim> claimCollection = new();

        DateTime utcNow = DateTime.UtcNow;

        claimCollection.Add(new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()));

        claimCollection.Add(new Claim(JwtRegisteredClaimNames.Iat, new DateTimeOffset(utcNow).ToUnixTimeSeconds().ToString(), ClaimValueTypes.Integer64));

        claimCollection.Add(new Claim(JwtRegisteredClaimNames.Sub, credential.NoUsuario ?? string.Empty));

        if (credential.CoEntidad != null)
            claimCollection.Add(new Claim("CoEntidad", credential.CoEntidad!.ToString()!));

        if (credential.CoUsuario != null)
            claimCollection.Add(new Claim("CoUsuario", credential.CoUsuario!.ToString()!));

        if (credential.NoUsuario != null)
            claimCollection.Add(new Claim("NoUsuario", credential.NoUsuario));

        if (credential.FlSuperAdmin == 1)
            claimCollection.Add(new Claim("FlSuperAdmin", credential.FlSuperAdmin.ToString()!));


        DateTime feExpiracion = utcNow.AddMinutes(5);

        JwtSecurityToken jwtSecurityToken =
            new JwtSecurityToken(
                issuer: _configuration["JwtBearerTokenSettings:Issuer"],
                audience: _configuration["JwtBearerTokenSettings:Audience"],
                claims: claimCollection,
                notBefore: utcNow,
                expires: feExpiracion,
                signingCredentials: signingCredentials
            );

        string noToken = new JwtSecurityTokenHandler().WriteToken(jwtSecurityToken);

        return noToken;
    }
    public static bool TokenNoExpiro(DateTime? to, DateTime? from)
    {
        DateTime now = DateTime.UtcNow;

        return to.HasValue &&
            from.HasValue &&
            now >= from.Value &&
            now <= to.Value;
    }

    public static TokenValidationParameters TokenParametro(IConfiguration configuration)
    {
        string publicKeyPath = configuration["JwtBearerTokenSettings:PublicKeyPath"]!;
        string publicKeyPem = File.ReadAllText(publicKeyPath);

        RSA rsa = RSA.Create();
        rsa.ImportFromPem(publicKeyPem);

        RsaSecurityKey publicKey = new(rsa);

        return new TokenValidationParameters
        {
            ValidateIssuer = true,
            ValidIssuer = configuration["JwtBearerTokenSettings:Issuer"],

            ValidateAudience = true,
            ValidAudience = configuration["JwtBearerTokenSettings:Audience"],

            ValidateLifetime = true,
            ValidateIssuerSigningKey = true,

            IssuerSigningKey = publicKey,

            ClockSkew = TimeSpan.Zero
        };
    }

    public DateTime GetRefreshTokenExpiration()
    {
        int days = _configuration.GetValue<int>("JwtBearerTokenSettings:RefreshTokenExpiryInDays");
        return DateTime.UtcNow.AddDays(days);
    }



}
