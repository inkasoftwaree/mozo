using Mozo.Domain.Catalogo;
using Mozo.Infrastructure.Persistence;
using Mozo.Infrastructure.Persistence.Builders;
using Mozo.Shared.Services;
using System.Data;

namespace Mozo.App.Catalogo.Atributo;

public interface IAtributoService
{
    Task<int> InsertAsync(AtributoEntity m);
    Task<int> UpdateByIdAsync(AtributoEntity m);
    Task<int> UpdateStateByIdAsync(AtributoEntity m);
    Task<int> DeleteByIdAsync(AtributoFilter f);
    Task<AtributoEntity?> SelByIdAsync(AtributoFilter f);
    Task<IReadOnlyList<AtributoEntity>> SelAllAsync(AtributoFilter f);
    Task<IReadOnlyList<AtributoEntity>> SelAllActiveAsync(AtributoFilter f);
}

public sealed class AtributoService : IAtributoService
{
    private readonly IDatabase _database;
    private readonly UserContext _user;

    public AtributoService(IDatabase database, UserContext user)
    {
        _database = database;
        _user = user;
    }

    public Task<int> InsertAsync(AtributoEntity m) =>
        _database.ScalarAsync<int>(AtributoDbObjects.Insert,
            p => p.AddEmpresa(_user.CoEmpresaRequired)
                  .Add("NoAtributo", m.NoAtributo, DbType.String)
                  .Add("CoTipoDato", m.CoTipoDato, DbType.Int32)
                  .Add("CoCategoria", m.CoCategoria, DbType.Int32)
                  .Add("NuOrden", m.NuOrden, DbType.Int32)
                  .Add("FlObligatorio", m.FlObligatorio, DbType.Int32)
                  .Add("FlFiltrable", m.FlFiltrable, DbType.Int32)
                  .Add("FlDescriptivo", m.FlDescriptivo, DbType.Int32)
                  .Add("FlEstReg", m.FlEstReg, DbType.Int32)
                  .AddUserCreate(_user.CoUsuarioRequired));

    public Task<int> UpdateByIdAsync(AtributoEntity m) =>
        _database.ScalarAsync<int>(AtributoDbObjects.UpdateById,
            p => p.AddEmpresa(_user.CoEmpresaRequired)
                  .Add("CoAtributo", m.CoAtributo, DbType.Int32)
                  .Add("NoAtributo", m.NoAtributo, DbType.String)
                  .Add("CoTipoDato", m.CoTipoDato, DbType.Int32)
                  .Add("CoCategoria", m.CoCategoria, DbType.Int32)
                  .Add("NuOrden", m.NuOrden, DbType.Int32)
                  .Add("FlObligatorio", m.FlObligatorio, DbType.Int32)
                  .Add("FlFiltrable", m.FlFiltrable, DbType.Int32)
                  .Add("FlDescriptivo", m.FlDescriptivo, DbType.Int32)
                  .Add("FlEstReg", m.FlEstReg, DbType.Int32)
                  .AddUserUpdate(_user.CoUsuarioRequired));

    public Task<int> UpdateStateByIdAsync(AtributoEntity m) =>
        _database.ScalarAsync<int>(AtributoDbObjects.UpdateStateById,
            p => p.AddEmpresa(_user.CoEmpresaRequired)
                  .Add("CoAtributo", m.CoAtributo, DbType.Int32)
                  .Add("FlEstReg", m.FlEstReg, DbType.Int32)
                  .AddUserUpdate(_user.CoUsuarioRequired));

    public Task<int> DeleteByIdAsync(AtributoFilter f) =>
        _database.ScalarAsync<int>(AtributoDbObjects.DeleteById,
            p => p.AddEmpresa(_user.CoEmpresaRequired)
                  .Add("CoAtributo", f.CoAtributo, DbType.Int32)
                  .AddUserDelete(_user.CoUsuarioRequired));

    public Task<AtributoEntity?> SelByIdAsync(AtributoFilter f) =>
        _database.FirstAsync<AtributoEntity>(AtributoDbObjects.SelById,
            p => p.AddEmpresa(_user.CoEmpresaRequired)
                  .Add("CoAtributo", f.CoAtributo, DbType.Int32));

    public Task<IReadOnlyList<AtributoEntity>> SelAllAsync(AtributoFilter f) =>
        _database.ListAsync<AtributoEntity>(AtributoDbObjects.SelAll,
            p => p.AddEmpresa(_user.CoEmpresaRequired));

    public Task<IReadOnlyList<AtributoEntity>> SelAllActiveAsync(AtributoFilter f) =>
        _database.ListAsync<AtributoEntity>(AtributoDbObjects.SelAllActive,
            p => p.AddEmpresa(_user.CoEmpresaRequired));
}
