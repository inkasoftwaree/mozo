using Mozo.App.Seguridad.Empresa.Contracts;
using Mozo.Domain.Seguridad;
using Mozo.Infrastructure.Persistence;
using Mozo.Infrastructure.Persistence.Builders;
using Mozo.Shared.Cripto;
using Mozo.Shared.Models;
using Mozo.Shared.Services;
using System.Data;

namespace Mozo.App.Seguridad.Empresa;

public interface IEmpresaService
{

    Task<EmpresaInsertAllResponse?> InsertAllAsync(EmpresaInsertAllRequest r);
    Task<int> InsertAsync(EmpresaEntity m);
    Task<int> UpdateByIdAsync(EmpresaEntity m);
    Task<int> UpdateStateByIdAsync(EmpresaEntity m);
    Task<EmpresaEditResponse?> SelByIdAsync(EmpresaFilter f);
    Task<PagedResult<EmpresaListItem>> SelAllAsync(EmpresaFilter f);
    Task<IReadOnlyList<EmpresaOption>> SelAllActiveAsync();
}

public sealed class EmpresaService : IEmpresaService
{
    private readonly IDatabase _database;
    private readonly UserContext _user;

    public EmpresaService(IDatabase database, UserContext user)
    {
        _database = database;
        _user = user;
    }

    // Registro/onboarding. El orden de los .Add debe respetar la firma de
    // fn_empresa_insert_all (el binder de Postgres es POSICIONAL). Los módulos ya no
    // se pasan sueltos: fn_suscripcion_insert los proyecta desde el plan (trfplanmodulo).
    public Task<EmpresaInsertAllResponse?> InsertAllAsync(EmpresaInsertAllRequest r)
    {
        List<EmpresaInsertAllDocumento> documentos = r.Documentos ?? [];
        List<EmpresaInsertAllRedSocial> redes = r.RedesSociales ?? [];

        return _database.FirstAsync<EmpresaInsertAllResponse>(EmpresaDbObjects.InsertAll,
            p => p.Add("NoRazonSocial", r.NoRazonSocial, DbType.String)
                  .Add("NoComercial", r.NoComercial, DbType.String)
                  .Add("CoRubro", r.CoRubro, DbType.Int32)
                  .Add("NoMision", r.NoMision, DbType.String)
                  .Add("NoVision", r.NoVision, DbType.String)
                  .Add("TxQuienSoy", r.TxQuienSoy, DbType.String)
                  .Add("CoPais", r.CoPais, DbType.Int32)
                  .Add("CoMoneda", r.CoMoneda, DbType.Int32)
                  .Add("CoIdioma", r.CoIdioma, DbType.Int32)
                  .AddArray("DocumentosCodigo", documentos.Select(d => (long)d.CoDocumentoIdentidad).ToArray())
                  .AddArray("DocumentosNumero", documentos.Select(d => d.NuDocumento ?? "").ToArray())
                  .AddArray("Direcciones", (r.Direcciones ?? []).ToArray())
                  .AddArray("TipoRedSocial", redes.Select(x => (long)x.CoTipoRedSocial).ToArray())
                  .AddArray("RedSocial", redes.Select(x => x.NoRedSocial ?? "").ToArray())
                  // suscripción (reemplaza Modulos)
                  .Add("CoPlan", r.CoPlan, DbType.Int32)
                  .Add("CoPlanPrecio", r.CoPlanPrecio, DbType.Int32)
                  .Add("CoEstado", r.CoEstado, DbType.Int32)
                  .Add("FlAutoRenovar", r.FlAutoRenovar, DbType.Int32)
                  .Add("AdminNoPersona", r.AdminNoPersona, DbType.String)
                  .Add("AdminApellidoP", r.AdminApellidoP, DbType.String)
                  .Add("AdminApellidoM", r.AdminApellidoM, DbType.String)
                  .Add("AdminNoUsuario", r.AdminNoUsuario, DbType.String)
                  .Add("AdminNoClave", ClaveHelper.Hash(r.AdminNoClave!), DbType.String)
                  .Add("CoUsuCre", 0, DbType.Int32));
    }



    public Task<int> InsertAsync(EmpresaEntity m) =>
       _database.ScalarAsync<int>(EmpresaDbObjects.Insert,
           p => p.Add("CoEntidad", m.CoEntidad, DbType.Int32)
                 .Add("NoMision", m.NoMision, DbType.String)
                 .Add("NoVision", m.NoVision, DbType.String)
                 .Add("TxQuienSoy", m.TxQuienSoy, DbType.String)
                 .Add("CoPais", m.CoPais, DbType.Int32)
                 .Add("CoMoneda", m.CoMoneda, DbType.Int32)
                 .Add("CoIdioma", m.CoIdioma, DbType.Int32)
                 .AddUserUpdate(_user.CoUsuarioRequired)
        );


    public Task<int> UpdateByIdAsync(EmpresaEntity m) =>
        _database.ScalarAsync<int>(EmpresaDbObjects.UpdateById,
            p => p.Add("CoEmpresa", m.CoEmpresa, DbType.Int32)
                  .Add("NoMision", m.NoMision, DbType.String)
                  .Add("NoVision", m.NoVision, DbType.String)
                  .Add("TxQuienSoy", m.TxQuienSoy, DbType.String)
                  .Add("CoPais", m.CoPais, DbType.Int32)
                  .Add("CoMoneda", m.CoMoneda, DbType.Int32)
                  .Add("CoIdioma", m.CoIdioma, DbType.Int32)
                  .AddUserUpdate(_user.CoUsuarioRequired));

    public Task<int> UpdateStateByIdAsync(EmpresaEntity m) =>
     _database.ScalarAsync<int>(EmpresaDbObjects.UpdateStateById,
         p => p.Add("CoEntidad", m.CoEntidad, DbType.Int32)
               .Add("FlEstReg", m.FlEstReg, DbType.Int32)
               .AddUserUpdate(_user.CoUsuarioRequired));

    public Task<EmpresaEditResponse?> SelByIdAsync(EmpresaFilter f) =>
        _database.FirstAsync<EmpresaEditResponse>(EmpresaDbObjects.SelById,
            p => p.Add("CoEmpresa", f.CoEmpresa, DbType.Int32));

    public async Task<PagedResult<EmpresaListItem>> SelAllAsync(EmpresaFilter f)
    {
        var r = await _database.ListAsync<EmpresaListItem>(EmpresaDbObjects.SelAll,
        p => p.Add("CoEmpresa", f.CoEmpresa, DbType.Int32)
              .Add("NoInputSearch", f.NoInputSearch, DbType.String)
              .Add("PageSize", f.PageSize, DbType.Int32)
              .Add("PageIndex", f.PageIndex, DbType.Int32));

        return new PagedResult<EmpresaListItem>
        {
            Items = r,
            TotalRows = r.Count > 0 ? (r[0].RowsCount ?? 0) : 0,
            PageIndex = f.PageIndex ?? 0,
            PageSize = f.PageSize ?? 0
        };
    }
    public Task<IReadOnlyList<EmpresaOption>> SelAllActiveAsync() =>
        _database.ListAsync<EmpresaOption>(EmpresaDbObjects.SelAllActive);

}