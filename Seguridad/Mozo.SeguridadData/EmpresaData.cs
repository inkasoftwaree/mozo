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

public interface IEmpresaData
{
    Task<int> InsertAsync(EmpresaModel c);
    Task UpdateAsync(EmpresaModel c);
    Task UpdateStateAsync(EmpresaModel c);
    Task DeleteByIdAsync(EmpresaFilterDto c);
    Task<IEnumerable<EmpresaModel>> SelAllAsync(EmpresaFilterDto c);
    Task<IEnumerable<EmpresaModel>> SelAllActiveAsync();
    Task<EmpresaModel?> SelByIdAsync(EmpresaFilterDto c);
}

public partial class EmpresaData : IEmpresaData
{
    private readonly string _schema = EnuCommon.BdDefault.Schema.Seguridad;
    private readonly IDbConnection _connection;
    private readonly UserContext _user;
    public EmpresaData(IDbConnection connection, UserContext user)
    {
        _connection = connection;
        _user = user;
    }

    public async Task<int> InsertAsync(EmpresaModel c)
    {
        DynamicParameters pr = new();
        pr.Add2("CoDocumentoIdentidad", c.CoDocumentoIdentidad, DbType.Int32);
        pr.Add2("NuDocumento", c.NuDocumento, DbType.String);
        pr.Add2("NoDirecionLinea1", c.NoDirecionLinea1, DbType.String);
        pr.Add2("CoUbigeo", c.CoUbigeo, DbType.Int32);

        pr.Add2("NoTelefonoFijo", c.NoTelefonoFijo, DbType.String);
        pr.Add2("NoTelefonoCelular", c.NoTelefonoCelular, DbType.String);       
        pr.Add2("NoCorreo", c.NoCorreo, DbType.String);


        pr.Add2("NoRazonSocial", c.PersonaJuridica?.NoRazonSocial, DbType.String);
        pr.Add2("NoComercial", c.PersonaJuridica?.NoComercial, DbType.String);

        pr.Add2("NoMision", c.NoMision, DbType.String);
        pr.Add2("NoVision", c.NoVision, DbType.String);
        pr.Add2("TxQuienSoy", c.TxQuienSoy, DbType.String);      
        pr.Add2("CoPais", c.CoPais, DbType.Int32);
        pr.Add2("CoMoneda", c.CoMoneda, DbType.Int32);
        pr.Add2("CoIdioma", c.CoIdioma, DbType.Int32);
        pr.Add2("CoUsuCre", _user.CoUsuarioRequired, DbType.Int32);

        string sql = @$"SELECT {_schema}.fn_empresa_insert(
            @CoDocumentoIdentidad,
            @NuDocumento,
            @NoDirecionLinea1,
            @CoUbigeo,
            @NoTelefonoFijo,
            @NoTelefonoCelular,
            @NoCorreo,
            @NoRazonSocial,
            @NoComercial,
            @NoMision,
            @NoVision,
            @TxQuienSoy,     
            @CoPais,
            @CoMoneda,
            @CoIdioma,
            @CoUsuCre
        )";
        return await _connection.ExecuteScalarAsync<int>(sql, pr);
    }
    public async Task UpdateAsync(EmpresaModel c)
    {
        DynamicParameters pr = new();
        pr.Add2("CoEntidad", c.CoEntidad, DbType.Int32);
        pr.Add2("NoRazonSocial", c.PersonaJuridica?.NoRazonSocial, DbType.String);
        pr.Add2("NoComercial", c.PersonaJuridica?.NoComercial, DbType.String);
        pr.Add2("NoMision", c.NoMision, DbType.String);
        pr.Add2("NoVision", c.NoVision, DbType.String);
        pr.Add2("TxQuienSoy", c.TxQuienSoy, DbType.String);      
        pr.Add2("CoPais", c.CoPais, DbType.Int32);
        pr.Add2("CoMoneda", c.CoMoneda, DbType.Int32);
        pr.Add2("CoIdioma", c.CoIdioma, DbType.Int32);       
        pr.Add2("CoUsuMod", _user.CoUsuarioRequired, DbType.Int32);


        string sql = @$"CALL {_schema}.usp_empresa_update(
            @CoEntidad,
            @NoRazonSocial,
            @NoComercial,
            @NoMision,
            @NoVision,
            @TxQuienSoy,
            @CoPais,
            @CoMoneda,
            @CoIdioma,
            @CoUsuMod)";
        await _connection.ExecuteAsync(sql, pr);
    }
    public async Task UpdateStateAsync(EmpresaModel c)
    {
        DynamicParameters pr = new();
        pr.Add2("CoEmpresa", c.CoEmpresa, DbType.Int32);
        pr.Add2("FlEstReg", c.FlEstReg, DbType.Int32);
        pr.Add2("CoUsuMod", _user.CoUsuarioRequired, DbType.Int32);

        string sql = @$"CALL {_schema}.usp_empresa_update_state(@CoEmpresa,@FlEstReg,@CoUsuMod)";
        await _connection.ExecuteAsync(sql, pr);
    }
    public async Task DeleteByIdAsync(EmpresaFilterDto c)
    {
        DynamicParameters pr = new();
        pr.Add2("CoEmpresa", c.CoEmpresa, DbType.Int32);
        pr.Add2("CoUsuEli", _user.CoUsuarioRequired, DbType.Int32);
        string sql = $"CALL {_schema}.usp_empresa_delete_by_id(@CoEmpresa,@CoUsuEli)";
        await _connection.ExecuteAsync(sql, pr);
    }
    public async Task<IEnumerable<EmpresaModel>> SelAllAsync(EmpresaFilterDto c)
    {
        DynamicParameters pr = new();
        pr.Add2("CoEmpresa", c.CoEmpresa, DbType.Int32);
        pr.Add2("NoInputSearch", c.NoInputSearch, DbType.String);
        pr.Add2("PageSize", c.PageSize, DbType.Int32);
        pr.Add2("PageIndex", c.PageIndex, DbType.Int32);

        string sql = $"SELECT * FROM {_schema}.fn_empresa_sel_all(@CoEmpresa,@NoInputSearch,@PageSize,@PageIndex)";
        return await _connection.QueryAsync<EmpresaModel>(sql, pr);
    }
    public async Task<IEnumerable<EmpresaModel>> SelAllActiveAsync()
    {
        string sql = $"SELECT * FROM {_schema}.fn_empresa_sel_all_active()";
        return await _connection.QueryAsync<EmpresaModel>(sql);
    }
    public async Task<EmpresaModel?> SelByIdAsync(EmpresaFilterDto c)
    {
        DynamicParameters pr = new();
        pr.Add2("CoEmpresa", c.CoEmpresa, DbType.Int32);
        string sql = $@"SELECT * FROM {_schema}.fn_empresa_sel_by_id(
            @CoEmpresa
        )";
        return await _connection.QueryFirstOrDefaultAsync<EmpresaModel>(sql, pr);
    }

}