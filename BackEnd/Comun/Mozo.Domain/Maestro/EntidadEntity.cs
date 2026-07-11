namespace Mozo.Domain.Maestro;


[Serializable]
public partial class EntidadEntity : BaseEntity
{
    public int? CoEntidad { get; set; }
    public string? NoEntidad { get; set; }
}

public partial class EntidadEntity
{
    #region Tabla auxiliares => uno a muchos
    public List<EntidadDireccionEntity>? DireccionLst { get; set; }
    public List<EntidadRedSocialEntity>? RedSocialLst { get; set; }
    public List<EntidadDocumentoEntity>? DocumentoLst { get; set; }
    public List<EntidadRolEntity>? EntidadRolLst { get; set; }

    #endregion





}