using Mozo.Shared.Contract;

namespace Mozo.App.Maestro.Archivo.Contracts;

public record ArchivoFilter : BaseFilter
{
    public int? CoEmpresa { get; set; }
    public int? CoArchivo { get; set; }
    public int? CoTipoEntidad { get; set; }
    public int? CoEntidad { get; set; }
    public int? CoTipo { get; set; }
    public int? NuOrden { get; set; }

    public int? FlEmpresaNotKey { get; set; }

}