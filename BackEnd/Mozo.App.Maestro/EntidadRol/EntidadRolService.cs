using Mozo.Domain.Maestro;
using Mozo.Infrastructure.Persistence;
using Mozo.Infrastructure.Persistence.Builders;
using Mozo.Shared.Services;
using System.Data;

namespace Mozo.App.Maestro.EntidadRol;

public interface IEntidadRolService
{
    Task<int> InsertAsync(EntidadRolEntity c);
    Task<int> UpdateByIdAsync(EntidadRolEntity c);
    Task<IEnumerable<EntidadRolEntity>> SelAllActiveByPersonAsync(EntidadRolFilter c);
    Task<IEnumerable<EntidadRolEntity>> SelAllActiveByModuleAndPersonAsync(EntidadRolFilter c);
    Task<IEnumerable<EntidadRolEntity>> SelAllActiveAsync(EntidadRolFilter c);
}

public sealed class EntidadRolService : IEntidadRolService
{
    private readonly IDatabase _database;
    private readonly UserContext _user;

    public EntidadRolService(IDatabase database, UserContext user)
    {
        _database = database;
        _user = user;
    }

    public Task<int> InsertAsync(EntidadRolEntity c) =>
        _database.ScalarAsync<int>(EntidadRolDbObjects.Insert,
            p => p
                .AddEmpresa(_user.CoEmpresaRequired)
                .Add("CoEntidad", c.CoEntidad, DbType.Int32)
                .Add("CoRolNegocio", c.CoRolNegocio, DbType.Int32)
                .Add("CoModulo", c.CoModulo, DbType.Int32)
                .AddUserCreate(_user.CoUsuarioRequired));

    public Task<int> UpdateByIdAsync(EntidadRolEntity c) =>
        _database.ScalarAsync<int>(EntidadRolDbObjects.UpdateById,
            p => p
                .Add("CoEntidadRol", c.CoEntidadRol, DbType.Int32)
                .Add("CoRolNegocio", c.CoRolNegocio, DbType.Int32)
                .AddUserUpdate(_user.CoUsuarioRequired));

    public async Task<IEnumerable<EntidadRolEntity>> SelAllActiveByPersonAsync(EntidadRolFilter c) =>
        await _database.ListAsync<EntidadRolEntity>(EntidadRolDbObjects.SelAllActiveByPersona,
            p => p
                .AddEmpresa(_user.CoEmpresaRequired)
                .Add("CoEntidad", c.CoEntidad, DbType.Int32));

    public async Task<IEnumerable<EntidadRolEntity>> SelAllActiveByModuleAndPersonAsync(EntidadRolFilter c) =>
        await _database.ListAsync<EntidadRolEntity>(EntidadRolDbObjects.SelAllActiveByModuloPersona,
            p => p
                .AddEmpresa(_user.CoEmpresaRequired)
                .Add("CoModulo", c.CoModulo, DbType.Int32)
                .Add("CoEntidad", c.CoEntidad, DbType.Int32));

    public async Task<IEnumerable<EntidadRolEntity>> SelAllActiveAsync(EntidadRolFilter c) =>
        await _database.ListAsync<EntidadRolEntity>(EntidadRolDbObjects.SelAllActive,
            p => p.AddEmpresa(_user.CoEmpresaRequired)
            );

}