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

public interface IPersonaNaturalData
{
    Task<int> InsertAsync(EntidadModel c, IDbTransaction? tran = null);
    Task UpdateAsync(EntidadModel c);
    Task UpdateStateAsync(EntidadModel c);
    Task DeleteByIdAsync(EntidadModel c);
    Task<EntidadModel?> SelByIdAsync(EntidadModel c);
    Task<EntidadModel?> SelRepeatAsync(EntidadModel c);
    Task<IEnumerable<EntidadModel>> SelAllAsync(EntidadModel c);
    Task<IEnumerable<EntidadModel>> SelAllActiveAsync(EntidadModel c);
}
public partial class PersonaNaturalData : IPersonaNaturalData
{
    private readonly string _schema = EnuCommon.BdDefault.Schema.Maestro;

    private readonly IDbConnection _connection;
    private readonly UserContext _user;
    public PersonaNaturalData(IDbConnection connection, UserContext user)
    {
        _connection = connection;
        _user = user;
    }

 //   p_coentidad integer,
 //   p_nopersona character varying,
 //   p_noapellidop character varying,
 //   p_noapellidom character varying,
 //   p_fenacimiento character,
	//p_cosexo integer,
 //   p_coestadocivil integer,
	//p_coprofesion integer,
 //   p_cousucre integer)
    public async Task<int> InsertAsync(PersonaNaturalModel c, IDbTransaction? tran = null)
    {
        DynamicParameters pr = new();
        pr.Add2("CoEntidad", c.CoEntidad, DbType.Int32);
        pr.Add2("NoPersona", c.NoPersona, DbType.String);
        pr.Add2("NoApellidoP", c.NoApellidoP, DbType.String);
        pr.Add2("NoApellidoM", c.NoApellidoM, DbType.String);
        pr.Add2("FeNacimiento", c.FeNacimiento, DbType.Date);
        pr.Add2("NoApellidoM", c.NoApellidoM, DbType.String);
        pr.Add2("CoSexo", c.CoSexo, DbType.Int32);
        pr.Add2("CoEstadoCivil", c.CoEstadoCivil, DbType.Int32);
        pr.Add2("CoProfesion", c.CoProfesion, DbType.Int32);       
        pr.Add2("CoUsuMod", _user.CoUsuarioRequired, DbType.String);
     

        string sql = $@"SELECT {_schema}.fn_personanatural_insert(
            @CoEntidad,
            @NoPersona,
            @NoApellidoP,
            @NoApellidoM,
            @FeNacimiento,
            @NoApellidoM,
            @CoSexo,
            @CoEstadoCivil,
            @CoProfesion,
            @CoUsuMod
        )";

        if (tran == null)
            return await _connection.ExecuteScalarAsync<int>(sql, pr);
        else
            return await _connection.ExecuteScalarAsync<int>(sql, pr, tran);

    }
    public async Task UpdateAsync(EntidadModel c)
    {
        (DynamicParameters pr, string args) = BuildDinamicParameter.Build(c, _user.CoEmpresaRequired, _user.CoUsuarioRequired,
            "CoEmpresa",
            "CoPersona",
            "CoTipoDocumento",
            "NuDocumento",
            "NoPersona",
            "NoApellidoP",
            "NoApellidoM",
            "FeNacimiento",
            "NoDireccion",
            "NoReferencia",
            "NoCodigoPostal",
            "CoSexo",
            "CoEstadoCivil",
            "CoPais",
            "CoUbigeo",
            "CoRubro",
            "CoProfesion",
            "CoUsuMod"
        );
        string sql = $"CALL {_schema}.usp_persona_update({args})";
        await _connection.ExecuteScalarAsync(sql, pr);
    }
    public async Task UpdateStateAsync(EntidadModel c)
    {
        (DynamicParameters pr, string args) = BuildDinamicParameter.Build(c, _user.CoEmpresaRequired, _user.CoUsuarioRequired,
            "CoEmpresa",
            "CoPersona",
            "FlEstReg",
            "CoUsuMod"
        );
        string sql = $"CALL {_schema}.usp_persona_update_state({args})";
        await _connection.ExecuteScalarAsync(sql, pr);
    }
    public async Task DeleteByIdAsync(EntidadModel c)
    {
        (DynamicParameters pr, string args) = BuildDinamicParameter.Build(c, _user.CoEmpresaRequired, _user.CoUsuarioRequired,
            "CoEmpresa",
            "CoPersona",
            "CoUsuEli"
        );
        string sql = $"CALL {_schema}.usp_persona_delete_by_id({args})";
        await _connection.ExecuteScalarAsync(sql, pr);
    }
    public async Task<IEnumerable<EntidadModel>> SelAllAsync(EntidadModel c)
    {
        (DynamicParameters pr, string args) = BuildDinamicParameter.Build(c, _user.CoEmpresaRequired, _user.CoUsuarioRequired,
            "CoEmpresa",
            "CoModulo",
            "CoPersonaTipo",
            "CoTipoDocumento",
            "NoInputSearch",
            "FlEstReg",
            "PageSize",
            "PageIndex"
        );
        string sql = $"SELECT * FROM {_schema}.fn_persona_sel_all({args})";
        return await _connection.QueryAsync<EntidadModel>(sql, pr);
    }
    public async Task<EntidadModel?> SelByIdAsync(EntidadModel c)
    {
        (DynamicParameters pr, string args) = BuildDinamicParameter.Build(c, _user.CoEmpresaRequired, _user.CoUsuarioRequired,
            "CoEmpresa",
            "CoPersona"
        );
        string sql = $"SELECT * FROM {_schema}.fn_persona_sel_by_id({args})";
        return await _connection.QueryFirstOrDefaultAsync<EntidadModel>(sql, pr);
    }
    public async Task<EntidadModel?> SelRepeatAsync(EntidadModel c)
    {
        (DynamicParameters pr, string args) = BuildDinamicParameter.Build(c, _user.CoEmpresaRequired, _user.CoUsuarioRequired,
            "CoEmpresa",
            "CoPersona",
            "CoTipoDocumento",
            "NuDocumento"
        );
        string sql = $"SELECT * FROM {_schema}.fn_persona_sel_repeat({args})";
        return await _connection.QueryFirstOrDefaultAsync<EntidadModel>(sql, pr);
    }
    public async Task<IEnumerable<EntidadModel>> SelAllActiveAsync(EntidadModel c)
    {
        (DynamicParameters pr, string args) = BuildDinamicParameter.Build(c, _user.CoEmpresaRequired, _user.CoUsuarioRequired,
            "CoEmpresa",
            "CoModulo",
            "CoPersonaTipo",
            "NoInputSearch"
        );
        string sql = $"SELECT * FROM {_schema}.fn_persona_sel_all_active({args})";
        return await _connection.QueryAsync<EntidadModel>(sql, pr);
    }
}
