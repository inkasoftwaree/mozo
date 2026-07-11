using Mozo.App.Login.Ingreso.Contracts;
using Mozo.Domain.Seguridad;
using Mozo.Infrastructure.Persistence;
using Mozo.Shared.Services;
using System.Data;

namespace Mozo.App.Login.Ingreso;

public interface IIngresoService
{
    Task<int> InsertAsync(IngresoEntity m);
    Task<int> ReplaceAsync(IngresoEntity m);
    Task<IngresoDetailResponse?> SelByRefreshTokenAsync(IngresoFilter f);
    Task<int> RevokeAsync(IngresoEntity m);
    Task<int> RevokeAllAsync(IngresoEntity m);
}

public sealed class IngresoService : IIngresoService
{
    private readonly IDatabase _database;
    private readonly UserContext _user;

    public IngresoService(IDatabase database, UserContext user)
    {
        _database = database;
        _user = user;
    }

    public Task<int> InsertAsync(IngresoEntity m) =>
        _database.ScalarAsync<int>(IngresoDbObjects.Insert,
            p => p.Add("CoUsuario", m.CoUsuario, DbType.Int32)
                  .Add("NoIp", m.NoIp, DbType.String)
                  .Add("NoRefreshToken", m.NoRefreshToken, DbType.String)
                  .Add("NoUserAgent", m.NoUserAgent, DbType.String)
                  .Add("FeRefreshTokenExpire", m.FeRefreshTokenExpire, DbType.DateTime));

    public Task<int> ReplaceAsync(IngresoEntity m) =>
        _database.ScalarAsync<int>(IngresoDbObjects.Replace,
            p => p.Add("NoRefreshToken", m.NoRefreshToken, DbType.String));

    public Task<IngresoDetailResponse?> SelByRefreshTokenAsync(IngresoFilter f) =>
        _database.FirstAsync<IngresoDetailResponse>(IngresoDbObjects.SelByRefreshToken,
            p => p.Add("NoRefreshToken", f.NoRefreshToken, DbType.String));

    public Task<int> RevokeAsync(IngresoEntity m) =>
        _database.ScalarAsync<int>(IngresoDbObjects.Revoke,
            p => p.Add("NoRefreshToken", m.NoRefreshToken, DbType.String));

    public Task<int> RevokeAllAsync(IngresoEntity m) =>
        _database.ScalarAsync<int>(IngresoDbObjects.RevokeAll,
            p => p.Add("CoUsuario", m.CoUsuario, DbType.Int32));
}
