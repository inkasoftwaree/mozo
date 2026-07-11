using Mozo.App.Login.Usuario.Contracts;
using Mozo.Infrastructure.Persistence;
using Mozo.Shared.Services;
using System.Data;

namespace Mozo.App.Login.Usuario;

public interface IUsuarioService
{
    Task<UsuarioDetailResponse?> SelByUserAsync(UsuarioFilter f);
    Task<UsuarioDetailResponse?> SelByIdAsync(UsuarioFilter f);
    Task<UsuarioDetailResponse?> SelByEmpresaAsync(UsuarioFilter f);
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

    public Task<UsuarioDetailResponse?> SelByUserAsync(UsuarioFilter f) =>
        _database.FirstAsync<UsuarioDetailResponse>(UsuarioDbObjects.SelByUser,
            p => p.Add("NoUsuario", f.NoUsuario, DbType.String));

    public Task<UsuarioDetailResponse?> SelByIdAsync(UsuarioFilter f) =>
        _database.FirstAsync<UsuarioDetailResponse>(UsuarioDbObjects.SelById,
            p => p.Add("CoUsuario", f.CoUsuario, DbType.Int32));

    public Task<UsuarioDetailResponse?> SelByEmpresaAsync(UsuarioFilter f) =>
        _database.FirstAsync<UsuarioDetailResponse>(UsuarioDbObjects.SelByEmpresa,
            p => p.Add("CoEmpresa", f.CoEmpresa, DbType.Int32)
                  .Add("CoUsuario", f.CoUsuario, DbType.Int32)
         );
}
