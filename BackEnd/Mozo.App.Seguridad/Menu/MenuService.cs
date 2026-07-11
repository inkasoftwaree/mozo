using Mozo.App.Seguridad.Menu.Contracts;
using Mozo.Domain.Seguridad;
using Mozo.Infrastructure.Persistence;
using Mozo.Infrastructure.Persistence.Builders;
using Mozo.Shared.Services;
using System.Data;

namespace Mozo.App.Seguridad.Menu;

public interface IMenuService
{
    Task<int> InsertAsync(MenuEntity m);
    Task<int> UpdateByIdAsync(MenuEntity m);
    Task<int> UpdateStateByIdAsync(MenuEntity m);
    Task<int> DeleteByIdAsync(MenuFilter f);
    Task<MenuEditResponse?> SelByIdAsync(MenuFilter f);
    Task<IReadOnlyList<MenuListItem>> SelAllAsync(MenuFilter f);
    Task<IReadOnlyList<MenuListItem>> SelAllActiveAsync(MenuFilter f);
}

public sealed class MenuService : IMenuService
{
    private readonly IDatabase _database;
    private readonly UserContext _user;

    public MenuService(IDatabase database, UserContext user)
    {
        _database = database;
        _user = user;
    }

    public Task<int> InsertAsync(MenuEntity m) =>
        _database.ScalarAsync<int>(MenuDbObjects.Insert,
            p => p.Add("CoModulo", m.CoModulo, DbType.Int32)
                  .Add("NuOrden", m.NuOrden, DbType.Int32)
                  .Add("NoMenu", m.NoMenu, DbType.String)
                  .AddUserCreate(_user.CoUsuarioRequired));

    public Task<int> UpdateByIdAsync(MenuEntity m) =>
        _database.ScalarAsync<int>(MenuDbObjects.UpdateById,
            p => p.Add("CoMenu", m.CoMenu, DbType.Int32)
                  .Add("NuOrden", m.NuOrden, DbType.Int32)
                  .Add("NoMenu", m.NoMenu, DbType.String)
                  .AddUserUpdate(_user.CoUsuarioRequired));

    public Task<int> UpdateStateByIdAsync(MenuEntity m) =>
        _database.ScalarAsync<int>(MenuDbObjects.UpdateStateById,
            p => p.Add("CoMenu", m.CoMenu, DbType.Int32)
                  .Add("FlEstReg", m.FlEstReg, DbType.Int32)
                  .AddUserUpdate(_user.CoUsuarioRequired));

    public Task<int> DeleteByIdAsync(MenuFilter f) =>
        _database.ScalarAsync<int>(MenuDbObjects.DeleteById,
            p => p.Add("CoMenu", f.CoMenu, DbType.Int32)
                  .AddUserDelete(_user.CoUsuarioRequired));

    public Task<MenuEditResponse?> SelByIdAsync(MenuFilter f) =>
        _database.FirstAsync<MenuEditResponse>(MenuDbObjects.SelById,
            p => p.Add("CoModulo", f.CoModulo, DbType.Int32)
                  .Add("CoMenu", f.CoMenu, DbType.Int32));

    public Task<IReadOnlyList<MenuListItem>> SelAllAsync(MenuFilter f) =>
        _database.ListAsync<MenuListItem>(MenuDbObjects.SelAll,
            p => p.Add("CoModulo", f.CoModulo, DbType.Int32));

    public Task<IReadOnlyList<MenuListItem>> SelAllActiveAsync(MenuFilter f) =>
        _database.ListAsync<MenuListItem>(MenuDbObjects.SelAllActive,
            p => p.Add("CoModulo", f.CoModulo, DbType.Int32));
}
