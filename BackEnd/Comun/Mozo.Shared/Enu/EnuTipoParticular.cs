
namespace Mozo.Shared.Enu;

public static class EnuTipoParticular
{
    public static class Maestro
    {
        public static class Rubro
        {
            public static readonly int CoModulo = EnuSeguridad.Modulo.Maestro.CoModulo;
            public static readonly int CoGrupo = 2;
        };
        public static class PersonaDescendiente
        {
            public static readonly int CoModulo = EnuSeguridad.Modulo.Maestro.CoModulo;
            public static readonly int CoGrupo = 3;
        };

        public static class Profesion
        {
            public static readonly int CoModulo = EnuSeguridad.Modulo.Maestro.CoModulo;
            public static readonly int CoGrupo = 6;
        };


        public static class Area
        {
            public static readonly int CoModulo = EnuSeguridad.Modulo.Maestro.CoModulo;
            public static readonly int CoGrupo = 7;
        };


        public static class Sede
        {
            public static readonly int CoModulo = EnuSeguridad.Modulo.Maestro.CoModulo;
            public static readonly int CoGrupo = 34;
        };
    }

    public static class Condominio
    {
        public static class Servicio
        {
            public static readonly int CoModulo = EnuSeguridad.Modulo.Condominio.CoModulo;
            public static readonly int CoGrupo = 9;
        };

    }

    public static class FinanzaPersonal
    {
        public static class Categoria
        {
            public static readonly int CoModulo = EnuSeguridad.Modulo.FinanzaPersonal.CoModulo;
            public static readonly int CoGrupo = 14;
        };
        public static class SubCategoria
        {

            public static readonly int CoModulo = EnuSeguridad.Modulo.FinanzaPersonal.CoModulo;
            public static readonly int CoGrupo = 15;
        };


        public static class CuentaAhorro
        {
            public static readonly int CoModulo = EnuSeguridad.Modulo.FinanzaPersonal.CoModulo;
            public static readonly int CoGrupo = 16;
        };


    }



    public static class Biblioteca
    {
        public static class FormatoMaterial
        {
            public static readonly int CoModulo = EnuSeguridad.Modulo.Biblioteca.CoModulo;
            public static readonly int CoGrupo = 19;
        };


        public static class Idioma
        {
            public static readonly int CoModulo = EnuSeguridad.Modulo.Biblioteca.CoModulo;
            public static readonly int CoGrupo = 20;
        };

        public static class FormaAdquisicion
        {

            public static readonly int CoModulo = EnuSeguridad.Modulo.Biblioteca.CoModulo;
            public static readonly int CoGrupo = 21;
        };

        public static class Periodicidad
        {

            public static readonly int CoModulo = EnuSeguridad.Modulo.Biblioteca.CoModulo;
            public static readonly int CoGrupo = 22;
        };

        public static class Documento
        {

            public static readonly int CoModulo = EnuSeguridad.Modulo.Biblioteca.CoModulo;
            public static readonly int CoGrupo = 23;
        };

        public static class SeccionPeriodico
        {

            public static readonly int CoModulo = EnuSeguridad.Modulo.Biblioteca.CoModulo;
            public static readonly int CoGrupo = 24;
        };
    }

    public static class Soporte
    {
        public static class Categoria
        {

            public static readonly int CoModulo = EnuSeguridad.Modulo.Empresa.CoModulo;
            public static readonly int CoGrupo = 11;
        };


        public static class SubCategoria
        {

            public static readonly int CoModulo = EnuSeguridad.Modulo.Empresa.CoModulo;
            public static readonly int CoGrupo = 12;
        };

        public static class Grupo
        {

            public static readonly int CoModulo = EnuSeguridad.Modulo.Empresa.CoModulo;
            public static readonly int CoGrupo = 13;
        };


    }

    //        Etiqueta	25	-3
    //Servicios	26	-3
    //Área prácticas	27	-3
    //Sub Servicios	31	-3
    public static class Empresa
    {
        public static class Estadistica
        {

            public static readonly int CoModulo = EnuSeguridad.Modulo.Empresa.CoModulo;
            public static readonly int CoGrupo = 1;
        };

        public static class BandejaEtiqueta
        {

            public static readonly int CoModulo = EnuSeguridad.Modulo.Empresa.CoModulo;
            public static readonly int CoGrupo = 25;
        };

        public static class Servicio
        {

            public static readonly int CoModulo = EnuSeguridad.Modulo.Empresa.CoModulo;
            public static readonly int CoGrupo = 26;
        };

        public static class SubServicio
        {

            public static readonly int CoModulo = EnuSeguridad.Modulo.Empresa.CoModulo;
            public static readonly int CoGrupo = 31;
        };

        public static class AreaPractica
        {

            public static readonly int CoModulo = EnuSeguridad.Modulo.Empresa.CoModulo;
            public static readonly int CoGrupo = 27;
        };

        public static class Ventaja
        {

