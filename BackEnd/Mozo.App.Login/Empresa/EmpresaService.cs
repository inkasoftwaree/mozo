using Mozo.App.Login.Empresa.Contracts;
using Mozo.Infrastructure.Persistence;
using Mozo.Infrastructure.Persistence.Builders;
using Mozo.Shared.Services;

namespace Mozo.App.Login.Empresa;

public interface IEmpresaService
{
    Task<EmpresaDetailResponse?> SelByIdAsync(EmpresaFilter f);
    Task<IReadOnlyList<EmpresaOption>> SelAllAsync();
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

    public Task<EmpresaDetailResponse?> SelByIdAsync(EmpresaFilter f) =>
        _database.FirstAsync<EmpresaDetailResponse>(EmpresaDbObjects.SelById,
            p => p.AddEmpresa(_user.CoEmpresaRequired));

    public async Task<IReadOnlyList<EmpresaOption>> SelAllAsync()
    {
        IReadOnlyList<EmpresaOption> r = await _database.ListAsync<EmpresaOption>(EmpresaDbObjects.SelAll);
        return [.. r.OrderBy(s => s.CoEmpresa)];
    }

}
