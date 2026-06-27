using Mozo.MaestroData;
using Mozo.Model.Maestro;

namespace Mozo.MaestroBusiness;

public interface IRedSocialBusiness
{
    Task<int> InsertAsync(EntidadRedSocialModel c);
    Task UpdateAsync(EntidadRedSocialModel c);
    Task DeleteByIdAsync(RedSocialFilterDto c);
    Task<EntidadRedSocialModel?> SelByIdAsync(RedSocialFilterDto c);
    Task<IEnumerable<EntidadRedSocialModel>> SelAllAsync(RedSocialFilterDto c);
}

public class RedSocialBusiness : IRedSocialBusiness
{
    private readonly IRedSocialData _data;
    public RedSocialBusiness(IRedSocialData data)
    {
        _data = data;
    }
    public async Task<int> InsertAsync(EntidadRedSocialModel c) => await _data.InsertAsync(c);
    public async Task UpdateAsync(EntidadRedSocialModel c) => await _data.UpdateAsync(c);
    public async Task DeleteByIdAsync(RedSocialFilterDto c) => await _data.DeleteByIdAsync(c);
    public async Task<IEnumerable<EntidadRedSocialModel>> SelAllAsync(RedSocialFilterDto c) => await _data.SelAllAsync(c);
    public async Task<EntidadRedSocialModel?> SelByIdAsync(RedSocialFilterDto c) => await _data.SelByIdAsync(c);

}
