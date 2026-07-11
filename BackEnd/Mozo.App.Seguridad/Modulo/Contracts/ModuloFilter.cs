using Mozo.Shared.Contract;

namespace Mozo.App.Seguridad.Modulo.Contracts;

public record ModuloFilter : BaseFilter
{
    public int? CoModulo { get; set; }
}
