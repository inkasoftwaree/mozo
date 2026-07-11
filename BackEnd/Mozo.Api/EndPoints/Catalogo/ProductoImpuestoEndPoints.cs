using Mozo.Api.Abstractions;
using Mozo.App.Catalogo.ProductoImpuesto;
using Mozo.Domain.Catalogo;

namespace Mozo.Api.Catalogo;
/// <summary>
/// Clase estatica que para llamar al grupo de end points "tblproductoimpuesto".
/// </summary>
public sealed partial class ProductoImpuestoEndPoints : IEndpoint
{
    public string Prefix => "/catalogo/producto-impuesto";

    /// <summary>
    /// Función que devuelve el grupo de end points de la entidad "tblproductoimpuesto".
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
/// Clase estatica donde se encuentran los procedimientos y funciones de los end points "tblproductoimpuesto".
/// </summary>
public partial class ProductoImpuestoEndPoints
{

    static async Task<IResult> InsertAsync(ProductoImpuestoEntity m, IProductoImpuestoService IProductoimpuesto)
    {
        m.CoProductoImpuesto = await IProductoimpuesto.InsertAsync(m);
        return Results.Created($"/{m.CoProductoImpuesto}", m.CoProductoImpuesto);
    }

    static async Task<IResult> UpdateByIdAsync(ProductoImpuestoEntity m, IProductoImpuestoService IProductoimpuesto)
    {
        int filas = await IProductoimpuesto.UpdateByIdAsync(m);
        return filas > 0 ? Results.Ok(filas) : Results.NotFound();
    }

    static async Task<IResult> UpdateStateByIdAsync(ProductoImpuestoEntity m, IProductoImpuestoService IProductoimpuesto)
    {
        int filas = await IProductoimpuesto.UpdateStateByIdAsync(m);
        return filas > 0 ? Results.Ok(filas) : Results.NotFound();
    }

    static async Task<IResult> DeleteByIdAsync([AsParameters] ProductoImpuestoFilter f, IProductoImpuestoService IProductoimpuesto)
    {
        int filas = await IProductoimpuesto.DeleteByIdAsync(f);
        return filas > 0 ? Results.Ok(filas) : Results.NotFound();
    }

    static async Task<IResult> SelAllAsync([AsParameters] ProductoImpuestoFilter f, IProductoImpuestoService IProductoimpuesto)
    {

        IEnumerable<ProductoImpuestoEntity> r = await IProductoimpuesto.SelAllAsync(f);
        return Results.Ok(r);
    }

    static async Task<IResult>
    SelAllActiveAsync(
        [AsParameters] ProductoImpuestoFilter f,
        IProductoImpuestoService IProductoimpuesto
    )
    {
        IEnumerable<ProductoImpuestoEntity> r = await IProductoimpuesto.SelAllActiveAsync(f);
        return Results.Ok(r);
    }

    static async Task<IResult>
    SelByIdAsync(
        [AsParameters] ProductoImpuestoFilter f,
        IProductoImpuestoService IProductoimpuesto)
    {
        ProductoImpuestoEntity? i = await IProductoimpuesto.SelByIdAsync(f);
        if (i == null)
            return Results.NotFound();
        return Results.Ok(i);
    }

}
