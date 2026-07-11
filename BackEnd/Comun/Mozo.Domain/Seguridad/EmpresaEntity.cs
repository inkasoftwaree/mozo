using Mozo.Domain.Empresa;
using Mozo.Domain.Maestro;

///<summary>
///
///</summary>
///<remarks>
///</remarks>
///<history>
/// t[Jonatan Abregu]	16/11/2018	Created
///</history>
namespace Mozo.Domain.Seguridad;


[Serializable]
public partial class EmpresaEntity : BaseEntity
{
    public int? CoEmpresa { get; set; }
    public int? CoEntidad { get; set; }
    public string? NoVision { get; set; }
    public string? NoMision { get; set; }
    public string? TxQuienSoy { get; set; }
    public int? CoMoneda { get; set; }
    public int? CoPais { get; set; }
    public int? CoIdioma { get; set; }
    public string? Configuracion { get; set; }
}

public partial class EmpresaEntity
{
    public EntidadEntity? Entidad { get; set; }
    public PersonaJuridicaEntity? PersonaJuridica { get; set; }
    public List<EmpresaModuloEntity>? EmpresaModuloLst { get; set; }
    public List<HorarioEntity>? HorarioCol { get; set; }


}