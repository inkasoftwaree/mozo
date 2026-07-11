namespace Mozo.Api.Abstractions;

/// <summary>
/// Contrato de un módulo de endpoints. Cada feature declara su prefijo de ruta
/// y mapea sus rutas sobre el grupo ya creado y tageado por <c>MapEndpoints()</c>.
/// Las clases que lo implementan se descubren y registran automáticamente por reflexión.
/// </summary>
public interface IEndpoint
{
    /// <summary>Prefijo de ruta del grupo, p. ej. "/seguridad/empresa".</summary>
    string Prefix { get; }

    /// <summary>Mapea las rutas del feature sobre su <see cref="RouteGroupBuilder"/>.</summary>
    void MapEndpoint(RouteGroupBuilder group);
}
