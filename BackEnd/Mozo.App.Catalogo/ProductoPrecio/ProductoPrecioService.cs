using Mozo.Domain.Catalogo;
using Mozo.Infrastructure.Persistence;
using Mozo.Infrastructure.Persistence.Builders;
using Mozo.Shared.Services;
using System.Data;

namespace Mozo.App.Catalogo.ProductoPrecio;

public interface IProductoPrecioService
{
    Task<int> InsertAsync(ProductoPrecioEntity m);
    Task<int> UpdateByIdAsync(ProductoPrecioEntity m);
    Task<int> UpdateStateByIdAsync(ProductoPrecioEntity m);
    Task<int> DeleteByIdAsync(ProductoPrecioFilter f);
    Task<ProductoPrecioEntity?> SelByIdAsync(ProductoPrecioFilter f);
    Task<IReadOnlyList<ProductoPrecioEntity>> SelAllAsync(ProductoPrecioFilter f);
    Task<IReadOnlyList<ProductoPrecioEntity>> SelAllActiveAsync(ProductoPrecioFilter f);
}

public sealed class ProductoPrecioService : IProductoPrecioService
{
    private readonly IDatabase _database;
    private readonly UserContext _user;

    public ProductoPrecioService(IDatabase database, UserContext user)
    {
        _database = database;
        _user = user;
    }

    public Task<int> InsertAsync(ProductoPrecioEntity m) =>
        _database.ScalarAsync<int>(ProductoPrecioDbObjects.Insert,
            p => p.AddEmpresa(_user.CoEmpresaRequired)
                  .Add("CoTipoPrecio", m.CoTipoPrecio, DbType.Int32)
                  .Add("CoProducto", m.CoProducto, DbType.Int32)
                  .Add("SsPrecio", m.SsPrecio, DbType.Decimal)
                  .Add("CoMoneda", m.CoMoneda, DbType.Int32)
                  .AddUserCreate(_user.CoUsuarioRequired));

    public Task<int> UpdateByIdAsync(ProductoPrecioEntity m) =>
        _database.ScalarAsync<int>(ProductoPrecioDbObjects.UpdateById,
            p => p.AddEmpresa(_user.CoEmpresaRequired)
                  .Add("CoProductoPrecio", m.CoProductoPrecio, DbType.Int32)
                  .Add("CoTipoPrecio", m.CoTipoPrecio, DbType.Int32)
                  .Add("CoProducto", m.CoProducto, DbType.Int32)
                  .Add("SsPrecio", m.SsPrecio, DbType.Decimal)
                  .Add("CoMoneda", m.CoMoneda, DbType.Int32)
                  .AddUserUpdate(_user.CoUsuarioRequired));

    public Task<int> UpdateStateByIdAsync(ProductoPrecioEntity m) =>
        _database.ScalarAsync<int>(ProductoPrecioDbObjects.UpdateStateById,
            p => p.AddEmpresa(_user.CoEmpresaRequired)
                  .Add("CoProductoPrecio", m.CoProductoPrecio, DbType.Int32)
                  .Add("FlEstReg", m.FlEstReg, DbType.Int32)
                  .AddUserUpdate(_user.CoUsuarioRequired));

    public Task<int> DeleteByIdAsync(ProductoPrecioFilter f) =>
        _database.ScalarAsync<int>(ProductoPrecioDbObjects.DeleteById,
            p => p.AddEmpresa(_user.CoEmpresaRequired)
                  .Add("CoProductoPrecio", f.CoProductoPrecio, DbType.Int32)
                  .AddUserDelete(_user.CoUsuarioRequired));

    public Task<ProductoPrecioEntity?> SelByIdAsync(ProductoPrecioFilter f) =>
        _database.FirstAsync<ProductoPrecioEntity>(ProductoPrecioDbObjects.SelById,
            p => p.AddEmpresa(_user.CoEmpresaRequired)
                  .Add("CoProductoPrecio", f.CoProductoPrecio, DbType.Int32));

    public Task<IReadOnlyList<ProductoPrecioEntity>> SelAllAsync(ProductoPrecioFilter f) =>
        _database.ListAsync<ProductoPrecioEntity>(ProductoPrecioDbObjects.SelAll,
            p => p.AddEmpresa(_user.CoEmpresaRequired));

    public Task<IReadOnlyList<ProductoPrecioEntity>> SelAllActiveAsync(ProductoPrecioFilter f) =>
        _database.ListAsync<ProductoPrecioEntity>(ProductoPrecioDbObjects.SelAllActive,
            p => p.AddEmpresa(_user.CoEmpresaRequired));
}
