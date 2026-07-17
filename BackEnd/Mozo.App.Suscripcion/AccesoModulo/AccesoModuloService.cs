using Mozo.App.Suscripcion.AccesoModulo.Contracts;
using Mozo.Infrastructure.Persistence;
using Mozo.Infrastructure.Persistence.Builders;
using Mozo.Shared.Services;
using System.Data;

namespace Mozo.App.Suscripcion.AccesoModulo;

public interface IAccesoModuloService
{
    Task<bool> HabilitadoAsync(AccesoModuloFilter f);
    Task<IReadOnlyList<AccesoModuloItem>> SelHabilitadosAsync(AccesoModuloFilter f);
}

public sealed class AccesoModuloService : IAccesoModuloService
{
    private readonly IDatabase _database;
    private readonly UserContext _user;

    public AccesoModuloService(IDatabase database, UserContext user)
    {
        _database = database;
        _user = user;
    }

    public Task<bool> HabilitadoAsync(AccesoModuloFilter f) =>
        _database.ScalarAsync<bool>(AccesoModuloDbObjects.Habilitado,
            p => p.Add("CoEmpresa", f.CoEmpresa ?? _user.CoEmpresaRequired, DbType.Int32)
                  .Add("CoModulo", f.CoModulo, DbType.Int32));

    public Task<IReadOnlyList<AccesoModuloItem>> SelHabilitadosAsync(AccesoModuloFilter f) =>
        _database.ListAsync<AccesoModuloItem>(AccesoModuloDbObjects.SelHabilitados,
            p => p.Add("CoEmpresa", f.CoEmpresa ?? _user.CoEmpresaRequired, DbType.Int32));
}
