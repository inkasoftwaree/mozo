using Mozo.App.Maestro.EntidadDireccion.Contracts;
using Mozo.Domain.Maestro;
using Mozo.Infrastructure.Persistence;
using Mozo.Infrastructure.Persistence.Builders;
using Mozo.Shared.Services;
using System.Data;


namespace Mozo.App.Maestro.EntidadDireccion;

public interface IEntidadDireccionService
{
    Task<int> InsertAsync(EntidadDireccionEntity m);
    Task<int> UpdateByIdAsync(EntidadDireccionEntity m);
    Task<int> UpdateStateByIdAsync(EntidadDireccionEntity m);
    Task<int> UpdateDefaultAsync(EntidadDireccionEntity m);
    Task<int> DeleteByIdAsync(EntidadDireccionFilter f);
    Task<EntidadDireccionEditResponse?> SelByIdAsync(EntidadDireccionFilter f);
    Task<IReadOnlyList<EntidadDireccionListItem>> SelAllAsync(EntidadDireccionFilter f);
    Task<IReadOnlyList<EntidadDireccionListItem>> SelAllActiveAsync(EntidadDireccionFilter f);

}

public sealed class EntidadDireccionService : IEntidadDireccionService
{
    private readonly IDatabase _database;
    private readonly UserContext _user;

    public EntidadDireccionService(IDatabase database, UserContext user)
    {
        _database = database;
        _user = user;
    }

    public Task<int> InsertAsync(EntidadDireccionEntity m) =>
        _database.ScalarAsync<int>(EntidadDireccionDbObjects.Insert,
            p => p
                .Add("CoEntidad", m.CoEntidad, DbType.Int32)
                .Add("CoEtiqueta", m.CoEtiqueta, DbType.Int32)
                .Add("NoDireccionLinea1", m.NoDireccionLinea1, DbType.String)
                .Add("NoDireccionLinea2", m.NoDireccionLinea2, DbType.String)
                .Add("NoDireccionLinea3", m.NoDireccionLinea3, DbType.String)
                .Add("NoUrbanizacionBarrio", m.NoUrbanizacionBarrio, DbType.String)
                .Add("NoCiudad", m.NoCiudad, DbType.String)
                .Add("NoReferencia", m.NoReferencia, DbType.String)
                .Add("CoPais", m.CoPais, DbType.Int32)
                .Add("CoUbigeo", m.CoUbigeo, DbType.Int32)
                .Add("NoCodigoPostal", m.NoCodigoPostal, DbType.String)
                .Add("SsLatitude", m.SsLatitude, DbType.Decimal)
                .Add("SsLongitude", m.SsLongitude, DbType.Decimal)
                .AddUserCreate(_user.CoUsuarioRequired));

    public Task<int> UpdateByIdAsync(EntidadDireccionEntity m) =>
        _database.ScalarAsync<int>(EntidadDireccionDbObjects.UpdateById,
            p => p
                .Add("CoEntidadDireccion", m.CoEntidadDireccion, DbType.Int32)
                .Add("CoEtiqueta", m.CoEtiqueta, DbType.Int32)
                .Add("NoDireccionLinea1", m.NoDireccionLinea1, DbType.String)
                .Add("NoDireccionLinea2", m.NoDireccionLinea2, DbType.String)
                .Add("NoDireccionLinea3", m.NoDireccionLinea3, DbType.String)
                .Add("NoUrbanizacionBarrio", m.NoUrbanizacionBarrio, DbType.String)
                .Add("NoCiudad", m.NoCiudad, DbType.String)
                .Add("NoReferencia", m.NoReferencia, DbType.String)
                .Add("CoPais", m.CoPais, DbType.Int32)
                .Add("CoUbigeo", m.CoUbigeo, DbType.Int32)
                .Add("NoCodigoPostal", m.NoCodigoPostal, DbType.String)
                .Add("SsLatitude", m.SsLatitude, DbType.Decimal)
                .Add("SsLongitude", m.SsLongitude, DbType.Decimal)
                .AddUserUpdate(_user.CoUsuarioRequired));

    public Task<int> DeleteByIdAsync(EntidadDireccionFilter f) =>
        _database.ScalarAsync<int>(EntidadDireccionDbObjects.DeleteById,
            p => p.Add("CoEntidadDireccion", f.CoEntidadDireccion, DbType.Int32)
                  .AddUserDelete(_user.CoUsuarioRequired));

    public Task<EntidadDireccionEditResponse?> SelByIdAsync(EntidadDireccionFilter f) =>
        _database.FirstAsync<EntidadDireccionEditResponse>(EntidadDireccionDbObjects.SelById,
            p => p.Add("CoEntidadDireccion", f.CoEntidadDireccion, DbType.Int32));

    public Task<IReadOnlyList<EntidadDireccionListItem>> SelAllAsync(EntidadDireccionFilter f) =>
        _database.ListAsync<EntidadDireccionListItem>(EntidadDireccionDbObjects.SelAll,
            p => p.Add("CoEntidad", f.CoEntidad, DbType.Int32));

    public Task<IReadOnlyList<EntidadDireccionListItem>> SelAllActiveAsync(EntidadDireccionFilter f) =>
        _database.ListAsync<EntidadDireccionListItem>(EntidadDireccionDbObjects.SelAllActive,
            p => p.Add("CoEntidad", f.CoEntidad, DbType.Int32));

    public Task<int> UpdateStateByIdAsync(EntidadDireccionEntity m) =>
        _database.ScalarAsync<int>(EntidadDireccionDbObjects.UpdateStateById,
            p => p.Add("CoEntidadDireccion", m.CoEntidadDireccion, DbType.Int32)
                  .Add("FlEstReg", m.FlEstReg, DbType.Int32)
                  .AddUserUpdate(_user.CoUsuarioRequired));

    public Task<int> UpdateDefaultAsync(EntidadDireccionEntity m) =>
        _database.ScalarAsync<int>(EntidadDireccionDbObjects.UpdateDefault,
            p => p.Add("CoEntidadDireccion", m.CoEntidadDireccion, DbType.Int32)
                  .Add("CoEntidad", m.CoEntidad, DbType.Int32)
                  .AddUserUpdate(_user.CoUsuarioRequired));
}
