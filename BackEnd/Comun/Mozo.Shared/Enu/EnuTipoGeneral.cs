using System.Collections.Immutable;
using static Mozo.Shared.Enu.EnuSeguridad;

namespace Mozo.Shared.Enu;

public static class EnuTipoGeneral
{

    public static readonly ImmutableHashSet<int?> MoreFiles =
    [
        FormatoArchivo.Soportee.Soporte.Sustento,
    FormatoArchivo.Soportee.Seguimiento.Sustento,
    FormatoArchivo.Catalogo.Producto.Imagen
    ];

    public static class FormatoArchivo
    {
        public static readonly int CoGrupo = 6;

        public static class Seguridad
        {
            public static readonly int CoModulo = Modulo.Seguridad.CoModulo;
            public static class Empresa
            {
                public const int Logo = 139;

            }
        };

        public static class Condominio
        {
            public static readonly int CoModulo = Modulo.Condominio.CoModulo;
            public static class Predio
            {
                public const int Minuta = 140;
            }
            public static class PredioAlquiler
            {
                public const int Contrato = 141;
            }
        };

        public static class Soportee
        {
            public static readonly int CoModulo = Modulo.Soporte.CoModulo;

            public static class Soporte
            {
                public const int Sustento = 142;
            }

            public static class Seguimiento
            {
                public const int Sustento = 82;
            }
        };

        public static class Maestro
        {
            public static readonly int CoModulo = Modulo.Maestro.CoModulo;

            public static class Persona
            {
                public const int Foto = 123;
            }
        };
        public static class Empresa
        {
            public static readonly int CoModulo = Modulo.Empresa.CoModulo;

            public static class Blog
            {
                public const int Imagen = 19;
            }

            public static class Cliente
            {
                public const int Foto = 20;
            }

            public static class Servicio
            {
                public const int Imagen = 81;
            }

            public static class ServicioCaracteristica
            {
                public const int Imagen = 21;
            }

            public static class ImagenWeb
            {
                public const int Imagen = 112;
            }
        };

        public static class Expediente
        {
            public static readonly int CoModulo = Modulo.Expediente.CoModulo;

            public static class Documento
            {
                public const int Escrito = 89;
            }

            public static class Notificacion
            {
                public const int Constancia = 90;
            }
        };

        public static class Matricula
        {
            public static readonly int CoModulo = Modulo.Matricula.CoModulo;

            //matricula.matriculapension.recibo
            public static class MatriculaPension
            {
                public const int Recibo = 113;
            }
        };


        public static class Catalogo
        {
            public static readonly int CoModulo = Modulo.Catalogo.CoModulo;

            public static class Producto
            {
                public const int Imagen = 85;
            }
        };
        public static string GetPath(string? path, int? coEmpresa, int? coEntidad, string? noArchivo)
        {
            ///Document/CoEmpresa/NoEsquema/NoEntidad/CoEntidad/TipoImagen/nameFile.jpg            
            string[] pathSplit = path!.Split(".");
            return $"{coEmpresa}/{pathSplit[0]}/{pathSplit[1]}/{coEntidad}/{pathSplit[3]}/{noArchivo}";

        }

    };


    public static class Rol
    {
        public static readonly int CoGrupo = 11;

        public static class Seguridad
        {
            public static readonly int CoModulo = EnuSeguridad.Modulo.Seguridad.CoModulo;
            public const int Sistema = 14;
        };
        public static class Condominio
        {
            public static readonly int CoModulo = EnuSeguridad.Modulo.Condominio.CoModulo;
            public const int Inquilino = 15;
            public const int Propietario = 16;
        };
        public static class FinanzaPersonal
        {
            public static readonly int CoModulo = EnuSeguridad.Modulo.FinanzaPersonal.CoModulo;
            public const int Beneficiario = 94;
            public const int Proveedor = 95;
        };
        public static class Soporte
        {
            public static readonly int CoModulo = EnuSeguridad.Modulo.Soporte.CoModulo;
            public const int Cliente = 93;
        };

        public static class Expediente
        {
            public static readonly int CoModulo = EnuSeguridad.Modulo.Expediente.CoModulo;
            public const int Abogado = 96;
            public const int Notificado = 70;
            public const int Parte = 75;
        };

        public static class Empresa
        {
            public static readonly int CoModulo = EnuSeguridad.Modulo.Empresa.CoModulo;
            public const int Bloguero = 64;
            public const int Cliente = 69;
            public const int Equipo = 100;
        };

        public static class Matricula
        {
            public static readonly int CoModulo = EnuSeguridad.Modulo.Matricula.CoModulo;
            public const int Alumno = 76;
            public const int Profesor = 77;
        };

