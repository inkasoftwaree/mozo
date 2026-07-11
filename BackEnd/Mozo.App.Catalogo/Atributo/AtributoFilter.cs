using Mozo.Shared.Contract;

namespace Mozo.App.Catalogo.Atributo;

public record AtributoFilter : BaseFilter
{
    public int? CoAtributo { get; set; }
}
