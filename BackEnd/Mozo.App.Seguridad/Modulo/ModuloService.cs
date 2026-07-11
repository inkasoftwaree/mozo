using Mozo.App.Seguridad.Modulo.Contracts;
using Mozo.Domain.Seguridad;
using Mozo.Infrastructure.Persistence;
using Mozo.Infrastructure.Persistence.Builders;
using Mozo.Shared.Services;
using System.Data;

namespace Mozo.App.Seguridad.Modulo;

public interface IModuloService
{
    Task<int> InsertAsync(ModuloEntity m);
    Task<int> UpdateByIdAsync(ModuloEntity m);
    Task<int> UpdateStateByIdAsync(ModuloEntity m);
    Task<int> DeleteByIdAsync(ModuloFilter f);
    Task<ModuloEditResponse?> SelByIdAsync(ModuloFilter f);
    Task<IReadOnlyList<ModuloListItem>> SelAllAsync(ModuloFilter f);
    Task<IReadOnlyList<ModuloOption>> SelAllActiveAsync();
}

public sealed class ModuloService : IModuloService
{
    private readonly IDatabase _database;
    private readonly UserContext _user;

    public ModuloService(IDatabase database, UserContext user)
    {
        _database = database;
        _user = user;
    }

    public Task<int> InsertAsync(ModuloEntity m) =>
        _database.ScalarAsync<int>(ModuloDbObjects.Insert,
            p => p.Add("NoModulo", m.NoModulo, DbType.String)
                  .Add("NoArea", m.NoArea, DbType.String)
                  .Add("NoModuloDescripcion", m.NoModuloDescripcion, DbType.String)
                  .Add("NuOrden", m.NuOrden, DbType.Int32)
                  .Add("NoIcono", m.NoIcono, DbType.String)
                  .Add("FlArea", m.FlArea, DbType.Int32)
                  .AddUserCreate(_user.CoUsuarioRequired));

    public Task<int> UpdateByIdAsync(ModuloEntity m) =>
        _database.ScalarAsync<int>(ModuloDbObjects.UpdateById,
            p => p.Add("CoModulo", m.CoModulo, DbType.Int32)
                  .Add("NoModulo", m.NoModulo, DbType.String)
                  .Add("NoArea", m.NoArea, DbType.String)
                  .Add("NoModuloDescripcion", m.NoModuloDescripcion, DbType.String)
                  .Add("NuOrden", m.NuOrden, DbType.Int32)
                  .Add("NoIcono", m.NoIcono, DbType.String)
                  .Add("FlArea", m.FlArea, DbType.Int32)
                  .AddUserUpdate(_user.CoUsuarioRequired));

    public Task<int> UpdateStateByIdAsync(ModuloEntity m) =>
        _database.ScalarAsync<int>(ModuloDbObjects.UpdateStateById,
            p => p.Add("CoModulo", m.CoModulo, DbType.Int32)
                  .Add("FlEstReg", m.FlEstReg, DbType.Int32)
                  .AddUserUpdate(_user.CoUsuarioRequired));

    public Task<int> DeleteByIdAsync(ModuloFilter f) =>
        _database.ScalarAsync<int>(ModuloDbObjects.DeleteById,
            p => p.Add("CoModulo", f.CoModulo, DbType.Int32)
                  .AddUserDelete(_user.CoUsuarioRequired));

    public Task<ModuloEditResponse?> SelByIdAsync(ModuloFilter f) =>
        _database.FirstAsync<ModuloEditResponse>(ModuloDbObjects.SelById,
            p => p.Add("CoModulo", f.CoModulo, DbType.Int32));

    public async Task<IReadOnlyList<ModuloListItem>> SelAllAsync(ModuloFilter f)
    {
        IReadOnlyList<ModuloListItem> r = await _database.ListAsync<ModuloListItem>(ModuloDbObjects.SelAll,
            p => p.Add("CoModulo", f.CoModulo, DbType.Int32));

        return [.. r.OrderBy(s => s.NuOrden)];
    }

    public async Task<IReadOnlyList<ModuloOption>> SelAllActiveAsync()
    {
        IReadOnlyList<ModuloOption> r = await _database.ListAsync<ModuloOption>(ModuloDbObjects.SelAllActive);
        return [.. r.OrderBy(s => s.NuOrden)];
    }



}
