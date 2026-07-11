using Mozo.Infrastructure.Persistence.Objects;

namespace Mozo.App.Maestro.PersonaJuridica;

public static class PersonaJuridicaDbObjects
{
    private const string Schema = "maestro";
    private static readonly DbObjectFactory.StandardDbObjects _std = DbObjectFactory.Standard(Schema, "personajuridica");

    public static DbObject Insert => _std.Insert;
    public static DbObject UpdateById => _std.UpdateById;
    public static DbObject SelById => _std.SelById;
    public static DbObject SelAll => _std.SelAll;

    public static readonly DbObject SelAllActive =
        new(Schema, "fn_personajuridica_sel_all_active", DbExecutionType.Select, DbReturnType.List);
}