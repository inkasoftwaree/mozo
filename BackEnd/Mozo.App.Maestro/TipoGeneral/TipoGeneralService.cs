using Mozo.Domain.Maestro;
using Mozo.Infrastructure.Persistence;
using System.Data;

namespace Mozo.App.Maestro.TipoGeneral;

public interface ITipoGeneralService
{
    Task<IEnumerable<TipoGeneralEntity>> SelAllActiveAsync(TipoGeneralFilter f);
    Task<IEnumerable<TipoGeneralEntity>> SelAllActiveByModuleAsync(TipoGeneralFilter f);
    Task<TipoGeneralEntity?> SelByIdAsync(TipoGeneralFilter f);
}

public sealed class TipoGeneralService : ITipoGeneralService
{
    private readonly IDatabase _database;

    public TipoGeneralService(IDatabase database)
    {
        _database = database;
    }

    public async Task<IEnumerable<TipoGeneralEntity>> SelAllActiveAsync(TipoGeneralFilter f) =>
        await _database.ListAsync<TipoGeneralEntity>(TipoGeneralDbObjects.SelAllActive,
            p => p.Add("CoGrupo", f.CoGrupo, DbType.Int32));

    public async Task<IEnumerable<TipoGeneralEntity>> SelAllActiveByModuleAsync(TipoGeneralFilter f) =>
        await _database.ListAsync<TipoGeneralEntity>(TipoGeneralDbObjects.SelAllActiveByModulo,
            p => p
                .Add("CoModulo", f.CoModulo, DbType.Int32)
                .Add("CoGrupo", f.CoGrupo, DbType.Int32));

    public Task<TipoGeneralEntity?> SelByIdAsync(TipoGeneralFilter f) =>
        _database.FirstAsync<TipoGeneralEntity>(TipoGeneralDbObjects.SelById,
            p => p
                .Add("CoTipoGeneral", f.CoTipoGeneral, DbType.Int32));
}
