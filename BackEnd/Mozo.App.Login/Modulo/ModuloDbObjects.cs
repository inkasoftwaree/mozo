using Mozo.Infrastructure.Persistence.Objects;

namespace Mozo.App.Login.Modulo;

public static class ModuloDbObjects
{
    private const string Schema = "login";
    private static readonly DbObjectFactory.StandardDbObjects _std = DbObjectFactory.Standard(Schema, "modulo");
    public static DbObject SelById => _std.SelById;
    public static DbObject SelAll => _std.SelAll;


}
