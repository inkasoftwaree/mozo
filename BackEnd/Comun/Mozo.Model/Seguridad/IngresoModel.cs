namespace Mozo.Model.Seguridad;

public record IngresoFilterDto : BaseFilterDto //IngresoFilter>
{

    public int? CoEmpresa { get; set; }
    public int? CoIngreso { get; set; }
    public string? NoRefreshToken { get; set; }
}
[Serializable]
public partial class IngresoModel : BaseModel //<IngresoModel>
{
    public int? CoIngreso { get; set; }
    public int? CoPersona { get; set; }
    public int? CoPermiso { get; set; }
    public string? NoIp { get; set; }
    public string? NoRefreshToken { get; set; }
    public string? NoRefreshTokenPrevious { get; set; }
    public string? NoUserAgent { get; set; }

    public DateTime? FeRefreshTokenExpire { get; set; }
    public int? CoEstado { get; set; }


}
public partial class IngresoModel
{
    public int? CoEmpresa { get; set; }
}
