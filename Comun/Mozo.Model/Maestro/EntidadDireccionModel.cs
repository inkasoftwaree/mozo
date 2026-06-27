///<summary>
///
///</summary>
///<remarks>
///</remarks>
///<history>
/// t[Jonatan Abregu]	18-04-2020	Created
///</history>
namespace Mozo.Model.Maestro;

public record EntidadDireccionFilterDto : BaseFilterDto //PersonaTipoFilter>
{
    public int? CoEntidadDireccion { get; set; }
    public int? CoEntidad { get; set; }
}

[Serializable]
public partial class EntidadDireccionModel : BaseModel //<PersonaTipoModel>
{
    public int? CoPersonaDireccion { get; set; }
    public int? CoEntidad { get; set; }    
    public int? CoEtiqueta { get; set; }
    public string? NoDirecionLinea1 { get; set; }
    public string? NoDirecionLinea2 { get; set; }
    public string? NoDirecionLinea3 { get; set; }
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
public partial class EntidadDireccionModel
{

}