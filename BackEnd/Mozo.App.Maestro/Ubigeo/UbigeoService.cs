using Mozo.Domain.Maestro;
using Mozo.Infrastructure.Persistence;
using System.Data;

namespace Mozo.App.Maestro.Ubigeo;

public interface IUbigeoService
{
    Task<UbigeoEntity?> SelByIdAsync(UbigeoFilter f);
    Task<IEnumerable<UbigeoEntity>> SelAllNivel1Async(UbigeoFilter f);
    Task<IEnumerable<UbigeoEntity>> SelAllNivel2Async(UbigeoFilter f);
    Task<IEnumerable<UbigeoEntity>> SelAllNivel3Async(UbigeoFilter f);
}

public sealed class UbigeoService : IUbigeoService
{
    private readonly IDatabase _database;

    public UbigeoService(IDatabase database)
    {
        _database = database;
    }

    public Task<UbigeoEntity?> SelByIdAsync(UbigeoFilter f) =>
        _database.FirstAsync<UbigeoEntity>(UbigeoDbObjects.SelById,
            p => p.Add("CoUbigeo", f.CoUbigeo, DbType.Int32));

    public async Task<IEnumerable<UbigeoEntity>> SelAllNivel1Async(UbigeoFilter f)
    {
        IEnumerable<UbigeoEntity> r = await _database.ListAsync<UbigeoEntity>(UbigeoDbObjects.SelAllNivel1,
            p => p.Add("CoPais", f.CoPais, DbType.Int32));

        return r.OrderBy(s => s.CoNivel1);
    }


    public async Task<IEnumerable<UbigeoEntity>> SelAllNivel2Async(UbigeoFilter f)
    {
        IEnumerable<UbigeoEntity> r = await _database.ListAsync<UbigeoEntity>(UbigeoDbObjects.SelAllNivel2,
            p => p
                .Add("CoPais", f.CoPais, DbType.Int32)
                .Add("CoNivel1", f.CoNivel1, DbType.String));

        return r.OrderBy(s => s.CoNivel2);
    }


    public async Task<IEnumerable<UbigeoEntity>> SelAllNivel3Async(UbigeoFilter f)
    {
        IEnumerable<UbigeoEntity> r = await _database.ListAsync<UbigeoEntity>(UbigeoDbObjects.SelAllNivel3,
           p => p
               .Add("CoPais", f.CoPais, DbType.Int32)
               .Add("CoNivel1", f.CoNivel1, DbType.String)
               .Add("CoNivel2", f.CoNivel2, DbType.String));

        return r.OrderBy(s => s.CoNivel3);
    }

}