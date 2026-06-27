using Mozo.Model.Seguridad;

namespace Mozo.Model.Maestro;

public record EntidadFilter : BaseFilterDto
{
    public int? CoEntidad { get; set; }
}


[Serializable]
public partial class EntidadModel : BaseModel //<PersonaModel>
{
    public int? CoEntidad{ get; set; }
    public string? NoEntidad { get; set; }
}

public partial class EntidadModel
{
    #region Tabla auxiliares => uno a muchos
    public IEnumerable<EntidadDireccionModel>? EntidadDireccionLst { get; set; }
    public IEnumerable<EntidadRedSocialModel>? EntidadRedSocialLst { get; set; }
    public List<EntidadRolModel>? EntidadRolLst { get; set; }
    public List<EntidadDocumentoModel>? EntidadDocumentoLst { get; set; }
    #endregion

    #region Field join Red Social - Primer ingreso
    public string? NoTelefonoMovil { get; set; }
    public string? NoTelefonoFijo { get; set; }
    public string? NoCorreoElectronico { get; set; }
    #endregion

    #region Field join Documentos - Primer ingreso
    public string? CoDocumentoIdentidad { get; set; }
    public string? NuDocumento { get; set; }
    #endregion

}