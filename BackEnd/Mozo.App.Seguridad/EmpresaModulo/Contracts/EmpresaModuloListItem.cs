using Mozo.Shared.Contract;

namespace Mozo.App.Seguridad.EmpresaModulo.Contracts;

public sealed partial class EmpresaModuloListItem : BaseListItem
{
    public int? CoEmpresaModulo { get; set; }
    public int? CoModulo { get; set; }
    public string? NoModulo { get; set; }
}

public sealed partial class EmpresaModuloListItem
{
    public int? NuOrden { get; set; }

}