using Mozo.Infrastructure.Persistence.Objects;

namespace Mozo.App.Maestro.Pais;

public static class PaisDbObjects
{
    private const string Schema = "maestro";

    public static readonly DbObject SelAllActive =
        new(Schema, "fn_pais_sel_all_active", DbExecutionType.Select, DbReturnType.List);
}