--
-- Control de acceso a módulos según el plan de suscripción
-- Schema: suscripcion
--
-- Gate a NIVEL EMPRESA, independiente del control por usuario del admin.
-- IMPORTANTE: NO toca seguridad.segmodulousuario.feexpiracion (eso lo gestiona
-- el admin de la empresa: qué usuarios usan qué módulo y hasta cuándo).
--
-- Acceso efectivo a un módulo = (gate de suscripción)  AND  (asignación del admin)
--
-- El gate es DINÁMICO ("caducar por fecha"): concede acceso solo si existe una
-- suscripción vigente (flvigente, no suspendida, fefin >= hoy) cuyo plan incluye
-- el módulo. Al vencer deja de conceder; al renovar vuelve solo, sin borrar nada.
--

SET check_function_bodies = false;
SET client_min_messages = warning;

-- ============================================================
-- fn_empresa_modulo_habilitado: fuente de verdad del gate.
-- El backend la llama antes de ejecutar cualquier acción del módulo.
-- ============================================================
CREATE FUNCTION suscripcion.fn_empresa_modulo_habilitado(p_coempresa bigint, p_comodulo bigint) RETURNS boolean
    LANGUAGE sql STABLE
    AS $$
    SELECT EXISTS (
        SELECT 1
        FROM suscripcion.tblsuscripcion s
        JOIN suscripcion.trfplanmodulo pm ON pm.coplan = s.coplan AND pm.flestreg = true
        WHERE s.coempresa = p_coempresa
          AND pm.comodulo = p_comodulo
          AND s.flvigente = true
          AND s.flestreg = true
          AND s.fefin >= CURRENT_DATE
          AND s.coestado <> (SELECT cotipogeneral FROM maestro.trftipogeneral
                             WHERE nocomando = 'suscripcion.estado.suspendida')
    );
$$;

ALTER FUNCTION suscripcion.fn_empresa_modulo_habilitado(p_coempresa bigint, p_comodulo bigint) OWNER TO postgres;


-- ============================================================
-- vw_empresa_modulo_vigente: módulos actualmente habilitados por
-- suscripción válida, por empresa (derivado del plan, en vivo).
-- ============================================================
CREATE VIEW suscripcion.vw_empresa_modulo_vigente AS
 SELECT DISTINCT s.coempresa,
    pm.comodulo,
    m.nomodulo,
    s.cosuscripcion,
    s.coplan,
    s.fefin
   FROM ((suscripcion.tblsuscripcion s
     JOIN suscripcion.trfplanmodulo pm ON (((pm.coplan = s.coplan) AND (pm.flestreg = true))))
     JOIN seguridad.segmodulo m ON (((m.comodulo = pm.comodulo) AND (m.flestreg = true))))
  WHERE ((s.flvigente = true) AND (s.flestreg = true) AND (s.fefin >= CURRENT_DATE)
     AND (s.coestado <> ( SELECT trftipogeneral.cotipogeneral
           FROM maestro.trftipogeneral
          WHERE ((trftipogeneral.nocomando)::text = 'suscripcion.estado.suspendida'::text))));

ALTER VIEW suscripcion.vw_empresa_modulo_vigente OWNER TO postgres;


-- ============================================================
-- fn_empresa_modulo_sel_habilitados: lista los módulos habilitados
-- de una empresa (conveniencia para el backend / armado de menú).
-- ============================================================
CREATE FUNCTION suscripcion.fn_empresa_modulo_sel_habilitados(p_coempresa bigint) RETURNS TABLE(comodulo bigint, nomodulo character varying, fefin date)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT v.comodulo, v.nomodulo, v.fefin
    FROM suscripcion.vw_empresa_modulo_vigente v
    WHERE v.coempresa = p_coempresa
    ORDER BY v.comodulo;
END;
$$;

ALTER FUNCTION suscripcion.fn_empresa_modulo_sel_habilitados(p_coempresa bigint) OWNER TO postgres;


-- ============================================================
-- fn_suscripcion_procesar_vencimientos: job (diario) que marca como
-- 'vencida' las suscripciones activas/prueba cuyo fefin ya pasó, y
-- registra el movimiento en el historial. Mantiene coestado veraz para
-- reportes; el gate ya caduca por fecha aunque esto no corra.
-- Retorna la cantidad de suscripciones vencidas.
-- ============================================================
CREATE FUNCTION suscripcion.fn_suscripcion_procesar_vencimientos() RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_rows integer;
    v_vencida bigint;
    v_activa bigint;
    v_prueba bigint;
    v_movcambio bigint;
BEGIN
    SELECT cotipogeneral INTO v_vencida FROM maestro.trftipogeneral WHERE nocomando = 'suscripcion.estado.vencida';
    SELECT cotipogeneral INTO v_activa  FROM maestro.trftipogeneral WHERE nocomando = 'suscripcion.estado.activa';
    SELECT cotipogeneral INTO v_prueba  FROM maestro.trftipogeneral WHERE nocomando = 'suscripcion.estado.prueba';
    SELECT cotipogeneral INTO v_movcambio FROM maestro.trftipogeneral WHERE nocomando = 'suscripcion.mov.cambioestado';

    -- historial funcional: registrar el vencimiento (estado anterior = actual)
    INSERT INTO suscripcion.tblsuscripcionmovimiento(
        cosuscripcion, coempresa, cotipomovimiento, coestadoanterior, coestadonuevo, fefinanterior, fefinactual, cousucre, txnota)
    SELECT s.cosuscripcion, s.coempresa, v_movcambio, s.coestado, v_vencida, s.fefin, s.fefin, -100, 'Vencimiento automático'
    FROM suscripcion.tblsuscripcion s
    WHERE s.flvigente = true AND s.flestreg = true
      AND s.fefin < CURRENT_DATE
      AND s.coestado IN (v_activa, v_prueba);

    UPDATE suscripcion.tblsuscripcion s
    SET coestado = v_vencida,
        femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    WHERE s.flvigente = true AND s.flestreg = true
      AND s.fefin < CURRENT_DATE
      AND s.coestado IN (v_activa, v_prueba);
    GET DIAGNOSTICS v_rows = ROW_COUNT;

    RETURN v_rows;
END;
$$;

ALTER FUNCTION suscripcion.fn_suscripcion_procesar_vencimientos() OWNER TO postgres;
