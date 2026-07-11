using Mozo.App.Login.Modulo.Contracts;
using Mozo.Infrastructure.Persistence;
using Mozo.Shared.Services;
using System.Data;

namespace Mozo.App.Login.Modulo;

public interface IModuloService
{
    Task<ModuloDetailResponse?> SelByIdAsync(ModuloFilter f);
    Task<IReadOnlyList<ModuloOption>> SelAllAsync();
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

    public Task<ModuloDetailResponse?> SelByIdAsync(ModuloFilter f) =>
        _database.FirstAsync<ModuloDetailResponse>(ModuloDbObjects.SelById,
            p => p.Add("CoModulo", f.CoModulo, DbType.Int32));

    public async Task<IReadOnlyList<ModuloOption>> SelAllAsync()
    {
        IReadOnlyList<ModuloOption> r = await _database.ListAsync<ModuloOption>(ModuloDbObjects.SelAll);
        return [.. r.OrderBy(x => x.NuOrden)];
    }
}
