namespace Mozo.App.Suscripcion.Plan.Contracts;

public sealed class PlanEditResponse
{
    public int CoPlan { get; set; }
    public string? NoPlan { get; set; }
    public string? NoPlanDescripcion { get; set; }
    public int? NuOrden { get; set; }
    public int? NuDiasPrueba { get; set; }
    public string? Valor { get; set; }
    public int? FlPublico { get; set; }
    public int? FlDefault { get; set; }
    public int? FlEstReg { get; set; }
}
