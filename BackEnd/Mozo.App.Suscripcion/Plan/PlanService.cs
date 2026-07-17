using Mozo.App.Suscripcion.Plan.Contracts;
using Mozo.Domain.Suscripcion;
using Mozo.Infrastructure.Persistence;
using Mozo.Infrastructure.Persistence.Builders;
using Mozo.Shared.Models;
using Mozo.Shared.Services;
using System.Data;

namespace Mozo.App.Suscripcion.Plan;

public interface IPlanService
{
    Task<int> InsertAsync(PlanEntity m);
    Task<int> UpdateByIdAsync(PlanEntity m);
    Task<int> UpdateStateByIdAsync(PlanEntity m);
    Task<int> DeleteByIdAsync(PlanFilter f);
    Task<PlanEditResponse?> SelByIdAsync(PlanFilter f);
    Task<PagedResult<PlanListItem>> SelAllAsync(PlanFilter f);
    Task<IReadOnlyList<PlanOption>> SelAllActiveAsync();
}

public sealed class PlanService : IPlanService
{
    private readonly IDatabase _database;
    private readonly UserContext _user;

    public PlanService(IDatabase database, UserContext user)
    {
        _database = database;
        _user = user;
    }

    public Task<int> InsertAsync(PlanEntity m) =>
        _database.ScalarAsync<int>(PlanDbObjects.Insert,
            p => p.Add("NoPlan", m.NoPlan, DbType.String)
                  .Add("NoPlanDescripcion", m.NoPlanDescripcion, DbType.String)
                  .Add("NuOrden", m.NuOrden, DbType.Int16)
                  .Add("NuDiasPrueba", m.NuDiasPrueba, DbType.Int16)
                  .Add("Valor", m.Valor, DbType.String)
                  .Add("FlPublico", m.FlPublico, DbType.Int32)
                  .Add("FlDefault", m.FlDefault, DbType.Int32)
                  .AddUserCreate(_user.CoUsuarioRequired));

    public Task<int> UpdateByIdAsync(PlanEntity m) =>
        _database.ScalarAsync<int>(PlanDbObjects.UpdateById,
            p => p.Add("CoPlan", m.CoPlan, DbType.Int32)
                  .Add("NoPlan", m.NoPlan, DbType.String)
                  .Add("NoPlanDescripcion", m.NoPlanDescripcion, DbType.String)
                  .Add("NuOrden", m.NuOrden, DbType.Int16)
                  .Add("NuDiasPrueba", m.NuDiasPrueba, DbType.Int16)
                  .Add("Valor", m.Valor, DbType.String)
                  .Add("FlPublico", m.FlPublico, DbType.Int32)
                  .Add("FlDefault", m.FlDefault, DbType.Int32)
                  .AddUserUpdate(_user.CoUsuarioRequired));

    public Task<int> UpdateStateByIdAsync(PlanEntity m) =>
        _database.ScalarAsync<int>(PlanDbObjects.UpdateStateById,
            p => p.Add("CoPlan", m.CoPlan, DbType.Int32)
                  .Add("FlEstReg", m.FlEstReg, DbType.Int32)
                  .AddUserUpdate(_user.CoUsuarioRequired));

    public Task<int> DeleteByIdAsync(PlanFilter f) =>
        _database.ScalarAsync<int>(PlanDbObjects.DeleteById,
            p => p.Add("CoPlan", f.CoPlan, DbType.Int32)
                  .AddUserDelete(_user.CoUsuarioRequired));

    public Task<PlanEditResponse?> SelByIdAsync(PlanFilter f) =>
        _database.FirstAsync<PlanEditResponse>(PlanDbObjects.SelById,
            p => p.Add("CoPlan", f.CoPlan, DbType.Int32));

    public async Task<PagedResult<PlanListItem>> SelAllAsync(PlanFilter f)
    {
        IReadOnlyList<PlanListItem> r = await _database.ListAsync<PlanListItem>(PlanDbObjects.SelAll,
            p => p.Add("PageSize", f.PageSize, DbType.Int32)
                  .Add("PageIndex", f.PageIndex, DbType.Int32));

        return new PagedResult<PlanListItem>
        {
            Items = r,
            TotalRows = r.Count > 0 ? (r[0].RowsCount ?? 0) : 0,
            PageIndex = f.PageIndex ?? 0,
            PageSize = f.PageSize ?? 0
        };
    }

    public Task<IReadOnlyList<PlanOption>> SelAllActiveAsync() =>
        _database.ListAsync<PlanOption>(PlanDbObjects.SelAllActive);
}
