--
-- Estado de suscripción de una empresa, para la respuesta del login.
-- Schema: suscripcion
--
-- Devuelve SIEMPRE exactamente una fila (aunque la empresa no tenga suscripción)
-- para que el front pueda rutear sin ambigüedad:
--   flexiste = 0        -> la empresa nunca contrató (pantalla de alta de plan)
--   flacceso = 1        -> suscripción vigente (app normal)
--   flacceso = 0        -> vencida/suspendida (pantalla de renovación)
--   esowner  = 1        -> el usuario es el dueño (mostrar CTA "Renovar/Pagar")
--
-- flacceso usa el MISMO criterio que el gate de módulos (fn_empresa_modulo_habilitado):
-- flvigente + estado != suspendida + fefin >= hoy.
--

SET check_function_bodies = false;
SET client_min_messages = warning;

CREATE FUNCTION suscripcion.fn_empresa_suscripcion_estado(p_coempresa bigint, p_cousuario bigint)
    RETURNS TABLE(flexiste integer, cosuscripcion bigint, coestado bigint, noestado character varying, fefin date, diasrestantes integer, flacceso integer, esowner integer)
    LANGUAGE plpgsql
    AS $$
DECLARE v_esowner integer;
BEGIN
    SELECT CASE WHEN e.cousuario_owner = p_cousuario THEN 1 ELSE 0 END
    INTO v_esowner
    FROM seguridad.tblempresa e
    WHERE e.coempresa = p_coempresa;

    RETURN QUERY
    SELECT
        1,
        s.cosuscripcion,
        s.coestado,
        t.notipo,
        s.fefin,
        (s.fefin - CURRENT_DATE)::int,
        CASE WHEN s.fefin >= CURRENT_DATE
              AND s.coestado <> (SELECT cotipogeneral FROM maestro.trftipogeneral
                                 WHERE nocomando = 'suscripcion.estado.suspendida')
             THEN 1 ELSE 0 END,
        COALESCE(v_esowner, 0)
    FROM suscripcion.tblsuscripcion s
    JOIN maestro.trftipogeneral t ON t.cotipogeneral = s.coestado
    WHERE s.coempresa = p_coempresa AND s.flvigente = true AND s.flestreg = true;

    -- empresa sin suscripción: fila única con flexiste = 0
    IF NOT FOUND THEN
        RETURN QUERY SELECT 0, NULL::bigint, NULL::bigint, NULL::character varying,
                            NULL::date, NULL::int, 0, COALESCE(v_esowner, 0);
    END IF;
END;
$$;

ALTER FUNCTION suscripcion.fn_empresa_suscripcion_estado(p_coempresa bigint, p_cousuario bigint) OWNER TO postgres;
