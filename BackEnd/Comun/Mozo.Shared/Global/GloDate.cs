using Mozo.Shared.Enu;
using System.Globalization;
using System.Text;

namespace Mozo.Shared.Global;

public static partial class Glo
{
    private static readonly string[] MesCol =
    {
        "Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio",
        "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"
    };

    private static readonly CultureInfo SpanishCulture = new("es-ES");

    private static (string hora, string meridiano) GetHoraYMeridiano(string hh)
    {
        int? hora = hh.Num();
        if (hora == null) return ("00", "am");

        if (hora == 0) return ("12", "am");
        if (hora < 12) return (hh, "am");
        if (hora == 12) return ("12", "pm");

        return ((hora.Value - 12).CerosIzquierda(2), "pm");
    }

    public static string? FechaBd(this object? xObjValue, string? noHora = null)
    {
        if (xObjValue.EsNulo()) return null;

        string? fecha = xObjValue.Text();
        if (fecha == null) return null;

        string? hora = null;

        switch (fecha.Length)
        {
            case 7:
            case 8:
            case 10:
                fecha = fecha.Replace("-", "");
                hora = noHora;
                break;
            case 16 when fecha.Contains('T'):
                string[] partes = fecha.Replace("-", "").Split('T');
                fecha = partes[0];
                hora = partes[1];
                break;
            case 16:
                fecha = fecha.Replace("-", "");
                break;
            default:
                return null;
        }

        if (!string.IsNullOrWhiteSpace(hora))
        {
            hora = hora.HoraBd();
        }

        return fecha + hora;
    }

    public static string? HoraBd(this object? xObjValue)
    {
        string? texto = xObjValue.Text();
        if (texto == null || texto.Length != 5) return null;

        return texto.Replace(":", "") + "00";
    }

    public static DateTime FechaUtc(this long? unixTimeStamp)
    {
        DateTime epoch = new(1970, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc);
        return epoch.AddSeconds(unixTimeStamp ?? 0);
    }

    public static string?[] InputFecha(this object? xObjValue, bool flDateTimeLocal = false)
    {
        string?[] output = new string?[2];

        if (xObjValue.EsNulo()) return output;

        string? texto = xObjValue.Text();
        if (texto == null) return output;

        switch (texto.Length)
        {
            case 14: // yyyyMMddHHmmss
                string fecha = $"{texto[..4]}-{texto.Substring(4, 2)}-{texto.Substring(6, 2)}";
                string hora = $"{texto.Substring(8, 2)}:{texto.Substring(10, 2)}";

                output[0] = flDateTimeLocal ? $"{fecha}T{hora}" : fecha;
                output[1] = flDateTimeLocal ? null : hora;
                break;

            case 8: // yyyyMMdd
                output[0] = $"{texto[..4]}-{texto.Substring(4, 2)}-{texto.Substring(6, 2)}";
                break;

            case 6: // HHmmss
                output[0] = $"{texto[..2]}:{texto.Substring(2, 2)}";
                break;
        }

        return output;
    }

    public static string? SubtractionDateTime(this string? date1, string? date2)
    {
        if (string.IsNullOrWhiteSpace(date1) || string.IsNullOrWhiteSpace(date2))
            return null;

        date1 = date1.Trim();
        date2 = date2.Trim();

        // Si date1 tiene fecha y date2 solo hora, concatenar fecha de date1
        if (date1.Length == 14 && date2.Length == 6)
        {
            date2 = date1[..8] + date2;
        }

        DateTime dt1 = ParseCustomDateTime(date1);
        DateTime dt2 = ParseCustomDateTime(date2);

        TimeSpan diferencia = dt2.Subtract(dt1);
        StringBuilder sb = new();

        if (diferencia.Days > 0) sb.Append($"{diferencia.Days} día(s) ");
        if (diferencia.Hours > 0) sb.Append($"{diferencia.Hours} hr.(s) ");
        if (diferencia.Minutes > 0) sb.Append($"{diferencia.Minutes} min.(s) ");

        return sb.ToString().Trim();
    }

    private static DateTime ParseCustomDateTime(string dateStr)
    {
        int yyyy = 0, mm = 1, dd = 1, hh = 0, mi = 0, ss = 0;

        switch (dateStr.Length)
        {
            case 8: // yyyyMMdd
                yyyy = int.Parse(dateStr[..4]);
                mm = int.Parse(dateStr.Substring(4, 2));
                dd = int.Parse(dateStr.Substring(6, 2));
                break;

            case 14: // yyyyMMddHHmmss
                yyyy = int.Parse(dateStr[..4]);
                mm = int.Parse(dateStr.Substring(4, 2));
                dd = int.Parse(dateStr.Substring(6, 2));
                hh = int.Parse(dateStr.Substring(8, 2));
                mi = int.Parse(dateStr.Substring(10, 2));
                ss = int.Parse(dateStr.Substring(12, 2));
                break;

            case 6: // HHmmss
                hh = int.Parse(dateStr[..2]);
                mi = int.Parse(dateStr.Substring(2, 2));
                ss = int.Parse(dateStr.Substring(4, 2));
                break;
        }

        return new DateTime(yyyy, mm, dd, hh, mi, ss);
    }

