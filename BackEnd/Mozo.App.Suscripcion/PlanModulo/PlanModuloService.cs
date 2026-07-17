using Mozo.App.Suscripcion.PlanModulo.Contracts;
using Mozo.Domain.Suscripcion;
using Mozo.Infrastructure.Persistence;
using Mozo.Infrastructure.Persistence.Builders;
using Mozo.Shared.Services;
using System.Data;

namespace Mozo.App.Suscripcion.PlanModulo;

public interface IPlanModuloService
{
    Task<int> InsertAsync(PlanModuloEntity m);
    Task<int> DeleteByIdAsync(PlanModuloFilter f);
    Task<IReadOnlyList<PlanModuloListItem>> SelAllByPlanAsync(PlanModuloFilter f);
}

public sealed class PlanModuloService : IPlanModuloService
{
    private readonly IDatabase _database;
    private readonly UserContext _user;

    public PlanModuloService(IDatabase database, UserContext user)
    {
        _database = database;
        _user = user;
    }

    public Task<int> InsertAsync(PlanModuloEntity m) =>
        _database.ScalarAsync<int>(PlanModuloDbObjects.Insert,
            p => p.Add("CoPlan", m.CoPlan, DbType.Int32)
                  .Add("CoModulo", m.CoModulo, DbType.Int32));

    public Task<int> DeleteByIdAsync(PlanModuloFilter f) =>
        _database.ScalarAsync<int>(PlanModuloDbObjects.DeleteById,
            p => p.Add("CoPlanModulo", f.CoPlanModulo, DbType.Int32)
                  .AddUserDelete(_user.CoUsuarioRequired));

    public Task<IReadOnlyList<PlanModuloListItem>> SelAllByPlanAsync(PlanModuloFilter f) =>
        _database.ListAsync<PlanModuloListItem>(PlanModuloDbObjects.SelAllByPlan,
            p => p.Add("CoPlan", f.CoPlan, DbType.Int32));
}
