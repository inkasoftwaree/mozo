using Mozo.Domain.Maestro;
using Mozo.Infrastructure.Persistence;

namespace Mozo.App.Maestro.Pais;

public interface IPaisService
{
    Task<IEnumerable<PaisEntity>> SelAllActiveAsync();
}

public sealed class PaisService : IPaisService
{
    private readonly IDatabase _database;

    public PaisService(IDatabase database)
    {
        _database = database;
    }

    public async Task<IEnumerable<PaisEntity>> SelAllActiveAsync()
    {
        IEnumerable<PaisEntity> r = await _database.ListAsync<PaisEntity, MonedaEntity, PaisEntity>(
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