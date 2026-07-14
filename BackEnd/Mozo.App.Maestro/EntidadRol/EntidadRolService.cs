using Mozo.App.Maestro.EntidadRol.Contracts;
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
    Task<IReadOnlyList<EntidadRolOption>> SelAllActiveByPersonAsync(EntidadRolFilter c);
    Task<IReadOnlyList<EntidadRolOption>> SelAllActiveByModuleAndPersonAsync(EntidadRolFilter c);
    Task<IReadOnlyList<EntidadRolOption>> SelAllActiveAsync(EntidadRolFilter c);
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

    public Task<IReadOnlyList<EntidadRolOption>> SelAllActiveByPersonAsync(EntidadRolFilter c) =>
        _database.ListAsync<EntidadRolOption>(EntidadRolDbObjects.SelAllActiveByPersona,
            p => p
                .AddEmpresa(_user.CoEmpresaRequired)
                .Add("CoEntidad", c.CoEntidad, DbType.Int32));

    public Task<IReadOnlyList<EntidadRolOption>> SelAllActiveByModuleAndPersonAsync(EntidadRolFilter c) =>
        _database.ListAsync<EntidadRolOption>(EntidadRolDbObjects.SelAllActiveByModuloPersona,
            p => p
                .AddEmpresa(_user.CoEmpresaRequired)
                .Add("CoModulo", c.CoModulo, DbType.Int32)
                .Add("CoEntidad", c.CoEntidad, DbType.Int32));

    public Task<IReadOnlyList<EntidadRolOption>> SelAllActiveAsync(EntidadRolFilter c) =>
        _database.ListAsync<EntidadRolOption>(EntidadRolDbObjects.SelAllActive,
            p => p.AddEmpresa(_user.CoEmpresaRequired));
}
