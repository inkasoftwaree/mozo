--
-- Seed de estados para la Gestión de Suscripciones
-- Tabla: maestro.trftipogeneral (catálogo global de tipos)
--
-- Crea dos grupos nuevos (cogrupo libres, el máximo actual es 39):
--   * cogrupo = 40  -> Estado Suscripción (trial/activa/vencida/suspendida/cancelada)
--   * cogrupo = 41  -> Estado Pago        (pendiente/pagado/fallido/reembolsado)
--
-- Estos son los valores que consumen suscripcion.tblsuscripcion.coestado y
-- suscripcion.tblsuscripcionpago.coestado (FK -> maestro.trftipogeneral).
--
-- Notas:
--   * cotipogeneral es GENERATED ALWAYS AS IDENTITY: NO se fija a mano; lo asigna
--     la identidad. El backend debe resolver el id por nocomando (estable) o por
--     (cogrupo, nuorden), tal como el resto del sistema referencia sus grupos.
--   * Idempotente: cada fila se inserta solo si no existe (cogrupo, nuorden).
--   * comodulo = -100 -> ámbito global de plataforma (igual que otros catálogos
--     maestros como tipos de contacto, redes sociales, grado de instrucción).
--

SET client_min_messages = warning;

-- ============================================================
-- cogrupo 40: Estado Suscripción
-- ============================================================
INSERT INTO maestro.trftipogeneral (cogrupo, nuorden, comodulo, notipo, nosigla, nocomando, flestreg, fldelete, fldefault)
SELECT v.cogrupo, v.nuorden, v.comodulo, v.notipo, v.nosigla, v.nocomando, true, false, v.fldefault
FROM (VALUES
    (40::bigint, 1::smallint, -100::bigint, 'Prueba'::varchar,     '40x1'::varchar, 'suscripcion.estado.prueba'::varchar,     false),
    (40,         2,           -100,         'Activa',              '40x2',          'suscripcion.estado.activa',              true ),
    (40,         3,           -100,         'Vencida',             '40x3',          'suscripcion.estado.vencida',             false),
    (40,         4,           -100,         'Suspendida',          '40x4',          'suscripcion.estado.suspendida',          false),
    (40,         5,           -100,         'Cancelada',           '40x5',          'suscripcion.estado.cancelada',           false)
) AS v(cogrupo, nuorden, comodulo, notipo, nosigla, nocomando, fldefault)
WHERE NOT EXISTS (
    SELECT 1 FROM maestro.trftipogeneral t
    WHERE t.cogrupo = v.cogrupo AND t.nuorden = v.nuorden
);

-- ============================================================
-- cogrupo 41: Estado Pago
-- ============================================================
INSERT INTO maestro.trftipogeneral (cogrupo, nuorden, comodulo, notipo, nosigla, nocomando, flestreg, fldelete, fldefault)
SELECT v.cogrupo, v.nuorden, v.comodulo, v.notipo, v.nosigla, v.nocomando, true, false, v.fldefault
FROM (VALUES
    (41::bigint, 1::smallint, -100::bigint, 'Pendiente'::varchar,   '41x1'::varchar, 'suscripcion.pago.pendiente'::varchar,   true ),
    (41,         2,           -100,         'Pagado',               '41x2',          'suscripcion.pago.pagado',               false),
    (41,         3,           -100,         'Fallido',              '41x3',          'suscripcion.pago.fallido',              false),
    (41,         4,           -100,         'Reembolsado',          '41x4',          'suscripcion.pago.reembolsado',          false)
) AS v(cogrupo, nuorden, comodulo, notipo, nosigla, nocomando, fldefault)
WHERE NOT EXISTS (
    SELECT 1 FROM maestro.trftipogeneral t
    WHERE t.cogrupo = v.cogrupo AND t.nuorden = v.nuorden
);
