using Mozo.Infrastructure.Persistence.Objects;

namespace Mozo.App.Catalogo.ProductoAtributo;

public static class ProductoAtributoDbObjects
{
    private const string Schema = "catalogo";
    private static readonly DbObjectFactory.StandardDbObjects _std = DbObjectFactory.Standard(Schema, "productoatributo");

    public static DbObject Insert => _std.Insert;
    public static DbObject UpdateById => _std.UpdateById;
    public static DbObject UpdateStateById => _std.UpdateStateById;
    public static DbObject DeleteById => _std.DeleteById;
    public static DbObject SelById => _std.SelById;
    public static DbObject SelAll => _std.SelAll;

    public static readonly DbObject SelAllActive =
        new(Schema, "fn_productoatributo_sel_all_active", DbExecutionType.Select, DbReturnType.List);
}
