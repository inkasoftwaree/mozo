namespace Mozo.App.Maestro.EntidadDireccion.Contracts;

/// <summary>
/// DTO plano para traer una Dirección a editar (GET SelById). Espeja los campos
/// editables de la entidad (PK + FK ids + textos), sin objetos anidados: los combos
/// (país, ubigeo, etiqueta) se preseleccionan con los FK ids.
/// </summary>
public sealed class EntidadDireccionEditResponse
{
    public int? CoEntidadDireccion { get; set; }
    public int? CoEntidad { get; set; }
    public int? CoEtiqueta { get; set; }
    public string? NoDireccionLinea1 { get; set; }
    public string? NoDireccionLinea2 { get; set; }
    public string? NoDireccionLinea3 { get; set; }
    public string? NoUrbanizacionBarrio { get; set; }
    public string? NoCiudad { get; set; }
    public string? NoCodigoPostal { get; set; }
    public int? CoUbigeo { get; set; }
    public decimal? SsLatitude { get; set; }
    public decimal? SsLongitude { get; set; }
    public string? NoReferencia { get; set; }
    public int? CoPais { get; set; }
    public int? FlDefault { get; set; }
}
