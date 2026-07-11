using Mozo.Domain.Catalogo;
using Mozo.Infrastructure.Persistence;
using Mozo.Infrastructure.Persistence.Builders;
using Mozo.Shared.Services;
using System.Data;

namespace Mozo.App.Catalogo.Producto;

public interface IProductoService
{
    // NOTA: InsertAsync / UpdateByIdAsync pendientes. Las funciones
    // fn_producto_insert / usp_producto_update_by_id reciben campos que la entidad
    // ProductoEntity normalizada ya no expone (NoCodigoInterno, SsFactorCompra) o
    // renombró (CoUnidadmedida* -> CoUnidad*). Hay que alinear la firma de la función
    // con la entidad antes de portarlos.

    Task<int> InsertAsync(ProductoEntity m);
    Task<int> UpdateByIdAsync(ProductoEntity m);
    Task<int> UpdateStateByIdAsync(ProductoEntity m);
    Task<int> DeleteByIdAsync(ProductoFilter f);
    Task<ProductoEntity?> SelByIdAsync(ProductoFilter f);
    Task<IReadOnlyList<ProductoEntity>> SelAllAsync(ProductoFilter f);
    Task<int> SelAllCountAsync(ProductoFilter f);
    Task<IReadOnlyList<ProductoEntity>> SelAllActiveAsync(ProductoFilter f);
    Task<int> SelAllActiveCountAsync(ProductoFilter f);
}

public sealed class ProductoService : IProductoService
{
    private readonly IDatabase _database;
    private readonly UserContext _user;

    public ProductoService(IDatabase database, UserContext user)
    {
        _database = database;
        _user = user;
    }

    public Task<int> InsertAsync(ProductoEntity m) =>
     _database.ScalarAsync<int>(ProductoDbObjects.Insert,
         p => p.AddEmpresa(_user.CoEmpresaRequired)
               .Add("CoProducto", m.CoProducto, DbType.Int32)
               .Add("NoCodigoInterno", m.NoCodigoInterno, DbType.String)
               .Add("CoMarca", m.CoMarca, DbType.Int32)
               .Add("CoLaboratorio", m.CoLaboratorio, DbType.Int32)
               .Add("NoProducto", m.NoProducto, DbType.String)
               .Add("NoModelo", m.NoModelo, DbType.String)
               .Add("CoUnidadMedidaInventario", m.CoUnidadMedidaInventario, DbType.Int32)
               .Add("CoUnidadMedidaCompra", m.CoUnidadMedidaCompra, DbType.Int32)
               .Add("CoUnidadMedidaVenta", m.CoUnidadMedidaVenta, DbType.Int32)
               .Add("SsFactorCompra", m.SsFactorCompra, DbType.Decimal)
               .Add("CoProveedorPrincipal", m.CoProveedorPrincipal, DbType.Int32)
               .Add("TxDescripcionCorta", m.TxDescripcionCorta, DbType.String)
               .Add("CoCategoria", m.CoCategoria, DbType.Int32)
               .Add("CoCategoriaHijo", m.CoCategoriaHijo, DbType.Int32)
               .Add("CoTipo", m.CoTipo, DbType.Int32)
               .Add("FlImpuesto", m.FlImpuesto, DbType.Int32)
               .Add("FlInventario", m.FlInventario, DbType.Int32)
               .Add("NoCodigoFiscal", m.NoCodigoFiscal, DbType.String)
               .Add("FlImpuestoExento", m.FlImpuestoExento, DbType.Int32)
               .Add("SsFactorVenta", m.SsFactorVenta, DbType.Decimal)
               .AddUserCreate(_user.CoUsuarioRequired));

