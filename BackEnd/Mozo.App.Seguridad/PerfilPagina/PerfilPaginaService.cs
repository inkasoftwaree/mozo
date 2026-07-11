using Mozo.App.Seguridad.PerfilPagina.Contracts;
using Mozo.Domain.Seguridad;
using Mozo.Infrastructure.Persistence;
using Mozo.Infrastructure.Persistence.Builders;
using Mozo.Shared.Services;
using System.Data;

namespace Mozo.App.Seguridad.PerfilPagina;

public interface IPerfilPaginaService
{
    Task<int> InsertAsync(PerfilPaginaEntity m);
    Task<int> DeleteByModuloAndPerfilAsync(PerfilPaginaFilter f);
    Task<IReadOnlyList<PerfilPaginaListItem>> SelAllAsync(PerfilPaginaFilter f);
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

    public Task<int> InsertAsync(PerfilPaginaEntity m) =>
        _database.ScalarAsync<int>(PerfilPaginaDbObjects.Insert,
            p => p.Add("CoModulo", m.CoModulo, DbType.Int32)
                  .Add("CoPerfil", m.CoPerfil, DbType.Int32)
                  .Add("CoPagina", m.CoPagina, DbType.Int32)
                  .Add("CoMenu", m.CoMenu, DbType.Int32)
                  .AddUserCreate(_user.CoUsuarioRequired));

    public Task<int> DeleteByModuloAndPerfilAsync(PerfilPaginaFilter f) =>
        _database.ScalarAsync<int>(PerfilPaginaDbObjects.DeleteByModuloAndPerfil,
            p => p.Add("CoModulo", f.CoModulo, DbType.Int32)
                  .Add("CoPerfil", f.CoPerfil, DbType.Int32)
                  .AddUserDelete(_user.CoUsuarioRequired));

    public Task<IReadOnlyList<PerfilPaginaListItem>> SelAllAsync(PerfilPaginaFilter f) =>
        _database.ListAsync<PerfilPaginaListItem>(PerfilPaginaDbObjects.SelAll,
            p => p.Add("CoModulo", f.CoModulo, DbType.Int32)
                  .Add("CoPerfil", f.CoPerfil, DbType.Int32));
}
