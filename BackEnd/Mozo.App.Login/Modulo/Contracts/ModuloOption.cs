namespace Mozo.App.Login.Modulo.Contracts;

/// <summary>
/// DTO plano para la lista de módulos del login (SelAll).
/// Alineado con login.fn_modulo_sel_all: nuorden, comodulo.
/// </summary>
public sealed class ModuloOption
{
    public int CoModulo { get; set; }
    public int? NuOrden { get; set; }
}
