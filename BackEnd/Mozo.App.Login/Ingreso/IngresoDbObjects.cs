using Mozo.Infrastructure.Persistence.Objects;

namespace Mozo.App.Login.Ingreso;

public static class IngresoDbObjects
{
    private const string Schema = "login";

    private static readonly DbObjectFactory.StandardDbObjects _std = DbObjectFactory.Standard(Schema, "ingreso");
    public static DbObject Insert => _std.Insert;

    public static readonly DbObject Replace =
        new(Schema, "fn_ingreso_replace", DbExecutionType.Select, DbReturnType.Scalar);

    public static readonly DbObject SelByRefreshToken =
        new(Schema, "fn_ingreso_sel_by_refreshtoken", DbExecutionType.Select, DbReturnType.Single);

    public static readonly DbObject Revoke =
        new(Schema, "fn_ingreso_revoke", DbExecutionType.Select, DbReturnType.Scalar);

    public static readonly DbObject RevokeAll =
        new(Schema, "fn_ingreso_revoke_all", DbExecutionType.Select, DbReturnType.Scalar);
}
