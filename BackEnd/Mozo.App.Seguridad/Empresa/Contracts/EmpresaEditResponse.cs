namespace Mozo.App.Seguridad.Empresa.Contracts;

/// <summary>
/// DTO plano para traer una Empresa a editar (GET). Su forma espeja la del update
/// (PK + campos editables + FK ids), sin objetos anidados ni splitOn:
/// los combos (país, moneda, idioma) se preseleccionan con los FK ids y sus
/// opciones las carga el frontend desde los endpoints de lookup cacheados.
/// </summary>
public sealed class EmpresaEditResponse
{
    public int CoEmpresa { get; set; }
    public int? CoEntidad { get; set; }
    public string? NoMision { get; set; }
    public string? NoVision { get; set; }
    public string? TxQuienSoy { get; set; }
    public int? CoPais { get; set; }
    public int? CoMoneda { get; set; }
    public int? CoIdioma { get; set; }

    #region Persona Juridica
    public string? NoRazonSocial { get; set; }
    public string? NoComercial { get; set; }
    #endregion
}
