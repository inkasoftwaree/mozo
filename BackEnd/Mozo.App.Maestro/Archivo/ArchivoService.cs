using Mozo.App.Maestro.Archivo.Contracts;
using Mozo.Domain.Maestro;
using Mozo.Infrastructure.Persistence;
using Mozo.Infrastructure.Persistence.Builders;
using Mozo.Shared.Services;
using System.Data;

namespace Mozo.App.Maestro.Archivo;

public interface IArchivoService
{
    Task<int> InsertAsync(ArchivoEntity m);
    Task<int> UpdateMetaDataByIdAsync(ArchivoEntity m);
    Task<int> UpdateByIdAsync(ArchivoEntity m);
    Task<int> DeleteByIdAsync(ArchivoFilter f);
    Task<int> UpdateOrderAsync(ArchivoEntity m);
    Task<int> UpdateOrderMassiveAsync(OrdenMasivoRequest req);
    Task<ArchivoEditResponse?> SelByIdAsync(ArchivoFilter f);
    Task<ArchivoEditResponse?> SelMetaDataByIdAsync(ArchivoFilter f);
    Task<ArchivoEditResponse?> SelMetaDataByUkAsync(ArchivoFilter f);
    Task<IReadOnlyList<ArchivoListItem>> SelAllAsync(ArchivoFilter f);
    Task<IReadOnlyList<ArchivoListItem>> SelAllActiveAsync(ArchivoFilter f);
}

public sealed class ArchivoService : IArchivoService
{
    private readonly IDatabase _database;
    private readonly UserContext _user;

    public ArchivoService(IDatabase database, UserContext user)
    {
        _database = database;
        _user = user;
    }

    public Task<int> InsertAsync(ArchivoEntity m) =>
        _database.ScalarAsync<int>(ArchivoDbObjects.Insert,
            p => p
                .Add("CoEmpresa", _user.ResolveEmpresa(m.FlEmpresaNotKey, m.CoEmpresa), DbType.Int32)
                .Add("CoTipoEntidad", m.CoTipoEntidad, DbType.Int32)
                .Add("CoEntidad", m.CoEntidad, DbType.Int32)
                .Add("CoTipo", m.CoTipo, DbType.Int32)
                .Add("FlGaleria", m.FlGaleria, DbType.Int32)
                .Add("NoArchivo", m.NoArchivo, DbType.String)
                .Add("NoExtension", m.NoExtension, DbType.String)
                .Add("NoRuta", m.NoRuta, DbType.String)
                .Add("NuBytes", m.NuBytes, DbType.Int32)
                .Add("NuAlto", m.NuAlto, DbType.Int32)
                .Add("NuAncho", m.NuAncho, DbType.Int32)
                .AddUserCreate(_user.CoUsuarioRequired));

    public Task<int> UpdateMetaDataByIdAsync(ArchivoEntity m) =>
        _database.ScalarAsync<int>(ArchivoDbObjects.UpdateMetaDataById,
            p => p
                .Add("CoEmpresa", _user.ResolveEmpresa(m.FlEmpresaNotKey, m.CoEmpresa), DbType.Int32)
                .Add("CoArchivo", m.CoArchivo, DbType.Int32)
                .Add("NoArchivo", m.NoArchivo, DbType.String)
                .Add("NoExtension", m.NoExtension, DbType.String)
                .Add("NoRuta", m.NoRuta, DbType.String)
                .Add("NuBytes", m.NuBytes, DbType.Int32)   // 👈 Decimal aquí, Int32 en Insert — ver nota abajo
                .Add("NuAlto", m.NuAlto, DbType.Int32)
                .Add("NuAncho", m.NuAncho, DbType.Int32)
                .AddUserUpdate(_user.CoUsuarioRequired));

    public Task<int> UpdateByIdAsync(ArchivoEntity m) =>
        _database.ScalarAsync<int>(ArchivoDbObjects.UpdateById,
            p => p
                .Add("CoEmpresa", _user.ResolveEmpresa(m.FlEmpresaNotKey, m.CoEmpresa), DbType.Int32)
                .Add("CoArchivo", m.CoArchivo, DbType.Int32)
                .Add("NuOrden", m.NuOrden, DbType.Int32)
                .Add("TxDescripcion", m.TxDescripcion, DbType.String)
                .Add("FlDefault", m.FlDefault, DbType.Int32)
                .Add("NoTitulo", m.NoTitulo, DbType.String)
                .AddUserUpdate(_user.CoUsuarioRequired));

