///<summary>
///
///</summary>
///<remarks>
///</remarks>
///<history>
/// t[Jonatan Abregu]	04-05-2020	Created
///</history>
namespace Mozo.Domain.Empresa;



[Serializable]
public partial class BlogMensajeEntity : BaseEntity
{
    public int? CoBlog { get; set; }
    public int? CoBlogMensaje { get; set; }
    public string? NoMensaje { get; set; }
    public string? NoEmail { get; set; }
    public string? NoPersona { get; set; }

}
public partial class BlogMensajeEntity
{
    public string? NoApellidoP { get; set; }
    public string? NoApellidoM { get; set; }
}