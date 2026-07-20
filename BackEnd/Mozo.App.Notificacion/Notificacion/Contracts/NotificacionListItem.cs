using Mozo.Shared.Contract;

namespace Mozo.App.Notificacion.Notificacion.Contracts;

/// <summary>
/// DTO plano para la bandeja paginada (fn_notificacion_sel_all).
/// RowsCount y FlEstReg vienen de BaseListItem.
/// </summary>
public sealed class NotificacionListItem : BaseListItem
{
    public long CoNotificacion { get; set; }
    public int? CoTipoNotificacion { get; set; }
    public int? CoCanal { get; set; }
    public string? NoTitulo { get; set; }
    public string? TxMensaje { get; set; }
    public string? TxDataJson { get; set; }
    public DateTime? FeRegistro { get; set; }
    public int? FlLeido { get; set; }
}
