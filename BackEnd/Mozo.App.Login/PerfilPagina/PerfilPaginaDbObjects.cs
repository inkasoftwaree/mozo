using Mozo.Infrastructure.Persistence.Objects;

namespace Mozo.App.Login.PerfilPagina;

public static class PerfilPaginaDbObjects
{
    private const string Schema = "login";

    public static readonly DbObject SelAllByModuloAndPerfil =
        new(Schema, "fn_perfilpagina_sel_all_by_modulo_and_perfil", DbExecutionType.Select, DbReturnType.List);
}
