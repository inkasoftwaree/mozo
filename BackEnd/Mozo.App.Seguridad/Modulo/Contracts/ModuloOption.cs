namespace Mozo.App.Seguridad.Modulo.Contracts;

/// <summary>
/// DTO plano para las listas de Módulos activos. Es la unión de las columnas que devuelven
/// las 3 funciones que lo usan (cada una llena las suyas, el resto queda null):
///   - fn_modulo_sel_all_active           → comodulo, nomodulo
///   - fn_modulo_sel_all_active_area       → comodulo, noarea
///   - fn_modulo_sel_all_active_for_empresa→ comodulo, nomodulo, nuorden
/// </summary>
public sealed class ModuloOption
{
    public int CoModulo { get; set; }
    public int? NuOrden { get; set; }
    public string? NoModulo { get; set; }

}
