using Microsoft.Extensions.DependencyInjection;
using Mozo.App.Maestro.Archivo;
using Mozo.App.Maestro.DocumentoIdentidad;
using Mozo.App.Maestro.Entidad;
using Mozo.App.Maestro.EntidadDireccion;
using Mozo.App.Maestro.EntidadDocumento;
using Mozo.App.Maestro.EntidadEmpresa;
using Mozo.App.Maestro.EntidadRedSocial;
using Mozo.App.Maestro.EntidadRol;
using Mozo.App.Maestro.Pais;
using Mozo.App.Maestro.PersonaJuridica;
using Mozo.App.Maestro.PersonaNatural;
using Mozo.App.Maestro.TipoGeneral;
using Mozo.App.Maestro.TipoParticular;
using Mozo.App.Maestro.Ubigeo;

namespace Mozo.App.Maestro;

public static class DependencyInjection
{
    public static IServiceCollection AddMaestro(this IServiceCollection services)
    {
        services.AddScoped<IEntidadService, EntidadService>();
        services.AddScoped<IPersonaNaturalService, PersonaNaturalService>();
        services.AddScoped<IPersonaJuridicaService, PersonaJuridicaService>();
        services.AddScoped<IEntidadDocumentoService, EntidadDocumentoService>();
        services.AddScoped<IEntidadDireccionService, EntidadDireccionService>();
        services.AddScoped<IEntidadRedSocialService, EntidadRedSocialService>();
        services.AddScoped<IEntidadRolService, EntidadRolService>();
        services.AddScoped<IEntidadEmpresaService, EntidadEmpresaService>();
        services.AddScoped<ITipoGeneralService, TipoGeneralService>();
        services.AddScoped<ITipoParticularService, TipoParticularService>();
        services.AddScoped<IPaisService, PaisService>();
        services.AddScoped<IDocumentoIdentidadService, DocumentoIdentidadService>();
        services.AddScoped<IUbigeoService, UbigeoService>();

        services.AddScoped<IArchivoService, ArchivoService>();
        services.AddScoped<IArchivoBusiness, ArchivoBusiness>();

        services.AddScoped<IPersonaNaturalBusiness, PersonaNaturalBusiness>();
        services.AddScoped<IPersonaJuridicaBusiness, PersonaJuridicaBusiness>();


        return services;
    }
}
