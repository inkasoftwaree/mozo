using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.Extensions.Logging;

namespace Mozo.HelperWeb.Token;

public class Authentication : JwtBearerEvents
{
    private readonly ILogger<Authentication> _logger;

    public Authentication(ILogger<Authentication> logger)
    {
        _logger = logger;
    }

    public override Task TokenValidated(TokenValidatedContext context)
    {
        if (!JwtService.TokenNoExpiro(context.SecurityToken.ValidTo, context.SecurityToken.ValidFrom))
        {
            context.Fail("Token Expiro.");
            return Task.CompletedTask;
        }
        return Task.CompletedTask;
    }

    public override Task Challenge(JwtBearerChallengeContext context)
    {
        return Task.CompletedTask;
    }

    public override Task Forbidden(ForbiddenContext context)
    {
        return Task.CompletedTask;
    }
    public override Task MessageReceived(MessageReceivedContext context)
    {

        return Task.CompletedTask;
    }

    public override Task AuthenticationFailed(AuthenticationFailedContext context)
    {
        _logger.LogInformation(context.Exception, "JWT authentication failed");
        return Task.CompletedTask;
    }

}
