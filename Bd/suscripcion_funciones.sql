--
-- Funciones de la Gestión de Suscripciones
-- Schema: suscripcion
--
-- Sigue el patrón de funciones del proyecto:
--   * insert  -> RETURNS bigint (id nuevo). No audita (usp_auditoria solo corre en 'D').
--   * update / update_state -> RETURNS integer (filas afectadas). Setea femod/cousumod.
--   * delete  -> captura row_to_json y llama seguridad.usp_auditoria(..., 'D', ...).
--   * sel_all -> RETURNS TABLE con paginación (rowscount/pagesize/pageindex).
--   * booleanos de entrada como integer (0/1); de salida casteados a ::int.
--
-- Lógica de negocio clave:
--   fn_suscripcion_insert activa la suscripción y PROYECTA los módulos del plan
--   hacia seguridad.segempresamodulo (punto de enforcement de acceso).
--

SET check_function_bodies = false;
SET client_min_messages = warning;

-- ============================================================
-- trfplan
-- ============================================================

CREATE FUNCTION suscripcion.fn_plan_insert(p_noplan character varying, p_noplandescripcion character varying, p_nuorden smallint, p_nudiasprueba smallint, p_valor jsonb, p_flpublico integer, p_fldefault integer, p_cousucre integer) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
DECLARE v_coplan bigint;
BEGIN
    IF p_fldefault = 1 THEN
        UPDATE suscripcion.trfplan SET fldefault = false WHERE fldefault = true;
    END IF;

    INSERT INTO suscripcion.trfplan(noplan, noplandescripcion, nuorden, nudiasprueba, valor, flpublico, fldefault, cousucre)
    VALUES (p_noplan, p_noplandescripcion, p_nuorden, COALESCE(p_nudiasprueba, 0), p_valor, p_flpublico::bool, p_fldefault::bool, p_cousucre)
    RETURNING coplan INTO v_coplan;
    RETURN v_coplan;
END;
$$;

ALTER FUNCTION suscripcion.fn_plan_insert(p_noplan character varying, p_noplandescripcion character varying, p_nuorden smallint, p_nudiasprueba smallint, p_valor jsonb, p_flpublico integer, p_fldefault integer, p_cousucre integer) OWNER TO postgres;


