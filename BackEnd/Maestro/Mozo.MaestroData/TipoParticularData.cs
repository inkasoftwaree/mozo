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

public interface ITipoParticularData
{
    Task<int> InsertAsync(TipoParticularModel c);
    Task UpdateAsync(TipoParticularModel c);
    Task UpdateStateAsync(TipoParticularModel c);
    Task UpdateCommandAsync(TipoParticularModel c);
    Task UpdateDefaultAsync(TipoParticularModel c);

    Task DeleteByIdAsync(TipoParticularFilterDto c);
    Task<int> SelOrderNextAsync(TipoParticularFilterDto c);
    Task<TipoParticularModel?> SelByIdAsync(TipoParticularFilterDto c);
    Task<TipoParticularModel?> SelByIdGroupAsync(TipoParticularFilterDto c);
    Task<TipoParticularModel?> SelDefaultAsync(TipoParticularFilterDto c);
    Task<IEnumerable<TipoParticularModel>> SelAllAsync(TipoParticularFilterDto c);
    Task<IEnumerable<TipoParticularModel>> SelAllChildrenAsync(TipoParticularFilterDto c);
    Task<IEnumerable<TipoParticularModel>> SelAllActiveGroupsByModuleAsync(TipoParticularFilterDto c);
    Task<IEnumerable<TipoParticularModel>> SelAllActiveAsync(TipoParticularFilterDto c);
    Task<IEnumerable<TipoParticularModel>> SelAllActiveChildrenAsync(TipoParticularFilterDto c);
    Task<IEnumerable<TipoParticularModel>> SelAllActiveFatherAndChildrenAsync(TipoParticularFilterDto c);
}

public partial class TipoParticularData : ITipoParticularData
{
    private readonly string _schema = EnuCommon.BdDefault.Schema.Maestro;
    private readonly IDbConnection _connection;
    private readonly UserContext _user;
    public TipoParticularData(IDbConnection connection, UserContext user)
    {
        _connection = connection;
        _user = user;
    }
  
