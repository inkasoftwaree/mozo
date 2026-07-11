using Mozo.Infrastructure.Persistence.Objects;

namespace Mozo.App.Maestro.DocumentoIdentidad;

public static class DocumentoIdentidadDbObjects
{
    private const string Schema = "maestro";

    public static readonly DbObject SelAllActive =
        new(Schema, "fn_documentoidentidad_sel_all_active",
            DbExecutionType.Select, DbReturnType.List);
}


