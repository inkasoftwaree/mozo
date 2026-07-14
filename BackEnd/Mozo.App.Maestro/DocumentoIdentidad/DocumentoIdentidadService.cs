using Mozo.App.Maestro.DocumentoIdentidad.Contracts;
using Mozo.Infrastructure.Persistence;
using System.Data;

namespace Mozo.App.Maestro.DocumentoIdentidad;

public interface IDocumentoIdentidadService
{
    Task<IReadOnlyList<DocumentoIdentidadOption>> SelAllActiveAsync(DocumentoIdentidadFilter f);
}

public sealed class DocumentoIdentidadService : IDocumentoIdentidadService
{
    private readonly IDatabase _database;

    public DocumentoIdentidadService(IDatabase database)
    {
        _database = database;
    }

    public Task<IReadOnlyList<DocumentoIdentidadOption>> SelAllActiveAsync(DocumentoIdentidadFilter f) =>
        _database.ListAsync<DocumentoIdentidadOption>(DocumentoIdentidadDbObjects.SelAllActive,
            p => p.Add("CoPais", f.CoPais, DbType.Int32)
                  .Add("CoAmbito", f.CoAmbito, DbType.Int32)
         );
}
