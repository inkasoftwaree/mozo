using Mozo.Infrastructure.Persistence.Abstractions;
using Mozo.Infrastructure.Persistence.Objects;

namespace Mozo.Infrastructure.Persistence;

public interface IDatabase
{
    Task ExecuteAsync(
        DbObject dbObject,
        Action<IParameterBuilder>? parameters = null,
        CancellationToken cancellationToken = default);

    Task<T> ScalarAsync<T>(
        DbObject dbObject,
        Action<IParameterBuilder>? parameters = null,
        CancellationToken cancellationToken = default);

    Task<T?> FirstAsync<T>(
        DbObject dbObject,
        Action<IParameterBuilder>? parameters = null,
        CancellationToken cancellationToken = default);

    Task<TReturn?> FirstAsync<TFirst, TSecond, TReturn>(
        DbObject obj,
        Func<TFirst, TSecond, TReturn> map,
        string splitOn,
        Action<IParameterBuilder>? configure = null);

    Task<IReadOnlyList<T>> ListAsync<T>(
        DbObject dbObject,
        Action<IParameterBuilder>? parameters = null,
        CancellationToken cancellationToken = default);

    Task<IReadOnlyList<TReturn>> ListAsync<TFirst, TSecond, TReturn>(
        DbObject obj,
        Func<TFirst, TSecond, TReturn> map,
        string splitOn,
        Action<IParameterBuilder>? configure = null);

    Task ExecuteTransactionAsync(
        Func<Task> action,
         CancellationToken cancellationToken = default);

    Task<T> ExecuteTransactionAsync<T>(
        Func<Task<T>> action,
        CancellationToken cancellationToken = default);
}