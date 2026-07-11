using Dapper;
using Mozo.Infrastructure.Persistence.Abstractions;
using Mozo.Infrastructure.Persistence.Objects;
using System.Data;
using System.Data.Common;

namespace Mozo.Infrastructure.Persistence.PostgreSql;

internal sealed class PostgreSqlDatabase : IDatabase
{
    private readonly DbConnection _connection;

    private readonly TransactionContext _transactionContext;

    public PostgreSqlDatabase(
    DbConnection connection,
    TransactionContext transactionContext)
    {
        _connection = connection;
        _transactionContext = transactionContext;
    }

    public async Task ExecuteAsync(
    DbObject dbObject,
    Action<IParameterBuilder>? configure = null,
    CancellationToken cancellationToken = default)
    {
        var command = CreateCommand(
            dbObject,
            configure,
            cancellationToken);

        await _connection.ExecuteAsync(command);
    }

    public async Task<T> ScalarAsync<T>(
        DbObject dbObject,
        Action<IParameterBuilder>? parameters = null,
        CancellationToken cancellationToken = default)
    {
        var command = CreateCommand(
           dbObject,
           parameters,
           cancellationToken);

        return (await _connection.ExecuteScalarAsync<T>(command))!;
    }

    public async Task<T?> FirstAsync<T>(
        DbObject dbObject,
        Action<IParameterBuilder>? parameters = null,
        CancellationToken cancellationToken = default)
    {
        var command = CreateCommand(
            dbObject,
            parameters,
            cancellationToken);

        return await _connection.QueryFirstOrDefaultAsync<T>(command);
    }

    public async Task<IReadOnlyList<T>> ListAsync<T>(
       DbObject dbObject,
       Action<IParameterBuilder>? parameters = null,
       CancellationToken cancellationToken = default)
    {
        var command = CreateCommand(
            dbObject,
            parameters,
            cancellationToken);

        var result = await _connection.QueryAsync<T>(command);

        return result.AsList();
    }



    public async Task<T> ExecuteTransactionAsync<T>(
     Func<Task<T>> action,
     CancellationToken cancellationToken = default)
    {
        // Ya existe una transacción (llamada anidada)
        if (_transactionContext.HasTransaction)
            return await action();

        if (_connection.State != ConnectionState.Open)
            await _connection.OpenAsync(cancellationToken);

        await using DbTransaction transaction =
            await _connection.BeginTransactionAsync(cancellationToken);

        _transactionContext.CurrentTransaction = transaction;

        try
        {
            T result = await action();

            await transaction.CommitAsync(cancellationToken);

            return result;
        }
        catch
        {
            await transaction.RollbackAsync(cancellationToken);

            throw;
        }
        finally
        {
            _transactionContext.CurrentTransaction = null;
        }
    }


    public Task ExecuteTransactionAsync(
        Func<Task> action,
        CancellationToken cancellationToken = default)
    {
        return ExecuteTransactionAsync(async () =>
        {
            await action();

            return true;
        }, cancellationToken);
    }

    private CommandDefinition CreateCommand(
      DbObject dbObject,
      Action<IParameterBuilder>? configure,
      CancellationToken cancellationToken)
    {
        var builder = new ParameterBuilder();

        configure?.Invoke(builder);

        return new CommandDefinition(
            commandText: BuildSql(dbObject, builder.Parameters),
            parameters: builder.Parameters,
            transaction: _transactionContext.CurrentTransaction,
            cancellationToken: cancellationToken);
    }

    private static string BuildSql(
    DbObject dbObject,
    DynamicParameters parameters)
    {
        string arguments = string.Join(
            ", ",
            parameters.ParameterNames.Select(x => $"@{x}"));

        // Nombre calificado con esquema (schema.objeto) para no depender del search_path.
        string target = $"{dbObject.Schema}.{dbObject.Name}";

        return dbObject.Execution switch
        {
            DbExecutionType.Call
                => $"CALL {target}({arguments})",

            // Las funciones que devuelven filas (RETURNS TABLE / SETOF) deben
            // invocarse con SELECT * FROM fn(...); las escalares con SELECT fn(...).
            DbExecutionType.Select
                => dbObject.ReturnType is DbReturnType.Single or DbReturnType.List
                    ? $"SELECT * FROM {target}({arguments})"
                    : $"SELECT {target}({arguments})",

            _ => throw new InvalidOperationException(
                $"Tipo de ejecución '{dbObject.Execution}' no soportado.")
        };
    }

    public async Task<IReadOnlyList<TReturn>> ListAsync<TFirst, TSecond, TReturn>(
      DbObject obj,
      Func<TFirst, TSecond, TReturn> map,
      string splitOn,
      Action<IParameterBuilder>? configure = null)
    {
        var command = CreateCommand(obj, configure, CancellationToken.None);

        var result = await _connection.QueryAsync(command, map, splitOn);

        return result.AsList();
    }

    public async Task<TReturn?> FirstAsync<TFirst, TSecond, TReturn>(
      DbObject obj,
      Func<TFirst, TSecond, TReturn> map,
      string splitOn,
      Action<IParameterBuilder>? configure = null)
    {
        var command = CreateCommand(obj, configure, CancellationToken.None);

        var result = await _connection.QueryAsync(command, map, splitOn);

        return result.FirstOrDefault();
    }
}
