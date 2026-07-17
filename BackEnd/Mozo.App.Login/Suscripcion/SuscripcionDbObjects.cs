using Mozo.Infrastructure.Persistence.Objects;

namespace Mozo.App.Login.Suscripcion;

public static class SuscripcionDbObjects
{
    private const string Schema = "suscripcion";

    public static readonly DbObject EstadoByEmpresa =
        new(Schema, "fn_empresa_suscripcion_estado", DbExecutionType.Select, DbReturnType.Single);
}