    public Task<int> UpdateOrderAsync(ArchivoEntity m) =>
        _database.ScalarAsync<int>(ArchivoDbObjects.UpdateOrder,
            p => p
                .Add("CoEmpresa", _user.ResolveEmpresa(m.FlEmpresaNotKey, m.CoEmpresa), DbType.Int32)
                .Add("CoArchivo", m.CoArchivo, DbType.Int32)
                .Add("NuOrden", m.NuOrden, DbType.Int32)
                .AddUserUpdate(_user.CoUsuarioRequired));

    // ⚠️ Ver nota debajo del código — requiere que IParameterBuilder soporte arrays de Postgres
    public Task<int> UpdateOrderMassiveAsync(OrdenMasivoRequest req) =>
        _database.ScalarAsync<int>(ArchivoDbObjects.UpdateOrderMassive,
            p => p
                .Add("CoEmpresa", _user.ResolveEmpresa(req.FlEmpresaNotKey, req.CoEmpresa), DbType.Int32)
                .AddArray("CoArchivos", req.Ordenes.Select(o => o.CoArchivo).ToArray())
                .AddArray("NuOrdenes", req.Ordenes.Select(o => o.NuOrden).ToArray())
                .AddUserUpdate(_user.CoUsuarioRequired));

    public Task<int> DeleteByIdAsync(ArchivoFilter f) =>
        _database.ScalarAsync<int>(ArchivoDbObjects.DeleteById,
            p => p
                .Add("CoEmpresa", _user.ResolveEmpresa(f.FlEmpresaNotKey, f.CoEmpresa), DbType.Int32)
                .Add("CoArchivo", f.CoArchivo, DbType.Int32)
                .AddUserDelete(_user.CoUsuarioRequired));

    public Task<ArchivoEditResponse?> SelByIdAsync(ArchivoFilter f) =>
        _database.FirstAsync<ArchivoEditResponse>(ArchivoDbObjects.SelById,
            p => p
                .Add("CoEmpresa", _user.ResolveEmpresa(f.FlEmpresaNotKey, f.CoEmpresa), DbType.Int32)
                .Add("CoArchivo", f.CoArchivo, DbType.Int32));

    public Task<ArchivoEditResponse?> SelMetaDataByIdAsync(ArchivoFilter f) =>
        _database.FirstAsync<ArchivoEditResponse>(ArchivoDbObjects.SelMetaDataById,
            p => p
                .Add("CoEmpresa", _user.ResolveEmpresa(f.FlEmpresaNotKey, f.CoEmpresa), DbType.Int32)
                .Add("CoArchivo", f.CoArchivo, DbType.Int32)
    );

    public Task<ArchivoEditResponse?> SelMetaDataByUkAsync(ArchivoFilter f) =>
        _database.FirstAsync<ArchivoEditResponse>(ArchivoDbObjects.SelMetaDataByUk,
            p => p
                .Add("CoEmpresa", _user.ResolveEmpresa(f.FlEmpresaNotKey, f.CoEmpresa), DbType.Int32)
                .Add("CoTipoEntidad", f.CoTipoEntidad, DbType.Int32)
                .Add("CoEntidad", f.CoEntidad, DbType.Int32)
                .Add("CoTipo", f.CoTipo, DbType.Int32)
                .Add("NuOrden", f.NuOrden, DbType.Int32));

    public Task<IReadOnlyList<ArchivoListItem>> SelAllAsync(ArchivoFilter f) =>
        _database.ListAsync<ArchivoListItem>(ArchivoDbObjects.SelAll,
            p => p
                .Add("CoEmpresa", _user.ResolveEmpresa(f.FlEmpresaNotKey, f.CoEmpresa), DbType.Int32)
                .Add("CoTipoEntidad", f.CoTipoEntidad, DbType.Int32)
                .Add("CoEntidad", f.CoEntidad, DbType.Int32)
    );

    public Task<IReadOnlyList<ArchivoListItem>> SelAllActiveAsync(ArchivoFilter f) =>
        _database.ListAsync<ArchivoListItem>(ArchivoDbObjects.SelAllActive,
            p => p
                .Add("CoEmpresa", _user.ResolveEmpresa(f.FlEmpresaNotKey, f.CoEmpresa), DbType.Int32)
                .Add("CoTipoEntidad", f.CoTipoEntidad, DbType.Int32)
                .Add("CoEntidad", f.CoEntidad, DbType.Int32)
   );

}