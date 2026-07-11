///<summary>
///
///</summary>
///<remarks>
///</remarks>
///<history>
/// t[Jonatan Abregu]	07-05-2020	Created
///</history>
namespace Mozo.Domain.Empresa;


[Serializable]
public class ClienteEntity : BaseEntity
{
    public string? NoCargo { get; set; }
    public int? CoCliente { get; set; }
    public string? NoCliente { get; set; }
    public string? TxOpinion { get; set; }
    public int? FlOpinion { get; set; }
}