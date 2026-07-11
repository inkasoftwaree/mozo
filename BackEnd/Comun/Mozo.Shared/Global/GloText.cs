using System.Collections;
using System.Data;
using System.Globalization;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;

namespace Mozo.Shared.Global;

public static partial class Glo
{
    private static readonly Dictionary<string, string> ForeignCharacters = new()
    {
        { "äæǽ", "ae" }, { "öœ", "oe" }, { "ü", "ue" },
        { "Ä", "Ae" }, { "Ü", "Ue" }, { "Ö", "Oe" },
        { "ÀÁÂÃÄÅǺĀĂĄǍΑΆẢẠẦẪẨẬẰẮẴẲẶА", "A" },
        { "àáâãåǻāăąǎªαάảạầấẫẩậằắẵẳặа", "a" },
        { "Б", "B" }, { "б", "b" },
        { "ÇĆĈĊČ", "C" }, { "çćĉċč", "c" },
        { "Д", "D" }, { "д", "d" },
        { "ÐĎĐΔ", "Dj" }, { "ðďđδ", "dj" },
        { "ÈÉÊËĒĔĖĘĚΕΈẼẺẸỀẾỄỂỆЕЭ", "E" },
        { "èéêëēĕėęěέεẽẻẹềếễểệеэ", "e" },
        { "Ф", "F" }, { "ф", "f" },
        { "ĜĞĠĢΓГҐ", "G" }, { "ĝğġģγгґ", "g" },
        { "ĤĦ", "H" }, { "ĥħ", "h" },
        { "ÌÍÎÏĨĪĬǏĮİΗΉΊΙΪỈỊИЫ", "I" },
        { "ìíîïĩīĭǐįıηήίιϊỉịиыї", "i" },
        { "Ĵ", "J" }, { "ĵ", "j" },
        { "ĶΚК", "K" }, { "ķκк", "k" },
        { "ĹĻĽĿŁΛЛ", "L" }, { "ĺļľŀłλл", "l" },
        { "М", "M" }, { "м", "m" },
        { "ÑŃŅŇΝН", "N" }, { "ñńņňŉνн", "n" },
        { "ÒÓÔÕŌŎǑŐƠØǾΟΌΩΏỎỌỒỐỖỔỘỜỚỠỞỢО", "O" },
        { "òóôõōŏǒőơøǿºοόωώỏọồốỗổộờớỡởợо", "o" },
        { "П", "P" }, { "п", "p" },
        { "ŔŖŘΡР", "R" }, { "ŕŗřρр", "r" },
        { "ŚŜŞȘŠΣС", "S" }, { "śŝşșšſσςс", "s" },
        { "ȚŢŤŦτТ", "T" }, { "țţťŧт", "t" },
        { "ÙÚÛŨŪŬŮŰŲƯǓǕǗǙǛŨỦỤỪỨỮỬỰУ", "U" },
        { "ùúûũūŭůűųưǔǖǘǚǜυύϋủụừứữửựу", "u" },
        { "ÝŸŶΥΎΫỲỸỶỴЙ", "Y" }, { "ýÿŷỳỹỷỵй", "y" },
        { "В", "V" }, { "в", "v" },
        { "Ŵ", "W" }, { "ŵ", "w" },
        { "ŹŻŽΖЗ", "Z" }, { "źżžζз", "z" },
        { "ÆǼ", "AE" }, { "ß", "ss" },
        { "Ĳ", "IJ" }, { "ĳ", "ij" }, { "Œ", "OE" },
        { "ƒ", "f" }, { "ξ", "ks" }, { "π", "p" },
        { "β", "v" }, { "μ", "m" }, { "ψ", "ps" },
        { "Ё", "Yo" }, { "ё", "yo" }, { "Є", "Ye" }, { "є", "ye" }, { "Ї", "Yi" },
        { "Ж", "Zh" }, { "ж", "zh" }, { "Х", "Kh" }, { "х", "kh" },
        { "Ц", "Ts" }, { "ц", "ts" }, { "Ч", "Ch" }, { "ч", "ch" },
        { "Ш", "Sh" }, { "ш", "sh" }, { "Щ", "Shch" }, { "щ", "shch" },
        { "ЪъЬь", "" }, { "Ю", "Yu" }, { "ю", "yu" }, { "Я", "Ya" }, { "я", "ya" }
    };

    private static readonly Dictionary<char, string> AccentMap = new()
    {
        { 'Á', "A" }, { 'É', "E" }, { 'Í', "I" }, { 'Ó', "O" }, { 'Ú', "U" },
        { 'À', "A" }, { 'È', "E" }, { 'Ì', "I" }, { 'Ò', "O" }, { 'Ù', "U" },
        { 'á', "a" }, { 'é', "e" }, { 'í', "i" }, { 'ó', "o" }, { 'ú', "u" }
    };

    private static readonly Dictionary<char, string> HtmlEntityMap = new()
    {
        { 'á', "&#225;" }, { 'é', "&#233;" }, { 'í', "&#237;" }, { 'ó', "&#243;" }, { 'ú', "&#250;" },
        { 'ñ', "&#241;" }, { 'Ñ', "&#209;" }, { 'ü', "&#252;" }, { 'Ü', "&#220;" },
        { '\'', "&#96;" }, { 'Á', "&#193;" }, { 'É', "&#201;" }, { 'Í', "&#205;" },
        { 'Ó', "&#211;" }, { 'Ú', "&#218;" }, { '°', "&#176;" }, { 'º', "&#186;" },
        { '{', "&#123;" }, { '}', "&#125;" }, { ':', "&#58;" }, { '.', "&#46;" }
    };