CREATE FUNCTION suscripcion.fn_plan_update_by_id(p_coplan bigint, p_noplan character varying, p_noplandescripcion character varying, p_nuorden smallint, p_nudiasprueba smallint, p_valor jsonb, p_flpublico integer, p_fldefault integer, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_rows integer;
BEGIN
    IF p_fldefault = 1 THEN
        UPDATE suscripcion.trfplan SET fldefault = false WHERE fldefault = true AND coplan <> p_coplan;
    END IF;

    UPDATE suscripcion.trfplan
    SET noplan = p_noplan,
        noplandescripcion = p_noplandescripcion,
        nuorden = p_nuorden,
        nudiasprueba = COALESCE(p_nudiasprueba, 0),
        valor = p_valor,
        flpublico = p_flpublico::bool,
        fldefault = p_fldefault::bool,
        cousumod = p_cousumod,
        femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    WHERE coplan = p_coplan;
    GET DIAGNOSTICS v_rows = ROW_COUNT;
    RETURN v_rows;
END;
$$;

ALTER FUNCTION suscripcion.fn_plan_update_by_id(p_coplan bigint, p_noplan character varying, p_noplandescripcion character varying, p_nuorden smallint, p_nudiasprueba smallint, p_valor jsonb, p_flpublico integer, p_fldefault integer, p_cousumod integer) OWNER TO postgres;


CREATE FUNCTION suscripcion.fn_plan_update_state_by_id(p_coplan bigint, p_flestreg integer, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_rows integer;
BEGIN
    UPDATE suscripcion.trfplan
    SET flestreg = p_flestreg::bool,
        cousumod = p_cousumod,
        femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    WHERE coplan = p_coplan AND (flestreg IS DISTINCT FROM p_flestreg::bool);
    GET DIAGNOSTICS v_rows = ROW_COUNT;
    RETURN v_rows;
END;
$$;

ALTER FUNCTION suscripcion.fn_plan_update_state_by_id(p_coplan bigint, p_flestreg integer, p_cousumod integer) OWNER TO postgres;


CREATE FUNCTION suscripcion.fn_plan_delete_by_id(p_coplan bigint, p_cousueli integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_rows integer; v_old jsonb;
BEGIN
    SELECT row_to_json(x) INTO v_old FROM suscripcion.trfplan x WHERE coplan = p_coplan;
    CALL seguridad.usp_auditoria(-100, 'suscripcion', 'trfplan', 'D', p_cousueli, jsonb_build_object('coplan', p_coplan), v_old, NULL);
    DELETE FROM suscripcion.trfplan WHERE coplan = p_coplan;
    GET DIAGNOSTICS v_rows = ROW_COUNT;
    RETURN v_rows;
END;
$$;

ALTER FUNCTION suscripcion.fn_plan_delete_by_id(p_coplan bigint, p_cousueli integer) OWNER TO postgres;


CREATE FUNCTION suscripcion.fn_plan_sel_all(p_pagesize integer, p_pageindex integer) RETURNS TABLE(rowscount bigint, pagesize integer, pageindex integer, coplan bigint, noplan character varying, noplandescripcion character varying, nuorden smallint, nudiasprueba smallint, flpublico integer, fldefault integer, flestreg integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    WITH dataa AS (
        SELECT t.coplan, t.noplan, t.noplandescripcion, t.nuorden, t.nudiasprueba,
               t.flpublico::int AS flpublico, t.fldefault::int AS fldefault, t.flestreg::int AS flestreg
        FROM suscripcion.trfplan t
    ),
    counta AS (SELECT COUNT(1) AS rowscount FROM dataa)
    SELECT c.rowscount, p_pagesize, p_pageindex,
           d.coplan, d.noplan, d.noplandescripcion, d.nuorden, d.nudiasprueba, d.flpublico, d.fldefault, d.flestreg
    FROM dataa d CROSS JOIN counta c
    ORDER BY d.nuorden, d.coplan
    LIMIT p_pagesize OFFSET p_pageindex * p_pagesize;
END;
$$;

ALTER FUNCTION suscripcion.fn_plan_sel_all(p_pagesize integer, p_pageindex integer) OWNER TO postgres;


CREATE FUNCTION suscripcion.fn_plan_sel_all_active() RETURNS TABLE(coplan bigint, noplan character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT t.coplan, t.noplan
    FROM suscripcion.trfplan t
    WHERE t.flestreg = true AND t.flpublico = true
    ORDER BY t.nuorden, t.coplan;
END;
$$;

ALTER FUNCTION suscripcion.fn_plan_sel_all_active() OWNER TO postgres;


CREATE FUNCTION suscripcion.fn_plan_sel_by_id(p_coplan bigint) RETURNS TABLE(coplan bigint, noplan character varying, noplandescripcion character varying, nuorden smallint, nudiasprueba smallint, valor jsonb, flpublico integer, fldefault integer, flestreg integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT t.coplan, t.noplan, t.noplandescripcion, t.nuorden, t.nudiasprueba, t.valor,
           t.flpublico::int, t.fldefault::int, t.flestreg::int
    FROM suscripcion.trfplan t
    WHERE t.coplan = p_coplan;
END;
$$;

ALTER FUNCTION suscripcion.fn_plan_sel_by_id(p_coplan bigint) OWNER TO postgres;


-- ============================================================
-- trfplanprecio
-- ============================================================

CREATE FUNCTION suscripcion.fn_planprecio_insert(p_coplan bigint, p_comoneda bigint, p_nuciclomeses smallint, p_ssprecio numeric) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
DECLARE v_coplanprecio bigint;
BEGIN
    -- solo un precio vigente por (plan, moneda, ciclo)
    UPDATE suscripcion.trfplanprecio
    SET flvigente = false, femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    WHERE coplan = p_coplan AND comoneda = p_comoneda AND nuciclomeses = p_nuciclomeses AND flvigente = true;

    INSERT INTO suscripcion.trfplanprecio(coplan, comoneda, nuciclomeses, ssprecio)
    VALUES (p_coplan, p_comoneda, COALESCE(p_nuciclomeses, 1), COALESCE(p_ssprecio, 0))
    RETURNING coplanprecio INTO v_coplanprecio;
    RETURN v_coplanprecio;
END;
$$;

ALTER FUNCTION suscripcion.fn_planprecio_insert(p_coplan bigint, p_comoneda bigint, p_nuciclomeses smallint, p_ssprecio numeric) OWNER TO postgres;


CREATE FUNCTION suscripcion.fn_planprecio_update_by_id(p_coplanprecio bigint, p_ssprecio numeric, p_flvigente integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_rows integer;
BEGIN
    UPDATE suscripcion.trfplanprecio
    SET ssprecio = COALESCE(p_ssprecio, ssprecio),
        flvigente = p_flvigente::bool,
        femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    WHERE coplanprecio = p_coplanprecio;
    GET DIAGNOSTICS v_rows = ROW_COUNT;
    RETURN v_rows;
END;
$$;

ALTER FUNCTION suscripcion.fn_planprecio_update_by_id(p_coplanprecio bigint, p_ssprecio numeric, p_flvigente integer) OWNER TO postgres;


CREATE FUNCTION suscripcion.fn_planprecio_delete_by_id(p_coplanprecio bigint, p_cousueli integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_rows integer; v_old jsonb;
BEGIN
    SELECT row_to_json(x) INTO v_old FROM suscripcion.trfplanprecio x WHERE coplanprecio = p_coplanprecio;
    CALL seguridad.usp_auditoria(-100, 'suscripcion', 'trfplanprecio', 'D', p_cousueli, jsonb_build_object('coplanprecio', p_coplanprecio), v_old, NULL);
    DELETE FROM suscripcion.trfplanprecio WHERE coplanprecio = p_coplanprecio;
    GET DIAGNOSTICS v_rows = ROW_COUNT;
    RETURN v_rows;
END;
$$;

ALTER FUNCTION suscripcion.fn_planprecio_delete_by_id(p_coplanprecio bigint, p_cousueli integer) OWNER TO postgres;


CREATE FUNCTION suscripcion.fn_planprecio_sel_all_by_plan(p_coplan bigint) RETURNS TABLE(coplanprecio bigint, coplan bigint, comoneda bigint, nuciclomeses smallint, ssprecio numeric, flvigente integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT t.coplanprecio, t.coplan, t.comoneda, t.nuciclomeses, t.ssprecio, t.flvigente::int
    FROM suscripcion.trfplanprecio t
    WHERE t.coplan = p_coplan AND t.flestreg = true
    ORDER BY t.comoneda, t.nuciclomeses;
END;
$$;

ALTER FUNCTION suscripcion.fn_planprecio_sel_all_by_plan(p_coplan bigint) OWNER TO postgres;


-- ============================================================
-- trfplanmodulo
-- ============================================================

CREATE FUNCTION suscripcion.fn_planmodulo_insert(p_coplan bigint, p_comodulo bigint) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
DECLARE v_coplanmodulo bigint;
BEGIN
    INSERT INTO suscripcion.trfplanmodulo(coplan, comodulo)
    VALUES (p_coplan, p_comodulo)
    ON CONFLICT (coplan, comodulo) DO UPDATE SET flestreg = true
    RETURNING coplanmodulo INTO v_coplanmodulo;
    RETURN v_coplanmodulo;
END;
$$;

ALTER FUNCTION suscripcion.fn_planmodulo_insert(p_coplan bigint, p_comodulo bigint) OWNER TO postgres;


CREATE FUNCTION suscripcion.fn_planmodulo_delete_by_id(p_coplanmodulo bigint, p_cousueli integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_rows integer; v_old jsonb;
BEGIN
    SELECT row_to_json(x) INTO v_old FROM suscripcion.trfplanmodulo x WHERE coplanmodulo = p_coplanmodulo;
    CALL seguridad.usp_auditoria(-100, 'suscripcion', 'trfplanmodulo', 'D', p_cousueli, jsonb_build_object('coplanmodulo', p_coplanmodulo), v_old, NULL);
    DELETE FROM suscripcion.trfplanmodulo WHERE coplanmodulo = p_coplanmodulo;
    GET DIAGNOSTICS v_rows = ROW_COUNT;
    RETURN v_rows;
END;
$$;

ALTER FUNCTION suscripcion.fn_planmodulo_delete_by_id(p_coplanmodulo bigint, p_cousueli integer) OWNER TO postgres;


CREATE FUNCTION suscripcion.fn_planmodulo_sel_all_by_plan(p_coplan bigint) RETURNS TABLE(coplanmodulo bigint, comodulo bigint, nomodulo character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT pm.coplanmodulo, pm.comodulo, m.nomodulo
    FROM suscripcion.trfplanmodulo pm
    JOIN seguridad.segmodulo m ON m.comodulo = pm.comodulo
    WHERE pm.coplan = p_coplan AND pm.flestreg = true
    ORDER BY m.nuorden, m.comodulo;
END;
$$;

ALTER FUNCTION suscripcion.fn_planmodulo_sel_all_by_plan(p_coplan bigint) OWNER TO postgres;


-- ============================================================
-- tblsuscripcion
-- ============================================================

--
-- Activa una suscripción para una empresa y proyecta los módulos del plan a
-- seguridad.segempresamodulo. Si p_coplanprecio es NULL se trata como periodo
-- de prueba (usa trfplan.nudiasprueba); si viene, toma ciclo/precio/moneda del
-- precio seleccionado. Desactiva la suscripción vigente anterior de la empresa.
--
CREATE FUNCTION suscripcion.fn_suscripcion_insert(p_coempresa bigint, p_coplan bigint, p_coplanprecio bigint, p_coestado bigint, p_feinicio date, p_flautorenovar integer, p_cousucre integer) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_cosuscripcion bigint;
    v_nuciclomeses smallint := 1;
    v_ssprecio numeric(14,4) := 0;
    v_comoneda bigint;
    v_nudiasprueba smallint := 0;
    v_feinicio date := COALESCE(p_feinicio, (CURRENT_TIMESTAMP AT TIME ZONE 'UTC')::date);
    v_fefin date;
BEGIN
    IF p_coplanprecio IS NOT NULL THEN
        SELECT pp.nuciclomeses, pp.ssprecio, pp.comoneda
        INTO v_nuciclomeses, v_ssprecio, v_comoneda
        FROM suscripcion.trfplanprecio pp
        WHERE pp.coplanprecio = p_coplanprecio;

        v_fefin := (v_feinicio + make_interval(months => v_nuciclomeses))::date;
    ELSE
        SELECT COALESCE(pl.nudiasprueba, 0) INTO v_nudiasprueba
        FROM suscripcion.trfplan pl WHERE pl.coplan = p_coplan;

        v_fefin := (v_feinicio + make_interval(days => v_nudiasprueba))::date;
    END IF;

    -- desactivar la suscripción vigente anterior (respeta el índice único parcial)
    UPDATE suscripcion.tblsuscripcion
    SET flvigente = false, cousumod = p_cousucre, femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    WHERE coempresa = p_coempresa AND flvigente = true AND flestreg = true;

    INSERT INTO suscripcion.tblsuscripcion(
        coempresa, coplan, coplanprecio, feinicio, fefin, ferenovacion,
        coestado, nuciclomeses, ssprecio, comoneda, flautorenovar, flvigente, cousucre)
    VALUES (
        p_coempresa, p_coplan, p_coplanprecio, v_feinicio, v_fefin, v_fefin,
        p_coestado, v_nuciclomeses, v_ssprecio, v_comoneda, COALESCE(p_flautorenovar, 1)::bool, true, p_cousucre)
    RETURNING cosuscripcion INTO v_cosuscripcion;

    -- proyectar módulos del plan hacia el enforcement de acceso
    INSERT INTO seguridad.segempresamodulo(coempresa, comodulo)
    SELECT p_coempresa, pm.comodulo
    FROM suscripcion.trfplanmodulo pm
    WHERE pm.coplan = p_coplan AND pm.flestreg = true
      AND NOT EXISTS (
          SELECT 1 FROM seguridad.segempresamodulo em
          WHERE em.coempresa = p_coempresa AND em.comodulo = pm.comodulo);

    -- historial funcional: activación (dato de negocio, no auditoría técnica)
    INSERT INTO suscripcion.tblsuscripcionmovimiento(
        cosuscripcion, coempresa, cotipomovimiento, coestadoanterior, coestadonuevo, fefinanterior, fefinactual, cousucre)
    VALUES (
        v_cosuscripcion, p_coempresa,
        (SELECT cotipogeneral FROM maestro.trftipogeneral WHERE nocomando = 'suscripcion.mov.activacion'),
        NULL, p_coestado, NULL, v_fefin, p_cousucre);

    RETURN v_cosuscripcion;
END;
$$;

ALTER FUNCTION suscripcion.fn_suscripcion_insert(p_coempresa bigint, p_coplan bigint, p_coplanprecio bigint, p_coestado bigint, p_feinicio date, p_flautorenovar integer, p_cousucre integer) OWNER TO postgres;


--
-- Renueva la suscripción extendiendo el periodo un ciclo y fijando el estado.
--
CREATE FUNCTION suscripcion.fn_suscripcion_renovar(p_cosuscripcion bigint, p_coestado bigint, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_rows integer; v_coempresa bigint; v_estadoant bigint; v_fefinant date; v_fefinnue date;
BEGIN
    SELECT coempresa, coestado, fefin INTO v_coempresa, v_estadoant, v_fefinant
    FROM suscripcion.tblsuscripcion WHERE cosuscripcion = p_cosuscripcion AND flestreg = true;
    IF NOT FOUND THEN
        RETURN 0;
    END IF;

    UPDATE suscripcion.tblsuscripcion
    SET fefin = (COALESCE(fefin, (CURRENT_TIMESTAMP AT TIME ZONE 'UTC')::date) + make_interval(months => nuciclomeses))::date,
        ferenovacion = (COALESCE(fefin, (CURRENT_TIMESTAMP AT TIME ZONE 'UTC')::date) + make_interval(months => nuciclomeses))::date,
        coestado = p_coestado,
        cousumod = p_cousumod,
        femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    WHERE cosuscripcion = p_cosuscripcion AND flestreg = true
    RETURNING fefin INTO v_fefinnue;
    GET DIAGNOSTICS v_rows = ROW_COUNT;

    -- historial funcional: renovación
    INSERT INTO suscripcion.tblsuscripcionmovimiento(
        cosuscripcion, coempresa, cotipomovimiento, coestadoanterior, coestadonuevo, fefinanterior, fefinactual, cousucre)
    VALUES (
        p_cosuscripcion, v_coempresa,
        (SELECT cotipogeneral FROM maestro.trftipogeneral WHERE nocomando = 'suscripcion.mov.renovacion'),
        v_estadoant, p_coestado, v_fefinant, v_fefinnue, p_cousumod);

    RETURN v_rows;
END;
$$;

ALTER FUNCTION suscripcion.fn_suscripcion_renovar(p_cosuscripcion bigint, p_coestado bigint, p_cousumod integer) OWNER TO postgres;


--
-- Cancela la suscripción: fija estado, desactiva autorrenovación y marca la
-- fecha de cancelación. Conserva el acceso hasta fefin (no revoca módulos).
--
CREATE FUNCTION suscripcion.fn_suscripcion_cancelar(p_cosuscripcion bigint, p_coestado bigint, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_rows integer; v_coempresa bigint; v_estadoant bigint; v_fefin date;
BEGIN
    SELECT coempresa, coestado, fefin INTO v_coempresa, v_estadoant, v_fefin
    FROM suscripcion.tblsuscripcion WHERE cosuscripcion = p_cosuscripcion AND flestreg = true;
    IF NOT FOUND THEN
        RETURN 0;
    END IF;

    UPDATE suscripcion.tblsuscripcion
    SET coestado = p_coestado,
        flautorenovar = false,
        fecancelacion = CURRENT_TIMESTAMP AT TIME ZONE 'UTC',
        cousumod = p_cousumod,
        femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    WHERE cosuscripcion = p_cosuscripcion AND flestreg = true;
    GET DIAGNOSTICS v_rows = ROW_COUNT;

    -- historial funcional: cancelación
    INSERT INTO suscripcion.tblsuscripcionmovimiento(
        cosuscripcion, coempresa, cotipomovimiento, coestadoanterior, coestadonuevo, fefinanterior, fefinactual, cousucre)
    VALUES (
        p_cosuscripcion, v_coempresa,
        (SELECT cotipogeneral FROM maestro.trftipogeneral WHERE nocomando = 'suscripcion.mov.cancelacion'),
        v_estadoant, p_coestado, v_fefin, v_fefin, p_cousumod);

    RETURN v_rows;
END;
$$;

ALTER FUNCTION suscripcion.fn_suscripcion_cancelar(p_cosuscripcion bigint, p_coestado bigint, p_cousumod integer) OWNER TO postgres;


CREATE FUNCTION suscripcion.fn_suscripcion_update_estado_by_id(p_cosuscripcion bigint, p_coestado bigint, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_rows integer; v_coempresa bigint; v_estadoant bigint; v_fefin date;
BEGIN
    SELECT coempresa, coestado, fefin INTO v_coempresa, v_estadoant, v_fefin
    FROM suscripcion.tblsuscripcion WHERE cosuscripcion = p_cosuscripcion;

    UPDATE suscripcion.tblsuscripcion
    SET coestado = p_coestado,
        cousumod = p_cousumod,
        femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    WHERE cosuscripcion = p_cosuscripcion AND (coestado IS DISTINCT FROM p_coestado);
    GET DIAGNOSTICS v_rows = ROW_COUNT;

    -- historial funcional: cambio de estado (solo si efectivamente cambió)
    IF v_rows > 0 THEN
        INSERT INTO suscripcion.tblsuscripcionmovimiento(
            cosuscripcion, coempresa, cotipomovimiento, coestadoanterior, coestadonuevo, fefinanterior, fefinactual, cousucre)
        VALUES (
            p_cosuscripcion, v_coempresa,
            (SELECT cotipogeneral FROM maestro.trftipogeneral WHERE nocomando = 'suscripcion.mov.cambioestado'),
            v_estadoant, p_coestado, v_fefin, v_fefin, p_cousumod);
    END IF;

    RETURN v_rows;
END;
$$;

ALTER FUNCTION suscripcion.fn_suscripcion_update_estado_by_id(p_cosuscripcion bigint, p_coestado bigint, p_cousumod integer) OWNER TO postgres;


CREATE FUNCTION suscripcion.fn_suscripcion_sel_by_empresa(p_coempresa bigint) RETURNS TABLE(cosuscripcion bigint, coempresa bigint, coplan bigint, noplan character varying, coplanprecio bigint, feinicio date, fefin date, ferenovacion date, coestado bigint, nuciclomeses smallint, ssprecio numeric, comoneda bigint, flautorenovar integer, flvigente integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT s.cosuscripcion, s.coempresa, s.coplan, pl.noplan, s.coplanprecio,
           s.feinicio, s.fefin, s.ferenovacion, s.coestado, s.nuciclomeses, s.ssprecio, s.comoneda,
           s.flautorenovar::int, s.flvigente::int
    FROM suscripcion.tblsuscripcion s
    JOIN suscripcion.trfplan pl ON pl.coplan = s.coplan
    WHERE s.coempresa = p_coempresa AND s.flvigente = true AND s.flestreg = true;
END;
$$;

ALTER FUNCTION suscripcion.fn_suscripcion_sel_by_empresa(p_coempresa bigint) OWNER TO postgres;


CREATE FUNCTION suscripcion.fn_suscripcion_sel_by_id(p_cosuscripcion bigint) RETURNS TABLE(cosuscripcion bigint, coempresa bigint, coplan bigint, noplan character varying, coplanprecio bigint, feinicio date, fefin date, ferenovacion date, coestado bigint, nuciclomeses smallint, ssprecio numeric, comoneda bigint, flautorenovar integer, flvigente integer, fecancelacion timestamp without time zone)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT s.cosuscripcion, s.coempresa, s.coplan, pl.noplan, s.coplanprecio,
           s.feinicio, s.fefin, s.ferenovacion, s.coestado, s.nuciclomeses, s.ssprecio, s.comoneda,
           s.flautorenovar::int, s.flvigente::int, s.fecancelacion
    FROM suscripcion.tblsuscripcion s
    JOIN suscripcion.trfplan pl ON pl.coplan = s.coplan
    WHERE s.cosuscripcion = p_cosuscripcion;
END;
$$;

ALTER FUNCTION suscripcion.fn_suscripcion_sel_by_id(p_cosuscripcion bigint) OWNER TO postgres;


CREATE FUNCTION suscripcion.fn_suscripcion_sel_all(p_coestado bigint, p_pagesize integer, p_pageindex integer) RETURNS TABLE(rowscount bigint, pagesize integer, pageindex integer, cosuscripcion bigint, coempresa bigint, coplan bigint, noplan character varying, feinicio date, fefin date, ferenovacion date, coestado bigint, ssprecio numeric, flvigente integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    WITH dataa AS (
        SELECT s.cosuscripcion, s.coempresa, s.coplan, pl.noplan, s.feinicio, s.fefin, s.ferenovacion,
               s.coestado, s.ssprecio, s.flvigente::int AS flvigente
        FROM suscripcion.tblsuscripcion s
        JOIN suscripcion.trfplan pl ON pl.coplan = s.coplan
        WHERE (p_coestado IS NULL OR s.coestado = p_coestado)
          AND s.flestreg = true
    ),
    counta AS (SELECT COUNT(1) AS rowscount FROM dataa)
    SELECT c.rowscount, p_pagesize, p_pageindex,
           d.cosuscripcion, d.coempresa, d.coplan, d.noplan, d.feinicio, d.fefin, d.ferenovacion,
           d.coestado, d.ssprecio, d.flvigente
    FROM dataa d CROSS JOIN counta c
    ORDER BY d.ferenovacion NULLS LAST, d.cosuscripcion
    LIMIT p_pagesize OFFSET p_pageindex * p_pagesize;
END;
$$;

ALTER FUNCTION suscripcion.fn_suscripcion_sel_all(p_coestado bigint, p_pagesize integer, p_pageindex integer) OWNER TO postgres;


-- ============================================================
-- tblsuscripcionpago
-- ============================================================

CREATE FUNCTION suscripcion.fn_suscripcionpago_insert(p_cosuscripcion bigint, p_coempresa bigint, p_feperiodoinicio date, p_feperiodofin date, p_ssmonto numeric, p_comoneda bigint, p_fepago timestamp without time zone, p_coestado bigint, p_noreferenciapago character varying, p_txnota character varying, p_cousucre integer) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
DECLARE v_cosuscripcionpago bigint;
BEGIN
    INSERT INTO suscripcion.tblsuscripcionpago(
        cosuscripcion, coempresa, feperiodoinicio, feperiodofin, ssmonto, comoneda,
        fepago, coestado, noreferenciapago, txnota, cousucre)
    VALUES (
        p_cosuscripcion, p_coempresa, p_feperiodoinicio, p_feperiodofin, COALESCE(p_ssmonto, 0), p_comoneda,
        p_fepago, p_coestado, p_noreferenciapago, p_txnota, p_cousucre)
    RETURNING cosuscripcionpago INTO v_cosuscripcionpago;
    RETURN v_cosuscripcionpago;
END;
$$;

ALTER FUNCTION suscripcion.fn_suscripcionpago_insert(p_cosuscripcion bigint, p_coempresa bigint, p_feperiodoinicio date, p_feperiodofin date, p_ssmonto numeric, p_comoneda bigint, p_fepago timestamp without time zone, p_coestado bigint, p_noreferenciapago character varying, p_txnota character varying, p_cousucre integer) OWNER TO postgres;


CREATE FUNCTION suscripcion.fn_suscripcionpago_update_estado_by_id(p_cosuscripcionpago bigint, p_coestado bigint, p_fepago timestamp without time zone, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_rows integer;
BEGIN
    UPDATE suscripcion.tblsuscripcionpago
    SET coestado = p_coestado,
        fepago = COALESCE(p_fepago, fepago),
        cousumod = p_cousumod,
        femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    WHERE cosuscripcionpago = p_cosuscripcionpago AND (coestado IS DISTINCT FROM p_coestado);
    GET DIAGNOSTICS v_rows = ROW_COUNT;
    RETURN v_rows;
END;
$$;

ALTER FUNCTION suscripcion.fn_suscripcionpago_update_estado_by_id(p_cosuscripcionpago bigint, p_coestado bigint, p_fepago timestamp without time zone, p_cousumod integer) OWNER TO postgres;


CREATE FUNCTION suscripcion.fn_suscripcionpago_sel_all_by_suscripcion(p_cosuscripcion bigint) RETURNS TABLE(cosuscripcionpago bigint, cosuscripcion bigint, feperiodoinicio date, feperiodofin date, ssmonto numeric, comoneda bigint, fepago timestamp without time zone, coestado bigint, noreferenciapago character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT t.cosuscripcionpago, t.cosuscripcion, t.feperiodoinicio, t.feperiodofin, t.ssmonto, t.comoneda,
           t.fepago, t.coestado, t.noreferenciapago
    FROM suscripcion.tblsuscripcionpago t
    WHERE t.cosuscripcion = p_cosuscripcion AND t.flestreg = true
    ORDER BY t.feperiodoinicio DESC, t.cosuscripcionpago DESC;
END;
$$;

ALTER FUNCTION suscripcion.fn_suscripcionpago_sel_all_by_suscripcion(p_cosuscripcion bigint) OWNER TO postgres;


-- ============================================================
-- tblsuscripcionmovimiento (historial funcional)
-- ============================================================

CREATE FUNCTION suscripcion.fn_suscripcionmovimiento_sel_all_by_suscripcion(p_cosuscripcion bigint) RETURNS TABLE(cosuscripcionmovimiento bigint, cotipomovimiento bigint, notipomovimiento character varying, coestadoanterior bigint, noestadoanterior character varying, coestadonuevo bigint, noestadonuevo character varying, fefinanterior date, fefinactual date, femovimiento timestamp without time zone, txnota character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT m.cosuscripcionmovimiento, m.cotipomovimiento, tm.notipo,
           m.coestadoanterior, ea.notipo, m.coestadonuevo, en.notipo,
           m.fefinanterior, m.fefinactual, m.femovimiento, m.txnota
    FROM suscripcion.tblsuscripcionmovimiento m
    JOIN maestro.trftipogeneral tm ON tm.cotipogeneral = m.cotipomovimiento
    LEFT JOIN maestro.trftipogeneral ea ON ea.cotipogeneral = m.coestadoanterior
    JOIN maestro.trftipogeneral en ON en.cotipogeneral = m.coestadonuevo
    WHERE m.cosuscripcion = p_cosuscripcion AND m.flestreg = true
    ORDER BY m.femovimiento DESC, m.cosuscripcionmovimiento DESC;
END;
$$;

ALTER FUNCTION suscripcion.fn_suscripcionmovimiento_sel_all_by_suscripcion(p_cosuscripcion bigint) OWNER TO postgres;
