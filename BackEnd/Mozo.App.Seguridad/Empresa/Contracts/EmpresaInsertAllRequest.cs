namespace Mozo.App.Seguridad.Empresa.Contracts;

/// <summary>
/// Alta completa de una Empresa (registro/onboarding): entidad + persona jurídica,
/// documentos fiscales, direcciones, redes sociales, suscripción a un plan y usuario
/// administrador. Sin usuario autenticado todavía, por eso no trae CoUsuCre (la función
/// lo recibe fijo). Los módulos NO se eligen sueltos: salen del plan (trfplanmodulo)
/// vía fn_suscripcion_insert.
/// </summary>
public sealed class EmpresaInsertAllRequest
{
    public string? NoRazonSocial { get; set; }
    public string? NoComercial { get; set; }
    public int? CoRubro { get; set; }
    public string? NoMision { get; set; }
    public string? NoVision { get; set; }
    public string? TxQuienSoy { get; set; }
    public int? CoPais { get; set; }
    public int? CoMoneda { get; set; }
    public int? CoIdioma { get; set; }

    public List<EmpresaInsertAllDocumento>? Documentos { get; set; }
    public List<string>? Direcciones { get; set; }
    public List<EmpresaInsertAllRedSocial>? RedesSociales { get; set; }

    #region Suscripción (reemplaza la selección libre de módulos)
    public int? CoPlan { get; set; }         // plan elegido
    public int? CoPlanPrecio { get; set; }   // null = prueba (usa nudiasprueba); con valor = pago
    public int? CoEstado { get; set; }       // 175 prueba / 178 activa
    public int? FlAutoRenovar { get; set; }
    #endregion

    #region Usuario administrador
    public string? AdminNoPersona { get; set; }
    public string? AdminApellidoP { get; set; }
    public string? AdminApellidoM { get; set; }
    public string? AdminNoUsuario { get; set; }
    public string? AdminNoClave { get; set; }
    #endregion
}

public sealed class EmpresaInsertAllDocumento
{
    public int CoDocumentoIdentidad { get; set; }
    public string? NuDocumento { get; set; }
}

public sealed class EmpresaInsertAllRedSocial
{
    public int CoTipoRedSocial { get; set; }
    public string? NoRedSocial { get; set; }
}
