using Mozo.App.Seguridad.Usuario.Contracts;
using Mozo.Domain.Seguridad;
using Mozo.Infrastructure.Persistence;
using Mozo.Infrastructure.Persistence.Builders;
using Mozo.Shared.Services;
using System.Data;

namespace Mozo.App.Seguridad.Usuario;

public interface IUsuarioService
{
    Task<int> InsertAsync(UsuarioEntity m);
    Task<int> UpdateByIdAsync(UsuarioEntity m);
    Task<int> UpdateClaveAsync(UsuarioEntity m);
    Task<int> UpdateStateByIdAsync(UsuarioEntity m);
    Task<UsuarioEditResponse?> SelByIdAsync(UsuarioFilter f);
}

public sealed class UsuarioService : IUsuarioService
{
    private readonly IDatabase _database;
    private readonly UserContext _user;

    public UsuarioService(IDatabase database, UserContext user)
    {
        _database = database;
        _user = user;
    }

    public Task<int> InsertAsync(UsuarioEntity m) =>
        _database.ScalarAsync<int>(UsuarioDbObjects.Insert,
            p => p.Add("CoEntidad", m.CoEntidad, DbType.Int32)
                  .Add("NoUsuario", m.NoUsuario, DbType.String)
                  .Add("NoClave", m.NoClave, DbType.String)
                  .AddUserCreate(_user.CoUsuarioRequired));

    public Task<int> UpdateByIdAsync(UsuarioEntity m) =>
        _database.ScalarAsync<int>(UsuarioDbObjects.UpdateById,
            p => p.Add("CoUsuario", m.CoUsuario, DbType.Int32)
                  .Add("NoUsuario", m.NoUsuario, DbType.String)
                  .Add("NoClave", m.NoClave, DbType.String)
                  .AddUserUpdate(_user.CoUsuarioRequired));

    public Task<int> UpdateClaveAsync(UsuarioEntity m) =>
        _database.ScalarAsync<int>(UsuarioDbObjects.UpdateClave,
            p => p.Add("CoUsuario", m.CoUsuario, DbType.Int32)
                  .Add("NoClaveNuevo", m.NoClave, DbType.String)
                  .AddUserUpdate(_user.CoUsuarioRequired));

    public Task<int> UpdateStateByIdAsync(UsuarioEntity m) =>
        _database.ScalarAsync<int>(UsuarioDbObjects.UpdateStateById,
            p => p.Add("CoUsuario", m.CoUsuario, DbType.Int32)
                  .Add("FlEstReg", m.FlEstReg, DbType.Int32)
                  .AddUserUpdate(_user.CoUsuarioRequired));

    public Task<UsuarioEditResponse?> SelByIdAsync(UsuarioFilter f) =>
        _database.FirstAsync<UsuarioEditResponse>(UsuarioDbObjects.SelById,
            p => p.Add("CoUsuario", f.CoUsuario, DbType.Int32));
}
