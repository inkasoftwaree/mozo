namespace Mozo.Shared.Token.Model;

/// <summary>
/// Estado de la suscripción de la empresa, devuelto en la respuesta del login
/// para que el front decida el ruteo sin round-trips ni ambigüedad:
///   FlExiste = 0  -> la empresa nunca contrató (pantalla de alta de plan)
///   FlAcceso = 1  -> suscripción vigente (app normal)
///   FlAcceso = 0  -> vencida/suspendida (pantalla de renovación)
///   EsOwner  = 1  -> el usuario es el dueño (mostrar CTA "Renovar/Pagar")
/// Mapea suscripcion.fn_empresa_suscripcion_estado(p_coempresa, p_cousuario).
/// </summary>
public class SuscripcionEstadoModel
{
    public int? FlExiste { get; set; }
    public int? CoSuscripcion { get; set; }
    public int? CoEstado { get; set; }
    public string? NoEstado { get; set; }
    public DateTime? FeFin { get; set; }
    public int? DiasRestantes { get; set; }
    public int? FlAcceso { get; set; }
    public int? EsOwner { get; set; }
}
