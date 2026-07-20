namespace Mozo.App.Notificacion.Notificacion.Contracts;

/// <summary>
/// Entrada para EMITIR una notificacion. La usan los demas modulos (onboarding,
/// ventas, suscripcion...) via INotificacionService.EmitirAsync. No se expone por
/// HTTP: es de uso interno servidor-a-servidor.
/// </summary>
public sealed class NotificacionEmitir
{
    public required string TipoSigla { get; set; }
    public CanalNotificacion Canal { get; set; } = CanalNotificacion.InApp;
    public int? CoUsuarioDestino { get; set; }
    public string? NoTitulo { get; set; }
    public string? TxMensaje { get; set; }
    public string? TxDataJson { get; set; }
    public DateTime? FeProgramada { get; set; }
}
