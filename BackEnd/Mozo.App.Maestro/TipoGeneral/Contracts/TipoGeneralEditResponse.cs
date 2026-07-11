namespace Mozo.App.Maestro.TipoGeneral.Contracts;

/// <summary>
/// DTO plano para traer un Tipo General a editar (GET SelById).
/// </summary>
public sealed class TipoGeneralEditResponse
{
    public int? CoTipoGeneral { get; set; }
    public int? CoModulo { get; set; }
    public int? CoGrupo { get; set; }
    public string? NoTipo { get; set; }
    public string? NoSigla { get; set; }
    public string? TxDescripcion { get; set; }
    public string? NoComando { get; set; }
    public string? Valor { get; set; }
    public int? NuOrden { get; set; }
    public int? FlDefault { get; set; }
}
