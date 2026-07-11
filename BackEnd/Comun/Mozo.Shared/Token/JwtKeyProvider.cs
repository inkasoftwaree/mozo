using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using System.Security.Cryptography;

namespace Mozo.Shared.Token;


public sealed class JwtKeyProvider
{
    public RsaSecurityKey PrivateKey { get; }
    public RsaSecurityKey PublicKey { get; }

    public JwtKeyProvider(IConfiguration configuration)
    {
        string privateKeyPath = configuration["JwtBearerTokenSettings:PrivateKeyPath"]!;
        string publicKeyPath = configuration["JwtBearerTokenSettings:PublicKeyPath"]!;

        RSA privateRsa = RSA.Create();
        privateRsa.ImportFromPem(File.ReadAllText(privateKeyPath));

        RSA publicRsa = RSA.Create();
        publicRsa.ImportFromPem(File.ReadAllText(publicKeyPath));

        PrivateKey = new RsaSecurityKey(privateRsa)
        {
            KeyId = "key-2026-01"
        };

        PublicKey = new RsaSecurityKey(publicRsa)
        {
            KeyId = "key-2026-01"
        };
    }

}