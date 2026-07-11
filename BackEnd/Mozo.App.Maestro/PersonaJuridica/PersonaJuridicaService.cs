using Mozo.Domain.Maestro;
using Mozo.Infrastructure.Persistence;
using Mozo.Infrastructure.Persistence.Builders;
using Mozo.Shared.Models;
using Mozo.Shared.Services;
using System.Data;

namespace Mozo.App.Maestro.PersonaJuridica;

public interface IPersonaJuridicaService
{
    Task<int> InsertAsync(PersonaJuridicaEntity c);
    Task<int> UpdateByIdAsync(PersonaJuridicaEntity c);
    Task<PersonaJuridicaEntity?> SelByIdAsync(PersonaJuridicaFilter f);
    Task<PagedResult<PersonaJuridicaListItem>> SelAllAsync(PersonaJuridicaFilter f);
    Task<IEnumerable<PersonaJuridicaEntity>> SelAllActiveAsync(PersonaJuridicaFilter f);
}

public sealed class PersonaJuridicaService : IPersonaJuridicaService
{
    private readonly IDatabase _database;
    private readonly UserContext _user;

    public PersonaJuridicaService(IDatabase database, UserContext user)
    {
        _database = database;
        _user = user;
    }

    public Task<int> InsertAsync(PersonaJuridicaEntity c) =>
        _database.ScalarAsync<int>(PersonaJuridicaDbObjects.Insert,
            p => p
                .Add("NoRazonSocial", c.NoRazonSocial, DbType.String)
                .Add("NoComercial", c.NoComercial, DbType.String)
                .Add("CoRubro", c.CoRubro, DbType.Int32)
                .AddUserCreate(_user.CoUsuarioRequired));

    public Task<int> UpdateByIdAsync(PersonaJuridicaEntity c) =>
        _database.ScalarAsync<int>(PersonaJuridicaDbObjects.UpdateById,
            p => p
                .Add("CoEntidad", c.CoEntidad, DbType.Int32)
                .Add("NoRazonSocial", c.NoRazonSocial, DbType.String)
                .Add("NoComercial", c.NoComercial, DbType.String)
                .Add("CoRubro", c.CoRubro, DbType.Int32)
                .AddUserUpdate(_user.CoUsuarioRequired));

    public Task<PersonaJuridicaEntity?> SelByIdAsync(PersonaJuridicaFilter c) =>
        _database.FirstAsync<PersonaJuridicaEntity>(PersonaJuridicaDbObjects.SelById,
            p => p.Add("CoEntidad", c.CoEntidad, DbType.Int32));

    public async Task<PagedResult<PersonaJuridicaListItem>> SelAllAsync(PersonaJuridicaFilter f)
    {
        var r = await _database.ListAsync<PersonaJuridicaListItem>(PersonaJuridicaDbObjects.SelAll,
            p => p
                 .AddEmpresa(_user.CoEmpresaRequired)
                .Add("CoModulo", f.CoModulo, DbType.Int32)
                .Add("CoRolNegocio", f.CoRolNegocio, DbType.Int32)
                .Add("NoInputSearch", f.NoInputSearch, DbType.String)
                .Add("PageSize", f.PageSize, DbType.Int32)
                .Add("PageIndex", f.PageIndex, DbType.Int32));

        return new PagedResult<PersonaJuridicaListItem>
        {
            Items = [.. r],
            TotalRows = r.Count > 0 ? (r[0].RowsCount ?? 0) : 0,
            PageIndex = f.PageIndex ?? 0,
            PageSize = f.PageSize ?? 0
        };
    }


    public async Task<IEnumerable<PersonaJuridicaEntity>> SelAllActiveAsync(PersonaJuridicaFilter c) =>
        await _database.ListAsync<PersonaJuridicaEntity>(PersonaJuridicaDbObjects.SelAllActive,
            p => p
                 .AddEmpresa(_user.CoEmpresaRequired)
                .Add("CoModulo", c.CoModulo, DbType.Int32)
                .Add("CoRolNegocio", c.CoRolNegocio, DbType.Int32)
                .Add("NoInputSearch", c.NoInputSearch, DbType.String));

}