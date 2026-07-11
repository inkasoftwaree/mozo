using Mozo.Infrastructure.Persistence.Objects;

namespace Mozo.App.Seguridad.ModuloUsuario;

public static class ModuloUsuarioDbObjects
{
    private const string Schema = "seguridad";
    private static readonly DbObjectFactory.StandardDbObjects _std = DbObjectFactory.Standard(Schema, "modulousuario");

    public static DbObject Insert => _std.Insert;
    public static DbObject UpdateById => _std.UpdateById;
    public static DbObject DeleteById => _std.DeleteById;
    public static DbObject SelById => _std.SelById;
    public static DbObject SelAll => _std.SelAll;

    public static readonly DbObject UpdateConfiguracion =
        new(Schema, "fn_modulousuario_update_configuracion", DbExecutionType.Select, DbReturnType.Scalar);


}
