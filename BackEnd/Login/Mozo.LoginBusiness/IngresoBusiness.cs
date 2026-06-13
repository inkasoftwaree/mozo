using Mozo.LoginData;
using Mozo.Model.Seguridad;

namespace Mozo.LoginBusiness;

public interface IIngresoBusiness
{
    Task<int> InsertAsync(IngresoModel c);
    Task RevokeAsync(IngresoModel c);
    Task<int> ReplaceAsync(IngresoModel c);
    Task RevokeAllAsync(IngresoModel c);
    Task<IngresoModel?> SelByRefreshTokenAsync(IngresoFilterDto c);
}
public class IngresoBusiness : IIngresoBusiness
{
    private readonly IIngresoData _data;
    public IngresoBusiness(IIngresoData data)
    {
        _data = data;
    }
    public async Task<int> InsertAsync(IngresoModel c) => await _data.InsertAsync(c);
    public async Task RevokeAsync(IngresoModel c) => await _data.RevokeAsync(c);

    public async Task<int> ReplaceAsync(IngresoModel c) => await _data.ReplaceAsync(c);
    public async Task RevokeAllAsync(IngresoModel c) => await _data.RevokeAllAsync(c);
    public async Task<IngresoModel?> SelByRefreshTokenAsync(IngresoFilterDto c) => await _data.SelByRefreshTokenAsync(c);

}