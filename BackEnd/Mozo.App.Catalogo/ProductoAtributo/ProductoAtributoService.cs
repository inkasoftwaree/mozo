using Mozo.Domain.Catalogo;
using Mozo.Infrastructure.Persistence;
using Mozo.Infrastructure.Persistence.Builders;
using Mozo.Shared.Services;
using System.Data;

namespace Mozo.App.Catalogo.ProductoAtributo;

public interface IProductoAtributoService
{
    Task<int> InsertAsync(ProductoAtributoEntity m);
    Task<int> UpdateByIdAsync(ProductoAtributoEntity m);
    Task<int> UpdateStateByIdAsync(ProductoAtributoEntity m);
    Task<int> DeleteByIdAsync(ProductoAtributoFilter f);
    Task<ProductoAtributoEntity?> SelByIdAsync(ProductoAtributoFilter f);
    Task<IReadOnlyList<ProductoAtributoEntity>> SelAllAsync(ProductoAtributoFilter f);
    Task<IReadOnlyList<ProductoAtributoEntity>> SelAllActiveAsync(ProductoAtributoFilter f);
}

public sealed class ProductoAtributoService : IProductoAtributoService
{
    private readonly IDatabase _database;
    private readonly UserContext _user;

    public ProductoAtributoService(IDatabase database, UserContext user)
    {
        _database = database;
        _user = user;
    }

    public Task<int> InsertAsync(ProductoAtributoEntity m) =>
        _database.ScalarAsync<int>(ProductoAtributoDbObjects.Insert,
            p => p.Add("CoProductoAtributo", m.CoProductoAtributo, DbType.Int32)
                  .Add("CoProducto", m.CoProducto, DbType.Int32)
                  .Add("CoAtributo", m.CoAtributo, DbType.Int32)
                  .Add("NoValor", m.NoValor, DbType.String)
                  .AddEmpresa(_user.CoEmpresaRequired)
                  .Add("FlEstReg", m.FlEstReg, DbType.Int32)
                  .AddUserCreate(_user.CoUsuarioRequired));

    public Task<int> UpdateByIdAsync(ProductoAtributoEntity m) =>
        _database.ScalarAsync<int>(ProductoAtributoDbObjects.UpdateById,
            p => p.Add("CoProductoAtributo", m.CoProductoAtributo, DbType.Int32)
                  .Add("CoProducto", m.CoProducto, DbType.Int32)
                  .Add("CoAtributo", m.CoAtributo, DbType.Int32)
                  .Add("NoValor", m.NoValor, DbType.String)
                  .AddEmpresa(_user.CoEmpresaRequired)
                  .Add("FlEstReg", m.FlEstReg, DbType.Int32)
                  .AddUserUpdate(_user.CoUsuarioRequired));

    public Task<int> UpdateStateByIdAsync(ProductoAtributoEntity m) =>
        _database.ScalarAsync<int>(ProductoAtributoDbObjects.UpdateStateById,
            p => p.Add("CoProductoAtributo", m.CoProductoAtributo, DbType.Int32)
                  .AddEmpresa(_user.CoEmpresaRequired)
                  .Add("FlEstReg", m.FlEstReg, DbType.Int32)
                  .AddUserUpdate(_user.CoUsuarioRequired));

    public Task<int> DeleteByIdAsync(ProductoAtributoFilter f) =>
        _database.ScalarAsync<int>(ProductoAtributoDbObjects.DeleteById,
            p => p.Add("CoProductoAtributo", f.CoProductoAtributo, DbType.Int32)
                  .AddEmpresa(_user.CoEmpresaRequired)
                  .AddUserDelete(_user.CoUsuarioRequired));

    public Task<ProductoAtributoEntity?> SelByIdAsync(ProductoAtributoFilter f) =>
        _database.FirstAsync<ProductoAtributoEntity>(ProductoAtributoDbObjects.SelById,
            p => p.Add("CoProductoAtributo", f.CoProductoAtributo, DbType.Int32)
                  .AddEmpresa(_user.CoEmpresaRequired));

    public Task<IReadOnlyList<ProductoAtributoEntity>> SelAllAsync(ProductoAtributoFilter f) =>
        _database.ListAsync<ProductoAtributoEntity>(ProductoAtributoDbObjects.SelAll,
            p => p.AddEmpresa(_user.CoEmpresaRequired));

    public Task<IReadOnlyList<ProductoAtributoEntity>> SelAllActiveAsync(ProductoAtributoFilter f) =>
        _database.ListAsync<ProductoAtributoEntity>(ProductoAtributoDbObjects.SelAllActive,
            p => p.AddEmpresa(_user.CoEmpresaRequired));
}
