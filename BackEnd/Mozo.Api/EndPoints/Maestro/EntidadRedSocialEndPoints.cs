using Mozo.Api.Abstractions;
using Mozo.App.Maestro.EntidadRedSocial;
using Mozo.Domain.Maestro;

namespace Mozo.Api.Maestro;
///<summary>
/// Endpoints para gestión de RedSocial
///</summary>
///<history>
/// Create by Jonatan Abregu
///</history>
public sealed partial class EntidadRedSocialEndPoints : IEndpoint
{
    public string Prefix => "/maestro/red-social";

    /// <summary>
    /// Mapea todas las rutas de RedSocial
    /// </summary>
    public void MapEndpoint(RouteGroupBuilder g)
    {
        g.WithSecurity();

        g.MapPost("/", InsertAsync)
         .WithResponsesValue<int>(StatusCodes.Status201Created)
         .WithDescription("Insertar una Red Social");

        g.MapPut("/", UpdateByIdAsync)
          .WithResponsesValue<int>(StatusCodes.Status200OK)
          .Produces(StatusCodes.Status404NotFound)
          .WithDescription("Actualizar una Red Social");

        g.MapDelete("/", DeleteByIdAsync)
             .WithResponsesValue<int>(StatusCodes.Status200OK)
             .Produces(StatusCodes.Status404NotFound)
             .WithDescription("Eliminar una  Red Social");

        g.MapGet("/", SelByIdAsync)
            .WithResponses<EntidadRedSocialEntity>(StatusCodes.Status200OK)
            .Produces(StatusCodes.Status404NotFound)
            .WithDescription("Obtener una Red Social");

        g.MapGet("/all", SelAllAsync)
          .WithResponses<IEnumerable<EntidadRedSocialEntity>>(StatusCodes.Status200OK)
          .WithDescription("Obtener todas las Redes Social");
    }
}
public partial class EntidadRedSocialEndPoints
{
    private static async Task<IResult>
        InsertAsync(
            EntidadRedSocialEntity m,
            IEntidadRedSocialService IRedSocial)
    {

        m.CoEntidadRedSocial = await IRedSocial.InsertAsync(m);
        return Results.Created($"/{m.CoEntidadRedSocial}", m.CoEntidadRedSocial);
    }

    private static async Task<IResult>
        UpdateByIdAsync(
            EntidadRedSocialEntity m,
            IEntidadRedSocialService IRedSocial
        )
    {
        int filas = await IRedSocial.UpdateByIdAsync(m);
        return filas > 0 ? Results.Ok(filas) : Results.NotFound();
    }

    private static async Task<IResult> DeleteByIdAsync(
        [AsParameters] EntidadRedSocialFilter f,
        IEntidadRedSocialService IRedSocial)
    {
        int filas = await IRedSocial.DeleteByIdAsync(f);
        return filas > 0 ? Results.Ok(filas) : Results.NotFound();
    }

    private static async Task<IResult>
        SelAllAsync(
            [AsParameters] EntidadRedSocialFilter f,
            IEntidadRedSocialService IRedSocial
       )
    {
        IEnumerable<EntidadRedSocialEntity> r = await IRedSocial.SelAllAsync(f);
        r = r.OrderBy(x => x.CoTipoRedSocial).ThenBy(y => y.NoRedSocial);
        return Results.Ok(r);
    }


    private static async Task<IResult>
         SelByIdAsync(
         [AsParameters] EntidadRedSocialFilter f,
         IEntidadRedSocialService IRedSocial
     )
    {
        EntidadRedSocialEntity? i = await IRedSocial.SelByIdAsync(f);
        if (i == null)
            return Results.NotFound();
        return Results.Ok(i);
    }

}



