using Mozo.Domain.Maestro;
using Mozo.Infrastructure.Persistence;
using Mozo.Infrastructure.Persistence.Builders;
using Mozo.Shared.Services;
using System.Data;


namespace Mozo.App.Maestro.EntidadDocumento;

public interface IEntidadDocumentoService
{
    Task<int> InsertAsync(EntidadDocumentoEntity m);
    Task<int> UpdateByIdAsync(EntidadDocumentoEntity m);
    Task<int> DeleteByIdAsync(EntidadDocumentoFilter f);
    Task<EntidadDocumentoEntity?> SelByIdAsync(EntidadDocumentoFilter f);
    Task<IReadOnlyList<EntidadDocumentoEntity>> SelAllAsync(EntidadDocumentoFilter f);
    Task<int> UpdateDefaultAsync(EntidadDocumentoEntity m);
}

public sealed class EntidadDocumentoService : IEntidadDocumentoService
{
    private readonly IDatabase _database;
    private readonly UserContext _user;

    public EntidadDocumentoService(IDatabase database, UserContext user)
    {
        _database = database;
        _user = user;
    }

    public Task<int> InsertAsync(EntidadDocumentoEntity m) =>
        _database.ScalarAsync<int>(EntidadDocumentoDbObjects.Insert,
            p => p.Add("CoEntidad", m.CoEntidad, DbType.Int32)
                  .Add("CoDocumentoIdentidad", m.CoDocumentoIdentidad, DbType.Int32)
                  .Add("NuDocumento", m.NuDocumento, DbType.String)
                  .AddUserCreate(_user.CoUsuarioRequired));

    public Task<int> UpdateByIdAsync(EntidadDocumentoEntity m) =>
        _database.ScalarAsync<int>(EntidadDocumentoDbObjects.UpdateById,
            p => p.Add("CoEntidadDocumento", m.CoEntidadDocumento, DbType.Int32)
                  .Add("CoEntidad", m.CoEntidad, DbType.Int32)
                  .Add("CoDocumentoIdentidad", m.CoDocumentoIdentidad, DbType.Int32)
                  .Add("NuDocumento", m.NuDocumento, DbType.String)
                  .AddUserUpdate(_user.CoUsuarioRequired));

    public Task<int> DeleteByIdAsync(EntidadDocumentoFilter f) =>
        _database.ScalarAsync<int>(EntidadDocumentoDbObjects.DeleteById,
            p => p.Add("CoEntidadDocumento", f.CoEntidadDocumento, DbType.Int32)
                  .AddUserDelete(_user.CoUsuarioRequired));

    public Task<EntidadDocumentoEntity?> SelByIdAsync(EntidadDocumentoFilter f) =>
        _database.FirstAsync<EntidadDocumentoEntity>(EntidadDocumentoDbObjects.SelById,
            p => p.Add("CoEntidadDocumento", f.CoEntidadDocumento, DbType.Int32));

    public Task<IReadOnlyList<EntidadDocumentoEntity>> SelAllAsync(EntidadDocumentoFilter f) =>
        _database.ListAsync<EntidadDocumentoEntity>(EntidadDocumentoDbObjects.SelAll,
            p => p.Add("CoEntidad", f.CoEntidad, DbType.Int32));

    public Task<int> UpdateDefaultAsync(EntidadDocumentoEntity m) =>
        _database.ScalarAsync<int>(EntidadDocumentoDbObjects.UpdateDefault,
            p => p.Add("CoEntidad", m.CoEntidad, DbType.Int32)
                  .Add("CoDocumentoIdentidad", m.CoDocumentoIdentidad, DbType.Int32)
                  .AddUserUpdate(_user.CoUsuarioRequired));
}