using Mozo.MaestroData;
using Mozo.Model.Maestro;
///<summary>
///
///</summary>
///<remarks>
///</remarks>
///<history>
/// t[Jonatan Abregu]	18-04-2020	Created
///</history>
namespace Mozo.MaestroBusiness;

public interface IPersonaTipoBusiness
{
    Task<int> InsertAsync(EntidadRolModel c);
    Task UpdateAsync(EntidadRolModel c);
    Task<IEnumerable<EntidadRolModel>> SelAllActiveByPersonAsync(EntidadRolModel c);
    Task<IEnumerable<EntidadRolModel>> SelAllActiveByModuleAndPersonAsync(EntidadRolModel c);
    Task<IEnumerable<EntidadRolModel>> SelAllActiveAsync(EntidadRolModel c);
}

public class PersonaTipoBusiness : IPersonaTipoBusiness
{
    private readonly IPersonaTipoData _data;
    public PersonaTipoBusiness(IPersonaTipoData data)
    {
        _data = data;
    }
    public async Task<int> InsertAsync(EntidadRolModel c) => await _data.InsertAsync(c);
    public async Task UpdateAsync(EntidadRolModel c) => await _data.UpdateAsync(c);
    public async Task<IEnumerable<EntidadRolModel>> SelAllActiveByPersonAsync(EntidadRolModel c) => await _data.SelAllActiveByPersonAsync(c);
    public async Task<IEnumerable<EntidadRolModel>> SelAllActiveByModuleAndPersonAsync(EntidadRolModel c) => await _data.SelAllActiveByModuleAndPersonAsync(c);
    public async Task<IEnumerable<EntidadRolModel>> SelAllActiveAsync(EntidadRolModel c) => await _data.SelAllActiveAsync(c);


}
