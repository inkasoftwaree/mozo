using Dapper;

using Mozo.Helper.Enu;
using Mozo.Helper.Global;
using Mozo.Model.Maestro;

using System.Data;
///<summary>
///
///</summary>
///<remarks>
///</remarks>
///<history>
/// t[Jonatan Abregu]	26/04/2022	Created
///</history>
namespace Mozo.MaestroData;

public interface IPersonaTipoData
{
    Task<int> InsertAsync(EntidadRolModel c, IDbTransaction? tran = null);
    Task UpdateAsync(EntidadRolModel c);
    Task<IEnumerable<EntidadRolModel>> SelAllActiveByPersonAsync(EntidadRolModel c);
    Task<IEnumerable<EntidadRolModel>> SelAllActiveByModuleAndPersonAsync(EntidadRolModel c);
    Task<IEnumerable<EntidadRolModel>> SelAllActiveAsync(EntidadRolModel c);
}

public partial class PersonaTipoData : IPersonaTipoData
{
    private readonly string _schema = EnuCommon.BdDefault.Schema.Maestro;

    private readonly IDbConnection _connection;
    private readonly UserContext _user;
    public PersonaTipoData(IDbConnection connection, UserContext user)
    {
        _connection = connection;
        _user = user;
    }

    public async Task<int> InsertAsync(EntidadRolModel c, IDbTransaction? tran = null)
    {
        (DynamicParameters pr, string args) = BuildDinamicParameter.Build(c, _user.CoEmpresaRequired, _user.CoUsuarioRequired,
            "CoEmpresa",
            "CoPersona",
            "CoTipo",
            "CoModulo",
            "CoUsuCre"
        );
        string sql = $"SELECT {_schema}.fn_personatipo_insert({args})";

        if (tran == null)
            return await _connection.ExecuteScalarAsync<int>(sql, pr);
        else
            return await _connection.ExecuteScalarAsync<int>(sql, pr, tran);
    }
    public async Task UpdateAsync(EntidadRolModel c)
    {
        (DynamicParameters pr, string args) = BuildDinamicParameter.Build(c, _user.CoEmpresaRequired, _user.CoUsuarioRequired,
            "CoEmpresa",
            "CoPersonaTipo",
            "CoTipo",
            "CoUsuMod"
        );
        string sql = $"CALL {_schema}.usp_personatipo_update({args})";
        await _connection.ExecuteScalarAsync<int>(sql, pr);
    }
    public async Task<IEnumerable<EntidadRolModel>> SelAllActiveByPersonAsync(EntidadRolModel c)
    {
        (DynamicParameters pr, string args) = BuildDinamicParameter.Build(c, _user.CoEmpresaRequired, _user.CoUsuarioRequired,
            "CoEmpresa",
            "CoPersona"
        );
        string sql = $"SELECT * FROM {_schema}.fn_personatipo_sel_all_active_by_persona({args})";
        return await _connection.QueryAsync<EntidadRolModel>(sql, pr);
    }
    public async Task<IEnumerable<EntidadRolModel>> SelAllActiveByModuleAndPersonAsync(EntidadRolModel c)
    {
        (DynamicParameters pr, string args) = BuildDinamicParameter.Build(c, _user.CoEmpresaRequired, _user.CoUsuarioRequired,
           "CoEmpresa",
           "CoModulo",
           "CoPersona"
       );
        string sql = $"SELECT * FROM {_schema}.fn_personatipo_sel_all_active_by_modulo_and_persona({args})";
        return await _connection.QueryAsync<EntidadRolModel>(sql, pr);
    }
    public async Task<IEnumerable<EntidadRolModel>> SelAllActiveAsync(EntidadRolModel c)
    {
        (DynamicParameters pr, string args) = BuildDinamicParameter.Build(c, _user.CoEmpresaRequired, _user.CoUsuarioRequired,
            "CoEmpresa"
        );
        string sql = $"SELECT * FROM {_schema}.fn_personatipo_sel_all_active({args})";
        return await _connection.QueryAsync<EntidadRolModel>(sql, pr);
    }
}
