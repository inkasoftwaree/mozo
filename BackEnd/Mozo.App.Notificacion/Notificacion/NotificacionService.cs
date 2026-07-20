using Mozo.App.Notificacion.Notificacion.Contracts;
using Mozo.Infrastructure.Persistence;
using Mozo.Infrastructure.Persistence.Builders;
using Mozo.Shared.Models;
using Mozo.Shared.Services;
using System.Data;

namespace Mozo.App.Notificacion.Notificacion;

public interface INotificacionService
{
    /// <summary>Emite (inserta) una notificacion. La llaman los demas modulos.</summary>
    Task<long> EmitirAsync(NotificacionEmitir m);

    /// <summary>Contador de no leidas del usuario autenticado (badge de la campanita).</summary>
    Task<int> CountNoLeidasAsync();

    /// <summary>Bandeja paginada del usuario autenticado.</summary>
    Task<PagedResult<NotificacionListItem>> SelAllAsync(NotificacionFilter f);

    /// <summary>Marca una notificacion como leida para el usuario autenticado.</summary>
    Task<int> MarcarLeidoAsync(NotificacionFilter f);

    /// <summary>Marca todas como leidas para el usuario autenticado.</summary>
    Task<int> MarcarTodoLeidoAsync();

    /// <summary>
    /// Borra una notificacion (uso manual: corregir un registro emitido por
    /// error). No existe limpieza automatica por antiguedad en este esquema.
    /// </summary>
    Task<int> DeleteByIdAsync(NotificacionFilter f);
}

public sealed class NotificacionService : INotificacionService
{
    private readonly IDatabase _database;
    private readonly UserContext _user;

    public NotificacionService(IDatabase database, UserContext user)
    {
        _database = database;
        _user = user;
    }

    // fn_notificacion_insert(
    //   p_coempresa, p_tipo_sigla, p_canal_sigla, p_cousuario_destino,
    //   p_notitulo, p_txmensaje, p_txdatajson, p_feprogramada, p_cousucre)
    // Tipo y canal van por SIGLA (codigo estable); la funcion resuelve el id
    // contra maestro.trftipogeneral. El orden de los .Add debe coincidir EXACTO
    // con el orden de los parametros (Postgres los recibe por posicion).
    public Task<long> EmitirAsync(NotificacionEmitir m) =>
        _database.ScalarAsync<long>(NotificacionDbObjects.Insert,
            p => p
                .AddEmpresa(_user.CoEmpresaRequired)
                .Add("TipoSigla", m.TipoSigla, DbType.String)
                .Add("CanalSigla", m.Canal.ToSigla(), DbType.String)
                .Add("CoUsuarioDestino", m.CoUsuarioDestino, DbType.Int32)
                .Add("NoTitulo", m.NoTitulo, DbType.String)
                .Add("TxMensaje", m.TxMensaje, DbType.String)
                .Add("TxDataJson", m.TxDataJson, DbType.String)
                .Add("FeProgramada", m.FeProgramada, DbType.DateTime)
                .AddUserCreate(_user.CoUsuarioRequired));

    public Task<int> CountNoLeidasAsync() =>
        _database.ScalarAsync<int>(NotificacionDbObjects.CountNoLeidas,
            p => p
                .AddEmpresa(_user.CoEmpresaRequired)
                .Add("CoUsuario", _user.CoUsuarioRequired, DbType.Int32));

    public async Task<PagedResult<NotificacionListItem>> SelAllAsync(NotificacionFilter f)
    {
        var r = await _database.ListAsync<NotificacionListItem>(NotificacionDbObjects.SelAll,
            p => p
                .AddEmpresa(_user.CoEmpresaRequired)
                .Add("CoUsuario", _user.CoUsuarioRequired, DbType.Int32)
                .Add("SoloNoLeidas", f.SoloNoLeidas ?? 0, DbType.Int16)
                .Add("PageIndex", f.PageIndex, DbType.Int32)
                .Add("PageSize", f.PageSize, DbType.Int32));

        return new PagedResult<NotificacionListItem>
        {
            Items = [.. r],
            TotalRows = r.Count > 0 ? (r[0].RowsCount ?? 0) : 0,
            PageIndex = f.PageIndex ?? 0,
            PageSize = f.PageSize ?? 0
        };
    }

    public Task<int> MarcarLeidoAsync(NotificacionFilter f) =>
        _database.ScalarAsync<int>(NotificacionDbObjects.MarcarLeido,
            p => p
                .Add("CoNotificacion", f.CoNotificacion, DbType.Int64)
                .Add("CoUsuario", _user.CoUsuarioRequired, DbType.Int32));

    public Task<int> MarcarTodoLeidoAsync() =>
        _database.ScalarAsync<int>(NotificacionDbObjects.MarcarTodoLeido,
            p => p
                .AddEmpresa(_user.CoEmpresaRequired)
                .Add("CoUsuario", _user.CoUsuarioRequired, DbType.Int32));

    // fn_notificacion_delete_by_id(p_conotificacion, p_cousueli) RETURNS boolean
    public Task<int> DeleteByIdAsync(NotificacionFilter f) =>
        _database.ScalarAsync<int>(NotificacionDbObjects.DeleteById,
            p => p
                .Add("CoNotificacion", f.CoNotificacion, DbType.Int64)
                .AddUserDelete(_user.CoUsuarioRequired));
}
