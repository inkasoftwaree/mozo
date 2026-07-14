using Mozo.App.Maestro.EntidadRedSocial.Contracts;
using Mozo.Domain.Maestro;
using Mozo.Infrastructure.Persistence;
using Mozo.Infrastructure.Persistence.Builders;
using Mozo.Shared.Services;
using System.Data;

namespace Mozo.App.Maestro.EntidadRedSocial;

public interface IEntidadRedSocialService
{
    Task<int> InsertAsync(EntidadRedSocialEntity m);
    Task<int> UpdateByIdAsync(EntidadRedSocialEntity m);
    Task<int> DeleteByIdAsync(EntidadRedSocialFilter f);
    Task<EntidadRedSocialEditResponse?> SelByIdAsync(EntidadRedSocialFilter f);
    Task<IReadOnlyList<EntidadRedSocialListItem>> SelAllAsync(EntidadRedSocialFilter f);
}

public sealed class EntidadRedSocialService : IEntidadRedSocialService
{
    private readonly IDatabase _database;
    private readonly UserContext _user;

    public EntidadRedSocialService(IDatabase database, UserContext user)
    {
        _database = database;
        _user = user;
    }

    public Task<int> InsertAsync(EntidadRedSocialEntity m) =>
        _database.ScalarAsync<int>(EntidadRedSocialDbObjects.Insert,
            p => p
                .Add("CoEntidad", m.CoEntidad, DbType.Int32)
                .Add("CoTipoRedSocial", m.CoTipoRedSocial, DbType.Int32)
                .Add("CoTipoUrl", m.CoTipoUrl, DbType.Int32)
                .Add("CoEtiqueta", m.CoEtiqueta, DbType.Int32)
                .Add("NoRedSocial", m.NoRedSocial, DbType.String)
                .Add("FlWhatsapp", m.FlWhatsapp, DbType.Int32)
                .AddUserCreate(_user.CoUsuarioRequired));

    public Task<int> UpdateByIdAsync(EntidadRedSocialEntity m) =>
        _database.ScalarAsync<int>(EntidadRedSocialDbObjects.UpdateById,
            p => p
                .Add("CoEntidadRedSocial", m.CoEntidadRedSocial, DbType.Int32)
                .Add("CoTipoUrl", m.CoTipoUrl, DbType.Int32)
                .Add("CoEtiqueta", m.CoEtiqueta, DbType.Int32)
                .Add("NoRedSocial", m.NoRedSocial, DbType.String)
                .Add("FlWhatsapp", m.FlWhatsapp, DbType.Int32)
                .AddUserUpdate(_user.CoUsuarioRequired));

    public Task<int> DeleteByIdAsync(EntidadRedSocialFilter f) =>
        _database.ScalarAsync<int>(EntidadRedSocialDbObjects.DeleteById,
            p => p.Add("CoEntidadRedSocial", f.CoEntidadRedSocial, DbType.Int32)
                  .AddUserDelete(_user.CoUsuarioRequired));

    public Task<EntidadRedSocialEditResponse?> SelByIdAsync(EntidadRedSocialFilter f) =>
        _database.FirstAsync<EntidadRedSocialEditResponse>(EntidadRedSocialDbObjects.SelById,
            p => p.Add("CoEntidadRedSocial", f.CoEntidadRedSocial, DbType.Int32));

    public Task<IReadOnlyList<EntidadRedSocialListItem>> SelAllAsync(EntidadRedSocialFilter f) =>
        _database.ListAsync<EntidadRedSocialListItem>(EntidadRedSocialDbObjects.SelAll,
            p => p
                .Add("CoTipoRedSocial", f.CoTipoRedSocial, DbType.Int32)
                .Add("CoEntidad", f.CoEntidad, DbType.Int32)
                .Add("CoEntidadRedSocial", f.CoEntidadRedSocial, DbType.Int32));
}
