using Mozo.Shared.Contract;

namespace Mozo.App.Maestro.EntidadDireccion.Contracts;

/// <summary>
/// DTO plano para los listados de Direcciones de una entidad (SelAll / SelAllActive).
/// FlEstReg y RowsCount vienen de BaseListItem.
/// </summary>
public sealed class EntidadDireccionListItem : BaseListItem
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
