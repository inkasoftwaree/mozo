using Mozo.Shared.Contract;

namespace Mozo.App.Maestro.Ubigeo.Contracts;

public record UbigeoFilter : BaseFilter
{
    public int? CoPais { get; set; }
    public int? CoUbigeo { get; set; }
    public string? CoNivel1 { get; set; }
    public string? CoNivel2 { get; set; }
    public string? CoNivel3 { get; set; }
}
