using Mozo.Api.Abstractions;
using Mozo.App.Login.Empresa;
using Mozo.App.Login.Empresa.Contracts;

namespace Mozo.Api.Login;

///<summary>
/// Endpoints para gestión de Empresa
///</summary>
///<history>
/// Create by Jonatan Abregu
///</history>
public sealed partial class EmpresaEndPoints : IEndpoint
{
    public string Prefix => "/login/empresa";

    /// <summary>
    /// Mapea todas las rutas de Empresa
    /// </summary>
    public void MapEndpoint(RouteGroupBuilder g)
    {
        g.WithSecurity();

        g.MapGet("/", SelByIdAsync)
           .WithResponses<EmpresaDetailResponse>(StatusCodes.Status200OK)
           .Produces(StatusCodes.Status404NotFound)
           .WithDescription("Obtener una Empresa");

        g.MapGet("/all", SelAllAsync)
           .WithResponses<IEnumerable<EmpresaOption>>(StatusCodes.Status200OK)
           .WithDescription("Obtener todas las empresas");
    }

}

public partial class EmpresaEndPoints
{
    private static async Task<IResult>
         SelByIdAsync(
             [AsParameters] EmpresaFilter f,
             IEmpresaService IEmpresa
         )
    {
        EmpresaDetailResponse? i = await IEmpresa.SelByIdAsync(f);
        if (i == null)
            return Results.NotFound();
        return Results.Ok(i);
    }

    private static async Task<IResult>
        SelAllAsync(IEmpresaService IEmpresa)
    {
        var r = await IEmpresa.SelAllAsync();
        return Results.Ok(r);
    }

}