using Microsoft.IdentityModel.Tokens;
using Mozo.ApiSeguridad.Helper;
using System.Security.Cryptography;
namespace Mozo.Api.Login;

///<summary>
/// Endpoints para gestión de JwksPermiso
///</summary>
///<history>
/// Create by Jonatan Abregu
///</history>
public static partial class JwksEndPoints
{
    /// <summary>
    /// Mapea todas las rutas de JwksPermiso
    /// </summary>
    public static RouteGroupBuilder MapJwks(this RouteGroupBuilder g)
    {
        g.MapGet("/jwks.json",
            (IConfiguration configuration) =>
            {
                string publicKeyPath = configuration["JwtBearerTokenSettings:PublicKeyPath"]!;
                string publicKeyPem = File.ReadAllText(publicKeyPath);

                RSA rsa = RSA.Create();
                rsa.ImportFromPem(publicKeyPem);

                RSAParameters p = rsa.ExportParameters(false);

                return Results.Ok(new
                {
                    keys = new[]
                    {
                        new
                        {
                            kty = "RSA",
                            use = "sig",
                            alg = "RS256",
                            kid = "key-2026-01",
                            n = Base64UrlEncoder.Encode(p.Modulus),
                            e = Base64UrlEncoder.Encode(p.Exponent)
                        }
                    }
                });
            }).AllowAnonymous();
        return g;
    }
}

