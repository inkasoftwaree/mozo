using Mozo.Domain.Maestro;
using Mozo.Infrastructure.Persistence;
using Mozo.Infrastructure.Persistence.Builders;
using Mozo.Shared.Services;


namespace Mozo.App.Maestro.Entidad;

public interface IEntidadService
{
    Task<int> InsertAsync(EntidadEntity m);
    Task<int> UpdateByIdAsync(EntidadEntity m);
    Task<int> DeleteByIdAsync(EntidadFilter f);
    Task<int> UpdateStateByIdAsync(EntidadEntity m);
}

public sealed class EntidadService : IEntidadService
{
    private readonly IDatabase _database;
    private readonly UserContext _user;

    public EntidadService(IDatabase database, UserContext user)
    {
        _database = database;
        _user = user;
    }

    public Task<int> InsertAsync(EntidadEntity m) =>
        _database.ScalarAsync<int>(EntidadDbObjects.Insert,
            p => p.Add("NoEntidad", m.NoEntidad)
                  .AddUserCreate(_user.CoUsuarioRequired));

    public Task<int> UpdateByIdAsync(EntidadEntity m) =>
        _database.ScalarAsync<int>(EntidadDbObjects.UpdateById,
            p => p.Add("CoEntidad", m.CoEntidad)
                  .Add("NoEntidad", m.NoEntidad)
                  .AddUserUpdate(_user.CoUsuarioRequired));

    public Task<int> DeleteByIdAsync(EntidadFilter f) =>
        _database.ScalarAsync<int>(EntidadDbObjects.DeleteById,
            p => p.Add("CoEntidad", f.CoEntidad)
                  .AddUserDelete(_user.CoUsuarioRequired));

    public Task<int> UpdateStateByIdAsync(EntidadEntity m) =>
        _database.ScalarAsync<int>(EntidadDbObjects.UpdateStateById,
            p => p.Add("CoEntidad", m.CoEntidad)
                  .Add("FlEstReg", m.FlEstReg)
                  .AddUserUpdate(_user.CoUsuarioRequired));
}