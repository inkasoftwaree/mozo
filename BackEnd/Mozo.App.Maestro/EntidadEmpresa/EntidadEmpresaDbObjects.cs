using Mozo.Infrastructure.Persistence.Objects;

namespace Mozo.App.Maestro.EntidadEmpresa;

public static class EntidadEmpresaDbObjects
{
    private const string Schema = "maestro";
    private static readonly DbObjectFactory.StandardDbObjects _std = DbObjectFactory.Standard(Schema, "entidadempresa");

    public static DbObject Insert => _std.Insert;

}