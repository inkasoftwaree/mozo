using Mozo.App.Maestro.TipoParticular.Contracts;
using Mozo.Domain.Maestro;
using Mozo.Infrastructure.Persistence;
using Mozo.Infrastructure.Persistence.Builders;
using Mozo.Shared.Models;
using Mozo.Shared.Services;
using System.Data;

namespace Mozo.App.Maestro.TipoParticular;

public interface ITipoParticularService
{
    Task<int> InsertAsync(TipoParticularEntity c);
    Task<int> UpdateByIdAsync(TipoParticularEntity c);
    Task<int> UpdateStateByIdAsync(TipoParticularEntity c);
    Task<int> UpdateDefaultAsync(TipoParticularEntity c);
    Task<int> DeleteByIdAsync(TipoParticularFilter f);
    Task<int> SelOrderNextAsync(TipoParticularFilter f);
    Task<TipoParticularEditResponse?> SelByIdAsync(TipoParticularFilter f);
    Task<TipoParticularEditResponse?> SelByIdGroupAsync(TipoParticularFilter f);
    Task<TipoParticularEditResponse?> SelDefaultAsync(TipoParticularFilter f);
    Task<PagedResult<TipoParticularListItem>> SelAllAsync(TipoParticularFilter f);
    Task<PagedResult<TipoParticularListItem>> SelAllChildrenAsync(TipoParticularFilter f);
    Task<IEnumerable<TipoParticularOption>> SelAllActiveGroupsByModuleAsync(TipoParticularFilter f);
    Task<IEnumerable<TipoParticularOption>> SelAllActiveAsync(TipoParticularFilter f);
    Task<IEnumerable<TipoParticularOption>> SelAllActiveChildrenAsync(TipoParticularFilter f);
    Task<IEnumerable<TipoParticularOption>> SelAllActiveFatherAndChildrenAsync(TipoParticularFilter f);
}

public sealed class TipoParticularService : ITipoParticularService
{
    private readonly IDatabase _database;
    private readonly UserContext _user;

    public TipoParticularService(IDatabase database, UserContext user)
    {
        _database = database;
        _user = user;
    }

    public Task<int> InsertAsync(TipoParticularEntity c) =>
        _database.ScalarAsync<int>(TipoParticularDbObjects.Insert,
            p => p
               .AddEmpresa(_user.CoEmpresaRequired)
                .Add("CoModulo", c.CoModulo, DbType.Int32)
                .Add("CoGrupo", c.CoGrupo, DbType.Int32)
                .Add("CoTipoParticularPadre", c.CoTipoParticularPadre, DbType.Int32)
                .Add("CoGrupoPadre", c.CoGrupoPadre, DbType.Int32)
                .Add("NuOrden", c.NuOrden, DbType.Int32)
                .Add("NoTipo", c.NoTipo, DbType.String)
                .Add("NoSigla", c.NoSigla, DbType.String)
                .Add("TxDescripcion", c.TxDescripcion, DbType.String)
                .Add("FlDefault", c.FlDefault, DbType.Int32)
                .AddUserCreate(_user.CoUsuarioRequired));

    public Task<int> UpdateByIdAsync(TipoParticularEntity c) =>
        _database.ScalarAsync<int>(TipoParticularDbObjects.UpdateById,
            p => p
                .AddEmpresa(_user.CoEmpresaRequired)
                .Add("CoGrupo", c.CoGrupo, DbType.Int32)
                .Add("CoTipoParticular", c.CoTipoParticular, DbType.Int32)
                .Add("NuOrden", c.NuOrden, DbType.Int32)
                .Add("NoTipo", c.NoTipo, DbType.String)
                .Add("NoSigla", c.NoSigla, DbType.String)
                .Add("TxDescripcion", c.TxDescripcion, DbType.String)
                .Add("FlDefault", c.FlDefault, DbType.Int32)
                .AddUserUpdate(_user.CoUsuarioRequired));

    public Task<int> UpdateStateByIdAsync(TipoParticularEntity c) =>
        _database.ScalarAsync<int>(TipoParticularDbObjects.UpdateStateById,
            p => p
                .Add("CoTipoParticular", c.CoTipoParticular, DbType.Int32)
                .Add("FlEstReg", c.FlEstReg, DbType.Int32)
                .AddUserUpdate(_user.CoUsuarioRequired));

    public Task<int> UpdateDefaultAsync(TipoParticularEntity c) =>
        _database.ScalarAsync<int>(TipoParticularDbObjects.UpdateDefault,
            p => p
                .AddEmpresa(_user.CoEmpresaRequired)
                .Add("CoTipoParticular", c.CoTipoParticular, DbType.Int32)
                .Add("CoGrupo", c.CoGrupo, DbType.Int32)
                .Add("FlDefault", c.FlDefault, DbType.Int32)
                .AddUserUpdate(_user.CoUsuarioRequired));

    public Task<int> DeleteByIdAsync(TipoParticularFilter f) =>
        _database.ScalarAsync<int>(TipoParticularDbObjects.DeleteById,
            p => p
                .Add("CoTipoParticular", f.CoTipoParticular, DbType.Int32)
                .AddUserDelete(_user.CoUsuarioRequired));

    public Task<int> SelOrderNextAsync(TipoParticularFilter f) =>
        _database.ScalarAsync<int>(TipoParticularDbObjects.SelOrderNext,
            p => p
                .AddEmpresa(_user.CoEmpresaRequired)
                .Add("CoGrupo", f.CoGrupo, DbType.Int32)
                .Add("CoTipoParticularPadre", f.CoTipoParticularPadre, DbType.Int32));

