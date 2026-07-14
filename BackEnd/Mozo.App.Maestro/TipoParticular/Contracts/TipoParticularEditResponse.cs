namespace Mozo.App.Maestro.TipoParticular.Contracts;

/// <summary>
/// DTO plano para traer un Tipo Particular a editar (GET SelById / SelByIdGroup / SelDefault).
/// Incluye los ids editables y los nombres de referencia (grupo, módulo, padre) que
/// devuelven las funciones de detalle.
/// </summary>
public sealed class TipoParticularEditResponse
{
    public int? CoEmpresa { get; set; }
    public int? CoModulo { get; set; }
    public int? CoGrupo { get; set; }
    public int? CoTipoParticular { get; set; }
    public int? NuOrden { get; set; }
    public string? NoTipo { get; set; }
    public string? NoSigla { get; set; }
    public string? TxDescripcion { get; set; }
    public int? CoGrupoPadre { get; set; }
    public int? CoTipoParticularPadre { get; set; }
    public int? FlDefault { get; set; }
    public string? NoComando { get; set; }
    public string? NoGrupo { get; set; }
    public string? NoGrupoPadre { get; set; }
    public string? NoTipoParticularPadre { get; set; }
    public string? NoModulo { get; set; }
    public int? CoGrupoHijo { get; set; }
    public int? QtHijo { get; set; }
    public int? CoServicio { get; set; }
}
