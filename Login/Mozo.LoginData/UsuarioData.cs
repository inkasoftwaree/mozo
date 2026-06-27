using Dapper;

using Mozo.Helper.Enu;
using Mozo.Helper.Global;

using Mozo.Model.Seguridad;

using System.Data;
using System.Text.Json;

///<summary>
///
///</summary>
///<remarks>
///</remarks>
///<history>
/// t[Jonatan Abregu]	16/11/2018	Created
///</history>
namespace Mozo.LoginData;

public interface IUsuarioData
{
    Task<UsuarioModel?> SelByUserAsync(UsuarioFilterDto c);
    Task<UsuarioModel?> SelByIdAsync(UsuarioFilterDto c);
    Task<UsuarioModel?> SelByEmpresaAsync(UsuarioFilterDto c);
}

public partial class UsuarioData : IUsuarioData
{
    private readonly string _schema = EnuCommon.BdDefault.Schema.Login;
    private readonly IDbConnection _connection;
    private readonly UserContext _user;
    public UsuarioData(IDbConnection connection, UserContext user)
    {
        _connection = connection;
        _user = user;
    }
    public async Task<UsuarioModel?> SelByUserAsync(UsuarioFilterDto c)
    {
        DynamicParameters pr = new();
        pr.Add2("NoUsuario", c.NoUsuario, DbType.String);       

        string sql = $@"SELECT * FROM {_schema}.fn_usuario_sel_by_user(
            @NoUsuario
        )";
        UsuarioModel? i = await _connection.QueryFirstOrDefaultAsync<UsuarioModel>(sql, pr);
        return i;
    }

    public async Task<UsuarioModel?> SelByEmpresaAsync(UsuarioFilterDto c)
    {
        DynamicParameters pr = new();
        pr.Add2("CoEmpresa", c.CoEmpresa, DbType.Int32);
        pr.Add2("CoUsuario", c.CoUsuario, DbType.Int32);
        string sql = $@"SELECT * FROM {_schema}.fn_usuario_sel_by_empresa(
            @CoEmpresa,
            @CoUsuario
        )";
        return await _connection.QueryFirstOrDefaultAsync<UsuarioModel>(sql, pr);
    }

    public async Task<UsuarioModel?> SelByIdAsync(UsuarioFilterDto c)
    {
        DynamicParameters pr = new();      
        pr.Add2("CoUsuario", c.CoUsuario, DbType.Int32);
        string sql = $@"SELECT * FROM {_schema}.fn_usuario_sel_by_id(
            @CoUsuario
        )";
        return await _connection.QueryFirstOrDefaultAsync<UsuarioModel>(sql, pr);
    }



}
