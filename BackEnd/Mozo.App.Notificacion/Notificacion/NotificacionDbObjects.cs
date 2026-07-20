using Mozo.Infrastructure.Persistence.Objects;

namespace Mozo.App.Notificacion.Notificacion;

/// <summary>
/// Mapa de funciones almacenadas del esquema "notificacion".
/// </summary>
public static class NotificacionDbObjects
{
    private const string Schema = "notificacion";
    private static readonly DbObjectFactory.StandardDbObjects _std =
        DbObjectFactory.Standard(Schema, "notificacion");

    public static DbObject Insert => _std.Insert;

    // fn_notificacion_delete_by_id(p_conotificacion, p_cousueli) RETURNS boolean.
    // Borrado MANUAL para corregir un registro emitido por error; no hay
    // limpieza automatica por antiguedad en este esquema.
    public static DbObject DeleteById => _std.DeleteById;

    public static readonly DbObject CountNoLeidas =
        new(Schema, "fn_notificacion_count_no_leidas", DbExecutionType.Select, DbReturnType.Scalar);

    public static readonly DbObject SelAll =
        new(Schema, "fn_notificacion_sel_all", DbExecutionType.Select, DbReturnType.List);

    public static readonly DbObject MarcarLeido =
        new(Schema, "fn_notificacion_marcar_leido", DbExecutionType.Select, DbReturnType.Scalar);

    public static readonly DbObject MarcarTodoLeido =
        new(Schema, "fn_notificacion_marcar_todo_leido", DbExecutionType.Select, DbReturnType.Scalar);
}
