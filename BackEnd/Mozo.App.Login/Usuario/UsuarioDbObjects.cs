using Mozo.Infrastructure.Persistence.Objects;

namespace Mozo.App.Login.Usuario;

public static class UsuarioDbObjects
{
    private const string Schema = "login";

    private static readonly DbObjectFactory.StandardDbObjects _std = DbObjectFactory.Standard(Schema, "usuario");
    public static DbObject SelById => _std.SelById;

    public static readonly DbObject SelByUser =
        new(Schema, "fn_usuario_sel_by_user", DbExecutionType.Select, DbReturnType.Single);


    public static readonly DbObject SelByEmpresa =
        new(Schema, "fn_usuario_sel_by_empresa", DbExecutionType.Select, DbReturnType.Single);
}
