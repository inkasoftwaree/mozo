///<summary>
///
///</summary>
///<remarks>
///</remarks>
///<history>
/// t[Jonatan Abregu]	30/06/2022	Created
///</history>
namespace Mozo.Domain.Urbano;


[Serializable]
public partial class BonoEntity : BaseEntity
{
    public int? CoBono { get; set; }
    public string? FeBono { get; set; }
    public decimal? SsBono { get; set; }



    public int? CoEntidad { get; set; }



    public int? CoTipoBono { get; set; }



    public int? FlBonoActual { get; set; }
}

public partial class BonoEntity
{
    public string? NoTipoBono { get; set; }


    public string? NoBonoDescripcion => SsBono.ToString() + " - " + NoNombreCompleto + " " + NoTipoBono;

    public string? NuDocumento { get; set; }
    public string? NoPersona { get; set; }
    public string? NoApellidoP { get; set; }
    public string? NoApellidoM { get; set; }

    public string? NoNombreCompleto =>
        NoPersona != null ? string.Concat(NoPersona, " ", NoApellidoP, " ", NoApellidoM) : null;
}