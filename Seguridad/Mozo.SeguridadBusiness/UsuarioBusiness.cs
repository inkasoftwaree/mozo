using Mozo.Model.Seguridad;
using Mozo.SeguridadData;

namespace Mozo.SeguridadBusiness;

public interface IUsuarioBusiness
{
    Task<int> InsertAsync(UsuarioModel c);
    Task UpdateAsync(UsuarioModel c);
    Task UpdateClaveAsync(UsuarioModel c);
    Task UpdateStateAsync(UsuarioModel c);
    Task<UsuarioModel?> SelByIdAsync(UsuarioFilterDto c);
}
public class UsuarioBusiness : IUsuarioBusiness
{
    private readonly IUsuarioData _data;
    public UsuarioBusiness(IUsuarioData data)
    {
        _data = data;
    }
    public async Task<int> InsertAsync(UsuarioModel c) => await _data.InsertAsync(c);
    public async Task UpdateAsync(UsuarioModel c) => await _data.UpdateAsync(c);
    public async Task UpdateClaveAsync(UsuarioModel c) => await _data.UpdateClaveAsync(c);
    public async Task UpdateStateAsync(UsuarioModel c) => await _data.UpdateStateAsync(c);
    public async Task<UsuarioModel?> SelByIdAsync(UsuarioFilterDto c) => await _data.SelByIdAsync(c);

}