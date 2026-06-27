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
namespace Mozo.LoginData;

public interface IIngresoData
{
    Task<int> InsertAsync(IngresoModel c);
    Task<IngresoModel?> SelByRefreshTokenAsync(IngresoFilterDto c);
    Task RevokeAsync(IngresoModel c);

    Task<int> ReplaceAsync(IngresoModel c);
    Task RevokeAllAsync(IngresoModel c);


}
public partial class IngresoData : IIngresoData
{

    private readonly string _schema = EnuCommon.BdDefault.Schema.Login;
    private readonly IDbConnection _connection;
    private readonly UserContext _user;
    public IngresoData(IDbConnection connection, UserContext user)
    {
        _connection = connection;
        _user = user;
    }
    public async Task<int> InsertAsync(IngresoModel c)
    {
        DynamicParameters pr = new();
        pr.Add2("CoUsuario", c.CoUsuario, DbType.Int32);              
        pr.Add2("NoIp", c.NoIp, DbType.String);
        pr.Add2("NoRefreshToken", c.NoRefreshToken, DbType.String);
        pr.Add2("NoUserAgent", c.NoUserAgent, DbType.String);
        pr.Add2("FeRefreshTokenExpire", c.FeRefreshTokenExpire, DbType.DateTime);

        string sql = $@"SELECT {_schema}.fn_ingreso_insert(
                @CoUsuario,              
                @NoIp,
                @NoRefreshToken,
                @NoUserAgent,   
                @FeRefreshTokenExpire
        )";
        return await _connection.ExecuteScalarAsync<int>(sql, pr);
    }
    public async Task<IngresoModel?> SelByRefreshTokenAsync(IngresoFilterDto c)
    {
        DynamicParameters pr = new();
        pr.Add2("NoRefreshToken", c.NoRefreshToken, DbType.String);
        string sql = $@"SELECT * FROM {_schema}.fn_ingreso_sel_by_refreshtoken(
                @NoRefreshToken
        )";
        return await _connection.QueryFirstOrDefaultAsync<IngresoModel>(sql, pr);
    }

    public async Task RevokeAsync(IngresoModel c)
    {
        DynamicParameters pr = new();
        pr.Add2("NoRefreshToken", c.NoRefreshToken, DbType.String);
        string sql = $@"CALL {_schema}.usp_ingreso_revoke(
            @NoRefreshToken
        )";
        await _connection.ExecuteScalarAsync(sql, pr);
    }

    public async Task<int> ReplaceAsync(IngresoModel c)
    {
        DynamicParameters pr = new();
        pr.Add2("NoRefreshToken", c.NoRefreshToken, DbType.String);
        string sql = $@"SELECT {_schema}.fn_ingreso_replace(
            @NoRefreshToken
        )";
        return await _connection.ExecuteScalarAsync<int>(sql, pr);
    }

    public async Task RevokeAllAsync(IngresoModel c)
    {
        DynamicParameters pr = new();        
        pr.Add2("CoUsuario", c.CoUsuario, DbType.Int32);
        string sql = $@"CALL {_schema}.usp_ingreso_revoke_all(
                @CoUsuario
        )";
        await _connection.ExecuteScalarAsync(sql, pr);
    }

}