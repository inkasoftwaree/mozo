namespace Mozo.Domain.Catalogo;

[Serializable]
public partial class ProductoAtributoEntity : BaseEntity //<ProductoAtributoModel>
{
    public int? CoProductoAtributo { get; set; }
    public int? CoProducto { get; set; }
    public int? CoAtributo { get; set; }
    public string? NoValor { get; set; }
}

public partial class ProductoAtributoModel
{

}