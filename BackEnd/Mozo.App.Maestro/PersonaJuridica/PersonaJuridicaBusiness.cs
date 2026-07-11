using Mozo.App.Maestro.Entidad;
using Mozo.App.Maestro.EntidadDireccion;
using Mozo.App.Maestro.EntidadDocumento;
using Mozo.App.Maestro.EntidadEmpresa;
using Mozo.App.Maestro.EntidadRedSocial;
using Mozo.App.Maestro.PersonaJuridica;
using Mozo.Domain.Maestro;
using Mozo.Infrastructure.Persistence;

namespace Mozo.App.Maestro.PersonaNatural;

public interface IPersonaJuridicaBusiness
{
    Task<int> InsertAsync(PersonaJuridicaEntity c);
    Task<int> UpdateByIdAsync(PersonaJuridicaEntity m);
}
public sealed class PersonaJuridicaBusiness : IPersonaJuridicaBusiness
{
    private readonly IDatabase _database;
    private readonly IEntidadService _entidad;
    private readonly IPersonaJuridicaService _personaJuridica;
    private readonly IEntidadDocumentoService _documento;
    private readonly IEntidadDireccionService _direccion;
    private readonly IEntidadRedSocialService _redSocial;
    private readonly IEntidadEmpresaService _entidadEmpresa;

    public PersonaJuridicaBusiness(
        IDatabase database,
        IEntidadService entidad,
        IPersonaJuridicaService personaJuridica,
        IEntidadDocumentoService documento,
        IEntidadDireccionService direccion,
        IEntidadRedSocialService redSocial,
        IEntidadEmpresaService entidadEmpresa
    )
    {
        _database = database;
        _entidad = entidad;
        _personaJuridica = personaJuridica;
        _documento = documento;
        _direccion = direccion;
        _redSocial = redSocial;
        _entidadEmpresa = entidadEmpresa;
    }

    public async Task<int> InsertAsync(PersonaJuridicaEntity c)
    {
        return await _database.ExecuteTransactionAsync(async () =>
        {
            // 1. Crear Entidad
            c.Entidad!.NoEntidad = c.NoRazonSocial;
            int coEntidad = await _entidad.InsertAsync(c.Entidad);

            c.CoEntidad = coEntidad;
            c.Entidad.CoEntidad = coEntidad;

            // 2. Crear Persona Natural
            await _personaJuridica.InsertAsync(c);

            // 3. Documentos
            foreach (EntidadDocumentoEntity documento in c.Entidad.DocumentoLst ?? [])
            {
                documento.CoEntidad = coEntidad;
                await _documento.InsertAsync(documento);
            }

            // 4. Direcciones
            foreach (EntidadDireccionEntity direccion in c.Entidad.DireccionLst ?? [])
            {
                direccion.CoEntidad = coEntidad;
                await _direccion.InsertAsync(direccion);
            }

            // 5. Redes Sociales
            foreach (EntidadRedSocialEntity red in c.Entidad.RedSocialLst ?? [])
            {
                red.CoEntidad = coEntidad;
                await _redSocial.InsertAsync(red);
            }

            // 6. Entidad Empresa                       
            await _entidadEmpresa.InsertAsync(new() { CoEntidad = coEntidad, FlEmpresaNotKey = c.FlEmpresaNotKey });


            return c.CoEntidad!.Value;
        });
    }


    public Task<int> UpdateByIdAsync(PersonaJuridicaEntity c)
    {
        return _database.ExecuteTransactionAsync(async () =>
        {
            // 1. Modificar Entidad
            c.Entidad!.NoEntidad = c.NoRazonSocial;
            await _entidad.UpdateByIdAsync(c.Entidad);

            // 2. Modificar Persona Juridica — fuente de la cantidad de filas afectadas.
            return await _personaJuridica.UpdateByIdAsync(c);
        });
    }

}