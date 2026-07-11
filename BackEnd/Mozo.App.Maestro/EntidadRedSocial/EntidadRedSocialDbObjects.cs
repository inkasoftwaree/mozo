using Mozo.Infrastructure.Persistence.Objects;

namespace Mozo.App.Maestro.EntidadRedSocial;

public static class EntidadRedSocialDbObjects
{
    private const string Schema = "maestro";
    private static readonly DbObjectFactory.StandardDbObjects _std = DbObjectFactory.Standard(Schema, "entidadredsocial");

    public static DbObject Insert => _std.Insert;
    public static DbObject UpdateById => _std.UpdateById;
    public static DbObject DeleteById => _std.DeleteById;
    public static DbObject SelById => _std.SelById;
    public static DbObject SelAll => _std.SelAll;
}