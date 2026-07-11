
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;
using Mozo.App.Maestro.Archivo.Contracts;
using Mozo.Domain.Maestro;
using Mozo.Shared.Global;
using Mozo.Shared.Services.Storage;
using System.Data;

namespace Mozo.App.Maestro.Archivo;

public interface IArchivoBusiness
{
    Task<ArchivoEntity> InsertAsync(ArchivoEntity c, IFormFile file);
    Task<ArchivoEntity> UpdateMetaDataByIdAsync(ArchivoEntity c, IFormFile file);
    Task<int> UpdateByIdAsync(ArchivoEntity c);
    Task<int> UpdateOrderAsync(ArchivoEntity c);
    Task<int> UpdateOrderMassiveAsync(OrdenMasivoRequest req);
    Task<int> DeleteByIdAsync(ArchivoFilter c);

    Task<ArchivoEditResponse?> SelByIdAsync(ArchivoFilter c);
    Task<ArchivoEditResponse?> SelMetaDataByUkAsync(ArchivoFilter c);
    Task<IEnumerable<ArchivoListItem>> SelAllAsync(ArchivoFilter c);
    Task<ArchivoEditResponse?> SelMetaDataByIdAsync(ArchivoFilter f);
    Task<IEnumerable<ArchivoListItem>> SelAllActiveAsync(ArchivoFilter c);
}
public class ArchivoBusiness : IArchivoBusiness
{
    private readonly IArchivoService _data;   // 👈 antes: IArchivoData
    private readonly IFileStorageService _storage;
    private readonly IImageProcessor _imageProcessor;
    private readonly ILogger<ArchivoBusiness> _logger;

    public ArchivoBusiness(
        IArchivoService data,                 // 👈 antes: IArchivoData
        IFileStorageService storage,
        IImageProcessor imageProcessor,
        ILogger<ArchivoBusiness> logger)
    {
        _data = data;
        _storage = storage;
        _imageProcessor = imageProcessor;
        _logger = logger;
    }

    public Task<int> UpdateOrderAsync(ArchivoEntity c) => _data.UpdateOrderAsync(c);
    public Task<int> UpdateOrderMassiveAsync(OrdenMasivoRequest req) => _data.UpdateOrderMassiveAsync(req);
    public async Task<ArchivoEditResponse?> SelByIdAsync(ArchivoFilter c) => await _data.SelByIdAsync(c);
    public async Task<ArchivoEditResponse?> SelMetaDataByUkAsync(ArchivoFilter c) => await _data.SelMetaDataByUkAsync(c);
    public async Task<IEnumerable<ArchivoListItem>> SelAllAsync(ArchivoFilter c)
    {
        List<ArchivoListItem> r = (await _data.SelAllAsync(c)).ToList();
        return r.OrderBy(x => x.CoTipo)
             .ThenBy(x => x.NuOrden)
             .ToList();
    }

    private async Task<ArchivoEntity> UploadProcessAsync(IFormFile file, ArchivoEntity p)
    {
        string extension = Path.GetExtension(file.FileName).ToLowerInvariant();
        string nombreSinExt = Path.GetFileNameWithoutExtension(file.FileName);
        string guid = Guid.NewGuid().ToString("N");

        // ⬇️ Validar extensión permitida
        if (!_storage.EsExtensionPermitida(extension))
        {
            throw new InvalidOperationException(
                $"Extensión '{extension}' no permitida"
            );
        }

        // ⬇️ Validar tamaño antes de procesar
        if (file.Length > _storage.GetMaxFileSize())
        {
            throw new InvalidOperationException(
                $"El archivo excede el tamaño máximo permitido"
            );
        }

        byte[] contenido;
        int? ancho = null;
        int? alto = null;
        string extensionFinal = extension;

        // Procesar solo si es imagen
        if (_imageProcessor.EsImagen(extension))
        {
            using Stream? stream = file.OpenReadStream();
            NormalizacionResult resultado = await _imageProcessor.NormalizarAsync(stream);

            contenido = resultado.Bytes;
            ancho = resultado.Ancho;
            alto = resultado.Alto;
            extensionFinal = resultado.Extension;
        }
        else
        {
            using var ms = new MemoryStream();
            await file.CopyToAsync(ms);
            contenido = ms.ToArray();
        }

        // Construir ruta
        string? nombreArchivo = $"{guid}{extensionFinal}";
        string? rutaRelativa = _storage.BuildPath(
            p.CoEmpresa,
            p.CoTipoEntidad,
            p.CoEntidad,
            p.CoTipo,
            nombreArchivo
        );

        // Guardar archivo físico
        await _storage.SaveAsync(contenido, rutaRelativa);

        // Insertar en BD
        ArchivoEntity archivo = new()
        {
            FlEmpresaNotKey = p.FlEmpresaNotKey,
            CoEmpresa = p.CoEmpresa,
            CoArchivo = p.CoArchivo,
            CoTipoEntidad = p.CoTipoEntidad,
            CoEntidad = p.CoEntidad,
            CoTipo = p.CoTipo,
            FlGaleria = p.FlGaleria,
            NoArchivo = nombreArchivo,
            NoExtension = extensionFinal,
            NoRuta = rutaRelativa,
            NuBytes = contenido.Length,
            NuAlto = alto,
            NuAncho = ancho
        };
        return archivo;
    }

