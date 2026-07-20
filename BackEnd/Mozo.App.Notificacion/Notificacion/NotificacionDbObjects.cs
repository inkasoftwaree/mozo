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

    public static readonly DbObject CountNoLeidas =
        new(Schema, "fn_notificacion_count_no_leidas", DbExecutionType.Select, DbReturnType.Scalar);

    public static readonly DbObject SelAll =
        new(Schema, "fn_notificacion_sel_all", DbExecutionType.Select, DbReturnType.List);

    public static readonly DbObject MarcarLeido =
        new(Schema, "fn_notificacion_marcar_leido", DbExecutionType.Select, DbReturnType.Scalar);

    public static readonly DbObject MarcarTodoLeido =
        new(Schema, "fn_notificacion_marcar_todo_leido", DbExecutionType.Select, DbReturnType.Scalar);
}
