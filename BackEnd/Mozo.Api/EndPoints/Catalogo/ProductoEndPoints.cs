using Mozo.Api.Abstractions;
using Mozo.App.Catalogo.Producto;
using Mozo.Domain.Catalogo;


namespace Mozo.Api.Catalogo;
/// <summary>
/// Clase estatica que para llamar al grupo de end points "tblproducto".
/// </summary>
public sealed partial class ProductoEndPoints : IEndpoint
{
    public string Prefix => "/catalogo/producto";

    /// <summary>
    /// Función que devuelve el grupo de end points de la entidad "tblproducto".
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
/// Clase estatica donde se encuentran los procedimientos y funciones de los end points "tblproducto".
/// </summary>
public partial class ProductoEndPoints
{

    static async Task<IResult>
        InsertAsync(
        ProductoEntity m, IProductoService IProducto)
    {
        m.CoProducto = await IProducto.InsertAsync(m);
        return Results.Created($"/{m.CoProducto}", m.CoProducto);
    }

    static async Task<IResult>
        UpdateByIdAsync(
         ProductoEntity m, IProductoService IProducto)
    {
        int filas = await IProducto.UpdateByIdAsync(m);
        return filas > 0 ? Results.Ok(filas) : Results.NotFound();
    }

    static async Task<IResult>
        UpdateStateByIdAsync(
        ProductoEntity m, IProductoService IProducto)
    {
        int filas = await IProducto.UpdateStateByIdAsync(m);
        return filas > 0 ? Results.Ok(filas) : Results.NotFound();
    }

    static async Task<IResult>
        DeleteByIdAsync(
        [AsParameters] ProductoFilter f, IProductoService IProducto)
    {
        int filas = await IProducto.DeleteByIdAsync(f);
        return filas > 0 ? Results.Ok(filas) : Results.NotFound();
    }

    static async Task<IResult>
        SelAllAsync(
        [AsParameters] ProductoFilter f,
        IProductoService IProducto)
    {
        IEnumerable<ProductoEntity> r = await IProducto.SelAllAsync(f);
        return Results.Ok(r);
    }

    static async Task<IResult>
        SelAllActiveAsync([AsParameters] ProductoFilter f, IProductoService IProducto)
    {
        IEnumerable<ProductoEntity> r = await IProducto.SelAllActiveAsync(f);
        return Results.Ok(r);
    }

    static async Task<IResult>
        SelByIdAsync([AsParameters] ProductoFilter f, IProductoService IProducto)
    {
        ProductoEntity? i = await IProducto.SelByIdAsync(f);
        if (i == null)
            return Results.NotFound();
        return Results.Ok(i);
    }

}
