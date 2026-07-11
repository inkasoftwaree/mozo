using Microsoft.IdentityModel.Tokens;
using Mozo.Api.Abstractions;
using System.Security.Cryptography;
namespace Mozo.Api.Login;

///<summary>
/// Endpoints para gestión de JwksPermiso
///</summary>
///<history>
/// Create by Jonatan Abregu
///</history>
public sealed partial class JwksEndPoints : IEndpoint
{
    public string Prefix => "/.well-known";

    /// <summary>
    /// Mapea todas las rutas de JwksPermiso
    /// </summary>
    public void MapEndpoint(RouteGroupBuilder g)
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
    }
}

