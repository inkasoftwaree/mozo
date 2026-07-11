using Mozo.Shared.Contract;

namespace Mozo.App.Login.Menu;

public record MenuFilter : BaseFilter
{
    public int? CoModulo { get; set; }
}
