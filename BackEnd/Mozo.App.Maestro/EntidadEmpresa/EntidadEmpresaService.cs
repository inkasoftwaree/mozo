using Mozo.Domain.Maestro;
using Mozo.Infrastructure.Persistence;
using Mozo.Infrastructure.Persistence.Builders;
using Mozo.Shared.Services;
using System.Data;


namespace Mozo.App.Maestro.EntidadEmpresa;

public interface IEntidadEmpresaService
{
    Task<int> InsertAsync(EntidadEmpresaEntity m);
}

public sealed class EntidadEmpresaService : IEntidadEmpresaService
{
    private readonly IDatabase _database;
    private readonly UserContext _user;

    public EntidadEmpresaService(IDatabase database, UserContext user)
    {
        _database = database;
        _user = user;
    }

    public Task<int> InsertAsync(EntidadEmpresaEntity m) =>
        _database.ScalarAsync<int>(EntidadEmpresaDbObjects.Insert,
            p => p.Add("CoEntidad", _user.ResolveEmpresa(m.FlEmpresaNotKey, m.CoEmpresa))
                  .Add("", m.CoEntidad, DbType.Int32)
                  .AddUserCreate(_user.CoUsuarioRequired));


}