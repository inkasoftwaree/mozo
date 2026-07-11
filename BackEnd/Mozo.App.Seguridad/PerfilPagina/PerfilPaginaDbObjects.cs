using Mozo.Infrastructure.Persistence.Objects;

namespace Mozo.App.Seguridad.PerfilPagina;

public static class PerfilPaginaDbObjects
{
    private const string Schema = "seguridad";
    private static readonly DbObjectFactory.StandardDbObjects _std = DbObjectFactory.Standard(Schema, "perfilpagina");

    public static DbObject Insert => _std.Insert;
    public static DbObject SelAll => _std.SelAll;

    public static readonly DbObject DeleteByModuloAndPerfil =
        new(Schema, "fn_perfilpagina_delete_by_modulo_and_perfil", DbExecutionType.Select, DbReturnType.Scalar);
}
