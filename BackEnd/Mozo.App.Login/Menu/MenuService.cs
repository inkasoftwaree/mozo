using Mozo.App.Login.Menu.Contracts;
using Mozo.Infrastructure.Persistence;
using Mozo.Infrastructure.Persistence.Builders;
using Mozo.Shared.Services;
using System.Data;

namespace Mozo.App.Login.Menu;

public interface IMenuService
{
    Task<IReadOnlyList<MenuListItem>> SelAllAsync(MenuFilter f);
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

    public async Task<IReadOnlyList<MenuListItem>> SelAllAsync(MenuFilter f)
    {
        IReadOnlyList<MenuListItem> r = await _database.ListAsync<MenuListItem>(MenuDbObjects.SelAll,
            p => p.AddEmpresa(_user.CoEmpresaRequired)
                  .Add("CoModulo", f.CoModulo, DbType.Int32)
                  .Add("CoUsuario", _user.CoUsuarioRequired, DbType.Int32));

        return [.. r.OrderBy(x => x.NuOrden)];
    }

}
