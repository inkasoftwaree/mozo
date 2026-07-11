using Mozo.Infrastructure.Persistence.Objects;

namespace Mozo.App.Login.Pagina;

public static class PaginaDbObjects
{
    private const string Schema = "login";

    private static readonly DbObjectFactory.StandardDbObjects _std = DbObjectFactory.Standard(Schema, "pagina");
    public static DbObject SelAll => _std.SelAll;
}
