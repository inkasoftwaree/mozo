using System.Collections;
using System.Data;
using System.Data.Common;
using System.Globalization;

namespace Mozo.Shared.Global;

public static partial class Glo
{
    private static readonly CultureInfo PeruvianCulture = new("es-PE")
    {
        NumberFormat =
        {
            CurrencyDecimalSeparator = ".",
            CurrencyGroupSeparator = ".",
            NumberDecimalSeparator = ".",
            PercentDecimalSeparator = "."
        }
    };

    public static int? Num(this object? value)
    {
        if (value is null || value is DBNull) return null;

        string str = value.ToString()?.Trim() ?? string.Empty;
        if (string.IsNullOrWhiteSpace(str)) return null;

        if (value.GetType().BaseType?.FullName == "System.Enum")
            return Convert.ToInt32(value);

        return int.TryParse(str, out int result) ? result : null;
    }

    public static int? Num(this DbDataReader? dr, string field) => Num(dr?[field]);
    public static int? Num(this IDataReader? dr, string field) => Num(dr?[field]);
    public static int? Num(this DataRowView? dr, string field) => Num(dr?[field]);
    public static int? Num(this DataRow? dr, string field) => Num(dr?[field]);
    public static int? Num(this IDictionary? dr, string field) => Num(dr?[field]);

    public static decimal Deci(this object? value)
    {
        if (value is null || value is DBNull) return 0;

        string str = value.ToString()?.Trim() ?? string.Empty;
        if (string.IsNullOrWhiteSpace(str)) return 0;

        decimal.TryParse(str, NumberStyles.Any, PeruvianCulture, out decimal result);
        return result;
    }

    public static decimal Deci(this IDataReader dr, string field) => Deci(dr[field]);

    public static string NumFormat(this object? value, int qtDecimal = 2)
    {
        if (value is null || value is DBNull) return string.Empty;

        string str = value.ToString()?.Trim() ?? string.Empty;
        if (string.IsNullOrWhiteSpace(str)) return string.Empty;

        string formato = qtDecimal > 0
            ? $"#,##0.{new string('0', qtDecimal)}"
            : "#,##0";

        return string.Format($"{{0:{formato}}}", value);
    }

    public static string NumFormatExcel(this object? value, int qtDecimal = 2, bool round = false)
    {
        if (value is null || value is DBNull) return string.Empty;

        string str = value.ToString()?.Trim() ?? string.Empty;
        if (string.IsNullOrWhiteSpace(str)) return string.Empty;

        object valorFormateado = value;
        if (round && value is decimal decValue)
        {
            valorFormateado = Math.Round(decValue, 1);
        }

        string formato = qtDecimal > 0
            ? $"0.{new string('0', qtDecimal)}"
            : "0";

        return string.Format($"{{0:{formato}}}", valorFormateado);
    }

    public static bool EsNumero(this object? value)
    {
        string? texto = value?.ToString();
        return int.TryParse(texto, out _) || decimal.TryParse(texto, out _);
    }
}