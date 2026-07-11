using Microsoft.Extensions.DependencyInjection;

namespace Mozo.Infrastructure.Persistence;

public static class DependencyInjection
{
    public static IServiceCollection AddPersistence(
        this IServiceCollection services)
    {
        services.AddScoped<TransactionContext>();
        services.AddScoped<IDatabase, PostgreSql.PostgreSqlDatabase>();

        return services;
    }
}