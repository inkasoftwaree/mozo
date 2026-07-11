using Mozo.App.Login.ModuloUsuario.Contracts;
using Mozo.Infrastructure.Persistence;
using Mozo.Shared.Services;
using System.Data;

namespace Mozo.App.Login.ModuloUsuario;

public interface IModuloUsuarioService
{
    Task<ModuloUsuarioDetailResponse?> SelByIdAsync(ModuloUsuarioFilter f);
    Task<ModuloUsuarioDetailResponse?> SelByModuloAsync(ModuloUsuarioFilter f);
    Task<IReadOnlyList<ModuloUsuarioListItem>> SelAllByUsuarioAsync(ModuloUsuarioFilter f);
}

public sealed class ModuloUsuarioService : IModuloUsuarioService
{
    private readonly IDatabase _database;
    private readonly UserContext _user;

    public ModuloUsuarioService(IDatabase database, UserContext user)
    {
        _database = database;
        _user = user;
    }

    public Task<ModuloUsuarioDetailResponse?> SelByIdAsync(ModuloUsuarioFilter f) =>
        _database.FirstAsync<ModuloUsuarioDetailResponse>(ModuloUsuarioDbObjects.SelById,
            p => p.Add("CoModuloUsuario", f.CoModuloUsuario, DbType.Int32));

    public Task<ModuloUsuarioDetailResponse?> SelByModuloAsync(ModuloUsuarioFilter f) =>
        _database.FirstAsync<ModuloUsuarioDetailResponse>(ModuloUsuarioDbObjects.SelByModulo,
            p => p.Add("CoModulo", f.CoModulo, DbType.Int32)
                  .Add("CoUsuario", f.CoUsuario, DbType.Int32));

    public async Task<IReadOnlyList<ModuloUsuarioListItem>> SelAllByUsuarioAsync(ModuloUsuarioFilter f)
    {
        IReadOnlyList<ModuloUsuarioListItem> r = await _database.ListAsync<ModuloUsuarioListItem>(ModuloUsuarioDbObjects.SelAllByUsuario,
            p => p.Add("CoEmpresa", _user.CoEmpresaRequired, DbType.Int32)
                  .Add("CoUsuario", f.CoUsuario, DbType.Int32));
        return [.. r.OrderBy(x => x.NuOrden)];
    }

}
