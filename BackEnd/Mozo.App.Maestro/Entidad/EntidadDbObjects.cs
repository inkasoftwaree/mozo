using Mozo.Infrastructure.Persistence.Objects;

namespace Mozo.App.Maestro.Entidad;

public static class EntidadDbObjects
{
    private const string Schema = "maestro";
    private static readonly DbObjectFactory.StandardDbObjects _std = DbObjectFactory.Standard(Schema, "entidad");

    public static DbObject Insert => _std.Insert;
    public static DbObject UpdateById => _std.UpdateById;
    public static DbObject DeleteById => _std.DeleteById;
    public static DbObject UpdateStateById => _std.UpdateStateById;

}