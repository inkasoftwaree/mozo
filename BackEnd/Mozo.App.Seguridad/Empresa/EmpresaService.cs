using Mozo.App.Seguridad.Empresa.Contracts;
using Mozo.Domain.Seguridad;
using Mozo.Infrastructure.Persistence;
using Mozo.Infrastructure.Persistence.Builders;
using Mozo.Shared.Models;
using Mozo.Shared.Services;
using System.Data;

namespace Mozo.App.Seguridad.Empresa;

public interface IEmpresaService
{
    Task<int> InsertAsync(EmpresaEntity m);
    Task<int> UpdateByIdAsync(EmpresaEntity m);
    Task<int> UpdateStateByIdAsync(EmpresaEntity m);
    Task<EmpresaEditResponse?> SelByIdAsync(EmpresaFilter f);
    Task<PagedResult<EmpresaListItem>> SelAllAsync(EmpresaFilter f);
    Task<IReadOnlyList<EmpresaOption>> SelAllActiveAsync();
}

public sealed class EmpresaService : IEmpresaService
{
    private readonly IDatabase _database;
    private readonly UserContext _user;

    public EmpresaService(IDatabase database, UserContext user)
    {
        _database = database;
        _user = user;
    }

    public Task<int> InsertAsync(EmpresaEntity m) =>
       _database.ScalarAsync<int>(EmpresaDbObjects.Insert,
           p => p.Add("CoEntidad", m.CoEntidad, DbType.Int32)
                 .Add("NoMision", m.NoMision, DbType.String)
                 .Add("NoVision", m.NoVision, DbType.String)
                 .Add("TxQuienSoy", m.TxQuienSoy, DbType.String)
                 .Add("CoPais", m.CoPais, DbType.Int32)
                 .Add("CoMoneda", m.CoMoneda, DbType.Int32)
                 .Add("CoIdioma", m.CoIdioma, DbType.Int32)
                 .AddUserUpdate(_user.CoUsuarioRequired)
        );


    public Task<int> UpdateByIdAsync(EmpresaEntity m) =>
        _database.ScalarAsync<int>(EmpresaDbObjects.UpdateById,
            p => p.Add("CoEmpresa", m.CoEmpresa, DbType.Int32)
                  .Add("NoMision", m.NoMision, DbType.String)
                  .Add("NoVision", m.NoVision, DbType.String)
                  .Add("TxQuienSoy", m.TxQuienSoy, DbType.String)
                  .Add("CoPais", m.CoPais, DbType.Int32)
                  .Add("CoMoneda", m.CoMoneda, DbType.Int32)
                  .Add("CoIdioma", m.CoIdioma, DbType.Int32)
                  .AddUserUpdate(_user.CoUsuarioRequired));

    public Task<int> UpdateStateByIdAsync(EmpresaEntity m) =>
     _database.ScalarAsync<int>(EmpresaDbObjects.UpdateStateById,
         p => p.Add("CoEntidad", m.CoEntidad, DbType.Int32)
               .Add("FlEstReg", m.FlEstReg, DbType.Int32)
               .AddUserUpdate(_user.CoUsuarioRequired));

    public Task<EmpresaEditResponse?> SelByIdAsync(EmpresaFilter f) =>
        _database.FirstAsync<EmpresaEditResponse>(EmpresaDbObjects.SelById,
            p => p.Add("CoEmpresa", f.CoEmpresa, DbType.Int32));

    public async Task<PagedResult<EmpresaListItem>> SelAllAsync(EmpresaFilter f)
    {
        var r = await _database.ListAsync<EmpresaListItem>(EmpresaDbObjects.SelAll,
        p => p.Add("CoEmpresa", f.CoEmpresa, DbType.Int32)
              .Add("NoInputSearch", f.NoInputSearch, DbType.String)
              .Add("PageSize", f.PageSize, DbType.Int32)
              .Add("PageIndex", f.PageIndex, DbType.Int32));

        return new PagedResult<EmpresaListItem>
        {
            Items = r,
            TotalRows = r.Count > 0 ? (r[0].RowsCount ?? 0) : 0,
            PageIndex = f.PageIndex ?? 0,
            PageSize = f.PageSize ?? 0
        };
    }
    public Task<IReadOnlyList<EmpresaOption>> SelAllActiveAsync() =>
        _database.ListAsync<EmpresaOption>(EmpresaDbObjects.SelAllActive);

}