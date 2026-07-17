using Mozo.App.Suscripcion.SuscripcionMovimiento.Contracts;
using Mozo.Infrastructure.Persistence;
using Mozo.Infrastructure.Persistence.Builders;
using System.Data;

namespace Mozo.App.Suscripcion.SuscripcionMovimiento;

public interface ISuscripcionMovimientoService
{
    Task<IReadOnlyList<SuscripcionMovimientoListItem>> SelAllBySuscripcionAsync(SuscripcionMovimientoFilter f);
}

public sealed class SuscripcionMovimientoService : ISuscripcionMovimientoService
{
    private readonly IDatabase _database;

    public SuscripcionMovimientoService(IDatabase database)
    {
        _database = database;
    }

    public Task<IReadOnlyList<SuscripcionMovimientoListItem>> SelAllBySuscripcionAsync(SuscripcionMovimientoFilter f) =>
        _database.ListAsync<SuscripcionMovimientoListItem>(SuscripcionMovimientoDbObjects.SelAllBySuscripcion,
            p => p.Add("CoSuscripcion", f.CoSuscripcion, DbType.Int32));
}
