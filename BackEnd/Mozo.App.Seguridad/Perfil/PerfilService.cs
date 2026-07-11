using Mozo.App.Seguridad.Perfil.Contracts;
using Mozo.Domain.Seguridad;
using Mozo.Infrastructure.Persistence;
using Mozo.Infrastructure.Persistence.Builders;
using Mozo.Shared.Services;
using System.Data;

namespace Mozo.App.Seguridad.Perfil;

public interface IPerfilService
{
    Task<int> InsertAsync(PerfilEntity m);
    Task<int> UpdateByIdAsync(PerfilEntity m);
    Task<int> UpdateStateByIdAsync(PerfilEntity m);
    Task<int> DeleteByIdAsync(PerfilFilter f);
    Task<PerfilEditResponse?> SelByIdAsync(PerfilFilter f);
    Task<PerfilEditResponse?> SelDefaultAsync(PerfilFilter f);
    Task<IReadOnlyList<PerfilListItem>> SelAllAsync(PerfilFilter f);
    Task<IReadOnlyList<PerfilOption>> SelAllActiveAsync(PerfilFilter f);
}

public sealed class PerfilService : IPerfilService
{
    private readonly IDatabase _database;
    private readonly UserContext _user;

    public PerfilService(IDatabase database, UserContext user)
    {
        _database = database;
        _user = user;
    }

    public Task<int> InsertAsync(PerfilEntity m) =>
        _database.ScalarAsync<int>(PerfilDbObjects.Insert,
            p => p.Add("CoModulo", m.CoModulo, DbType.Int32)
                  .Add("NoPerfil", m.NoPerfil, DbType.String)
                  .Add("FlDefault", m.FlDefault, DbType.Int32)
                  .Add("FlAdmin", m.FlAdmin, DbType.Int32)
                  .AddUserCreate(_user.CoUsuarioRequired));

    public Task<int> UpdateByIdAsync(PerfilEntity m) =>
        _database.ScalarAsync<int>(PerfilDbObjects.UpdateById,
            p => p.Add("CoModulo", m.CoModulo, DbType.Int32)
                  .Add("CoPerfil", m.CoPerfil, DbType.Int32)
                  .Add("NoPerfil", m.NoPerfil, DbType.String)
                  .Add("FlDefault", m.FlDefault, DbType.Int32)
                  .AddUserUpdate(_user.CoUsuarioRequired));

    public Task<int> UpdateStateByIdAsync(PerfilEntity m) =>
        _database.ScalarAsync<int>(PerfilDbObjects.UpdateStateById,
            p => p.Add("CoModulo", m.CoModulo, DbType.Int32)
                  .Add("CoPerfil", m.CoPerfil, DbType.Int32)
                  .Add("FlEstReg", m.FlEstReg, DbType.Int32)
                  .Add("FlDefault", m.FlDefault, DbType.Int32)
                  .AddUserUpdate(_user.CoUsuarioRequired));

    public Task<int> DeleteByIdAsync(PerfilFilter f) =>
        _database.ScalarAsync<int>(PerfilDbObjects.DeleteById,
            p => p.Add("CoPerfil", f.CoPerfil, DbType.Int32)
                  .AddUserDelete(_user.CoUsuarioRequired));

    public Task<PerfilEditResponse?> SelByIdAsync(PerfilFilter f) =>
        _database.FirstAsync<PerfilEditResponse>(PerfilDbObjects.SelById,
            p => p.Add("CoModulo", f.CoModulo, DbType.Int32)
                  .Add("CoPerfil", f.CoPerfil, DbType.Int32));

    public Task<PerfilEditResponse?> SelDefaultAsync(PerfilFilter f) =>
        _database.FirstAsync<PerfilEditResponse>(PerfilDbObjects.SelDefault,
            p => p.Add("CoModulo", f.CoModulo, DbType.Int32));

    public async Task<IReadOnlyList<PerfilListItem>> SelAllAsync(PerfilFilter f)
    {
        IReadOnlyList<PerfilListItem> r = await _database.ListAsync<PerfilListItem>(PerfilDbObjects.SelAll,
            p => p.Add("CoModulo", f.CoModulo, DbType.Int32)
                  .Add("CoPerfil", f.CoPerfil, DbType.Int32));

        return [.. r.OrderBy(x => x.NoPerfil)];
    }


    public async Task<IReadOnlyList<PerfilOption>> SelAllActiveAsync(PerfilFilter f)
    {
        IReadOnlyList<PerfilOption> r = await _database.ListAsync<PerfilOption>(PerfilDbObjects.SelAllActive,
            p => p.Add("CoModulo", f.CoModulo, DbType.Int32));
        return [.. r.OrderBy(x => x.NoPerfil)];
    }

}
