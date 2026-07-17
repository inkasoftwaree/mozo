using Mozo.Shared.Contract;

namespace Mozo.App.Suscripcion.AccesoModulo.Contracts;

public record AccesoModuloFilter : BaseFilter
{
    public int? CoEmpresa { get; set; }
    public int? CoModulo { get; set; }
}