    public async Task<int> InsertAsync(TipoParticularModel c)
    {
        DynamicParameters pr = new();
        pr.Add2("CoEmpresa", _user.CoEmpresa, DbType.Int32);
        pr.Add2("CoModulo", c.CoModulo, DbType.Int32);
        pr.Add2("CoGrupo", c.CoGrupo, DbType.Int32);
        pr.Add2("CoTipoPadre", c.CoTipoPadre, DbType.Int32);
        pr.Add2("CoGrupoPadre", c.CoGrupoPadre, DbType.Int32);
        pr.Add2("NuOrden", c.NuOrden, DbType.Int32);
        pr.Add2("NoTipo", c.NoTipo, DbType.String);
        pr.Add2("NoSigla", c.NoSigla, DbType.String);
        pr.Add2("TxDescripcion", c.TxDescripcion, DbType.String);
        pr.Add2("FlDefault", c.FlDefault, DbType.Int32);        
        pr.Add2("CoUsuCre", _user.CoPersona, DbType.Int32);
               
        string sql = $@"SELECT {_schema}.fn_tipoparticular_insert(
            @CoEmpresa,
            @CoModulo,
            @CoGrupo,
            @CoTipoPadre,
            @CoGrupoPadre,
            @NuOrden,
            @NoTipo,
            @NoSigla,
            @TxDescripcion,
            @FlDefault,
            @CoUsuCre
        )";
        return await _connection.ExecuteScalarAsync<int>(sql, pr);
    }
    public async Task UpdateAsync(TipoParticularModel c)
    {
        DynamicParameters pr = new();
        pr.Add2("CoEmpresa", _user.CoEmpresa, DbType.Int32);
        pr.Add2("CoGrupo", c.CoGrupo, DbType.Int32);
        pr.Add2("CoTipo", c.CoTipo, DbType.Int32);
        pr.Add2("NuOrden", c.NuOrden, DbType.Int32);
        pr.Add2("NoTipo", c.NoTipo, DbType.String);
        pr.Add2("NoSigla", c.NoSigla, DbType.String);
        pr.Add2("TxDescripcion", c.TxDescripcion, DbType.String);        
        pr.Add2("FlDefault", c.FlDefault, DbType.Int32);        
        pr.Add2("CoUsuMod", _user.CoPersona, DbType.Int32);

        string sql = $@"CALL {_schema}.usp_tipoparticular_update(
            @CoEmpresa,
            @CoGrupo,
            @CoTipo,
            @NuOrden,
            @NoTipo,
            @NoSigla,
            @TxDescripcion,
            @FlDefault,
            @CoUsuMod
        )";
        await _connection.ExecuteScalarAsync(sql, pr);
    }
    public async Task UpdateStateAsync(TipoParticularModel c)
    {
        DynamicParameters pr = new();
        pr.Add2("CoEmpresa", _user.CoEmpresa, DbType.Int32);
        pr.Add2("CoTipo", c.CoTipo, DbType.Int32);
        pr.Add2("CoGrupo", c.CoGrupo, DbType.Int32);
        pr.Add2("FlEstReg", c.FlEstReg, DbType.Int32);
        pr.Add2("CoUsuMod", _user.CoPersona, DbType.Int32);

        string sql = $@"CALL {_schema}.usp_tipoparticular_update_state(
            @CoEmpresa,
            @CoTipo,
            @CoGrupo,
            @FlEstReg,
            @CoUsuMod
        )";
        await _connection.ExecuteScalarAsync(sql, pr);
    }

    public async Task UpdateCommandAsync(TipoParticularModel c)
    {
        DynamicParameters pr = new();
        pr.Add2("CoEmpresa", _user.CoEmpresa, DbType.Int32);
        pr.Add2("CoTipo", c.CoTipo, DbType.Int32);
        pr.Add2("CoGrupo", c.CoGrupo, DbType.Int32);
        pr.Add2("NoComando", c.NoComando, DbType.String);
        pr.Add2("CoUsuMod", _user.CoPersona, DbType.Int32);
              
        string sql = $@"CALL {_schema}.usp_tipoparticular_update_command(
            @CoEmpresa,
            @CoTipo,
            @CoGrupo,
            @NoComando,
            @CoUsuMod
        )";
        await _connection.ExecuteScalarAsync(sql, pr);
    }

    public async Task UpdateDefaultAsync(TipoParticularModel c)
    {
        DynamicParameters pr = new();
        pr.Add2("CoEmpresa", _user.CoEmpresa, DbType.Int32);
        pr.Add2("CoTipo", c.CoTipo, DbType.Int32);
        pr.Add2("CoGrupo", c.CoGrupo, DbType.Int32);
        pr.Add2("FlDefault", c.FlDefault, DbType.Int32);
        pr.Add2("CoUsuMod", _user.CoPersona, DbType.Int32);

        string sql = $@"CALL {_schema}.usp_tipoparticular_update_default(
            @CoEmpresa,
            @CoTipo,
            @CoGrupo,
            @FlDefault,
            @CoUsuMod
         )";
        await _connection.ExecuteScalarAsync(sql, pr);
    }

    public async Task DeleteByIdAsync(TipoParticularFilterDto c)
    {
        DynamicParameters pr = new();
        pr.Add2("CoEmpresa", _user.CoEmpresa, DbType.Int32);
        pr.Add2("CoTipo", c.CoTipo, DbType.Int32);
        pr.Add2("CoGrupo", c.CoGrupo, DbType.Int32);
        pr.Add2("CoUsuEli", _user.CoPersona, DbType.Int32);

        string sql = $@"CALL {_schema}.usp_tipoparticular_delete_by_id(
            @CoEmpresa,
            @CoTipo,
            @CoGrupo,
            @CoUsuEli
        )";
        await _connection.ExecuteScalarAsync(sql, pr);
    }


    public async Task<IEnumerable<TipoParticularModel>> SelAllAsync(TipoParticularFilterDto c)
    {
        DynamicParameters pr = new();
        pr.Add2("CoEmpresa", _user.CoEmpresa, DbType.Int32);
        pr.Add2("CoGrupo", c.CoGrupo, DbType.Int32);
        pr.Add2("NoInputSearch", c.NoInputSearch, DbType.String);
        pr.Add2("FlEstReg", c.FlEstReg, DbType.Int32);
        pr.Add2("CoTipo", c.CoTipo, DbType.Int32);
        pr.Add2("PageSize", c.PageSize, DbType.Int32);
        pr.Add2("PageIndex", c.PageIndex, DbType.Int32);

        string sql = $@"SELECT * FROM {_schema}.fn_tipoparticular_sel_all(
            @CoEmpresa,
            @CoGrupo,
            @NoInputSearch,
            @FlEstReg,
            @CoTipo,
            @PageSize,
            @PageIndex
        )";
        return await _connection.QueryAsync<TipoParticularModel>(sql, pr);
    }

   


    public async Task<IEnumerable<TipoParticularModel>> SelAllChildrenAsync(TipoParticularFilterDto c)
    {
        DynamicParameters pr = new();
        pr.Add2("CoEmpresa", _user.CoEmpresa, DbType.Int32);
        pr.Add2("CoGrupoPadre", c.CoGrupoPadre, DbType.Int32);
        pr.Add2("CoTipoPadre", c.CoTipoPadre, DbType.Int32);
        pr.Add2("NoInputSearch", c.NoInputSearch, DbType.String);
        pr.Add2("CoTipo", c.CoTipo, DbType.Int32);
        pr.Add2("PageSize", c.PageSize, DbType.Int32);
        pr.Add2("PageIndex", c.PageIndex, DbType.Int32);

        string sql = $@"SELECT * FROM {_schema}.fn_tipoparticular_sel_all_hijo(
            @CoEmpresa,
            @CoGrupoPadre,
            @CoTipoPadre,
            @NoInputSearch,
            @CoTipo,
            @PageSize,
            @PageIndex
        )";
        return await _connection.QueryAsync<TipoParticularModel>(sql, pr);
    }
    public async Task<TipoParticularModel?> SelByIdAsync(TipoParticularFilterDto c)
    {
        DynamicParameters pr = new();
        pr.Add2("CoEmpresa", _user.CoEmpresa, DbType.Int32);
        pr.Add2("CoGrupo", c.CoGrupo, DbType.Int32);
        pr.Add2("CoTipo", c.CoTipo, DbType.Int32);

        string sql = $@"SELECT * FROM {_schema}.fn_tipoparticular_sel_by_id(
            @CoEmpresa,
            @CoGrupo,
            @CoTipo
        )";
        return await _connection.QueryFirstOrDefaultAsync<TipoParticularModel>(sql, pr);
    }
    public async Task<int> SelOrderNextAsync(TipoParticularFilterDto c)
    {
        DynamicParameters pr = new();
        pr.Add2("CoEmpresa", _user.CoEmpresa, DbType.Int32);
        pr.Add2("CoGrupo", c.CoGrupo, DbType.Int32);
        pr.Add2("CoTipoPadre", c.CoTipoPadre, DbType.Int32);

        string sql = $@"SELECT * FROM {_schema}.fn_tipoparticular_sel_orden_next(
            @CoEmpresa,
            @CoGrupo,
            @CoTipoPadre
        )";
        return await _connection.ExecuteScalarAsync<int>(sql, pr);
    }
    public async Task<TipoParticularModel?> SelByIdGroupAsync(TipoParticularFilterDto c)
    {
        DynamicParameters pr = new();       
        pr.Add2("CoGrupo", c.CoGrupo, DbType.Int32);

        string sql = $"SELECT * FROM {_schema}.fn_tipoparticular_sel_by_grupo(@CoGrupo)";
        return await _connection.QueryFirstOrDefaultAsync<TipoParticularModel>(sql, pr);
    }
    public async Task<IEnumerable<TipoParticularModel>> SelAllActiveAsync(TipoParticularFilterDto c)
    {
        DynamicParameters pr = new();
        pr.Add2("CoEmpresa", _user.CoEmpresa, DbType.Int32);
        pr.Add2("CoGrupo", c.CoGrupo, DbType.Int32);
        pr.Add2("NoInputSearch", c.NoInputSearch, DbType.String);
                
        string sql = $@"SELECT * FROM {_schema}.fn_tipoparticular_sel_all_active(
            @CoEmpresa,
            @CoGrupo,
            @NoInputSearch
        )";
        return await _connection.QueryAsync<TipoParticularModel>(sql, pr);
    }
    public async Task<IEnumerable<TipoParticularModel>> SelAllActiveChildrenAsync(TipoParticularFilterDto c)
    {
        DynamicParameters pr = new();
        pr.Add2("CoEmpresa", _user.CoEmpresa, DbType.Int32);
        pr.Add2("CoGrupo", c.CoGrupo, DbType.Int32);
        pr.Add2("CoTipoPadre", c.CoTipoPadre, DbType.Int32);
        pr.Add2("NoInputSearch", c.NoInputSearch, DbType.String);
              
        string sql = $@"SELECT * FROM {_schema}.fn_tipoparticular_sel_all_active_hijo(
            @CoEmpresa,
            @CoGrupo,
            @CoTipoPadre,
            @NoInputSearch
        )";
        return await _connection.QueryAsync<TipoParticularModel>(sql, pr);
    }
    public async Task<IEnumerable<TipoParticularModel>> SelAllActiveFatherAndChildrenAsync(TipoParticularFilterDto c)
    {
        DynamicParameters pr = new();
        pr.Add2("CoEmpresa", _user.CoEmpresa, DbType.Int32);
        pr.Add2("CoGrupo", c.CoGrupo, DbType.Int32);       
        pr.Add2("NoInputSearch", c.NoInputSearch, DbType.String);

        string sql = $@"SELECT * FROM {_schema}.fn_tipoparticular_sel_all_active_padre_e_hijo(
            @CoEmpresa,
            @CoGrupo,
            @NoInputSearch
        )";
        return await _connection.QueryAsync<TipoParticularModel>(sql, pr);
    }
    public async Task<IEnumerable<TipoParticularModel>> SelAllActiveGroupsByModuleAsync(TipoParticularFilterDto c)
    {
        DynamicParameters pr = new();
        pr.Add2("CoEmpresa", _user.CoEmpresa, DbType.Int32);
        pr.Add2("CoModulo", c.CoModulo, DbType.Int32);
              
        string sql = $@"SELECT * FROM {_schema}.fn_tipoparticular_sel_all_grupo_by_modulo(
            @CoEmpresa,
            @CoModulo
        )";
        return await _connection.QueryAsync<TipoParticularModel>(sql, pr);
    }
  
    public async Task<TipoParticularModel?> SelDefaultAsync(TipoParticularFilterDto c)
    {
        DynamicParameters pr = new();
        pr.Add2("CoEmpresa", _user.CoEmpresa, DbType.Int32);
        pr.Add2("CoGrupo", c.CoGrupo, DbType.Int32);

        string sql = $@"SELECT * FROM {_schema}.fn_tipoparticular_sel_default(
            @CoEmpresa,
            @CoGrupo
        )";
        return await _connection.QueryFirstOrDefaultAsync<TipoParticularModel>(sql, pr);
    }

}
