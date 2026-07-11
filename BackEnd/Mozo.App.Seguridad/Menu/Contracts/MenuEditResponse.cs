namespace Mozo.App.Seguridad.Menu.Contracts;

/// <summary>
/// DTO plano para traer un Menu a editar (GET SelById). PK + FK padre + campos editables.
/// Nota: los listados de Menu (SelAll/SelAllActive) alimentan el árbol (MenuSeguridad)
/// y siguen devolviendo MenuEntity con su estructura anidada — no aplican DTO plano.
/// </summary>
public sealed class MenuEditResponse
{
    public int CoMenu { get; set; }
    public int? CoModulo { get; set; }
    public int? NuOrden { get; set; }
    public string? NoMenu { get; set; }
    public string? NoModuloDescripcion { get; set; }

}

