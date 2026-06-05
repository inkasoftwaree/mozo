using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;

using Mozo.Helper.Global;
using Mozo.Model.Seguridad.Auth;

using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Security.Cryptography;

namespace Mozo.HelperWeb.Token;

public interface IJwtService
{
    string GenerateToken(CredencialModel credential);
    string GenerateRefreshToken();
}
public sealed class JwtService : IJwtService
{
    private readonly JwtKeyProvider _keys;
    private readonly IConfiguration _configuration;

    public JwtService(
        JwtKeyProvider keys,
        IConfiguration configuration)
    {
        _keys = keys;
        _configuration = configuration;
    }
    public string GenerateRefreshToken()
    {
        Guid g = Guid.NewGuid();
        return g.ToString("N");
    }

    public string GenerateToken(
        CredencialModel credential)
    {
        //string privateKeyPath = _configuration["JwtBearerTokenSettings:PrivateKeyPath"]!;
        //string privateKeyPem = File.ReadAllText(privateKeyPath);
        //RSA rsa = RSA.Create(); rsa.ImportFromPem(privateKeyPem);

        //RsaSecurityKey rsaKey = new(rsa)
        //{
        //    KeyId = "key-2026-01"
        //};

        var signingCredentials =
            new SigningCredentials(
                _keys.PrivateKey,
                SecurityAlgorithms.RsaSha256);


        // Datos del usuario
        List<Claim> claimCollection = new();

        DateTime utcNow = DateTime.UtcNow;

        claimCollection.Add(new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()));

        claimCollection.Add(new Claim(JwtRegisteredClaimNames.Iat, new DateTimeOffset(utcNow).ToUnixTimeSeconds().ToString(), ClaimValueTypes.Integer64));

        claimCollection.Add(new Claim(JwtRegisteredClaimNames.Sub, credential.NoUsuario ?? string.Empty));

        if (credential.CoEmpresa != null)
            claimCollection.Add(new Claim("CoEmpresa", credential.CoEmpresa!.Text()));

        if (credential.CoPersona != null)
            claimCollection.Add(new Claim("CoPersona", credential.CoPersona!.Text()));

        if (credential.CoPermiso != null)
            claimCollection.Add(new Claim("CoPermiso", credential.CoPermiso!.Text()));

        if (credential.CoIngreso != null)
            claimCollection.Add(new Claim("CoIngreso", credential.CoIngreso!.Text()));

        if (credential.NoUsuario != null)
            claimCollection.Add(
      new Claim(
          "NoUsuario",
          credential.NoUsuario));


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
        //byte[] SecretKey = Encoding.ASCII.GetBytes(configuration.GetSection("JwtBearerTokenSettings").GetSection("SecretKey").Value!);
        //SymmetricSecurityKey securityKey = new SymmetricSecurityKey(SecretKey);
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


  


}
