using Microsoft.AspNetCore.Http.HttpResults;

using Mozo.ApiSeguridad.Helper;
using Mozo.MaestroBusiness;
using Mozo.Model.Maestro;

namespace Mozo.Api.Maestro;

public static partial class PersonaTipoEndPoints
{
    public static RouteGroupBuilder MapPersonaTipo(this RouteGroupBuilder g)
    {
        g.DisableAntiforgery().RequireAuthorization();
        g.MapPost("/", InsertAsync);
        g.MapPut("/", UpdateAsync).RequireAuthorization();
        g.MapGet("", SelAllActiveAsync);
        return g;
    }

}
public static partial class PersonaTipoEndPoints
{
    static async Task<Results<Created<int?>, ValidationProblem>> InsertAsync(EntidadRolModel m, IPersonaTipoBusiness IPersonaTipo)
    {
        m.CoPersonaTipo = await IPersonaTipo.InsertAsync(m);
        return TypedResults.Created($"/{m.CoPersonaTipo}", m.CoPersonaTipo);
    }

    static async Task<Results<Ok<int?>, ValidationProblem>> UpdateAsync(EntidadRolModel m, IPersonaTipoBusiness IPersonaTipo)
    {

        await IPersonaTipo.UpdateAsync(m);
        return TypedResults.Ok(m.CoPersona);
    }

    static async Task<Results<Ok<IEnumerable<EntidadRolModel>>, ValidationProblem>> SelAllActiveAsync([AsParameters] PersonaTipoFilter f, IPersonaTipoBusiness IPersonaTipo)
    {
        IEnumerable<EntidadRolModel> r = Enumerable.Empty<EntidadRolModel>();
        if (f.CoModulo != null && f.CoPersona != null)
            r = await IPersonaTipo.SelAllActiveByModuleAndPersonAsync(new());
        else if (f.CoModulo == null && f.CoPersona != null)
            r = await IPersonaTipo.SelAllActiveByPersonAsync(new());
        else if (f.CoModulo == null && f.CoPersona == null)
            r = await IPersonaTipo.SelAllActiveAsync(new());
        return TypedResults.Ok(r);
    }



}


