using Mozo.Api.Abstractions;
using Mozo.App.Catalogo.ProductoStock;
using Mozo.Domain.Catalogo;

namespace Mozo.Api.Catalogo;
/// <summary>
/// Clase estatica que para llamar al grupo de end points "tblproductostock".
/// </summary>
public sealed partial class ProductoStockEndPoints : IEndpoint
{
    public string Prefix => "/catalogo/producto-stock";

    /// <summary>
    /// Función que devuelve el grupo de end points de la entidad "tblproductostock".
    /// </summary>
    public void MapEndpoint(RouteGroupBuilder g)
    {
        g.DisableAntiforgery().RequireAuthorization();
        g.MapPost("/", InsertAsync);
        g.MapPut("/", UpdateByIdAsync);
        g.MapPatch("/state", UpdateStateByIdAsync);
        g.MapDelete("/", DeleteByIdAsync);
        g.MapGet("/all", SelAllAsync);
        g.MapGet("/active", SelAllActiveAsync);
        g.MapGet("/", SelByIdAsync);
    }
}
/// <summary>
/// Clase estatica donde se encuentran los procedimientos y funciones de los end points "tblproductostock".
/// </summary>
public partial class ProductoStockEndPoints
{

    static async Task<IResult> InsertAsync(ProductoStockEntity m, IProductoStockService IProductostock)
    {

        m.CoProductoStock = await IProductostock.InsertAsync(m);
        return Results.Created($"/{m.CoProductoStock}", m.CoProductoStock);
    }

    static async Task<IResult>
    UpdateByIdAsync(
        ProductoStockEntity m,
        IProductoStockService IProductostock
    )
    {
        int filas = await IProductostock.UpdateByIdAsync(m);
        return filas > 0 ? Results.Ok(filas) : Results.NotFound();
    }

    static async Task<IResult>
    UpdateStateByIdAsync(
        ProductoStockEntity m,
        IProductoStockService IProductostock
    )
    {
        int filas = await IProductostock.UpdateStateByIdAsync(m);
        return filas > 0 ? Results.Ok(filas) : Results.NotFound();
    }

    static async Task<IResult>
    DeleteByIdAsync(
        [AsParameters] ProductoStockFilter f,
        IProductoStockService IProductostock)
    {
        int filas = await IProductostock.DeleteByIdAsync(f);
        return filas > 0 ? Results.Ok(filas) : Results.NotFound();
    }

    static async Task<IResult> SelAllAsync([AsParameters] ProductoStockFilter f, IProductoStockService IProductostock)
    {
        IEnumerable<ProductoStockEntity> r = await IProductostock.SelAllAsync(f);
        return Results.Ok(r);
    }

    static async Task<IResult> SelAllActiveAsync([AsParameters] ProductoStockFilter f, IProductoStockService IProductostock)
    {
        IEnumerable<ProductoStockEntity> r = await IProductostock.SelAllActiveAsync(f);
        return Results.Ok(r);
    }

    static async Task<IResult> SelByIdAsync([AsParameters] ProductoStockFilter f, IProductoStockService IProductostock)
    {
        ProductoStockEntity? i = await IProductostock.SelByIdAsync(f);
        if (i == null)
            return Results.NotFound();
        return Results.Ok(i);
    }

}
