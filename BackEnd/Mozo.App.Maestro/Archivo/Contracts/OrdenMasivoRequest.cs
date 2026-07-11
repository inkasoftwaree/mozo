namespace Mozo.App.Maestro.Archivo.Contracts;

public class OrdenMasivoRequest
{
    public int? CoEmpresa { get; set; }
    public int? FlEmpresaNotKey { get; set; }

    public List<OrdenArchivo> Ordenes { get; set; } = new();
}
