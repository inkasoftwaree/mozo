using Mozo.App.Suscripcion.PlanPrecio.Contracts;
using Mozo.Domain.Suscripcion;
using Mozo.Infrastructure.Persistence;
using Mozo.Infrastructure.Persistence.Builders;
using Mozo.Shared.Services;
using System.Data;

namespace Mozo.App.Suscripcion.PlanPrecio;

public interface IPlanPrecioService
{
    Task<int> InsertAsync(PlanPrecioEntity m);
    Task<int> UpdateByIdAsync(PlanPrecioEntity m);
    Task<int> DeleteByIdAsync(PlanPrecioFilter f);
    Task<IReadOnlyList<PlanPrecioListItem>> SelAllByPlanAsync(PlanPrecioFilter f);
}

public sealed class PlanPrecioService : IPlanPrecioService
{
    private readonly IDatabase _database;
    private readonly UserContext _user;

    public PlanPrecioService(IDatabase database, UserContext user)
    {
        _database = database;
        _user = user;
    }

    public Task<int> InsertAsync(PlanPrecioEntity m) =>
        _database.ScalarAsync<int>(PlanPrecioDbObjects.Insert,
            p => p.Add("CoPlan", m.CoPlan, DbType.Int32)
                  .Add("CoMoneda", m.CoMoneda, DbType.Int32)
                  .Add("NuCicloMeses", m.NuCicloMeses, DbType.Int16)
                  .Add("SsPrecio", m.SsPrecio, DbType.Decimal));

    public Task<int> UpdateByIdAsync(PlanPrecioEntity m) =>
        _database.ScalarAsync<int>(PlanPrecioDbObjects.UpdateById,
            p => p.Add("CoPlanPrecio", m.CoPlanPrecio, DbType.Int32)
                  .Add("SsPrecio", m.SsPrecio, DbType.Decimal)
                  .Add("FlVigente", m.FlVigente, DbType.Int32));

    public Task<int> DeleteByIdAsync(PlanPrecioFilter f) =>
        _database.ScalarAsync<int>(PlanPrecioDbObjects.DeleteById,
            p => p.Add("CoPlanPrecio", f.CoPlanPrecio, DbType.Int32)
                  .AddUserDelete(_user.CoUsuarioRequired));

    public Task<IReadOnlyList<PlanPrecioListItem>> SelAllByPlanAsync(PlanPrecioFilter f) =>
        _database.ListAsync<PlanPrecioListItem>(PlanPrecioDbObjects.SelAllByPlan,
            p => p.Add("CoPlan", f.CoPlan, DbType.Int32));
}
