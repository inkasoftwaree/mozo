///<summary>
///
///</summary>
///<remarks>
///</remarks>
///<history>
/// t[Jonatan Abregu]	16/11/2018	Created
///</history>

namespace Mozo.Domain.Maestro;


public partial class UbigeoEntity : BaseEntity
{
    public string? NoCodigo { get; set; }
    public string? CoNivel1 { get; set; }
    public string? CoNivel2 { get; set; }
    public string? CoNivel3 { get; set; }
    public int? CoUbigeo { get; set; }
    public int? CoPais { get; set; }
    public string? NoNivel1 { get; set; }
    public string? NoNivel2 { get; set; }
    public string? NoNivel3 { get; set; }
}