        public static class Facturacion
        {
            public static readonly int CoModulo = EnuSeguridad.Modulo.Facturacion.CoModulo;
            public const int Proveedor = 78;
            public const int Cliente = 97;
            public const int Vendedor = 101;

        };

        public static class Urbano
        {
            public static readonly int CoModulo = EnuSeguridad.Modulo.Urbano.CoModulo;
            public const int Cliente = 98;
            public const int Vendedor = 99;
            public const int Entidad = 125;
        };

        public static class Maestro
        {
            public static readonly int CoModulo = EnuSeguridad.Modulo.Maestro.CoModulo;
            public const int Entidad = 124;
            public const int Contacto = 174;
        };
    };

    public static class Catalogo
    {
        public static class Producto
        {
            public static readonly int CoModulo = EnuSeguridad.Modulo.Catalogo.CoModulo;
            public static readonly int CoGrupo = 2;

            public const int BienesTangibles = 83;
            public const int Servicios = 171;
            public const int Consumible = 84;
            public const int Compuestos = 91;
            public const int Virtuales = 92;
        };
    }
    public static class Maestro
    {
        public static class EstadoCivil
        {
            public static readonly int CoModulo = EnuSeguridad.Modulo.Maestro.CoModulo;
            public static readonly int CoGrupo = 73;

        };
        public static class EstadoRegistro
        {
            public static readonly int CoModulo = EnuSeguridad.Modulo.Maestro.CoModulo;
            public static readonly int CoGrupo = 156;
        };

        public static class EtiquetaRedSocial
        {
            public static readonly int CoModulo = EnuSeguridad.Modulo.Maestro.CoModulo;
            public static readonly int CoGrupo = 71;

            public const int Trabajo = 72;
            public const int Personal = 154;
            public const int Otro = 155;
        };
        public static class RedSocial
        {
            public static readonly int CoModulo = EnuSeguridad.Modulo.Maestro.CoModulo;
            public static readonly int CoGrupo = 25;

            public const int TelefonoMovil = 34;
            public const int CorreoElectronico = 35;
            public const int TelefonoFijo = 36;
            public const int Url = 37;

        };
        public static class UrlRedSocial
        {
            public static readonly int CoModulo = EnuSeguridad.Modulo.Maestro.CoModulo;
            public static readonly int CoGrupo = 27;

            public const int PaginaWeb = 38;
            public const int Facebook = 39;
            public const int X = 40;
            public const int Youtube = 41;
            public const int LinkedLn = 42;
            public const int Instagram = 43;
            public const int Tiktok = 44;
        };

        public static class Tabla
        {
            public static readonly int CoModulo = EnuSeguridad.Modulo.Maestro.CoModulo;
            public static readonly int CoGrupo = 38;

            public const int Maestro_Entidad = 17;
            public const int Seguridad_Empresa = 18;
            public const int Empresa_Blog = 106;
            public const int Empresa_Cliente = 107;
            public const int Empresa_Imagenweb = 109;
            public const int Empresa_ServicioCaracteristica = 110;
            public const int Condominio_Predio = 111;
            public const int Condominio_PredioAlquiler = 7;
            public const int Soporte_Soporte = 6;
            public const int Soporte_Seguimiento = 5;
            public const int Catalogo_Producto = 4;
            public const int Expediente_Documento = 161;
            public const int Expediente_Notificacion = 160;
            public const int Matricula_MatriculaPension = 159;




        };


    }


    public static class Seguridad
    {
        public static class Pagina
        {
            public static readonly int CoModulo = EnuSeguridad.Modulo.Seguridad.CoModulo;
            public static readonly int CoGrupo = 7;

            public const int Menu = 9;
            public const int Paginaa = 150;
            public const int SubPagina = 151;
            public const int VistaFlotante = 152;
            public const int ServicioWeb = 153;
        };

    }

    public static class Urbano
    {
        public static class Cuota
        {
            public static readonly int CoModulo = EnuSeguridad.Modulo.Urbano.CoModulo;
            public static readonly int CoGrupo = 28;

            public const int Inicial = 45;
            public const int Separación = 46;
            public const int Penalidad = 47;
            public const int Abono = 48;
            public const int CuotaAutomatico = 49; //Cuota Automatica
            public const int CuotaManual = 50; //Cuota Automatica
        };

        public static class Manzana
        {
            public static readonly int CoModulo = EnuSeguridad.Modulo.Urbano.CoModulo;
            public static readonly int CoGrupo = 32;

            public const int Lote = 56;
            public const int Jardin = 57;
            public const int Mercado = 58;
            public const int Colegio = 59;
            public const int Universidad = 60;
        };

