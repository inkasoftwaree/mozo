using Mozo.Domain.Catalogo;
using Mozo.Infrastructure.Persistence;
using Mozo.Infrastructure.Persistence.Builders;
using Mozo.Shared.Services;
using System.Data;

namespace Mozo.App.Catalogo.ProductoStock;

public interface IProductoStockService
{
    Task<int> InsertAsync(ProductoStockEntity m);
    Task<int> UpdateByIdAsync(ProductoStockEntity m);
    Task<int> UpdateStateByIdAsync(ProductoStockEntity m);
    Task<int> DeleteByIdAsync(ProductoStockFilter f);
    Task<ProductoStockEntity?> SelByIdAsync(ProductoStockFilter f);
    Task<IReadOnlyList<ProductoStockEntity>> SelAllAsync(ProductoStockFilter f);
    Task<IReadOnlyList<ProductoStockEntity>> SelAllActiveAsync(ProductoStockFilter f);
}

public sealed class ProductoStockService : IProductoStockService
{
    private readonly IDatabase _database;
    private readonly UserContext _user;

    public ProductoStockService(IDatabase database, UserContext user)
    {
        _database = database;
        _user = user;
    }

    public Task<int> InsertAsync(ProductoStockEntity m) =>
        _database.ScalarAsync<int>(ProductoStockDbObjects.Insert,
            p => p.AddEmpresa(_user.CoEmpresaRequired)
                  .Add("CoProducto", m.CoProducto, DbType.Int32)
                  .Add("CoLocal", m.CoLocal, DbType.Int32)
                  .Add("CoAlmacen", m.CoAlmacen, DbType.Int32)
                  .Add("QtInicial", m.QtInicial, DbType.Int32)
                  .Add("QtMaxima", m.QtMaxima, DbType.Int32)
                  .Add("QtMinima", m.QtMinima, DbType.Int32)
                  .Add("FlDefault", m.FlDefault, DbType.Int32)
                  .AddUserCreate(_user.CoUsuarioRequired));

    public Task<int> UpdateByIdAsync(ProductoStockEntity m) =>
        _database.ScalarAsync<int>(ProductoStockDbObjects.UpdateById,
            p => p.AddEmpresa(_user.CoEmpresaRequired)
                  .Add("CoProductoStock", m.CoProductoStock, DbType.Int32)
                  .Add("CoProducto", m.CoProducto, DbType.Int32)
                  .Add("CoLocal", m.CoLocal, DbType.Int32)
                  .Add("CoAlmacen", m.CoAlmacen, DbType.Int32)
                  .Add("QtInicial", m.QtInicial, DbType.Int32)
                  .Add("QtMaxima", m.QtMaxima, DbType.Int32)
                  .Add("QtMinima", m.QtMinima, DbType.Int32)
                  .Add("FlDefault", m.FlDefault, DbType.Int32)
                  .AddUserUpdate(_user.CoUsuarioRequired));

    public Task<int> UpdateStateByIdAsync(ProductoStockEntity m) =>
        _database.ScalarAsync<int>(ProductoStockDbObjects.UpdateStateById,
            p => p.AddEmpresa(_user.CoEmpresaRequired)
                  .Add("CoProductoStock", m.CoProductoStock, DbType.Int32)
                  .Add("FlEstReg", m.FlEstReg, DbType.Int32)
                  .AddUserUpdate(_user.CoUsuarioRequired));

    public Task<int> DeleteByIdAsync(ProductoStockFilter f) =>
        _database.ScalarAsync<int>(ProductoStockDbObjects.DeleteById,
            p => p.AddEmpresa(_user.CoEmpresaRequired)
                  .Add("CoProductoStock", f.CoProductoStock, DbType.Int32)
                  .AddUserDelete(_user.CoUsuarioRequired));

    public Task<ProductoStockEntity?> SelByIdAsync(ProductoStockFilter f) =>
        _database.FirstAsync<ProductoStockEntity>(ProductoStockDbObjects.SelById,
            p => p.AddEmpresa(_user.CoEmpresaRequired)
                  .Add("CoProductoStock", f.CoProductoStock, DbType.Int32));

    public Task<IReadOnlyList<ProductoStockEntity>> SelAllAsync(ProductoStockFilter f) =>
        _database.ListAsync<ProductoStockEntity>(ProductoStockDbObjects.SelAll,
            p => p.AddEmpresa(_user.CoEmpresaRequired));

    public Task<IReadOnlyList<ProductoStockEntity>> SelAllActiveAsync(ProductoStockFilter f) =>
        _database.ListAsync<ProductoStockEntity>(ProductoStockDbObjects.SelAllActive,
            p => p.AddEmpresa(_user.CoEmpresaRequired));
}
