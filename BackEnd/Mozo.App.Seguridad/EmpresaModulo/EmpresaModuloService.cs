using Mozo.App.Seguridad.EmpresaModulo.Contracts;
using Mozo.Domain.Seguridad;
using Mozo.Infrastructure.Persistence;
using Mozo.Infrastructure.Persistence.Builders;
using Mozo.Shared.Services;
using System.Data;

namespace Mozo.App.Seguridad.EmpresaModulo;

public interface IEmpresaModuloService
{
    Task<int> InsertAsync(EmpresaModuloEntity m);
    //Task<int> UpdateByIdAsync(EmpresaModuloEntity m);
    Task<int> DeleteByIdAsync(EmpresaModuloFilter f);
    Task<EmpresaModuloEditResponse?> SelByIdAsync(EmpresaModuloFilter f);
    Task<IReadOnlyList<EmpresaModuloListItem>> SelAllAsync(EmpresaModuloFilter f);
}

public sealed class EmpresaModuloService : IEmpresaModuloService
{
    private readonly IDatabase _database;
    private readonly UserContext _user;

    public EmpresaModuloService(IDatabase database, UserContext user)
    {
        _database = database;
        _user = user;
    }

    public Task<int> InsertAsync(EmpresaModuloEntity m) =>
        _database.ScalarAsync<int>(EmpresaModuloDbObjects.Insert,
            p => p.Add("CoEmpresa", m.CoEmpresa, DbType.Int32)
                  .Add("CoModulo", m.CoModulo, DbType.Int32));

    //public Task<int> UpdateByIdAsync(EmpresaModuloEntity m) =>
    //    _database.ScalarAsync<int>(EmpresaModuloDbObjects.UpdateById,
    //        p => p.Add("CoEmpresaModulo", m.CoEmpresaModulo, DbType.Int32)
    //              .Add("CoEmpresa", m.CoEmpresa, DbType.Int32)
    //              .Add("CoModulo", m.CoModulo, DbType.Int32));

    public Task<int> DeleteByIdAsync(EmpresaModuloFilter f) =>
        _database.ScalarAsync<int>(EmpresaModuloDbObjects.DeleteById,
            p => p.Add("CoEmpresaModulo", f.CoEmpresaModulo, DbType.Int32)
                  .AddUserDelete(_user.CoUsuarioRequired));

    public Task<EmpresaModuloEditResponse?> SelByIdAsync(EmpresaModuloFilter f) =>
        _database.FirstAsync<EmpresaModuloEditResponse>(EmpresaModuloDbObjects.SelById,
            p => p.Add("CoEmpresaModulo", f.CoEmpresaModulo, DbType.Int32));

    public async Task<IReadOnlyList<EmpresaModuloListItem>> SelAllAsync(EmpresaModuloFilter f)
    {
        IReadOnlyList<EmpresaModuloListItem> r = await _database.ListAsync<EmpresaModuloListItem>(EmpresaModuloDbObjects.SelAll,
            p => p.Add("CoEmpresa", _user.ResolveEmpresa(f.FlEmpresaNotKey, f.CoEmpresa), DbType.Int32)
            );
        return [.. r.OrderBy(s => s.NoModulo)];
    }

}
