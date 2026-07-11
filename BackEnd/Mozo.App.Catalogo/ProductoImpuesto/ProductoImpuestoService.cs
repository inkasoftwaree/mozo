using Mozo.Domain.Catalogo;
using Mozo.Infrastructure.Persistence;
using Mozo.Infrastructure.Persistence.Builders;
using Mozo.Shared.Services;
using System.Data;

namespace Mozo.App.Catalogo.ProductoImpuesto;

public interface IProductoImpuestoService
{
    Task<int> InsertAsync(ProductoImpuestoEntity m);
    Task<int> UpdateByIdAsync(ProductoImpuestoEntity m);
    Task<int> UpdateStateByIdAsync(ProductoImpuestoEntity m);
    Task<int> DeleteByIdAsync(ProductoImpuestoFilter f);
    Task<ProductoImpuestoEntity?> SelByIdAsync(ProductoImpuestoFilter f);
    Task<IReadOnlyList<ProductoImpuestoEntity>> SelAllAsync(ProductoImpuestoFilter f);
    Task<IReadOnlyList<ProductoImpuestoEntity>> SelAllActiveAsync(ProductoImpuestoFilter f);
}

public sealed class ProductoImpuestoService : IProductoImpuestoService
{
    private readonly IDatabase _database;
    private readonly UserContext _user;

    public ProductoImpuestoService(IDatabase database, UserContext user)
    {
        _database = database;
        _user = user;
    }

    public Task<int> InsertAsync(ProductoImpuestoEntity m) =>
        _database.ScalarAsync<int>(ProductoImpuestoDbObjects.Insert,
            p => p.AddEmpresa(_user.CoEmpresaRequired)
                  .Add("CoProducto", m.CoProducto, DbType.Int32)
                  .Add("CoImpuesto", m.CoImpuesto, DbType.Int32)
                  .Add("CoImpuestoHijo", m.CoImpuestoHijo, DbType.Int32)
                  .Add("PqTaza", m.PqTaza, DbType.Decimal)
                  .AddUserCreate(_user.CoUsuarioRequired));

    public Task<int> UpdateByIdAsync(ProductoImpuestoEntity m) =>
        _database.ScalarAsync<int>(ProductoImpuestoDbObjects.UpdateById,
            p => p.AddEmpresa(_user.CoEmpresaRequired)
                  .Add("CoProductoImpuesto", m.CoProductoImpuesto, DbType.Int32)
                  .Add("CoProducto", m.CoProducto, DbType.Int32)
                  .Add("CoImpuesto", m.CoImpuesto, DbType.Int32)
                  .Add("CoImpuestoHijo", m.CoImpuestoHijo, DbType.Int32)
                  .Add("PqTaza", m.PqTaza, DbType.Decimal)
                  .AddUserUpdate(_user.CoUsuarioRequired));

    public Task<int> UpdateStateByIdAsync(ProductoImpuestoEntity m) =>
        _database.ScalarAsync<int>(ProductoImpuestoDbObjects.UpdateStateById,
            p => p.AddEmpresa(_user.CoEmpresaRequired)
                  .Add("CoProductoImpuesto", m.CoProductoImpuesto, DbType.Int32)
                  .Add("FlEstReg", m.FlEstReg, DbType.Int32)
                  .AddUserUpdate(_user.CoUsuarioRequired));

    public Task<int> DeleteByIdAsync(ProductoImpuestoFilter f) =>
        _database.ScalarAsync<int>(ProductoImpuestoDbObjects.DeleteById,
            p => p.AddEmpresa(_user.CoEmpresaRequired)
                  .Add("CoProductoImpuesto", f.CoProductoImpuesto, DbType.Int32)
                  .AddUserDelete(_user.CoUsuarioRequired));

    public Task<ProductoImpuestoEntity?> SelByIdAsync(ProductoImpuestoFilter f) =>
        _database.FirstAsync<ProductoImpuestoEntity>(ProductoImpuestoDbObjects.SelById,
            p => p.AddEmpresa(_user.CoEmpresaRequired)
                  .Add("CoProductoImpuesto", f.CoProductoImpuesto, DbType.Int32));

    public Task<IReadOnlyList<ProductoImpuestoEntity>> SelAllAsync(ProductoImpuestoFilter f) =>
        _database.ListAsync<ProductoImpuestoEntity>(ProductoImpuestoDbObjects.SelAll,
            p => p.AddEmpresa(_user.CoEmpresaRequired));

    public Task<IReadOnlyList<ProductoImpuestoEntity>> SelAllActiveAsync(ProductoImpuestoFilter f) =>
        _database.ListAsync<ProductoImpuestoEntity>(ProductoImpuestoDbObjects.SelAllActive,
            p => p.AddEmpresa(_user.CoEmpresaRequired));
}