    public static bool In<T>(this T value, params T[] args)
    {
        return args.Contains(value);
    }

    public static string? Mayuscula(this object? value)
    {
        return value?.ToString()?.Trim().ToUpper();
    }

    public static string? Minuscula(this object? value)
    {
        return value?.ToString()?.Trim().ToLower();
    }

    public static string? NombresAltasYBajas(this object? xObjValue)
    {
        if (xObjValue is null) return null;

        string[] palabras = xObjValue.ToString()!.ToLower().Split(' ', StringSplitOptions.RemoveEmptyEntries);

        for (int i = 0; i < palabras.Length; i++)
        {
            if (palabras[i].Length > 2 && palabras[i] != "del")
            {
                palabras[i] = char.ToUpper(palabras[i][0]) + palabras[i][1..];
            }
        }

        return string.Join(' ', palabras);
    }

    public static string? PriLetraMayuscula(this object? value)
    {
        if (value is null) return null;
        return CultureInfo.InvariantCulture.TextInfo.ToTitleCase(value.ToString()!.ToLower());
    }

    public static string? SinAcento(this object? value)
    {
        if (value is null) return null;

        string texto = value.ToString()!;
        StringBuilder result = new(texto.Length);

        foreach (char c in texto)
        {
            result.Append(AccentMap.TryGetValue(c, out string? replacement) ? replacement : c.ToString());
        }

        return result.ToString().Trim();
    }

    public static string? Text(this object? objValue, int qtCaracter = 0, string? txRellenaCharacter = null)
    {
        if (objValue is null) return null;

        string texto = objValue.ToString()!.Trim();
        int longitud = texto.Length;

        // Truncar si excede el límite
        if (qtCaracter > 0 && longitud > qtCaracter)
        {
            texto = texto[..qtCaracter] + "...";
        }

        // Aplicar relleno si se especifica
        if (!string.IsNullOrEmpty(txRellenaCharacter))
        {
            char charRelleno = txRellenaCharacter[0];
            int longitudObjetivo = Math.Abs(qtCaracter);

            if (longitud <= longitudObjetivo)
            {
                texto = qtCaracter >= 0
                    ? texto.PadRight(longitudObjetivo, charRelleno)
                    : texto.PadLeft(longitudObjetivo, charRelleno);
            }
        }

        return texto;
    }

    public static string RandomString(int length,
        string allowedChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")
    {
        if (length < 0)
            throw new ArgumentOutOfRangeException(nameof(length), "length cannot be less than zero.");
        if (string.IsNullOrEmpty(allowedChars))
            throw new ArgumentException("allowedChars may not be empty.", nameof(allowedChars));

        const int byteSize = 0x100;
        char[] allowedCharSet = new HashSet<char>(allowedChars).ToArray();

        if (byteSize < allowedCharSet.Length)
            throw new ArgumentException($"allowedChars may contain no more than {byteSize} characters.");

        using var rng = RandomNumberGenerator.Create();
        StringBuilder result = new(length);
        byte[] buffer = new byte[128];

        while (result.Length < length)
        {
            rng.GetBytes(buffer);
            foreach (byte b in buffer)
            {
                if (result.Length >= length) break;

                int outOfRangeStart = byteSize - (byteSize % allowedCharSet.Length);
                if (b < outOfRangeStart)
                {
                    result.Append(allowedCharSet[b % allowedCharSet.Length]);
                }
            }
        }

        return result.ToString();
    }

    public static string? Text(this DateTime? fecha, string formato)
    {
        return fecha?.ToString(formato);
    }

    public static string? Text(this IDataReader dr, string field) => Text(dr[field]);
    public static string? Text(this DataRowView dr, string field) => Text(dr[field]);
    public static string? Text(this DataRow dr, string field) => Text(dr[field]);
    public static string? Text(this IDictionary dr, string field) => Text(dr[field]);

    public static string CerosIzquierda(this object? obj, int qtCero)
    {
        string texto = obj?.ToString() ?? "0";
        return texto.PadLeft(qtCero, '0');
    }

    public static string Traslado(string? xStrCad)
    {
        if (string.IsNullOrEmpty(xStrCad)) return string.Empty;

        StringBuilder result = new(xStrCad.Length);

        foreach (char c in xStrCad)
        {
            result.Append(HtmlEntityMap.TryGetValue(c, out string? entity) ? entity : c.ToString());
        }

        return result.ToString();
    }

    public static string RemoveDiacritics(this string s)
    {
        if (string.IsNullOrEmpty(s)) return s;

        StringBuilder result = new(s.Length);

        foreach (char c in s)
        {
            bool found = false;
            foreach (var entry in ForeignCharacters)
            {
                if (entry.Key.Contains(c))
                {
                    result.Append(entry.Value);
                    found = true;
                    break;
                }
            }

            if (!found) result.Append(c);
        }

        return result.ToString();
    }

    public static string RestringeASCII(this string s, int tamano = -1)
    {
        // Reemplazar múltiples espacios con uno solo usando Regex
        s = Regex.Replace(s, @"\s+", " ");

        byte[] asciiBytes = Encoding.ASCII.GetBytes(s);
        StringBuilder resultado = new();

        foreach (byte c in asciiBytes)
        {
            if ((c >= 48 && c <= 57) ||   // 0-9
                (c >= 65 && c <= 90) ||   // A-Z
                (c >= 97 && c <= 122) ||  // a-z
                c == 32)                   // espacio
            {
                resultado.Append((char)c);
            }
        }

        // Truncar si excede el tamaño
        if (tamano > 0 && resultado.Length > tamano)
        {
            resultado.Length = tamano;
        }

        return resultado.ToString();
    }
}