    public Task<TipoParticularEditResponse?> SelByIdAsync(TipoParticularFilter f) =>
        _database.FirstAsync<TipoParticularEditResponse>(TipoParticularDbObjects.SelById,
            p => p
                .AddEmpresa(_user.CoEmpresaRequired)
                .Add("CoGrupo", f.CoGrupo, DbType.Int32)
                .Add("CoTipoParticular", f.CoTipoParticular, DbType.Int32));

    public Task<TipoParticularEditResponse?> SelByIdGroupAsync(TipoParticularFilter f) =>
        _database.FirstAsync<TipoParticularEditResponse>(TipoParticularDbObjects.SelByIdGroup,
            p => p.Add("CoGrupo", f.CoGrupo, DbType.Int32));

    public Task<TipoParticularEditResponse?> SelDefaultAsync(TipoParticularFilter f) =>
        _database.FirstAsync<TipoParticularEditResponse>(TipoParticularDbObjects.SelDefault,
            p => p
                .AddEmpresa(_user.CoEmpresaRequired)
                .Add("CoGrupo", f.CoGrupo, DbType.Int32));

    public async Task<PagedResult<TipoParticularListItem>> SelAllAsync(TipoParticularFilter f)
    {
        var r = await _database.ListAsync<TipoParticularListItem>(TipoParticularDbObjects.SelAll,
         p => p
             .AddEmpresa(_user.CoEmpresaRequired)
             .Add("CoGrupo", f.CoGrupo, DbType.Int32)
             .Add("NoInputSearch", f.NoInputSearch, DbType.String)
             .Add("FlEstReg", f.FlEstReg, DbType.Int32)
             .Add("CoTipoParticular", f.CoTipoParticular, DbType.Int32)
             .Add("PageSize", f.PageSize, DbType.Int32)
             .Add("PageIndex", f.PageIndex, DbType.Int32));

        return new PagedResult<TipoParticularListItem>
        {
            Items = [.. r.OrderBy(s => s.NuOrden)],
            TotalRows = r.Count > 0 ? (r[0].RowsCount ?? 0) : 0,
            PageIndex = f.PageIndex ?? 0,
            PageSize = f.PageSize ?? 0
        };


    }


    public async Task<PagedResult<TipoParticularListItem>> SelAllChildrenAsync(TipoParticularFilter f)
    {
        var r = await _database.ListAsync<TipoParticularListItem>(TipoParticularDbObjects.SelAllChildren,
           p => p
               .AddEmpresa(_user.CoEmpresaRequired)
               .Add("CoGrupoPadre", f.CoGrupoPadre, DbType.Int32)
               .Add("CoTipoParticularPadre", f.CoTipoParticularPadre, DbType.Int32)
               .Add("NoInputSearch", f.NoInputSearch, DbType.String)
               .Add("CoTipoParticular", f.CoTipoParticular, DbType.Int32)
               .Add("PageSize", f.PageSize, DbType.Int32)
               .Add("PageIndex", f.PageIndex, DbType.Int32));

        return new PagedResult<TipoParticularListItem>
        {
            Items = [.. r.OrderBy(s => s.NuOrden)],
            TotalRows = r.Count > 0 ? (r[0].RowsCount ?? 0) : 0,
            PageIndex = f.PageIndex ?? 0,
            PageSize = f.PageSize ?? 0
        };
    }


    public async Task<IEnumerable<TipoParticularOption>> SelAllActiveGroupsByModuleAsync(TipoParticularFilter f)
    {
        IEnumerable<TipoParticularOption> r = await _database.ListAsync<TipoParticularOption>(TipoParticularDbObjects.SelAllActiveGroupsByModulo,
            p => p
                .AddEmpresa(_user.CoEmpresaRequired)
                .Add("CoModulo", f.CoModulo, DbType.Int32));

        return r.OrderBy(s => s.NuOrden);
    }


    public async Task<IEnumerable<TipoParticularOption>> SelAllActiveAsync(TipoParticularFilter f)
    {
        IEnumerable<TipoParticularOption> r = await _database.ListAsync<TipoParticularOption>(TipoParticularDbObjects.SelAllActive,
            p => p
               .AddEmpresa(_user.CoEmpresaRequired)
                .Add("CoGrupo", f.CoGrupo, DbType.Int32)
                .Add("NoInputSearch", f.NoInputSearch, DbType.String));

        return r.OrderBy(s => s.NuOrden);
    }


    public async Task<IEnumerable<TipoParticularOption>> SelAllActiveChildrenAsync(TipoParticularFilter f)
    {
        IEnumerable<TipoParticularOption> r = await _database.ListAsync<TipoParticularOption>(TipoParticularDbObjects.SelAllActiveChildren,
            p => p
               .AddEmpresa(_user.CoEmpresaRequired)
                .Add("CoGrupo", f.CoGrupo, DbType.Int32)
                .Add("CoTipoParticularPadre", f.CoTipoParticularPadre, DbType.Int32)
                .Add("NoInputSearch", f.NoInputSearch, DbType.String));

        return r.OrderBy(s => s.NuOrden).ThenBy(s => s.NuSubOrden);
    }


    public async Task<IEnumerable<TipoParticularOption>> SelAllActiveFatherAndChildrenAsync(TipoParticularFilter f)
    {
        IEnumerable<TipoParticularOption> r = await _database.ListAsync<TipoParticularOption>(TipoParticularDbObjects.SelAllActiveFatherAndChildren,
            p => p
                .AddEmpresa(_user.CoEmpresaRequired)
                .Add("CoGrupo", f.CoGrupo, DbType.Int32)
                .Add("NoInputSearch", f.NoInputSearch, DbType.String));

        return r.OrderBy(s => s.NuOrden).ThenBy(s => s.NoTipo).ThenBy(s => s.NuSubOrden);
    }


}
