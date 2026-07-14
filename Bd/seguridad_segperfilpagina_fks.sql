--
-- Limpieza de FKs redundantes en seguridad.segperfilpagina
--
-- La tabla tenía FKs DUPLICADAS: una versión compuesta (que garantiza la
-- consistencia de módulo) y una simple de una sola columna para la misma
-- relación. Las simples no agregan garantía —ya la dan las compuestas— y solo
-- suman costo de mantenimiento en cada insert. Se eliminan las 3 simples y se
-- conservan las compuestas (+ la de módulo).
--
-- Se conservan:
--   "Seguridad_PerfilPagina_Pagina$_Fk"  (comodulo, comenu, copagina) -> segpagina
--   "Seguridad_PerfilPagina_Menu$_Fk"    (comodulo, comenu)           -> segmenu
--   "Seguridad_PerfilPagina_Perfil$_Fk"  (comodulo, coperfil)         -> segperfil
--   "Seguridad_PerfilPagina_Modulo_Fk"   (comodulo)                   -> segmodulo
--
-- Se eliminan (redundantes):
--   "Seguridad_PerfilPagina_Pagina_Fk"   (copagina)  -> segpagina
--   "Seguridad_PerfilPagina_Menu_Fk"     (comenu)    -> segmenu
--   "Seguridad_PerfilPagina_Perfil_Fk"   (coperfil)  -> segperfil
--

SET client_min_messages = warning;

ALTER TABLE seguridad.segperfilpagina DROP CONSTRAINT IF EXISTS "Seguridad_PerfilPagina_Pagina_Fk";
ALTER TABLE seguridad.segperfilpagina DROP CONSTRAINT IF EXISTS "Seguridad_PerfilPagina_Menu_Fk";
ALTER TABLE seguridad.segperfilpagina DROP CONSTRAINT IF EXISTS "Seguridad_PerfilPagina_Perfil_Fk";

-- Opcional (recomendado a futuro): validar las FKs compuestas contra los datos
-- existentes (hoy están NOT VALID, enforzan solo en filas nuevas). Descomentar
-- tras verificar que no haya datos inconsistentes:
-- ALTER TABLE seguridad.segperfilpagina VALIDATE CONSTRAINT "Seguridad_PerfilPagina_Pagina$_Fk";
-- ALTER TABLE seguridad.segperfilpagina VALIDATE CONSTRAINT "Seguridad_PerfilPagina_Menu$_Fk";
-- ALTER TABLE seguridad.segperfilpagina VALIDATE CONSTRAINT "Seguridad_PerfilPagina_Perfil$_Fk";
