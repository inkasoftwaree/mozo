using Mozo.Domain.Maestro;
using Mozo.Infrastructure.Persistence;
using Mozo.Infrastructure.Persistence.Builders;
using Mozo.Shared.Models;
using Mozo.Shared.Services;
using System.Data;

namespace Mozo.App.Maestro.PersonaNatural;

public interface IPersonaNaturalService
{
    Task<int> InsertAsync(PersonaNaturalEntity m);
    Task<int> UpdateByIdAsync(PersonaNaturalEntity m);
    Task<PersonaNaturalEntity?> SelByIdAsync(PersonaNaturalFilter f);
    Task<PagedResult<PersonaNaturalListItem>> SelAllAsync(PersonaNaturalFilter f);
    Task<IReadOnlyList<PersonaNaturalEntity>> SelAllActiveAsync(PersonaNaturalFilter f);
}

public sealed class PersonaNaturalService : IPersonaNaturalService
{
    private readonly IDatabase _database;
    private readonly UserContext _user;

    public PersonaNaturalService(IDatabase database, UserContext user)
    {
        _database = database;
        _user = user;
    }

    public Task<int> InsertAsync(PersonaNaturalEntity m) =>
        _database.ScalarAsync<int>(PersonaNaturalDbObjects.Insert,
            p => p
                .Add("CoEntidad", m.CoEntidad, DbType.Int32)
                .Add("NoPersona", m.NoPersona, DbType.String)
                .Add("NoApellidoP", m.NoApellidoP, DbType.String)
                .Add("NoApellidoM", m.NoApellidoM, DbType.String)
                .Add("FeNacimiento", m.FeNacimiento, DbType.Date)
                .Add("CoSexo", m.CoSexo, DbType.Int32)
                .Add("CoEstadoCivil", m.CoEstadoCivil, DbType.Int32)
                .Add("CoProfesion", m.CoProfesion, DbType.Int32)
                .AddUserCreate(_user.CoUsuarioRequired));

    public Task<int> UpdateByIdAsync(PersonaNaturalEntity m) =>
        _database.ScalarAsync<int>(PersonaNaturalDbObjects.UpdateById,
            p => p
                .Add("CoEntidad", m.CoEntidad, DbType.Int32)
                .Add("NoPersona", m.NoPersona, DbType.String)
                .Add("NoApellidoP", m.NoApellidoP, DbType.String)
                .Add("NoApellidoM", m.NoApellidoM, DbType.String)
                .Add("FeNacimiento", m.FeNacimiento, DbType.Date)
                .Add("CoSexo", m.CoSexo, DbType.Int32)
                .Add("CoEstadoCivil", m.CoEstadoCivil, DbType.Int32)
                .Add("CoProfesion", m.CoProfesion, DbType.Int32)
                .AddUserUpdate(_user.CoUsuarioRequired));

    public Task<PersonaNaturalEntity?> SelByIdAsync(PersonaNaturalFilter f) =>
        _database.FirstAsync<PersonaNaturalEntity>(PersonaNaturalDbObjects.SelById,
            p => p.Add("CoEntidad", f.CoEntidad));

    public async Task<PagedResult<PersonaNaturalListItem>> SelAllAsync(PersonaNaturalFilter f)
    {
        var r = await _database.ListAsync<PersonaNaturalListItem>(PersonaNaturalDbObjects.SelAll,
            p => p.AddEmpresa(_user.CoEmpresaRequired)
                  .Add("CoModulo", f.CoModulo, DbType.String)
                  .Add("CoRolNegocio", f.CoRolNegocio, DbType.String)
                  .Add("NoImputSearch", f.NoImputSearch, DbType.String)
                  .Add("FlEstReg", f.FlEstReg, DbType.Date)
                  .Add("PageSize", f.PageSize, DbType.Int32)
                  .Add("PageIndex", f.PageIndex, DbType.Int32));

        return new PagedResult<PersonaNaturalListItem>
        {
            Items = [.. r],
            TotalRows = r.Count > 0 ? (r[0].RowsCount ?? 0) : 0,
            PageIndex = f.PageIndex ?? 0,
            PageSize = f.PageSize ?? 0
        };
    }


    public Task<IReadOnlyList<PersonaNaturalEntity>> SelAllActiveAsync(PersonaNaturalFilter f) =>
        _database.ListAsync<PersonaNaturalEntity>(PersonaNaturalDbObjects.SelAllActive,
            p => p.AddEmpresa(_user.CoEmpresaRequired)
                  .Add("CoModulo", f.CoModulo, DbType.String)
                  .Add("CoRolNegocio", f.CoRolNegocio, DbType.String)
                  .Add("NoImputSearch", f.NoImputSearch, DbType.String));
}