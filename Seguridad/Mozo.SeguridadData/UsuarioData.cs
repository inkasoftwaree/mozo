using Dapper;

using Mozo.Helper.Enu;
using Mozo.Helper.Global;
using Mozo.Model.Seguridad;

using System.Data;

///<summary>
///
///</summary>
///<remarks>
///</remarks>
///<history>
/// t[Jonatan Abregu]	16/11/2018	Created
///</history>
namespace Mozo.SeguridadData;

public interface IUsuarioData
{
    Task<int> InsertAsync(UsuarioModel c);
    Task UpdateAsync(UsuarioModel c);
    Task UpdateClaveAsync(UsuarioModel c);
    Task UpdateStateAsync(UsuarioModel c);
    Task<UsuarioModel?> SelByIdAsync(UsuarioFilterDto c);
    //Task<IEnumerable<UsuarioModel>> SelAllAsync(UsuarioModel c);
    //Task<IEnumerable<UsuarioModel>> SelAllActiveAsync(UsuarioModel c);
}
public partial class UsuarioData : IUsuarioData
{
    private readonly string _schema = EnuCommon.BdDefault.Schema.Seguridad;
    private readonly IDbConnection _connection;
    private readonly UserContext _user;
    public UsuarioData(IDbConnection connection, UserContext user)
    {
        _connection = connection;
        _user = user;
    }

 
    public async Task<int> InsertAsync(UsuarioModel c)
    {
        DynamicParameters pr = new();      
        pr.Add2("CoEntidad", c.CoEntidad, DbType.Int32);
        pr.Add2("NoUsuario", c.NoUsuario, DbType.String);
        pr.Add2("NoClave", c.NoClave, DbType.String);
        pr.Add2("CoUsuCre", _user.CoUsuarioRequired, DbType.Int32);

        string sql = $@"SELECT {_schema}.fn_usuario_insert(           
            @CoEntidad,
            @NoUsuario,
            @NoClave,
            @CoUsuCre
        )";
        return await _connection.ExecuteScalarAsync<int>(sql, pr);
    }
    public async Task UpdateAsync(UsuarioModel c)
    {
        DynamicParameters pr = new();      
        pr.Add2("CoUsuario", c.CoUsuario, DbType.Int32);       
        pr.Add2("NoUsuario", c.NoUsuario, DbType.String);
        pr.Add2("NoClave", c.NoClave, DbType.String);
        pr.Add2("CoUsuMod", _user.CoUsuarioRequired, DbType.Int32);

        string sql = $@"CALL {_schema}.usp_usuario_update(           
            @CoUsuario,           
            @NoUsuario,
            @NoClave,
            @CoUsuMod
        )";
        await _connection.ExecuteScalarAsync(sql, pr);
    }
    public async Task UpdateClaveAsync(UsuarioModel c)
    {
        DynamicParameters pr = new();
        pr.Add2("CoUsuario", c.CoUsuario, DbType.Int32);
        pr.Add2("NoClaveNuevo", c.NoClave, DbType.String);
        pr.Add2("CoUsuMod", _user.CoUsuarioRequired, DbType.Int32);

        string sql = $@"CALL {_schema}.usp_usuario_update_clave(
            @CoUsuario,
            @NoClaveNuevo,
            @CoUsuMod)";
        await _connection.ExecuteScalarAsync(sql, pr);
    }
    public async Task UpdateStateAsync(UsuarioModel c)
    {
        DynamicParameters pr = new();      
        pr.Add2("CoUsuario", c.CoUsuario, DbType.Int32);
        pr.Add2("FlEstReg", c.FlEstReg, DbType.Int32);
        pr.Add2("CoUsuMod", _user.CoUsuarioRequired, DbType.Int32);

        string sql = $@"CALL {_schema}.usp_usuario_update_state(
        @CoUsuario,@FlEstReg,@CoUsuMod)";
        await _connection.ExecuteScalarAsync(sql, pr);
    }

    public async Task<UsuarioModel?> SelByIdAsync(UsuarioFilterDto c)
    {
        DynamicParameters pr = new();
        pr.Add2("CoUsuario", c.CoUsuario, DbType.Int32);

        string sql = $"SELECT * FROM {_schema}.fn_usuario_sel_by_id(@CoUsuario)";
        return await _connection.QueryFirstOrDefaultAsync<UsuarioModel>(sql, pr);
    }

}