using NpgsqlTypes;
using System.Data;

namespace Mozo.Infrastructure.Persistence.Abstractions;

public interface IParameterBuilder
{
    IParameterBuilder Add(
        string name,
        object? value,
        DbType dbType);

    IParameterBuilder Add(
        string name,
        object? value);

    IParameterBuilder Add(
        string name,
        object? value,
        DbType? dbType,
        ParameterDirection direction);

    IParameterBuilder AddArray<T>(string name, T[] values);

    IParameterBuilder AddArray<T>(string name, T[] values, NpgsqlDbType elementType);
}