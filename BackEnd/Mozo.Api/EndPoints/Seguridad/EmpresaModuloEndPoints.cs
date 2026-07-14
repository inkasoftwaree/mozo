using Mozo.Api.Abstractions;
using Mozo.App.Seguridad.EmpresaModulo;
using Mozo.App.Seguridad.EmpresaModulo.Contracts;
using Mozo.App.Seguridad.Modulo;
using Mozo.App.Seguridad.Modulo.Contracts;
using Mozo.Domain.Seguridad;

namespace Mozo.Api.Seguridad;

///<summary>
/// Endpoints para gestión de EmpresaModulo
///</summary>
///<history>
/// Create by Jonatan Abregu
///</history>
public sealed partial class EmpresaModuloEndPoints : IEndpoint
{
    public string Prefix => "/seguridad/empresa-modulo";

    /// <summary>
    /// Mapea todas las rutas de EmpresaModulo
    /// </summary>
    public void MapEndpoint(RouteGroupBuilder g)
    {
        g.WithSecurity();

        g.MapPost("/", InsertAsync)
             .WithResponsesValue<int>(StatusCodes.Status201Created)
             .WithDescription("Insertar una EmpresaModulo");



        g.MapDelete("/", DeleteByIdAsync)
          .WithResponsesValue<int>(StatusCodes.Status200OK)
          .Produces(StatusCodes.Status404NotFound)
          .WithDescription("Eliminar una EmpresaModulo");

        g.MapGet("/", SelByIdAsync)
         .WithResponses<EmpresaModuloEntity>(StatusCodes.Status200OK)
         .Produces(StatusCodes.Status404NotFound)
         .WithDescription("Obtener una EmpresaModulo");

        g.MapGet("/all", SelAllAsync)
          .WithResponses<IEnumerable<EmpresaModuloEntity>>(StatusCodes.Status200OK)
          .Produces(StatusCodes.Status404NotFound)
          .WithDescription("Obtener todos los Módulos de la Empresa");

        g.MapGet("/select-unselect", SelSelectAndUnSelectAllAsync)
          .WithResponses<IEnumerable<EmpresaModuloEntity>>(StatusCodes.Status200OK)
          .Produces(StatusCodes.Status404NotFound)
          .WithDescription("Obtener todos los Módulos de la Empresa y los Módulos no seleccionados");
    }

}

public partial class EmpresaModuloEndPoints
{
    private static async Task<IResult>
        InsertAsync(
            EmpresaModuloEntity m,
            IEmpresaModuloService IEmpresaModulo
         )
    {

        m.CoEmpresaModulo = await IEmpresaModulo.InsertAsync(m);
        return Results.Created($"/{m.CoEmpresaModulo}", m.CoEmpresaModulo);
    }



    private static async Task<IResult>
         DeleteByIdAsync(
             [AsParameters] EmpresaModuloFilter f,
               IEmpresaModuloService IEmpresaModulo
      )
    {
        int filas = await IEmpresaModulo.DeleteByIdAsync(f);
        return filas > 0 ? Results.Ok(filas) : Results.NotFound();
    }


    private static async Task<IResult>
         SelByIdAsync(
             [AsParameters] EmpresaModuloFilter f,
           IEmpresaModuloService IEmpresaModulo
        )
    {
        EmpresaModuloEditResponse? i = await IEmpresaModulo.SelByIdAsync(f);
        if (i is null)
            return Results.NotFound();
        return Results.Ok(i);
    }

    static async Task<IResult>
        SelSelectAndUnSelectAllAsync(
            [AsParameters] EmpresaModuloFilter f,
            IModuloService IModulo,
            IEmpresaModuloService IEmpresaModulo
    )
    {
        List<ModuloOption> moduloLst = (await IModulo.SelAllActiveAsync()).ToList();
        List<EmpresaModuloListItem> empresaModuloLst = (await IEmpresaModulo.SelAllAsync(f)).ToList();

        foreach (EmpresaModuloListItem item in empresaModuloLst)
            item.FlEstReg = 1;

        foreach (ModuloOption item in moduloLst)
        {
            EmpresaModuloListItem? empresaModuloFind = empresaModuloLst.Find(x => x.CoModulo == item.CoModulo);
            if (empresaModuloFind == null)
                empresaModuloLst.Add(new() { CoModulo = item.CoModulo, NoModulo = item.NoModulo, FlEstReg = 0, NuOrden = item.NuOrden });
            else
                empresaModuloFind.NuOrden = item.NuOrden;
        }

        empresaModuloLst = empresaModuloLst.OrderBy(x => x.NuOrden).ToList();
        return Results.Ok(empresaModuloLst);
    }


    static async Task<IResult>
       SelAllAsync(
           [AsParameters] EmpresaModuloFilter f,
           IEmpresaModuloService IEmpresaModulo
    )
    {
        var r = await IEmpresaModulo.SelAllAsync(f);
        r = r.OrderBy(x => x.NoModulo).ToList();
        return Results.Ok(r);
    }



}