namespace Mozo.Domain.Seguridad;


[Serializable]
public partial class IngresoEntity : BaseEntity
{
    public int? CoIngreso { get; set; }
    public int? CoUsuario { get; set; }
    public string? NoIp { get; set; }
    public string? NoRefreshToken { get; set; }
    public string? NoRefreshTokenPrevious { get; set; }
    public string? NoUserAgent { get; set; }

    public DateTime? FeRefreshTokenExpire { get; set; }
    public int? CoEstado { get; set; }

    public DateTime? FeSalida { get; set; }
    public DateTime? FeIngreso { get; set; }
}
