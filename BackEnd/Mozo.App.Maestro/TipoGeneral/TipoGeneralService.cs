using Mozo.App.Maestro.TipoGeneral.Contracts;
using Mozo.Infrastructure.Persistence;
using System.Data;

namespace Mozo.App.Maestro.TipoGeneral;

public interface ITipoGeneralService
{
    Task<IReadOnlyList<TipoGeneralOption>> SelAllActiveAsync(TipoGeneralFilter f);
    Task<IReadOnlyList<TipoGeneralOption>> SelAllActiveByModuleAsync(TipoGeneralFilter f);
    Task<TipoGeneralEditResponse?> SelByIdAsync(TipoGeneralFilter f);
}

public sealed class TipoGeneralService : ITipoGeneralService
{
    private readonly IDatabase _database;

    public TipoGeneralService(IDatabase database)
    {
        _database = database;
    }

    public Task<IReadOnlyList<TipoGeneralOption>> SelAllActiveAsync(TipoGeneralFilter f) =>
        _database.ListAsync<TipoGeneralOption>(TipoGeneralDbObjects.SelAllActive,
            p => p.Add("CoGrupo", f.CoGrupo, DbType.Int32));

    public Task<IReadOnlyList<TipoGeneralOption>> SelAllActiveByModuleAsync(TipoGeneralFilter f) =>
        _database.ListAsync<TipoGeneralOption>(TipoGeneralDbObjects.SelAllActiveByModulo,
            p => p
                .Add("CoModulo", f.CoModulo, DbType.Int32)
                .Add("CoGrupo", f.CoGrupo, DbType.Int32));

    public Task<TipoGeneralEditResponse?> SelByIdAsync(TipoGeneralFilter f) =>
        _database.FirstAsync<TipoGeneralEditResponse>(TipoGeneralDbObjects.SelById,
            p => p
                .Add("CoTipoGeneral", f.CoTipoGeneral, DbType.Int32));
}
