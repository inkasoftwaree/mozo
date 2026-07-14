using Mozo.Shared.Contract;

namespace Mozo.App.Maestro.EntidadRol.Contracts;

public record EntidadRolFilter : BaseFilter
{
    public int? CoModulo { get; set; }
    public int? CoEntidad { get; set; }
    public int? CoEmpresa { get; set; }
    public int? CoRolNegocio { get; set; }
}
