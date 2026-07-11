using Mozo.Infrastructure.Persistence.Abstractions;

namespace Mozo.Infrastructure.PostgreSql;

public interface IPostgreSqlExecutor
{
    Task ExecuteProcedureAsync(
        string schema,
        string procedure,
        Action<ParameterBuilder>? parameters = null);

    Task<T> ExecuteFunctionAsync<T>(
        string schema,
        string function,
        Action<ParameterBuilder>? parameters = null);

    Task<T?> QueryFirstAsync<T>(
        string schema,
        string function,
        Action<ParameterBuilder>? parameters = null);

    Task<IEnumerable<T>> QueryAsync<T>(
        string schema,
        string function,
        Action<ParameterBuilder>? parameters = null);
}