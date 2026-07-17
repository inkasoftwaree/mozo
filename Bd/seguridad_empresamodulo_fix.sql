--
-- Fix: seguridad.fn_empresamodulo_insert idempotente + drop de índice redundante
--
-- Con el nuevo UNIQUE(coempresa, comodulo), el alta de empresa fallaba: los
-- módulos se insertan por dos caminos (suscripcion.fn_suscripcion_insert los
-- proyecta del plan, y luego el orquestador llama fn_empresamodulo_insert). El
-- INSERT plano chocaba con el UNIQUE -> duplicate key. Se hace idempotente con
-- ON CONFLICT, devolviendo el id existente si ya estaba.
--
-- Además se elimina el índice seguridad_segempresamodulo_empresa_uk
-- (coempresa, coempresamodulo): redundante desde que existe el UNIQUE real
-- (coempresa, comodulo), que además cubre el lookup por coempresa.
--

SET client_min_messages = warning;

CREATE OR REPLACE FUNCTION seguridad.fn_empresamodulo_insert(p_coempresa bigint, p_comodulo bigint) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
DECLARE v_coempresamodulo bigint;
BEGIN
    INSERT INTO seguridad.segempresamodulo (coempresa, comodulo)
    VALUES (p_coempresa, p_comodulo)
    ON CONFLICT (coempresa, comodulo) DO UPDATE SET comodulo = EXCLUDED.comodulo
    RETURNING coempresamodulo INTO v_coempresamodulo;
    RETURN v_coempresamodulo;
END;
$$;

ALTER FUNCTION seguridad.fn_empresamodulo_insert(p_coempresa bigint, p_comodulo bigint) OWNER TO postgres;

DROP INDEX IF EXISTS seguridad.seguridad_segempresamodulo_empresa_uk;
