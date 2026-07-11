using Mozo.Infrastructure.Persistence.Objects;

namespace Mozo.App.Login.Menu;

public static class MenuDbObjects
{
    private const string Schema = "login";

    private static readonly DbObjectFactory.StandardDbObjects _std = DbObjectFactory.Standard(Schema, "menu");
    public static DbObject SelAll => _std.SelAll;
}