    public Task<int> UpdateByIdAsync(ProductoEntity m) =>
        _database.ScalarAsync<int>(ProductoDbObjects.UpdateById,
            p => p.AddEmpresa(_user.CoEmpresaRequired)
               .Add("CoProducto", m.CoProducto, DbType.Int32)
               .Add("NoCodigoInterno", m.NoCodigoInterno, DbType.String)
               .Add("CoMarca", m.CoMarca, DbType.Int32)
               .Add("CoLaboratorio", m.CoLaboratorio, DbType.Int32)
               .Add("NoProducto", m.NoProducto, DbType.String)
               .Add("NoModelo", m.NoModelo, DbType.String)
               .Add("CoUnidadMedidaInventario", m.CoUnidadMedidaInventario, DbType.Int32)
               .Add("CoUnidadMedidaCompra", m.CoUnidadMedidaCompra, DbType.Int32)
               .Add("CoUnidadMedidaVenta", m.CoUnidadMedidaVenta, DbType.Int32)
               .Add("SsFactorCompra", m.SsFactorCompra, DbType.Decimal)
               .Add("CoProveedorPrincipal", m.CoProveedorPrincipal, DbType.Int32)
               .Add("TxDescripcionCorta", m.TxDescripcionCorta, DbType.String)
               .Add("CoCategoria", m.CoCategoria, DbType.Int32)
               .Add("CoCategoriaHijo", m.CoCategoriaHijo, DbType.Int32)
               .Add("CoTipo", m.CoTipo, DbType.Int32)
               .Add("FlImpuesto", m.FlImpuesto, DbType.Int32)
               .Add("FlInventario", m.FlInventario, DbType.Int32)
               .Add("NoCodigoFiscal", m.NoCodigoFiscal, DbType.String)
               .Add("FlImpuestoExento", m.FlImpuestoExento, DbType.Int32)
               .Add("SsFactorVenta", m.SsFactorVenta, DbType.Decimal)
               .AddUserUpdate(_user.CoUsuarioRequired));

    public Task<int> UpdateStateByIdAsync(ProductoEntity m) =>
        _database.ScalarAsync<int>(ProductoDbObjects.UpdateStateById,
            p => p.AddEmpresa(_user.CoEmpresaRequired)
                  .Add("CoProducto", m.CoProducto, DbType.Int32)
                  .Add("FlEstReg", m.FlEstReg, DbType.Int32)
                  .AddUserUpdate(_user.CoUsuarioRequired));

    public Task<int> DeleteByIdAsync(ProductoFilter f) =>
        _database.ScalarAsync<int>(ProductoDbObjects.DeleteById,
            p => p.AddEmpresa(_user.CoEmpresaRequired)
                  .Add("CoProducto", f.CoProducto, DbType.Int32)
                  .AddUserDelete(_user.CoUsuarioRequired));

    public Task<ProductoEntity?> SelByIdAsync(ProductoFilter f) =>
        _database.FirstAsync<ProductoEntity>(ProductoDbObjects.SelById,
            p => p.AddEmpresa(_user.CoEmpresaRequired)
                  .Add("CoProducto", f.CoProducto, DbType.Int32));

    public Task<IReadOnlyList<ProductoEntity>> SelAllAsync(ProductoFilter f) =>
        _database.ListAsync<ProductoEntity>(ProductoDbObjects.SelAll,
            p => p.AddEmpresa(_user.CoEmpresaRequired)
                  .Add("CoProveedorPrincipal", f.CoProveedorPrincipal, DbType.Int32)
                  .Add("CoMarca", f.CoMarca, DbType.Int32)
                  .Add("NoInputSearch", f.NoInputSearch, DbType.String)
                  .Add("PageSize", f.PageSize, DbType.Int32)
                  .Add("PageIndex", f.PageIndex, DbType.Int32));

    public Task<int> SelAllCountAsync(ProductoFilter f) =>
        _database.ScalarAsync<int>(ProductoDbObjects.SelAllCount,
            p => p.AddEmpresa(_user.CoEmpresaRequired)
                  .Add("CoProveedorPrincipal", f.CoProveedorPrincipal, DbType.Int32)
                  .Add("CoMarca", f.CoMarca, DbType.Int32)
                  .Add("NoInputSearch", f.NoInputSearch, DbType.String));

    public Task<IReadOnlyList<ProductoEntity>> SelAllActiveAsync(ProductoFilter f) =>
        _database.ListAsync<ProductoEntity>(ProductoDbObjects.SelAllActive,
            p => p.AddEmpresa(_user.CoEmpresaRequired)
                  .Add("PageSize", f.PageSize, DbType.Int32)
                  .Add("CursorId", f.CursorId, DbType.Int32)
                  .Add("Direction", f.Direction, DbType.Int32));

    public Task<int> SelAllActiveCountAsync(ProductoFilter f) =>
        _database.ScalarAsync<int>(ProductoDbObjects.SelAllCount,
            p => p.AddEmpresa(_user.CoEmpresaRequired));
}
