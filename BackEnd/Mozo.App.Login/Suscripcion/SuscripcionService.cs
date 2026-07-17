using Mozo.Infrastructure.Persistence;
using Mozo.Shared.Token.Model;
using System.Data;

namespace Mozo.App.Login.Suscripcion;

public interface ISuscripcionService
{
    /// <summary>
    /// Estado de la suscripción de la empresa para el usuario dado (owner o no),
    /// usado en la respuesta del login. Devuelve siempre una fila.
    /// </summary>
    Task<SuscripcionEstadoModel?> EstadoByEmpresaAsync(int coEmpresa, int coUsuario);
}

public sealed class SuscripcionService : ISuscripcionService
{
    private readonly IDatabase _database;

    public SuscripcionService(IDatabase database)
    {
        _database = database;
    }

    public Task<SuscripcionEstadoModel?> EstadoByEmpresaAsync(int coEmpresa, int coUsuario) =>
        _database.FirstAsync<SuscripcionEstadoModel>(SuscripcionDbObjects.EstadoByEmpresa,
            p => p.Add("CoEmpresa", coEmpresa, DbType.Int32)
                  .Add("CoUsuario", coUsuario, DbType.Int32));
}
