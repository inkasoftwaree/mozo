using Mozo.Api.Abstractions;
using Mozo.App.Catalogo.ProductoAtributo;
using Mozo.Domain.Catalogo;

namespace Mozo.Api.Catalogo;
/// <summary>
/// Clase estatica que para llamar al grupo de end points "tblproductoatributo".
/// </summary>
public sealed partial class ProductoAtributoEndPoints : IEndpoint
{
    public string Prefix => "/catalogo/producto-atributo";

    /// <summary>
    /// Función que devuelve el grupo de end points de la entidad "tblproductoatributo".
    /// </summary>
    public void MapEndpoint(RouteGroupBuilder g)
    {
        g.DisableAntiforgery().RequireAuthorization();
        g.MapPost("/", InsertAsync);
        g.MapPut("/", UpdateByIdAsync);
        g.MapPatch("/state", UpdateStateByIdAsync);
        g.MapDelete("/", DeleteByIdAsync);
        g.MapGet("/", SelByIdAsync);
        g.MapGet("/all", SelAllAsync);
        g.MapGet("/active", SelAllActiveAsync);
    }
}
/// <summary>
/// Clase estatica donde se encuentran los procedimientos y funciones de los end points "tblproductoatributo".
/// </summary>
public partial class ProductoAtributoEndPoints
{

    static async Task<IResult>
        InsertAsync(ProductoAtributoEntity m,
        IProductoAtributoService IProductoatributo
        )
    {
        m.CoProductoAtributo = await IProductoatributo.InsertAsync(m);
        return Results.Created($"/{m.CoProductoAtributo}", m.CoProductoAtributo);
    }

    static async Task<IResult>
    UpdateByIdAsync(
        ProductoAtributoEntity m,
        IProductoAtributoService IProductoatributo
    )
    {
        int filas = await IProductoatributo.UpdateByIdAsync(m);
        return filas > 0 ? Results.Ok(filas) : Results.NotFound();
    }

    static async Task<IResult>
        UpdateStateByIdAsync(ProductoAtributoEntity m,
        IProductoAtributoService IProductoatributo)
    {
        int filas = await IProductoatributo.UpdateStateByIdAsync(m);
        return filas > 0 ? Results.Ok(filas) : Results.NotFound();
    }

    static async Task<IResult>
    DeleteByIdAsync(
        [AsParameters] ProductoAtributoFilter f,
        IProductoAtributoService IProductoatributo)
    {
        int filas = await IProductoatributo.DeleteByIdAsync(f);
        return filas > 0 ? Results.Ok(filas) : Results.NotFound();
    }

    static async Task<IResult>
    SelAllAsync([AsParameters] ProductoAtributoFilter f,
        IProductoAtributoService IProductoatributo)
    {

        IEnumerable<ProductoAtributoEntity> r = await IProductoatributo.SelAllAsync(f);
        return Results.Ok(r);
    }

    static async Task<IResult>
    SelAllActiveAsync(
        [AsParameters] ProductoAtributoFilter f,
        IProductoAtributoService IProductoatributo)
    {

        IEnumerable<ProductoAtributoEntity> r = await IProductoatributo.SelAllActiveAsync(f);
        return Results.Ok(r);
    }

    static async Task<IResult>
    SelByIdAsync(
        [AsParameters] ProductoAtributoFilter f,
        IProductoAtributoService IProductoatributo)
    {
        ProductoAtributoEntity? i = await IProductoatributo.SelByIdAsync(f);
        if (i == null)
            return Results.NotFound();
        return Results.Ok(i);
    }

}
