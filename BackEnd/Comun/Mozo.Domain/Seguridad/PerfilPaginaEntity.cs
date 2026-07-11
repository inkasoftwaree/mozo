namespace Mozo.Domain.Seguridad;


[Serializable]
public partial class PerfilPaginaEntity : BaseEntity //<PerfilPaginaModel>
{
    public int? CoPerfilPagina { get; set; }
    public int? CoPerfil { get; set; }
    public int? CoPagina { get; set; }

    public int? CoModulo { get; set; }
    public int? CoMenu { get; set; }


}




