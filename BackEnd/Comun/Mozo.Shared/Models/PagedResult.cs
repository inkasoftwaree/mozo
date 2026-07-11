namespace Mozo.Shared.Models;

public sealed class PagedResult<T>
{
    public IReadOnlyCollection<T> Items { get; init; }
        = [];

    public int TotalRows { get; init; }

    public int PageIndex { get; init; }

    public int PageSize { get; init; }

    public int TotalPages =>
        TotalRows == 0
            ? 0
            : (int)Math.Ceiling((double)TotalRows / PageSize);
}