using Mozo.Shared.Contract;

namespace Mozo.App.Suscripcion.PlanModulo.Contracts;

public sealed class PlanModuloListItem : BaseListItem
{
    public int CoPlanModulo { get; set; }
    public int? CoModulo { get; set; }
    public string? NoModulo { get; set; }
}
