using Mozo.Infrastructure.Persistence.Objects;

namespace Mozo.App.Suscripcion.AccesoModulo;

public static class AccesoModuloDbObjects
{
    private const string Schema = "suscripcion";

    public static readonly DbObject Habilitado =
        new(Schema, "fn_empresa_modulo_habilitado", DbExecutionType.Select, DbReturnType.Scalar);

    public static readonly DbObject SelHabilitados =
        new(Schema, "fn_empresa_modulo_sel_habilitados", DbExecutionType.Select, DbReturnType.List);
}