    public async Task<ArchivoEntity> InsertAsync(ArchivoEntity c, IFormFile file)
    {
        ArchivoEntity archivo = await UploadProcessAsync(file, c);
        archivo.CoArchivo = await _data.InsertAsync(archivo);

        archivo.Url = $"/uploads/{archivo.NoRuta}";
        archivo.ContentType = Glo.GetContentType(archivo.NoExtension!);


        _logger.LogInformation(
          "Archivo {CoArchivo} subido: {Ruta} ({Bytes} bytes)",
          archivo.CoArchivo, archivo.NoRuta, archivo.NuBytes
      );

        return archivo;
    }

    public async Task<int> DeleteByIdAsync(ArchivoFilter f)
    {
        ArchivoEditResponse? archivo = await _data.SelMetaDataByIdAsync(f);
        if (archivo == null) return 0;

        // Eliminar registro primero: si esto falla, no perdemos el archivo físico.
        // El orden inverso dejaría un registro huérfano apuntando a un archivo ya
        // borrado, que es peor que un archivo huérfano en disco (solo espacio perdido).
        int filas = await _data.DeleteByIdAsync(f);

        if (!string.IsNullOrEmpty(archivo.NoRuta))
        {
            try
            {
                await _storage.DeleteAsync(archivo.NoRuta);
            }
            catch (Exception ex)
            {
                _logger.LogWarning(ex,
                    "No se pudo eliminar archivo físico: {Ruta}",
                    archivo.NoRuta
                );
            }
        }
        _logger.LogInformation("Archivo {CoArchivo} eliminado", f.CoArchivo);

        return filas;
    }

    public async Task<ArchivoEntity> UpdateMetaDataByIdAsync(ArchivoEntity c, IFormFile file)
    {    // 1. Obtener el archivo anterior
        var filterAnterior = new ArchivoFilter
        {
            FlEmpresaNotKey = c.FlEmpresaNotKey,
            CoEmpresa = c.CoEmpresa,
            CoArchivo = c.CoArchivo
        };
        ArchivoEditResponse? anterior = await _data.SelMetaDataByIdAsync(filterAnterior);
        if (anterior == null)
            throw new InvalidOperationException($"No se encontró el archivo {c.CoArchivo}");

        // 2. Eliminar el anterior (archivo físico)
        if (!string.IsNullOrEmpty(anterior.NoRuta))
        {
            try
            {
                await _storage.DeleteAsync(anterior.NoRuta);
            }
            catch (Exception ex)
            {
                _logger.LogWarning(ex,
                    "No se pudo eliminar archivo físico anterior: {Ruta}",
                    anterior.NoRuta
                );
            }
        }

        // 3. Actualizar el archivo
        ArchivoEntity archivo = await UploadProcessAsync(file, c);
        await _data.UpdateMetaDataByIdAsync(archivo);
        return archivo;
    }

    public async Task<int> UpdateByIdAsync(ArchivoEntity c) => await _data.UpdateByIdAsync(c);

    public async Task<IEnumerable<ArchivoListItem>> SelAllActiveAsync(ArchivoFilter c)
    {
        List<ArchivoListItem> r = (await _data.SelAllActiveAsync(c)).ToList();

        return r.OrderBy(x => x.CoTipo)
             .ThenBy(x => x.NuOrden)
             .ToList();
    }


    public async Task<ArchivoEditResponse?> SelMetaDataByIdAsync(ArchivoFilter f) => await _data.SelMetaDataByIdAsync(f);



}
