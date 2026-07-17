using Mozo.App.Suscripcion.SuscripcionPago.Contracts;
using Mozo.Domain.Suscripcion;
using Mozo.Infrastructure.Persistence;
using Mozo.Infrastructure.Persistence.Builders;
using Mozo.Shared.Services;
using System.Data;

namespace Mozo.App.Suscripcion.SuscripcionPago;

public interface ISuscripcionPagoService
{
    Task<int> InsertAsync(SuscripcionPagoEntity m);
    Task<IReadOnlyList<SuscripcionPagoListItem>> SelAllBySuscripcionAsync(SuscripcionPagoFilter f);
    Task<int> UpdateEstadoByIdAsync(SuscripcionPagoEntity m);
}

public sealed class SuscripcionPagoService : ISuscripcionPagoService
{
    private readonly IDatabase _database;
    private readonly UserContext _user;

    public SuscripcionPagoService(IDatabase database, UserContext user)
    {
        _database = database;
        _user = user;
    }

    public Task<int> InsertAsync(SuscripcionPagoEntity m) =>
        _database.ScalarAsync<int>(SuscripcionPagoDbObjects.Insert,
            p => p.Add("CoSuscripcion", m.CoSuscripcion, DbType.Int32)
                  .AddEmpresa(_user.CoEmpresaRequired)
                  .Add("FePeriodoInicio", m.FePeriodoInicio, DbType.Date)
                  .Add("FePeriodoFin", m.FePeriodoFin, DbType.Date)
                  .Add("SsMonto", m.SsMonto, DbType.Decimal)
                  .Add("CoMoneda", m.CoMoneda, DbType.Int32)
                  .Add("FePago", m.FePago, DbType.DateTime)
                  .Add("CoEstado", m.CoEstado, DbType.Int32)
                  .Add("NoReferenciaPago", m.NoReferenciaPago, DbType.String)
                  .Add("TxNota", m.TxNota, DbType.String)
                  .AddUserCreate(_user.CoUsuarioRequired));

    public Task<IReadOnlyList<SuscripcionPagoListItem>> SelAllBySuscripcionAsync(SuscripcionPagoFilter f) =>
        _database.ListAsync<SuscripcionPagoListItem>(SuscripcionPagoDbObjects.SelAllBySuscripcion,
            p => p.Add("CoSuscripcion", f.CoSuscripcion, DbType.Int32));

    public Task<int> UpdateEstadoByIdAsync(SuscripcionPagoEntity m) =>
        _database.ScalarAsync<int>(SuscripcionPagoDbObjects.UpdateEstadoById,
            p => p.Add("CoSuscripcionPago", m.CoSuscripcionPago, DbType.Int32)
                  .Add("CoEstado", m.CoEstado, DbType.Int32)
                  .Add("FePago", m.FePago, DbType.DateTime)
                  .AddUserUpdate(_user.CoUsuarioRequired));
}
