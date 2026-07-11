using System.Security.Claims;

namespace Mozo.Shared.Services;

public interface IClaimsService
{
    ClaimsPrincipal? User { get; }
    bool IsAuthenticated { get; }
    int? GetInt32(string claimType);
    string? GetString(string claimType);
}
