using Dapper;
using Npgsql;
using NpgsqlTypes;
using System.Data;

namespace Mozo.Infrastructure.Persistence.Abstractions;

public sealed class ParameterBuilder : IParameterBuilder
{
    private readonly DynamicParameters _parameters = new();

    internal DynamicParameters Parameters
        => _parameters;

    public IParameterBuilder Add(
        string name,
        object? value,
        DbType? dbType,
        ParameterDirection direction)
    {
        _parameters.Add(
            name,
            value,
            dbType,
            direction);

        return this;
    }

    public IParameterBuilder Add(string name, object? value, DbType dbType)
    {
        _parameters.Add(
            name,
            value,
            dbType);

        return this;
    }

    public IParameterBuilder Add(string name, object? value)
    {
        _parameters.Add(
            name,
            value);

        return this;
    }

    public IParameterBuilder AddArray<T>(string name, T[] values)
    {
        _parameters.Add(
            name,
            values);

        return this;
    }

    public IParameterBuilder AddArray<T>(string name, T[] values, NpgsqlDbType elementType)
    {
        _parameters.Add(name, new NpgsqlParameter
        {
            ParameterName = name,
            Value = values,
            NpgsqlDbType = NpgsqlDbType.Array | elementType
        });

        return this;
    }
}