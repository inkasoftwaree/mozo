using Mozo.Infrastructure.Persistence.Objects;

namespace Mozo.App.Seguridad.EmpresaModulo;

public static class EmpresaModuloDbObjects
{
    private const string Schema = "seguridad";
    private static readonly DbObjectFactory.StandardDbObjects _std = DbObjectFactory.Standard(Schema, "empresamodulo");

    public static DbObject Insert => _std.Insert;
    // public static DbObject UpdateById => _std.UpdateById;
    public static DbObject DeleteById => _std.DeleteById;
    public static DbObject SelById => _std.SelById;
    public static DbObject SelAll => _std.SelAll;

}
