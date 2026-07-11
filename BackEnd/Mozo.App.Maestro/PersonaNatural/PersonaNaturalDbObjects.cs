using Mozo.Infrastructure.Persistence.Objects;

namespace Mozo.App.Maestro.PersonaNatural;

public static class PersonaNaturalDbObjects
{
    private const string Schema = "maestro";
    private static readonly DbObjectFactory.StandardDbObjects _std = DbObjectFactory.Standard(Schema, "personanatural");

    public static DbObject Insert => _std.Insert;
    public static DbObject UpdateById => _std.UpdateById;
    public static DbObject SelById => _std.SelById;
    public static DbObject SelAll => _std.SelAll;

    public static readonly DbObject SelAllActive =
       new(Schema, "fn_personanatural_sel_all_active", DbExecutionType.Select, DbReturnType.List);
}