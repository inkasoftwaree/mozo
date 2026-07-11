///<summary>
///
///</summary>
///<remarks>
///</remarks>
///<history>
/// t[Jonatan Abregu]	16/11/2018	Created
///</history>
namespace Mozo.Domain.Empresa;



[Serializable]
public class LocalEntity : BaseEntity //<LocalModel>
{
    public string? NoDireccion { get; set; }
    public int? CoLocal { get; set; }
    public string? NoLocal { get; set; }
    public string? NoCodigoPostal { get; set; }
    public int? FlPrincipal { get; set; }
}