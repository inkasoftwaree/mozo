using Mozo.App.Maestro.Pais.Contracts;
using Mozo.Infrastructure.Persistence;

namespace Mozo.App.Maestro.Pais;

public interface IPaisService
{
    Task<IEnumerable<PaisOption>> SelAllActiveAsync();
}

public sealed class PaisService : IPaisService
{
    private readonly IDatabase _database;

    public PaisService(IDatabase database)
    {
        _database = database;
    }

    public async Task<IEnumerable<PaisOption>> SelAllActiveAsync()
    {
        IEnumerable<PaisOption> r = await _database.ListAsync<PaisOption, MonedaOption, PaisOption>(
            PaisDbObjects.SelAllActive,
            map: (pais, moneda) =>
            {
                pais.Moneda = moneda;
                pais.CoMoneda = moneda?.CoMoneda;   // país.CoMoneda desde el objeto anidado
                return pais;
            },
            splitOn: "nomoneda");

        return r.OrderBy(x => x.NoPais);
    }
}