        public static class MotivoAnulacionCredito
        {
            public static readonly int CoModulo = EnuSeguridad.Modulo.Urbano.CoModulo;
            public static readonly int CoGrupo = 31;

            public const int CambioTitularidad = 53;
            public const int CambioInmueble = 54;
            public const int DesistioCompra = 55;
        };


    }

    public static class Condominio
    {
        public static class CalculoServicio
        {
            public static readonly int CoModulo = EnuSeguridad.Modulo.Condominio.CoModulo;
            public static readonly int CoGrupo = 8;

            public const int Calculo1 = 10;
            public const int Calculo2 = 11;
            public const int Calculo3 = 12;
            public const int Calculo4 = 104;
            public const int Calculo5 = 103;
            public const int Calculo6 = 104;
            public const int Calculo7 = 105;
            public const int Calculo8 = 13;
        };

        public static class Predio
        {
            public static readonly int CoModulo = EnuSeguridad.Modulo.Condominio.CoModulo;
            public static readonly int CoGrupo = 9;

            public const int Condominio = 162;
            public const int Edificio = 163;
            public const int Apartamento = 2;
            public const int Cochera = 3;
        };

    }

    public static class Contabilidad
    {
        public static class AmbitoDocumentoIdentificacion
        {
            public static readonly int CoModulo = EnuSeguridad.Modulo.Contabilidad.CoModulo;
            public static readonly int CoGrupo = 12;

            public const int PersonaNatural = 61;
            public const int PersonaJuridica = 62;
            public const int Ambos = 63;

        };

        /*De aca para abajo falta ubicar el codigo*/
        public static class DocumentoTributario
        {
            public static readonly int CoModulo = EnuSeguridad.Modulo.Contabilidad.CoModulo;
            public static readonly int CoGrupo = 13;

            public const int Factura = 1;
            public const int Boleta = 3;
            public const int NotaCredito = 7;
            public const int NotaDebito = 8;
            public const int TicketMaquinaRegistradora = 12;
        };


        public static class DocumentoTributarioInventario
        {
            public static readonly int CoModulo = EnuSeguridad.Modulo.Contabilidad.CoModulo;
            public static readonly int CoGrupo = 20;
        };

        public static class DocumentoTributarioTransporteCompraVenta
        {
            public static readonly int CoModulo = EnuSeguridad.Modulo.Contabilidad.CoModulo;
            public static readonly int CoGrupo = 21;
        };

        public static class OperacionVenta
        {
            public static readonly int CoModulo = EnuSeguridad.Modulo.Contabilidad.CoModulo;
            public static readonly int CoGrupo = 14;
        };

        public static class ModoPago
        {
            public static readonly int CoModulo = EnuSeguridad.Modulo.Contabilidad.CoModulo;
            public static readonly int CoGrupo = 15;

            public const int Credito = 1;
            public const int Contado = 2;
        };

        public static class MedioPago
        {
            public static readonly int CoModulo = EnuSeguridad.Modulo.Contabilidad.CoModulo;
            public static readonly int CoGrupo = 16;

            public const int DepositoCuenta = 1;
            public const int Giro = 2;
            public const int Transferencias = 3;
            public const int OrdenPago = 4;
            public const int TarjetaDebito = 5;
            public const int TarjetaCredito = 6;
            public const int Cheque = 7;
            public const int Efectivo = 8;
            public const int EfectivoOperaciones = 9;
            public const int OtrosMedios = 999;
        };




        public static class Impuesto
        {
            public static readonly int CoModulo = EnuSeguridad.Modulo.Contabilidad.CoModulo;
            public static readonly int CoGrupo = 30;

            public const int IGV = 1;
            public const int ITF = 2;
        };


        public static class NotaCredito
        {
            public static readonly int CoModulo = EnuSeguridad.Modulo.Contabilidad.CoModulo;
            public static readonly int CoGrupo = 33;

            public const int AnulacioDeLaOperacion = 1;
            public const int AnulacionPorErrorEnElRUC = 2;
            public const int CorreccionPorErrorEnLaDescripción = 3;
            public const int DescuentoGlobal = 4;
            public const int DescuentoPorItem = 5;
            public const int DevolucionTotal = 6;
            public const int DevolucionParcial = 7;
            public const int Bonificacion = 8;
            public const int DisminucionEnElValor = 9;
        };







    }

    public static class Inventario
    {
        public static class TipoInventario
        {
            public static readonly int CoModulo = EnuSeguridad.Modulo.Inventario.CoModulo;
            public static readonly int CoGrupo = 19;
        };


    }
}
