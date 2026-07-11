
using System.Text.Json.Serialization;
namespace Mozo.Shared.Contract;

public class BaseListItem
{
    public int? FlEstReg { get; set; }

    [JsonIgnore]
    public int? RowsCount { get; set; }
}

