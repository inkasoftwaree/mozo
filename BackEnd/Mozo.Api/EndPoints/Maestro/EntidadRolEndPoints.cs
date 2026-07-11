using Mozo.Api.Abstractions;
using Mozo.App.Maestro.EntidadRol;
using Mozo.Domain.Maestro;

namespace Mozo.Api.Maestro;

///<summary>
/// Endpoints para gestión de EntidadRol
///</summary>
///<history>
/// Create by Jonatan Abregu
///</history>
public sealed partial class EntidadRolEndPoints : IEndpoint
{
    public string Prefix => "/maestro/entidad-rol";

    /// <summary>
    /// Mapea todas las rutas de EntidadRol
    /// </summary>
    public void MapEndpoint(RouteGroupBuilder g)
    {
        g.DisableAntiforgery().RequireAuthorization();
        g.MapPost("/", InsertAsync);
        g.MapPut("/", UpdateByIdAsync);
        g.MapGet("/ative", SelAllActiveAsync);
    }

}
public partial class EntidadRolEndPoints
{
    static async Task<IResult> InsertAsync(
        EntidadRolEntity m,
        IEntidadRolService IEntidadRol)
    {
        m.CoRolNegocio = await IEntidadRol.InsertAsync(m);
        return Results.Created($"/{m.CoRolNegocio}", m.CoRolNegocio);
    }

    static async Task<IResult> UpdateByIdAsync(EntidadRolEntity m,
        IEntidadRolService IEntidadRol
        )
    {
        int filas = await IEntidadRol.UpdateByIdAsync(m);
        return filas > 0 ? Results.Ok(filas) : Results.NotFound();
    }

    static async Task<IResult>
        SelAllActiveAsync([AsParameters] EntidadRolFilter f,
       IEntidadRolService IEntidadRol)
    {
        IEnumerable<EntidadRolEntity> r = Enumerable.Empty<EntidadRolEntity>();
        if (f.CoModulo != null && f.CoEntidad != null)
            r = await IEntidadRol.SelAllActiveByModuleAndPersonAsync(new());
        else if (f.CoModulo == null && f.CoEntidad != null)
            r = await IEntidadRol.SelAllActiveByPersonAsync(new());
        else if (f.CoModulo == null && f.CoEntidad == null)
            r = await IEntidadRol.SelAllActiveAsync(new());
        return Results.Ok(r);
    }



}


