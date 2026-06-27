using Mozo.Model.Empresa;
using Mozo.Model.Maestro;
using System.Formats.Asn1;
using static Mozo.Helper.Enu.EnuCommon;
using static Mozo.Helper.Enu.EnuTipoGeneral.Contabilidad;
using static Mozo.Helper.Enu.EnuTipoParticular.Matricula;
using static System.Net.Mime.MediaTypeNames;

///<summary>
///
///</summary>
///<remarks>
///</remarks>
///<history>
/// t[Jonatan Abregu]	16/11/2018	Created
///</history>
namespace Mozo.Model.Seguridad;

public record EmpresaFilterDto : BaseFilterDto //EmpresaFilter>
{
    public string? NoRazonSocial { get; set; }
    public string? NuDocumento { get; set; }
    
        
    public int? CoEmpresa { get; set; }
    public int? CoEntidad { get; set; }

}
[Serializable]
public partial class EmpresaModel : BaseModel
{

    public int? CoEmpresa { get; set; }
    public int? CoEntidad { get; set; }
    public string? NoVision { get; set; }
    public string? NoMision { get; set; }
    public string? TxQuienSoy { get; set; }   
    public string? NoEmpresaCorto { get; set; }    
    public int? CoMoneda { get; set; }    
    public int? CoPais { get; set; }
    public int? CoIdioma { get; set; }
    public string? Configuracion { get; set; }

}

public partial class EmpresaModel
{
    public EntidadModel? Entidad { get; set; }
    public PersonaJuridicaModel? PersonaJuridica { get; set; }

    public List<EmpresaModuloModel>? EmpresaModuloLst { get; set; }
    public List<HorarioModel>? HorarioCol { get; set; }

    #region Insertar rapido - Documento
    public int? CoDocumentoIdentidad { get; set; }
    public string? NuDocumento { get; set; }

    #endregion

    #region Insertar rapido - Direcccion
    public string? NoDirecionLinea1 { get; set; }
    public int? CoUbigeo { get; set; }

    #endregion

    #region Insertar rapido - Redes sociales
    public string? NoTelefonoFijo { get; set; }
    public string? NoTelefonoCelular { get; set; }
    public string? NoCorreo { get; set; }
    #endregion




	


}