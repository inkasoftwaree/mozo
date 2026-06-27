using Mozo.MaestroData;
using Mozo.Model.Maestro;

namespace Mozo.MaestroBusiness;

public interface ITipoParticularBusiness
{
    Task<int> InsertAsync(TipoParticularModel c);
    Task UpdateAsync(TipoParticularModel c);
    Task UpdateStateAsync(TipoParticularModel c);
    Task UpdateCommandAsync(TipoParticularModel c);
    Task UpdateDefaultAsync(TipoParticularModel c);

    Task DeleteByIdAsync(TipoParticularFilterDto c);
    Task<IEnumerable<TipoParticularModel>> SelAllAsync(TipoParticularFilterDto c);
    Task<IEnumerable<TipoParticularModel>> SelAllChildrenAsync(TipoParticularFilterDto c);
    Task<IEnumerable<TipoParticularModel>> SelAllActiveFatherAndChildrenAsync(TipoParticularFilterDto c);
    Task<IEnumerable<TipoParticularModel>> SelAllActiveGroupsByModuleAsync(TipoParticularFilterDto c);
    Task<TipoParticularModel?> SelByIdAsync(TipoParticularFilterDto c);
    Task<TipoParticularModel?> SelByIdGroupAsync(TipoParticularFilterDto c);
    Task<IEnumerable<TipoParticularModel>> SelAllActiveAsync(TipoParticularFilterDto c);
    Task<IEnumerable<TipoParticularModel>> SelAllActiveChildrenAsync(TipoParticularFilterDto c);
    Task<int> SelOrderNextAsync(TipoParticularFilterDto c);
    Task<TipoParticularModel?> SelDefaultAsync(TipoParticularFilterDto c);
}
public class TipoParticularBusiness : ITipoParticularBusiness
{
    private readonly ITipoParticularData _data;
    public TipoParticularBusiness(ITipoParticularData data)
    {
        _data = data;
    }

    public async Task<int> InsertAsync(TipoParticularModel c) => await _data.InsertAsync(c);
    public async Task UpdateCommandAsync(TipoParticularModel c) => await _data.UpdateCommandAsync(c);
    public async Task UpdateAsync(TipoParticularModel c) => await _data.UpdateAsync(c);
    public async Task UpdateStateAsync(TipoParticularModel c) => await _data.UpdateStateAsync(c);
    public async Task UpdateDefaultAsync(TipoParticularModel c) => await _data.UpdateDefaultAsync(c);
    public async Task DeleteByIdAsync(TipoParticularFilterDto c) => await _data.DeleteByIdAsync(c);
    public async Task<IEnumerable<TipoParticularModel>> SelAllAsync(TipoParticularFilterDto c)
    {
        IEnumerable<TipoParticularModel> r = await _data.SelAllAsync(c);
        return r.OrderBy(s => s.NuOrden);
    }

    public async Task<IEnumerable<TipoParticularModel>> SelAllActiveAsync(TipoParticularFilterDto c)
    {
        IEnumerable<TipoParticularModel> r = await _data.SelAllActiveAsync(c);
        return r.OrderBy(s => s.NuOrden).ToList();
    }
    public async Task<IEnumerable<TipoParticularModel>> SelAllActiveChildrenAsync(TipoParticularFilterDto c)
    {
        IEnumerable<TipoParticularModel> r = await _data.SelAllActiveChildrenAsync(c);
        return r.OrderBy(s => s.NuOrden).ThenBy(s => s.NuSubOrden).ToList();
    }
    public async Task<IEnumerable<TipoParticularModel>> SelAllActiveFatherAndChildrenAsync(TipoParticularFilterDto c)
    {
        IEnumerable<TipoParticularModel> r = await _data.SelAllActiveFatherAndChildrenAsync(c);
        return r.OrderBy(s => s.NuOrden).ThenBy(s => s.NoTipo).ThenBy(s => s.NuSubOrden);
    }
    public async Task<IEnumerable<TipoParticularModel>> SelAllActiveGroupsByModuleAsync(TipoParticularFilterDto c)
    {
        IEnumerable<TipoParticularModel> r = await _data.SelAllActiveGroupsByModuleAsync(c);
        return r.OrderBy(s => s.NuOrden);
    }
    public async Task<IEnumerable<TipoParticularModel>> SelAllChildrenAsync(TipoParticularFilterDto c)
    {
        IEnumerable<TipoParticularModel> r = await _data.SelAllChildrenAsync(c);
        return r.OrderBy(s => s.NuOrden);
    }
    public async Task<TipoParticularModel?> SelByIdAsync(TipoParticularFilterDto c) => await _data.SelByIdAsync(c);
    public async Task<int> SelOrderNextAsync(TipoParticularFilterDto c) => await _data.SelOrderNextAsync(c);
    public async Task<TipoParticularModel?> SelByIdGroupAsync(TipoParticularFilterDto c) => await _data.SelByIdGroupAsync(c);
    
    public async Task<TipoParticularModel?> SelDefaultAsync(TipoParticularFilterDto c) => await _data.SelDefaultAsync(c);


}
