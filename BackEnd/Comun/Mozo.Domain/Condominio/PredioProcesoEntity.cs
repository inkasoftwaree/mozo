namespace Mozo.Domain.Condominio;



[Serializable]
public class PredioProcesoEntity
{
    public int? IngresaLecturaActual { get; set; }
    public int? EditaMonto { get; set; }
    public int? RecalculoMontoPorCambioLecturaActual { get; set; }
}