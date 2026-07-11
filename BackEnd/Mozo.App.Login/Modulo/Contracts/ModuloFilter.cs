using Mozo.Shared.Contract;

namespace Mozo.App.Login.Modulo.Contracts;

public record ModuloFilter : BaseFilter
{
    public int? CoModulo { get; set; }
}
