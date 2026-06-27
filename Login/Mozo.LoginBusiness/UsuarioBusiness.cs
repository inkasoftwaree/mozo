using Mozo.Helper.Global;
using Mozo.LoginData;
using Mozo.Model.Seguridad;

namespace Mozo.LoginBusiness;

public interface IUsuarioBusiness
{
    Task<UsuarioModel?> SelByUserAsync(UsuarioFilterDto c);
    Task<UsuarioModel?> SelByIdAsync(UsuarioFilterDto c);
    Task<UsuarioModel?> SelByEmpresaAsync(UsuarioFilterDto c);
}
public class UsuarioBusiness : IUsuarioBusiness
{
    private readonly IUsuarioData _data;
    public UsuarioBusiness(IUsuarioData data, UserContext user)
    {
        _data = data;
    }

    public async Task<UsuarioModel?> SelByIdAsync(UsuarioFilterDto c) => await _data.SelByIdAsync(c);
    public async Task<UsuarioModel?> SelByUserAsync(UsuarioFilterDto c) => await _data.SelByUserAsync(c);
    public async Task<UsuarioModel?> SelByEmpresaAsync(UsuarioFilterDto c) => await _data.SelByEmpresaAsync(c);
   

}
