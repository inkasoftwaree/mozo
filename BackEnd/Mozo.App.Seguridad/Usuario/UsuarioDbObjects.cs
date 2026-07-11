using Mozo.Infrastructure.Persistence.Objects;

namespace Mozo.App.Seguridad.Usuario;

public static class UsuarioDbObjects
{
    private const string Schema = "seguridad";
    private static readonly DbObjectFactory.StandardDbObjects _std = DbObjectFactory.Standard(Schema, "usuario");

    public static DbObject Insert => _std.Insert;
    public static DbObject UpdateById => _std.UpdateById;
    public static DbObject UpdateStateById => _std.UpdateStateById;
    public static DbObject SelById => _std.SelById;

    public static readonly DbObject UpdateClave =
        new(Schema, "fn_usuario_update_clave_by_id", DbExecutionType.Select, DbReturnType.Scalar);


}
