using System.Data;

namespace Mozo.Infrastructure.Persistence;

internal sealed class TransactionContext
{
    public IDbTransaction? CurrentTransaction { get; set; }

    public bool HasTransaction => CurrentTransaction is not null;
}