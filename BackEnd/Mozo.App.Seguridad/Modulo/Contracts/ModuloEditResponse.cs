namespace Mozo.App.Seguridad.Modulo.Contracts;

/// <summary>
/// DTO plano para traer un Módulo a editar (GET). PK + campos editables.
/// </summary>
public sealed class ModuloEditResponse
{
    public int CoModulo { get; set; }
    public string? NoModulo { get; set; }
    public string? NoModuloDescripcion { get; set; }
    public string? NoArea { get; set; }
    public int? NuOrden { get; set; }
    public string? NoIcono { get; set; }
    public int? FlArea { get; set; }
}
