using Mozo.App.Suscripcion.Suscripcion.Contracts;
using Mozo.Domain.Suscripcion;
using Mozo.Infrastructure.Persistence;
using Mozo.Infrastructure.Persistence.Builders;
using Mozo.Shared.Models;
using Mozo.Shared.Services;
using System.Data;

namespace Mozo.App.Suscripcion.Suscripcion;

public interface ISuscripcionService
{
    Task<int> InsertAsync(SuscripcionEntity m);
    Task<SuscripcionEditResponse?> SelByIdAsync(SuscripcionFilter f);
    Task<PagedResult<SuscripcionListItem>> SelAllAsync(SuscripcionFilter f);
    Task<IReadOnlyList<SuscripcionEmpresaItem>> SelByEmpresaAsync(SuscripcionFilter f);
    Task<int> UpdateEstadoByIdAsync(SuscripcionEntity m);
    Task<int> CancelarAsync(SuscripcionEntity m);
    Task<int> RenovarAsync(SuscripcionEntity m);
    Task<int> ProcesarVencimientosAsync();
}

public sealed class SuscripcionService : ISuscripcionService
{
    private readonly IDatabase _database;
    private readonly UserContext _user;

    public SuscripcionService(IDatabase database, UserContext user)
    {
        _database = database;
        _user = user;
    }

    public Task<int> InsertAsync(SuscripcionEntity m) =>
        _database.ScalarAsync<int>(SuscripcionDbObjects.Insert,
            p => p.Add("CoEmpresa", m.CoEmpresa, DbType.Int32)
                  .Add("CoPlan", m.CoPlan, DbType.Int32)
                  .Add("CoPlanPrecio", m.CoPlanPrecio, DbType.Int32)
                  .Add("CoEstado", m.CoEstado, DbType.Int32)
                  .Add("FeInicio", m.FeInicio, DbType.Date)
                  .Add("FlAutoRenovar", m.FlAutoRenovar, DbType.Int32)
                  .AddUserCreate(_user.CoUsuarioRequired));

    public Task<SuscripcionEditResponse?> SelByIdAsync(SuscripcionFilter f) =>
        _database.FirstAsync<SuscripcionEditResponse>(SuscripcionDbObjects.SelById,
            p => p.Add("CoSuscripcion", f.CoSuscripcion, DbType.Int32));

    public async Task<PagedResult<SuscripcionListItem>> SelAllAsync(SuscripcionFilter f)
    {
        IReadOnlyList<SuscripcionListItem> r = await _database.ListAsync<SuscripcionListItem>(SuscripcionDbObjects.SelAll,
            p => p.Add("CoEstado", f.CoEstado, DbType.Int32)
                  .Add("PageSize", f.PageSize, DbType.Int32)
                  .Add("PageIndex", f.PageIndex, DbType.Int32));

        return new PagedResult<SuscripcionListItem>
        {
            Items = r,
            TotalRows = r.Count > 0 ? (r[0].RowsCount ?? 0) : 0,
            PageIndex = f.PageIndex ?? 0,
            PageSize = f.PageSize ?? 0
        };
    }

    public Task<IReadOnlyList<SuscripcionEmpresaItem>> SelByEmpresaAsync(SuscripcionFilter f) =>
        _database.ListAsync<SuscripcionEmpresaItem>(SuscripcionDbObjects.SelByEmpresa,
            p => p.Add("CoEmpresa", f.CoEmpresa ?? _user.CoEmpresaRequired, DbType.Int32));

    public Task<int> UpdateEstadoByIdAsync(SuscripcionEntity m) =>
        _database.ScalarAsync<int>(SuscripcionDbObjects.UpdateEstadoById,
            p => p.Add("CoSuscripcion", m.CoSuscripcion, DbType.Int32)
                  .Add("CoEstado", m.CoEstado, DbType.Int32)
                  .AddUserUpdate(_user.CoUsuarioRequired));

    public Task<int> CancelarAsync(SuscripcionEntity m) =>
        _database.ScalarAsync<int>(SuscripcionDbObjects.Cancelar,
            p => p.Add("CoSuscripcion", m.CoSuscripcion, DbType.Int32)
                  .Add("CoEstado", m.CoEstado, DbType.Int32)
                  .AddUserUpdate(_user.CoUsuarioRequired));

    public Task<int> RenovarAsync(SuscripcionEntity m) =>
        _database.ScalarAsync<int>(SuscripcionDbObjects.Renovar,
            p => p.Add("CoSuscripcion", m.CoSuscripcion, DbType.Int32)
                  .Add("CoEstado", m.CoEstado, DbType.Int32)
                  .AddUserUpdate(_user.CoUsuarioRequired));

    public Task<int> ProcesarVencimientosAsync() =>
        _database.ScalarAsync<int>(SuscripcionDbObjects.ProcesarVencimientos);
}
