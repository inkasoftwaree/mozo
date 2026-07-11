using Mozo.App.Login.PerfilPagina.Contracts;
using Mozo.Infrastructure.Persistence;
using Mozo.Shared.Services;
using System.Data;

namespace Mozo.App.Login.PerfilPagina;

public interface IPerfilPaginaService
{
    Task<IReadOnlyList<PerfilPaginaListItem>> SelAllByModuloAndPerfilAsync(PerfilPaginaFilter f);
}

public sealed class PerfilPaginaService : IPerfilPaginaService
{
    private readonly IDatabase _database;
    private readonly UserContext _user;

    public PerfilPaginaService(IDatabase database, UserContext user)
    {
        _database = database;
        _user = user;
    }

    public Task<IReadOnlyList<PerfilPaginaListItem>> SelAllByModuloAndPerfilAsync(PerfilPaginaFilter f) =>
        _database.ListAsync<PerfilPaginaListItem>(PerfilPaginaDbObjects.SelAllByModuloAndPerfil,
            p => p.Add("CoModulo", f.CoModulo, DbType.Int32)
                  .Add("CoPerfil", f.CoPerfil, DbType.Int32));
}
