using Mozo.Domain.Maestro;
using Mozo.Infrastructure.Persistence;
using System.Data;

namespace Mozo.App.Maestro.DocumentoIdentidad;

public interface IDocumentoIdentidadService
{
    Task<IEnumerable<DocumentoIdentidadEntity>> SelAllActiveAsync(DocumentoIdentidadFilter f);
}

public sealed class DocumentoIdentidadService : IDocumentoIdentidadService
{
    private readonly IDatabase _database;

    public DocumentoIdentidadService(IDatabase database)
    {
        _database = database;
    }

    public async Task<IEnumerable<DocumentoIdentidadEntity>> SelAllActiveAsync(DocumentoIdentidadFilter f) =>
        await _database.ListAsync<DocumentoIdentidadEntity>(DocumentoIdentidadDbObjects.SelAllActive,
            p => p.Add("CoPais", f.CoPais, DbType.Int32)
                  .Add("CoAmbito", f.CoAmbito, DbType.Int32)
         );


}