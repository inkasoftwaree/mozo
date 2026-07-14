using Mozo.Shared.Contract;

namespace Mozo.App.Maestro.EntidadRol.Contracts;

/// <summary>
/// DTO plano para los listados de Roles activos de una entidad
/// (SelAllActive / SelAllActiveByPersona / SelAllActiveByModuloPersona).
/// FlEstReg viene de BaseListItem.
/// </summary>
public sealed class EntidadRolOption : BaseListItem
{
    public int? CoEntidadRol { get; set; }
    public int? CoEmpresa { get; set; }
    public int? CoEntidad { get; set; }
    public int? CoModulo { get; set; }
    public int? CoRolNegocio { get; set; }
}
