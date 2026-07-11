using Mozo.Infrastructure.Persistence.Objects;

namespace Mozo.App.Login.ModuloUsuario;

public static class ModuloUsuarioDbObjects
{
    private const string Schema = "login";

    private static readonly DbObjectFactory.StandardDbObjects _std = DbObjectFactory.Standard(Schema, "modulousuario");
    public static DbObject SelById => _std.SelById;

    public static readonly DbObject SelByModulo =
        new(Schema, "fn_modulousuario_sel_by_modulo", DbExecutionType.Select, DbReturnType.Single);

    public static readonly DbObject SelAllByUsuario =
        new(Schema, "fn_modulousuario_sel_all_by_usuario", DbExecutionType.Select, DbReturnType.List);
}
