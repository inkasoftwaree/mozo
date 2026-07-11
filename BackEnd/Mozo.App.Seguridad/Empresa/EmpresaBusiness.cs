using Mozo.App.Maestro.Entidad;
using Mozo.App.Maestro.EntidadDireccion;
using Mozo.App.Maestro.EntidadDocumento;
using Mozo.App.Maestro.EntidadRedSocial;
using Mozo.App.Maestro.PersonaJuridica;
using Mozo.Domain.Maestro;
using Mozo.Domain.Seguridad;
using Mozo.Infrastructure.Persistence;

namespace Mozo.App.Seguridad.Empresa;

public interface IEmpresaBusiness
{
    Task<int> InsertAsync(EmpresaEntity c);
    Task<int> UpdateByIdAsync(EmpresaEntity m);
}
public sealed class EmpresaBusiness : IEmpresaBusiness
{
    private readonly IDatabase _database;
    private readonly IEntidadService _entidad;
    private readonly IPersonaJuridicaService _personaJuridica;
    private readonly IEmpresaService _empresa;
    private readonly IEntidadDocumentoService _documento;
    private readonly IEntidadDireccionService _direccion;
    private readonly IEntidadRedSocialService _redSocial;


    public EmpresaBusiness(
        IDatabase database,
        IEntidadService entidad,
        IPersonaJuridicaService personaJuridica,
        IEmpresaService empresa,
        IEntidadDocumentoService documento,
        IEntidadDireccionService direccion,
        IEntidadRedSocialService redSocial
    )
    {
        _database = database;
        _entidad = entidad;
        _personaJuridica = personaJuridica;
        _documento = documento;
        _direccion = direccion;
        _redSocial = redSocial;
        _empresa = empresa;
    }

    public async Task<int> InsertAsync(EmpresaEntity c)
    {
        return await _database.ExecuteTransactionAsync(async () =>
        {
            // 1. Crear Entidad
            c.Entidad!.NoEntidad = c.PersonaJuridica!.NoRazonSocial;
            int coEntidad = await _entidad.InsertAsync(c.Entidad);

            c.CoEntidad = coEntidad;
            c.Entidad.CoEntidad = coEntidad;


            // 2. Documentos
            foreach (EntidadDocumentoEntity documento in c.Entidad.DocumentoLst ?? [])
            {
                documento.CoEntidad = coEntidad;
                await _documento.InsertAsync(documento);
            }

            // 3. Direcciones
            foreach (EntidadDireccionEntity direccion in c.Entidad.DireccionLst ?? [])
            {
                direccion.CoEntidad = coEntidad;
                await _direccion.InsertAsync(direccion);
            }

            // 4. Redes Sociales
            foreach (EntidadRedSocialEntity red in c.Entidad.RedSocialLst ?? [])
            {
                red.CoEntidad = coEntidad;
                await _redSocial.InsertAsync(red);
            }



            // 5. Crear Persona Juridica
            c.PersonaJuridica.CoEntidad = coEntidad;
            await _personaJuridica.InsertAsync(c.PersonaJuridica);

            // 6. Empresa
            c.CoEntidad = coEntidad;
            await _empresa.InsertAsync(c);


            return c.CoEntidad!.Value;
        });
    }


    public Task<int> UpdateByIdAsync(EmpresaEntity c)
    {
        return _database.ExecuteTransactionAsync(async () =>
        {
            // 1. Modificar Entidad
            c.Entidad!.NoEntidad = c.PersonaJuridica!.NoRazonSocial;
            await _entidad.UpdateByIdAsync(c.Entidad);

            // 2. Modificar Persona Juridica
            await _personaJuridica.UpdateByIdAsync(c.PersonaJuridica);

            // 3. Modificar Empresa — fuente de la cantidad de filas afectadas: es la
            // entidad que expone este endpoint (/seguridad/empresa).
            return await _empresa.UpdateByIdAsync(c);
        });
    }

}