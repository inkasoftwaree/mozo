using System.Data;
using System.Reflection;
using System.Text.Json;
using System.Text.Json.Serialization;
using System.Web;

namespace Mozo.Shared.Global;

public static partial class Glo
{
    public static string GetContentType(string extension) => extension.ToLowerInvariant() switch
    {
        ".jpg" or ".jpeg" => "image/jpeg",
        ".png" => "image/png",
        ".webp" => "image/webp",
        ".gif" => "image/gif",
        ".pdf" => "application/pdf",
        ".doc" => "application/msword",
        ".docx" => "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
        ".xls" => "application/vnd.ms-excel",
        ".xlsx" => "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
        ".svg" => "image/svg+xml",
        ".atom" => "application/atom+xml",
        ".txt" => "text/plain",
        ".css" => "text/css",
        ".js" => "application/javascript",
        ".html" => "text/html",
        ".xml" => "application/xml",
        ".json" => "text/json",
        _ => "application/octet-stream"
    };


    private static readonly JsonSerializerOptions DefaultSerializerOptions = new()
    {
        AllowTrailingCommas = true,
        WriteIndented = false,
        DefaultIgnoreCondition = JsonIgnoreCondition.WhenWritingNull
    };

    private static readonly JsonSerializerOptions DeserializerOptions = new()
    {
        AllowTrailingCommas = true,
        PropertyNameCaseInsensitive = true
    };

    public static string ToParam(this object obj)
    {
        var properties = obj.GetType()
            .GetProperties()
            .Where(p => p.GetValue(obj, null) != null)
            .Select(p => $"{p.Name}={HttpUtility.UrlEncode(p.GetValue(obj, null)!.ToString())}");

        return string.Join("&", properties);
    }

    public static string Serializa(this object? value)
    {
        return JsonSerializer.Serialize(value, DefaultSerializerOptions);
    }

    public static List<T>? DeserializaLista<T>(this string? data)
    {
        if (string.IsNullOrWhiteSpace(data)) return new List<T>();

        return JsonSerializer.Deserialize<List<T>>(data, DeserializerOptions);
    }

    public static T? Deserializa<T>(this string data)
    {
        return JsonSerializer.Deserialize<T>(data, DeserializerOptions);
    }

    public static T? DeserializaByte<T>(this byte[]? bytes)
    {
        if (bytes == null || bytes.Length == 0)
            return default;

        return JsonSerializer.Deserialize<T>(bytes, DeserializerOptions);
    }

    public static async Task<T?> DeserializaStream<T>(this Stream? stream)
    {
        if (stream == null || !stream.CanRead)
            return default;

        return await JsonSerializer.DeserializeAsync<T>(stream, DeserializerOptions);
    }

    public static async Task<string?> StreamToStringAsync(Stream? stream)
    {
        if (stream == null) return null;

        using var reader = new StreamReader(stream);
        return await reader.ReadToEndAsync();
    }

    public static string GetQueryString2(this object obj, string? prefix = null)
    {
        PropertyInfo[] properties = obj.GetType().GetProperties();
        List<string> queryParts = new();

        foreach (PropertyInfo property in properties)
        {
            object? value = property.GetValue(obj, null);

            if (value == null) continue;

            string key = prefix != null ? $"{prefix}.{property.Name}" : property.Name;

            // Si es un objeto complejo (no string, no int32), hacer recursión
            if (value.GetType().Name != "String" && value.GetType().Name != "Int32")
            {
                queryParts.Add(GetQueryString2(value, key));
            }
            else
            {
                queryParts.Add($"{Uri.EscapeDataString(key)}={Uri.EscapeDataString(value.ToString()!)}");
            }
        }

        return string.Join("&", queryParts);
    }

    public static T With<T>(this T item, Action<T> action)
    {
        action(item);
        return item;
    }
}