using Mozo.App.Seguridad.Pagina.Contract;
using Mozo.Domain.Seguridad;
using Mozo.Infrastructure.Persistence;
using Mozo.Infrastructure.Persistence.Builders;
using Mozo.Shared.Services;
using System.Data;

namespace Mozo.App.Seguridad.Pagina;

public interface IPaginaService
{
    Task<int> InsertAsync(PaginaEntity m);
    Task<int> UpdateByIdAsync(PaginaEntity m);
    Task<int> UpdateStateByIdAsync(PaginaEntity m);
    Task<int> DeleteByIdAsync(PaginaFilter f);
    Task<PaginaEditResponse?> SelByIdAsync(PaginaFilter f);
    Task<IReadOnlyList<PaginaListItem>> SelAllAsync(PaginaFilter f);

}

public sealed class PaginaService : IPaginaService
{
    private readonly IDatabase _database;
    private readonly UserContext _user;

    public PaginaService(IDatabase database, UserContext user)
    {
        _database = database;
        _user = user;
    }

    public Task<int> InsertAsync(PaginaEntity m) =>
        _database.ScalarAsync<int>(PaginaDbObjects.Insert,
            p => p.Add("CoModulo", m.CoModulo, DbType.Int32)
                  .Add("CoArea", m.CoArea, DbType.Int32)
                  .Add("CoMenu", m.CoMenu, DbType.Int32)
                  .Add("NoOpcion", m.NoOpcion, DbType.String)
                  .Add("NuOrden", m.NuOrden, DbType.Int32)
                  .Add("CoTipoPagina", m.CoTipoPagina, DbType.Int32)
                  .Add("NoControlador", m.NoControlador, DbType.String)
                  .Add("NoAccion", m.NoAccion, DbType.String)
                  .AddUserCreate(_user.CoUsuarioRequired));

    public Task<int> UpdateByIdAsync(PaginaEntity m) =>
        _database.ScalarAsync<int>(PaginaDbObjects.UpdateById,
            p => p.Add("CoPagina", m.CoPagina, DbType.Int32)
                  .Add("CoArea", m.CoArea, DbType.Int32)
                  .Add("NoOpcion", m.NoOpcion, DbType.String)
                  .Add("NuOrden", m.NuOrden, DbType.Int32)
                  .Add("NoControlador", m.NoControlador, DbType.String)
                  .Add("NoAccion", m.NoAccion, DbType.String)
                  .AddUserUpdate(_user.CoUsuarioRequired));

    public Task<int> UpdateStateByIdAsync(PaginaEntity m) =>
        _database.ScalarAsync<int>(PaginaDbObjects.UpdateStateById,
            p => p.Add("CoPagina", m.CoPagina, DbType.Int32)
                  .Add("FlEstReg", m.FlEstReg, DbType.Int32)
                  .AddUserUpdate(_user.CoUsuarioRequired));

    public Task<int> DeleteByIdAsync(PaginaFilter f) =>
        _database.ScalarAsync<int>(PaginaDbObjects.DeleteById,
            p => p.Add("CoPagina", f.CoPagina, DbType.Int32)
                  .AddUserDelete(_user.CoUsuarioRequired));

    public Task<PaginaEditResponse?> SelByIdAsync(PaginaFilter f) =>
        _database.FirstAsync<PaginaEditResponse>(PaginaDbObjects.SelById,
            p => p.Add("CoPagina", f.CoPagina, DbType.Int32));

    public Task<IReadOnlyList<PaginaListItem>> SelAllAsync(PaginaFilter f) =>
        _database.ListAsync<PaginaListItem>(PaginaDbObjects.SelAll,
            p => p.Add("CoModulo", f.CoModulo, DbType.Int32)
                  .Add("CoTipoPagina", f.CoTipoPagina, DbType.Int32)
                  .Add("FlEstReg", f.FlEstReg, DbType.Int32));


}
