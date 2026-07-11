namespace Mozo.Domain.Seguridad;



[Serializable]
public partial class PerfilEntity : BaseEntity
{
    public int? CoPerfil { get; set; }
    public string? NoPerfil { get; set; }
    public int? CoModulo { get; set; }

    public int? FlAdmin { get; set; }

    public int? FlDefault { get; set; }

}
public partial class PerfilEntity
{
    public List<PerfilPaginaEntity>? PerfilPaginaLst { get; set; }

}