    public static string? FechaHora(this string? xObjValue, int coFormatoFecha = EnuCommon.FormatoFecha.SoloFecha)
    {
        if (string.IsNullOrWhiteSpace(xObjValue)) return null;

        xObjValue = xObjValue.Trim();

        return coFormatoFecha switch
        {
            EnuCommon.FormatoFecha.SoloFecha => FormatSoloFecha(xObjValue),
            EnuCommon.FormatoFecha.SoloHora => FormatSoloHora(xObjValue),
            EnuCommon.FormatoFecha.FechaYHora => FormatFechaYHora(xObjValue),
            EnuCommon.FormatoFecha.FechaNombre => FormatFechaNombre(xObjValue),
            EnuCommon.FormatoFecha.FechaYHoraNombre => FormatFechaYHoraNombre(xObjValue),
            EnuCommon.FormatoFecha.MesAnio => FormatMesAnio(xObjValue),
            EnuCommon.FormatoFecha.MesNombre => FormatMesNombre(xObjValue),
            EnuCommon.FormatoFecha.DiaNombre => FormatDiaNombre(xObjValue),
            EnuCommon.FormatoFecha.DiaNumero => FormatDiaNumero(xObjValue),
            _ => null
        };
    }

    private static string? FormatSoloFecha(string fecha)
    {
        if (fecha.Length < 8) return null;
        return $"{fecha.Substring(6, 2)}/{fecha.Substring(4, 2)}/{fecha[..4]}";
    }

    private static string? FormatSoloHora(string fecha)
    {
        string hh, mi;

        if (fecha.Length == 6)
        {
            hh = fecha[..2];
            mi = fecha.Substring(2, 2);
        }
        else if (fecha.Length >= 14)
        {
            hh = fecha.Substring(8, 2);
            mi = fecha.Substring(10, 2);
        }
        else
        {
            return null;
        }

        var (horaFormateada, meridiano) = GetHoraYMeridiano(hh);
        return $"{horaFormateada}:{mi} {meridiano}";
    }

    private static string? FormatFechaYHora(string fecha)
    {
        if (fecha.Length < 14) return null;

        string yyyy = fecha[..4];
        string mm = fecha.Substring(4, 2);
        string dd = fecha.Substring(6, 2);
        string hh = fecha.Substring(8, 2);
        string mi = fecha.Substring(10, 2);

        var (horaFormateada, meridiano) = GetHoraYMeridiano(hh);
        return $"{dd}/{mm}/{yyyy} {horaFormateada}:{mi} {meridiano}";
    }

    private static string? FormatFechaNombre(string fecha)
    {
        if (fecha.Length < 8) return null;

        int yyyy = int.Parse(fecha[..4]);
        int mm = int.Parse(fecha.Substring(4, 2));
        int dd = int.Parse(fecha.Substring(6, 2));

        DateTime dateValue = new(yyyy, mm, dd);
        string diaNombre = dateValue.ToString("dddd", SpanishCulture);
        string mesNombre = MesCol[mm - 1];

        return $"{diaNombre} {dd} de {mesNombre} del {yyyy}";
    }

    private static string? FormatFechaYHoraNombre(string fecha)
    {
        if (fecha.Length < 14) return null;

        int yyyy = int.Parse(fecha[..4]);
        int mm = int.Parse(fecha.Substring(4, 2));
        int dd = int.Parse(fecha.Substring(6, 2));
        string hh = fecha.Substring(8, 2);
        string mi = fecha.Substring(10, 2);

        DateTime dateValue = new(yyyy, mm, dd);
        string diaNombre = dateValue.ToString("dddd", SpanishCulture);
        string mesNombre = MesCol[mm - 1];

        var (horaFormateada, meridiano) = GetHoraYMeridiano(hh);
        return $"{diaNombre} {dd} de {mesNombre} del {yyyy} {horaFormateada}:{mi} {meridiano}";
    }

    private static string? FormatMesAnio(string fecha)
    {
        if (fecha.Length < 6) return null;

        string yyyy = fecha[..4];
        int mm = int.Parse(fecha.Substring(4, 2));
        string mesNombre = MesCol[mm - 1];

        return $"{mesNombre} del {yyyy}";
    }

    private static string? FormatMesNombre(string fecha)
    {
        if (fecha.Length < 6) return null;

        int mm = int.Parse(fecha.Substring(4, 2));
        return MesCol[mm - 1];
    }

    private static string? FormatDiaNombre(string fecha)
    {
        if (fecha.Length < 8) return null;

        int yyyy = int.Parse(fecha[..4]);
        int mm = int.Parse(fecha.Substring(4, 2));
        int dd = int.Parse(fecha.Substring(6, 2));

        DateTime dateValue = new(yyyy, mm, dd);
        return dateValue.ToString("dddd", SpanishCulture);
    }

    private static string? FormatDiaNumero(string fecha)
    {
        if (fecha.Length < 8) return null;
        return fecha.Substring(6, 2);
    }
}