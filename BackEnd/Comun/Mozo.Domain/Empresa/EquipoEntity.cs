using Mozo.Domain.Maestro;

///<summary>
///
///</summary>
///<remarks>
///</remarks>
///<history>
/// t[Jonatan Abregu]	16/03/2022	Created
///</history>
namespace Mozo.Domain.Empresa;


[Serializable]
public partial class EquipoEntity : BaseEntity //<EquipoModel>
{
    public int? CoEquipo { get; set; }
    public int? CoPersona { get; set; }
    public string? NoExtracto { get; set; }
}

public partial class EquipoEntity
{
    public EntidadEntity? Persona { get; set; }

}