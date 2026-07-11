

using Mozo.Infrastructure.Persistence.Objects;

namespace Mozo.App.Login.Empresa;

public static class EmpresaDbObjects
{
    private const string Schema = "login";
    private static readonly DbObjectFactory.StandardDbObjects _std = DbObjectFactory.Standard(Schema, "empresa");
    public static DbObject SelById => _std.SelById;
    public static DbObject SelAll => _std.SelAll;
}
