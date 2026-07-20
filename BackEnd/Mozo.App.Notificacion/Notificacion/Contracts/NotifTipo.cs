namespace Mozo.App.Notificacion.Notificacion.Contracts;

/// <summary>
/// Codigos estables (NoSigla en maestro.trftipogeneral) de los tipos de notificacion.
/// El codigo SIEMPRE referencia por estas constantes, nunca por el id numerico del
/// catalogo (que puede variar entre bases). Mantener en sync con las filas sembradas
/// en trftipogeneral.
/// </summary>
public static class NotifTipo
{
    public const string Bienvenida = "NOTIF_BIENVENIDA";
    public const string PedidoNuevo = "NOTIF_PEDIDO_NUEVO";
    public const string PedidoListo = "NOTIF_PEDIDO_LISTO";
    public const string MesaCuenta = "NOTIF_MESA_CUENTA";
    public const string PlanPorVencer = "NOTIF_PLAN_POR_VENCER";
    public const string PlanVencido = "NOTIF_PLAN_VENCIDO";
}
