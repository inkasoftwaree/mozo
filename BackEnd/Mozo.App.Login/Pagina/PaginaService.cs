using Mozo.App.Login.Pagina.Contracts;
using Mozo.Infrastructure.Persistence;
using Mozo.Infrastructure.Persistence.Builders;
using Mozo.Shared.Services;
using System.Data;

namespace Mozo.App.Login.Pagina;

public interface IPaginaService
{
    Task<IReadOnlyList<PaginaListItem>> SelAllPaginaAsync(PaginaFilter f);
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

    public async Task<IReadOnlyList<PaginaListItem>> SelAllPaginaAsync(PaginaFilter f)
    {
        IReadOnlyList<PaginaListItem> r = await _database.ListAsync<PaginaListItem>(PaginaDbObjects.SelAll,
            p => p.AddEmpresa(_user.CoEmpresaRequired)
                  .Add("CoModulo", f.CoModulo, DbType.Int32)
                  .Add("CoUsuario", f.CoUsuario, DbType.Int32));

        return [.. r.OrderBy(x => x.NuOrden)];
    }

}
