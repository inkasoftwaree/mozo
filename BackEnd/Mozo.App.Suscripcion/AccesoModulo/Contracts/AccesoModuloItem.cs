namespace Mozo.App.Suscripcion.AccesoModulo.Contracts;

/// <summary>
/// DTO plano de un módulo habilitado por la suscripción vigente de la empresa
/// (fn_empresa_modulo_sel_habilitados).
/// </summary>
public sealed class AccesoModuloItem
{
    public int? CoModulo { get; set; }
    public string? NoModulo { get; set; }
    public DateTime? FeFin { get; set; }
}