            public static readonly int CoModulo = EnuSeguridad.Modulo.Empresa.CoModulo;
            public static readonly int CoGrupo = 8;
        };
    }


    public static class Expediente
    {
        public static class MateriaExpediente
        {

            public static readonly int CoModulo = EnuSeguridad.Modulo.Expediente.CoModulo;
            public static readonly int CoGrupo = 28;
        };

        public static class Documento
        {

            public static readonly int CoModulo = EnuSeguridad.Modulo.Expediente.CoModulo;
            public static readonly int CoGrupo = 29;
        };

        public static class EstadoExpediente
        {
            public static readonly int CoModulo = EnuSeguridad.Modulo.Expediente.CoModulo;
            public static readonly int CoGrupo = 30;
        };

        public static class SubMateriaExpediente
        {

            public static readonly int CoModulo = EnuSeguridad.Modulo.Expediente.CoModulo;
            public static readonly int CoGrupo = 32;
        };

        public static class ParteExpediente
        {

            public static readonly int CoModulo = EnuSeguridad.Modulo.Expediente.CoModulo;
            public static readonly int CoGrupo = 33;
        };


    }

    public static class Matricula
    {
        public static class GradoAcademico
        {

            public static readonly int CoGrupo = 36;
            public static readonly int CoModulo = EnuSeguridad.Modulo.Matricula.CoModulo;
        };


        public static class Nota
        {

            public static readonly int CoGrupo = 37;
            public static readonly int CoModulo = EnuSeguridad.Modulo.Matricula.CoModulo;
        };

        public static class Horario
        {

            public static readonly int CoGrupo = 38;
            public static readonly int CoModulo = EnuSeguridad.Modulo.Matricula.CoModulo;
        };

        public static class Pension
        {

            public static readonly int CoModulo = EnuSeguridad.Modulo.Matricula.CoModulo;
            public static readonly int CoGrupo = 39;
        };

        public static class CategoriaCurso
        {

            public static readonly int CoModulo = EnuSeguridad.Modulo.Matricula.CoModulo;
            public static readonly int CoGrupo = 40;
        };
        public static class CategoriaCarrera
        {

            public static readonly int CoModulo = EnuSeguridad.Modulo.Matricula.CoModulo;
            public static readonly int CoGrupo = 41;
        };
    }

    public static class Inventario
    {
        public static class ArticuloGrupoSegmento
        {

            public static readonly int CoGrupo = 4;
            public static readonly int CoModulo = EnuSeguridad.Modulo.Inventario.CoModulo;
        };

        public static class ArticuloSegmento
        {

            public static readonly int CoGrupo = 7;
            public static readonly int CoModulo = EnuSeguridad.Modulo.Inventario.CoModulo;
        };
        public static class ArticuloPrecio
        {

            public static readonly int CoGrupo = 49;
            public static readonly int CoModulo = EnuSeguridad.Modulo.Inventario.CoModulo;
        };


        public static class UnidadMedida
        {

            public static readonly int CoGrupo = 44;
            public static readonly int CoModulo = EnuSeguridad.Modulo.Inventario.CoModulo;
        };

        public static class LaboratorioArticulo
        {

            public static readonly int CoGrupo = 46;
            public static readonly int CoModulo = EnuSeguridad.Modulo.Inventario.CoModulo;
        };

    }

    public static class Contabilidad
    {
        public static class Banco
        {

            public static readonly int CoGrupo = 17;
            public static readonly int CoModulo = EnuSeguridad.Modulo.Contabilidad.CoModulo;
        };

        public static class TazaInteres
        {

            public static readonly int CoGrupo = 47;
            public static readonly int CoModulo = EnuSeguridad.Modulo.Contabilidad.CoModulo;

            public const int Tea = 1;
        };
        public static class CuentaContable
        {

            public static readonly int CoGrupo = 48;
            public static readonly int CoModulo = EnuSeguridad.Modulo.Contabilidad.CoModulo;
        };

    }

    public static class Urbano
    {
        public static class ComentarioGestionCobranza
        {

            public static readonly int CoGrupo = 42;
            public static readonly int CoModulo = EnuSeguridad.Modulo.Urbano.CoModulo;
        };
        public static class Bono
        {

            public static readonly int CoGrupo = 5;
            public static readonly int CoModulo = EnuSeguridad.Modulo.Urbano.CoModulo;
        };

        public static class EstadoBono
        {

            public static readonly int CoGrupo = 13;
            public static readonly int CoModulo = EnuSeguridad.Modulo.Urbano.CoModulo;

            public const int Inscrito = 1;
            public const int ElejibleNoEvaluado = 2;
            public const int ElejibleEvaluado = 3;
            public const int NoElejible = 4;
            public const int SolicitudDeExoneración = 5;
        };


    }

    public static class Rrhh
    {
        public static class PerfilPuesto
        {

            public static readonly int CoGrupo = 18;
            public static readonly int CoModulo = EnuSeguridad.Modulo.Rrhh.CoModulo;
        };

    }

}