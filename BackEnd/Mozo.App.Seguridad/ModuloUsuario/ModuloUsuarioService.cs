using Mozo.App.Seguridad.ModuloUsuario.Contract;
using Mozo.App.Seguridad.ModuloUsuario.Contracts;
using Mozo.Domain.Seguridad;
using Mozo.Infrastructure.Persistence;
using Mozo.Infrastructure.Persistence.Builders;
using Mozo.Shared.Services;
using System.Data;

namespace Mozo.App.Seguridad.ModuloUsuario;

public interface IModuloUsuarioService
{
    Task<int> InsertAsync(ModuloUsuarioEntity m);
    Task<int> UpdateByIdAsync(ModuloUsuarioEntity m);
    Task<int> UpdateConfiguracionAsync(ModuloUsuarioEntity m);
    Task<int> DeleteByIdAsync(ModuloUsuarioFilter f);
    Task<ModuloUsuarioEditResponse?> SelByIdAsync(ModuloUsuarioFilter f);
    Task<IReadOnlyList<ModuloUsuarioListItem>> SelAllAsync(ModuloUsuarioFilter f);
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

    public Task<int> InsertAsync(ModuloUsuarioEntity m) =>
        _database.ScalarAsync<int>(ModuloUsuarioDbObjects.Insert,
            p => p.Add("CoEmpresa", m.CoEmpresa, DbType.Int32)
                  .Add("CoUsuario", m.CoUsuario, DbType.Int32)
                  .Add("CoModulo", m.CoModulo, DbType.Int32)
                  .Add("CoPerfil", m.CoPerfil, DbType.Int32)
                  .Add("FeExpiracion", m.FeExpiracion, DbType.Date));

    public Task<int> UpdateByIdAsync(ModuloUsuarioEntity m) =>
        _database.ScalarAsync<int>(ModuloUsuarioDbObjects.UpdateById,
            p => p.Add("CoModuloUsuario", m.CoModuloUsuario, DbType.Int32)
                  .Add("CoPerfil", m.CoPerfil, DbType.Int32)
                  .Add("FeExpiracion", m.FeExpiracion, DbType.String));

    public Task<int> UpdateConfiguracionAsync(ModuloUsuarioEntity m) =>
        _database.ScalarAsync<int>(ModuloUsuarioDbObjects.UpdateConfiguracion,
            p => p.Add("CoModuloUsuario", m.CoModuloUsuario, DbType.Int32)
                  .Add("Valor", m.Valor, DbType.String));

    public Task<int> DeleteByIdAsync(ModuloUsuarioFilter f) =>
        _database.ScalarAsync<int>(ModuloUsuarioDbObjects.DeleteById,
            p => p.Add("CoEmpresa", f.CoEmpresa, DbType.Int32)
                  .Add("CoModuloUsuario", f.CoModuloUsuario, DbType.Int32)
                  .AddUserDelete(_user.CoUsuarioRequired)
            );

    public Task<ModuloUsuarioEditResponse?> SelByIdAsync(ModuloUsuarioFilter f) =>
        _database.FirstAsync<ModuloUsuarioEditResponse>(ModuloUsuarioDbObjects.SelById,
            p => p.Add("CoModuloUsuario", f.CoModuloUsuario, DbType.Int32)
    );


    public Task<IReadOnlyList<ModuloUsuarioListItem>> SelAllAsync(ModuloUsuarioFilter f) =>
        _database.ListAsync<ModuloUsuarioListItem>(ModuloUsuarioDbObjects.SelAll,
            p => p.Add("CoUsuario", f.CoUsuario, DbType.Int32)
    );

}
