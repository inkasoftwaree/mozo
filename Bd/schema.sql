--
-- PostgreSQL database dump
--

\restrict 1tlB7HECTiNEHOETkSOjIxzbTTUdPOzuv8p93gsXnjKXpDYXh0vaxwh2izL3kIU

-- Dumped from database version 18.4
-- Dumped by pg_dump version 18.4

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: catalogo; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA catalogo;


ALTER SCHEMA catalogo OWNER TO postgres;

--
-- Name: contabilidad; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA contabilidad;


ALTER SCHEMA contabilidad OWNER TO postgres;

--
-- Name: empresa; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA empresa;


ALTER SCHEMA empresa OWNER TO postgres;

--
-- Name: facturacion; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA facturacion;


ALTER SCHEMA facturacion OWNER TO postgres;

--
-- Name: facturacionrpt; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA facturacionrpt;


ALTER SCHEMA facturacionrpt OWNER TO postgres;

--
-- Name: inventario; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA inventario;


ALTER SCHEMA inventario OWNER TO postgres;

--
-- Name: login; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA login;


ALTER SCHEMA login OWNER TO postgres;

--
-- Name: maestro; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA maestro;


ALTER SCHEMA maestro OWNER TO postgres;

--
-- Name: maestrorpt; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA maestrorpt;


ALTER SCHEMA maestrorpt OWNER TO postgres;

--
-- Name: seguridad; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA seguridad;


ALTER SCHEMA seguridad OWNER TO postgres;

--
-- Name: fn_atributo_delete_by_id(integer, integer, integer); Type: FUNCTION; Schema: catalogo; Owner: postgres
--

CREATE FUNCTION catalogo.fn_atributo_delete_by_id(p_coempresa integer, p_coatributo integer, p_cousueli integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_rows integer;
	v_old JSONB;
BEGIN
	SELECT row_to_json(x) INTO v_old
	FROM catalogo.tblatributo x
	WHERE coatributo = p_coatributo AND coempresa = p_coempresa;

	CALL seguridad.usp_auditoria(
		p_coempresa,
		'catalogo',
		'tblatributo',
		'D',
        p_cousueli,
		jsonb_build_object('coatributo', p_coatributo),
		v_old,
		NULL
	);

	DELETE FROM catalogo.tblatributo
	WHERE coatributo = p_coatributo AND coempresa = p_coempresa;
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION catalogo.fn_atributo_delete_by_id(p_coempresa integer, p_coatributo integer, p_cousueli integer) OWNER TO postgres;

--
-- Name: fn_atributo_insert(integer, text, integer, integer, smallint, integer, integer, integer, integer); Type: FUNCTION; Schema: catalogo; Owner: postgres
--

CREATE FUNCTION catalogo.fn_atributo_insert(p_coempresa integer, p_noatributo text, p_cotipodato integer, p_cocategoria integer, p_nuorden smallint, p_flobligatorio integer, p_flfiltrable integer, p_fldescriptivo integer, p_cousucre integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_id INT;
BEGIN
	INSERT INTO catalogo.tblatributo (
		coempresa,
		noatributo,
		cotipodato,
		cocategoria,
		nuorden,
		flobligatorio,
		flfiltrable,
		fldescriptivo,
		cousucre
	)
	VALUES (
		p_coempresa,
		p_noatributo,
		p_cotipodato,
		p_cocategoria,
		p_nuorden,
		p_flobligatorio::boolean,
		p_flfiltrable::boolean,
		p_fldescriptivo::boolean,
		p_cousucre
	)
	RETURNING coatributo INTO v_id;
	RETURN v_id;
END;
$$;


ALTER FUNCTION catalogo.fn_atributo_insert(p_coempresa integer, p_noatributo text, p_cotipodato integer, p_cocategoria integer, p_nuorden smallint, p_flobligatorio integer, p_flfiltrable integer, p_fldescriptivo integer, p_cousucre integer) OWNER TO postgres;

--
-- Name: fn_atributo_sel_all(integer); Type: FUNCTION; Schema: catalogo; Owner: postgres
--

CREATE FUNCTION catalogo.fn_atributo_sel_all(p_coempresa integer) RETURNS TABLE(coatributo integer, coempresa integer, noatributo text, cotipodato integer, cocategoria integer, nuorden smallint, flobligatorio integer, flfiltrable integer, fldescriptivo integer, flestreg integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
	RETURN QUERY
		SELECT
			coatributo,
			coempresa,
			noatributo,
			cotipodato,
			cocategoria,
			nuorden,
			flobligatorio::int AS flobligatorio,
			flfiltrable::int AS flfiltrable,
			fldescriptivo::int AS fldescriptivo,
			flestreg::int AS flestreg
		FROM catalogo.tblatributo
		WHERE coempresa = p_coempresa AND fldelete = 0;
END;
$$;


ALTER FUNCTION catalogo.fn_atributo_sel_all(p_coempresa integer) OWNER TO postgres;

--
-- Name: fn_atributo_sel_all_active(integer); Type: FUNCTION; Schema: catalogo; Owner: postgres
--

CREATE FUNCTION catalogo.fn_atributo_sel_all_active(p_coempresa integer) RETURNS TABLE(coatributo integer, coempresa integer, noatributo text, cotipodato integer, cocategoria integer, nuorden smallint, flobligatorio integer, flfiltrable integer, fldescriptivo integer, flestreg integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
	RETURN QUERY
		SELECT
			coatributo,
			coempresa,
			noatributo,
			cotipodato,
			cocategoria,
			nuorden,
			flobligatorio::int AS flobligatorio,
			flfiltrable::int AS flfiltrable,
			fldescriptivo::int AS fldescriptivo,
			flestreg::int AS flestreg
		FROM catalogo.tblatributo
		WHERE coempresa = p_coempresa AND fldelete = false AND flestreg = true;
END;
$$;


ALTER FUNCTION catalogo.fn_atributo_sel_all_active(p_coempresa integer) OWNER TO postgres;

--
-- Name: fn_atributo_sel_by_id(integer, integer); Type: FUNCTION; Schema: catalogo; Owner: postgres
--

CREATE FUNCTION catalogo.fn_atributo_sel_by_id(p_coempresa integer, p_coatributo integer) RETURNS TABLE(coatributo integer, coempresa integer, noatributo text, cotipodato integer, cocategoria integer, nuorden smallint, flobligatorio integer, flfiltrable integer, fldescriptivo integer, flestreg integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
	RETURN QUERY
		SELECT
			coatributo,
			coempresa,
			noatributo,
			cotipodato,
			cocategoria,
			nuorden,
			flobligatorio::int AS flobligatorio,
			flfiltrable::int AS flfiltrable,
			fldescriptivo::int AS fldescriptivo,
			flestreg::int AS flestreg
		FROM catalogo.tblatributo
		WHERE coempresa = p_coempresa AND coatributo = p_coatributo;
END;
$$;


ALTER FUNCTION catalogo.fn_atributo_sel_by_id(p_coempresa integer, p_coatributo integer) OWNER TO postgres;

--
-- Name: fn_atributo_update_by_id(integer, integer, text, integer, integer, smallint, integer, integer, integer, integer); Type: FUNCTION; Schema: catalogo; Owner: postgres
--

CREATE FUNCTION catalogo.fn_atributo_update_by_id(p_coempresa integer, p_coatributo integer, p_noatributo text, p_cotipodato integer, p_cocategoria integer, p_nuorden smallint, p_flobligatorio integer, p_flfiltrable integer, p_fldescriptivo integer, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_rows integer;
BEGIN
	UPDATE catalogo.tblatributo
	SET
		noatributo = p_noatributo,
		cotipodato = p_cotipodato,
		cocategoria = p_cocategoria,
		nuorden = p_nuorden,
		flobligatorio = p_flobligatorio::boolean,
		flfiltrable = p_flfiltrable::boolean,
		fldescriptivo = p_fldescriptivo::boolean,
		cousumod = p_cousumod,
		femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
	WHERE coempresa = p_coempresa AND coatributo = p_coatributo;
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION catalogo.fn_atributo_update_by_id(p_coempresa integer, p_coatributo integer, p_noatributo text, p_cotipodato integer, p_cocategoria integer, p_nuorden smallint, p_flobligatorio integer, p_flfiltrable integer, p_fldescriptivo integer, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_atributo_update_state_by_id(integer, integer, integer, integer); Type: FUNCTION; Schema: catalogo; Owner: postgres
--

CREATE FUNCTION catalogo.fn_atributo_update_state_by_id(p_coempresa integer, p_coatributo integer, p_flestreg integer, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_rows integer;
BEGIN
	UPDATE catalogo.tblatributo
	SET
		flestreg = p_flestreg,
		cousumod = p_cousumod,
		femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
	WHERE coatributo = p_coatributo AND coempresa = p_coempresa;
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION catalogo.fn_atributo_update_state_by_id(p_coempresa integer, p_coatributo integer, p_flestreg integer, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_producto_delete_by_id(integer, integer, integer); Type: FUNCTION; Schema: catalogo; Owner: postgres
--

CREATE FUNCTION catalogo.fn_producto_delete_by_id(p_coempresa integer, p_coproducto integer, p_cousueli integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
Declare
	v_old JSONB; 
	v_rows integer;
begin

	SELECT row_to_json(x) INTO v_old
    FROM catalogo.tblproducto x
    WHERE coempresa = p_coempresa And coproducto = p_coproducto;

    CALL seguridad.usp_auditoria(
 		p_coempresa,	-- Empresa
        'catalogo',                          -- Esquema
		'tblproducto',                  -- tabla
		'D',                        -- acción
        p_cousueli,                        -- usuario
        jsonb_build_object('coproducto', p_coproducto),
        v_old,
        NULL
    );

      Delete From catalogo.tblproducto where coempresa = p_coempresa and coproducto = p_coproducto;
	  Delete from catalogo.tblproductostock where coempresa = p_coempresa and coproducto = p_coproducto;
	  
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;

end;
$$;


ALTER FUNCTION catalogo.fn_producto_delete_by_id(p_coempresa integer, p_coproducto integer, p_cousueli integer) OWNER TO postgres;

--
-- Name: fn_producto_exist(integer, integer, integer, integer, integer, character varying, character varying); Type: FUNCTION; Schema: catalogo; Owner: postgres
--

CREATE FUNCTION catalogo.fn_producto_exist(p_coempresa integer, p_coproducto integer, p_cotipo integer, p_comarca integer, p_colaboratorio integer, p_noproducto character varying, p_nomodelo character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_qt int;
BEGIN
    SELECT COUNT(1)
    INTO v_qt
    FROM catalogo.tblproducto
    WHERE coempresa        = p_coempresa 
		AND cotipo          = p_cotipo
      	AND comarca          = p_comarca
      	AND colaboratorio    = p_colaboratorio
      	AND noproducto       = p_noproducto
      	AND nomodelo         = p_nomodelo
      	AND coproducto <> p_coproducto;

    RETURN v_qt;
END;
$$;


ALTER FUNCTION catalogo.fn_producto_exist(p_coempresa integer, p_coproducto integer, p_cotipo integer, p_comarca integer, p_colaboratorio integer, p_noproducto character varying, p_nomodelo character varying) OWNER TO postgres;

--
-- Name: fn_producto_insert(integer, text, integer, integer, text, text, integer, integer, integer, numeric, integer, text, integer, integer, integer, smallint, smallint, text, numeric, integer, integer); Type: FUNCTION; Schema: catalogo; Owner: postgres
--

CREATE FUNCTION catalogo.fn_producto_insert(p_coempresa integer, p_nocodigointerno text, p_comarca integer, p_colaboratorio integer, p_noproducto text, p_nomodelo text, p_counidadmedidainventario integer, p_counidadmedidacompra integer, p_counidadmedidaventa integer, p_ssfactorcompra numeric, p_coproveedorprincipal integer, p_txdescripcioncorta text, p_cocategoria integer, p_cocategoriahijo integer, p_cotipo integer, p_flimpuesto smallint, p_flinventario smallint, p_nocodigofiscal text, p_ssfactorventa numeric, p_flimpuestoexento integer, p_cousucre integer) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
DECLARE 	
    v_coproducto BIGINT;
	v_pqimpuesto decimal(14, 4);
BEGIN
       IF catalogo.fn_producto_exist(
        p_coempresa,
        p_producto,
        p_cotipo,   
        p_comarca,
        p_colaboratorio,
        p_noproducto,
        p_nomodelo
    ) > 0 THEN
        RAISE EXCEPTION 'El producto ya existe.';
    END IF;

      insert into catalogo.tblproducto (
		coempresa,		
		nocodigointerno,
		comarca,
		colaboratorio,
		noproducto,
		nomodelo,
		counidadmedidainventario,
		counidadmedidacompra,
		counidadmedidaventa,
		ssfactorcompra,
		coproveedorprincipal,
		txdescripcioncorta,
		cocategoria,
		cocategoriahijo,
		cotipo,
		flimpuesto,
		flinventario,
		nocodigofiscal,		
		ssfactorventa,
		flimpuestoexento,
		cousucre
		)								
          values (
		p_coempresa,	
		p_nocodigointerno,
		p_comarca,
		p_colaboratorio,
		p_noproducto,
		p_nomodelo,
		p_counidadmedidainventario,
		p_counidadmedidacompra,
		p_counidadmedidaventa,
		p_ssfactorcompra,
		p_coproveedorprincipal,
		p_txdescripcioncorta,
		p_cocategoria,
		p_cocategoriahijo,
		p_cotipo,
		p_flimpuesto,
		p_flinventario,
		p_nocodigofiscal,		
		p_ssfactorventa,
		p_flimpuestoexento::boolean,
		p_cousucre
			)
	RETURNING coproducto INTO v_coproducto;

	RETURN v_coproducto;
	
END;
$$;


ALTER FUNCTION catalogo.fn_producto_insert(p_coempresa integer, p_nocodigointerno text, p_comarca integer, p_colaboratorio integer, p_noproducto text, p_nomodelo text, p_counidadmedidainventario integer, p_counidadmedidacompra integer, p_counidadmedidaventa integer, p_ssfactorcompra numeric, p_coproveedorprincipal integer, p_txdescripcioncorta text, p_cocategoria integer, p_cocategoriahijo integer, p_cotipo integer, p_flimpuesto smallint, p_flinventario smallint, p_nocodigofiscal text, p_ssfactorventa numeric, p_flimpuestoexento integer, p_cousucre integer) OWNER TO postgres;

--
-- Name: fn_producto_insert(integer, integer, integer, integer, integer, character varying, character varying, integer, integer, integer, numeric, integer, character varying, integer, integer, integer, integer, integer, character varying, integer, numeric, integer); Type: FUNCTION; Schema: catalogo; Owner: postgres
--

CREATE FUNCTION catalogo.fn_producto_insert(p_coempresa integer, p_coproducto integer, p_nocodigointerno integer, p_comarca integer, p_colaboratorio integer, p_noproducto character varying, p_nomodelo character varying, p_counidadmedidainventario integer, p_counidadmedidacompra integer, p_counidadmedidaventa integer, p_ssfactorcompra numeric, p_coproveedorprincipal integer, p_txdescripcioncorta character varying, p_cocategoria integer, p_cocategoriahijo integer, p_cotipo integer, p_flimpuesto integer, p_flinventario integer, p_nocodigofiscal character varying, p_flimpuestoexento integer, p_ssfactorventa numeric, p_cousucre integer) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
DECLARE 	
    v_coproducto BIGINT;
	v_pqimpuesto decimal(14, 4);
BEGIN
       IF catalogo.fn_producto_exist(
        p_coempresa,
        p_producto,
        p_cotipo,   
        p_comarca,
        p_colaboratorio,
        p_noproducto,
        p_nomodelo
    ) > 0 THEN
        RAISE EXCEPTION 'El producto ya existe.';
    END IF;

      insert into catalogo.tblproducto (
		  	coempresa,
			nocodigointerno ,
			comarca ,
		 	colaboratorio ,
			noproducto ,
			nomodelo ,
			counidadmedidainventario ,
			counidadmedidacompra ,
			counidadmedidaventa ,
			ssfactorcompra ,
			coproveedorprincipal ,			
			txdescripcioncorta ,
			cocategoria ,
			cocategoriahijo ,
			cotipo ,
			flimpuesto ,
			flinventario ,
			nocodigofiscal ,
			flimpuestoexento ,
			ssfactorventa ,		
	        cousucre
		)								
          values (
			p_coempresa,
			p_nocodigointerno,
			p_comarca,
	 		p_colaboratorio,
	 		p_noproducto,
	 		p_nomodelo,
	 		p_counidadmedidainventario,
	 		p_counidadmedidacompra,
	 		p_counidadmedidaventa,
			p_ssfactorcompra,
	 		p_coproveedorprincipal,	 	
	 		p_txdescripcioncorta,
	 		p_cocategoria,
	 		p_cocategoriahijo,
	 		p_cotipo,
	 		p_flimpuesto,
	 		p_flinventario,
	 		p_nocodigofiscal,
	 		p_flimpuestoexento,
	 		p_ssfactorventa,
			p_cousucre
			)
	RETURNING coproducto INTO v_coproducto;

	RETURN v_coproducto;
	
END;
$$;


ALTER FUNCTION catalogo.fn_producto_insert(p_coempresa integer, p_coproducto integer, p_nocodigointerno integer, p_comarca integer, p_colaboratorio integer, p_noproducto character varying, p_nomodelo character varying, p_counidadmedidainventario integer, p_counidadmedidacompra integer, p_counidadmedidaventa integer, p_ssfactorcompra numeric, p_coproveedorprincipal integer, p_txdescripcioncorta character varying, p_cocategoria integer, p_cocategoriahijo integer, p_cotipo integer, p_flimpuesto integer, p_flinventario integer, p_nocodigofiscal character varying, p_flimpuestoexento integer, p_ssfactorventa numeric, p_cousucre integer) OWNER TO postgres;

--
-- Name: fn_producto_sel_all(integer, integer, integer, character varying, integer, integer); Type: FUNCTION; Schema: catalogo; Owner: postgres
--

CREATE FUNCTION catalogo.fn_producto_sel_all(p_coempresa integer, p_coproveedorprincipal integer, p_comarca integer, p_noinputsearch character varying, p_pagesize integer, p_pageindex integer) RETURNS TABLE(coempresa integer, coproducto integer, noproducto character varying, nomodelo character varying, txdescripcioncorta character varying, nolaboratorio character varying, nomarca character varying, notipo character varying, nocatagoria character varying, nocategoriahijo character varying, flestreg integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
	RETURN QUERY
		SELECT 
			p.coempresa,
			p.coproducto,
			p.noproducto,
			p.nomodelo,
			p.txdescripcioncorta,
			p.nolaboratorio,
			p.nomarca,
			p.notipo,
			p.nocatagoria,
			p.nocategoriahijo,
			p.flestreg
		FROM catalogo.vw_producto p
		WHERE p.coempresa = p_coempresa
			AND (p_coproveedorprincipal IS NULL OR p.coproveedorprincipal = p_coproveedorprincipal)
			AND (p_comarca IS NULL OR p.comarca = p_comarca)
			AND (
				p_noinputsearch IS NULL OR
				p.noproducto ILIKE '%' || p_noinputsearch || '%' OR
				p.nocodigointerno ILIKE '%' || p_noinputsearch || '%' OR
				p.nocodigofiscal ILIKE '%' || p_noinputsearch || '%'
			)
		ORDER BY p.coproducto
		OFFSET COALESCE(p_pageindex, 0) * COALESCE(p_pagesize, 1)
		LIMIT COALESCE(p_pagesize, 1)
	;
END;
$$;


ALTER FUNCTION catalogo.fn_producto_sel_all(p_coempresa integer, p_coproveedorprincipal integer, p_comarca integer, p_noinputsearch character varying, p_pagesize integer, p_pageindex integer) OWNER TO postgres;

--
-- Name: fn_producto_sel_all_by_compra(integer, integer, character varying, integer, integer); Type: FUNCTION; Schema: catalogo; Owner: postgres
--

CREATE FUNCTION catalogo.fn_producto_sel_all_by_compra(p_coempresa integer, p_comarca integer, p_noinputsearch character varying, p_cocompra integer, p_coproducto integer) RETURNS TABLE(coempresa integer, coproducto integer, nocodigointerno character varying, nocodigofiscal character varying, cocategoria integer, cocategoriahijo integer, cotipo integer, comarca integer, colaboratorio integer, noproducto character varying, nomodelo character varying, counidadmedidainventario integer, counidadmedidacompra integer, counidadmedidaventa integer, ssfactorcompra numeric, ssfactorventa numeric, coproveedorprincipal integer, flpadre integer, txdescripcioncorta character varying, flimpuesto integer, flinventario integer, flimpuestoexento integer, flestreg integer, nolaboratorio character varying, nomarca character varying, nounidadmedidainventario character varying, nounidadmedidacompra character varying, nocounidadmedidaventa character varying, notipo character varying, nocatagoria character varying, nocategoriahijo character varying, colocal integer, coalmacen integer, nolocal character varying, noalmacen character varying)
    LANGUAGE plpgsql
    AS $$
DECLARE  
    p_colocal int;
    p_coalmacen int;
	p_nolocal varchar(100);
	p_noalmacen varchar(50);	
BEGIN
    -- Validación de compra obligatoria
    IF p_cocompra IS NULL THEN
        RAISE EXCEPTION 'falta el código de la compra.';
    END IF;
	
    -- Obtener local y almacén por defecto
    IF p_coproducto > 0 THEN
        SELECT ps.colocal, ps.coalmacen, lc.nolocal, al.noalmacen
          INTO p_colocal, p_coalmacen, p_nolocal, p_noalmacen
        FROM catalogo.tblproductostock ps, empresa.tbllocal lc, inventario.tblalmacen al
        WHERE ps.coempresa = lc.coempresa AND ps.colocal = lc.colocal
			AND ps.coempresa = al.coempresa AND ps.coalmacen = al.coalmacen
			AND ps.coempresa = p_coempresa 
          	AND ps.coproducto = p_coproducto       
          	AND ps.fldefault = true
        LIMIT 1;

        IF p_coalmacen IS NULL THEN
            SELECT al.colocal, al.coalmacen, al.nolocal, al.noalmacen
              INTO p_colocal, p_coalmacen, p_nolocal, p_noalmacen
            FROM inventario.tblalmacen al, empresa.tbllocal lc			
            WHERE al.coempresa = lc.coempresa AND al.colocal = lc.colocal			
			  AND al.coempresa = p_coempresa              
              AND al.flprincipal = true
            LIMIT 1;
        END IF;
    END IF;

    -- Normalizar búsqueda
    IF p_noinputsearch IS NOT NULL THEN
        p_noinputsearch := lower(p_noinputsearch);
    END IF;

    -- Query principal (devuelve tabla)
    RETURN QUERY
    SELECT 
      p.coempresa,
	  p.coproducto,
	  p.nocodigointerno,
	  p.nocodigofiscal,
	  p.cocategoria,
	  p.cocategoriahijo,
	  p.cotipo,
			    p.comarca,
			    p.colaboratorio,
			    p.noproducto,
			    p.nomodelo,
			    p.counidadmedidainventario,
			    p.counidadmedidacompra,
			    p.counidadmedidaventa,
			    p.ssfactorcompra,
			    p.ssfactorventa,
			    p.coproveedorprincipal,
			    p.flpadre,
			    p.txdescripcioncorta,
			    p.flimpuesto,
			    p.flinventario,
			    p.flimpuestoexento,
			    p.flestreg,
			    p.nolaboratorio,
			    p.nomarca,
			    p.nounidadmedidainventario,
			    p.nounidadmedidacompra,
			    p.nounidadmedidaventa,
			    p.notipo,
			    p.nocatagoria,
			    p.nocategoriahijo,
        p_colocal As colocal,
        p_coalmacen AS coalmacen,
		 p_nolocal AS nolocal,
        p_noalmacen AS noalmacen
    FROM catalogo.vw_producto p
    WHERE v.coempresa = p_coempresa
      AND v.flestreg = true
      AND (p_comarca IS NULL OR v.comarca = p_comarca)
      AND (p_coproducto IS NULL OR v.coproducto = p_coproducto)
      AND (
            p_noinputsearch IS NULL OR         
            lower(v.noproducto)      LIKE '%' || p_noinputsearch || '%' OR
            lower(v.nomodelo)        LIKE '%' || p_noinputsearch || '%' OR
            lower(v.nomarca)         LIKE '%' || p_noinputsearch || '%' OR         
            lower(v.nocodigointerno)       LIKE '%' || p_noinputsearch || '%'
      );
END;
$$;


ALTER FUNCTION catalogo.fn_producto_sel_all_by_compra(p_coempresa integer, p_comarca integer, p_noinputsearch character varying, p_cocompra integer, p_coproducto integer) OWNER TO postgres;

--
-- Name: fn_producto_sel_all_by_venta(integer, integer, integer, integer, integer, character varying, integer, integer); Type: FUNCTION; Schema: catalogo; Owner: postgres
--

CREATE FUNCTION catalogo.fn_producto_sel_all_by_venta(p_coempresa integer, p_comarca integer, p_colocal integer, p_coalmacen integer, p_cotipoprecio integer, p_noinputsearch character varying, p_coventa integer, p_coproducto integer) RETURNS TABLE(coempresa integer, coproducto integer, nocodigointerno character varying, nocodigofiscal character varying, cocategoria integer, cocategoriahijo integer, cotipo integer, comarca integer, colaboratorio integer, noproducto character varying, nomodelo character varying, counidadmedidainventario integer, counidadmedidacompra integer, counidadmedidaventa integer, ssfactorcompra numeric, ssfactorventa numeric, coproveedorprincipal integer, txdescripcioncorta character varying, flimpuesto integer, flinventario integer, flimpuestoexento integer, flestreg integer, nolaboratorio character varying, nomarca character varying, nounidadmedidainventario character varying, nounidadmedidacompra character varying, nounidadmedidaventa character varying, notipo character varying, nocatagoria character varying, nocategoriahijo character varying, ssprecio numeric, comoneda integer, qtunidad integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF p_coventa IS NULL THEN
        RAISE EXCEPTION 'falta el codigo de la venta.';
    END IF;

    IF p_noinputsearch IS NOT NULL THEN
        p_noinputsearch := lower(p_noinputsearch);
    END IF;

    RETURN QUERY
    (
        SELECT 
            	p.coempresa,
			    p.coproducto,
			    p.nocodigointerno,
			    p.nocodigofiscal,
			    p.cocategoria,
			    p.cocategoriahijo,
			    p.cotipo,
			    p.comarca,
			    p.colaboratorio,
			    p.noproducto,
			    p.nomodelo,
			    p.counidadmedidainventario,
			    p.counidadmedidacompra,
			    p.counidadmedidaventa,
			    p.ssfactorcompra,
			    p.ssfactorventa,
			    p.coproveedorprincipal,
			    p.txdescripcioncorta,
			    p.flimpuesto,
			    p.flinventario,
			    p.flimpuestoexento,
			    p.flestreg,
			    p.nolaboratorio,
			    p.nomarca,
			    p.nounidadmedidainventario,
			    p.nounidadmedidacompra,
			    p.nounidadmedidaventa,
			    p.notipo,
			    p.nocatagoria,
			    p.nocategoriahijo,
				
				pp.ssprecio,
				pp.comoneda,
				s.qtunidad
        FROM catalogo.vw_producto p
			INNER JOIN catalogo.tblproductoprecio pp ON p.coempresa = pp.coempresa 
				AND p.coproducto = pp.coproducto AND p.flestreg = true AND pp.cotipoprecio = p_cotipoprecio
			INNER JOIN inventario.tblstock s ON p.coempresa = s.coempresa 
				AND p.coproducto = s.coproducto AND s.colocal = p_colocal AND s.coalmacen = p_coalmacen        
        WHERE p.coempresa = p_coempresa                   
          AND (p_comarca IS NULL OR v.comarca = p_comarca)       
          AND (p_coproducto IS NULL OR p.coproducto = p_coproducto)
          AND (p_noinputsearch IS NULL OR (                
                lower(p.noproducto) LIKE '%'||p_noinputsearch||'%' OR
                lower(p.nomodelo) LIKE '%'||p_noinputsearch||'%' OR
                lower(p.nomarca) LIKE '%'||p_noinputsearch||'%' OR                
                lower(p.nocodigointerno) LIKE '%'||p_noinputsearch||'%'
          ))       
    );
END;
$$;


ALTER FUNCTION catalogo.fn_producto_sel_all_by_venta(p_coempresa integer, p_comarca integer, p_colocal integer, p_coalmacen integer, p_cotipoprecio integer, p_noinputsearch character varying, p_coventa integer, p_coproducto integer) OWNER TO postgres;

--
-- Name: fn_producto_sel_all_count(integer, integer, integer, character varying); Type: FUNCTION; Schema: catalogo; Owner: postgres
--

CREATE FUNCTION catalogo.fn_producto_sel_all_count(p_coempresa integer, p_coproveedorprincipal integer, p_comarca integer, p_noinputsearch character varying) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_total bigint;
BEGIN
    SELECT COUNT(1)
    INTO v_total
    FROM catalogo.vw_producto p
    WHERE p.coempresa = p_coempresa
      AND (p_coproveedorprincipal IS NULL OR p.coproveedorprincipal = p_coproveedorprincipal)
      AND (p_comarca IS NULL OR p.comarca = p_comarca)
      AND (
	  		p_noinputsearch IS NULL 
			  OR
            (
				p.noproducto ILIKE '%' || p_noinputsearch || '%' OR
	            p.nocodigointerno ILIKE '%' || p_noinputsearch || '%' OR
	            p.nocodigofiscal ILIKE '%' || p_noinputsearch || '%' 
			)
            
          );

    RETURN v_total;
END;
$$;


ALTER FUNCTION catalogo.fn_producto_sel_all_count(p_coempresa integer, p_coproveedorprincipal integer, p_comarca integer, p_noinputsearch character varying) OWNER TO postgres;

--
-- Name: fn_producto_sel_by_id(integer, integer); Type: FUNCTION; Schema: catalogo; Owner: postgres
--

CREATE FUNCTION catalogo.fn_producto_sel_by_id(p_coempresa integer, p_coproducto integer) RETURNS TABLE(coempresa integer, coproducto integer, nocodigointerno character varying, nocodigofiscal character varying, cocategoria integer, cocategoriahijo integer, cotipo integer, comarca integer, colaboratorio integer, noproducto character varying, nomodelo character varying, counidadmedidainventario integer, counidadmedidacompra integer, counidadmedidaventa integer, ssfactorcompra numeric, ssfactorventa numeric, coproveedorprincipal integer, txdescripcioncorta character varying, flimpuesto integer, flinventario integer, flimpuestoexento integer, flestreg integer, nolaboratorio character varying, nomarca character varying, nounidadmedidainventario character varying, nounidadmedidacompra character varying, nounidadmedidaventa character varying, notipo character varying, nocatagoria character varying, nocategoriahijo character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN

    RETURN QUERY
  SELECT 
            	p.coempresa,
			    p.coproducto,
			    p.nocodigointerno,
			    p.nocodigofiscal,
			    p.cocategoria,
			    p.cocategoriahijo,
			    p.cotipo,
			    p.comarca,
			    p.colaboratorio,
			    p.noproducto,
			    p.nomodelo,
			    p.counidadmedidainventario,
			    p.counidadmedidacompra,
			    p.counidadmedidaventa,
			    p.ssfactorcompra,
			    p.ssfactorventa,
			    p.coproveedorprincipal,
			    p.txdescripcioncorta,
			    p.flimpuesto,
			    p.flinventario,
			    p.flimpuestoexento,
			    p.flestreg,
			    p.nolaboratorio,
			    p.nomarca,
			    p.nounidadmedidainventario,
			    p.nounidadmedidacompra,
			    p.nounidadmedidaventa,
			    p.notipo,
			    p.nocatagoria,
			    p.nocategoriahijo
        FROM catalogo.vw_producto p    
    WHERE p.coempresa = p_coempresa 
      AND p.coproducto = p_coproducto;
END;
$$;


ALTER FUNCTION catalogo.fn_producto_sel_by_id(p_coempresa integer, p_coproducto integer) OWNER TO postgres;

--
-- Name: fn_producto_update_by_id(integer, integer, text, integer, integer, text, text, integer, integer, integer, numeric, integer, text, integer, integer, integer, smallint, smallint, text, numeric, integer, integer); Type: FUNCTION; Schema: catalogo; Owner: postgres
--

CREATE FUNCTION catalogo.fn_producto_update_by_id(p_coempresa integer, p_coproducto integer, p_nocodigointerno text, p_comarca integer, p_colaboratorio integer, p_noproducto text, p_nomodelo text, p_counidadmedidainventario integer, p_counidadmedidacompra integer, p_counidadmedidaventa integer, p_ssfactorcompra numeric, p_coproveedorprincipal integer, p_txdescripcioncorta text, p_cocategoria integer, p_cocategoriahijo integer, p_cotipo integer, p_flimpuesto smallint, p_flinventario smallint, p_nocodigofiscal text, p_ssfactorventa numeric, p_flimpuestoexento integer, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_rows integer;
    p_pqimpuesto numeric(14,4);
BEGIN
    -- Validación de duplicados
    IF catalogo.fn_producto_exist(
        p_coempresa,
        p_coproducto,
        p_cotipo,   
        p_comarca,
        p_colaboratorio,
        p_noproducto,
        p_nomodelo
    ) > 0 THEN
        RAISE EXCEPTION 'El producto ya existe.';
    END IF;

    -- Actualizar artículo
    UPDATE catalogo.tblproducto
       SET 	
		nocodigointerno = p_nocodigointerno,
		comarca = p_comarca,
		colaboratorio = p_colaboratorio,
		noproducto = p_noproducto,
		nomodelo = p_nomodelo,
		counidadmedidainventario = p_counidadmedidainventario,
		counidadmedidacompra = p_counidadmedidacompra,
		counidadmedidaventa = p_counidadmedidaventa,
		ssfactorcompra = p_ssfactorcompra,
		coproveedorprincipal = p_coproveedorprincipal,
		txdescripcioncorta = p_txdescripcioncorta,
		cocategoria = p_cocategoria,
		cocategoriahijo = p_cocategoriahijo,
		cotipo = p_cotipo,
		flimpuesto = p_flimpuesto,
		flinventario = p_flinventario,
		nocodigofiscal = p_nocodigofiscal,		
		ssfactorventa = p_ssfactorventa,
		flimpuestoexento = p_flimpuestoexento::boolean,
		cousumod = p_cousumod,
		femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
     WHERE coempresa = p_coempresa 
       AND coproducto = p_coproducto;
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION catalogo.fn_producto_update_by_id(p_coempresa integer, p_coproducto integer, p_nocodigointerno text, p_comarca integer, p_colaboratorio integer, p_noproducto text, p_nomodelo text, p_counidadmedidainventario integer, p_counidadmedidacompra integer, p_counidadmedidaventa integer, p_ssfactorcompra numeric, p_coproveedorprincipal integer, p_txdescripcioncorta text, p_cocategoria integer, p_cocategoriahijo integer, p_cotipo integer, p_flimpuesto smallint, p_flinventario smallint, p_nocodigofiscal text, p_ssfactorventa numeric, p_flimpuestoexento integer, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_producto_update_state_by_id(integer, integer, integer, integer); Type: FUNCTION; Schema: catalogo; Owner: postgres
--

CREATE FUNCTION catalogo.fn_producto_update_state_by_id(p_coempresa integer, p_coproducto integer, p_flestreg integer, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_rows integer;
BEGIN
    UPDATE catalogo.tblproducto
       SET 
	   	flestreg = p_flestreg,
		cousumod = p_cousumod,
		femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
     WHERE coempresa = p_coempresa
       AND coproducto = p_coproducto;
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION catalogo.fn_producto_update_state_by_id(p_coempresa integer, p_coproducto integer, p_flestreg integer, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_productoatributo_delete_by_id(integer, bigint, integer); Type: FUNCTION; Schema: catalogo; Owner: postgres
--

CREATE FUNCTION catalogo.fn_productoatributo_delete_by_id(p_coempresa integer, p_coproductoatributo bigint, p_cousueli integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_rows integer;
	v_old JSONB;
BEGIN
	SELECT row_to_json(x) INTO v_old
	FROM catalogo.tblproductoatributo x
	WHERE coproductoatributo = p_coproductoatributo AND coempresa = p_coempresa;

	CALL seguridad.usp_auditoria(
		p_coempresa,
		'catalogo',
		'tblproductoatributo',
		'D',
		p_cousueli,
		jsonb_build_object('coproductoatributo', p_coproductoatributo),
		v_old,
		NULL
	);

	DELETE FROM catalogo.tblproductoatributo
	WHERE coproductoatributo = p_coproductoatributo AND coempresa = p_coempresa;
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION catalogo.fn_productoatributo_delete_by_id(p_coempresa integer, p_coproductoatributo bigint, p_cousueli integer) OWNER TO postgres;

--
-- Name: fn_productoatributo_insert(integer, integer, integer, text, integer); Type: FUNCTION; Schema: catalogo; Owner: postgres
--

CREATE FUNCTION catalogo.fn_productoatributo_insert(p_coempresa integer, p_coproducto integer, p_coatributo integer, p_novalor text, p_cousucre integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_id INT;
BEGIN
	INSERT INTO catalogo.tblproductoatributo (	
		coempresa,
		coproducto,
		coatributo,
		novalor,
		coempresa,
		cousucre
	)
	VALUES (		
		p_coempresa,
		p_coproducto,
		p_coatributo,
		p_novalor,
		p_coempresa,		
		p_cousucre
	)
	RETURNING coproductoatributo INTO v_id;
	RETURN v_id;
END;
$$;


ALTER FUNCTION catalogo.fn_productoatributo_insert(p_coempresa integer, p_coproducto integer, p_coatributo integer, p_novalor text, p_cousucre integer) OWNER TO postgres;

--
-- Name: fn_productoatributo_sel_all(integer, integer); Type: FUNCTION; Schema: catalogo; Owner: postgres
--

CREATE FUNCTION catalogo.fn_productoatributo_sel_all(p_coempresa integer, p_coproducto integer) RETURNS TABLE(coproductoatributo bigint, coproducto integer, coatributo integer, novalor text, coempresa integer, flestreg integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
	RETURN QUERY
		SELECT
			coproductoatributo,
			coproducto,
			coatributo,
			novalor,
			coempresa,
			flestreg::int AS flestreg
		FROM catalogo.tblproductoatributo
		WHERE coempresa = p_coempresa AND fldelete = 0 AND coproducto = p_coproducto;
END;
$$;


ALTER FUNCTION catalogo.fn_productoatributo_sel_all(p_coempresa integer, p_coproducto integer) OWNER TO postgres;

--
-- Name: fn_productoatributo_sel_all_active(integer, integer); Type: FUNCTION; Schema: catalogo; Owner: postgres
--

CREATE FUNCTION catalogo.fn_productoatributo_sel_all_active(p_coempresa integer, p_coproducto integer) RETURNS TABLE(coproductoatributo integer, coproducto integer, coatributo integer, novalor text, coempresa integer, flestreg integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
	RETURN QUERY
		SELECT
			coproductoatributo,
			coproducto,
			coatributo,
			novalor,
			coempresa,
			flestreg::int AS flestreg
		FROM catalogo.tblproductoatributo
		WHERE coempresa = p_coempresa AND fldelete = false AND flestreg = true AND coproducto = p_coproducto;
END;
$$;


ALTER FUNCTION catalogo.fn_productoatributo_sel_all_active(p_coempresa integer, p_coproducto integer) OWNER TO postgres;

--
-- Name: fn_productoatributo_sel_by_id(integer, integer); Type: FUNCTION; Schema: catalogo; Owner: postgres
--

CREATE FUNCTION catalogo.fn_productoatributo_sel_by_id(p_coempresa integer, p_coproductoatributo integer) RETURNS TABLE(coproductoatributo integer, coproducto integer, coatributo integer, novalor text, coempresa integer, flestreg integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
	RETURN QUERY
		SELECT
			coproductoatributo,
			coproducto,
			coatributo,
			novalor,
			coempresa,
			flestreg::int AS flestreg
		FROM catalogo.tblproductoatributo
		WHERE coempresa = p_coempresa AND coproductoatributo = p_coproductoatributo;
END;
$$;


ALTER FUNCTION catalogo.fn_productoatributo_sel_by_id(p_coempresa integer, p_coproductoatributo integer) OWNER TO postgres;

--
-- Name: fn_productoatributo_update_by_id(integer, integer, integer, integer, text, integer); Type: FUNCTION; Schema: catalogo; Owner: postgres
--

CREATE FUNCTION catalogo.fn_productoatributo_update_by_id(p_coempresa integer, p_coproductoatributo integer, p_coproducto integer, p_coatributo integer, p_novalor text, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_rows integer;
BEGIN
	UPDATE catalogo.tblproductoatributo
	SET
		coproducto = p_coproducto,
		coatributo = p_coatributo,
		novalor = p_novalor,		
		cousumod = p_cousumod,
		femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
	WHERE coproductoatributo = p_coproductoatributo AND coempresa = p_coempresa;
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION catalogo.fn_productoatributo_update_by_id(p_coempresa integer, p_coproductoatributo integer, p_coproducto integer, p_coatributo integer, p_novalor text, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_productoatributo_update_state_by_id(integer, integer, integer, integer); Type: FUNCTION; Schema: catalogo; Owner: postgres
--

CREATE FUNCTION catalogo.fn_productoatributo_update_state_by_id(p_coempresa integer, p_coproductoatributo integer, p_flestreg integer, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_rows integer;
BEGIN
	UPDATE catalogo.tblproductoatributo
	SET
		flestreg = p_flestreg,
		cousumod = p_cousumod,
		femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
	WHERE coproductoatributo = p_coproductoatributo AND coempresa = p_coempresa;
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION catalogo.fn_productoatributo_update_state_by_id(p_coempresa integer, p_coproductoatributo integer, p_flestreg integer, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_productoimpuesto_delete_by_id(integer, integer, integer); Type: FUNCTION; Schema: catalogo; Owner: postgres
--

CREATE FUNCTION catalogo.fn_productoimpuesto_delete_by_id(p_coempresa integer, p_coproductoimpuesto integer, p_cousueli integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_rows integer;
	v_old JSONB;
BEGIN
	SELECT row_to_json(x) INTO v_old
	FROM catalogo.tblproductoimpuesto x
	WHERE coempresa = p_coempresa AND coproductoimpuesto = p_coproductoimpuesto;

	CALL seguridad.usp_auditoria(
		p_coempresa,
		'catalogo',
		'tblproductoimpuesto',
		'D',
		p_cousueli,
		jsonb_build_object('coproductoimpuesto', p_coproductoimpuesto),
		v_old,
		NULL
	);

	DELETE FROM catalogo.tblproductoimpuesto
	WHERE coempresa = p_coempresa AND coproductoimpuesto = p_coproductoimpuesto;
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION catalogo.fn_productoimpuesto_delete_by_id(p_coempresa integer, p_coproductoimpuesto integer, p_cousueli integer) OWNER TO postgres;

--
-- Name: fn_productoimpuesto_insert(integer, integer, integer, integer, numeric, integer); Type: FUNCTION; Schema: catalogo; Owner: postgres
--

CREATE FUNCTION catalogo.fn_productoimpuesto_insert(p_coempresa integer, p_coproducto integer, p_coimpuesto integer, p_coimpuestohijo integer, p_pqtaza numeric, p_cousucre integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_id INT;
BEGIN
	INSERT INTO catalogo.tblproductoimpuesto (
		coempresa,		
		coproducto,
		coimpuesto,
		coimpuestohijo,
		pqtaza,
		cousucre
	)
	VALUES (
		p_coempresa,		
		p_coproducto,
		p_coimpuesto,
		p_coimpuestohijo,
		p_pqtaza,
		p_cousucre
	)
	RETURNING coproductoimpuesto INTO v_id;
	RETURN v_id;
END;
$$;


ALTER FUNCTION catalogo.fn_productoimpuesto_insert(p_coempresa integer, p_coproducto integer, p_coimpuesto integer, p_coimpuestohijo integer, p_pqtaza numeric, p_cousucre integer) OWNER TO postgres;

--
-- Name: fn_productoimpuesto_sel_all(integer, integer); Type: FUNCTION; Schema: catalogo; Owner: postgres
--

CREATE FUNCTION catalogo.fn_productoimpuesto_sel_all(p_coempresa integer, p_coproducto integer) RETURNS TABLE(coempresa integer, coproductoimpuesto integer, coproducto integer, coimpuesto integer, coimpuestohijo integer, flestreg integer, pqtaza numeric)
    LANGUAGE plpgsql
    AS $$
BEGIN
	RETURN QUERY
		SELECT
			coempresa,
			coproductoimpuesto,
			coproducto,
			coimpuesto,
			coimpuestohijo,
			flestreg::int AS flestreg,
			pqtaza
		FROM catalogo.tblproductoimpuesto
		WHERE coempresa = p_coempresa AND fldelete = 0 AND coproducto = p_coproducto;
END;
$$;


ALTER FUNCTION catalogo.fn_productoimpuesto_sel_all(p_coempresa integer, p_coproducto integer) OWNER TO postgres;

--
-- Name: fn_productoimpuesto_sel_all_active(integer, integer); Type: FUNCTION; Schema: catalogo; Owner: postgres
--

CREATE FUNCTION catalogo.fn_productoimpuesto_sel_all_active(p_coempresa integer, p_coproducto integer) RETURNS TABLE(coempresa integer, coproductoimpuesto integer, coproducto integer, coimpuesto integer, coimpuestohijo integer, flestreg integer, pqtaza numeric)
    LANGUAGE plpgsql
    AS $$
BEGIN
	RETURN QUERY
		SELECT
			coempresa,
			coproductoimpuesto,
			coproducto,
			coimpuesto,
			coimpuestohijo,
			flestreg::int AS flestreg,
			pqtaza
		FROM catalogo.tblproductoimpuesto
		WHERE coempresa = p_coempresa AND fldelete = false AND flestreg = true AND coproducto = p_coproducto;
END;
$$;


ALTER FUNCTION catalogo.fn_productoimpuesto_sel_all_active(p_coempresa integer, p_coproducto integer) OWNER TO postgres;

--
-- Name: fn_productoimpuesto_sel_by_id(integer, integer); Type: FUNCTION; Schema: catalogo; Owner: postgres
--

CREATE FUNCTION catalogo.fn_productoimpuesto_sel_by_id(p_coempresa integer, p_coproductoimpuesto integer) RETURNS TABLE(coempresa integer, coproductoimpuesto integer, coproducto integer, coimpuesto integer, coimpuestohijo integer, flestreg integer, pqtaza numeric)
    LANGUAGE plpgsql
    AS $$
BEGIN
	RETURN QUERY
		SELECT
			coempresa,
			coproductoimpuesto,
			coproducto,
			coimpuesto,
			coimpuestohijo,
			flestreg::int AS flestreg,
			pqtaza
		FROM catalogo.tblproductoimpuesto
		WHERE coempresa = p_coempresa AND coempresa = p_coempresa AND coproductoimpuesto = p_coproductoimpuesto;
END;
$$;


ALTER FUNCTION catalogo.fn_productoimpuesto_sel_by_id(p_coempresa integer, p_coproductoimpuesto integer) OWNER TO postgres;

--
-- Name: fn_productoimpuesto_update_by_id(integer, integer, integer, integer, numeric, integer); Type: FUNCTION; Schema: catalogo; Owner: postgres
--

CREATE FUNCTION catalogo.fn_productoimpuesto_update_by_id(p_coempresa integer, p_coproductoimpuesto integer, p_coimpuesto integer, p_coimpuestohijo integer, p_pqtaza numeric, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_rows integer;
BEGIN
	UPDATE catalogo.tblproductoimpuesto
	SET		
		coimpuesto = p_coimpuesto,
		coimpuestohijo = p_coimpuestohijo,		
		pqtaza = p_pqtaza,
		cousumod = p_cousumod,
		femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
	WHERE coempresa = p_coempresa AND coproductoimpuesto = p_coproductoimpuesto;
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION catalogo.fn_productoimpuesto_update_by_id(p_coempresa integer, p_coproductoimpuesto integer, p_coimpuesto integer, p_coimpuestohijo integer, p_pqtaza numeric, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_productoimpuesto_update_state_by_id(integer, integer, integer, integer); Type: FUNCTION; Schema: catalogo; Owner: postgres
--

CREATE FUNCTION catalogo.fn_productoimpuesto_update_state_by_id(p_coempresa integer, p_coproductoimpuesto integer, p_flestreg integer, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_rows integer;
BEGIN
	UPDATE catalogo.tblproductoimpuesto
	SET
		flestreg = p_flestreg,
		cousumod = p_cousumod,
		femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
	WHERE coempresa = p_coempresa AND coproductoimpuesto = p_coproductoimpuesto;
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION catalogo.fn_productoimpuesto_update_state_by_id(p_coempresa integer, p_coproductoimpuesto integer, p_flestreg integer, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_productoindex_update(integer); Type: FUNCTION; Schema: catalogo; Owner: postgres
--

CREATE FUNCTION catalogo.fn_productoindex_update(p_coproducto integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_coempresa INT;
    v_cocategoria INT;
    v_noproducto TEXT;
    v_txdescripcioncorta TEXT;
BEGIN
    -- Datos base del producto
    SELECT coempresa, cocategoria, noproducto, txdescripcioncorta
    INTO v_coempresa, v_cocategoria, v_noproducto, v_txdescripcioncorta
    FROM catalogo.tblproducto
    WHERE coproducto = p_coproducto;

    -- Construir JSON con atributos
    WITH attrs AS (
        SELECT ca.noatributo, pa.novalor
        FROM catalogo.tblproductoatributo pa
        JOIN catalogo.tblatributo ca ON pa.coatributo = ca.coatributo
        WHERE pa.coproducto = p_coproducto
    )
    INSERT INTO catalogo.tblproductoindex(coproducto, coempresa, cocategoria, noproducto, txdescripcioncorta, jsonatributo, txbusqueda)
    VALUES (
        p_coproducto,
        v_coempresa,
        v_cocategoria,
        v_noproducto,
        v_txdescripcioncorta,
        (SELECT jsonb_object_agg(noatributo, novalor) FROM attrs),
        to_tsvector('spanish', coalesce(v_noproducto,'') || ' ' || coalesce(v_txdescripcioncorta,''))
    )
    ON CONFLICT (coproducto) DO UPDATE
    SET coempresa = EXCLUDED.coempresa,
        cocategoria = EXCLUDED.cocategoria,
        noproducto = EXCLUDED.noproducto,
        txdescripcioncorta = EXCLUDED.txdescripcioncorta,
        jsonatributo = EXCLUDED.jsonatributo,
        txbusqueda = EXCLUDED.txbusqueda;
END;
$$;


ALTER FUNCTION catalogo.fn_productoindex_update(p_coproducto integer) OWNER TO postgres;

--
-- Name: fn_productoprecio_delete_by_id(integer, integer, integer); Type: FUNCTION; Schema: catalogo; Owner: postgres
--

CREATE FUNCTION catalogo.fn_productoprecio_delete_by_id(p_coempresa integer, p_coproductoprecio integer, p_cousueli integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
Declare
	v_old JSONB; 
	v_rows integer;
begin

SELECT row_to_json(x) INTO v_old
    FROM catalogo.tblproductoprecio x
    WHERE coempresa = p_coempresa And coproductoprecio = p_coproductoprecio;

    CALL seguridad.usp_auditoria(
 		p_coempresa,	-- Empresa
        'catalogo',                          -- Esquema
		'tblproductoprecio',                  -- tabla
		'D',                        -- acción
        p_cousueli,                        -- usuario
        jsonb_build_object('coproductoprecio', p_coproductoprecio),
        v_old,
        NULL
    );

Delete From catalogo.tblproductoprecio where coempresa = p_coempresa and coproductoprecio = p_coproductoprecio;
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
 
end;
$$;


ALTER FUNCTION catalogo.fn_productoprecio_delete_by_id(p_coempresa integer, p_coproductoprecio integer, p_cousueli integer) OWNER TO postgres;

--
-- Name: fn_productoprecio_sel_all(integer, integer); Type: FUNCTION; Schema: catalogo; Owner: postgres
--

CREATE FUNCTION catalogo.fn_productoprecio_sel_all(p_coempresa integer, p_coproducto integer) RETURNS TABLE(coempresa integer, coproductoprecio integer, cotipoprecio integer, coproducto integer, ssprecio numeric, flestreg integer, comoneda integer, moneda character varying, nosimbolo character varying, notipoprecio character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
   	SELECT
	   pp.coempresa,
	   pp.coproductoprecio,
	   pp.cotipoprecio,
	   pp.coproducto,
	   pp.ssprecio,
	   pp.flestreg,
	   pp.comoneda,
	   m.moneda, 
	   m.nosimbolo,
	   tipoprecio.notipo AS notipoprecio
	FROM catalogo.tblproductoprecio pp
		INNER JOIN maestro.trfmoneda m ON pp.comoneda = m.comoneda
		INNER JOIN maestro.vw_tipoparticular tipoprecio ON tipoprecio.coempresa = pp.coempresa
			AND tipoprecio.cotipo = pp.cotipoprecio AND tipoprecio.cogrupo = 39
	Where pp.coempresa = p_coempresa
		AND  pp.coproducto = p_coproducto;
END;
$$;


ALTER FUNCTION catalogo.fn_productoprecio_sel_all(p_coempresa integer, p_coproducto integer) OWNER TO postgres;

--
-- Name: fn_productoprecio_sel_by_id(integer, integer); Type: FUNCTION; Schema: catalogo; Owner: postgres
--

CREATE FUNCTION catalogo.fn_productoprecio_sel_by_id(p_coempresa integer, p_coproductoprecio integer) RETURNS TABLE(coempresa integer, coproductoprecio integer, cotipoprecio integer, coproducto integer, ssprecio numeric, flestreg integer, comoneda integer, moneda character varying, nosimbolo character varying, notipoprecio character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
   	SELECT
	   pp.coempresa,
	   pp.coproductoprecio,
	   pp.cotipoprecio,
	   pp.coproducto,
	   pp.ssprecio,
	   pp.flestreg::int,
	   pp.comoneda,
	   m.moneda, 
	   m.nosimbolo,
	   tipoprecio.notipo AS notipoprecio
	FROM catalogo.tblproductoprecio pp
		INNER JOIN maestro.trfmoneda m ON pp.comoneda = m.comoneda
		INNER JOIN maestro.vw_tipoparticular tipoprecio ON tipoprecio.coempresa = pp.coempresa
			AND tipoprecio.cotipo = pp.cotipoprecio AND tipoprecio.cogrupo = 39
	Where pp.coempresa = p_coempresa
		AND  pp.coproductoprecio = p_coproductoprecio;
END;
$$;


ALTER FUNCTION catalogo.fn_productoprecio_sel_by_id(p_coempresa integer, p_coproductoprecio integer) OWNER TO postgres;

--
-- Name: fn_productoprecio_update_by_id(integer, integer, integer, integer, numeric, integer, integer); Type: FUNCTION; Schema: catalogo; Owner: postgres
--

CREATE FUNCTION catalogo.fn_productoprecio_update_by_id(p_coempresa integer, p_coproductoprecio integer, p_cotipoprecio integer, p_coproducto integer, p_ssprecio numeric, p_comoneda integer, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_rows integer;
BEGIN
    UPDATE catalogo.tblproductoprecio
    SET
        cotipoprecio = p_cotipoprecio,
		comoneda = p_comoneda,
        ssprecio     = p_ssprecio,
        cousumod     = p_cousumod,
        femod        = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    WHERE coempresa = p_coempresa 
      AND coproductoprecio = p_coproductoprecio;
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION catalogo.fn_productoprecio_update_by_id(p_coempresa integer, p_coproductoprecio integer, p_cotipoprecio integer, p_coproducto integer, p_ssprecio numeric, p_comoneda integer, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_productoprecio_update_state_by_id(integer, integer, integer, integer); Type: FUNCTION; Schema: catalogo; Owner: postgres
--

CREATE FUNCTION catalogo.fn_productoprecio_update_state_by_id(p_coempresa integer, p_coproductoprecio integer, p_flestreg integer, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_rows integer;
BEGIN
    UPDATE catalogo.tblproductoprecio
    SET 
        flestreg = p_flestreg::boolean,
        cousumod = p_cousumod,
        femod    = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    WHERE coempresa = p_coempresa
      AND coproductoprecio = p_coproductoprecio;
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION catalogo.fn_productoprecio_update_state_by_id(p_coempresa integer, p_coproductoprecio integer, p_flestreg integer, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_productostock_delete_by_id(integer, integer, integer); Type: FUNCTION; Schema: catalogo; Owner: postgres
--

CREATE FUNCTION catalogo.fn_productostock_delete_by_id(p_coempresa integer, p_coproductostock integer, p_cousueli integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
Declare
	v_old JSONB; 
	v_rows integer;
begin

	SELECT row_to_json(x) INTO v_old
    FROM catalogo.tblproductostock x
    WHERE coempresa = p_coempresa And coproductostock = p_coproductostock;

    CALL seguridad.usp_auditoria(
 		p_coempresa,	-- Empresa
        'catalogo',                          -- Esquema
		'tblproductostock',                  -- tabla
		'D',                        -- acción
        p_cousueli,                        -- usuario
        jsonb_build_object('coproductostock', p_coproductostock),
        v_old,
        NULL
    );

	delete from catalogo.tblproductostock where coempresa = p_coempresa and coproductostock = p_coproductostock;
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
 
end;
$$;


ALTER FUNCTION catalogo.fn_productostock_delete_by_id(p_coempresa integer, p_coproductostock integer, p_cousueli integer) OWNER TO postgres;

--
-- Name: fn_productostock_insert(integer, integer, integer, integer, integer, integer, integer, integer, integer); Type: FUNCTION; Schema: catalogo; Owner: postgres
--

CREATE FUNCTION catalogo.fn_productostock_insert(p_coempresa integer, p_coproducto integer, p_colocal integer, p_coalmacen integer, p_qtinicial integer, p_qtmaxima integer, p_qtminima integer, p_fldefault integer, p_cousucre integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE 	
    v_qt integer;
	v_coproductostock BIGINT;
BEGIN
 
		select count(1) into v_qt from catalogo.tblarticulostock  where coempresa = p_coempresa and  coproducto = p_coproducto;

		if v_qt = 0 THen
			p_fldefault = 1;
		else			
			if p_fldefault = 1 Then			
				UPDATE catalogo.tblarticulostock 
				SET fldefault = false  
				WHERE coempresa = p_coempresa 
					AND coproducto = p_coproducto;
			end if;
		End if;
	/*end*/

	insert into catalogo.tblarticulostock (
		coempresa,		
		coproducto,
		coalmacen,
		colocal,
		qtinicial,
		qtmaxima,
		qtminima,
		fldefault,
		cousucre
	)
	values 
	(
		p_coempresa,		
		p_coproducto,
		p_coalmacen,
		p_colocal,
		p_qtinicial,
		p_qtmaxima,
		p_qtminima,
		p_fldefault::boolean,
		p_cousucre
	) 
	RETURNING coproductostock INTO v_coproductostock;

	RETURN v_coproductostock;
	
END;
$$;


ALTER FUNCTION catalogo.fn_productostock_insert(p_coempresa integer, p_coproducto integer, p_colocal integer, p_coalmacen integer, p_qtinicial integer, p_qtmaxima integer, p_qtminima integer, p_fldefault integer, p_cousucre integer) OWNER TO postgres;

--
-- Name: fn_productostock_sel_all(integer, integer); Type: FUNCTION; Schema: catalogo; Owner: postgres
--

CREATE FUNCTION catalogo.fn_productostock_sel_all(p_coempresa integer, p_coproducto integer) RETURNS TABLE(coproductostock integer, coempresa integer, coproducto integer, coalmacen integer, colocal integer, nolocal text, noalmacen text, qtinicial numeric, qtmaxima numeric, qtminima numeric, fldefault integer, flestreg integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        s.coproductostock,
        s.coempresa,
        s.coproducto,
        s.coalmacen,
        s.colocal,
        l.nolocal,
        a.noalmacen,
        s.qtinicial,
        s.qtmaxima,
        s.qtminima,
        s.fldefault::int,
        s.flestreg::int
    FROM catalogo.tblarticulostock s
    INNER JOIN empresa.trflocal l ON s.coempresa = l.coempresa AND s.colocal = l.colocal
    INNER JOIN inventario.tblalmacen a ON s.coempresa = a.coempresa AND s.coalmacen = a.coalmacen
    WHERE s.coempresa = p_coempresa     
      AND s.coproducto = p_coproducto;
END;
$$;


ALTER FUNCTION catalogo.fn_productostock_sel_all(p_coempresa integer, p_coproducto integer) OWNER TO postgres;

--
-- Name: fn_productostock_sel_all_active(integer, integer); Type: FUNCTION; Schema: catalogo; Owner: postgres
--

CREATE FUNCTION catalogo.fn_productostock_sel_all_active(p_coempresa integer, p_coproducto integer) RETURNS TABLE(coproductostock integer, coempresa integer, coproducto integer, coalmacen integer, colocal integer, nolocal text, noalmacen text, qtinicial numeric, qtmaxima numeric, qtminima numeric, fldefault integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        s.coproductostock,
        s.coempresa,
        s.coproducto,
        s.coalmacen,
        s.colocal,
        l.nolocal,
        a.noalmacen,
        s.qtinicial,
        s.qtmaxima,
        s.qtminima,
        s.fldefault::int
    FROM catalogo.tblproductostock s
    INNER JOIN empresa.trflocal l ON s.coempresa = l.coempresa AND s.colocal = l.colocal
    INNER JOIN inventario.tblalmacen a ON s.coempresa = a.coempresa  AND s.coalmacen = a.coalmacen
    WHERE s.coempresa = p_coempresa
      AND s.coproducto = p_coproducto
      AND s.flestreg = true;
END;
$$;


ALTER FUNCTION catalogo.fn_productostock_sel_all_active(p_coempresa integer, p_coproducto integer) OWNER TO postgres;

--
-- Name: fn_productostock_sel_by_id(integer, integer); Type: FUNCTION; Schema: catalogo; Owner: postgres
--

CREATE FUNCTION catalogo.fn_productostock_sel_by_id(p_coempresa integer, p_coproductostock integer) RETURNS TABLE(coproductostock integer, coempresa integer, coproducto integer, coalmacen integer, colocal integer, qtinicial numeric, qtmaxima numeric, qtminima numeric, fldefault integer, flestreg integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
       s.coproductostock,
        s.coempresa,
        s.coproducto,
        s.coalmacen,
        s.colocal,
        l.nolocal,
        a.noalmacen,
        s.qtinicial,
        s.qtmaxima,
        s.qtminima,
        s.fldefault::int,
        s.flestreg::int
     FROM catalogo.tblarticulostock s
    WHERE s.coempresa = p_coempresa
      AND s.coproductostock = p_coproductostock;
END;
$$;


ALTER FUNCTION catalogo.fn_productostock_sel_by_id(p_coempresa integer, p_coproductostock integer) OWNER TO postgres;

--
-- Name: fn_productostock_update_by_id(integer, integer, integer, integer, integer, numeric, numeric, numeric, integer, integer); Type: FUNCTION; Schema: catalogo; Owner: postgres
--

CREATE FUNCTION catalogo.fn_productostock_update_by_id(p_coempresa integer, p_coproductostock integer, p_coproducto integer, p_colocal integer, p_coalmacen integer, p_qtinicial numeric, p_qtmaxima numeric, p_qtminima numeric, p_fldefault integer, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_rows integer;
    v_colocal INT;
    v_qt INT;
BEGIN
    -- Obtener colocal desde tblalmacen
    SELECT colocal 
    INTO v_colocal
    FROM inventario.tblalmacen
    WHERE coempresa = p_coempresa 
      AND coalmacen = p_coalmacen;
    
    p_colocal := v_colocal;

    -- Contar articulostock existentes
    SELECT COUNT(1)
    INTO v_qt
    FROM catalogo.tblproductostock
    WHERE coempresa = p_coempresa
      AND coproducto = p_coproducto;

    IF v_qt = 0 THEN
        p_fldefault := 1;
    ELSE
        IF p_fldefault = 1 THEN
            -- Resetear fldefault de otros registros
            UPDATE catalogo.tblproductostock
            SET fldefault = false
            WHERE coempresa = p_coempresa
              AND coproducto = p_coproducto
              AND coproductostock <> p_coproductostock;
        END IF;
    END IF;

    -- Actualizar productostock
    UPDATE catalogo.tblproductostock
    SET
        coalmacen   = p_coalmacen,
        colocal     = p_colocal,
        qtinicial   = p_qtinicial,
        qtmaxima    = p_qtmaxima,
        qtminima    = p_qtminima,
        fldefault   = p_fldefault::boolean,
        cousumod    = p_cousumod,
        femod       = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    WHERE coempresa = p_coempresa
      AND coproductostock = p_coproductostock;

	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION catalogo.fn_productostock_update_by_id(p_coempresa integer, p_coproductostock integer, p_coproducto integer, p_colocal integer, p_coalmacen integer, p_qtinicial numeric, p_qtmaxima numeric, p_qtminima numeric, p_fldefault integer, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_productoterminado_delete_by_id(integer, integer, integer); Type: FUNCTION; Schema: catalogo; Owner: postgres
--

CREATE FUNCTION catalogo.fn_productoterminado_delete_by_id(p_coempresa integer, p_coproductoterminado integer, p_cousueli integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
Declare
	v_old JSONB;
	v_rows integer;
begin

SELECT row_to_json(x) INTO v_old
    FROM catalogo.tblproductoterminado x
    WHERE coempresa = p_coempresa And coproductoterminado = p_coproductoterminado;

    CALL seguridad.usp_auditoria(
 		p_coempresa,	-- Empresa
        'catalogo',                          -- Esquema
		'tblproductoterminado',                  -- tabla
		'D',                        -- acción
        p_cousueli,                        -- usuario
        jsonb_build_object('coproductoterminado', p_coproductoterminado),
        v_old,
        NULL
    );

	Delete from catalogo.tblproductoterminado where coempresa= p_coempresa and  coproductoterminado = p_coproductoterminado;
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
 
end;
$$;


ALTER FUNCTION catalogo.fn_productoterminado_delete_by_id(p_coempresa integer, p_coproductoterminado integer, p_cousueli integer) OWNER TO postgres;

--
-- Name: fn_productoterminado_insert(integer, integer, integer, integer, integer, integer); Type: FUNCTION; Schema: catalogo; Owner: postgres
--

CREATE FUNCTION catalogo.fn_productoterminado_insert(p_coempresa integer, p_coproductopadre integer, p_nuorden integer, p_coproducto integer, p_qtproducto integer, p_cousucre integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE 	
    v_coproductoterminado integer;
BEGIN

insert into catalogo.tblproductoterminado (
	coempresa,	
	coproductopadre,
	nuorden,
	coproducto,
	qtproducto,
	cousucre
)
values 
(
	p_coempresa,	
	p_coproductopadre,
	p_nuorden,
	p_coproducto,
	p_qtproducto,
	p_cousucre

) 
	RETURNING coproductoterminado INTO v_coproductoterminado;

	RETURN v_coproductoterminado;
	
END;
$$;


ALTER FUNCTION catalogo.fn_productoterminado_insert(p_coempresa integer, p_coproductopadre integer, p_nuorden integer, p_coproducto integer, p_qtproducto integer, p_cousucre integer) OWNER TO postgres;

--
-- Name: fn_productoterminado_sel_all(integer, integer); Type: FUNCTION; Schema: catalogo; Owner: postgres
--

CREATE FUNCTION catalogo.fn_productoterminado_sel_all(p_coempresa integer, p_coproductopadre integer) RETURNS TABLE(coproductoterminado integer, coempresa integer, nuorden integer, coproductopadre integer, coproducto integer, noproducto text, nomarca integer, nounidadmedidainventario text, tproducto integer, flestreg integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
  SELECT
        pt.coproductoterminado,
        pt.coempresa,
        pt.nuorden,
        pt.coproductopadre,
        pt.coproducto,
        p.noproducto,     
        p.nomarca,
        p.nounidadmedidainventario,
        pt.qtproducto,
        pt.flestreg::int
    FROM catalogo.tblproductoterminado pt
    INNER JOIN catalogo.vw_producto p  ON pt.coempresa = p.coempresa AND pt.coproducto = p.coproducto
    WHERE pt.coempresa = p_coempresa
      AND pt.coproductopadre = p_coproductopadre;
END;
$$;


ALTER FUNCTION catalogo.fn_productoterminado_sel_all(p_coempresa integer, p_coproductopadre integer) OWNER TO postgres;

--
-- Name: fn_productoterminado_sel_by_id(integer, integer); Type: FUNCTION; Schema: catalogo; Owner: postgres
--

CREATE FUNCTION catalogo.fn_productoterminado_sel_by_id(p_coempresa integer, p_coproductoterminado integer) RETURNS TABLE(coproductoterminado integer, coempresa integer, nuorden integer, coproductopadre integer, coproducto integer, noproducto text, nomarca integer, nounidadmedidainventario text, tproducto integer, flestreg integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
     SELECT
        pt.coproductoterminado,
        pt.coempresa,
        pt.nuorden,
        pt.coproductopadre,
        pt.coproducto,
        p.noproducto,     
        p.nomarca,
        p.nounidadmedidainventario,
        pt.qtproducto,
        pt.flestreg::int
    FROM catalogo.tblproductoterminado pt
    INNER JOIN catalogo.vw_producto p  ON pt.coempresa = p.coempresa AND pt.coproducto = p.coproducto
    WHERE pt.coempresa = p_coempresa
      AND pt.coproductopadre = p_coproductopadre;
  
END;
$$;


ALTER FUNCTION catalogo.fn_productoterminado_sel_by_id(p_coempresa integer, p_coproductoterminado integer) OWNER TO postgres;

--
-- Name: fn_productoterminado_update_by_id(integer, integer, integer, integer, integer, integer, integer); Type: FUNCTION; Schema: catalogo; Owner: postgres
--

CREATE FUNCTION catalogo.fn_productoterminado_update_by_id(p_coempresa integer, p_coproductoterminado integer, p_coproductopadre integer, p_nuorden integer, p_coproducto integer, p_qtproducto integer, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_rows integer;
BEGIN
    UPDATE catalogo.tblproductoterminado
    SET
        nuorden = p_nuorden,
        coproducto = p_coproducto,
        qtproducto = p_qtproducto,
        cousumod = p_cousumod,
        femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    WHERE coempresa = p_coempresa
      AND coproductoterminado = p_coproductoterminado;
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION catalogo.fn_productoterminado_update_by_id(p_coempresa integer, p_coproductoterminado integer, p_coproductopadre integer, p_nuorden integer, p_coproducto integer, p_qtproducto integer, p_cousumod integer) OWNER TO postgres;

--
-- Name: trg_productoindex_change(); Type: FUNCTION; Schema: catalogo; Owner: postgres
--

CREATE FUNCTION catalogo.trg_productoindex_change() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Llamar a la función que actualiza el índice del producto
    PERFORM catalogo.fn_update_producto_index(NEW.producto_id);

    RETURN NEW;
END;
$$;


ALTER FUNCTION catalogo.trg_productoindex_change() OWNER TO postgres;

--
-- Name: fn_moneda_primaria(); Type: FUNCTION; Schema: contabilidad; Owner: postgres
--

CREATE FUNCTION contabilidad.fn_moneda_primaria() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN 604;
END;
$$;


ALTER FUNCTION contabilidad.fn_moneda_primaria() OWNER TO postgres;

--
-- Name: fn_moneda_secundaria(); Type: FUNCTION; Schema: contabilidad; Owner: postgres
--

CREATE FUNCTION contabilidad.fn_moneda_secundaria() RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN 840;
END;
$$;


ALTER FUNCTION contabilidad.fn_moneda_secundaria() OWNER TO postgres;

--
-- Name: fn_plancontable_delete_by_id(integer, integer); Type: FUNCTION; Schema: contabilidad; Owner: postgres
--

CREATE FUNCTION contabilidad.fn_plancontable_delete_by_id(p_coplancontable integer, p_cousueli integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
Declare
	v_old JSONB;
	v_rows integer;
BEGIN

	SELECT row_to_json(x) INTO v_old
    FROM contabilidad.trfplancontable x
    WHERE coplancontable = p_coplancontable;

    CALL seguridad.usp_auditoria(
 		0,	-- Empresa
        'contabilidad',                          -- Esquema
		'trfplancontable',                  -- tabla
		'D',                        -- acción
        p_cousueli,                        -- usuario
        jsonb_build_object('coplancontable', p_coplancontable),
        v_old,
        NULL
    );

    Delete From contabilidad.trfplancontable WHERE coplancontable = p_coplancontable;
	
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION contabilidad.fn_plancontable_delete_by_id(p_coplancontable integer, p_cousueli integer) OWNER TO postgres;

--
-- Name: fn_plancontable_insert(integer, character varying, character varying, integer, integer); Type: FUNCTION; Schema: contabilidad; Owner: postgres
--

CREATE FUNCTION contabilidad.fn_plancontable_insert(p_coelemento integer, p_cocuenta character varying, p_nocuenta character varying, p_cotipocuenta integer, p_cousucre integer) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
DECLARE 	
    v_coplancontable BIGINT;
BEGIN
    INSERT INTO contabilidad.trfplancontable (
        coelemento,
        cocuenta,
        nocuenta,
        cotipocuenta,
        cousucre
    )
    VALUES (
        p_coelemento,
        p_cocuenta,
        p_nocuenta,
        p_cotipocuenta,
        p_cousucre
    )
    RETURNING coplancontable INTO v_coplancontable;

    RETURN v_coplancontable;
END;
$$;


ALTER FUNCTION contabilidad.fn_plancontable_insert(p_coelemento integer, p_cocuenta character varying, p_nocuenta character varying, p_cotipocuenta integer, p_cousucre integer) OWNER TO postgres;

--
-- Name: fn_plancontable_sel_all(integer, integer, integer, integer); Type: FUNCTION; Schema: contabilidad; Owner: postgres
--

CREATE FUNCTION contabilidad.fn_plancontable_sel_all(p_coelemento integer, p_cotipocuenta integer, p_pagesize integer, p_pageindex integer) RETURNS TABLE(rowscount bigint, pagesize integer, pageindex integer, coplancontable integer, coelemento integer, cocuenta character varying, nocuenta character varying, cotipocuenta integer, coestreg integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    WITH dataa AS (
        SELECT
            t.coplancontable,
            t.coelemento,
            t.cocuenta,
            t.nocuenta,
            t.cotipocuenta,
            t.coestreg
        FROM contabilidad.trfplancontable t
        WHERE (p_coelemento IS NULL OR t.coelemento = p_coelemento)
          AND (p_cotipocuenta IS NULL OR t.cotipocuenta = p_cotipocuenta)
    ),
    counta AS (
        SELECT COUNT(1) AS rowscount FROM dataa
    )
    SELECT
        c.rowscount,
        p_pagesize AS pagesize,
        p_pageindex AS pageindex,
        d.coplancontable,
        d.coelemento,
        d.cocuenta,
        d.nocuenta,
        d.cotipocuenta,
        d.coestreg
    FROM dataa d
    CROSS JOIN counta c
    ORDER BY d.coplancontable
    LIMIT p_pagesize
    OFFSET p_pageindex * p_pagesize;
END;
$$;


ALTER FUNCTION contabilidad.fn_plancontable_sel_all(p_coelemento integer, p_cotipocuenta integer, p_pagesize integer, p_pageindex integer) OWNER TO postgres;

--
-- Name: fn_plancontable_sel_all_active(integer, integer); Type: FUNCTION; Schema: contabilidad; Owner: postgres
--

CREATE FUNCTION contabilidad.fn_plancontable_sel_all_active(p_coelemento integer, p_cotipocuenta integer) RETURNS TABLE(coplancontable integer, coelemento integer, cocuenta character varying, nocuenta character varying, cotipocuenta integer, coestreg integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        t.coplancontable,
        t.coelemento,
        t.cocuenta,
        t.nocuenta,
        t.cotipocuenta,
        t.coestreg
    FROM contabilidad.trfplancontable t
    WHERE (p_coelemento IS NULL OR t.coelemento = p_coelemento)
      AND (p_cotipocuenta IS NULL OR t.cotipocuenta = p_cotipocuenta);
END;
$$;


ALTER FUNCTION contabilidad.fn_plancontable_sel_all_active(p_coelemento integer, p_cotipocuenta integer) OWNER TO postgres;

--
-- Name: fn_plancontable_sel_by_id(integer); Type: FUNCTION; Schema: contabilidad; Owner: postgres
--

CREATE FUNCTION contabilidad.fn_plancontable_sel_by_id(p_coplancontable integer) RETURNS TABLE(coplancontable integer, coelemento integer, cocuenta character varying, nocuenta character varying, cotipocuenta integer, coestreg integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        t.coplancontable,
        t.coelemento,
        t.cocuenta,
        t.nocuenta,
        t.cotipocuenta,
        t.coestreg
    FROM contabilidad.trfplancontable t
    WHERE t.coplancontable = p_coplancontable;
END;
$$;


ALTER FUNCTION contabilidad.fn_plancontable_sel_by_id(p_coplancontable integer) OWNER TO postgres;

--
-- Name: fn_plancontable_update_by_id(integer, integer, character varying, character varying, integer, integer); Type: FUNCTION; Schema: contabilidad; Owner: postgres
--

CREATE FUNCTION contabilidad.fn_plancontable_update_by_id(p_coplancontable integer, p_coelemento integer, p_cocuenta character varying, p_nocuenta character varying, p_cotipocuenta integer, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_rows integer;
BEGIN
    UPDATE contabilidad.trfplancontable
    SET
        coelemento  = p_coelemento,
        cocuenta    = p_cocuenta,
        nocuenta    = p_nocuenta,
        cotipocuenta= p_cotipocuenta,
        cousumod    = p_cousumod,
        femod       = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    WHERE coplancontable = p_coplancontable;
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION contabilidad.fn_plancontable_update_by_id(p_coplancontable integer, p_coelemento integer, p_cocuenta character varying, p_nocuenta character varying, p_cotipocuenta integer, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_plancontable_update_state_by_id(integer, integer, integer); Type: FUNCTION; Schema: contabilidad; Owner: postgres
--

CREATE FUNCTION contabilidad.fn_plancontable_update_state_by_id(p_coplancontable integer, p_coestreg integer, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_rows integer;
BEGIN
    UPDATE contabilidad.trfplancontable
    SET coestreg = p_coestreg,
        cousumod = p_cousumod,
        femod    = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    WHERE coplancontable = p_coplancontable;
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION contabilidad.fn_plancontable_update_state_by_id(p_coplancontable integer, p_coestreg integer, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_tipocambio_delete_by_id(integer, integer, integer); Type: FUNCTION; Schema: contabilidad; Owner: postgres
--

CREATE FUNCTION contabilidad.fn_tipocambio_delete_by_id(p_coempresa integer, p_cotipocambio integer, p_cousueli integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
Declare
	v_old JSONB;
	v_rows integer;
BEGIN

	SELECT row_to_json(x) INTO v_old
    FROM contabilidad.trftipocambio x
    WHERE coempresa = p_coempresa And cotipocambio = p_cotipocambio;

    CALL seguridad.usp_auditoria(
 		p_coempresa,	-- Empresa
        'contabilidad',                          -- Esquema
		'trftipocambio',                  -- tabla
		'D',                        -- acción
        p_cousueli,                        -- usuario
        jsonb_build_object('cotipocambio', p_cotipocambio),
        v_old,
        NULL
    );

    Delete From contabilidad.trftipocambio WHERE coempresa = p_coempresa AND cotipocambio = p_cotipocambio;
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION contabilidad.fn_tipocambio_delete_by_id(p_coempresa integer, p_cotipocambio integer, p_cousueli integer) OWNER TO postgres;

--
-- Name: fn_tipocambio_insert(integer, integer, character varying, numeric, numeric, smallint, integer); Type: FUNCTION; Schema: contabilidad; Owner: postgres
--

CREATE FUNCTION contabilidad.fn_tipocambio_insert(p_coempresa integer, p_comoneda integer, p_fetipocambio character varying, p_sstipocambiocompra numeric, p_sstipocambioventa numeric, p_flautomatico smallint, p_cousucre integer) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
DECLARE 	
    v_cotipocambio BIGINT;
BEGIN

    INSERT INTO contabilidad.trftipocambio (
        coempresa,
        cotipocambio,
        comoneda,
        fetipocambio,
        sstipocambiocompra,
        sstipocambioventa,
        flautomatico,
        cousucre
    )
    VALUES (
        p_coempresa,
        v_cotipocambio,
        p_comoneda,
        p_fetipocambio,
        p_sstipocambiocompra,
        p_sstipocambioventa,
        p_flautomatico,
        p_cousucre
    )
    RETURNING cotipocambio INTO v_cotipocambio;

    RETURN v_cotipocambio;
END;

$$;


ALTER FUNCTION contabilidad.fn_tipocambio_insert(p_coempresa integer, p_comoneda integer, p_fetipocambio character varying, p_sstipocambiocompra numeric, p_sstipocambioventa numeric, p_flautomatico smallint, p_cousucre integer) OWNER TO postgres;

--
-- Name: fn_tipocambio_insert_by_fecha(integer, integer, character varying); Type: FUNCTION; Schema: contabilidad; Owner: postgres
--

CREATE FUNCTION contabilidad.fn_tipocambio_insert_by_fecha(p_coempresa integer, p_comoneda integer, p_fetipocambio character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_cotipocambio INT;
    v_sstipocambiocompra NUMERIC(5,3);
    v_sstipocambioventa NUMERIC(5,3);
BEGIN
    -- Buscar si ya existe el tipo de cambio en esa fecha
    SELECT cotipocambio,
           sstipocambiocompra,
           sstipocambioventa
    INTO v_cotipocambio,
         v_sstipocambiocompra,
         v_sstipocambioventa
    FROM contabilidad.trftipocambio
    WHERE coempresa   = p_coempresa     
      AND coestreg    = 1
      AND comoneda    = p_comoneda
      AND fetipocambio= p_fetipocambio
    LIMIT 1;

    -- Si no existe, tomar el último tipo de cambio
    IF v_cotipocambio IS NULL THEN
        SELECT sstipocambiocompra,
               sstipocambioventa
        INTO v_sstipocambiocompra,
             v_sstipocambioventa
        FROM contabilidad.trftipocambio
        WHERE coempresa = p_coempresa         
          AND coestreg  = 1
          AND comoneda  = p_comoneda
          AND fetipocambio = (
              SELECT MAX(fetipocambio)
              FROM contabilidad.trftipocambio
              WHERE coempresa = p_coempresa
                AND coestreg  = 1              
                AND comoneda  = p_comoneda
          )
        LIMIT 1;

        -- Si tampoco hay anterior, valores por defecto
        IF v_sstipocambiocompra IS NULL THEN
            v_sstipocambiocompra := 1;
            v_sstipocambioventa  := 1;
        END IF;

        -- Insertar nuevo tipo de cambio reutilizando la otra función
        v_cotipocambio := contabilidad.fn_tipocambio_insert(
            p_coempresa,
            p_comoneda,
            p_fetipocambio,
            v_sstipocambiocompra,
            v_sstipocambioventa,
            1,
            -100
        );
    END IF;

    RETURN v_cotipocambio;
END;
$$;


ALTER FUNCTION contabilidad.fn_tipocambio_insert_by_fecha(p_coempresa integer, p_comoneda integer, p_fetipocambio character varying) OWNER TO postgres;

--
-- Name: fn_tipocambio_sel_all(integer, character varying, integer, integer); Type: FUNCTION; Schema: contabilidad; Owner: postgres
--

CREATE FUNCTION contabilidad.fn_tipocambio_sel_all(p_coempresa integer, p_fetipocambiomes character varying, p_pagesize integer, p_pageindex integer) RETURNS TABLE(rowscount bigint, pagesize integer, pageindex integer, coempresa integer, cotipocambio integer, comoneda integer, fetipocambio character varying, fetipocambiomes character varying, sstipocambiocompra numeric, sstipocambioventa numeric, flautomatico boolean, coestreg integer, nomoneda character varying, nomonedasigla character varying)
    LANGUAGE plpgsql
    AS $$
begin
    return query
    with dataa as (
        select  
            t.coempresa,
            t.cotipocambio,
            t.comoneda,
            t.fetipocambio,
            substring(t.fetipocambio,1,6) as fetipocambiomes,
            t.sstipocambiocompra,
            t.sstipocambioventa,
            t.flautomatico,
            t.coestreg,
            m.notipo as nomoneda,
            m.nosigla as nomonedasigla
        from contabilidad.trftipocambio t
        left join vw_tipogeneral m 
            on t.comoneda = m.cotipo and m.d = 'contabilidad.tipomoneda'
        where t.coempresa = p_coempresa
          and (p_fetipocambiomes is null or substring(t.fetipocambio,1,6) = p_fetipocambiomes)
    ), 
    counta as (
        select count(1) as rowscount from dataa
    )
    select 
        b.rowscount,
        p_pagesize as pagesize,
        p_pageindex as pageindex,
        a.*
    from dataa a
    cross join counta b
    order by a.cotipocambio
    limit p_pagesize
    offset (p_pageindex) * p_pagesize;
end;
$$;


ALTER FUNCTION contabilidad.fn_tipocambio_sel_all(p_coempresa integer, p_fetipocambiomes character varying, p_pagesize integer, p_pageindex integer) OWNER TO postgres;

--
-- Name: fn_tipocambio_sel_by_id(integer, integer); Type: FUNCTION; Schema: contabilidad; Owner: postgres
--

CREATE FUNCTION contabilidad.fn_tipocambio_sel_by_id(p_coempresa integer, p_cotipocambio integer) RETURNS TABLE(coempresa integer, cotipocambio integer, comoneda integer, fetipocambio character varying, sstipocambiocompra numeric, sstipocambioventa numeric)
    LANGUAGE plpgsql
    AS $$
begin
    return query
    select 
        t.coempresa,
        t.cotipocambio,
        t.comoneda,
        t.fetipocambio,
        t.sstipocambiocompra,
        t.sstipocambioventa
    from contabilidad.trftipocambio t
    where t.coempresa = p_coempresa
      and t.cotipocambio = p_cotipocambio;
end;
$$;


ALTER FUNCTION contabilidad.fn_tipocambio_sel_by_id(p_coempresa integer, p_cotipocambio integer) OWNER TO postgres;

--
-- Name: fn_tipocambio_sel_last(integer, integer, character varying); Type: FUNCTION; Schema: contabilidad; Owner: postgres
--

CREATE FUNCTION contabilidad.fn_tipocambio_sel_last(p_coempresa integer, p_comoneda integer, p_fetipocambio character varying) RETURNS TABLE(coempresa integer, cotipocambio integer, fetipocambio character varying, sstipocambiocompra numeric, sstipocambioventa numeric)
    LANGUAGE plpgsql
    AS $$
declare
    v_cotipocambio int;
begin
    -- Llamada al procedimiento/función que inserta o devuelve el último tipo de cambio
    -- Aquí asumo que en PostgreSQL lo migraste como función que devuelve int
    -- Ejemplo: contabilidad.usp_tipocambio_insertbyfecha(...) retorna el nuevo cotipocambio
    v_cotipocambio := contabilidad.usp_tipocambio_insert_by_fecha(
                          p_coempresa,
                          p_comoneda,
                          p_fetipocambio
                      );

    -- Si prefieres, puedes usar directamente fntipocambiolastbyfecha()
    -- p_cotipocambio := contabilidad.fntipocambiolastbyfecha(p_coempresa, p_comoneda, p_fetipocambio);

    return query
    select 
        t.coempresa,
        t.cotipocambio,
        t.fetipocambio,
        t.sstipocambiocompra,
        t.sstipocambioventa
    from contabilidad.trftipocambio t
    where t.coempresa = p_coempresa
      and t.cotipocambio = v_cotipocambio;
end;
$$;


ALTER FUNCTION contabilidad.fn_tipocambio_sel_last(p_coempresa integer, p_comoneda integer, p_fetipocambio character varying) OWNER TO postgres;

--
-- Name: fn_tipocambio_update_by_id(integer, integer, integer, character varying, numeric, numeric, integer); Type: FUNCTION; Schema: contabilidad; Owner: postgres
--

CREATE FUNCTION contabilidad.fn_tipocambio_update_by_id(p_coempresa integer, p_cotipocambio integer, p_comoneda integer, p_fetipocambio character varying, p_sstipocambiocompra numeric, p_sstipocambioventa numeric, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
Declare	
	v_rows integer;
begin
    update contabilidad.trftipocambio
    set sstipocambiocompra = p_sstipocambiocompra,
        sstipocambioventa = p_sstipocambioventa,
        fetipocambio      = p_fetipocambio,
        comoneda          = p_comoneda,
        cousumod          = p_cousumod,    
        flautomatico      = 0,
        femod             = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    where coempresa = p_coempresa
      and cotipocambio = p_cotipocambio;
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
end;
$$;


ALTER FUNCTION contabilidad.fn_tipocambio_update_by_id(p_coempresa integer, p_cotipocambio integer, p_comoneda integer, p_fetipocambio character varying, p_sstipocambiocompra numeric, p_sstipocambioventa numeric, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_bandejaentrada_delete_by_id(integer, integer, integer); Type: FUNCTION; Schema: empresa; Owner: postgres
--

CREATE FUNCTION empresa.fn_bandejaentrada_delete_by_id(p_coempresa integer, p_cobandejaentrada integer, p_cousueli integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
Declare	
	v_rows integer;
	v_old JSONB;
begin

	SELECT row_to_json(x) INTO v_old
	FROM empresa.tblbandejaentrada x
	WHERE coempresa = p_coempresa and cobandejaentrada = p_cobandejaentrada;

	CALL seguridad.usp_auditoria(
		p_coempresa,
		'empresa',
		'tblbandejaentrada',
		'D',
        p_cousueli,
		jsonb_build_object('_cobandejaentrada', p_cobandejaentrada),
		v_old,
		NULL
	);

Delete From empresa.tblbandejaentrada where coempresa = p_coempresa and cobandejaentrada = p_cobandejaentrada;
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;

end;
$$;


ALTER FUNCTION empresa.fn_bandejaentrada_delete_by_id(p_coempresa integer, p_cobandejaentrada integer, p_cousueli integer) OWNER TO postgres;

--
-- Name: fn_bandejaentrada_sel_all(integer, character varying, integer, integer); Type: FUNCTION; Schema: empresa; Owner: postgres
--

CREATE FUNCTION empresa.fn_bandejaentrada_sel_all(p_coempresa integer, p_nopersona character varying, p_coestreg integer, p_flfavorito integer) RETURNS TABLE(cobandejaentrada integer, coempresa integer, nopersona character varying, noemail character varying, notelefono character varying, noasunto character varying, coservicio integer, noserviciopadre character varying, noservicio character varying, coetiqueta integer, flfavorito integer, nomensaje character varying, noetiqueta character varying, fecre character varying, coestreg integer)
    LANGUAGE plpgsql
    AS $$
 Begin
	
return query
select 	
	be.cobandejaentrada,
	be.coempresa,
	be.nopersona,
	be.noemail,
	be.notelefono,
	be.noasunto,
	be.coservicio,
	servicio.notipo as noserviciopadre,
	servicio.nosubtipo as noservicio,
	be.coetiqueta,
	be.flfavorito,
	be.nomensaje,
	et.notipo as noetiqueta,
	format(be.fecre,'yyyymmddhhmmss') as fecre,	
	be.coestreg
from  empresa.tblbandejaentrada be
	left join vw_tipo et on be.coempresa = et.coempresa and  be.coetiqueta = et.cotipo  and et.d ='empresa.bandejaetiqueta' 
	left join vw_subtipo servicio on servicio.coempresa = be.coempresa  and servicio.cotipo = be.coservicio  and servicio.d = 'empresa.subservicio'
where be.coempresa = p_coempresa
 and ( p_nopersona is null or dbo.funmayuscula(be.nopersona) like '%' + p_nopersona + '%')
  and ( p_nopersona is null or dbo.funmayuscula(be.noemail) like '%' + p_nopersona + '%')
 and ( p_nopersona is null or dbo.funmayuscula(be.noasunto) like '%' + p_nopersona + '%')
  and ( p_nopersona is null or dbo.funmayuscula(be.nomensaje) like '%' + p_nopersona + '%')
    and ( p_flfavorito is null or be.flfavorito = p_flfavorito)
	 and ( p_coestreg is null or be.coestreg = p_coestreg);

end;
$$;


ALTER FUNCTION empresa.fn_bandejaentrada_sel_all(p_coempresa integer, p_nopersona character varying, p_coestreg integer, p_flfavorito integer) OWNER TO postgres;

--
-- Name: fn_bandejaentrada_sel_by_id(integer, integer); Type: FUNCTION; Schema: empresa; Owner: postgres
--

CREATE FUNCTION empresa.fn_bandejaentrada_sel_by_id(p_coempresa integer, p_cobandejaentrada integer) RETURNS TABLE(cobandejaentrada integer, coempresa integer, nopersona character varying, noemail character varying, notelefono character varying, noasunto character varying, coservicio integer, noserviciopadre character varying, noservicio character varying, coetiqueta integer, flfavorito integer, nomensaje character varying, noetiqueta character varying, fecre character varying, coestreg integer)
    LANGUAGE plpgsql
    AS $$
 Begin
 return query
select 	
	be.cobandejaentrada,
	be.coempresa,
	be.nopersona,
	be.noemail,
	be.notelefono,
	be.noasunto,
	be.coservicio,
	servicio.notipo as noserviciopadre,
	servicio.nosubtipo as noservicio,
	be.coetiqueta,
	be.flfavorito,
	be.nomensaje,
	et.notipo as noetiqueta,
	format(be.fecre,'yyyymmddhhmmss') as fecre,
	be.coestreg
from  empresa.tblbandejaentrada be 
		left join vw_tipo et on be.coempresa = et.coempresa and  be.coetiqueta = et.cotipo  and et.d ='empresa.bandejaetiqueta' 
		left join vw_subtipo servicio on servicio.coempresa = be.coempresa  and servicio.cotipo = be.coservicio  and servicio.d = 'empresa.subservicio'
where be.coempresa = p_coempresa and	be.cobandejaentrada = p_cobandejaentrada;

end;
$$;


ALTER FUNCTION empresa.fn_bandejaentrada_sel_by_id(p_coempresa integer, p_cobandejaentrada integer) OWNER TO postgres;

--
-- Name: fn_bandejaentrada_sel_qt_unread(integer); Type: FUNCTION; Schema: empresa; Owner: postgres
--

CREATE FUNCTION empresa.fn_bandejaentrada_sel_qt_unread(p_coempresa integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
declare 
    p_qt int;
begin
    select count(1)
    into p_qt
    from empresa.tblbandejaentrada be
    where be.coestreg = 1
      and be.coempresa = p_coempresa;

    return p_qt;
end;
$$;


ALTER FUNCTION empresa.fn_bandejaentrada_sel_qt_unread(p_coempresa integer) OWNER TO postgres;

--
-- Name: fn_bandejaentrada_update_favorito(integer, integer, integer, integer); Type: FUNCTION; Schema: empresa; Owner: postgres
--

CREATE FUNCTION empresa.fn_bandejaentrada_update_favorito(p_coempresa integer, p_cobandejaentrada integer, p_flfavorito integer, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_rows integer;
begin

   UPDATE empresa.tblbandejaentrada
      SET flfavorito = p_flfavorito,
          cousumod = p_cousumod,
          femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    WHERE coempresa = p_coempresa and cobandejaentrada = p_cobandejaentrada;
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
end;
$$;


ALTER FUNCTION empresa.fn_bandejaentrada_update_favorito(p_coempresa integer, p_cobandejaentrada integer, p_flfavorito integer, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_bandejaentrada_update_state_by_id(integer, integer, integer, integer); Type: FUNCTION; Schema: empresa; Owner: postgres
--

CREATE FUNCTION empresa.fn_bandejaentrada_update_state_by_id(p_coempresa integer, p_cobandejaentrada integer, p_coestreg integer, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
Declare	
	v_rows integer;
begin

   update empresa.tblbandejaentrada
      set coestreg = p_coestreg,
          cousumod = p_cousumod,
          femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    where coempresa = p_coempresa and cobandejaentrada = p_cobandejaentrada;
		GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;

end;
$$;


ALTER FUNCTION empresa.fn_bandejaentrada_update_state_by_id(p_coempresa integer, p_cobandejaentrada integer, p_coestreg integer, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_blog_delete_by_id(integer, integer, integer); Type: FUNCTION; Schema: empresa; Owner: postgres
--

CREATE FUNCTION empresa.fn_blog_delete_by_id(p_coempresa integer, p_coblog integer, p_cousueli integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
Declare
	v_rows integer;
	v_old JSONB;
begin

SELECT row_to_json(x) INTO v_old
    FROM empresa.tblblog x
    WHERE coempresa = p_coempresa And coblog = p_coblog;

    CALL seguridad.usp_auditoria(
 		p_coempresa,	-- Empresa
        'empresa',                          -- Esquema
		'tblblog',                  -- tabla
		'D',                        -- acción
        p_cousueli,                        -- usuario
        jsonb_build_object('coblog', p_coblog),
        v_old,
        NULL
    );

Delete From empresa.tblblog where coempresa = p_coempresa and coblog = p_coblog;
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;

end;
$$;


ALTER FUNCTION empresa.fn_blog_delete_by_id(p_coempresa integer, p_coblog integer, p_cousueli integer) OWNER TO postgres;

--
-- Name: fn_blog_insert(integer, integer, integer, character varying, character varying, character varying, character, integer, integer); Type: FUNCTION; Schema: empresa; Owner: postgres
--

CREATE FUNCTION empresa.fn_blog_insert(p_coempresa integer, p_coservicio integer, p_cosubservicio integer, p_notitulo character varying, p_txblog character varying, p_noideacentral character varying, p_feblog character, p_coautor integer, p_cousucre integer) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
DECLARE 	
    v_coblog BIGINT;
begin

	insert into empresa.tblblog (
		coempresa,
		coservicio,
		cosubservicio,
		notitulo,
		txblog,
		feblog,
		noideacentral,
		coautor,
		cousucre
	)	
	values 
	(
		p_coempresa,	
		p_coservicio,
		p_cosubservicio,
		p_notitulo,
		p_txblog,
		p_feblog,
		p_noideacentral,
		p_coautor,
		p_cousucre

	)
	RETURNING coblog INTO v_coblog;

	RETURN v_coblog;
	
END;
$$;


ALTER FUNCTION empresa.fn_blog_insert(p_coempresa integer, p_coservicio integer, p_cosubservicio integer, p_notitulo character varying, p_txblog character varying, p_noideacentral character varying, p_feblog character, p_coautor integer, p_cousucre integer) OWNER TO postgres;

--
-- Name: fn_blog_sel_all(integer, integer, integer); Type: FUNCTION; Schema: empresa; Owner: postgres
--

CREATE FUNCTION empresa.fn_blog_sel_all(p_coempresa integer, p_pagesize integer, p_pageindex integer) RETURNS TABLE(rowscount bigint, coblog integer, coempresa integer, coservicio integer, cosubservicio integer, noservicio text, nosubservicio text, notitulo text, txblog text, noideacentral text, feblog date, coautor integer, noautor text, coestreg integer, pagesize integer, pageindex integer)
    LANGUAGE plpgsql
    AS $$
Begin
return query
    with dataa as (
        select 
            tblblog.coblog,
            tblblog.coempresa,
            tblblog.coservicio,
            tblblog.cosubservicio,
            servicio.notipo as noservicio,
            subservicio.notipo as nosubservicio,
            tblblog.notitulo,
            tblblog.txblog,
            tblblog.noideacentral,
            tblblog.feblog,
            tblblog.coautor,
            coalesce(pe.nopersona,'') || ' ' || coalesce(pe.noapellidop,'') || ' ' || coalesce(pe.noapellidom,'') as noautor,
            tblblog.coestreg
        from empresa.tblblog 
        left join maestro.vw_tipo servicio 
            on servicio.coempresa = tblblog.coempresa  
           and servicio.cotipo = tblblog.coservicio  
           and servicio.d = 'empresa.servicio'
        left join maestro.vw_tipo subservicio 
            on subservicio.coempresa = tblblog.coempresa  
           and subservicio.cotipo = tblblog.cosubservicio  
           and subservicio.d = 'empresa.subservicio'
        left join maestro.tblpersona pe 
            on tblblog.coempresa =  pe.coempresa
           and tblblog.coautor =  pe.copersona
        where tblblog.coempresa = p_coempresa
    ), 
    counta as (
        select count(1) as rowscount from dataa
    )
    select 
        b.rowscount,
        a.coblog,
        a.coempresa,
        a.coservicio,
        a.cosubservicio,
        a.noservicio,
        a.nosubservicio,
        a.notitulo,
        a.txblog,
        a.noideacentral,
        a.feblog,
        a.coautor,
        a.noautor,
        a.coestreg,
        p_pagesize as pagesize,
        p_pageindex as pageindex
    from dataa a
    cross join counta b
    order by a.coblog
    offset (p_pageindex) * p_pagesize
    limit p_pagesize;
End;
$$;


ALTER FUNCTION empresa.fn_blog_sel_all(p_coempresa integer, p_pagesize integer, p_pageindex integer) OWNER TO postgres;

--
-- Name: fn_blog_sel_by_id(integer, integer); Type: FUNCTION; Schema: empresa; Owner: postgres
--

CREATE FUNCTION empresa.fn_blog_sel_by_id(p_coempresa integer, p_coblog integer) RETURNS TABLE(coblog integer, coempresa integer, coservicio integer, cosubservicio integer, notitulo text, txblog text, noideacentral text, feblog timestamp without time zone, coautor integer, coestreg integer, noautor text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT  
        b.coblog,
        b.coempresa,
        b.coservicio,
        b.cosubservicio,
        b.notitulo,
        b.txblog,
        b.noideacentral,
        b.feblog,
        b.coautor,
        b.coestreg,      
        COALESCE(p.nopersona, '') || ' ' || COALESCE(p.noapellidop, '') || ' ' || COALESCE(p.noapellidom, '') AS noautor
    FROM empresa.tblblog b
    LEFT JOIN maestros.tblpersona p
        ON b.coempresa = p.coempresa 
       AND b.coautor = p.copersona 
       AND p.flsitreg = 'a'
    WHERE b.coempresa = p_coempresa
      AND b.coblog = p_coblog;
END;
$$;


ALTER FUNCTION empresa.fn_blog_sel_by_id(p_coempresa integer, p_coblog integer) OWNER TO postgres;

--
-- Name: fn_blog_update_by_id(integer, integer, integer, integer, character varying, character varying, character varying, character, integer, bigint); Type: FUNCTION; Schema: empresa; Owner: postgres
--

CREATE FUNCTION empresa.fn_blog_update_by_id(p_coempresa integer, p_coblog integer, p_coservicio integer, p_cosubservicio integer, p_notitulo character varying, p_txblog character varying, p_noideacentral character varying, p_feblog character, p_coautor integer, p_cousumod bigint) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_rows integer;
BEGIN
    UPDATE empresa.tblblog
    SET
        coservicio   = p_coservicio,
        cosubservicio= p_cosubservicio,
        notitulo     = p_notitulo,
        txblog       = p_txblog,
        feblog       = p_feblog,
        noideacentral= p_noideacentral,
        coautor      = p_coautor,
        cousumod     = p_cousumod,
        femod        = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    WHERE coempresa = p_coempresa
      AND coblog    = p_coblog;
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION empresa.fn_blog_update_by_id(p_coempresa integer, p_coblog integer, p_coservicio integer, p_cosubservicio integer, p_notitulo character varying, p_txblog character varying, p_noideacentral character varying, p_feblog character, p_coautor integer, p_cousumod bigint) OWNER TO postgres;

--
-- Name: fn_blog_update_state_by_id(integer, integer, integer, integer); Type: FUNCTION; Schema: empresa; Owner: postgres
--

CREATE FUNCTION empresa.fn_blog_update_state_by_id(p_coempresa integer, p_coblog integer, p_coestreg integer, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_rows integer;
BEGIN
    UPDATE empresa.tblblog
    SET 
        coestreg = p_coestreg,
        cousumod = p_cousumod,
        femod    = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    WHERE coempresa = p_coempresa 
      AND coblog    = p_coblog;

  
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION empresa.fn_blog_update_state_by_id(p_coempresa integer, p_coblog integer, p_coestreg integer, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_blogmensaje_sel_all(integer, integer); Type: FUNCTION; Schema: empresa; Owner: postgres
--

CREATE FUNCTION empresa.fn_blogmensaje_sel_all(p_coempresa integer, p_coblog integer) RETURNS TABLE(coblogmensaje integer, coempresa integer, coblog integer, nopersona character varying, nomensaje character varying, noemail character varying, coestreg integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT  
        bm.coblogmensaje,
        bm.coempresa,
        bm.coblog,
        bm.nopersona,
        bm.nomensaje,
        bm.noemail,
        bm.coestreg
    FROM empresa.tblblogmensaje bm
    WHERE bm.flsitreg = 'a'
      AND bm.coempresa = p_coempresa
      AND bm.coblog    = p_coblog;
END;
$$;


ALTER FUNCTION empresa.fn_blogmensaje_sel_all(p_coempresa integer, p_coblog integer) OWNER TO postgres;

--
-- Name: fn_blogmensaje_sel_by_id(integer, integer); Type: FUNCTION; Schema: empresa; Owner: postgres
--

CREATE FUNCTION empresa.fn_blogmensaje_sel_by_id(p_coempresa integer, p_coblogmensaje integer) RETURNS TABLE(coblogmensaje integer, coempresa integer, coblog integer, nopersona character varying, nomensaje character varying, noemail character varying, coestreg integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT  
        bm.coblogmensaje,
        bm.coempresa,
        bm.coblog,
        bm.nopersona,
        bm.nomensaje,
        bm.noemail,
        bm.coestreg
    FROM empresa.tblblogmensaje bm
    WHERE bm.coempresa     = p_coempresa
      AND bm.coblogmensaje = p_coblogmensaje;
END;
$$;


ALTER FUNCTION empresa.fn_blogmensaje_sel_by_id(p_coempresa integer, p_coblogmensaje integer) OWNER TO postgres;

--
-- Name: fn_cliente_delete_by_id(integer, integer, integer); Type: FUNCTION; Schema: empresa; Owner: postgres
--

CREATE FUNCTION empresa.fn_cliente_delete_by_id(p_coempresa integer, p_cocliente integer, p_cousueli integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
Declare
	v_rows integer;
	v_old JSONB;
BEGIN

	SELECT row_to_json(x) INTO v_old
    FROM empresa.tblcliente x
    WHERE coempresa = p_coempresa And cocliente = p_cocliente;

    CALL seguridad.usp_auditoria(
 		p_coempresa,	-- Empresa
        'empresa',                          -- Esquema
		'tblcliente',                  -- tabla
		'D',                        -- acción
        p_cousueli,                        -- usuario
        jsonb_build_object('cocliente', p_cocliente),
        v_old,
        NULL
    );

    Delete From empresa.tblcliente WHERE coempresa = p_coempresa AND cocliente = p_cocliente;
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION empresa.fn_cliente_delete_by_id(p_coempresa integer, p_cocliente integer, p_cousueli integer) OWNER TO postgres;

--
-- Name: fn_cliente_insert(integer, character varying, character varying, character varying, integer, integer); Type: FUNCTION; Schema: empresa; Owner: postgres
--

CREATE FUNCTION empresa.fn_cliente_insert(p_coempresa integer, p_nocliente character varying, p_nocargo character varying, p_txopinion character varying, p_flopinion integer, p_cousucre integer) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
DECLARE 	
    v_cocliente BIGINT;
begin

insert into empresa.tblcliente (
	coempresa,	
	nocliente,
	nocargo,
	txopinion,
	flopinion,
	cousucre
)
values 
(
	p_coempresa,	
	p_nocliente,
	p_nocargo,
	p_txopinion,
	p_flopinion,
	p_cousucre

) 	
RETURNING cocliente INTO v_cocliente;

	RETURN v_cocliente;
	
END;
$$;


ALTER FUNCTION empresa.fn_cliente_insert(p_coempresa integer, p_nocliente character varying, p_nocargo character varying, p_txopinion character varying, p_flopinion integer, p_cousucre integer) OWNER TO postgres;

--
-- Name: fn_cliente_sel_all(integer, integer, integer); Type: FUNCTION; Schema: empresa; Owner: postgres
--

CREATE FUNCTION empresa.fn_cliente_sel_all(p_coempresa integer, p_pagesize integer, p_pageindex integer) RETURNS TABLE(rowscount bigint, cocliente integer, coempresa integer, nocliente character varying, nocargo character varying, txopinion text, flopinion character varying, coestreg integer, fecre character varying, pagesize integer, pageindex integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    WITH dataa AS (
        SELECT
            c.cocliente,
            c.coempresa,
            c.nocliente,
            c.nocargo,
            c.txopinion,
            c.flopinion,
            c.coestreg,
            TO_CHAR(c.fecre, 'YYYYMMDDHH24MISS') AS fecre
        FROM empresa.tblcliente c
        WHERE c.coempresa = p_coempresa
    ),
    counta AS (
        SELECT COUNT(1) AS rowscount FROM dataa
    )
    SELECT
        b.rowscount,
        a.cocliente,
        a.coempresa,
        a.nocliente,
        a.nocargo,
        a.txopinion,
        a.flopinion,
        a.coestreg,
        a.fecre,
        p_pagesize,
        p_pageindex
    FROM dataa a
    CROSS JOIN counta b
    ORDER BY a.cocliente
    OFFSET (p_pageindex) * p_pagesize
    FETCH NEXT p_pagesize ROWS ONLY;
END;
$$;


ALTER FUNCTION empresa.fn_cliente_sel_all(p_coempresa integer, p_pagesize integer, p_pageindex integer) OWNER TO postgres;

--
-- Name: fn_cliente_sel_by_id(integer, integer); Type: FUNCTION; Schema: empresa; Owner: postgres
--

CREATE FUNCTION empresa.fn_cliente_sel_by_id(p_coempresa integer, p_cocliente integer) RETURNS TABLE(cocliente integer, coempresa integer, nocliente character varying, nocargo character varying, txopinion text, flopinion character varying, coestreg integer, fecre character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT  
        c.cocliente,
        c.coempresa,
        c.nocliente,
        c.nocargo,
        c.txopinion,
        c.flopinion,
        c.coestreg,      
        TO_CHAR(c.fecre, 'YYYYMMDDHH24MISS') AS fecre
    FROM empresa.tblcliente c
    WHERE c.coempresa = p_coempresa
      AND c.cocliente = p_cocliente;
END;
$$;


ALTER FUNCTION empresa.fn_cliente_sel_by_id(p_coempresa integer, p_cocliente integer) OWNER TO postgres;

--
-- Name: fn_cliente_update_by_id(integer, integer, character varying, character varying, character varying, integer, integer); Type: FUNCTION; Schema: empresa; Owner: postgres
--

CREATE FUNCTION empresa.fn_cliente_update_by_id(p_coempresa integer, p_cocliente integer, p_nocliente character varying, p_nocargo character varying, p_txopinion character varying, p_flopinion integer, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_rows integer;
BEGIN
    UPDATE empresa.tblcliente
    SET
        nocliente = p_nocliente,
        nocargo   = p_nocargo,
        txopinion = p_txopinion,
        flopinion = p_flopinion,
        cousumod  = p_cousumod,
        femod     = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    WHERE coempresa = p_coempresa
      AND cocliente = p_cocliente;
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION empresa.fn_cliente_update_by_id(p_coempresa integer, p_cocliente integer, p_nocliente character varying, p_nocargo character varying, p_txopinion character varying, p_flopinion integer, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_cliente_update_state_by_id(integer, integer, integer, integer); Type: FUNCTION; Schema: empresa; Owner: postgres
--

CREATE FUNCTION empresa.fn_cliente_update_state_by_id(p_coempresa integer, p_cocliente integer, p_coestreg integer, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_rows integer;
BEGIN
    UPDATE empresa.tblcliente
    SET 
        coestreg = p_coestreg,
        cousumod = p_cousumod,
        femod    = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    WHERE coempresa = p_coempresa 
      AND cocliente = p_cocliente;
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION empresa.fn_cliente_update_state_by_id(p_coempresa integer, p_cocliente integer, p_coestreg integer, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_equipo_delete_by_id(integer, integer, integer); Type: FUNCTION; Schema: empresa; Owner: postgres
--

CREATE FUNCTION empresa.fn_equipo_delete_by_id(p_coempresa integer, p_coequipo integer, p_cousueli integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
Declare
	v_rows integer;
	v_old JSONB;
begin

	SELECT row_to_json(x) INTO v_old
    FROM empresa.tblequipo x
    WHERE coempresa = p_coempresa And coequipo = p_coequipo;

    CALL seguridad.usp_auditoria(
 		p_coempresa,	-- Empresa
        'empresa',                          -- Esquema
		'tblequipo',                  -- tabla
		'D',                        -- acción
        p_cousueli,                        -- usuario
        jsonb_build_object('coequipo', p_coequipo),
        v_old,
        NULL
    );

delete from empresa.tblequipo
where coempresa = p_coempresa  and coequipo = p_coequipo;
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
end;
$$;


ALTER FUNCTION empresa.fn_equipo_delete_by_id(p_coempresa integer, p_coequipo integer, p_cousueli integer) OWNER TO postgres;

--
-- Name: fn_equipo_insert(integer, integer, character varying, integer); Type: FUNCTION; Schema: empresa; Owner: postgres
--

CREATE FUNCTION empresa.fn_equipo_insert(p_coempresa integer, p_copersona integer, p_noextracto character varying, p_cousucre integer) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
DECLARE 	
    v_coequipo BIGINT;
BEGIN


insert into empresa.tblequipo (
	coempresa,
	coequipo,
	copersona,
	noextracto,
	cousucre
)
values 
(
	p_coempresa,
	p_coequipo,
	p_copersona,
	p_noextracto,
	p_cousucre

) 
	RETURNING coequipo INTO v_coequipo;

	RETURN v_coequipo;
	
END;
$$;


ALTER FUNCTION empresa.fn_equipo_insert(p_coempresa integer, p_copersona integer, p_noextracto character varying, p_cousucre integer) OWNER TO postgres;

--
-- Name: fn_equipo_sel_all(integer, integer, integer); Type: FUNCTION; Schema: empresa; Owner: postgres
--

CREATE FUNCTION empresa.fn_equipo_sel_all(p_coempresa integer, p_pagesize integer, p_pageindex integer) RETURNS TABLE(rowscount bigint, coequipo integer, coempresa integer, copersona integer, persona_nopersona character varying, persona_noapellidop character varying, persona_noapellidom character varying, persona_noprofesion character varying, noextracto text, coestreg integer, pagesize integer, pageindex integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    WITH dataa AS (
        SELECT  
            e.coequipo,
            e.coempresa,
            e.copersona,
            p.nopersona       AS persona_nopersona,
            p.noapellidop     AS persona_noapellidop,
            p.noapellidom     AS persona_noapellidom,
            p.noprofesion     AS persona_noprofesion,      
            e.noextracto,
            e.coestreg
        FROM empresa.tblequipo e
        INNER JOIN maestros.vwpersona p 
            ON e.coempresa = p.coempresa 
           AND e.copersona = p.copersona
        WHERE e.coempresa = p_coempresa 
    ),
    counta AS (
        SELECT COUNT(1) AS rowscount FROM dataa
    )
    SELECT
        b.rowscount,
        a.coequipo,
        a.coempresa,
        a.copersona,
        a.persona_nopersona,
        a.persona_noapellidop,
        a.persona_noapellidom,
        a.persona_noprofesion,
        a.persona_noarchivo,
        a.persona_noextension,
        a.noextracto,
        a.coestreg,
        p_pagesize,
        p_pageindex
    FROM dataa a
    CROSS JOIN counta b
    ORDER BY a.coequipo
    OFFSET (p_pageindex) * p_pagesize
    FETCH NEXT p_pagesize ROWS ONLY;
END;
$$;


ALTER FUNCTION empresa.fn_equipo_sel_all(p_coempresa integer, p_pagesize integer, p_pageindex integer) OWNER TO postgres;

--
-- Name: fn_equipo_sel_by_id(integer, integer); Type: FUNCTION; Schema: empresa; Owner: postgres
--

CREATE FUNCTION empresa.fn_equipo_sel_by_id(p_coempresa integer, p_coequipo integer) RETURNS TABLE(coequipo integer, coempresa integer, copersona integer, persona_nopersona character varying, persona_noapellidop character varying, persona_noapellidom character varying, persona_noprofesion character varying, noextracto text, coestreg integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT  
        e.coequipo,
        e.coempresa,
        e.copersona,
        p.nopersona      AS persona_nopersona,
        p.noapellidop    AS persona_noapellidop,
        p.noapellidom    AS persona_noapellidom,
        p.noprofesion    AS persona_noprofesion,    
        e.noextracto,
        e.coestreg
    FROM empresa.tblequipo e
    INNER JOIN maestros.vwpersona p
        ON e.coempresa = p.coempresa 
       AND e.copersona = p.copersona
    WHERE e.coempresa = p_coempresa 
      AND e.coequipo  = p_coequipo;
END;
$$;


ALTER FUNCTION empresa.fn_equipo_sel_by_id(p_coempresa integer, p_coequipo integer) OWNER TO postgres;

--
-- Name: fn_equipo_update_by_id(integer, integer, integer, character varying, integer); Type: FUNCTION; Schema: empresa; Owner: postgres
--

CREATE FUNCTION empresa.fn_equipo_update_by_id(p_coempresa integer, p_coequipo integer, p_copersona integer, p_noextracto character varying, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_rows integer;
BEGIN
    UPDATE empresa.tblequipo
    SET copersona = p_copersona,
        noextracto = p_noextracto,
        cousumod = p_cousumod,
        femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    WHERE coempresa = p_coempresa
      AND coequipo  = p_coequipo;
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION empresa.fn_equipo_update_by_id(p_coempresa integer, p_coequipo integer, p_copersona integer, p_noextracto character varying, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_equipo_update_state_by_id(integer, integer, integer, integer); Type: FUNCTION; Schema: empresa; Owner: postgres
--

CREATE FUNCTION empresa.fn_equipo_update_state_by_id(p_coempresa integer, p_coequipo integer, p_coestreg integer, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_rows integer;
BEGIN
    UPDATE empresa.tblequipo
    SET coestreg = p_coestreg,
        cousumod = p_cousumod,
        femod    = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    WHERE coempresa = p_coempresa
      AND coequipo  = p_coequipo;
  
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION empresa.fn_equipo_update_state_by_id(p_coempresa integer, p_coequipo integer, p_coestreg integer, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_horario_delete_by_id(integer, integer, integer); Type: FUNCTION; Schema: empresa; Owner: postgres
--

CREATE FUNCTION empresa.fn_horario_delete_by_id(p_coempresa integer, p_cohorario integer, p_cousueli integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
Declare
	v_rows integer;
 v_old JSONB;
begin

SELECT row_to_json(x) INTO v_old
    FROM empresa.tblhorario x
    WHERE coempresa = p_coempresa And cohorario = p_cohorario;

    CALL seguridad.usp_auditoria(
 		p_coempresa,	-- Empresa
        'empresa',                          -- Esquema
		'tblhorario',                  -- tabla
		'D',                        -- acción
        p_cousueli,                        -- usuario
        jsonb_build_object('cohorario', p_cohorario),
        v_old,
        NULL
    );

Delete From empresa.tblhorario where coempresa = p_coempresa And cohorario = p_cohorario;
 	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
end;
$$;


ALTER FUNCTION empresa.fn_horario_delete_by_id(p_coempresa integer, p_cohorario integer, p_cousueli integer) OWNER TO postgres;

--
-- Name: fn_horario_insert(integer, integer, character, character, integer); Type: FUNCTION; Schema: empresa; Owner: postgres
--

CREATE FUNCTION empresa.fn_horario_insert(p_coempresa integer, p_codia integer, p_hoinicio character, p_hofinal character, p_cousucre integer) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
DECLARE 	
    v_cohorario BIGINT;
BEGIN
 
insert into empresa.tblhorario (
	coempresa,
	codia,
	hoinicio,
	hofinal,
	cousucre
)
values 
(
	p_coempresa,	
	p_codia,
	p_hoinicio,
	p_hofinal,
	p_cousucre

) 
	RETURNING cohorario INTO v_cohorario;

	RETURN v_cohorario;
	
END;
$$;


ALTER FUNCTION empresa.fn_horario_insert(p_coempresa integer, p_codia integer, p_hoinicio character, p_hofinal character, p_cousucre integer) OWNER TO postgres;

--
-- Name: fn_horario_sel_all(integer); Type: FUNCTION; Schema: empresa; Owner: postgres
--

CREATE FUNCTION empresa.fn_horario_sel_all(p_coempresa integer) RETURNS TABLE(cohorario integer, coempresa integer, codia integer, nodia text, hoinicio time without time zone, hofinal time without time zone, coestreg integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT  h.cohorario,
            h.coempresa,
            h.codia,
            d.notipo AS nodia,
            h.hoinicio,
            h.hofinal,
            h.coestreg
    FROM empresa.tblhorario h
    LEFT JOIN vw_tipogeneral d
           ON h.codia = d.cotipo
          AND d.d = 'diasemana'
    WHERE h.coempresa = p_coempresa;
END;
$$;


ALTER FUNCTION empresa.fn_horario_sel_all(p_coempresa integer) OWNER TO postgres;

--
-- Name: fn_horario_sel_by_id(integer, integer); Type: FUNCTION; Schema: empresa; Owner: postgres
--

CREATE FUNCTION empresa.fn_horario_sel_by_id(p_coempresa integer, p_cohorario integer) RETURNS TABLE(cohorario integer, coempresa integer, codia integer, hoinicio time without time zone, hofinal time without time zone, coestreg integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT  h.cohorario,
            h.coempresa,
            h.codia,
            h.hoinicio,
            h.hofinal,
            h.coestreg
    FROM empresa.tblhorario h
    WHERE h.cohorario = p_cohorario
      AND h.coempresa = p_coempresa;
END;
$$;


ALTER FUNCTION empresa.fn_horario_sel_by_id(p_coempresa integer, p_cohorario integer) OWNER TO postgres;

--
-- Name: fn_horario_update_by_id(integer, integer, integer, character, character, integer); Type: FUNCTION; Schema: empresa; Owner: postgres
--

CREATE FUNCTION empresa.fn_horario_update_by_id(p_coempresa integer, p_cohorario integer, p_codia integer, p_hoinicio character, p_hofinal character, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_rows integer;
BEGIN
    UPDATE empresa.tblhorario
    SET codia     = p_codia,
        hoinicio  = p_hoinicio,
        hofinal   = p_hofinal,
        cousumod  = p_cousumod,
        femod     = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    WHERE coempresa = p_coempresa
      AND cohorario = p_cohorario;
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION empresa.fn_horario_update_by_id(p_coempresa integer, p_cohorario integer, p_codia integer, p_hoinicio character, p_hofinal character, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_imagenweb_delete_by_id(integer, integer, integer); Type: FUNCTION; Schema: empresa; Owner: postgres
--

CREATE FUNCTION empresa.fn_imagenweb_delete_by_id(p_coempresa integer, p_coimagenweb integer, p_cousueli integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
Declare
	v_rows integer;
 v_old JSONB;
begin

SELECT row_to_json(x) INTO v_old
    FROM empresa.tblimagenweb x
    WHERE coempresa = p_coempresa And coimagenweb = p_coimagenweb;

    CALL seguridad.usp_auditoria(
 		p_coempresa,	-- Empresa
        'empresa',                          -- Esquema
		'tblimagenweb',                  -- tabla
		'D',                        -- acción
        p_cousueli,                        -- usuario
        jsonb_build_object('coimagenweb', p_coimagenweb),
        v_old,
        NULL
    );

Delete From empresa.tblimagenweb where coempresa = p_coempresa and coimagenweb = p_coimagenweb;
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
end;
$$;


ALTER FUNCTION empresa.fn_imagenweb_delete_by_id(p_coempresa integer, p_coimagenweb integer, p_cousueli integer) OWNER TO postgres;

--
-- Name: fn_imagenweb_insert(integer, character varying, character varying, integer); Type: FUNCTION; Schema: empresa; Owner: postgres
--

CREATE FUNCTION empresa.fn_imagenweb_insert(p_coempresa integer, p_noimagenweb character varying, p_txdescripcion character varying, p_cousucre integer) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
DECLARE 	
    v_coimagenweb BIGINT;
BEGIN

insert into empresa.tblimagenweb (
	coempresa,	
	noimagenweb,
	txdescripcion,
	cousucre
)
values 
(
	p_coempresa,	
	p_noimagenweb,
	p_txdescripcion,
	p_cousucre

) 
	RETURNING coimagenweb INTO v_coimagenweb;

	RETURN v_coimagenweb;
	
END;
$$;


ALTER FUNCTION empresa.fn_imagenweb_insert(p_coempresa integer, p_noimagenweb character varying, p_txdescripcion character varying, p_cousucre integer) OWNER TO postgres;

--
-- Name: fn_imagenweb_sel_all(integer); Type: FUNCTION; Schema: empresa; Owner: postgres
--

CREATE FUNCTION empresa.fn_imagenweb_sel_all(p_coempresa integer) RETURNS TABLE(coimagenweb integer, coempresa integer, noimagenweb text, txdescripcion text, coestreg integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT  
        i.coimagenweb,
        i.coempresa,
        i.noimagenweb,
        i.txdescripcion,     
        i.coestreg
    FROM empresa.tblimagenweb i
    WHERE i.coempresa = p_coempresa;
END;
$$;


ALTER FUNCTION empresa.fn_imagenweb_sel_all(p_coempresa integer) OWNER TO postgres;

--
-- Name: fn_imagenweb_sel_by_id(integer, integer); Type: FUNCTION; Schema: empresa; Owner: postgres
--

CREATE FUNCTION empresa.fn_imagenweb_sel_by_id(p_coempresa integer, p_coimagenweb integer) RETURNS TABLE(coimagenweb integer, coempresa integer, noimagenweb text, txdescripcion text, coestreg integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT  
        i.coimagenweb,
        i.coempresa,
        i.noimagenweb,
        i.txdescripcion,      
        i.coestreg
    FROM empresa.tblimagenweb i
    WHERE i.coempresa = p_coempresa
      AND i.coimagenweb = p_coimagenweb;
END;
$$;


ALTER FUNCTION empresa.fn_imagenweb_sel_by_id(p_coempresa integer, p_coimagenweb integer) OWNER TO postgres;

--
-- Name: fn_imagenweb_update_by_id(integer, integer, character varying, character varying, integer); Type: FUNCTION; Schema: empresa; Owner: postgres
--

CREATE FUNCTION empresa.fn_imagenweb_update_by_id(p_coempresa integer, p_coimagenweb integer, p_noimagenweb character varying, p_txdescripcion character varying, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_rows integer;
BEGIN
    UPDATE empresa.tblimagenweb
    SET noimagenweb = p_noimagenweb,
        txdescripcion = p_txdescripcion,    
        cousumod = p_cousumod,
        femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    WHERE coempresa = p_coempresa
      AND coimagenweb = p_coimagenweb;
	  
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION empresa.fn_imagenweb_update_by_id(p_coempresa integer, p_coimagenweb integer, p_noimagenweb character varying, p_txdescripcion character varying, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_imagenweb_update_state_by_id(integer, integer, integer, integer); Type: FUNCTION; Schema: empresa; Owner: postgres
--

CREATE FUNCTION empresa.fn_imagenweb_update_state_by_id(p_coempresa integer, p_coimagenweb integer, p_flestreg integer, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_rows integer;
BEGIN
    UPDATE empresa.tblimagenweb
    SET flestreg  = p_flestreg::bool,
        cousumod  = p_cousumod,
        femod     = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    WHERE coempresa   = p_coempresa
      AND coimagenweb = p_coimagenweb;
	  
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION empresa.fn_imagenweb_update_state_by_id(p_coempresa integer, p_coimagenweb integer, p_flestreg integer, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_local_delete_by_id(integer, integer, integer); Type: FUNCTION; Schema: empresa; Owner: postgres
--

CREATE FUNCTION empresa.fn_local_delete_by_id(p_coempresa integer, p_colocal integer, p_cousueli integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
Declare
	v_rows integer;
 v_old JSONB;
begin

	SELECT row_to_json(x) INTO v_old
    FROM empresa.trflocal x
    WHERE coempresa = p_coempresa And colocal = p_colocal;

    CALL seguridad.usp_auditoria(
 		p_coempresa,	-- Empresa
        'empresa',                          -- Esquema
		'trflocal',                  -- tabla
		'D',                        -- acción
        p_cousueli,                        -- usuario
        jsonb_build_object('colocal', p_colocal),
        v_old,
        NULL
    );

Delete From  empresa.trflocal where coempresa = p_coempresa and colocal= p_colocal;
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
end;
$$;


ALTER FUNCTION empresa.fn_local_delete_by_id(p_coempresa integer, p_colocal integer, p_cousueli integer) OWNER TO postgres;

--
-- Name: fn_local_insert(integer, character varying, character varying, character varying, character, integer); Type: FUNCTION; Schema: empresa; Owner: postgres
--

CREATE FUNCTION empresa.fn_local_insert(p_coempresa integer, p_nolocal character varying, p_nodireccion character varying, p_nocodigopostal character varying, p_coubigeo character, p_cousucre integer) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
DECLARE 	
    v_colocal BIGINT;
Begin


insert into empresa.trflocal (
coempresa,
nolocal,
nodireccion,
nocodigopostal,
coubigeo,
cousucre)
values (
p_coempresa,
p_nolocal,
p_nodireccion,
p_nocodigopostal,
p_coubigeo,
p_cousucre) 
	RETURNING colocal INTO v_colocal;

	RETURN v_colocal;
	
END;
$$;


ALTER FUNCTION empresa.fn_local_insert(p_coempresa integer, p_nolocal character varying, p_nodireccion character varying, p_nocodigopostal character varying, p_coubigeo character, p_cousucre integer) OWNER TO postgres;

--
-- Name: fn_local_sel_all(integer); Type: FUNCTION; Schema: empresa; Owner: postgres
--

CREATE FUNCTION empresa.fn_local_sel_all(p_coempresa integer) RETURNS TABLE(coempresa integer, colocal integer, nolocal text, nodireccion text, nocodigopostal text, coubigeo integer, codepartamento text, coprovincia text, codistrito text, nodepartamento text, noprovinica text, nodistrito text, coestreg integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        l.coempresa,
        l.colocal,
        l.nolocal,
        l.nodireccion,
        l.nocodigopostal,
        l.coubigeo,
        u.codepartamento,
        u.coprovincia,
        u.codistrito,
        u.nodepartamento,
        u.noprovincia,
        u.nodistrito,
        l.coestreg
    FROM empresa.trflocal l
    LEFT JOIN maestros.trfubigeo u
           ON l.coubigeo = u.coubigeo
    WHERE l.coempresa = p_coempresa;
END;
$$;


ALTER FUNCTION empresa.fn_local_sel_all(p_coempresa integer) OWNER TO postgres;

--
-- Name: fn_local_sel_allactive(integer); Type: FUNCTION; Schema: empresa; Owner: postgres
--

CREATE FUNCTION empresa.fn_local_sel_allactive(p_coempresa integer) RETURNS TABLE(coempresa integer, colocal integer, nolocal text, nodireccion text, coubigeo integer, codepartamento text, coprovincia text, codistrito text, nodepartamento text, noprovinica text, nodistrito text, coestreg integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        l.coempresa,
        l.colocal,
        l.nolocal,
        l.nodireccion,
        l.coubigeo,
        u.codepartamento,
        u.coprovincia,
        u.codistrito,
        u.nodepartamento,
        u.noprovincia,
        u.nodistrito,
        l.coestreg
    FROM empresa.trflocal l
    LEFT JOIN maestros.trfubigeo u
           ON l.coubigeo = u.coubigeo
    WHERE l.coempresa = p_coempresa      
      AND l.coestreg = 1;
END;
$$;


ALTER FUNCTION empresa.fn_local_sel_allactive(p_coempresa integer) OWNER TO postgres;

--
-- Name: fn_local_sel_by_id(integer, integer); Type: FUNCTION; Schema: empresa; Owner: postgres
--

CREATE FUNCTION empresa.fn_local_sel_by_id(p_coempresa integer, p_colocal integer) RETURNS TABLE(coempresa integer, colocal integer, nolocal text, nodireccion text, nocodigopostal text, coubigeo integer, codepartamento text, coprovincia text, codistrito text, nodepartamento text, noprovinica text, nodistrito text, coestreg integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        l.coempresa,
        l.colocal,
        l.nolocal,
        l.nodireccion,
        l.nocodigopostal,
        l.coubigeo,
        u.codepartamento,
        u.coprovincia,
        u.codistrito,
        u.nodepartamento,
        u.noprovincia,
        u.nodistrito,
        l.coestreg
    FROM empresa.trflocal l
    LEFT JOIN maestros.trfubigeo u
           ON l.coubigeo = u.coubigeo
    WHERE l.coempresa = p_coempresa
      AND l.colocal = p_colocal;
END;
$$;


ALTER FUNCTION empresa.fn_local_sel_by_id(p_coempresa integer, p_colocal integer) OWNER TO postgres;

--
-- Name: fn_local_update_by_id(integer, integer, character varying, character varying, character varying, character, integer); Type: FUNCTION; Schema: empresa; Owner: postgres
--

CREATE FUNCTION empresa.fn_local_update_by_id(p_coempresa integer, p_colocal integer, p_nolocal character varying, p_nodireccion character varying, p_nocodigopostal character varying, p_coubigeo character, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_rows integer;
BEGIN
    UPDATE empresa.trflocal
    SET 
        nolocal = p_nolocal,
        nodireccion = p_nodireccion,
        nocodigopostal = p_nocodigopostal,
        coubigeo = p_coubigeo,
        cousumod = p_cousumod,
        femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    WHERE coempresa = p_coempresa 
      AND colocal = p_colocal;
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION empresa.fn_local_update_by_id(p_coempresa integer, p_colocal integer, p_nolocal character varying, p_nodireccion character varying, p_nocodigopostal character varying, p_coubigeo character, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_local_update_state_by_id(integer, integer, integer, integer); Type: FUNCTION; Schema: empresa; Owner: postgres
--

CREATE FUNCTION empresa.fn_local_update_state_by_id(p_coempresa integer, p_colocal integer, p_coestreg integer, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_rows integer;
BEGIN
    UPDATE empresa.trflocal
    SET 
        coestreg = p_coestreg,
        cousumod = p_cousumod,
        femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    WHERE coempresa = p_coempresa
      AND colocal = p_colocal;
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION empresa.fn_local_update_state_by_id(p_coempresa integer, p_colocal integer, p_coestreg integer, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_pregunta_delete_by_id(integer, integer, integer); Type: FUNCTION; Schema: empresa; Owner: postgres
--

CREATE FUNCTION empresa.fn_pregunta_delete_by_id(p_coempresa integer, p_copregunta integer, p_cousueli integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
Declare
	v_rows integer;
 v_old JSONB;
begin

SELECT row_to_json(x) INTO v_old
    FROM empresa.tblpregunta x
    WHERE coempresa = p_coempresa And copregunta = p_copregunta;

    CALL seguridad.usp_auditoria(
 		p_coempresa,	-- Empresa
        'empresa',                          -- Esquema
		'tblpregunta',                  -- tabla
		'D',                        -- acción
        p_cousueli,                        -- usuario
        jsonb_build_object('copregunta', p_copregunta),
        v_old,
        NULL
    );

Delete From empresa.tblpregunta where coempresa = p_coempresa and copregunta = p_copregunta;
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;

end;
$$;


ALTER FUNCTION empresa.fn_pregunta_delete_by_id(p_coempresa integer, p_copregunta integer, p_cousueli integer) OWNER TO postgres;

--
-- Name: fn_pregunta_insert(integer, integer, character varying, character varying, integer); Type: FUNCTION; Schema: empresa; Owner: postgres
--

CREATE FUNCTION empresa.fn_pregunta_insert(p_coempresa integer, p_nuorden integer, p_nopregunta character varying, p_norespuesta character varying, p_cousucre integer) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
DECLARE 	
    v_copregunta BIGINT;
Begin
insert into empresa.tblpregunta (
	coempresa,
	copregunta,	
	nopregunta,
	norespuesta,
	nuorden,
	cousucre
)
values 
(
	p_coempresa,
	p_copregunta,	
	p_nopregunta,
	p_norespuesta,
	p_nuorden,
	p_cousucre

) 
	RETURNING copregunta INTO v_copregunta;

	RETURN v_copregunta;
	
END;
$$;


ALTER FUNCTION empresa.fn_pregunta_insert(p_coempresa integer, p_nuorden integer, p_nopregunta character varying, p_norespuesta character varying, p_cousucre integer) OWNER TO postgres;

--
-- Name: fn_pregunta_sel_all(integer); Type: FUNCTION; Schema: empresa; Owner: postgres
--

CREATE FUNCTION empresa.fn_pregunta_sel_all(p_coempresa integer) RETURNS TABLE(copregunta integer, nuorden integer, coempresa integer, nopregunta character varying, norespuesta character varying, coestreg integer)
    LANGUAGE sql
    AS $$
    SELECT copregunta, nuorden, coempresa, nopregunta, norespuesta, coestreg
    FROM empresa.tblpregunta
    WHERE coempresa = p_coempresa;
$$;


ALTER FUNCTION empresa.fn_pregunta_sel_all(p_coempresa integer) OWNER TO postgres;

--
-- Name: fn_pregunta_sel_by_id(integer, integer); Type: FUNCTION; Schema: empresa; Owner: postgres
--

CREATE FUNCTION empresa.fn_pregunta_sel_by_id(p_coempresa integer, p_copregunta integer) RETURNS TABLE(copregunta integer, nuorden integer, coempresa integer, nopregunta character varying, norespuesta character varying, coestreg integer)
    LANGUAGE sql
    AS $$
    SELECT copregunta, nuorden, coempresa, nopregunta, norespuesta, coestreg
    FROM empresa.tblpregunta
    WHERE coempresa = p_coempresa
      AND copregunta = p_copregunta;
$$;


ALTER FUNCTION empresa.fn_pregunta_sel_by_id(p_coempresa integer, p_copregunta integer) OWNER TO postgres;

--
-- Name: fn_pregunta_update_by_id(integer, integer, integer, character varying, character varying, integer); Type: FUNCTION; Schema: empresa; Owner: postgres
--

CREATE FUNCTION empresa.fn_pregunta_update_by_id(p_coempresa integer, p_copregunta integer, p_nuorden integer, p_nopregunta character varying, p_norespuesta character varying, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_rows integer;
BEGIN
    UPDATE empresa.tblpregunta
    SET
        coempresa = p_coempresa,
        nopregunta = p_nopregunta,
        norespuesta = p_norespuesta,
        nuorden = p_nuorden,
        cousumod = p_cousumod,
        femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    WHERE coempresa = p_coempresa
      AND copregunta = p_copregunta;
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION empresa.fn_pregunta_update_by_id(p_coempresa integer, p_copregunta integer, p_nuorden integer, p_nopregunta character varying, p_norespuesta character varying, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_pregunta_update_state_by_id(integer, integer, integer, integer); Type: FUNCTION; Schema: empresa; Owner: postgres
--

CREATE FUNCTION empresa.fn_pregunta_update_state_by_id(p_coempresa integer, p_copregunta integer, p_coestreg integer, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_rows integer;
BEGIN
    UPDATE empresa.tblpregunta
    SET
        coestreg = p_coestreg,
        cousumod = p_cousumod,
        femod =CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    WHERE coempresa = p_coempresa
      AND copregunta = p_copregunta;
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION empresa.fn_pregunta_update_state_by_id(p_coempresa integer, p_copregunta integer, p_coestreg integer, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_servicio_delete_by_id(integer, integer, integer); Type: FUNCTION; Schema: empresa; Owner: postgres
--

CREATE FUNCTION empresa.fn_servicio_delete_by_id(p_coempresa integer, p_coservicio integer, p_cousueli integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
Declare
	v_rows integer;
 	v_old JSONB;
begin

SELECT row_to_json(x) INTO v_old
    FROM empresa.tblservicio x
    WHERE coempresa = p_coempresa And coservicio = p_coservicio;

    CALL seguridad.usp_auditoria(
 		p_coempresa,	-- Empresa
        'empresa',                          -- Esquema
		'tblservicio',                  -- tabla
		'D',                        -- acción
        p_cousueli,                        -- usuario
        jsonb_build_object('coservicio', p_coservicio),
        v_old,
        NULL
    );

Delete From empresa.tblservicio where coempresa = p_coempresa and coservicio = p_coservicio;
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;

end;
$$;


ALTER FUNCTION empresa.fn_servicio_delete_by_id(p_coempresa integer, p_coservicio integer, p_cousueli integer) OWNER TO postgres;

--
-- Name: fn_servicio_insert(integer, integer, integer, character varying, character varying, character varying, integer, integer); Type: FUNCTION; Schema: empresa; Owner: postgres
--

CREATE FUNCTION empresa.fn_servicio_insert(p_coempresa integer, p_cotipo integer, p_cosubtipo integer, p_notitulo character varying, p_txdescripcion character varying, p_txdescripcioncorta character varying, p_flmuestraimagen integer, p_cousucre integer) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
DECLARE 	
    v_coservicio BIGINT;
BEGIN

insert into empresa.tblservicio (
	coempresa,	
	cotipo,
	cosubtipo,
	notitulo,
	txdescripcion,
	txdescripcioncorta,
	flmuestraimagen,
	cousucre
)
values 
(
	p_coempresa,	
	p_cotipo,
	p_cosubtipo,
	p_notitulo,
	p_txdescripcion,
	p_txdescripcioncorta,
	p_flmuestraimagen,
	p_cousucre

) 	RETURNING coservicio INTO v_coservicio;

	RETURN v_coservicio;
	
END;
$$;


ALTER FUNCTION empresa.fn_servicio_insert(p_coempresa integer, p_cotipo integer, p_cosubtipo integer, p_notitulo character varying, p_txdescripcion character varying, p_txdescripcioncorta character varying, p_flmuestraimagen integer, p_cousucre integer) OWNER TO postgres;

--
-- Name: fn_servicio_sel_all(integer, integer, integer); Type: FUNCTION; Schema: empresa; Owner: postgres
--

CREATE FUNCTION empresa.fn_servicio_sel_all(p_coempresa integer, p_pagesize integer, p_pageindex integer) RETURNS TABLE(coservicio integer, coempresa integer, notitulo character varying, cotipo integer, cosubtipo integer, flmuestraimagen boolean, notipo character varying, nosubtipo character varying, txdescripcion text, txdescripcioncorta text, coestreg integer, pagesize integer, pageindex integer, rowscount bigint)
    LANGUAGE plpgsql
    AS $$
BEGIN
 
Return Query
WITH dataa AS (
    SELECT
        tblservicio.coservicio,
        tblservicio.coempresa,
        tblservicio.notitulo,
        tblservicio.cotipo,
        tblservicio.cosubtipo,     
        tblservicio.flmuestraimagen,
        tipo.notipo AS notipo,
        subtipo.notipo AS nosubtipo,
        tblservicio.txdescripcion,
        tblservicio.txdescripcioncorta,
        tblservicio.coestreg
    FROM empresa.tblservicio
    LEFT JOIN maestro.vw_tipo tipo
        ON tipo.coempresa = tblservicio.coempresa
        AND tipo.cotipo = tblservicio.cotipo
        AND tipo.d = 'empresa.servicio'
    LEFT JOIN maestro.vw_tipo subtipo
        ON subtipo.coempresa = tblservicio.coempresa
        AND subtipo.cotipo = tblservicio.cosubtipo
        AND subtipo.d = 'empresa.subservicio'
    WHERE tblservicio.coempresa = p_coempresa
),
counta AS (
    SELECT COUNT(*) AS rowscount FROM dataa
)
SELECT
    a.*,
    p_pagesize AS pagesize,
    p_pageindex AS pageindex,
    b.rowscount
FROM dataa a
CROSS JOIN counta b
ORDER BY a.coservicio
OFFSET p_pageindex * p_pagesize
LIMIT p_pagesize;
End;
$$;


ALTER FUNCTION empresa.fn_servicio_sel_all(p_coempresa integer, p_pagesize integer, p_pageindex integer) OWNER TO postgres;

--
-- Name: fn_servicio_sel_by_id(integer, integer); Type: FUNCTION; Schema: empresa; Owner: postgres
--

CREATE FUNCTION empresa.fn_servicio_sel_by_id(p_coempresa integer, p_coservicio integer) RETURNS TABLE(coservicio integer, coempresa integer, notitulo character varying, cotipo integer, cosubtipo integer, flmuestraimagen boolean, notipo character varying, nosubtipo character varying, txdescripcion text, txdescripcioncorta text, coestreg integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
 
Return Query
SELECT
    tblservicio.coservicio,
    tblservicio.coempresa,
    tblservicio.notitulo,
    tblservicio.cotipo,
    tblservicio.cosubtipo,
    tblservicio.flmuestraimagen,  
    tipo.notipo AS notipo,
    subtipo.notipo AS nosubtipo,
    tblservicio.txdescripcion,
    tblservicio.txdescripcioncorta,
    tblservicio.coestreg
FROM empresa.tblservicio
LEFT JOIN maestro.vw_tipo tipo
    ON tipo.coempresa = tblservicio.coempresa
    AND tipo.cotipo = tblservicio.cotipo
    AND tipo.d = 'empresa.servicio'
LEFT JOIN maestro.vw_tipo subtipo
    ON subtipo.coempresa = tblservicio.coempresa
    AND subtipo.cotipo = tblservicio.cosubtipo
    AND subtipo.d = 'empresa.subservicio'
WHERE tblservicio.coempresa = p_coempresa
  AND tblservicio.coservicio = p_coservicio;
End;
$$;


ALTER FUNCTION empresa.fn_servicio_sel_by_id(p_coempresa integer, p_coservicio integer) OWNER TO postgres;

--
-- Name: fn_servicio_update_by_id(integer, integer, integer, integer, character varying, character varying, character varying, integer, integer); Type: FUNCTION; Schema: empresa; Owner: postgres
--

CREATE FUNCTION empresa.fn_servicio_update_by_id(p_coempresa integer, p_coservicio integer, p_cotipo integer, p_cosubtipo integer, p_notitulo character varying, p_txdescripcion character varying, p_txdescripcioncorta character varying, p_flmuestraimagen integer, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_rows integer;
BEGIN
    UPDATE empresa.tblservicio
    SET
        cotipo = p_cotipo,
        cosubtipo = p_cosubtipo,
        txdescripcion = p_txdescripcion,
        txdescripcioncorta = p_txdescripcioncorta,
        notitulo = p_notitulo,
        flmuestraimagen = p_flmuestraimagen,
        cousumod = p_cousumod,
        femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    WHERE coempresa = p_coempresa
      AND coservicio = p_coservicio;
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION empresa.fn_servicio_update_by_id(p_coempresa integer, p_coservicio integer, p_cotipo integer, p_cosubtipo integer, p_notitulo character varying, p_txdescripcion character varying, p_txdescripcioncorta character varying, p_flmuestraimagen integer, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_servicio_update_state_by_id(integer, integer, integer, integer); Type: FUNCTION; Schema: empresa; Owner: postgres
--

CREATE FUNCTION empresa.fn_servicio_update_state_by_id(p_coempresa integer, p_coservicio integer, p_coestreg integer, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_rows integer;
BEGIN
    UPDATE empresa.tblservicio
    SET
        coestreg = p_coestreg,
        cousumod = p_cousumod,
        femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    WHERE coempresa = p_coempresa
      AND coservicio = p_coservicio;
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION empresa.fn_servicio_update_state_by_id(p_coempresa integer, p_coservicio integer, p_coestreg integer, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_serviciocaracteristica_delete_by_id(integer, integer, integer); Type: FUNCTION; Schema: empresa; Owner: postgres
--

CREATE FUNCTION empresa.fn_serviciocaracteristica_delete_by_id(p_coempresa integer, p_coserviciocaracteristica integer, p_cousueli integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
Declare
	v_rows integer;
 v_old JSONB;
begin

SELECT row_to_json(x) INTO v_old
    FROM empresa.tblserviciocaracteristica x
    WHERE coempresa = p_coempresa And coserviciocaracteristica = p_coserviciocaracteristica;

    CALL seguridad.usp_auditoria(
 		p_coempresa,	-- Empresa
        'empresa',                          -- Esquema
		'tblserviciocaracteristica',                  -- tabla
		'D',                        -- acción
        p_cousueli,                        -- usuario
        jsonb_build_object('coserviciocaracteristica', p_coserviciocaracteristica),
        v_old,
        NULL
    );

Delete From empresa.tblserviciocaracteristica where coempresa = p_coempresa and coserviciocaracteristica = p_coserviciocaracteristica;
 	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;

end;
$$;


ALTER FUNCTION empresa.fn_serviciocaracteristica_delete_by_id(p_coempresa integer, p_coserviciocaracteristica integer, p_cousueli integer) OWNER TO postgres;

--
-- Name: fn_serviciocaracteristica_insert(integer, integer, integer, character varying, character varying, integer); Type: FUNCTION; Schema: empresa; Owner: postgres
--

CREATE FUNCTION empresa.fn_serviciocaracteristica_insert(p_coempresa integer, p_coservicio integer, p_nuorden integer, p_notitulo character varying, p_txdescripcion character varying, p_cousucre integer) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
DECLARE 	
    v_coserviciocaracteristica BIGINT;
BEGIN

insert into empresa.tblserviciocaracteristica (
	coempresa,	
	coservicio,
	nuorden,
	notitulo,
	txdescripcion,
	cousucre
)
values 
(
	p_coempresa,	
	p_coservicio,
	p_nuorden,
	p_notitulo,
	p_txdescripcion,
	p_cousucre

) 
	RETURNING coserviciocaracteristica INTO v_coserviciocaracteristica;

	RETURN v_coserviciocaracteristica;
	
END;
$$;


ALTER FUNCTION empresa.fn_serviciocaracteristica_insert(p_coempresa integer, p_coservicio integer, p_nuorden integer, p_notitulo character varying, p_txdescripcion character varying, p_cousucre integer) OWNER TO postgres;

--
-- Name: fn_serviciocaracteristica_sel_all(integer, integer); Type: FUNCTION; Schema: empresa; Owner: postgres
--

CREATE FUNCTION empresa.fn_serviciocaracteristica_sel_all(p_coempresa integer, p_coservicio integer) RETURNS TABLE(coserviciocaracteristica integer, coempresa integer, coservicio integer, nuorden integer, notitulo character varying, txdescripcion text, coestreg integer)
    LANGUAGE sql
    AS $$
SELECT
    coserviciocaracteristica,
    coempresa,
    coservicio,
    nuorden,
    notitulo,
    txdescripcion,   
    coestreg
FROM empresa.tblserviciocaracteristica
WHERE coempresa = p_coempresa
  AND coservicio = p_coservicio;
$$;


ALTER FUNCTION empresa.fn_serviciocaracteristica_sel_all(p_coempresa integer, p_coservicio integer) OWNER TO postgres;

--
-- Name: fn_serviciocaracteristica_sel_by_id(integer, integer); Type: FUNCTION; Schema: empresa; Owner: postgres
--

CREATE FUNCTION empresa.fn_serviciocaracteristica_sel_by_id(p_coempresa integer, p_coserviciocaracteristica integer) RETURNS TABLE(coserviciocaracteristica integer, coempresa integer, coservicio integer, nuorden integer, notitulo character varying, txdescripcion text, coestreg integer)
    LANGUAGE sql
    AS $$
SELECT
    coserviciocaracteristica,
    coempresa,
    coservicio,
    nuorden,
    notitulo,
    txdescripcion,   
    coestreg
FROM empresa.tblserviciocaracteristica
WHERE coempresa = p_coempresa
  AND coserviciocaracteristica = p_coserviciocaracteristica;
$$;


ALTER FUNCTION empresa.fn_serviciocaracteristica_sel_by_id(p_coempresa integer, p_coserviciocaracteristica integer) OWNER TO postgres;

--
-- Name: fn_serviciocaracteristica_update_by_id(integer, integer, integer, integer, character varying, character varying, integer); Type: FUNCTION; Schema: empresa; Owner: postgres
--

CREATE FUNCTION empresa.fn_serviciocaracteristica_update_by_id(p_coempresa integer, p_coserviciocaracteristica integer, p_coservicio integer, p_nuorden integer, p_notitulo character varying, p_txdescripcion character varying, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_rows integer;
BEGIN
    UPDATE empresa.tblserviciocaracteristica
    SET
        nuorden = p_nuorden,
        notitulo = p_notitulo,
        txdescripcion = p_txdescripcion,
        cousumod = p_cousumod,
        femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    WHERE coempresa = p_coempresa
      AND coserviciocaracteristica = p_coserviciocaracteristica;
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION empresa.fn_serviciocaracteristica_update_by_id(p_coempresa integer, p_coserviciocaracteristica integer, p_coservicio integer, p_nuorden integer, p_notitulo character varying, p_txdescripcion character varying, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_serviciocaracteristica_update_state_by_id(integer, integer, integer, integer); Type: FUNCTION; Schema: empresa; Owner: postgres
--

CREATE FUNCTION empresa.fn_serviciocaracteristica_update_state_by_id(p_coempresa integer, p_coserviciocaracteristica integer, p_coestreg integer, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_rows integer;
BEGIN
    UPDATE empresa.tblserviciocaracteristica
    SET
        coestreg = p_coestreg,
        cousumod = p_cousumod,
        femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    WHERE coempresa = p_coempresa
      AND coserviciocaracteristica = p_coserviciocaracteristica;

   
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION empresa.fn_serviciocaracteristica_update_state_by_id(p_coempresa integer, p_coserviciocaracteristica integer, p_coestreg integer, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_compra_delete_by_id(integer, integer, integer); Type: FUNCTION; Schema: facturacion; Owner: postgres
--

CREATE FUNCTION facturacion.fn_compra_delete_by_id(p_coempresa integer, p_cocompra integer, p_cousueli integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_rows integer;
    r_detalle RECORD;
BEGIN
    -- Recorrer todos los detalles de la compra
    FOR r_detalle IN
        SELECT cocompradetalle
        FROM facturacion.tblcompradetalle
        WHERE coempresa = p_coempresa
          AND cocompra = p_cocompra
    LOOP
        -- Llamar al procedimiento que elimina cada detalle
        CALL facturacion.fn_compradetalle_delete_by_id(
            r_detalle.cocompradetalle,
            p_coempresa,
            p_cousueli,
            1
        );
    END LOOP;

    -- Actualizar la compra como eliminada o modificada
    UPDATE facturacion.tblcompra
    SET  
        cousueli = p_cousueli,
        feeli = NOW()   -- Fecha actual
    WHERE coempresa = p_coempresa
      AND cocompra = p_cocompra;

	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION facturacion.fn_compra_delete_by_id(p_coempresa integer, p_cocompra integer, p_cousueli integer) OWNER TO postgres;

--
-- Name: fn_compra_insert(integer, integer, integer, smallint, character varying, character varying, character, character, integer, integer, integer, integer, integer, character varying, integer); Type: FUNCTION; Schema: facturacion; Owner: postgres
--

CREATE FUNCTION facturacion.fn_compra_insert(p_coempresa integer, p_colocal integer, p_cotipodocumento integer, p_flimpuestoincluyeprecio smallint, p_nuserie character varying, p_nudocumento character varying, p_fecompra character, p_fevencimiento character, p_comoneda integer, p_cotipocambio integer, p_coproveedor integer, p_comodopago integer, p_comediopago integer, p_txdescripcion character varying, p_cousucre integer) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_cocompra BIGINT;
    v_comonedasecundaria integer;
    v_cotipocambio BIGINT;  -- puede ser decimal si es tipo de cambio
BEGIN
    -- Obtener moneda secundaria
   v_comonedasecundaria := contabilidad.fn_moneda_secundaria();
   
   v_cotipocambio = contabilidad.fn_tipocambio_insert_by_fecha(
        p_coempresa,
        v_comonedasecundaria,
        p_fecompra
    );

    -- Insertar la compra
    INSERT INTO facturacion.tblcompra (       
        coempresa,    
        colocal,
        cotipodocumento,
        flimpuestoincluyeprecio,
        nuserie,
        nudocumento,
        fecompra,
        fevencimiento,
        comoneda,
        cotipocambio,
        coproveedor,    
        comodopago,
        comediopago,
        txdescripcion,
        cousucre
    )
    VALUES (        
        p_coempresa,    
        p_colocal,
        p_cotipodocumento,
        p_flimpuestoincluyeprecio,
        p_nuserie,
        p_nudocumento,
        p_fecompra,
        p_fevencimiento,
        p_comoneda,
        v_cotipocambio,
        p_coproveedor,
        p_comodopago,
        p_comediopago,
        p_txdescripcion,
        p_cousucre
    )
	RETURNING cocompra INTO v_cocompra;

	RETURN v_cocompra;
	
END;
$$;


ALTER FUNCTION facturacion.fn_compra_insert(p_coempresa integer, p_colocal integer, p_cotipodocumento integer, p_flimpuestoincluyeprecio smallint, p_nuserie character varying, p_nudocumento character varying, p_fecompra character, p_fevencimiento character, p_comoneda integer, p_cotipocambio integer, p_coproveedor integer, p_comodopago integer, p_comediopago integer, p_txdescripcion character varying, p_cousucre integer) OWNER TO postgres;

--
-- Name: fn_compra_sel_all(integer, character, character, integer, integer, integer, character varying, integer, integer, integer); Type: FUNCTION; Schema: facturacion; Owner: postgres
--

CREATE FUNCTION facturacion.fn_compra_sel_all(p_coempresa integer, p_feinicio character, p_fefinal character, p_cotipodocumento integer, p_comodopago integer, p_coproveedor integer, p_noinputsearch character varying, p_pagesize integer, p_cursorid integer, p_direction integer) RETURNS TABLE(cocompra bigint, notipodocumentosigla character varying, nuserie character varying, nudocumento character varying, fecompra character, fevencimiento character, nomonedasigla character varying, ssprecio numeric, ssimpuesto numeric, ssdescuento numeric, nunotaentrada integer, nomodopago character varying, nomediopago character varying, noproveedor character varying, coestreg integer)
    LANGUAGE plpgsql
    AS $_$
DECLARE 
	sql TEXT;
BEGIN
    sql := FORMAT($f$
        SELECT 	
            c.cocompra,            
            td.nosigla AS notipodocumentosigla,
            c.nuserie,
            c.nudocumento,
            c.fecompra,
            c.fevencimiento,
            m.notipo AS nomoneda,
            m.nosigla AS nomonedasigla,            
            c.ssprecio,
            c.ssimpuesto,
            c.ssdescuento,
            c.nunotaentrada,            
            mp.notipo AS nomodopago,
            medp.notipo AS nomediopago,            
            p.nopersona || ' ' || p.noapellidop || ' ' || p.noapellidom AS noproveedor,
            c.coestreg
        FROM facturacion.tblcompra c
        LEFT JOIN maestros.tblpersona p ON c.coempresa = p.coempresa AND c.coproveedor = p.copersona
        LEFT JOIN maestros.vw_tipogeneral td ON c.cotipodocumento = td.cotipo AND td.d = 'contabilidad.tipodocumentotributario'
        LEFT JOIN maestros.vw_tipogeneral m ON c.comoneda = m.cotipo AND m.d = 'contabilidad.tipomoneda'
        LEFT JOIN maestros.vw_tipogeneral mp ON c.comodopago = mp.cotipo AND mp.d = 'contabilidad.modopago'
        LEFT JOIN maestros.vw_tipogeneral medp ON c.comediopago = medp.cotipo AND medp.d = 'contabilidad.mediopago'
        WHERE c.coempresa = %L
            AND (%L IS NULL OR c.fecompra >= %L)
            AND (%L IS NULL OR c.fecompra <= %L)
            AND (%L IS NULL OR c.cotipodocumento = %L)
            AND (%L IS NULL OR c.comodopago = %L)
            AND (%L IS NULL OR c.coproveedor = %L)
            AND (%L IS NULL OR 
                c.nuserie ILIKE '%' || %L || '%' OR
                c.nudocumento ILIKE '%' || %L || '%'
            )
		AND (
				(%s)
			)
		ORDER BY p.cocompra %s
		LIMIT %s
  	$f$,
		p_coempresa,
		p_feinicio,	p_feinicio,
		p_fefinal, p_fefinal,
		p_comodopago, p_cotipodocumento, 
		p_noinputsearch, p_comodopago,
		p_coproveedor, p_coproveedor,
		CASE 
				WHEN p_direction = 1 THEN FORMAT('c.cocompra > %s', COALESCE(p_cursorid::text, '0'))
				ELSE FORMAT('c.cocompra < %s', COALESCE(p_cursorid::text, '(SELECT MAX(x.cocompra) FROM facturacion.tblcompra x WHERE x.coempresa = %s)'::text, p_coempresa::text))
		END,
		CASE WHEN p_direction = 1 THEN 'ASC' ELSE 'DESC' END,
		COALESCE(p_pagesize, 1)	
	);

	RETURN QUERY EXECUTE sql;

END;
$_$;


ALTER FUNCTION facturacion.fn_compra_sel_all(p_coempresa integer, p_feinicio character, p_fefinal character, p_cotipodocumento integer, p_comodopago integer, p_coproveedor integer, p_noinputsearch character varying, p_pagesize integer, p_cursorid integer, p_direction integer) OWNER TO postgres;

--
-- Name: fn_compra_sel_all_count(integer, character, character, integer, integer, integer, character varying); Type: FUNCTION; Schema: facturacion; Owner: postgres
--

CREATE FUNCTION facturacion.fn_compra_sel_all_count(p_coempresa integer, p_feinicio character, p_fefinal character, p_cotipodocumento integer, p_comodopago integer, p_coproveedor integer, p_noinputsearch character varying) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
DECLARE 
	   v_total bigint;
BEGIN  
        SELECT COUNT(1)
		 INTO v_total
        FROM facturacion.tblcompra c
        LEFT JOIN maestros.tblpersona p ON c.coempresa = p.coempresa AND c.coproveedor = p.copersona
        LEFT JOIN maestros.vw_tipogeneral td ON c.cotipodocumento = td.cotipo AND td.d = 'contabilidad.tipodocumentotributario'
        LEFT JOIN maestros.vw_tipogeneral m ON c.comoneda = m.cotipo AND m.d = 'contabilidad.tipomoneda'
        LEFT JOIN maestros.vw_tipogeneral mp ON c.comodopago = mp.cotipo AND mp.d = 'contabilidad.modopago'
        LEFT JOIN maestros.vw_tipogeneral medp ON c.comediopago = medp.cotipo AND medp.d = 'contabilidad.mediopago'
        WHERE c.coempresa = p_coempresa
            AND (p_feinicio IS NULL OR c.fecompra >= p_feinicio)
            AND (p_fefinal IS NULL OR c.fecompra <= p_fefinal)
            AND (p_cotipodocumento IS NULL OR c.cotipodocumento = p_cotipodocumento)
            AND (p_comodopago IS NULL OR c.comodopago = p_comodopago)
            AND (p_coproveedor IS NULL OR c.coproveedor = p_coproveedor)
            AND (p_noinputsearch IS NULL OR 
                c.nuserie ILIKE '%' || p_noinputsearch || '%' OR
                c.nudocumento ILIKE '%' || p_noinputsearch || '%'
            )
		;
		RETURN v_total;
END;
$$;


ALTER FUNCTION facturacion.fn_compra_sel_all_count(p_coempresa integer, p_feinicio character, p_fefinal character, p_cotipodocumento integer, p_comodopago integer, p_coproveedor integer, p_noinputsearch character varying) OWNER TO postgres;

--
-- Name: fn_compra_sel_by_id(integer, integer); Type: FUNCTION; Schema: facturacion; Owner: postgres
--

CREATE FUNCTION facturacion.fn_compra_sel_by_id(p_coempresa integer, p_cocompra integer) RETURNS TABLE(cocompra bigint, coempresa integer, cotipodocumento integer, flimpuestoincluyeprecio smallint, notipodocumento character varying, nuserie character varying, nudocumento character varying, fecompra character, fevencimiento character, comoneda integer, nomoneda character varying, nomonedasigla character varying, cotipocambio numeric, coproveedor integer, ssprecio numeric, ssimpuesto numeric, ssdescuento numeric, nunotaentrada integer, comodopago integer, comediopago integer, nomodopago character varying, nomediopago character varying, txdescripcion character varying, tipocambio_sstipocambioventa numeric, tipocambio_sstipocambiocompra numeric, tipocambio_fetipocambio character, tipocambio_flautomatico boolean, proveedor_nopersona character varying, proveedor_noapellidop character varying, proveedor_noapellidom character varying, proveedor_nudocumento character varying, proveedor_notipodocumento character varying, proveedor_notipodocumentosigla character varying, coestreg integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        c.cocompra,
        c.coempresa,
        c.cotipodocumento,
        c.flimpuestoincluyeprecio,
        td.notipo AS notipodocumento,
        c.nuserie,
        c.nudocumento,
        c.fecompra,
        c.fevencimiento,
        c.comoneda,
        m.notipo AS nomoneda,
        m.nosigla AS nomonedasigla,
        c.cotipocambio,
        c.coproveedor,
        c.ssprecio,
        c.ssimpuesto,
        c.ssdescuento,
        c.nunotaentrada,
        c.comodopago,
        c.comediopago,
        mp.notipo AS nomodopago,
        medp.notipo AS nomediopago,
        c.txdescripcion,
        t.sstipocambioventa AS tipocambio_sstipocambioventa,
        t.sstipocambiocompra AS tipocambio_sstipocambiocompra,
        t.fetipocambio AS tipocambio_fetipocambio,
        t.flautomatico AS tipocambio_flautomatico,
        p.nopersona AS proveedor_nopersona,
        p.noapellidop AS proveedor_noapellidop,
        p.noapellidom AS proveedor_noapellidom,
        p.nudocumento AS proveedor_nudocumento,
        tdprov.notipo AS proveedor_notipodocumento,
        tdprov.nosigla AS proveedor_notipodocumentosigla,
        c.coestreg
    FROM facturacion.tblcompra c
    LEFT JOIN maestros.tblpersona p ON c.coempresa = p.coempresa AND c.coproveedor = p.copersona
    LEFT JOIN maestros.vw_tipogeneral td ON c.cotipodocumento = td.cotipo AND td.d = 'contabilidad.tipodocumentotributario'
    LEFT JOIN maestros.vw_tipogeneral m ON c.comoneda = m.cotipo AND m.d = 'contabilidad.tipomoneda'
    LEFT JOIN maestros.vw_tipogeneral tdprov ON p.cotipodocumento = tdprov.cotipo AND tdprov.d = 'tipodocumento'
    INNER JOIN contabilidad.trftipocambio t ON c.coempresa = t.coempresa AND c.cotipocambio = t.cotipocambio
    LEFT JOIN maestros.vw_tipogeneral mp ON c.comodopago = mp.cotipo AND mp.d = 'contabilidad.modopago'
    LEFT JOIN maestros.vw_tipogeneral medp ON c.comediopago = medp.cotipo AND medp.d = 'contabilidad.mediopago'
    WHERE c.coempresa = p_coempresa AND c.cocompra = p_cocompra;
END;
$$;


ALTER FUNCTION facturacion.fn_compra_sel_by_id(p_coempresa integer, p_cocompra integer) OWNER TO postgres;

--
-- Name: fn_compra_sum_all(integer, integer); Type: FUNCTION; Schema: facturacion; Owner: postgres
--

CREATE FUNCTION facturacion.fn_compra_sum_all(p_coempresa integer, p_cocompra integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_rows integer;
    p_ssprecio numeric(14,4);
    p_ssdescuento numeric(14,4);
    p_ssimpuesto numeric(14,4);
BEGIN
    -- Sumar los totales de los detalles de compra
    SELECT 
        COALESCE(SUM(ssprecio * qtproducto),0),
        COALESCE(SUM(ssdescuento * qtproducto),0),
        COALESCE(SUM(ssimpuesto * qtproducto),0)
    INTO p_ssprecio, p_ssdescuento, p_ssimpuesto
    FROM facturacion.tblcompradetalle
    WHERE flestreg = true
      AND coempresa = p_coempresa
      AND cocompra = p_cocompra;

    -- Actualizar la cabecera de la compra
    UPDATE facturacion.tblcompra
    SET
        ssprecio = p_ssprecio,
        ssdescuento = p_ssdescuento,
        ssimpuesto = p_ssimpuesto
    WHERE coempresa = p_coempresa
      AND cocompra = p_cocompra;

  	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION facturacion.fn_compra_sum_all(p_coempresa integer, p_cocompra integer) OWNER TO postgres;

--
-- Name: fn_compra_update_by_id(integer, integer, integer, character varying, character varying, character, character, integer, integer, integer, integer, integer, character varying, integer); Type: FUNCTION; Schema: facturacion; Owner: postgres
--

CREATE FUNCTION facturacion.fn_compra_update_by_id(p_coempresa integer, p_cocompra integer, p_cotipodocumento integer, p_nuserie character varying, p_nudocumento character varying, p_fecompra character, p_fevencimiento character, p_comoneda integer, p_coproveedor integer, p_comodopago integer, p_comediopago integer, p_cotipocambio integer, p_txdescripcion character varying, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_rows integer;
BEGIN
    -- Actualizar la compra
    UPDATE facturacion.tblcompra
    SET
        cotipodocumento = p_cotipodocumento,
        nuserie = p_nuserie,
        nudocumento = p_nudocumento,
        fecompra = p_fecompra,
        cotipocambio = p_cotipocambio,
        fevencimiento = p_fevencimiento,
        coproveedor = p_coproveedor,
        comodopago = p_comodopago,
        comediopago = p_comediopago,
        txdescripcion = p_txdescripcion,
        cousumod = p_cousumod,
        femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    WHERE coempresa = p_coempresa
      AND cocompra = p_cocompra;

	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION facturacion.fn_compra_update_by_id(p_coempresa integer, p_cocompra integer, p_cotipodocumento integer, p_nuserie character varying, p_nudocumento character varying, p_fecompra character, p_fevencimiento character, p_comoneda integer, p_coproveedor integer, p_comodopago integer, p_comediopago integer, p_cotipocambio integer, p_txdescripcion character varying, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_compradetalle_delete_by_id(integer, integer, integer, integer); Type: FUNCTION; Schema: facturacion; Owner: postgres
--

CREATE FUNCTION facturacion.fn_compradetalle_delete_by_id(p_coempresa integer, p_cocompradetalle integer, p_cousueli integer, p_fldeletedetalle integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_rows integer;
    v_qtventadetalle integer;
BEGIN
    -- Verificar si existen ventas asociadas
    v_qtventadetalle := inventario.fn_inventario_tiene_venta(p_coempresa, p_cocompradetalle);
    
    IF v_qtventadetalle > 0 THEN
        RAISE EXCEPTION 'Existen ventas asociadas a esta compra.';
    END IF;

    -- Eliminar inventario relacionadas a la venta
    DELETE FROM inventario.tblinventario
    WHERE coempresa = p_coempresa 
      AND coreferencia = p_cocompradetalle 
	  AND cotiporeferencia = 2;
	  
    -- Eliminar inventario relacionado a la compra
    DELETE FROM inventario.tblinventario
    WHERE coempresa = p_coempresa 
      AND coreferencia = p_cocompradetalle 
	  AND cotiporeferencia = 1;

    -- Actualizar estado si corresponde
    IF p_fldeletedetalle = 1 THEN
        UPDATE facturacion.tblcompradetalle
        SET flestreg = false,
            femod = NOW(),          -- Fecha actual
            cousumod = p_cousueli  -- Usuario que modifica
        WHERE coempresa = p_coempresa 
          AND cocompradetalle = p_cocompradetalle;
    END IF;

	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION facturacion.fn_compradetalle_delete_by_id(p_coempresa integer, p_cocompradetalle integer, p_cousueli integer, p_fldeletedetalle integer) OWNER TO postgres;

--
-- Name: fn_compradetalle_insert(integer, integer, integer, integer, integer, numeric, integer, numeric, numeric, numeric, numeric, integer, integer, character varying, integer); Type: FUNCTION; Schema: facturacion; Owner: postgres
--

CREATE FUNCTION facturacion.fn_compradetalle_insert(p_coempresa integer, p_cocompra integer, p_nuorden integer, p_coarticulo integer, p_qtarticulo integer, p_ssprecioingresado numeric, p_coimpuesto integer, p_pqimpuesto numeric, p_ssimpuesto numeric, p_pqdescuento numeric, p_ssdescuento numeric, p_colocal integer, p_coalmacen integer, p_noserie character varying, p_cousucre integer) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_estadoalmacen varchar(100);
	v_cocompradetalle bigint;
    v_qtarticulorepetido int;
    v_ssprecio numeric(14,4);
    v_sspreciototal numeric(14,4);
    v_flinventariable int;
    v_nuorden int;
    v_colocal int;
BEGIN
    -- Verificar si el artículo ya existe en la compra
    SELECT COUNT(1) INTO v_qtarticulorepetido
    FROM facturacion.tblcompradetalle
    WHERE coempresa = p_coempresa
      AND cocompra = p_cocompra
      AND coarticulo = p_coarticulo;

    IF v_qtarticulorepetido > 0 THEN
        RAISE EXCEPTION 'El artículo ya se ingresó.';
    END IF;

    -- Calcular precios y descuentos usando la función
    SELECT 
        ssprecio,
        pqimpuesto,
        pqdescuento,
        ssdescuento,
        ssimpuesto,
        sspreciototal
    INTO v_ssprecio, p_pqimpuesto, p_pqdescuento, p_ssdescuento, p_ssimpuesto, v_sspreciototal
    FROM facturacion.fn_descuento_and_impuesto_compra(
        p_coempresa, p_cocompra, p_ssprecioingresado, p_pqdescuento, p_coimpuesto, p_qtarticulo
    );

    -- Obtener correlativo del detalle nextval('facturacion.tblcompradetalleseq'::regclass)
	v_cocompradetalle := nextval('facturacion.tblcompradetalleseq');

    -- Obtener número de orden
    SELECT COALESCE(MAX(nuorden),0) + 1 INTO v_nuorden
    FROM facturacion.tblcompradetalle
    WHERE coempresa = p_coempresa AND cocompra = p_cocompra;

    -- Obtener local
    SELECT colocal INTO v_colocal
    FROM inventario.tblalmacen
    WHERE coempresa = p_coempresa AND coalmacen = p_coalmacen;

    -- Insertar detalle
    INSERT INTO facturacion.tblcompradetalle (
        coempresa,
        cocompradetalle,
        cocompra,
        nuorden,
        coarticulo,
        qtarticulo,
        ssprecioingresado,
        ssprecio,
        coimpuesto,
        pqimpuesto,
        ssimpuesto,
        ssdescuento,
        pqdescuento,
        sspreciototal,
        colocal, 
        coalmacen,
        cousucre
    )
    VALUES (
        p_coempresa,
        v_cocompradetalle,
        p_cocompra,
        v_nuorden,
        p_coarticulo,
        p_qtarticulo,
        p_ssprecioingresado,
        v_ssprecio,
        p_coimpuesto,
        p_pqimpuesto,
        p_ssimpuesto,
        p_ssdescuento,
        p_pqdescuento,
        v_sspreciototal,
        v_colocal,
        p_coalmacen,
        p_cousucre
    );

    -- Actualizar totales de la compra
    CALL facturacion.usp_compra_sumall(p_coempresa, p_cocompra);

    -- Verificar si el artículo es inventariable   
    SELECT articulo.noestadoalmacen INTO v_estadoalmacen
    FROM inventario.vw_articulo articulo
    WHERE coempresa = p_coempresa AND coarticulo = p_coarticulo;

    IF v_estadoalmacen = 'INVENTARIABLE' THEN
        FOR i IN 1..p_qtarticulo LOOP
            CALL inventario.usp_inventario_insert(
                p_coempresa, p_cocompra, v_cocompradetalle, p_coarticulo, p_noserie, v_colocal, p_coalmacen, p_cousucre
            );
        END LOOP;
    END IF;
	

	RETURN v_cocompradetalle;
	
END;
$$;


ALTER FUNCTION facturacion.fn_compradetalle_insert(p_coempresa integer, p_cocompra integer, p_nuorden integer, p_coarticulo integer, p_qtarticulo integer, p_ssprecioingresado numeric, p_coimpuesto integer, p_pqimpuesto numeric, p_ssimpuesto numeric, p_pqdescuento numeric, p_ssdescuento numeric, p_colocal integer, p_coalmacen integer, p_noserie character varying, p_cousucre integer) OWNER TO postgres;

--
-- Name: fn_compradetalle_sel_all(integer, integer); Type: FUNCTION; Schema: facturacion; Owner: postgres
--

CREATE FUNCTION facturacion.fn_compradetalle_sel_all(p_coempresa integer, p_cocompra integer) RETURNS TABLE(cocompradetalle integer, coempresa integer, cocompra integer, nuorden integer, coarticulo integer, qtarticulo integer, ssprecioingresado numeric, ssprecio numeric, coimpuesto integer, pqimpuesto numeric, ssimpuesto numeric, ssdescuento numeric, pqdescuento numeric, sspreciototal numeric, colocal integer, coalmacen integer, coestreg integer, nomoneda text, nomonedasigla text, noimpuesto text, noimpuestosigla text, noimpuestovalor numeric, articulo_noestadoalmacen text, articulo_nosegmentogrupo text, articulo_nosegmento text, articulo_nofamilia text, articulo_noclase text, articulo_nomarca text, articulo_nomodelo text, articulo_noarticulo text, articulo_nounidadentrada text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT
        d.cocompradetalle,
        d.coempresa,
        d.cocompra,
        d.nuorden,
        d.coarticulo,
        d.qtarticulo,
        d.ssprecioingresado,
        d.ssprecio,
        d.coimpuesto,
        d.pqimpuesto,
        d.ssimpuesto,
        d.ssdescuento,
        d.pqdescuento,
        d.sspreciototal,
        d.colocal,
        d.coalmacen,
        d.coestreg,
        m.notipo AS nomoneda,
        m.nosigla AS nomonedasigla,
        i.notipo AS noimpuesto,
        i.nosigla AS noimpuestosigla,
        i.novalor AS noimpuestovalor,
        v.noestadoalmacen AS articulo_noestadoalmacen,
        v.nosegmentogrupo AS articulo_nosegmentogrupo,
        v.nosegmento AS articulo_nosegmento,
        v.nofamilia AS articulo_nofamilia,
        v.noclase AS articulo_noclase,
        v.nomarca AS articulo_nomarca,
        v.nomodelo AS articulo_nomodelo,
        v.noarticulo AS articulo_noarticulo,
        v.nounidadentrada AS articulo_nounidadentrada
    FROM facturacion.tblcompradetalle d
	    INNER JOIN facturacion.tblcompra c ON d.coempresa = c.coempresa AND d.cocompra = c.cocompra
	    INNER JOIN inventario.vwarticulo v ON d.coempresa = v.coempresa AND d.coarticulo = v.coarticulo
	    INNER JOIN vw_tipogeneral m ON c.comoneda = m.cotipo AND m.d = 'contabilidad.tipomoneda'
	    LEFT JOIN vw_tipo i ON d.coempresa = i.coempresa AND d.coimpuesto = i.cotipo AND i.d = 'contabilidad.impuesto'
    WHERE d.coempresa = p_coempresa AND d.cocompra = p_cocompra;
END;
$$;


ALTER FUNCTION facturacion.fn_compradetalle_sel_all(p_coempresa integer, p_cocompra integer) OWNER TO postgres;

--
-- Name: fn_compradetalle_sel_by_id(integer, integer); Type: FUNCTION; Schema: facturacion; Owner: postgres
--

CREATE FUNCTION facturacion.fn_compradetalle_sel_by_id(p_coempresa integer, p_cocompradetalle integer) RETURNS TABLE(cocompradetalle integer, coempresa integer, cocompra integer, nuorden integer, coarticulo integer, qtarticulo integer, ssprecio numeric, ssprecioingresado numeric, coimpuesto integer, ssimpuesto numeric, ssdescuento numeric, pqimpuesto numeric, pqdescuento numeric, sspreciototal numeric, colocal integer, coalmacen integer, coestreg integer, nomoneda text, nomonedasigla text, articulo_noestadoalmacen text, articulo_nosegmentogrupo text, articulo_nosegmento text, articulo_nofamilia text, articulo_noclase text, articulo_nomarca text, articulo_nomodelo text, articulo_noarticulo text, articulo_articulo_nomoneda text, articulo_articulo_nomonedasigla text, articulo_nounidadentrada text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT
        d.cocompradetalle,
        d.coempresa,
        d.cocompra,
        d.nuorden,
        d.coarticulo,
        d.qtarticulo,
        d.ssprecio,
        d.ssprecioingresado,
        d.coimpuesto,
        d.ssimpuesto,
        d.ssdescuento,
        d.pqimpuesto,
        d.pqdescuento,
        d.sspreciototal,
        d.colocal,
        d.coalmacen,
        d.coestreg,
        m.notipo AS nomoneda,
        m.nosigla AS nomonedasigla,
        v.noestadoalmacen AS articulo_noestadoalmacen,
        v.nosegmentogrupo AS articulo_nosegmentogrupo,
        v.nosegmento AS articulo_nosegmento,
        v.nofamilia AS articulo_nofamilia,
        v.noclase AS articulo_noclase,
        v.nomarca AS articulo_nomarca,
        v.nomodelo AS articulo_nomodelo,
        v.noarticulo AS articulo_noarticulo,
        m.notipo AS articulo_articulo_nomoneda,
        m.nosigla AS articulo_articulo_nomonedasigla,
        v.nounidadentrada AS articulo_nounidadentrada
    FROM facturacion.tblcompradetalle d
    INNER JOIN facturacion.tblcompra c ON d.coempresa = c.coempresa AND d.cocompra = c.cocompra
    INNER JOIN inventario.vwarticulo v ON d.coempresa = v.coempresa AND d.coarticulo = v.coarticulo
    INNER JOIN maestro.vw_tipogeneral m ON c.comoneda = m.cotipo AND m.d = 'contabilidad.tipomoneda'
    WHERE d.coempresa = p_coempresa
      AND d.cocompradetalle = p_cocompradetalle;
END;
$$;


ALTER FUNCTION facturacion.fn_compradetalle_sel_by_id(p_coempresa integer, p_cocompradetalle integer) OWNER TO postgres;

--
-- Name: fn_compradetalle_update_by_id(integer, integer, integer, integer, integer, integer, numeric, integer, numeric, numeric, numeric, numeric, integer, integer, character varying, integer); Type: FUNCTION; Schema: facturacion; Owner: postgres
--

CREATE FUNCTION facturacion.fn_compradetalle_update_by_id(p_coempresa integer, p_cocompradetalle integer, p_cocompra integer, p_nuorden integer, p_coarticulo integer, p_qtarticulo integer, p_ssprecioingresado numeric, p_coimpuesto integer, p_pqimpuesto numeric, p_ssimpuesto numeric, p_pqdescuento numeric, p_ssdescuento numeric, p_colocal integer, p_coalmacen integer, p_noserie character varying, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_rows integer;
    v_qtarticulorepetido int;
    v_sspreciototal numeric(14,4);
    v_noestadoalmacen varchar(100);
	v_ssprecio numeric(14,4);	
    p_i int;
BEGIN
    -- Validar si el artículo ya existe
    SELECT COUNT(1) INTO v_qtarticulorepetido
    FROM facturacion.tblcompradetalle
    WHERE coempresa = p_coempresa AND cocompra = p_cocompra AND coarticulo = p_coarticulo;

    IF v_qtarticulorepetido > 1 THEN
        RAISE EXCEPTION 'El artículo ya se ingresó.';
    END IF;

    -- Eliminar detalle anterior
    CALL facturacion.fn_compradetalle_delete_by_id(p_coempresa, p_cocompradetalle, p_cousumod, 0);

    -- Calcular descuentos e impuestos
    SELECT ssprecio, pqimpuesto, pqdescuento, ssdescuento, ssimpuesto, sspreciototal
    INTO v_ssprecio, p_pqimpuesto, p_pqdescuento, p_ssdescuento, p_ssimpuesto, v_sspreciototal
    FROM facturacion.fn_descuento_and_impuesto_compra(p_coempresa, p_cocompra, p_ssprecioingresado, p_pqdescuento, p_coimpuesto, p_qtarticulo);

    -- Obtener local
    SELECT colocal INTO p_colocal
    FROM inventario.tblalmacen
    WHERE coempresa = p_coempresa AND coalmacen = p_coalmacen;

    -- Actualizar detalle
    UPDATE facturacion.tblcompradetalle
    SET
        coarticulo = p_coarticulo,
        qtarticulo = p_qtarticulo,
        ssprecioingresado = p_ssprecioingresado,
        ssprecio = v_ssprecio,
        coimpuesto = p_coimpuesto,
        pqimpuesto = p_pqimpuesto,
        ssimpuesto = p_ssimpuesto,
        ssdescuento = p_ssdescuento,
        pqdescuento = p_pqdescuento,
        sspreciototal = v_sspreciototal,
        colocal = p_colocal,
        coalmacen = p_coalmacen,
        cousumod = p_cousumod,
        femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    WHERE coempresa = p_coempresa AND cocompradetalle = p_cocompradetalle;

    -- Verificar si el artículo es inventariable
    SELECT noestadoalmacen INTO v_noestadoalmacen
    FROM inventario.vw_articulo
    WHERE coempresa = p_coempresa AND coarticulo = p_coarticulo;

    IF v_noestadoalmacen = 'INVENTARIABLE' THEN
        p_i := 0;
        WHILE p_i < p_qtarticulo LOOP
            p_i := p_i + 1;
            CALL inventario.fn_inventario_insert(p_coempresa, p_cocompra, p_cocompradetalle, p_coarticulo, p_noserie, p_colocal, p_coalmacen, p_cousumod);
        END LOOP;
    END IF;

    -- Recalcular totales de la compra
    CALL facturacion.fn_compra_sumall(p_coempresa, p_cocompra);
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION facturacion.fn_compradetalle_update_by_id(p_coempresa integer, p_cocompradetalle integer, p_cocompra integer, p_nuorden integer, p_coarticulo integer, p_qtarticulo integer, p_ssprecioingresado numeric, p_coimpuesto integer, p_pqimpuesto numeric, p_ssimpuesto numeric, p_pqdescuento numeric, p_ssdescuento numeric, p_colocal integer, p_coalmacen integer, p_noserie character varying, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_compradetalle_update_state_by_id(integer, integer, integer, integer); Type: FUNCTION; Schema: facturacion; Owner: postgres
--

CREATE FUNCTION facturacion.fn_compradetalle_update_state_by_id(p_coempresa integer, p_cocompradetalle integer, p_coestreg integer, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_rows integer;
    v_cocompra int;
BEGIN
    -- Obtener la compra asociada al detalle
    SELECT cocompra INTO v_cocompra
    FROM facturacion.tblcompradetalle
    WHERE coempresa = p_coempresa AND cocompradetalle = p_cocompradetalle;

    -- Actualizar estado del detalle
    UPDATE facturacion.tblcompradetalle
    SET coestreg = p_coestreg,
        cousumod = p_cousumod,
        femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    WHERE coempresa = p_coempresa AND cocompradetalle = p_cocompradetalle;

    -- Recalcular totales de la compra
    CALL facturacion.fn_compra_sumall(p_coempresa, v_cocompra);
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION facturacion.fn_compradetalle_update_state_by_id(p_coempresa integer, p_cocompradetalle integer, p_coestreg integer, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_correlativo_delete_by_id(integer, integer, integer); Type: FUNCTION; Schema: facturacion; Owner: postgres
--

CREATE FUNCTION facturacion.fn_correlativo_delete_by_id(p_coempresa integer, p_cocorrelativo integer, p_cousueli integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
Declare
	v_rows integer;
 v_old JSONB;
BEGIN

	SELECT row_to_json(x) INTO v_old
    FROM facturacion.tblcorrelativo x
    WHERE coempresa = p_coempresa And cocorrelativo = p_cocorrelativo;

    CALL seguridad.usp_auditoria(
 		p_coempresa,	-- Empresa
        'facturacion',                          -- Esquema
		'tblcorrelativo',                  -- tabla
		'D',                        -- acción
        p_cousueli,                        -- usuario
        jsonb_build_object('cocorrelativo', p_cocorrelativo),
        v_old,
        NULL
    );

    Delete from facturacion.tblcorrelativo WHERE coempresa = p_coempresa AND cocorrelativo = p_cocorrelativo;
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION facturacion.fn_correlativo_delete_by_id(p_coempresa integer, p_cocorrelativo integer, p_cousueli integer) OWNER TO postgres;

--
-- Name: fn_correlativo_insert(integer, integer, integer, character varying, integer, integer); Type: FUNCTION; Schema: facturacion; Owner: postgres
--

CREATE FUNCTION facturacion.fn_correlativo_insert(p_coempresa integer, p_colocal integer, p_cotipodocumento integer, p_nuserie character varying, p_nudocumento integer, p_cousucre integer) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
DECLARE 	
    v_cocorrelativo BIGINT;
BEGIN


insert into facturacion.tblcorrelativo (
	coempresa,
	colocal,
	cotipodocumento,
	nuserie,
	nudocumento,
	cousucre
)
values 
(
	p_coempresa,
	p_colocal,
	p_cotipodocumento,
	p_nuserie,
	p_nudocumento,
	p_cousucre

) 	
RETURNING cocorrelativo INTO v_cocorrelativo;

	RETURN v_cocorrelativo;
	
END;
$$;


ALTER FUNCTION facturacion.fn_correlativo_insert(p_coempresa integer, p_colocal integer, p_cotipodocumento integer, p_nuserie character varying, p_nudocumento integer, p_cousucre integer) OWNER TO postgres;

--
-- Name: fn_correlativo_sel_all(integer, integer, integer, integer); Type: FUNCTION; Schema: facturacion; Owner: postgres
--

CREATE FUNCTION facturacion.fn_correlativo_sel_all(p_coempresa integer, p_colocal integer, p_cotipodocumento integer, p_coestreg integer) RETURNS TABLE(cocorrelativo integer, coempresa integer, colocal integer, nolocal character varying, cotipodocumento integer, notipodocumentotributario character varying, notipodocumentotributariosigla character varying, nuserie character varying, nudocumento character varying, fldefecto boolean, coestreg integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT
        tblcorrelativo.cocorrelativo,
        tblcorrelativo.coempresa,
        tblcorrelativo.colocal,
        trflocal.nolocal,
        tblcorrelativo.cotipodocumento,
        tipodocumento.notipo AS notipodocumentotributario,
        tipodocumento.nosigla AS notipodocumentotributariosigla,
        tblcorrelativo.nuserie,
        tblcorrelativo.nudocumento,
        tblcorrelativo.fldefecto,
        tblcorrelativo.coestreg
    FROM facturacion.tblcorrelativo
    INNER JOIN empresa.trflocal 
        ON trflocal.coempresa = tblcorrelativo.coempresa 
       AND trflocal.colocal = tblcorrelativo.colocal
    INNER JOIN vw_tipogeneral tipodocumento 
        ON tblcorrelativo.cotipodocumento = tipodocumento.cotipo
       AND tipodocumento.d = 'contabilidad.tipodocumentotributario'
    WHERE tblcorrelativo.coempresa = p_coempresa
      AND (p_colocal IS NULL OR tblcorrelativo.colocal = p_colocal)
      AND (p_cotipodocumento IS NULL OR tblcorrelativo.cotipodocumento = p_cotipodocumento)
      AND (p_coestreg IS NULL OR tblcorrelativo.coestreg = p_coestreg);
END;
$$;


ALTER FUNCTION facturacion.fn_correlativo_sel_all(p_coempresa integer, p_colocal integer, p_cotipodocumento integer, p_coestreg integer) OWNER TO postgres;

--
-- Name: fn_correlativo_sel_by_id(integer, integer); Type: FUNCTION; Schema: facturacion; Owner: postgres
--

CREATE FUNCTION facturacion.fn_correlativo_sel_by_id(p_coempresa integer, p_cocorrelativo integer) RETURNS TABLE(cocorrelativo integer, coempresa integer, colocal integer, cotipodocumento integer, nuserie character varying, nudocumento character varying, fldefecto boolean, coestreg integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        tblcorrelativo.cocorrelativo,
        tblcorrelativo.coempresa,
        tblcorrelativo.colocal,
        tblcorrelativo.cotipodocumento,
        tblcorrelativo.nuserie,
        tblcorrelativo.nudocumento,
        tblcorrelativo.fldefecto,
        tblcorrelativo.coestreg
    FROM facturacion.tblcorrelativo
    WHERE tblcorrelativo.coempresa = p_coempresa
      AND tblcorrelativo.cocorrelativo = p_cocorrelativo;
END;
$$;


ALTER FUNCTION facturacion.fn_correlativo_sel_by_id(p_coempresa integer, p_cocorrelativo integer) OWNER TO postgres;

--
-- Name: fn_correlativo_sel_by_local_and_documento(integer, integer, integer); Type: FUNCTION; Schema: facturacion; Owner: postgres
--

CREATE FUNCTION facturacion.fn_correlativo_sel_by_local_and_documento(p_coempresa integer, p_colocal integer, p_cotipodocumento integer) RETURNS TABLE(cocorrelativo integer, coempresa integer, colocal integer, cotipodocumento integer, nuserie character varying, nudocumento character varying, fldefecto boolean, coestreg integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT
        tblcorrelativo.cocorrelativo,
        tblcorrelativo.coempresa,
        tblcorrelativo.colocal,
        tblcorrelativo.cotipodocumento,
        tblcorrelativo.nuserie,
        tblcorrelativo.nudocumento,
        tblcorrelativo.fldefecto,
        tblcorrelativo.coestreg
    FROM facturacion.tblcorrelativo
    WHERE tblcorrelativo.coempresa = p_coempresa
      AND tblcorrelativo.colocal = p_colocal
      AND tblcorrelativo.cotipodocumento = p_cotipodocumento;
END;
$$;


ALTER FUNCTION facturacion.fn_correlativo_sel_by_local_and_documento(p_coempresa integer, p_colocal integer, p_cotipodocumento integer) OWNER TO postgres;

--
-- Name: fn_correlativo_update(integer, integer, integer, character varying); Type: FUNCTION; Schema: facturacion; Owner: postgres
--

CREATE FUNCTION facturacion.fn_correlativo_update(p_coempresa integer, p_colocal integer, p_cotipodocumento integer, p_nuserie character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_nudocumento INT;
    v_qtdocumento INT;
BEGIN
    -- Obtener el siguiente número de documento
    SELECT COALESCE(MAX(nudocumento), 0) + 1
    INTO v_nudocumento
    FROM facturacion.tblcorrelativo
    WHERE coestreg = 1
      AND coempresa = p_coempresa
      AND colocal = p_colocal
      AND cotipodocumento = p_cotipodocumento;

    IF v_nudocumento IS NOT NULL THEN
        -- Verificar si el número de documento ya existe en tblventa
        SELECT COUNT(1)
        INTO v_qtdocumento
        FROM facturacion.tblventa
        WHERE coempresa = p_coempresa
          AND cotipodocumento = p_cotipodocumento
          AND nuserie = p_nuserie
          AND nudocumento = v_nudocumento;

        IF v_qtdocumento > 0 THEN
            RAISE EXCEPTION 'El número de documento ya existe.';
        END IF;

        -- Actualizar el correlativo
        UPDATE facturacion.tblcorrelativo
        SET nudocumento = v_nudocumento
        WHERE coestreg = 1
          AND coempresa = p_coempresa
          AND colocal = p_colocal
          AND cotipodocumento = p_cotipodocumento;
    END IF;

    RETURN v_nudocumento;
END;
$$;


ALTER FUNCTION facturacion.fn_correlativo_update(p_coempresa integer, p_colocal integer, p_cotipodocumento integer, p_nuserie character varying) OWNER TO postgres;

--
-- Name: fn_correlativo_update_by_id(integer, integer, integer, integer, character varying, integer, integer); Type: FUNCTION; Schema: facturacion; Owner: postgres
--

CREATE FUNCTION facturacion.fn_correlativo_update_by_id(p_coempresa integer, p_cocorrelativo integer, p_colocal integer, p_cotipodocumento integer, p_nuserie character varying, p_nudocumento integer, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_rows integer;
BEGIN
    UPDATE facturacion.tblcorrelativo
    SET
        colocal = p_colocal,
        cotipodocumento = p_cotipodocumento,
        nuserie = p_nuserie,
        nudocumento = p_nudocumento,
        cousumod = p_cousumod,
        femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    WHERE coempresa = p_coempresa
      AND cocorrelativo = p_cocorrelativo;
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION facturacion.fn_correlativo_update_by_id(p_coempresa integer, p_cocorrelativo integer, p_colocal integer, p_cotipodocumento integer, p_nuserie character varying, p_nudocumento integer, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_correlativo_update_state_by_id(integer, integer, integer, integer); Type: FUNCTION; Schema: facturacion; Owner: postgres
--

CREATE FUNCTION facturacion.fn_correlativo_update_state_by_id(p_coempresa integer, p_cocorrelativo integer, p_coestreg integer, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_rows integer;
BEGIN
    UPDATE facturacion.tblcorrelativo
    SET
        coestreg = p_coestreg,
        cousumod = p_cousumod,
        femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    WHERE coempresa = p_coempresa
      AND cocorrelativo = p_cocorrelativo;
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION facturacion.fn_correlativo_update_state_by_id(p_coempresa integer, p_cocorrelativo integer, p_coestreg integer, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_descuento_and_impuesto_compra(integer, integer, numeric, numeric, integer, integer); Type: FUNCTION; Schema: facturacion; Owner: postgres
--

CREATE FUNCTION facturacion.fn_descuento_and_impuesto_compra(p_coempresa integer, p_cocompra integer, p_ssprecioingresado numeric, p_pqdescuento numeric, p_coimpuesto integer, p_qtarticulo integer) RETURNS TABLE(ssprecio numeric, pqimpuesto numeric, pqdescuento numeric, ssdescuento numeric, ssimpuesto numeric, sspreciototal numeric)
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_pqimpuesto numeric(14,4);
    v_ssprecio numeric(14,4);
    v_ssdescuento numeric(14,4);
    v_ssimpuesto numeric(14,4);
    v_sspreciototal numeric(14,4);
    v_flimpuestoincluyeprecio smallint;
BEGIN
    -- Convertir descuento a decimal
    p_pqdescuento := COALESCE(p_pqdescuento,0) / 100;

    -- Calcular descuento
    v_ssdescuento := p_ssprecioingresado * p_pqdescuento;
    v_ssprecio := p_ssprecioingresado - v_ssdescuento;

    -- Calcular impuesto
    IF p_coimpuesto IS NOT NULL THEN
        SELECT flimpuestoincluyeprecio INTO v_flimpuestoincluyeprecio
        FROM facturacion.tblcompra
        WHERE coempresa = p_coempresa AND cocompra = p_cocompra;

        SELECT COALESCE(novalor,0)::numeric(14,4) / 100 INTO v_pqimpuesto
        FROM maestros.trftipo
        WHERE coempresa = p_coempresa AND cogrupo = 47 AND cotipo = p_coimpuesto;

        IF v_flimpuestoincluyeprecio = 1 THEN
            -- Impuesto incluido en el precio
            v_ssimpuesto := v_ssprecio - (v_ssprecio / (1 + v_pqimpuesto));
            v_ssprecio := v_ssprecio - v_ssimpuesto;
            v_sspreciototal := (v_ssprecio + v_ssimpuesto) * p_qtarticulo;
        ELSE
            -- Impuesto agregado al precio
            v_ssimpuesto := v_ssprecio * v_pqimpuesto;
            v_sspreciototal := (v_ssprecio + v_ssimpuesto) * p_qtarticulo;
        END IF;
    ELSE
        v_pqimpuesto := 0;
        v_ssimpuesto := 0;
        v_ssprecio := COALESCE(p_ssprecioingresado,0);
        v_sspreciototal := v_ssprecio * p_qtarticulo;
    END IF;

    RETURN QUERY
    SELECT v_ssprecio, v_pqimpuesto, p_pqdescuento, v_ssdescuento, v_ssimpuesto, v_sspreciototal;
END;
$$;


ALTER FUNCTION facturacion.fn_descuento_and_impuesto_compra(p_coempresa integer, p_cocompra integer, p_ssprecioingresado numeric, p_pqdescuento numeric, p_coimpuesto integer, p_qtarticulo integer) OWNER TO postgres;

--
-- Name: fn_descuento_and_impuesto_venta(integer, integer, numeric, numeric, integer, integer); Type: FUNCTION; Schema: facturacion; Owner: postgres
--

CREATE FUNCTION facturacion.fn_descuento_and_impuesto_venta(p_coempresa integer, p_coventa integer, p_ssprecioingresado numeric, p_pqdescuento numeric, p_coimpuesto integer, p_qtarticulo integer) RETURNS TABLE(ssprecio numeric, pqimpuesto numeric, pqdescuento numeric, ssdescuento numeric, ssimpuesto numeric, sspreciototal numeric)
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_pqimpuesto    numeric(14,4) := 0;
    v_ssprecio      numeric(14,4) := 0;
    v_ssdescuento   numeric(14,4) := 0;
    v_ssimpuesto    numeric(14,4) := 0;
    v_sspreciototal numeric(14,4) := 0;
BEGIN
    -- Descuento como decimal (0 si es nulo)
    p_pqdescuento := coalesce(p_pqdescuento,0) / 100;

    -- Hallar el descuento
    v_ssdescuento := coalesce(p_ssprecioingresado,0) * p_pqdescuento;
    v_ssprecio := coalesce(p_ssprecioingresado,0) - v_ssdescuento;

    -- Hallar el impuesto
    IF p_coimpuesto IS NOT NULL THEN
        SELECT coalesce(novalor,0)::numeric(14,4)
        INTO v_pqimpuesto
        FROM maestros.trftipo
        WHERE coempresa = p_coempresa
          AND cogrupo = 47
          AND cotipo = p_coimpuesto;

        v_pqimpuesto := coalesce(v_pqimpuesto,0) / 100;

        -- Cálculo de impuestos incluidos en el precio
        v_ssimpuesto := v_ssprecio - (v_ssprecio / (1 + v_pqimpuesto));
        v_ssprecio := v_ssprecio - v_ssimpuesto;
        v_sspreciototal := (v_ssprecio + v_ssimpuesto) * coalesce(p_qtarticulo,0);
    ELSE
        v_pqimpuesto := 0;
        v_ssimpuesto := 0;
        v_ssprecio := coalesce(p_ssprecioingresado,0);
        v_sspreciototal := v_ssprecio * coalesce(p_qtarticulo,0);
    END IF;

    -- Devolver resultado como tabla
    RETURN QUERY
    SELECT v_ssprecio, v_pqimpuesto, p_pqdescuento, v_ssdescuento, v_ssimpuesto, v_sspreciototal;
END;
$$;


ALTER FUNCTION facturacion.fn_descuento_and_impuesto_venta(p_coempresa integer, p_coventa integer, p_ssprecioingresado numeric, p_pqdescuento numeric, p_coimpuesto integer, p_qtarticulo integer) OWNER TO postgres;

--
-- Name: fn_venta_delete_by_id(integer, integer, integer); Type: FUNCTION; Schema: facturacion; Owner: postgres
--

CREATE FUNCTION facturacion.fn_venta_delete_by_id(p_coempresa integer, p_coventa integer, p_cousueli integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
Declare
	v_rows integer;
 	v_old JSONB;
    rec RECORD;
BEGIN
    -- Recorre cada detalle de la venta
    FOR rec IN
        SELECT coventadetalle
        FROM facturacion.tblventadetalle
        WHERE coempresa = p_coempresa AND coventa = p_coventa
    LOOP
        -- Llamada al procedimiento para eliminar detalle
        CALL facturacion.fn_ventadetalle_delete_by_id(p_coempresa, rec.coventadetalle, p_cousueli, 1);
    END LOOP;

    -- Actualiza la cabecera de la venta
	SELECT row_to_json(x) INTO v_old
    FROM facturacion.tblventa x
    WHERE coempresa = p_coempresa And coventa = p_coventa;

    CALL seguridad.usp_auditoria(
 		p_coempresa,	-- Empresa
        'facturacion',                          -- Esquema
		'tblventa',                  -- tabla
		'D',                        -- acción
        p_cousueli,                        -- usuario
        jsonb_build_object('coventa', p_coventa),
        v_old,
        NULL
    );	
    Delete From facturacion.tblventa WHERE coempresa = p_coempresa AND coventa = p_coventa;

	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION facturacion.fn_venta_delete_by_id(p_coempresa integer, p_coventa integer, p_cousueli integer) OWNER TO postgres;

--
-- Name: fn_venta_insert(integer, integer, integer, character varying, integer, character, character, integer, integer, integer, integer, character varying, integer); Type: FUNCTION; Schema: facturacion; Owner: postgres
--

CREATE FUNCTION facturacion.fn_venta_insert(p_coempresa integer, p_colocal integer, p_cotipodocumento integer, p_nuserie character varying, p_nudocumento integer, p_feventa character, p_fevencimiento character, p_comoneda integer, p_cocliente integer, p_comodopago integer, p_comediopago integer, p_txdescripcion character varying, p_cousucre integer) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
DECLARE 	
    v_coventa BIGINT;
	v_comonedasecundaria integer;
	v_cotipocambio BIGINT;
	v_nudocumento integer;
begin


/*  cotipodocumento
	cotipo	notipo
	1		factura								serie	
	3		boleta								serie	
	7		nota de credito						serie	
	8		nota de debito						serie	
	9		guia de remisión remitente			serie	
	12		ticket de maquina registradora		serie	
	100		ingreso inventario					serie	
	101		salida inventario					serie	
*/
	
	v_comonedasecundaria = contabilidad.fn_moneda_secundaria();
	v_cotipocambio = contabilidad.fn_tipocambio_insert_by_fecha(p_coempresa, p_comonedasecundaria, p_feventa);
	
	/*correlativo*/	
	v_nudocumento = facturacion.fn_correlativo_update(p_coempresa, p_colocal, p_cotipodocumento, p_nuserie);
	
	
	   IF v_nudocumento Is Null THEN
            RAISE EXCEPTION '|falta determinar el correlativo del documento.|';
        END IF;
	

insert into facturacion.tblventa (
	coempresa,
	colocal,
	cotipodocumento,
	nuserie,
	nudocumento,
	feventa,
	fevencimiento,
	comoneda,
	cotipocambio,
	cocliente,
	comodopago,
	comediopago,
	txdescripcion,
	cousucre
)
values 
(
	p_coempresa,
	p_colocal,
	p_cotipodocumento,
	p_nuserie,
	p_nudocumento,
	p_feventa,
	p_fevencimiento,
	p_comoneda,
	v_cotipocambio,
	p_cocliente,	
	p_comodopago,
	p_comediopago,
	p_txdescripcion,
	p_cousucre
) 
	RETURNING coventa INTO v_coventa;

	RETURN v_coventa;
	
END;
$$;


ALTER FUNCTION facturacion.fn_venta_insert(p_coempresa integer, p_colocal integer, p_cotipodocumento integer, p_nuserie character varying, p_nudocumento integer, p_feventa character, p_fevencimiento character, p_comoneda integer, p_cocliente integer, p_comodopago integer, p_comediopago integer, p_txdescripcion character varying, p_cousucre integer) OWNER TO postgres;

--
-- Name: fn_venta_sel_by_id(integer, integer); Type: FUNCTION; Schema: facturacion; Owner: postgres
--

CREATE FUNCTION facturacion.fn_venta_sel_by_id(p_coempresa integer, p_coventa integer) RETURNS TABLE(coventa integer, coempresa integer, colocal integer, cotipodocumento integer, notipodocumento character varying, notipodocumentosigla character varying, nuserie character varying, nudocumento character varying, feventa character varying, fevencimiento character varying, comoneda integer, nomoneda character varying, nomonedasigla character varying, cotipocambio integer, cocliente integer, ssprecio numeric, ssimpuesto numeric, ssdescuento numeric, nunotasalida integer, comodopago integer, comediopago integer, nomodopago character varying, nomediopago character varying, txdescripcion character varying, coestreg integer, tipocambio_sstipocambioventa numeric, tipocambio_sstipocambiocompra numeric, tipocambio_fetipocambio date, tipocambio_flautomatico boolean, cliente_nopersona character varying, cliente_noapellidop character varying, cliente_noapellidom character varying, cliente_nudocumento character varying, cliente_notipodocumento character varying, cliente_notipodocumentosigla character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
        v.coventa,
        v.coempresa,
        v.colocal,
        v.cotipodocumento,
        td.notipo      AS notipodocumento,
        td.nosigla     AS notipodocumentosigla,
        v.nuserie,
        v.nudocumento,
        v.feventa,
        v.fevencimiento,
        v.comoneda,
        m.notipo       AS nomoneda,
        m.nosigla      AS nomonedasigla,
        v.cotipocambio,
        v.cocliente,
        v.ssprecio,
        v.ssimpuesto,
        v.ssdescuento,
        v.nunotasalida,
        v.comodopago,
        v.comediopago,
        mp.notipo      AS nomodopago,
        me.notipo      AS nomediopago,
        v.txdescripcion,
        v.coestreg,
        tc.sstipocambioventa,
        tc.sstipocambiocompra,
        tc.fetipocambio,
        tc.flautomatico,
        c.nopersona    AS cliente_nopersona,
        c.noapellidop  AS cliente_noapellidop,
        c.noapellidom  AS cliente_noapellidom,
        c.nudocumento  AS cliente_nudocumento,
        tdc.notipo     AS cliente_notipodocumento,
        tdc.nosigla    AS cliente_notipodocumentosigla
    FROM facturacion.tblventa v
    LEFT JOIN maestros.tblpersona c ON v.coempresa = c.coempresa AND v.cocliente = c.copersona
    LEFT JOIN maestros.vw_tipogeneral td ON v.cotipodocumento = td.cotipo AND td.d = 'contabilidad.tipodocumentotributario'
    LEFT JOIN maestros.vw_tipogeneral m ON v.comoneda = m.cotipo AND m.d = 'contabilidad.tipomoneda'
    LEFT JOIN maestros.vw_tipogeneral tdc ON c.cotipodocumento = tdc.cotipo AND tdc.d = 'tipodocumento'
    INNER JOIN contabilidad.trftipocambio tc ON v.coempresa = tc.coempresa AND v.cotipocambio = tc.cotipocambio
    LEFT JOIN maestros.vw_tipogeneral mp ON v.comodopago = mp.cotipo AND mp.d = 'contabilidad.modopago'
    LEFT JOIN maestros.vw_tipogeneral me ON v.comediopago = me.cotipo AND me.d = 'contabilidad.mediopago'
    WHERE v.coempresa = p_coempresa
      AND v.coventa   = p_coventa;
END;
$$;


ALTER FUNCTION facturacion.fn_venta_sel_by_id(p_coempresa integer, p_coventa integer) OWNER TO postgres;

--
-- Name: fn_venta_sum_all(integer, integer); Type: FUNCTION; Schema: facturacion; Owner: postgres
--

CREATE FUNCTION facturacion.fn_venta_sum_all(p_coempresa integer, p_coventa integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_rows integer;
    v_ssprecio    numeric(14,4);
    v_ssdescuento numeric(14,4);
    v_ssimpuesto  numeric(14,4);
BEGIN
    -- Calcular sumas
    SELECT 
        SUM(coalesce(ssprecio,0) * coalesce(qtarticulo,0)),
        SUM(coalesce(ssdescuento,0) * coalesce(qtarticulo,0)),
        SUM(coalesce(ssimpuesto,0) * coalesce(qtarticulo,0))
    INTO v_ssprecio, v_ssdescuento, v_ssimpuesto
    FROM facturacion.tblventadetalle
    WHERE coestreg = 1 
      AND coempresa = p_coempresa 
      AND coventa   = p_coventa;

    -- Actualizar tabla venta
    UPDATE facturacion.tblventa
    SET ssprecio    = coalesce(v_ssprecio,0),
        ssdescuento = coalesce(v_ssdescuento,0),
        ssimpuesto  = coalesce(v_ssimpuesto,0)
    WHERE coempresa = p_coempresa 
      AND coventa   = p_coventa;

	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION facturacion.fn_venta_sum_all(p_coempresa integer, p_coventa integer) OWNER TO postgres;

--
-- Name: fn_venta_update_by_id(integer, integer, integer, character varying, integer, character, character, integer, integer, integer, integer, integer, character varying, integer); Type: FUNCTION; Schema: facturacion; Owner: postgres
--

CREATE FUNCTION facturacion.fn_venta_update_by_id(p_coempresa integer, p_coventa integer, p_cotipodocumento integer, p_nuserie character varying, p_nudocumento integer, p_feventa character, p_fevencimiento character, p_comoneda integer, p_cotipocambio integer, p_cocliente integer, p_comodopago integer, p_comediopago integer, p_txdescripcion character varying, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_rows integer;
    v_comonedasecundaria int;
	v_cotipocambio BIGINT;
BEGIN 

    -- Obtener moneda secundaria
    SELECT contabilidad.comonedasecundaria()
    INTO v_comonedasecundaria;

    -- Llamada al procedimiento de tipo de cambio
    v_cotipocambio = contabilidad.fn_tipocambio_insert_by_fecha(
        p_coempresa,
        v_comonedasecundaria,
        p_feventa
    );

    -- Actualizar venta
    UPDATE facturacion.tblventa
    SET
        cotipodocumento = p_cotipodocumento,
        nuserie         = p_nuserie,
        nudocumento     = p_nudocumento,
        feventa         = p_feventa,
        fevencimiento   = p_fevencimiento,    
        cocliente       = p_cocliente,    
        cotipocambio    = p_cotipocambio,
        comodopago      = p_comodopago,
        comediopago     = p_comediopago,
        txdescripcion   = p_txdescripcion,
        cousumod        = p_cousumod,
        femod           = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    WHERE coempresa = p_coempresa 
      AND coventa   = p_coventa;
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION facturacion.fn_venta_update_by_id(p_coempresa integer, p_coventa integer, p_cotipodocumento integer, p_nuserie character varying, p_nudocumento integer, p_feventa character, p_fevencimiento character, p_comoneda integer, p_cotipocambio integer, p_cocliente integer, p_comodopago integer, p_comediopago integer, p_txdescripcion character varying, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_venta_update_state_by_id(integer, integer, integer, integer); Type: FUNCTION; Schema: facturacion; Owner: postgres
--

CREATE FUNCTION facturacion.fn_venta_update_state_by_id(p_coempresa integer, p_coventa integer, p_coestreg integer, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_rows integer;
BEGIN
    UPDATE facturacion.tblventa
    SET coestreg = p_coestreg,
        cousumod = p_cousumod,
        femod    = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    WHERE coempresa = p_coempresa
      AND coventa   = p_coventa;
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION facturacion.fn_venta_update_state_by_id(p_coempresa integer, p_coventa integer, p_coestreg integer, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_ventadetalle_delete_by_id(integer, integer, integer, integer); Type: FUNCTION; Schema: facturacion; Owner: postgres
--

CREATE FUNCTION facturacion.fn_ventadetalle_delete_by_id(p_coempresa integer, p_coventadetalle integer, p_cousueli integer, p_fldeletedetalle integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_rows integer;
    rec RECORD;
    v_qtunidadsalidaventa integer;
	v_old JSONB;
BEGIN
    -- Itera sobre los registros de tblinventarioventa
    FOR rec IN
        SELECT coinventariocompra, coinventarioventa
        FROM inventario.tblinventarioventa
        WHERE coempresa = p_coempresa AND coventadetalle = p_coventadetalle
    LOOP
        -- Elimina cada registro
        DELETE FROM inventario.tblinventarioventa
        WHERE coempresa = p_coempresa
          AND coventadetalle = p_coventadetalle
          AND coinventariocompra = rec.coinventariocompra
          AND coinventarioventa = rec.coinventarioventa;

        -- Sumar las ventas totales
        SELECT COALESCE(SUM(qtunidadsalidaventa),0)
        INTO v_qtunidadsalidaventa
        FROM inventario.tblinventarioventa
        WHERE coempresa = p_coempresa
          AND coinventariocompra = rec.coinventariocompra;

        UPDATE inventario.tblinventariocompra
        SET qtunidadsalidaventa = v_qtunidadsalidaventa
        WHERE coempresa = p_coempresa AND coinventariocompra = rec.coinventariocompra;
    END LOOP;

    -- Marca el detalle como eliminado si p_fldeletedetalle = 1
    IF p_fldeletedetalle = 1 THEN
	
		SELECT row_to_json(x) INTO v_old
	    FROM facturacion.tblventadetalle x
	    WHERE coempresa = p_coempresa And coventadetalle = p_coventadetalle;
	
	    CALL seguridad.usp_auditoria(
	 		p_coempresa,	-- Empresa
	        'facturacion',                          -- Esquema
			'tblventadetalle',                  -- tabla
			'D',                        -- acción
	        p_cousueli,                        -- usuario
	        jsonb_build_object('coventadetalle', p_coventadetalle),
	        v_old,
	        NULL
	    );

        Delete From facturacion.tblventadetalle Where coempresa = p_coempresa AND coventadetalle = p_coventadetalle;
    END IF;
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION facturacion.fn_ventadetalle_delete_by_id(p_coempresa integer, p_coventadetalle integer, p_cousueli integer, p_fldeletedetalle integer) OWNER TO postgres;

--
-- Name: fn_ventadetalle_insert(integer, integer, integer, integer, numeric, integer, numeric, numeric, numeric, numeric, integer, integer, character varying, integer); Type: FUNCTION; Schema: facturacion; Owner: postgres
--

CREATE FUNCTION facturacion.fn_ventadetalle_insert(p_coempresa integer, p_coventa integer, p_coarticulo integer, p_qtarticulo integer, p_ssprecioingresado numeric, p_coimpuesto integer, p_pqimpuesto numeric, p_ssimpuesto numeric, p_pqdescuento numeric, p_ssdescuento numeric, p_colocal integer, p_coalmacen integer, p_noserie character varying, p_cousucre integer) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
DECLARE 	
    v_coperfilprivilegio BIGINT;
	v_coventadetalle BIGINT;
	v_qtarticulorepetido integer;
	v_ssprecio numeric(14,4);
	v_sspreciototal numeric(14,4);
	v_nuorden integer;
	v_noestadoalmacen varchar;
begin

	select count(1) into v_qtarticulorepetido from facturacion.tblventadetalle where coempresa = p_coempresa and coventa = p_coventa and coarticulo = p_coarticulo;
	
	IF v_qtarticulorepetido > 0 THEN
        RAISE EXCEPTION '|el artículo ya se ingreso.|';
    END IF;


	select 
		v_ssprecio = ssprecio,
		p_pqimpuesto = pqimpuesto,
		p_pqdescuento = pqdescuento,
		p_ssdescuento = ssdescuento,
		p_ssimpuesto = ssimpuesto,
		v_sspreciototal = sspreciototal
	from facturacion.fn_descuento_and_impuesto_venta(p_coempresa, p_coventa, p_ssprecioingresado, p_pqdescuento, p_coimpuesto, p_qtarticulo);

	
	
	/*hallar el correlativo.*/
	select isnull (max (nuorden), 0) + 1 into v_nuorden from facturacion.tblventadetalle where coempresa = p_coempresa and coventa = p_coventa;

	insert into facturacion.tblventadetalle (
		coempresa,	
		coventa,
		nuorden,
		coarticulo,
		qtarticulo,
		ssprecioingresado,
		ssprecio,
		coimpuesto,
		pqimpuesto,
		ssimpuesto,
		pqdescuento,
		ssdescuento,
		sspreciototal,	
		colocal, 
		coalmacen,
		cousucre
	)
	values 
	(
		p_coempresa,		
		p_coventa,
		v_nuorden,
		p_coarticulo,
		p_qtarticulo,
		p_ssprecioingresado,
		p_ssprecio,
		p_coimpuesto,
		p_pqimpuesto,
		p_ssimpuesto,
		p_pqdescuento,
		p_ssdescuento,
		p_sspreciototal,
		p_colocal, 
		p_coalmacen,
		p_cousucre
	) 
RETURNING coventadetalle INTO v_coventadetalle;

/*hallar si el articulo es inventariable.*/
	select articulo.noestadoalmacen into v_noestadoalmacen from inventario.vw_articulo articulo where coempresa = p_coempresa and coarticulo = p_coarticulo;

	if v_noestadoalmacen='INVENTARIABLE' THEN		
			Call inventario.usp_inventarioventa_insert_by_ventadetalle(
				p_coempresa, 
				p_coventa, 
				p_coventadetalle,
				p_coarticulo,
				p_qtarticulo,
				p_colocal, 
				p_coalmacen
				);
		end if;

	Call facturacion.usp_venta_sum_all(p_coventa, p_coempresa);

	RETURN v_coventadetalle;
	
END;
$$;


ALTER FUNCTION facturacion.fn_ventadetalle_insert(p_coempresa integer, p_coventa integer, p_coarticulo integer, p_qtarticulo integer, p_ssprecioingresado numeric, p_coimpuesto integer, p_pqimpuesto numeric, p_ssimpuesto numeric, p_pqdescuento numeric, p_ssdescuento numeric, p_colocal integer, p_coalmacen integer, p_noserie character varying, p_cousucre integer) OWNER TO postgres;

--
-- Name: fn_ventadetalle_sel_all(integer, integer); Type: FUNCTION; Schema: facturacion; Owner: postgres
--

CREATE FUNCTION facturacion.fn_ventadetalle_sel_all(p_coempresa integer, p_coventa integer) RETURNS TABLE(coventadetalle integer, coempresa integer, coventa integer, nuorden integer, coarticulo integer, qtarticulo numeric, ssprecioingresado numeric, ssprecio numeric, coimpuesto integer, pqimpuesto numeric, ssimpuesto numeric, pqdescuento numeric, ssdescuento numeric, sspreciototal numeric, colocal integer, coalmacen integer, nolocal character varying, noalmacen character varying, nomoneda character varying, nomonedasigla character varying, noimpuesto character varying, noimpuestosigla character varying, noimpuestovalor character varying, articulo_noestadoalmacen character varying, articulo_nosegmentogrupo character varying, articulo_nosegmento character varying, articulo_nofamilia character varying, articulo_noclase character varying, articulo_nomarca character varying, articulo_nomodelo character varying, articulo_noarticulo character varying, articulo_nounidadentrada character varying, articulo_nounidadsalida character varying, feventa character varying, comoneda integer, nunotasalida integer, coestreg integer)
    LANGUAGE sql
    AS $$
    SELECT
        d.coventadetalle,
        d.coempresa,
        d.coventa,
        d.nuorden,
        d.coarticulo,
        d.qtarticulo,
        d.ssprecioingresado,
        d.ssprecio,
        d.coimpuesto,
        d.pqimpuesto,
        d.ssimpuesto,
        d.pqdescuento,
        d.ssdescuento,
        d.sspreciototal,
        d.colocal,
        d.coalmacen,
        l.nolocal,
        a.noalmacen,
        m.notipo   AS nomoneda,
        m.nosigla  AS nomonedasigla,
        i.notipo   AS noimpuesto,
        i.nosigla  AS noimpuestosigla,
        i.novalor  AS noimpuestovalor,
        v.noestadoalmacen   AS articulo_noestadoalmacen,
        v.nosegmentogrupo   AS articulo_nosegmentogrupo,
        v.nosegmento        AS articulo_nosegmento,
        v.nofamilia         AS articulo_nofamilia,
        v.noclase           AS articulo_noclase,
        v.nomarca           AS articulo_nomarca,
        v.nomodelo          AS articulo_nomodelo,
        v.noarticulo        AS articulo_noarticulo,
        v.nounidadentrada   AS articulo_nounidadentrada,
        v.nounidadsalida    AS articulo_nounidadsalida,
        vta.feventa,
        vta.comoneda,
        vta.nunotasalida,
        d.coestreg
    FROM facturacion.tblventadetalle d
    INNER JOIN facturacion.tblventa vta ON d.coempresa = vta.coempresa AND d.coventa = vta.coventa
    INNER JOIN inventario.vw_articulo v ON d.coempresa = v.coempresa AND v.coarticulo = d.coarticulo
    INNER JOIN maestro.vw_tipogeneral m ON vta.comoneda = m.cotipo AND m.d = 'contabilidad.tipomoneda'
    LEFT JOIN empresa.trflocal l ON d.coempresa = l.coempresa AND d.colocal = l.colocal
    LEFT JOIN inventario.tblalmacen a ON d.coempresa = a.coempresa AND d.coalmacen = a.coalmacen
    LEFT JOIN maestro.vw_tipo i ON d.coempresa = i.coempresa AND d.coimpuesto = i.cotipo AND i.d = 'contabilidad.impuesto'
    WHERE d.coempresa = p_coempresa 
      AND d.coventa = p_coventa;
$$;


ALTER FUNCTION facturacion.fn_ventadetalle_sel_all(p_coempresa integer, p_coventa integer) OWNER TO postgres;

--
-- Name: fn_ventadetalle_sel_by_id(integer, integer); Type: FUNCTION; Schema: facturacion; Owner: postgres
--

CREATE FUNCTION facturacion.fn_ventadetalle_sel_by_id(p_coempresa integer, p_coventadetalle integer) RETURNS TABLE(coventadetalle bigint, coempresa bigint, coventa bigint, nuorden smallint, coproducto bigint, qtarticulo numeric, ssprecioingresado numeric, ssprecio numeric, pqdescuento numeric, ssdescuento numeric, sspreciototal numeric, colocal bigint, coalmacen bigint, flestreg integer, nolocal character varying, noalmacen character varying, articulo_nomarca character varying, articulo_nomodelo character varying, articulo_noarticulo character varying)
    LANGUAGE sql
    AS $$
    SELECT 	
        d.coventadetalle,
        d.coempresa,
        d.coventa,
        d.nuorden,
        d.coproducto,
        d.qtproducto,
        d.ssprecioingresado,
        d.ssprecio,
        --d.coimpuesto,
        --d.pqimpuesto,
       -- d.ssimpuesto,
        d.pqdescuento,
        d.ssdescuento,
        d.sspreciototal,
        d.colocal,
        d.coalmacen,
        d.flestreg::int,
        l.nolocal,
        a.noalmacen,
       -- i.notipo   AS noimpuesto,
      --  i.nosigla  AS noimpuestosigla,
       -- i.novalor  AS noimpuestovalor,
       -- v.noestadoalmacen   AS articulo_noestadoalmacen,
        --v.nosegmentogrupo   AS articulo_nosegmentogrupo,
       -- v.nosegmento        AS articulo_nosegmento,
       -- v.nofamilia         AS articulo_nofamilia,
       -- v.noclase           AS articulo_noclase,
        v.nomarca           AS articulo_nomarca,
        v.nomodelo          AS articulo_nomodelo,
        v.noproducto        AS articulo_noproducto
      --  m.notipo            AS articulo_nomoneda,
      --  m.nosigla           AS articulo_nomonedasigla,
       -- v.nounidadentrada   AS articulo_nounidadentrada
    FROM facturacion.tblventadetalle d
    INNER JOIN catalogo.vw_producto v ON d.coempresa = v.coempresa AND v.coproducto = d.coproducto
    --LEFT JOIN maestro.vw_tipogeneral m ON v.comoneda = m.cotipo AND m.d = 'contabilidad.tipomoneda'
    --LEFT JOIN maestro.vw_tipoparticular i ON d.coempresa = i.coempresa AND d.coimpuesto = i.cotipo AND i.d = 'contabilidad.impuesto'
    LEFT JOIN empresa.tbllocal l ON d.coempresa = l.coempresa AND d.colocal = l.colocal
    LEFT JOIN inventario.tblalmacen a ON d.coempresa = a.coempresa AND d.coalmacen = a.coalmacen
    WHERE d.coempresa = p_coempresa AND d.coventadetalle = p_coventadetalle;
$$;


ALTER FUNCTION facturacion.fn_ventadetalle_sel_by_id(p_coempresa integer, p_coventadetalle integer) OWNER TO postgres;

--
-- Name: fn_ventadetalle_update_by_id(integer, integer, integer, integer, integer, numeric, integer, numeric, numeric, numeric, numeric, integer, integer, character varying, integer); Type: FUNCTION; Schema: facturacion; Owner: postgres
--

CREATE FUNCTION facturacion.fn_ventadetalle_update_by_id(p_coempresa integer, p_coventadetalle integer, p_coventa integer, p_coarticulo integer, p_qtarticulo integer, p_ssprecioingresado numeric, p_coimpuesto integer, p_pqimpuesto numeric, p_ssimpuesto numeric, p_pqdescuento numeric, p_ssdescuento numeric, p_colocal integer, p_coalmacen integer, p_noserie character varying, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_rows integer;
    v_qtarticulorepetido int;
    p_ssprecio numeric(14,4);
    p_sspreciototal numeric(14,4);
    v_noestadoalmacen varchar(100);
BEGIN
    -- Verificar si artículo ya existe
    SELECT COUNT(1)
    INTO v_qtarticulorepetido
    FROM facturacion.tblventadetalle
    WHERE coempresa = p_coempresa
      AND coventa = p_coventa
      AND coarticulo = p_coarticulo;

    IF v_qtarticulorepetido > 1 THEN
        RAISE EXCEPTION 'El artículo ya se ingresó.';
    END IF;

    -- Eliminar detalle anterior
    CALL facturacion.fn_ventadetalle_delete_by_id(p_coempresa, p_coventadetalle, p_cousumod, 0);

    -- Calcular descuentos e impuestos
    SELECT 
        f.ssprecio,
        f.pqimpuesto,
        f.pqdescuento,
        f.ssdescuento,
        f.ssimpuesto,
        f.sspreciototal
    INTO 
        p_ssprecio,
        p_pqimpuesto,
        p_pqdescuento,
        p_ssdescuento,
        p_ssimpuesto,
        p_sspreciototal
    FROM facturacion.fn_descuento_and_impuesto_venta(
        p_coempresa, 
        p_coventa, 
        p_ssprecioingresado, 
        p_pqdescuento, 
        p_coimpuesto, 
        p_qtarticulo
    ) f;

    -- Actualizar detalle
    UPDATE facturacion.tblventadetalle
    SET
        coarticulo       = p_coarticulo,
        qtarticulo       = p_qtarticulo,
        ssprecioingresado= p_ssprecioingresado,
        ssprecio         = p_ssprecio,
        coimpuesto       = p_coimpuesto,
        pqimpuesto       = p_pqimpuesto,
        ssimpuesto       = p_ssimpuesto,
        ssdescuento      = p_ssdescuento,
        pqdescuento      = p_pqdescuento,
        sspreciototal    = p_sspreciototal,
        colocal          = p_colocal, 
        coalmacen        = p_coalmacen,
        cousumod         = p_cousumod,
        femod            = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    WHERE coempresa = p_coempresa
      AND coventadetalle = p_coventadetalle;

    -- Recalcular totales de venta
    CALL facturacion.fn_venta_sum_all(p_coempresa, p_coventa);

    -- Validar si es inventariable
    SELECT v.noestadoalmacen
    INTO v_noestadoalmacen
    FROM inventario.vw_articulo v
    WHERE coempresa = p_coempresa
      AND coarticulo = p_coarticulo;

    IF v_noestadoalmacen = 'INVENTARIABLE' THEN
        CALL inventario.fn_inventarioventa_insert_by_ventadetalle(
            p_coempresa, 
            p_coventa, 
            p_coventadetalle,
            p_coarticulo,
            p_qtarticulo,
            p_colocal, 
            p_coalmacen
        );
    END IF;

	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION facturacion.fn_ventadetalle_update_by_id(p_coempresa integer, p_coventadetalle integer, p_coventa integer, p_coarticulo integer, p_qtarticulo integer, p_ssprecioingresado numeric, p_coimpuesto integer, p_pqimpuesto numeric, p_ssimpuesto numeric, p_pqdescuento numeric, p_ssdescuento numeric, p_colocal integer, p_coalmacen integer, p_noserie character varying, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_ventadetalle_update_state_by_id(integer, integer, integer, integer); Type: FUNCTION; Schema: facturacion; Owner: postgres
--

CREATE FUNCTION facturacion.fn_ventadetalle_update_state_by_id(p_coempresa integer, p_coventadetalle integer, p_coestreg integer, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_rows integer;
    v_coventa bigint;
BEGIN
    -- Obtener coventa
    SELECT coventa
    INTO v_coventa
    FROM facturacion.tblventadetalle
    WHERE coempresa = p_coempresa
      AND coventadetalle = p_coventadetalle;

    -- Actualizar detalle
    UPDATE facturacion.tblventadetalle
    SET coestreg = p_coestreg,
        cousumod = p_cousumod,
        femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    WHERE coempresa = p_coempresa
      AND coventadetalle = p_coventadetalle; 

    -- Recalcular totales de la venta
    CALL facturacion.fn_venta_sum_all(p_coempresa, v_coventa);
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION facturacion.fn_ventadetalle_update_state_by_id(p_coempresa integer, p_coventadetalle integer, p_coestreg integer, p_cousumod integer) OWNER TO postgres;

--
-- Name: usp_venta_sel_all(integer, integer, character varying, character varying, integer, integer, integer, character varying, integer, integer); Type: FUNCTION; Schema: facturacionrpt; Owner: postgres
--

CREATE FUNCTION facturacionrpt.usp_venta_sel_all(p_coempresa integer, p_cotipodocumento integer, p_feinicio character varying, p_fefinal character varying, p_cocliente integer, p_nunotasalida integer, p_flestreg integer, p_noinputsearch character varying, p_pagesize integer, p_pageindex integer) RETURNS TABLE(coventa bigint, coempresa bigint, colocal bigint, cotipodocumento integer, notipodocumento character varying, notipodocumentosigla character varying, nuserie character varying, nudocumento character varying, feventa date, fevencimiento date, comoneda bigint, nomoneda character varying, nomonedasigla character varying, cotipocambio integer, cocliente integer, ssprecio numeric, ssimpuesto numeric, ssdescuento numeric, nunotasalida integer, comodopago integer, comediopago integer, nomodopago character varying, nomediopago character varying, txdescripcion character varying, cliente_nopersona character varying, cliente_noapellidop character varying, cliente_noapellidom character varying, cliente_nudocumento character varying, cliente_notipodocumento character varying, cliente_notipodocumentosigla character varying, flestreg integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT
        v.coventa,
        v.coempresa,
        v.colocal,
        v.cotipodocumento,
        td.notipo       AS notipodocumento,
        td.nosigla      AS notipodocumentosigla,
        v.nuserie,
        v.nudocumento,
        v.feventa,
        v.fevencimiento,
        v.comoneda,
        m.notipo        AS nomoneda,
        m.nosigla       AS nomonedasigla,
        v.cotipocambio,
        v.cocliente,
        v.ssprecio,
        v.ssimpuesto,
        v.ssdescuento,
        v.nunotasalida,
        v.comodopago,
        v.comediopago,
        mp.notipo       AS nomodopago,
        me.notipo       AS nomediopago,
        v.txdescripcion,
        c.nopersona     AS cliente_nopersona,
        c.noapellidop   AS cliente_noapellidop,
        c.noapellidom   AS cliente_noapellidom,
        c.nudocumento   AS cliente_nudocumento,
        c.notipodocumento AS cliente_notipodocumento,
        c.notipodocumentosigla AS cliente_notipodocumentosigla,
        v.coestreg
    FROM facturacion.tblventa v
    LEFT JOIN maestros.vwpersona c ON v.coempresa = c.coempresa AND v.cocliente = c.copersona
    LEFT JOIN vw_tipogeneral td ON v.cotipodocumento = td.cotipo AND td.d = 'contabilidad.tipodocumentotributario'
    LEFT JOIN vw_tipogeneral m ON v.comoneda = m.cotipo AND m.d = 'contabilidad.tipomoneda'
    LEFT JOIN vw_tipogeneral mp ON v.comodopago = mp.cotipo AND mp.d = 'contabilidad.modopago'
    LEFT JOIN vw_tipogeneral me ON v.comediopago = me.cotipo AND me.d = 'contabilidad.mediopago'
    WHERE v.coempresa = p_coempresa
      AND (p_flestreg IS NULL OR v.flestreg = p_flestreg)
      AND (p_feinicio IS NULL OR v.feventa >= p_feinicio || '000000')
      AND (p_fefinal IS NULL OR v.feventa <= p_fefinal || '235959')
      AND (p_cotipodocumento IS NULL OR v.cotipodocumento = p_cotipodocumento)
      AND (p_noinputsearch IS NULL OR (
            v.nuserie ILIKE '%' || p_noinputsearch || '%' OR
            v.nudocumento ILIKE '%' || p_noinputsearch || '%'
          ))
      AND (p_cocliente IS NULL OR v.cocliente = p_cocliente)
      AND (p_nunotasalida IS NULL OR v.nunotasalida = p_nunotasalida)
    ORDER BY v.feventa DESC
    LIMIT p_pagesize
    OFFSET (p_pageindex - 1) * p_pagesize;
END;
$$;


ALTER FUNCTION facturacionrpt.usp_venta_sel_all(p_coempresa integer, p_cotipodocumento integer, p_feinicio character varying, p_fefinal character varying, p_cocliente integer, p_nunotasalida integer, p_flestreg integer, p_noinputsearch character varying, p_pagesize integer, p_pageindex integer) OWNER TO postgres;

--
-- Name: fn_almacen_delete_by_id(integer, integer, integer); Type: FUNCTION; Schema: inventario; Owner: postgres
--

CREATE FUNCTION inventario.fn_almacen_delete_by_id(p_coempresa integer, p_coalmacen integer, p_cousueli integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
Declare
	v_rows integer;
 v_old JSONB;
begin

	SELECT row_to_json(x) INTO v_old
    FROM inventario.tblalmacen x
    WHERE coempresa = p_coempresa And coalmacen = p_coalmacen;

    CALL seguridad.usp_auditoria(
 		p_coempresa,	-- Empresa
        'inventario',                          -- Esquema
		'tblalmacen',                  -- tabla
		'D',                        -- acción
        p_cousueli,                        -- usuario
        jsonb_build_object('coalmacen', p_coalmacen),
        v_old,
        NULL
    );

	Delete From inventario.tblalmacen where coempresa = p_coempresa and coalmacen = p_coalmacen;
 	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
end;
$$;


ALTER FUNCTION inventario.fn_almacen_delete_by_id(p_coempresa integer, p_coalmacen integer, p_cousueli integer) OWNER TO postgres;

--
-- Name: fn_almacen_insert(integer, integer, character varying, integer, integer); Type: FUNCTION; Schema: inventario; Owner: postgres
--

CREATE FUNCTION inventario.fn_almacen_insert(p_coempresa integer, p_colocal integer, p_noalmacen character varying, p_flprincipal integer, p_cousucre integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE 	
    v_coalmacen integer;
	v_qtalmacen int;
BEGIN

	select count(1) Into v_qtalmacen from inventario.tblalmacen where coempresa = p_coempresa;

	if v_qtalmacen = 0 Then		
		p_flprincipal = 1;		
	else		
		if p_flprincipal = 1 Then			
			  update inventario.tblalmacen set flprincipal = false  where coempresa = p_coempresa;
		End If;
	end if;

insert into inventario.tblalmacen (
	coempresa,	
	noalmacen,
	colocal,	
    flprincipal,
	cousucre
)
values 
(
	p_coempresa,
	p_noalmacen,
	p_colocal,
    p_flprincipal::boolean,
	p_cousucre
) 
RETURNING coalmacen INTO v_coalmacen;

	RETURN v_coalmacen;
	
END;
$$;


ALTER FUNCTION inventario.fn_almacen_insert(p_coempresa integer, p_colocal integer, p_noalmacen character varying, p_flprincipal integer, p_cousucre integer) OWNER TO postgres;

--
-- Name: fn_almacen_sel_all(integer); Type: FUNCTION; Schema: inventario; Owner: postgres
--

CREATE FUNCTION inventario.fn_almacen_sel_all(p_coempresa integer) RETURNS TABLE(coalmacen bigint, noalmacen character varying, coempresa bigint, colocal bigint, nolocal character varying, flprincipal integer, flestreg integer)
    LANGUAGE plpgsql
    AS $$
Begin
Return query
    SELECT 	
        a.coalmacen,
        a.noalmacen,
        a.coempresa,
        a.colocal,
        l.nolocal,	
        a.flprincipal::int,
        a.flestreg::int
    FROM inventario.tblalmacen a
    Inner JOIN empresa.tbllocal l ON a.coempresa = l.coempresa AND a.colocal = l.colocal
    WHERE a.coempresa = p_coempresa;
    -- AND a.colocal = p_colocal; -- <- lo puedes habilitar si agregas ese parámetro
End;
$$;


ALTER FUNCTION inventario.fn_almacen_sel_all(p_coempresa integer) OWNER TO postgres;

--
-- Name: fn_almacen_sel_all_active(integer); Type: FUNCTION; Schema: inventario; Owner: postgres
--

CREATE FUNCTION inventario.fn_almacen_sel_all_active(p_coempresa integer) RETURNS TABLE(coalmacen bigint, noalmacen character varying, coempresa bigint, colocal bigint, flprincipal integer, nolocal character varying)
    LANGUAGE plpgsql
    AS $$
Begin 
Return Query
    SELECT 	
        a.coalmacen,
        a.noalmacen,
        a.coempresa,
        a.colocal,
        a.flprincipal::int,
        l.nolocal
        -- (l.nolocal || ' - ' || a.noalmacen) AS nolocalandalmacen -- alternativa en PostgreSQL
    FROM inventario.tblalmacen a
    Inner JOIN empresa.tbllocal l ON a.coempresa = l.coempresa AND a.colocal = l.colocal AND l.flestreg = true
    WHERE a.coempresa = p_coempresa AND a.flestreg = true;
End;
$$;


ALTER FUNCTION inventario.fn_almacen_sel_all_active(p_coempresa integer) OWNER TO postgres;

--
-- Name: fn_almacen_sel_all_active_by_local(integer, integer); Type: FUNCTION; Schema: inventario; Owner: postgres
--

CREATE FUNCTION inventario.fn_almacen_sel_all_active_by_local(p_coempresa integer, p_colocal integer) RETURNS TABLE(coalmacen bigint, noalmacen character varying, coempresa bigint, colocal bigint, flprincipal integer, nolocal character varying)
    LANGUAGE sql
    AS $$
 SELECT 	
        a.coalmacen,
        a.noalmacen,
        a.coempresa,
        a.colocal,
        a.flprincipal::int,
        l.nolocal
    FROM inventario.tblalmacen a
    Inner JOIN empresa.tbllocal l ON a.coempresa = l.coempresa AND a.colocal = l.colocal AND l.flestreg = true
    WHERE a.coempresa = p_coempresa 
      AND a.flestreg = true 
      AND a.colocal = p_colocal;
$$;


ALTER FUNCTION inventario.fn_almacen_sel_all_active_by_local(p_coempresa integer, p_colocal integer) OWNER TO postgres;

--
-- Name: fn_almacen_sel_by_id(integer, integer); Type: FUNCTION; Schema: inventario; Owner: postgres
--

CREATE FUNCTION inventario.fn_almacen_sel_by_id(p_coempresa integer, p_coalmacen integer) RETURNS TABLE(coalmacen bigint, noalmacen character varying, coempresa bigint, colocal bigint, flprincipal integer, flestreg integer, nolocal character varying)
    LANGUAGE sql
    AS $$
    SELECT 	
        a.coalmacen,
        a.noalmacen,
        a.coempresa,
        a.colocal,
        a.flprincipal::int,
        a.flestreg::int,
        l.nolocal
    FROM inventario.tblalmacen a
    JOIN empresa.tbllocal l ON a.coempresa = l.coempresa AND a.colocal = l.colocal
    WHERE a.coempresa = p_coempresa
      AND a.coalmacen = p_coalmacen;
$$;


ALTER FUNCTION inventario.fn_almacen_sel_by_id(p_coempresa integer, p_coalmacen integer) OWNER TO postgres;

--
-- Name: fn_almacen_update_by_id(integer, integer, integer, character varying, integer, integer); Type: FUNCTION; Schema: inventario; Owner: postgres
--

CREATE FUNCTION inventario.fn_almacen_update_by_id(p_coempresa integer, p_colocal integer, p_coalmacen integer, p_noalmacen character varying, p_flprincipal integer, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_rows integer;
    v_qtalmacen int;
BEGIN
    -- contar almacenes activos
    SELECT COUNT(1)
    INTO v_qtalmacen
    FROM inventario.tblalmacen
    WHERE coempresa = p_coempresa;

    -- si no hay almacenes, este será principal
    IF v_qtalmacen = 0 THEN
        p_flprincipal := 1;
    ELSE
        -- si se indica como principal, desmarcar los demás
        IF p_flprincipal = 1 THEN
            UPDATE inventario.tblalmacen
            SET flprincipal = false
            WHERE coempresa = p_coempresa;
        END IF;
    END IF;

    -- actualizar el almacén
    UPDATE inventario.tblalmacen
    SET
        colocal     = p_colocal,
        noalmacen   = p_noalmacen,
        cousumod    = p_cousumod,
        flprincipal = p_flprincipal::boolean,
        femod       = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    WHERE coempresa = p_coempresa
      AND coalmacen = p_coalmacen;

	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION inventario.fn_almacen_update_by_id(p_coempresa integer, p_colocal integer, p_coalmacen integer, p_noalmacen character varying, p_flprincipal integer, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_almacen_update_state_by_id(integer, integer, integer, integer); Type: FUNCTION; Schema: inventario; Owner: postgres
--

CREATE FUNCTION inventario.fn_almacen_update_state_by_id(p_coempresa integer, p_coalmacen integer, p_flestreg integer, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_rows integer;
BEGIN
    UPDATE inventario.tblalmacen
    SET flestreg = p_flestreg::boolean,
        cousumod = p_cousumod,
        femod    = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    WHERE coempresa = p_coempresa
      AND coalmacen = p_coalmacen;
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION inventario.fn_almacen_update_state_by_id(p_coempresa integer, p_coalmacen integer, p_flestreg integer, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_inventario_insert(integer, integer, integer, integer, integer, integer, integer, integer, integer); Type: FUNCTION; Schema: inventario; Owner: postgres
--

CREATE FUNCTION inventario.fn_inventario_insert(p_coempresa integer, p_coreferencia integer, p_coproducto integer, p_qtunidad integer, p_coalmacen integer, p_cooperacion integer, p_cotiporeferencia integer, p_colocal integer, p_cousucre integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE 	
    v_coinventario integer;
	v_qtunidadsalida int;
	v_qtunidadentrada int;
BEGIN
  

	INSERT INTO inventario.tblinventario(
		coempresa,	
		coreferencia,
		coproducto,
		qtunidad,
		coalmacen,
		cooperacion,
		cotiporeferencia,
		colocal)
	VALUES (
		p_coempresa,	
		p_coreferencia,
		p_coproducto,
		p_qtunidad,
		p_coalmacen,
		p_cooperacion,
		p_cotiporeferencia,
		p_colocal
	)
	RETURNING coinventario INTO v_coinventario;

	RETURN v_coinventario;
	
END;
$$;


ALTER FUNCTION inventario.fn_inventario_insert(p_coempresa integer, p_coreferencia integer, p_coproducto integer, p_qtunidad integer, p_coalmacen integer, p_cooperacion integer, p_cotiporeferencia integer, p_colocal integer, p_cousucre integer) OWNER TO postgres;

--
-- Name: fn_inventario_kardex(integer); Type: FUNCTION; Schema: inventario; Owner: postgres
--

CREATE FUNCTION inventario.fn_inventario_kardex(p_coempresa integer) RETURNS TABLE(coempresa bigint, coinventario bigint, cotiporeferencia integer, coreferencia integer, coproducto bigint, qtunidad integer, coalmacen bigint, cooperacion integer, noproducto character varying, nolocal character varying, noalmacen character varying, nooperacion character varying, noreferencia character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
 SELECT 
	inventario.coempresa,
	inventario.coinventario,
	inventario.cotiporeferencia,
	inventario.coreferencia,
	inventario.coproducto,
	inventario.qtunidad,
	inventario.coalmacen,
	inventario.cooperacion,
	p.noproducto,
	loc.nolocal,
	almacen.noalmacen,
	operacion.notipo AS nooperacion, 
	referencia.notipo AS noreferencia
FROM inventario.tblinventario inventario
INNER JOIN producto.tblproducto p ON inventario.coempresa = p.coempresa AND inventario.coproducto = p.coproducto
INNER JOIN empresa.tbllocal loc ON inventario.coempresa = loc.coempresa AND inventario.colocal = loc.colocal
INNER JOIN inventario.tblalmacen almacen ON inventario.coempresa = almacen.coempresa AND inventario.coalmacen = almacen.coalmacen
INNER JOIN facturacion.tblcompradetalle compradetalle ON compradetalle.cocompradetalle = inventario.coreferencia AND inventario.cotiporeferencia = 1
INNER JOIN facturacion.tblventadetalle ventadetalle ON ventadetalle.coventadetalle = inventario.coreferencia AND inventario.cotiporeferencia = 2
INNER JOIN maestro.vw_tipogeneral referencia ON referencia.cotipo = inventario.coreferencia AND referencia.cogrupo = 36
INNER JOIN maestro.vw_tipogeneral operacion ON operacion.cotipo = inventario.cooperacion AND operacion.cogrupo = 19
WHERE inventario.coempresa = p_coempresa;
END;
$$;


ALTER FUNCTION inventario.fn_inventario_kardex(p_coempresa integer) OWNER TO postgres;

--
-- Name: fn_inventario_sel_by_id(integer, integer); Type: FUNCTION; Schema: inventario; Owner: postgres
--

CREATE FUNCTION inventario.fn_inventario_sel_by_id(p_coempresa integer, p_coinventario integer) RETURNS TABLE(coempresa bigint, coinventario bigint, coreferencia bigint, coproducto bigint, qtunidad integer, coalmacen bigint, cooperacion bigint, cotiporeferencia integer, colocal bigint)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT
       coempresa, 
	   coinventario,
	   coreferencia,
	   coproducto, 
	   qtunidad,
	   coalmacen,	   
	   cooperacion,
	   cotiporeferencia,
	   colocal
    FROM inventario.tblinventario
    WHERE coempresa = p_coempresa
      AND coinventario = p_coinventario;
END;
$$;


ALTER FUNCTION inventario.fn_inventario_sel_by_id(p_coempresa integer, p_coinventario integer) OWNER TO postgres;

--
-- Name: fn_inventario_tiene_venta(integer, integer); Type: FUNCTION; Schema: inventario; Owner: postgres
--

CREATE FUNCTION inventario.fn_inventario_tiene_venta(p_coempresa integer, p_cocompradetalle integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_qtventa INT;
BEGIN

 SELECT COUNT(1)
 INTO v_qtventa
FROM inventario.tblinventario inventario
INNER JOIN facturacion.tblcompradetalle compradetalle ON compradetalle.cocompradetalle = inventario.coreferencia AND inventario.cotiporeferencia = 1
INNER JOIN facturacion.tblventadetalle ventadetalle ON ventadetalle.coventadetalle = inventario.coreferencia AND inventario.cotiporeferencia = 2
WHERE inventario.coempresa = p_coempresa
  AND compradetalle.cocompradetalle = p_cocompradetalle;

   

    RETURN v_qtventa;
END;
$$;


ALTER FUNCTION inventario.fn_inventario_tiene_venta(p_coempresa integer, p_cocompradetalle integer) OWNER TO postgres;

--
-- Name: fn_inventario_update_by_id(integer, integer); Type: FUNCTION; Schema: inventario; Owner: postgres
--

CREATE FUNCTION inventario.fn_inventario_update_by_id(p_coempresa integer, p_coinventario integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE
	v_rows integer;
BEGIN
    UPDATE inventario.tblinventario
    SET fecre = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    WHERE coempresa = p_coempresa
      AND coinventario = p_coinventario;
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION inventario.fn_inventario_update_by_id(p_coempresa integer, p_coinventario integer) OWNER TO postgres;

--
-- Name: fn_empresa_sel_all(); Type: FUNCTION; Schema: login; Owner: postgres
--

CREATE FUNCTION login.fn_empresa_sel_all() RETURNS TABLE(coempresa bigint, noentidad character varying, coentidad bigint)
    LANGUAGE plpgsql
    AS $$
begin
    return query
   	SELECT 
	   	e.coempresa, -- ← splitOn
		en.noentidad,
		en.coentidad
    FROM seguridad.vw_empresa e
    WHERE e.flestreg = true;
end;
$$;


ALTER FUNCTION login.fn_empresa_sel_all() OWNER TO postgres;

--
-- Name: fn_empresa_sel_by_id(bigint); Type: FUNCTION; Schema: login; Owner: postgres
--

CREATE FUNCTION login.fn_empresa_sel_by_id(p_coempresa bigint) RETURNS TABLE(novision character varying, nomision character varying, txquiensoy character varying, coempresa bigint, noentidad character varying, coentidad bigint)
    LANGUAGE plpgsql
    AS $$
begin
    return query
   	SELECT
		e.novision,
		e.nomision,
		e.txquiensoy,		
		e.coempresa, 
		en.noentidad, 
		en.coentidad
    FROM seguridad.vw_empresa e		
    WHERE e.flestreg = true
      AND e.coempresa = p_coempresa;
end;
$$;


ALTER FUNCTION login.fn_empresa_sel_by_id(p_coempresa bigint) OWNER TO postgres;

--
-- Name: fn_ingreso_insert(bigint, character varying, character varying, character varying, timestamp with time zone); Type: FUNCTION; Schema: login; Owner: postgres
--

CREATE FUNCTION login.fn_ingreso_insert(p_cousuario bigint, p_noip character varying, p_norefreshtoken character varying, p_nouseragent character varying, p_ferefreshtokenexpire timestamp with time zone) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
DECLARE v_coingreso bigint;
begin
	/*
	1	=>	"Activo"	=>	115
	2	=>	"Revocado" => 116
	3	=>	"Expirado" => 117
	4	=>	"Reemplazado" => 118
	*/
    insert into seguridad.tblingreso (cousuario, noip, norefreshtoken, ferefreshtokenexpire, nouseragent, coestado)
    values (p_cousuario, p_noip, p_norefreshtoken, p_ferefreshtokenexpire, p_nouseragent, 115)
	RETURNING coingreso INTO v_coingreso;
	RETURN v_coingreso;
END;
$$;


ALTER FUNCTION login.fn_ingreso_insert(p_cousuario bigint, p_noip character varying, p_norefreshtoken character varying, p_nouseragent character varying, p_ferefreshtokenexpire timestamp with time zone) OWNER TO postgres;

--
-- Name: fn_ingreso_replace(character varying); Type: FUNCTION; Schema: login; Owner: postgres
--

CREATE FUNCTION login.fn_ingreso_replace(p_norefreshtoken character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_rows integer;
BEGIN
	/*
	1	=>	"Activo"	=>	115
	2	=>	"Revocado" => 116
	3	=>	"Expirado" => 117
	4	=>	"Reemplazado" => 118
	*/
    UPDATE seguridad.tblingreso SET fesalida = CURRENT_TIMESTAMP, coestado = 118
     WHERE norefreshtoken = p_norefreshtoken AND coestado = 115;
	GET DIAGNOSTICS v_rows = ROW_COUNT;
    RETURN v_rows;
END;
$$;


ALTER FUNCTION login.fn_ingreso_replace(p_norefreshtoken character varying) OWNER TO postgres;

--
-- Name: fn_ingreso_revoke(character varying); Type: FUNCTION; Schema: login; Owner: postgres
--

CREATE FUNCTION login.fn_ingreso_revoke(p_norefreshtoken character varying) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_rows integer;
BEGIN
	/*
	1	=>	"Activo"	=>	115
	2	=>	"Revocado" => 116
	3	=>	"Expirado" => 117
	4	=>	"Reemplazado" => 118
	*/
	
    UPDATE seguridad.tblingreso SET fesalida = CURRENT_TIMESTAMP, coestado = 116, norefreshtokenprevious = norefreshtoken
     WHERE norefreshtoken = p_norefreshtoken AND coestado = 115;
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION login.fn_ingreso_revoke(p_norefreshtoken character varying) OWNER TO postgres;

--
-- Name: fn_ingreso_revoke_all(bigint); Type: FUNCTION; Schema: login; Owner: postgres
--

CREATE FUNCTION login.fn_ingreso_revoke_all(p_cousuario bigint) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_rows integer;
BEGIN
	/*
	1	=>	"Activo"	=>	115
	2	=>	"Revocado" => 116
	3	=>	"Expirado" => 117
	4	=>	"Reemplazado" => 118
	*/
	
    UPDATE seguridad.tblingreso SET coestado = 116, fesalida = CURRENT_TIMESTAMP
     WHERE cousuario = p_cousuario AND coestado = 115;
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION login.fn_ingreso_revoke_all(p_cousuario bigint) OWNER TO postgres;

--
-- Name: fn_ingreso_sel_by_refreshtoken(character varying); Type: FUNCTION; Schema: login; Owner: postgres
--

CREATE FUNCTION login.fn_ingreso_sel_by_refreshtoken(p_norefreshtoken character varying) RETURNS TABLE(cousuario bigint, coingreso bigint, nouseragent character varying)
    LANGUAGE plpgsql
    AS $$
begin
	/*
	1	=>	"Activo"	=>	115
	2	=>	"Revocado" => 116
	3	=>	"Expirado" => 117
	4	=>	"Reemplazado" => 118
	*/
    return query
    select ing.cousuario, ing.coingreso, ing.nouseragent
    FROM seguridad.tblingreso ing
    WHERE ing.coestado = 115 AND ing.norefreshtoken = p_norefreshtoken AND ing.fesalida IS NULL AND ing.ferefreshtokenexpire > CURRENT_TIMESTAMP;
end;
$$;


ALTER FUNCTION login.fn_ingreso_sel_by_refreshtoken(p_norefreshtoken character varying) OWNER TO postgres;

--
-- Name: fn_menu_sel_all(bigint, bigint, bigint); Type: FUNCTION; Schema: login; Owner: postgres
--

CREATE FUNCTION login.fn_menu_sel_all(p_coempresa bigint, p_comodulo bigint, p_cousuario bigint) RETURNS TABLE(comenu bigint, nuorden integer, nomenu text, comodulo bigint)
    LANGUAGE plpgsql
    AS $$
begin
    return query
     SELECT DISTINCT segmenu.comenu, segmenu.nuorden::integer, segmenu.nomenu::text, perfilpagina.comodulo
    FROM seguridad.segperfilpagina perfilpagina
         INNER JOIN seguridad.segmenu ON perfilpagina.comenu = segmenu.comenu
             AND perfilpagina.comodulo = segmenu.comodulo AND segmenu.flestreg = true
         INNER JOIN seguridad.segperfil
              ON segperfil.coperfil = perfilpagina.coperfil
             AND segperfil.comodulo = perfilpagina.comodulo AND segperfil.flestreg = true
         INNER JOIN seguridad.segmodulousuario mu
              ON mu.comodulo = perfilpagina.comodulo AND perfilpagina.coperfil = mu.coperfil
         INNER JOIN seguridad.tblusuario u
              ON u.cousuario = mu.cousuario AND u.flestreg = true
         INNER JOIN seguridad.segpagina
              ON segpagina.copagina = perfilpagina.copagina
             AND segpagina.comodulo = perfilpagina.comodulo AND segpagina.flestreg = true
    where mu.coempresa = p_coempresa
      and perfilpagina.comodulo = p_comodulo
      and mu.cousuario = p_cousuario;
END;
$$;


ALTER FUNCTION login.fn_menu_sel_all(p_coempresa bigint, p_comodulo bigint, p_cousuario bigint) OWNER TO postgres;

--
-- Name: fn_modulo_sel_all(); Type: FUNCTION; Schema: login; Owner: postgres
--

CREATE FUNCTION login.fn_modulo_sel_all() RETURNS TABLE(nuorden smallint, comodulo bigint)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT segmodulo.nuorden, segmodulo.comodulo
    FROM seguridad.segmodulo WHERE segmodulo.flestreg = true;
END;
$$;


ALTER FUNCTION login.fn_modulo_sel_all() OWNER TO postgres;

--
-- Name: fn_modulo_sel_by_id(bigint); Type: FUNCTION; Schema: login; Owner: postgres
--

CREATE FUNCTION login.fn_modulo_sel_by_id(p_comodulo bigint) RETURNS TABLE(comodulo bigint, nomodulo character varying, nomodulodescripcion character varying, noarea character varying, noicono character varying, nuorden smallint, flarea integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
		segmodulo.comodulo,
		segmodulo.nomodulo,
		segmodulo.nomodulodescripcion,
		segmodulo.noarea,
		segmodulo.noicono,
		segmodulo.nuorden,
		segmodulo.flarea::int
    FROM seguridad.segmodulo WHERE segmodulo.comodulo = p_comodulo;
END;
$$;


ALTER FUNCTION login.fn_modulo_sel_by_id(p_comodulo bigint) OWNER TO postgres;

--
-- Name: fn_modulousuario_sel_all_by_usuario(bigint, bigint); Type: FUNCTION; Schema: login; Owner: postgres
--

CREATE FUNCTION login.fn_modulousuario_sel_all_by_usuario(p_coempresa bigint, p_cousuario bigint) RETURNS TABLE(comodulo bigint, coperfil bigint, nuorden smallint, nomodulo character varying, noicono character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
		DISTINCT 
		modulousuario.comodulo,
		modulousuario.coperfil,
		modulo.nuorden,
		modulo.nomodulo, 
		modulo.noicono
    FROM seguridad.segmodulousuario modulousuario
    Inner JOIN seguridad.segmodulo modulo ON modulousuario.comodulo = modulo.comodulo AND modulo.flestreg = true
    Inner JOIN seguridad.tblusuario usuario ON usuario.cousuario = modulousuario.cousuario AND usuario.flestreg = true
    WHERE modulousuario.coempresa = p_coempresa
      AND modulousuario.cousuario = p_cousuario
	AND (modulousuario.feexpiracion IS NULL OR modulousuario.feexpiracion >= CURRENT_DATE);
END;
$$;


ALTER FUNCTION login.fn_modulousuario_sel_all_by_usuario(p_coempresa bigint, p_cousuario bigint) OWNER TO postgres;

--
-- Name: fn_modulousuario_sel_by_id(bigint); Type: FUNCTION; Schema: login; Owner: postgres
--

CREATE FUNCTION login.fn_modulousuario_sel_by_id(p_comodulousuario bigint) RETURNS TABLE(coempresa bigint, comodulousuario bigint, cousuario bigint, comodulo bigint, coperfil bigint, feexpiracion date, nomodulo character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
		su.coempresa,
		su.comodulousuario,
		su.cousuario, 
		su.comodulo,
        su.coperfil,
		su.feexpiracion,
		mo.nomodulo
    FROM seguridad.segmodulousuario su
    Inner JOIN seguridad.segmodulo mo ON su.comodulo = mo.comodulo
    WHERE su.comodulousuario = p_comodulousuario;
END;
$$;


ALTER FUNCTION login.fn_modulousuario_sel_by_id(p_comodulousuario bigint) OWNER TO postgres;

--
-- Name: fn_modulousuario_sel_by_modulo(bigint, bigint); Type: FUNCTION; Schema: login; Owner: postgres
--

CREATE FUNCTION login.fn_modulousuario_sel_by_modulo(p_comodulo bigint, p_cousuario bigint) RETURNS TABLE(coempresa bigint, comodulousuario bigint, cousuario bigint, comodulo bigint, coperfil bigint, feexpiracion date, nomodulo character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
		su.coempresa,
		su.comodulousuario,
		su.cousuario, 
		su.comodulo,
		su.coperfil,
		su.feexpiracion,
		sm.nomodulo
    FROM seguridad.segmodulousuario su
    INNER JOIN seguridad.segmodulo sm ON su.comodulo = sm.comodulo
    WHERE su.cousuario = p_cousuario AND su.comodulo = p_comodulo;
END;
$$;


ALTER FUNCTION login.fn_modulousuario_sel_by_modulo(p_comodulo bigint, p_cousuario bigint) OWNER TO postgres;

--
-- Name: fn_pagina_sel_all(bigint, bigint, bigint); Type: FUNCTION; Schema: login; Owner: postgres
--

CREATE FUNCTION login.fn_pagina_sel_all(p_coempresa bigint, p_comodulo bigint, p_cousuario bigint) RETURNS TABLE(comenu bigint, nocontrolador character varying, noaccion character varying, coarea bigint, noarea character varying, noopcion character varying, nuorden smallint, copagina bigint, cotipopagina bigint)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
SELECT DISTINCT
           spp.comenu, 
		   sp.coarea,
		   sp.copagina,
		   sp.cotipopagina,
		   sp.nuorden,
		   sp.nocontrolador, 
		   sp.noaccion, 		   
		   sm_area.noarea,
		   sp.noopcion
    FROM seguridad.segperfilpagina spp
    INNER JOIN seguridad.segpagina sp ON spp.copagina = sp.copagina AND spp.comodulo = sp.comodulo AND sp.flestreg = true
    INNER JOIN seguridad.segmodulo sm ON sm.comodulo = spp.comodulo AND sp.cotipopagina = 150
    INNER JOIN seguridad.segperfil sper ON sper.coperfil = spp.coperfil AND sper.comodulo = spp.comodulo AND sper.flestreg = true
    INNER JOIN seguridad.segmodulousuario smu ON smu.comodulo = spp.comodulo AND spp.coperfil = smu.coperfil
    INNER JOIN seguridad.tblusuario tp ON tp.cousuario = smu.cousuario AND tp.flestreg = true
    INNER JOIN seguridad.segmodulo sm_area ON sp.coarea = sm_area.comodulo
    WHERE smu.coempresa = p_coempresa
      AND spp.comodulo = p_comodulo
      AND tp.cousuario = p_cousuario;
END;
$$;


ALTER FUNCTION login.fn_pagina_sel_all(p_coempresa bigint, p_comodulo bigint, p_cousuario bigint) OWNER TO postgres;

--
-- Name: fn_perfilpagina_sel_all_by_modulo_and_perfil(bigint, bigint); Type: FUNCTION; Schema: login; Owner: postgres
--

CREATE FUNCTION login.fn_perfilpagina_sel_all_by_modulo_and_perfil(p_comodulo bigint, p_coperfil bigint) RETURNS TABLE(comodulo bigint, comenu bigint, copagina bigint, nuorden smallint, nomenu character varying, cotipopagina bigint, noarea character varying, nocontrolador character varying, noaccion character varying, noopcion character varying)
    LANGUAGE plpgsql
    AS $$
begin
    return query
    -- MENUS
    SELECT 
		menu.comodulo, 
		menu.comenu, 
		null::bigint as copagina, 
		menu.nuorden, 
		menu.nomenu, 
		9::bigint as cotipopagina,
        null::character varying as noarea,
		null::character varying as nocontrolador, 
		null::character varying as noaccion, 
		null::character varying as noopcion
    FROM seguridad.segmenu menu
    WHERE menu.flestreg = true
      AND menu.comenu in (
            SELECT perfilpagina.comenu
            FROM seguridad.segperfilpagina perfilpagina
            INNER JOIN seguridad.segperfil perfil on perfil.comodulo = perfilpagina.comodulo and perfil.coperfil = perfilpagina.coperfil
            WHERE perfil.flestreg = true 
				AND perfilpagina.comodulo = p_comodulo 
				AND perfilpagina.coperfil = p_coperfil
      )
    union
    -- PAGINAS TIPO 1
    select 
		modulo.comodulo, 
		pagina.comenu, 
		pagina.copagina, 
		pagina.nuorden, 
		null::character varying as nomenu, 
		pagina.cotipopagina,
        modulo.noarea, 
		pagina.nocontrolador, 
		pagina.noaccion, 
		pagina.noopcion
    from seguridad.segpagina pagina
    join seguridad.segmodulo modulo On modulo.comodulo = pagina.coarea And modulo.flestreg = true
    where pagina.flestreg = true and pagina.cotipopagina = 150
      and pagina.copagina in (
            select perfilpagina.copagina
            from seguridad.segperfilpagina perfilpagina
            join seguridad.segperfil perfil on perfil.comodulo = perfilpagina.comodulo and perfil.coperfil = perfilpagina.coperfil
            where perfil.flestreg = true and perfilpagina.comodulo = p_comodulo and perfilpagina.coperfil = p_coperfil
      )
    union
    -- PAGINAS TIPO 2 y 3
   select 
   		modulo.comodulo, 
		pagina.comenu, 
		pagina.copagina, 
		pagina.nuorden, 
		null::character varying as nomenu, 
		pagina.cotipopagina,
        modulo.noarea, 
		pagina.nocontrolador, 
		pagina.noaccion, 
		pagina.noopcion
    from seguridad.segpagina pagina
    join seguridad.segmodulo modulo on modulo.comodulo = pagina.coarea and modulo.flestreg = true
    where pagina.flestreg = true and pagina.cotipopagina in (151,152)
      and pagina.copagina in (
            select perfilpagina.copagina
            from seguridad.segperfilpagina perfilpagina
            join seguridad.segperfil perfil on perfil.comodulo = perfilpagina.comodulo and perfil.coperfil = perfilpagina.coperfil
            where perfil.flestreg = true and perfilpagina.comodulo = p_comodulo and perfilpagina.coperfil = p_coperfil
      );
end;
$$;


ALTER FUNCTION login.fn_perfilpagina_sel_all_by_modulo_and_perfil(p_comodulo bigint, p_coperfil bigint) OWNER TO postgres;

--
-- Name: fn_usuario_sel_by_empresa(bigint, bigint); Type: FUNCTION; Schema: login; Owner: postgres
--

CREATE FUNCTION login.fn_usuario_sel_by_empresa(p_coempresa bigint, p_cousuario bigint) RETURNS TABLE(cousuario bigint, coentidad bigint, nousuario character varying, noentidad character varying, flsuperadmin integer)
    LANGUAGE plpgsql
    AS $$
begin
    return query
		SELECT 
			u.cousuario,
			u.coentidad, 
			u.nousuario,
			--e.coempresa,
			u.noentidad,
			u.flsuperadmin::int
		FROM seguridad.vw_usuario u
		INNER JOIN seguridad.vw_empresa e ON e.coempresa = u.coempresa AND e.flestreg = true
		WHERE u.flestreg = true 
			AND u.cousuario = p_cousuario 
			AND e.coempresa = p_coempresa;
end;
$$;


ALTER FUNCTION login.fn_usuario_sel_by_empresa(p_coempresa bigint, p_cousuario bigint) OWNER TO postgres;

--
-- Name: fn_usuario_sel_by_id(bigint); Type: FUNCTION; Schema: login; Owner: postgres
--

CREATE FUNCTION login.fn_usuario_sel_by_id(p_cousuario bigint) RETURNS TABLE(coentidad bigint, cousuario bigint, nousuario character varying, noentidad character varying, flsuperadmin integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN QUERY
   	SELECT 
	   	   u.coentidad, 
		   u.cousuario, 
		   u.nousuario, 
		   u.noentidad,
		   u.flsuperadmin::int
    FROM seguridad.vw_usuario u
     WHERE u.flestreg = true AND u.cousuario = p_cousuario;
End;
$$;


ALTER FUNCTION login.fn_usuario_sel_by_id(p_cousuario bigint) OWNER TO postgres;

--
-- Name: fn_usuario_sel_by_user(character varying); Type: FUNCTION; Schema: login; Owner: postgres
--

CREATE FUNCTION login.fn_usuario_sel_by_user(p_nousuario character varying) RETURNS TABLE(coentidad bigint, cousuario bigint, nousuario character varying, noclave character varying, noentidad character varying, flsuperadmin integer, empresalstjson text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
   SELECT   
		u.coentidad,
        u.cousuario,
        u.nousuario,
		u.noclave,
		u.noentidad,
		u.flsuperadmin::int,
		jsonb_agg(
	        jsonb_build_object(
		            'coempresa', e.coempresa,
		            'norazonsocial', e.norazonsocial
	        	)
        	ORDER BY u.noentidad
    	)::text AS empresalstjson
    FROM seguridad.vw_usuario u	
		INNER JOIN seguridad.vw_empresa e ON e.coempresa = u.coempresa AND e.flestreg = true		
     WHERE u.flestreg = true      
       AND u.nousuario = p_nousuario
	  GROUP BY
	  	u.coentidad,
	    u.cousuario,
	    u.nousuario,
		u.noclave,
	    u.noentidad,
		u.flsuperadmin::int
	;

END;
$$;


ALTER FUNCTION login.fn_usuario_sel_by_user(p_nousuario character varying) OWNER TO postgres;

--
-- Name: fn_archivo_delete_by_id(bigint, bigint, integer); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_archivo_delete_by_id(p_coempresa bigint, p_coarchivo bigint, p_cousueli integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
Declare v_rows integer; v_old JSONB;
begin
SELECT row_to_json(x) INTO v_old FROM maestro.tblarchivo x WHERE coempresa = p_coempresa And coarchivo = p_coarchivo;
CALL seguridad.usp_auditoria(p_coempresa, 'maestro', 'tblarchivo', 'D', p_cousueli, jsonb_build_object('coarchivo', p_coarchivo), v_old, NULL);
Delete From maestro.tblarchivo where coempresa = p_coempresa and coarchivo = p_coarchivo;
GET DIAGNOSTICS v_rows = ROW_COUNT;
RETURN v_rows;
end;
$$;


ALTER FUNCTION maestro.fn_archivo_delete_by_id(p_coempresa bigint, p_coarchivo bigint, p_cousueli integer) OWNER TO postgres;

--
-- Name: fn_archivo_insert(bigint, integer, bigint, integer, integer, character varying, character varying, character varying, integer, integer, integer, integer); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_archivo_insert(p_coempresa bigint, p_cotipoentidad integer, p_coentidad bigint, p_cotipo integer, p_flgaleria integer, p_noarchivo character varying, p_noextension character varying, p_noruta character varying, p_nubytes integer, p_nualto integer, p_nuancho integer, p_cousucre integer) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
DECLARE v_coarchivo bigint; v_nuorden int;
BEGIN

	if p_flgaleria = 1 then
	    select COALESCE(max(nuorden), 0) + 1 into v_nuorden from maestro.tblarchivo
	    where coempresa = p_coempresa 
		and cotipoentidad = p_cotipoentidad 
		and coentidad = p_coentidad 
		and cotipo = p_cotipo;
	else 
		v_nuorden := 1;
	end if;
	
	insert into maestro.tblarchivo 
		(
			coempresa, 
			cotipoentidad,
			coentidad, 
			cotipo,
			nuorden,
			noarchivo, 
			noextension,
			noruta,
			nubytes,
			nualto,
			nuancho,
			cousucre
		)
		values (
			p_coempresa,
			p_cotipoentidad,
			p_coentidad,
			p_cotipo,
			v_nuorden,
			p_noarchivo,
			p_noextension,
			p_noruta,
			p_nubytes,
			p_nualto,
			p_nuancho,
			p_cousucre
		)
	RETURNING coarchivo INTO v_coarchivo;
	
	RETURN v_coarchivo;
END;
$$;


ALTER FUNCTION maestro.fn_archivo_insert(p_coempresa bigint, p_cotipoentidad integer, p_coentidad bigint, p_cotipo integer, p_flgaleria integer, p_noarchivo character varying, p_noextension character varying, p_noruta character varying, p_nubytes integer, p_nualto integer, p_nuancho integer, p_cousucre integer) OWNER TO postgres;

--
-- Name: fn_archivo_sel_all(bigint, integer, bigint); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_archivo_sel_all(p_coempresa bigint, p_cotipoentidad integer, p_coentidad bigint) RETURNS TABLE(coarchivo bigint, cotipoentidad integer, coentidad bigint, cotipo integer, noarchivo character varying, noextension character varying, noruta character varying, nubytes numeric, nualto numeric, nuancho numeric, nuorden smallint, txdescripcion character varying, fldefault integer, notitulo character varying, flestreg integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
		a.coarchivo,
		a.cotipoentidad,
		a.coentidad,
		a.cotipo,
		a.noarchivo,
		a.noextension, 
		a.noruta,
		a.nubytes,
		a.nualto,
		a.nuancho,
		a.nuorden,
		a.txdescripcion,
		a.fldefault::int,
		a.notitulo,
		a.flestreg::int
    FROM maestro.tblarchivo a
    WHERE a.coempresa = p_coempresa 
		AND a.cotipoentidad = p_cotipoentidad 
		AND a.coentidad = p_coentidad;
END;
$$;


ALTER FUNCTION maestro.fn_archivo_sel_all(p_coempresa bigint, p_cotipoentidad integer, p_coentidad bigint) OWNER TO postgres;

--
-- Name: fn_archivo_sel_all_active(bigint, integer, bigint); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_archivo_sel_all_active(p_coempresa bigint, p_cotipoentidad integer, p_coentidad bigint) RETURNS TABLE(coarchivo bigint, nuorden smallint, txdescripcion character varying, fldefault integer, notitulo character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
		a.coarchivo, 
		a.nuorden,
		a.txdescripcion, 
		a.fldefault::int,
		a.notitulo
    FROM maestro.tblarchivo a
    WHERE a.coempresa = p_coempresa 
		AND a.flestreg = true 
		AND a.cotipoentidad = p_cotipoentidad 
		AND a.coentidad = p_coentidad;
END;
$$;


ALTER FUNCTION maestro.fn_archivo_sel_all_active(p_coempresa bigint, p_cotipoentidad integer, p_coentidad bigint) OWNER TO postgres;

--
-- Name: fn_archivo_sel_by_id(bigint, bigint); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_archivo_sel_by_id(p_coempresa bigint, p_coarchivo bigint) RETURNS TABLE(coarchivo bigint, coempresa bigint, cotipoentidad bigint, coentidad bigint, cotipo bigint, noarchivo character varying, noextension character varying, noruta character varying, nubytes numeric, nualto numeric, nuancho numeric, nuorden smallint, txdescripcion character varying, fldefault integer, notitulo character varying, flestreg integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
		a.coarchivo, 
		a.coempresa, 
		a.cotipoentidad, 
		a.coentidad, 
		a.cotipo, 
		a.noarchivo,
		a.noextension, 
		a.noruta,
		a.nubytes,
		a.nualto,
		a.nuancho,
		a.nuorden,
		a.txdescripcion,
		a.fldefault::int,
		a.notitulo,
		a.flestreg::int
    FROM maestro.tblarchivo a
    WHERE a.coempresa = p_coempresa AND a.coarchivo = p_coarchivo;
END;
$$;


ALTER FUNCTION maestro.fn_archivo_sel_by_id(p_coempresa bigint, p_coarchivo bigint) OWNER TO postgres;

--
-- Name: fn_archivo_sel_metadata_by_id(bigint, bigint); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_archivo_sel_metadata_by_id(p_coempresa bigint, p_coarchivo bigint) RETURNS TABLE(coarchivo bigint, noarchivo character varying, noextension character varying, noruta character varying, nubytes numeric, nualto numeric, nuancho numeric)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
		a.coarchivo,
		a.noarchivo,
		a.noextension,
		a.noruta,
		a.nubytes,
		a.nualto,
		a.nuancho
    FROM maestro.tblarchivo a
    WHERE a.coempresa = p_coempresa 
		AND a.coarchivo = p_coarchivo;
END;
$$;


ALTER FUNCTION maestro.fn_archivo_sel_metadata_by_id(p_coempresa bigint, p_coarchivo bigint) OWNER TO postgres;

--
-- Name: fn_archivo_sel_metadata_by_uk(bigint, integer, bigint, integer, integer); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_archivo_sel_metadata_by_uk(p_coempresa bigint, p_cotipoentidad integer, p_coentidad bigint, p_cotipo integer, p_nuorden integer) RETURNS TABLE(coarchivo bigint, noarchivo character varying, noextension character varying, noruta character varying, nubytes numeric, nualto numeric, nuancho numeric)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
		a.coarchivo,
		a.noarchivo,
		a.noextension, 
		a.noruta,
		a.nubytes,
		a.nualto,
		a.nuancho		
    FROM maestro.tblarchivo a
    WHERE a.coempresa = p_coempresa AND a.cotipoentidad = p_cotipoentidad AND a.coentidad = p_coentidad AND a.cotipo = p_cotipo AND a.nuorden = p_nuorden;
END;
$$;


ALTER FUNCTION maestro.fn_archivo_sel_metadata_by_uk(p_coempresa bigint, p_cotipoentidad integer, p_coentidad bigint, p_cotipo integer, p_nuorden integer) OWNER TO postgres;

--
-- Name: fn_archivo_update_by_id(bigint, bigint, integer, character varying, integer, character varying, integer); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_archivo_update_by_id(p_coempresa bigint, p_coarchivo bigint, p_nuorden integer, p_txdescripcion character varying, p_fldefault integer, p_notitulo character varying, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_rows integer;
BEGIN
   UPDATE maestro.tblarchivo
    SET nuorden = p_nuorden, txdescripcion = p_txdescripcion, fldefault = p_fldefault::boolean, notitulo = p_notitulo, cousumod = p_cousumod, femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    WHERE coempresa = p_coempresa AND coarchivo = p_coarchivo
      AND (nuorden IS DISTINCT FROM p_nuorden OR txdescripcion IS DISTINCT FROM p_txdescripcion OR fldefault IS DISTINCT FROM p_fldefault::boolean OR notitulo IS DISTINCT FROM p_notitulo);
    GET DIAGNOSTICS v_rows = ROW_COUNT;
    RETURN v_rows;
END;
$$;


ALTER FUNCTION maestro.fn_archivo_update_by_id(p_coempresa bigint, p_coarchivo bigint, p_nuorden integer, p_txdescripcion character varying, p_fldefault integer, p_notitulo character varying, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_archivo_update_meta_data_by_id(bigint, bigint, character varying, character varying, character varying, numeric, integer, integer, integer); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_archivo_update_meta_data_by_id(p_coempresa bigint, p_coarchivo bigint, p_noarchivo character varying, p_noextension character varying, p_noruta character varying, p_nubytes numeric, p_nualto integer, p_nuancho integer, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_rows integer;
BEGIN
    UPDATE maestro.tblarchivo
    SET noarchivo = p_noarchivo, noextension = p_noextension, noruta = p_noruta, nubytes = p_nubytes, nualto = p_nualto, nuancho = p_nuancho, cousumod = p_cousumod, femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    WHERE tblarchivo.coempresa = p_coempresa AND tblarchivo.coarchivo = p_coarchivo
      AND (noarchivo IS DISTINCT FROM p_noarchivo OR noextension IS DISTINCT FROM p_noextension OR noruta IS DISTINCT FROM p_noruta OR nubytes IS DISTINCT FROM p_nubytes OR nualto IS DISTINCT FROM p_nualto OR nuancho IS DISTINCT FROM p_nuancho);
    GET DIAGNOSTICS v_rows = ROW_COUNT;
    RETURN v_rows;
END;
$$;


ALTER FUNCTION maestro.fn_archivo_update_meta_data_by_id(p_coempresa bigint, p_coarchivo bigint, p_noarchivo character varying, p_noextension character varying, p_noruta character varying, p_nubytes numeric, p_nualto integer, p_nuancho integer, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_archivo_update_orden_by_id(bigint, bigint, integer, integer); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_archivo_update_orden_by_id(p_coempresa bigint, p_coarchivo bigint, p_nuorden integer, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_rows integer;
BEGIN
    UPDATE maestro.tblarchivo SET nuorden = p_nuorden, cousumod = p_cousumod, femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    WHERE coempresa = p_coempresa AND coarchivo = p_coarchivo AND (nuorden IS DISTINCT FROM p_nuorden);
    GET DIAGNOSTICS v_rows = ROW_COUNT;
    RETURN v_rows;
END;
$$;


ALTER FUNCTION maestro.fn_archivo_update_orden_by_id(p_coempresa bigint, p_coarchivo bigint, p_nuorden integer, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_archivo_update_orden_masivo(bigint, bigint[], integer[], integer); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_archivo_update_orden_masivo(p_coempresa bigint, p_coarchivos bigint[], p_nuordenes integer[], p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_rows integer; v_index integer; v_total integer;
BEGIN
    v_total := array_length(p_coarchivos, 1);
    IF v_total IS NULL OR v_total = 0 THEN RETURN 0; END IF;
    FOR v_index IN 1..v_total LOOP
        UPDATE maestro.tblarchivo SET nuorden = -1 * v_index, cousumod = p_cousumod, femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
        WHERE coempresa = p_coempresa AND coarchivo = p_coarchivos[v_index];
    END LOOP;
    FOR v_index IN 1..v_total LOOP
        UPDATE maestro.tblarchivo SET nuorden = p_nuordenes[v_index]
        WHERE coempresa = p_coempresa AND coarchivo = p_coarchivos[v_index];
    END LOOP;
    GET DIAGNOSTICS v_rows = ROW_COUNT;
    RETURN v_rows;
END;
$$;


ALTER FUNCTION maestro.fn_archivo_update_orden_masivo(p_coempresa bigint, p_coarchivos bigint[], p_nuordenes integer[], p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_archivo_update_state_by_id(bigint, bigint, integer, integer); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_archivo_update_state_by_id(p_coempresa bigint, p_coarchivo bigint, p_flestreg integer, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_rows integer;
BEGIN
    UPDATE maestro.tblarchivo SET flestreg = p_flestreg::boolean, cousumod = p_cousumod, femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    WHERE tblarchivo.coempresa = p_coempresa AND tblarchivo.coarchivo = p_coarchivo AND (flestreg IS DISTINCT FROM p_flestreg::boolean);
    GET DIAGNOSTICS v_rows = ROW_COUNT;
    RETURN v_rows;
END;
$$;


ALTER FUNCTION maestro.fn_archivo_update_state_by_id(p_coempresa bigint, p_coarchivo bigint, p_flestreg integer, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_documentoidentidad_sel_all_active(bigint, integer); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_documentoidentidad_sel_all_active(p_copais bigint, p_coambito integer) RETURNS TABLE(nocodigo character varying, codocumentoidentidad bigint, nodocumentoidentidad character varying, nodocumentoidentidadsigla character varying, coambito bigint)
    LANGUAGE plpgsql
    AS $$
DECLARE C_TIPOPERSONA_AMBOS CONSTANT INT := 3;
begin
    return query
    select d.nocodigo, d.codocumentoidentidad, d.nodocumentoidentidad, d.nodocumentoidentidadsigla, d.coambito
    from maestro.trfdocumentoidentidad d
	INNER JOIN maestro.trftipogeneral ambito ON d.coambito = ambito.cotipogeneral
    where d.flestreg = true AND d.copais = p_copais
	AND (p_coambito IS NULL OR d.coambito = p_coambito)
	;
end;
$$;


ALTER FUNCTION maestro.fn_documentoidentidad_sel_all_active(p_copais bigint, p_coambito integer) OWNER TO postgres;

--
-- Name: fn_entidad_delete_by_id(bigint, bigint); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_entidad_delete_by_id(p_coentidad bigint, p_cousueli bigint) RETURNS integer
    LANGUAGE plpgsql
    AS $_$
DECLARE
	v_rows integer;
    v_coempresa BIGINT;
    v_old JSONB;
    v_delete_tables TEXT[][] := ARRAY[
        ARRAY['maestro','tblentidadempresa','coentidad'],
        ARRAY['seguridad','tblempresa','coentidad'],
        ARRAY['maestro','tblentidadrol','coentidad'],
        ARRAY['maestro','tblentidaddocumento','coentidad'],
        ARRAY['maestro','tblentidaddireccion','coentidad'],
        ARRAY['maestro','tblentidadredsocial','coentidad'],
        ARRAY['maestro','tblpersonajuridica','coentidad'],
        ARRAY['maestro','tblpersonanatural','coentidad'],
        ARRAY['maestro','tblentidad','coentidad']
    ];
    v_validate_tables TEXT[][] := ARRAY[
        ARRAY['seguridad','tblusuario','coentidad']
    ];
    v_item TEXT[];
    v_sql TEXT;
    v_count BIGINT;
BEGIN
    FOREACH v_item SLICE 1 IN ARRAY v_validate_tables
    LOOP
        v_sql := format('SELECT COUNT(*) FROM %I.%I WHERE %I=$1', v_item[1], v_item[2], v_item[3]);
        EXECUTE v_sql INTO v_count USING p_coentidad;
        IF v_count > 0 THEN
            RAISE EXCEPTION 'No se puede eliminar la entidad %. Existen registros en %.%', p_coentidad, v_item[1], v_item[2];
        END IF;
    END LOOP;

    SELECT coempresa INTO v_coempresa FROM seguridad.tblempresa WHERE coentidad=p_coentidad;

    SELECT jsonb_build_object(
        'empresa', (SELECT to_jsonb(e) FROM seguridad.tblempresa e WHERE e.coentidad=p_coentidad),
        'entidadempresa', (SELECT COALESCE(jsonb_agg(to_jsonb(x)),'[]'::jsonb) FROM maestro.tblentidadempresa x WHERE x.coempresa=v_coempresa),
        'entidad', (SELECT to_jsonb(x) FROM maestro.tblentidad x WHERE x.coentidad=p_coentidad),
        'personajuridica', (SELECT to_jsonb(x) FROM maestro.tblpersonajuridica x WHERE x.coentidad=p_coentidad),
        'personanatural', (SELECT to_jsonb(x) FROM maestro.tblpersonanatural x WHERE x.coentidad=p_coentidad),
        'documentos', (SELECT COALESCE(jsonb_agg(to_jsonb(x)),'[]'::jsonb) FROM maestro.tblentidaddocumento x WHERE x.coentidad=p_coentidad),
        'direcciones', (SELECT COALESCE(jsonb_agg(to_jsonb(x)),'[]'::jsonb) FROM maestro.tblentidaddireccion x WHERE x.coentidad=p_coentidad),
        'redessociales', (SELECT COALESCE(jsonb_agg(to_jsonb(x)),'[]'::jsonb) FROM maestro.tblentidadredsocial x WHERE x.coentidad=p_coentidad),
        'roles', (SELECT COALESCE(jsonb_agg(to_jsonb(x)),'[]'::jsonb) FROM maestro.tblentidadrol x WHERE x.coentidad=p_coentidad)
    ) INTO v_old;

    CALL seguridad.usp_auditoria(
        COALESCE(v_coempresa,-100), 'maestro', 'entidad', 'D', p_cousueli,
        jsonb_build_object('coentidad',p_coentidad,'coempresa',v_coempresa), v_old, NULL
    );

    FOREACH v_item SLICE 1 IN ARRAY v_delete_tables
    LOOP
        v_sql := format('DELETE FROM %I.%I WHERE %I=$1', v_item[1], v_item[2], v_item[3]);
        EXECUTE v_sql USING p_coentidad;
    END LOOP;

    GET DIAGNOSTICS v_rows = ROW_COUNT;
    RETURN v_rows;
END;
$_$;


ALTER FUNCTION maestro.fn_entidad_delete_by_id(p_coentidad bigint, p_cousueli bigint) OWNER TO postgres;

--
-- Name: fn_entidad_insert(character varying, integer); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_entidad_insert(p_noentidad character varying, p_cousucre integer) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_coentidad bigint;
BEGIN

    INSERT INTO maestro.tblentidad
    (
        noentidad,
        cousucre
    )
    VALUES
    (
        p_noentidad,
        p_cousucre
    )
    RETURNING coentidad
    INTO v_coentidad;

    RETURN v_coentidad;

END;
$$;


ALTER FUNCTION maestro.fn_entidad_insert(p_noentidad character varying, p_cousucre integer) OWNER TO postgres;

--
-- Name: fn_entidad_update_by_id(bigint, character varying, integer); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_entidad_update_by_id(p_coentidad bigint, p_noentidad character varying, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_rows integer;
begin
    update maestro.tblentidad set noentidad = p_noentidad, cousumod = p_cousumod, femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    where coentidad = p_coentidad AND (noentidad IS DISTINCT FROM p_noentidad);
    GET DIAGNOSTICS v_rows = ROW_COUNT;
    RETURN v_rows;
end;
$$;


ALTER FUNCTION maestro.fn_entidad_update_by_id(p_coentidad bigint, p_noentidad character varying, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_entidad_update_state_by_id(bigint, integer, integer); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_entidad_update_state_by_id(p_coentidad bigint, p_flestreg integer, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_rows integer;
begin
    update maestro.tblentidad set flestreg = p_flestreg::boolean, cousumod = p_cousumod, femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    where coentidad = p_coentidad AND (flestreg IS DISTINCT FROM p_flestreg::boolean);
    GET DIAGNOSTICS v_rows = ROW_COUNT;
    RETURN v_rows;
end;
$$;


ALTER FUNCTION maestro.fn_entidad_update_state_by_id(p_coentidad bigint, p_flestreg integer, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_entidaddireccion_default(bigint, bigint, integer); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_entidaddireccion_default(p_coentidad bigint, p_coentidaddireccion bigint, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_rows integer;
BEGIN
    UPDATE maestro.tblentidaddireccion SET fldefault = false WHERE coentidad = p_coentidad;
    UPDATE maestro.tblentidaddireccion SET fldefault = true, cousumod = p_cousumod, femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    WHERE coentidaddireccion = p_coentidaddireccion AND coentidad = p_coentidad AND (fldefault IS DISTINCT FROM p_fldefault::boolean);
    GET DIAGNOSTICS v_rows = ROW_COUNT;
    RETURN v_rows;
END;
$$;


ALTER FUNCTION maestro.fn_entidaddireccion_default(p_coentidad bigint, p_coentidaddireccion bigint, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_entidaddireccion_delete_by_id(bigint, integer); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_entidaddireccion_delete_by_id(p_coentidaddireccion bigint, p_cousueli integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_rows integer; v_old JSONB;
begin
    SELECT row_to_json(x) INTO v_old FROM maestro.tblentidaddireccion x WHERE coentidaddireccion = p_coentidaddireccion;
    CALL seguridad.usp_auditoria(-100, 'maestro', 'tblentidaddireccion', 'D', p_cousueli, jsonb_build_object('coentidaddireccion', p_coentidaddireccion), v_old, NULL);
    Delete From maestro.tblentidaddireccion Where coentidaddireccion = p_coentidaddireccion;
    GET DIAGNOSTICS v_rows = ROW_COUNT;
    RETURN v_rows;
end;
$$;


ALTER FUNCTION maestro.fn_entidaddireccion_delete_by_id(p_coentidaddireccion bigint, p_cousueli integer) OWNER TO postgres;

--
-- Name: fn_entidaddireccion_insert(bigint, bigint, character varying, bigint, integer); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_entidaddireccion_insert(p_coentidad bigint, p_coetiqueta bigint, p_nodireccionlinea1 character varying, p_copais bigint, p_cousucre integer) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
DECLARE v_coentidaddireccion bigint; v_fldefault bool := true;
BEGIN
    
	SELECT NOT EXISTS (SELECT 1 FROM maestro.tblentidaddireccion WHERE coentidad = p_coentidad) INTO v_fldefault;
	
    INSERT INTO maestro.tblentidaddireccion (
		coentidad,
		coetiqueta, 
		nodireccionlinea1,
		copais,
		fldefault,		
		cousucre)
    VALUES (
		p_coentidad,
		p_coetiqueta,
		p_nodireccionlinea1, 
		p_copais,
		v_fldefault,
		p_cousucre
	)
    RETURNING coentidaddireccion INTO v_coentidaddireccion;
    RETURN v_coentidaddireccion;
END;
$$;


ALTER FUNCTION maestro.fn_entidaddireccion_insert(p_coentidad bigint, p_coetiqueta bigint, p_nodireccionlinea1 character varying, p_copais bigint, p_cousucre integer) OWNER TO postgres;

--
-- Name: fn_entidaddireccion_insert(bigint, bigint, character varying, character varying, character varying, character varying, character varying, character varying, bigint, bigint, character varying, numeric, numeric, integer); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_entidaddireccion_insert(p_coentidad bigint, p_coetiqueta bigint, p_nodireccionlinea1 character varying, p_nodireccionlinea2 character varying, p_nodireccionlinea3 character varying, p_nourbanizacionbarrio character varying, p_nociudad character varying, p_noreferencia character varying, p_copais bigint, p_coubigeo bigint, p_nocodigopostal character varying, p_sslatitude numeric, p_sslongitude numeric, p_cousucre integer) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
DECLARE v_coentidaddireccion bigint; v_fldefault bool := true;
BEGIN
    SELECT NOT EXISTS (SELECT 1 FROM maestro.tblentidaddireccion WHERE coentidad = p_coentidad) INTO v_fldefault;
    INSERT INTO maestro.tblentidaddireccion (coentidad, coetiqueta, nodireccionlinea1, nodireccionlinea2, nodireccionlinea3, nourbanizacionbarrio, nociudad, nocodigopostal, sslatitude, sslongitude, noreferencia, fldefault, copais, coubigeo, cousucre)
    VALUES (p_coentidad, p_coetiqueta, p_nodireccionlinea1, p_nodireccionlinea2, p_nodireccionlinea3, p_nourbanizacionbarrio, p_nociudad, p_nocodigopostal, p_sslatitude, p_sslongitude, p_noreferencia, v_fldefault, p_copais, p_coubigeo, p_cousucre)
    RETURNING coentidaddireccion INTO v_coentidaddireccion;
    RETURN v_coentidaddireccion;
END;
$$;


ALTER FUNCTION maestro.fn_entidaddireccion_insert(p_coentidad bigint, p_coetiqueta bigint, p_nodireccionlinea1 character varying, p_nodireccionlinea2 character varying, p_nodireccionlinea3 character varying, p_nourbanizacionbarrio character varying, p_nociudad character varying, p_noreferencia character varying, p_copais bigint, p_coubigeo bigint, p_nocodigopostal character varying, p_sslatitude numeric, p_sslongitude numeric, p_cousucre integer) OWNER TO postgres;

--
-- Name: fn_entidaddireccion_sel_all(bigint); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_entidaddireccion_sel_all(p_coentidad bigint) RETURNS TABLE(coentidaddireccion bigint, coentidad bigint, noetiqueta character varying, nodireccionlinea1 character varying, nodireccionlinea2 character varying, nodireccionlinea3 character varying, nourbanizacionbarrio character varying, nociudad character varying, noreferencia character varying, nopais character varying, nodepartamento character varying, noprovincia character varying, nodistrito character varying, nocodigopostal character varying, sslatitude numeric, sslongitude numeric, fldefault integer, flestreg integer)
    LANGUAGE plpgsql
    AS $$
begin
    return query
  select pd.coentidaddireccion, pd.coentidad, etiqueta.notipo AS noetiqueta, pd.nodireccionlinea1, pd.nodireccionlinea2, pd.nodireccionlinea3, pd.nourbanizacionbarrio, pd.nociudad, pd.noreferencia,
        pais.nopais, ubigeo.nonivel1 AS nodepartamento, ubigeo.nonivel2 AS noprovincia, ubigeo.nonivel3 AS nodistrito, pd.nocodigopostal, pd.sslatitude, pd.sslongitude, pd.fldefault::int, pd.flestreg::int
    FROM maestro.tblentidaddireccion pd
       INNER JOIN maestro.trftipogeneral etiqueta on pd.coetiqueta = etiqueta.cotipogeneral
       INNER JOIN maestro.trfpais pais on pd.copais = pais.copais
       LEFT JOIN maestro.trfubigeo ubigeo on pd.copais = ubigeo.copais AND pd.coubigeo = ubigeo.coubigeo
    WHERE pd.coentidad = p_coentidad;
end;
$$;


ALTER FUNCTION maestro.fn_entidaddireccion_sel_all(p_coentidad bigint) OWNER TO postgres;

--
-- Name: fn_entidaddireccion_sel_all_active(bigint); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_entidaddireccion_sel_all_active(p_coentidad bigint) RETURNS TABLE(coentidaddireccion bigint, coentidad bigint, noetiqueta character varying, nodireccionlinea1 character varying, nodireccionlinea2 character varying, nodireccionlinea3 character varying, nourbanizacionbarrio character varying, nociudad character varying, noreferencia character varying, nopais character varying, nodepartamento character varying, noprovincia character varying, nodistrito character varying, nocodigopostal character varying, sslatitude numeric, sslongitude numeric, fldefault integer)
    LANGUAGE plpgsql
    AS $$
begin
    return query
  select pd.coentidaddireccion, pd.coentidad, etiqueta.notipo AS noetiqueta, pd.nodireccionlinea1, pd.nodireccionlinea2, pd.nodireccionlinea3, pd.nourbanizacionbarrio, pd.nociudad, pd.noreferencia,
        pais.nopais, ubigeo.nonivel1 AS nodepartamento, ubigeo.nonivel2 AS noprovincia, ubigeo.nonivel3 AS nodistrito, pd.nocodigopostal, pd.sslatitude, pd.sslongitude, pd.fldefault::int
    FROM maestro.tblentidaddireccion pd
       INNER JOIN maestro.trftipogeneral etiqueta on pd.coetiqueta = etiqueta.cotipogeneral
       INNER JOIN maestro.trfpais pais on pd.copais = pais.copais
       LEFT JOIN maestro.trfubigeo ubigeo on pd.copais = ubigeo.copais AND pd.coubigeo = ubigeo.coubigeo
    WHERE pd.flestreg = true AND pd.coentidad = p_coentidad;
end;
$$;


ALTER FUNCTION maestro.fn_entidaddireccion_sel_all_active(p_coentidad bigint) OWNER TO postgres;

--
-- Name: fn_entidaddireccion_sel_by_id(bigint); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_entidaddireccion_sel_by_id(p_coentidaddireccion bigint) RETURNS TABLE(coentidaddireccion bigint, coentidad bigint, noetiqueta character varying, nodireccionlinea1 character varying, nodireccionlinea2 character varying, nodireccionlinea3 character varying, nourbanizacionbarrio character varying, nociudad character varying, noreferencia character varying, nopais character varying, nodepartamento character varying, noprovincia character varying, nodistrito character varying, nocodigopostal character varying, sslatitude numeric, sslongitude numeric, fldefault integer, flestreg integer)
    LANGUAGE plpgsql
    AS $$
begin
    return query
  select pd.coentidaddireccion, pd.coentidad, etiqueta.notipo AS noetiqueta, pd.nodireccionlinea1, pd.nodireccionlinea2, pd.nodireccionlinea3, pd.nourbanizacionbarrio, pd.nociudad, pd.noreferencia,
        pais.nopais, ubigeo.nonivel1 AS nodepartamento, ubigeo.nonivel2 AS noprovincia, ubigeo.nonivel3 AS nodistrito, pd.nocodigopostal, pd.sslatitude, pd.sslongitude, pd.fldefault::int, pd.flestreg::int
    FROM maestro.tblentidaddireccion pd
       INNER JOIN maestro.trftipogeneral etiqueta on pd.coetiqueta = etiqueta.cotipogeneral
       INNER JOIN maestro.trfpais pais on pd.copais = pais.copais
       LEFT JOIN maestro.trfubigeo ubigeo on pd.copais = ubigeo.copais AND pd.coubigeo = ubigeo.coubigeo
    WHERE pd.coentidaddireccion = p_coentidaddireccion;
end;
$$;


ALTER FUNCTION maestro.fn_entidaddireccion_sel_by_id(p_coentidaddireccion bigint) OWNER TO postgres;

--
-- Name: fn_entidaddireccion_update_by_id(bigint, bigint, character varying, character varying, character varying, character varying, character varying, character varying, bigint, bigint, character varying, numeric, numeric, integer); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_entidaddireccion_update_by_id(p_coentidaddireccion bigint, p_coetiqueta bigint, p_nodireccionlinea1 character varying, p_nodireccionlinea2 character varying, p_nodireccionlinea3 character varying, p_nourbanizacionbarrio character varying, p_nociudad character varying, p_noreferencia character varying, p_copais bigint, p_coubigeo bigint, p_nocodigopostal character varying, p_sslatitude numeric, p_sslongitude numeric, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_rows integer;
BEGIN
    update maestro.tblentidaddireccion
    set coetiqueta = p_coetiqueta, nodireccionlinea1 = p_nodireccionlinea1, nodireccionlinea2 = p_nodireccionlinea2, nodireccionlinea3 = p_nodireccionlinea3,
        nourbanizacionbarrio = p_nourbanizacionbarrio, nociudad = p_nociudad, noreferencia = p_noreferencia, nocodigopostal = p_nocodigopostal,
        copais = p_copais, coubigeo = p_coubigeo, sslatitude = p_sslatitude, sslongitude = p_sslongitude, cousumod = p_cousumod, femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    where coentidaddireccion = p_coentidaddireccion
      AND ROW(coetiqueta, nodireccionlinea1, nodireccionlinea2, nodireccionlinea3, nourbanizacionbarrio, nociudad, noreferencia, nocodigopostal, copais, coubigeo, sslatitude, sslongitude)
      IS DISTINCT FROM ROW(p_coetiqueta, p_nodireccionlinea1, p_nodireccionlinea2, p_nodireccionlinea3, p_nourbanizacionbarrio, p_nociudad, p_noreferencia, p_nocodigopostal, p_copais, p_coubigeo, p_sslatitude, p_sslongitude);
    GET DIAGNOSTICS v_rows = ROW_COUNT;
    RETURN v_rows;
end;
$$;


ALTER FUNCTION maestro.fn_entidaddireccion_update_by_id(p_coentidaddireccion bigint, p_coetiqueta bigint, p_nodireccionlinea1 character varying, p_nodireccionlinea2 character varying, p_nodireccionlinea3 character varying, p_nourbanizacionbarrio character varying, p_nociudad character varying, p_noreferencia character varying, p_copais bigint, p_coubigeo bigint, p_nocodigopostal character varying, p_sslatitude numeric, p_sslongitude numeric, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_entidaddireccion_update_state_by_id(bigint, integer, integer); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_entidaddireccion_update_state_by_id(p_coentidaddireccion bigint, p_flestreg integer, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_rows integer;
BEGIN
    UPDATE maestro.tblentidaddireccion SET flestreg = p_flestreg::boolean, cousumod = p_cousumod, femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    WHERE coentidaddireccion = p_coentidaddireccion AND (flestreg IS DISTINCT FROM p_flestreg::boolean);
    GET DIAGNOSTICS v_rows = ROW_COUNT;
    RETURN v_rows;
END;
$$;


ALTER FUNCTION maestro.fn_entidaddireccion_update_state_by_id(p_coentidaddireccion bigint, p_flestreg integer, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_entidaddocumento_default(bigint, bigint); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_entidaddocumento_default(p_coentidad bigint, p_codocumentoidentidad bigint) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_rows integer;
BEGIN
    UPDATE maestro.tblentidaddocumento SET fldefault = false WHERE coentidad = p_coentidad;
	
    UPDATE maestro.tblentidaddocumento 
	SET fldefault = true
    WHERE codocumentoidentidad = p_codocumentoidentidad 
		AND coentidad = p_coentidad;
		
    GET DIAGNOSTICS v_rows = ROW_COUNT;
    RETURN v_rows;
END;
$$;


ALTER FUNCTION maestro.fn_entidaddocumento_default(p_coentidad bigint, p_codocumentoidentidad bigint) OWNER TO postgres;

--
-- Name: fn_entidaddocumento_delete_by_id(bigint, integer); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_entidaddocumento_delete_by_id(p_coentidaddocumento bigint, p_cousueli integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
Declare v_rows integer; v_old JSONB;
begin
    SELECT row_to_json(x) INTO v_old FROM maestro.tblentidaddocumento x WHERE coentidaddocumento = p_coentidaddocumento;
    CALL seguridad.usp_auditoria(-100, 'maestro', 'tblentidaddocumento', 'D', p_cousueli, jsonb_build_object('coentidaddocumento', p_coentidaddocumento), v_old, NULL);
    Delete From maestro.tblentidaddocumento Where coentidaddocumento = p_coentidaddocumento;
    GET DIAGNOSTICS v_rows = ROW_COUNT;
    RETURN v_rows;
end;
$$;


ALTER FUNCTION maestro.fn_entidaddocumento_delete_by_id(p_coentidaddocumento bigint, p_cousueli integer) OWNER TO postgres;

--
-- Name: fn_entidaddocumento_insert(bigint, bigint, character varying, integer); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_entidaddocumento_insert(p_coentidad bigint, p_codocumentoidentidad bigint, p_nudocumento character varying, p_cousucre integer) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
DECLARE v_coentidaddocumento bigint; v_fldefault bool := true;
BEGIN
    SELECT NOT EXISTS (SELECT 1 FROM maestro.tblentidaddocumento WHERE coentidad = p_coentidad) INTO v_fldefault;
    INSERT INTO maestro.tblentidaddocumento (coentidad, codocumentoidentidad, nudocumento, fldefault, cousucre)
    VALUES (p_coentidad, p_codocumentoidentidad, p_nudocumento, v_fldefault, p_cousucre)
    RETURNING coentidaddocumento INTO v_coentidaddocumento;
    RETURN v_coentidaddocumento;
END;
$$;


ALTER FUNCTION maestro.fn_entidaddocumento_insert(p_coentidad bigint, p_codocumentoidentidad bigint, p_nudocumento character varying, p_cousucre integer) OWNER TO postgres;

--
-- Name: fn_entidaddocumento_sel_all(bigint); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_entidaddocumento_sel_all(p_coentidad bigint) RETURNS TABLE(coentidad bigint, coentidaddocumento bigint, nudocumento character varying, nodocumentoidentidad character varying, nodocumentoidentidadsigla character varying)
    LANGUAGE plpgsql
    AS $$
begin
    return query
  select pd.coentidad, pd.coentidaddocumento, pd.nudocumento, di.nodocumentoidentidad, di.nodocumentoidentidadsigla
    FROM maestro.tblentidaddocumento pd
       INNER JOIN maestro.trfdocumentoidentidad di ON pd.codocumentoidentidad = di.codocumentoidentidad
    WHERE pd.coentidad = p_coentidad;
end;
$$;


ALTER FUNCTION maestro.fn_entidaddocumento_sel_all(p_coentidad bigint) OWNER TO postgres;

--
-- Name: fn_entidaddocumento_sel_by_id(bigint); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_entidaddocumento_sel_by_id(p_coentidaddocumento bigint) RETURNS TABLE(coentidad bigint, coentidaddocumento bigint, nudocumento character varying, nodocumentoidentidad character varying, nodocumentoidentidadsigla character varying)
    LANGUAGE plpgsql
    AS $$
begin
    return query
  select pd.coentidad, pd.coentidaddocumento, pd.nudocumento, di.nodocumentoidentidad, di.nodocumentoidentidadsigla
    FROM maestro.tblentidaddocumento pd
       INNER JOIN maestro.trfdocumentoidentidad di ON pd.codocumentoidentidad = di.codocumentoidentidad
    WHERE pd.coentidaddocumento = p_coentidaddocumento;
end;
$$;


ALTER FUNCTION maestro.fn_entidaddocumento_sel_by_id(p_coentidaddocumento bigint) OWNER TO postgres;

--
-- Name: fn_entidaddocumento_update_by_id(bigint, bigint, bigint, character varying, integer); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_entidaddocumento_update_by_id(p_coentidaddocumento bigint, p_coentidad bigint, p_codocumentoidentidad bigint, p_nudocumento character varying, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_rows integer;
BEGIN
    update maestro.tblentidaddocumento
    set codocumentoidentidad = p_codocumentoidentidad, 
		nudocumento = p_nudocumento, 
		cousumod = p_cousumod, 
		femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC' 
    where coentidaddocumento = p_coentidaddocumento AND coentidad = p_coentidad
      AND (codocumentoidentidad IS DISTINCT FROM p_codocumentoidentidad OR nudocumento IS DISTINCT FROM p_nudocumento);
    GET DIAGNOSTICS v_rows = ROW_COUNT;
    RETURN v_rows;
end;
$$;


ALTER FUNCTION maestro.fn_entidaddocumento_update_by_id(p_coentidaddocumento bigint, p_coentidad bigint, p_codocumentoidentidad bigint, p_nudocumento character varying, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_entidadempresa_insert(bigint, bigint, integer); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_entidadempresa_insert(p_coempresa bigint, p_coentidad bigint, p_cousucre integer) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_coentidadempresa bigint;
BEGIN

    INSERT INTO maestro.tblentidadempresa
    (
        coempresa,
        coentidad,      
        cousucre
    )
    VALUES
    (
        p_coempresa,
        p_coentidad,
        p_cousucre
    )
		  RETURNING coentidadempresa
    INTO v_coentidadempresa;

    RETURN v_coentidadempresa;

END;
$$;


ALTER FUNCTION maestro.fn_entidadempresa_insert(p_coempresa bigint, p_coentidad bigint, p_cousucre integer) OWNER TO postgres;

--
-- Name: fn_entidadredsocial_delete_by_id(bigint, integer); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_entidadredsocial_delete_by_id(p_coentidadredsocial bigint, p_cousueli integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
Declare v_rows integer; v_old JSONB;
begin
    SELECT row_to_json(x) INTO v_old FROM maestro.tblentidadredsocial x WHERE coentidadredsocial = p_coentidadredsocial;
    CALL seguridad.usp_auditoria(-100, 'maestro', 'tblentidadredsocial', 'D', p_cousueli, jsonb_build_object('coentidadredsocial', p_coentidadredsocial), v_old, NULL);
    Delete From maestro.tblentidadredsocial Where coentidadredsocial = p_coentidadredsocial;
    GET DIAGNOSTICS v_rows = ROW_COUNT;
    RETURN v_rows;
end;
$$;


ALTER FUNCTION maestro.fn_entidadredsocial_delete_by_id(p_coentidadredsocial bigint, p_cousueli integer) OWNER TO postgres;

--
-- Name: fn_entidadredsocial_insert(bigint, bigint, bigint, character varying, integer); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_entidadredsocial_insert(p_coentidad bigint, p_cotiporedsocial bigint, p_coetiqueta bigint, p_noredsocial character varying, p_cousucre integer) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
DECLARE 
	v_coentidadredsocial bigint;
BEGIN

    INSERT INTO maestro.tblentidadredsocial (
		coentidad, 
		cotiporedsocial,
		coetiqueta, 
		noredsocial, 
		cousucre)
    VALUES (
		p_coentidad,
		p_cotiporedsocial,
		p_coetiqueta,
		p_noredsocial,
		p_cousucre)
    RETURNING coentidadredsocial INTO v_coentidadredsocial;
    RETURN v_coentidadredsocial;
END;
$$;


ALTER FUNCTION maestro.fn_entidadredsocial_insert(p_coentidad bigint, p_cotiporedsocial bigint, p_coetiqueta bigint, p_noredsocial character varying, p_cousucre integer) OWNER TO postgres;

--
-- Name: fn_entidadredsocial_insert(bigint, bigint, bigint, bigint, character varying, integer, integer); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_entidadredsocial_insert(p_coentidad bigint, p_cotiporedsocial bigint, p_cotipourl bigint, p_coetiqueta bigint, p_noredsocial character varying, p_flwhatsapp integer, p_cousucre integer) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
DECLARE v_coentidadredsocial bigint;
begin
    insert into maestro.tblentidadredsocial (coentidad, cotiporedsocial, cotipourl, coetiqueta, noredsocial, flwhatsapp, cousucre)
    values (p_coentidad, p_cotiporedsocial, p_cotipourl, p_coetiqueta, p_noredsocial, p_flwhatsapp::boolean, p_cousucre)
    RETURNING coentidadredsocial INTO v_coentidadredsocial;
    RETURN v_coentidadredsocial;
END;
$$;


ALTER FUNCTION maestro.fn_entidadredsocial_insert(p_coentidad bigint, p_cotiporedsocial bigint, p_cotipourl bigint, p_coetiqueta bigint, p_noredsocial character varying, p_flwhatsapp integer, p_cousucre integer) OWNER TO postgres;

--
-- Name: fn_entidadredsocial_sel_all(bigint, bigint, bigint); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_entidadredsocial_sel_all(p_cotiporedsocial bigint, p_coentidad bigint, p_coentidadredsocial bigint) RETURNS TABLE(coentidadredsocial bigint, coentidad bigint, coetiqueta bigint, noetiqueta character varying, cotiporedsocial bigint, cotipourl bigint, notipourl character varying, noredsocial character varying, flwhatsapp integer)
    LANGUAGE plpgsql
    AS $$
begin
    return query
  select rd.coentidadredsocial, rd.coentidad, rd.coetiqueta, etiqueta.notipo as noetiqueta, rd.cotiporedsocial, rd.cotipourl, tipourl.notipo as notipourl, rd.noredsocial, rd.flwhatsapp::int
    from maestro.tblentidadredsocial rd
       left join maestro.trftipogeneral etiqueta on rd.coetiqueta = etiqueta.cotipogeneral
       left join maestro.trftipogeneral tipourl on rd.cotipourl = tipourl.cotipogeneral
    where rd.coentidad = p_coentidad
      and (p_cotiporedsocial is null or rd.cotiporedsocial = p_cotiporedsocial)
      and (p_coentidadredsocial is null or rd.coentidadredsocial = p_coentidadredsocial);
end;
$$;


ALTER FUNCTION maestro.fn_entidadredsocial_sel_all(p_cotiporedsocial bigint, p_coentidad bigint, p_coentidadredsocial bigint) OWNER TO postgres;

--
-- Name: fn_entidadredsocial_sel_by_id(bigint); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_entidadredsocial_sel_by_id(p_coentidadredsocial bigint) RETURNS TABLE(coentidadredsocial bigint, coentidad bigint, coetiqueta bigint, noetiqueta character varying, cotiporedsocial bigint, cotipourl bigint, notipourl character varying, noredsocial character varying, flwhatsapp integer)
    LANGUAGE plpgsql
    AS $$
begin
    return query
     select rd.coentidadredsocial, rd.coentidad, rd.coetiqueta, etiqueta.notipo as noetiqueta, rd.cotiporedsocial, rd.cotipourl, tipourl.notipo as notipourl, rd.noredsocial, rd.flwhatsapp::int
    from maestro.tblentidadredsocial rd
       left join maestro.trftipogeneral etiqueta on rd.coetiqueta = etiqueta.cotipogeneral
       left join maestro.trftipogeneral tipourl on rd.cotipourl = tipourl.cotipogeneral
    where rd.coentidadredsocial = p_coentidadredsocial;
end;
$$;


ALTER FUNCTION maestro.fn_entidadredsocial_sel_by_id(p_coentidadredsocial bigint) OWNER TO postgres;

--
-- Name: fn_entidadredsocial_update_by_id(bigint, bigint, bigint, character varying, integer, integer); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_entidadredsocial_update_by_id(p_coentidadredsocial bigint, p_cotipourl bigint, p_coetiqueta bigint, p_noredsocial character varying, p_flwhatsapp integer, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
Declare v_rows integer;
begin
    update maestro.tblentidadredsocial
    set coetiqueta = p_coetiqueta, cotipourl = p_cotipourl, noredsocial = p_noredsocial, flwhatsapp = p_flwhatsapp::boolean, cousumod = p_cousumod, femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    where coentidadredsocial = p_coentidadredsocial
      AND (coetiqueta IS DISTINCT FROM p_coetiqueta AND cotipourl IS DISTINCT FROM p_cotipourl AND noredsocial IS DISTINCT FROM p_noredsocial AND flwhatsapp IS DISTINCT FROM p_flwhatsapp::boolean);
    GET DIAGNOSTICS v_rows = ROW_COUNT;
    RETURN v_rows;
end;
$$;


ALTER FUNCTION maestro.fn_entidadredsocial_update_by_id(p_coentidadredsocial bigint, p_cotipourl bigint, p_coetiqueta bigint, p_noredsocial character varying, p_flwhatsapp integer, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_entidadrol_insert(bigint, bigint, bigint, bigint, integer); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_entidadrol_insert(p_coempresa bigint, p_coentidad bigint, p_corolnegocio bigint, p_comodulo bigint, p_cousucre integer) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
DECLARE v_coentidadrol BIGINT;
begin
    insert into maestro.tblentidadrol (coentidad, corolnegocio, coempresa, comodulo, cousucre)
    values (p_coentidad, p_corolnegocio, p_coempresa, p_comodulo, p_cousucre)
    RETURNING coentidadrol INTO v_coentidadrol;
    RETURN v_coentidadrol;
END;
$$;


ALTER FUNCTION maestro.fn_entidadrol_insert(p_coempresa bigint, p_coentidad bigint, p_corolnegocio bigint, p_comodulo bigint, p_cousucre integer) OWNER TO postgres;

--
-- Name: fn_entidadrol_sel_all_active(bigint); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_entidadrol_sel_all_active(p_coempresa bigint) RETURNS TABLE(corolnegocio bigint, norolnegocio character varying, comodulo bigint, nomodulo character varying, nomodulodescripcion character varying)
    LANGUAGE plpgsql
    AS $$
begin
    return query
 select pr.cotipogeneral as corolnegocio, pr.notipo as norolnegocio, pr.comodulo, mo.nomodulo, mo.nomodulodescripcion
    from maestro.trftipogeneral pr
        Inner join seguridad.segmodulo mo ON mo.comodulo = pr.comodulo and mo.flestreg = true
    where pr.cogrupo = 11
      and pr.comodulo in (select em.comodulo From seguridad.segempresamodulo em where em.coempresa = p_coempresa);
end;
$$;


ALTER FUNCTION maestro.fn_entidadrol_sel_all_active(p_coempresa bigint) OWNER TO postgres;

--
-- Name: fn_entidadrol_sel_all_active_by_entidad(bigint, bigint); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_entidadrol_sel_all_active_by_entidad(p_coempresa bigint, p_coentidad bigint) RETURNS TABLE(coentidadrol bigint, coentidad bigint, corolnegocio bigint, norolnegocio character varying, comodulo bigint, nomodulo character varying, nomodulodescripcion character varying, coempresa bigint)
    LANGUAGE plpgsql
    AS $$
begin
    return query
    select pr.coentidadrol, pr.coentidad, pr.corolnegocio, rol.notipo AS norolnegocio, pr.comodulo, mo.nomodulo, mo.nomodulodescripcion, pr.coempresa
   from maestro.tblentidadrol pr 
     Inner join seguridad.segmodulo mo ON mo.comodulo = pr.comodulo and mo.flestreg = true
     inner join maestro.trftipogeneral rol on pr.corolnegocio = rol.cotipogeneral
     inner join seguridad.segempresamodulo em on em.coempresa = pr.coempresa and pr.comodulo = em.comodulo
    where pr.coempresa = p_coempresa and pr.coentidad = p_coentidad;
end;
$$;


ALTER FUNCTION maestro.fn_entidadrol_sel_all_active_by_entidad(p_coempresa bigint, p_coentidad bigint) OWNER TO postgres;

--
-- Name: fn_entidadrol_sel_all_active_by_modulo_persona(bigint, bigint, bigint); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_entidadrol_sel_all_active_by_modulo_persona(p_coempresa bigint, p_comodulo bigint, p_coentidad bigint) RETURNS TABLE(coentidadrol bigint, coentidad bigint, corolnegocio bigint, norolnegocio character varying, comodulo bigint, nomodulo character varying, nomodulodescripcion character varying, coempresa bigint)
    LANGUAGE plpgsql
    AS $$
begin
    return query
     select pr.coentidadrol, pr.coentidad, pr.corolnegocio, rol.notipo AS norolnegocio, pr.comodulo, mo.nomodulo, mo.nomodulodescripcion, pr.coempresa
    from maestro.tblentidadrol pr
     Inner join seguridad.segmodulo mo ON mo.comodulo = pr.comodulo and mo.flestreg = true
     inner join maestro.trftipogeneral rol on pr.corolnegocio = rol.cotipogeneral
     inner join seguridad.segempresamodulo em on em.coempresa = pr.coempresa and pr.comodulo = em.comodulo
  where pr.coempresa = p_coempresa and pr.comodulo = p_comodulo and pr.coentidad = p_coentidad;
end;
$$;


ALTER FUNCTION maestro.fn_entidadrol_sel_all_active_by_modulo_persona(p_coempresa bigint, p_comodulo bigint, p_coentidad bigint) OWNER TO postgres;

--
-- Name: fn_entidadrol_update_by_id(bigint, bigint, integer); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_entidadrol_update_by_id(p_coentidadrol bigint, p_corolnegocio bigint, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_rows integer;
BEGIN
      UPDATE maestro.tblentidadrol
      SET corolnegocio = p_corolnegocio, cousumod = p_cousumod, femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
        WHERE corolnegocio = p_corolnegocio 
         AND (corolnegocio IS DISTINCT FROM p_corolnegocio);
    GET DIAGNOSTICS v_rows = ROW_COUNT;
    RETURN v_rows;
end;
$$;


ALTER FUNCTION maestro.fn_entidadrol_update_by_id(p_coentidadrol bigint, p_corolnegocio bigint, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_pais_sel_all_active(); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_pais_sel_all_active() RETURNS TABLE(copais bigint, nopais character varying, nomoneda character varying, comoneda bigint, nocodigoiso character varying, nosimbolo character varying)
    LANGUAGE plpgsql
    AS $$
begin
    return query
   select 
        p.copais,
        p.nopais,
        m.nomoneda,     -- ← splitOn: "nomoneda"
        m.comoneda,     -- ← MonedaEntity.CoMoneda ✓
        m.nocodigoiso,
        m.nosimbolo
    from maestro.trfpais p
	left join maestro.trfmoneda m on p.comoneda = m.comoneda
    where p.flestreg = true;
end;
$$;


ALTER FUNCTION maestro.fn_pais_sel_all_active() OWNER TO postgres;

--
-- Name: fn_personajuridica_insert(bigint, character varying, character varying, bigint, integer); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_personajuridica_insert(p_coentidad bigint, p_norazonsocial character varying, p_nocomercial character varying, p_corubro bigint, p_cousucre integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN

    INSERT INTO maestro.tblpersonajuridica
    (
        coentidad,
        norazonsocial,
        nocomercial,
		corubro,
        cousucre
    )
    VALUES
    (
        p_coentidad,
        p_norazonsocial,
        p_nocomercial,
		p_corubro,
        p_cousucre
    );

END;
$$;


ALTER FUNCTION maestro.fn_personajuridica_insert(p_coentidad bigint, p_norazonsocial character varying, p_nocomercial character varying, p_corubro bigint, p_cousucre integer) OWNER TO postgres;

--
-- Name: fn_personajuridica_sel_all(bigint, bigint, bigint, character varying, integer, integer, integer); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_personajuridica_sel_all(p_coempresa bigint, p_comodulo bigint, p_corolnegocio bigint, p_noinputsearch character varying, p_flestreg integer, p_pagesize integer, p_pageindex integer) RETURNS TABLE(rowscount bigint, coempresa bigint, coentidad bigint, noentidad character varying, flestreg integer)
    LANGUAGE plpgsql
    AS $$
begin
    return query
        SELECT COUNT(*) OVER() AS rowscount, pn.coempresa, pn.coentidad, pn.noentidad, pn.flestreg::int
        FROM maestro.vw_personajuridica pn
        WHERE pn.coempresa = p_coempresa
          AND (p_noinputsearch IS NULL OR LOWER(pn.noentidad) LIKE '%' || LOWER(p_noinputsearch) || '%' OR EXISTS (SELECT 1 FROM maestro.tblentidaddocumento ed WHERE ed.coentidad = pn.coentidad AND LOWER(ed.nudocumento) LIKE '%' || LOWER(p_noinputsearch) || '%'))
          AND (p_flestreg IS NULL OR pn.flestreg = p_flestreg::boolean)
          AND (p_corolnegocio IS NULL OR EXISTS (SELECT 1 FROM maestro.tblentidadrol er WHERE er.coentidad = pn.coentidad AND er.corolnegocio = p_corolnegocio))
        ORDER BY pn.coentidad
        OFFSET COALESCE(p_pageindex,0) * COALESCE(p_pagesize,10)
        LIMIT COALESCE(p_pagesize,10);
end;
$$;


ALTER FUNCTION maestro.fn_personajuridica_sel_all(p_coempresa bigint, p_comodulo bigint, p_corolnegocio bigint, p_noinputsearch character varying, p_flestreg integer, p_pagesize integer, p_pageindex integer) OWNER TO postgres;

--
-- Name: fn_personajuridica_sel_all_active(bigint, bigint, bigint, character varying); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_personajuridica_sel_all_active(p_coempresa bigint, p_comodulo bigint, p_corolnegocio bigint, p_noinputsearch character varying) RETURNS TABLE(coempresa bigint, coentidad bigint, noentidad character varying)
    LANGUAGE plpgsql
    AS $$
begin
    return query
        SELECT pn.coempresa, pn.coentidad, pn.noentidad
        FROM maestro.vw_personajuridica pn
        WHERE pn.coempresa = p_coempresa AND pn.flestreg = true
          AND (p_noinputsearch IS NULL OR LOWER(pn.noentidad) LIKE '%' || LOWER(p_noinputsearch) || '%' OR EXISTS (SELECT 1 FROM maestro.tblentidaddocumento ed WHERE ed.coentidad = pn.coentidad AND LOWER(ed.nudocumento) LIKE '%' || LOWER(p_noinputsearch) || '%'))
          AND (p_corolnegocio IS NULL OR EXISTS (SELECT 1 FROM maestro.tblentidadrol er WHERE er.coentidad = pn.coentidad AND er.corolnegocio = p_corolnegocio))
        ORDER BY pn.coentidad;
end;
$$;


ALTER FUNCTION maestro.fn_personajuridica_sel_all_active(p_coempresa bigint, p_comodulo bigint, p_corolnegocio bigint, p_noinputsearch character varying) OWNER TO postgres;

--
-- Name: fn_personajuridica_sel_by_id(bigint); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_personajuridica_sel_by_id(p_coentidad bigint) RETURNS TABLE(coempresa bigint, coentidad bigint, noentidad character varying, norazonsocial character varying, nocomercial character varying, corubro integer, flestreg integer)
    LANGUAGE plpgsql
    AS $$
begin
    return query
     select pj.coempresa, pj.coentidad, pj.noentidad, pj.norazonsocial, pj.nocomercial, pj.corubro, pj.flestreg::int
   FROM maestro.vw_personajuridica pj
    WHERE pj.coentidad = p_coentidad;
end;
$$;


ALTER FUNCTION maestro.fn_personajuridica_sel_by_id(p_coentidad bigint) OWNER TO postgres;

--
-- Name: fn_personajuridica_update_by_id(bigint, character varying, character varying, integer, integer); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_personajuridica_update_by_id(p_coentidad bigint, p_norazonsocial character varying, p_nocomercial character varying, p_corubro integer, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_rows integer;
BEGIN
     UPDATE maestro.tblpersonajuridica
       SET norazonsocial = trim(p_norazonsocial), nocomercial = trim(p_nocomercial), corubro = p_corubro, cousumod = p_cousumod, femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
     WHERE coentidad = p_coentidad
      AND (norazonsocial IS DISTINCT FROM p_norazonsocial AND nocomercial IS DISTINCT FROM p_nocomercial AND corubro IS DISTINCT FROM p_corubro);
    GET DIAGNOSTICS v_rows = ROW_COUNT;
    RETURN v_rows;
end;
$$;


ALTER FUNCTION maestro.fn_personajuridica_update_by_id(p_coentidad bigint, p_norazonsocial character varying, p_nocomercial character varying, p_corubro integer, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_personanatural_insert(bigint, character varying, character varying, character varying, date, integer, integer, integer, integer); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_personanatural_insert(p_coentidad bigint, p_nopersona character varying, p_noapellidop character varying, p_noapellidom character varying, p_fenacimiento date, p_cosexo integer, p_coestadocivil integer, p_coprofesion integer, p_cousucre integer) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
BEGIN
     INSERT INTO maestro.tblpersonanatural 
	 	(
	 		coentidad, 
			nopersona,
			noapellidop,
			noapellidom,
			fenacimiento,
			cosexo,
			coestadocivil,
			coprofesion,
			cousucre
		)
        values 
		(
			p_coentidad, 
			trim(p_nopersona), 
			trim(p_noapellidop), 
			trim(p_noapellidom), p_fenacimiento, p_cosexo, p_coestadocivil, p_coprofesion, p_cousucre);
			
    RETURN p_coentidad;
END;
$$;


ALTER FUNCTION maestro.fn_personanatural_insert(p_coentidad bigint, p_nopersona character varying, p_noapellidop character varying, p_noapellidom character varying, p_fenacimiento date, p_cosexo integer, p_coestadocivil integer, p_coprofesion integer, p_cousucre integer) OWNER TO postgres;

--
-- Name: fn_personanatural_sel_all(bigint, bigint, bigint, character varying, integer, integer, integer); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_personanatural_sel_all(p_coempresa bigint, p_comodulo bigint, p_corolnegocio bigint, p_noinputsearch character varying, p_flestreg integer, p_pagesize integer, p_pageindex integer) RETURNS TABLE(rowscount bigint, coempresa bigint, coentidad bigint, noentidad character varying, flestreg integer)
    LANGUAGE plpgsql
    AS $$
begin
    return query
        SELECT COUNT(*) OVER() AS rowscount, pn.coempresa, pn.coentidad, pn.noentidad, pn.flestreg::int
        FROM maestro.vw_personanatural pn
        WHERE pn.coempresa = p_coempresa
          AND (p_noinputsearch IS NULL OR LOWER(pn.noentidad) LIKE '%' || LOWER(p_noinputsearch) || '%' OR EXISTS (SELECT 1 FROM maestro.tblentidaddocumento ed WHERE ed.coentidad = pn.coentidad AND LOWER(ed.nudocumento) LIKE '%' || LOWER(p_noinputsearch) || '%'))
          AND (p_flestreg IS NULL OR pn.flestreg = p_flestreg::boolean)
          AND (p_corolnegocio IS NULL OR EXISTS (SELECT 1 FROM maestro.tblentidadrol er WHERE er.coentidad = pn.coentidad AND er.corolnegocio = p_corolnegocio))
        ORDER BY pn.coentidad
        OFFSET COALESCE(p_pageindex,0) * COALESCE(p_pagesize,10)
        LIMIT COALESCE(p_pagesize,10);
end;
$$;


ALTER FUNCTION maestro.fn_personanatural_sel_all(p_coempresa bigint, p_comodulo bigint, p_corolnegocio bigint, p_noinputsearch character varying, p_flestreg integer, p_pagesize integer, p_pageindex integer) OWNER TO postgres;

--
-- Name: fn_personanatural_sel_all_active(bigint, bigint, bigint, character varying); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_personanatural_sel_all_active(p_coempresa bigint, p_comodulo bigint, p_corolnegocio bigint, p_noinputsearch character varying) RETURNS TABLE(coempresa bigint, coentidad bigint, noentidad character varying)
    LANGUAGE plpgsql
    AS $$
begin
    return query
        SELECT pn.coempresa, pn.coentidad, pn.noentidad
        FROM maestro.vw_personanatural pn
        WHERE pn.coempresa = p_coempresa AND pn.flestreg = true
          AND (p_noinputsearch IS NULL OR LOWER(pn.noentidad) LIKE '%' || LOWER(p_noinputsearch) || '%' OR EXISTS (SELECT 1 FROM maestro.tblentidaddocumento ed WHERE ed.coentidad = pn.coentidad AND LOWER(ed.nudocumento) LIKE '%' || LOWER(p_noinputsearch) || '%'))
          AND (p_corolnegocio IS NULL OR EXISTS (SELECT 1 FROM maestro.tblentidadrol er WHERE er.coentidad = pn.coentidad AND er.corolnegocio = p_corolnegocio))
        ORDER BY pn.coentidad;
end;
$$;


ALTER FUNCTION maestro.fn_personanatural_sel_all_active(p_coempresa bigint, p_comodulo bigint, p_corolnegocio bigint, p_noinputsearch character varying) OWNER TO postgres;

--
-- Name: fn_personanatural_sel_by_id(bigint); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_personanatural_sel_by_id(p_coentidad bigint) RETURNS TABLE(coempresa bigint, coentidad bigint, nopersona character varying, noapellidop character varying, noapellidom character varying, fenacimiento date, cosexo integer, coestadocivil integer, coprofesion integer, flsitreg integer)
    LANGUAGE plpgsql
    AS $$
begin
    return query
     select pn.coempresa, pn.coentidad, pn.nopersona, pn.noapellidop, pn.noapellidom, pn.fenacimiento, pn.cosexo, pn.coestadocivil, pn.coprofesion, pn.flestreg::int
   FROM maestro.vw_personanatural pn
    where pn.coentidad = p_coentidad; 
end;
$$;


ALTER FUNCTION maestro.fn_personanatural_sel_by_id(p_coentidad bigint) OWNER TO postgres;

--
-- Name: fn_personanatural_update_by_id(bigint, character varying, character varying, character varying, date, integer, integer, integer, integer); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_personanatural_update_by_id(p_coentidad bigint, p_nopersona character varying, p_noapellidop character varying, p_noapellidom character varying, p_fenacimiento date, p_cosexo integer, p_coestadocivil integer, p_coprofesion integer, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_rows integer;
begin
    update maestro.tblpersonanatural
       set nopersona = trim(p_nopersona), noapellidop = trim(p_noapellidop), noapellidom = trim(p_noapellidom), fenacimiento = p_fenacimiento,
           cosexo = p_cosexo, coestadocivil = p_coestadocivil, coprofesion = p_coprofesion, cousumod = p_cousumod, femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
     where coentidad = p_coentidad
       AND (nopersona IS DISTINCT FROM p_nopersona AND noapellidop IS DISTINCT FROM p_noapellidop AND noapellidom IS DISTINCT FROM p_noapellidom AND fenacimiento IS DISTINCT FROM p_fenacimiento AND cosexo IS DISTINCT FROM p_cosexo AND coestadocivil IS DISTINCT FROM p_coestadocivil AND coprofesion IS DISTINCT FROM p_coprofesion);
    GET DIAGNOSTICS v_rows = ROW_COUNT;
    RETURN v_rows;
end;
$$;


ALTER FUNCTION maestro.fn_personanatural_update_by_id(p_coentidad bigint, p_nopersona character varying, p_noapellidop character varying, p_noapellidom character varying, p_fenacimiento date, p_cosexo integer, p_coestadocivil integer, p_coprofesion integer, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_tipogeneral_sel_all_active(bigint); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_tipogeneral_sel_all_active(p_cogrupo bigint) RETURNS TABLE(cotipogeneral bigint, cogrupo bigint, nuorden smallint, notipo character varying, fldefault integer, valor jsonb)
    LANGUAGE plpgsql
    AS $$
begin
    return query
    select
      t1.cotipogeneral, t1.cogrupo, t1.nuorden, t1.notipo, t1.fldefault::int, t1.valor
    from maestro.trftipogeneral t1
    where 
	t1.cogrupo = p_cogrupo and 
	t1.fldelete = false
      and t1.flestreg = true;
end;
$$;


ALTER FUNCTION maestro.fn_tipogeneral_sel_all_active(p_cogrupo bigint) OWNER TO postgres;

--
-- Name: fn_tipogeneral_sel_all_active_by_modulo(bigint, bigint); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_tipogeneral_sel_all_active_by_modulo(p_comodulo bigint, p_cogrupo bigint) RETURNS TABLE(cotipogeneral bigint, cogrupo bigint, nuorden smallint, notipo character varying, fldefault integer, valor jsonb)
    LANGUAGE plpgsql
    AS $$
begin
    return query
    select
         t1.cotipogeneral, t1.cogrupo, t1.nuorden, t1.notipo, t1.fldefault::int,  t1.valor
    from maestro.trftipogeneral t1
    where t1.comodulo = p_comodulo
      and t1.cogrupo = p_cogrupo
      and t1.fldelete = false
      and t1.flestreg = true;
end;
$$;


ALTER FUNCTION maestro.fn_tipogeneral_sel_all_active_by_modulo(p_comodulo bigint, p_cogrupo bigint) OWNER TO postgres;

--
-- Name: fn_tipogeneral_sel_by_id(bigint); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_tipogeneral_sel_by_id(p_cotipogeneral bigint) RETURNS TABLE(cotipogeneral bigint, cogrupo bigint, nuorden smallint, notipo character varying, nosigla character varying, fldefault integer, flestreg integer, comodulo bigint, valor jsonb)
    LANGUAGE plpgsql
    AS $$
begin
    return query
    select
         t1.cotipogeneral, t1.cogrupo, t1.nuorden, t1.notipo, t1.nosigla, t1.fldefault::int, t1.flestreg::int, t1.comodulo, t1.valor
    from maestro.trftipogeneral t1
    where t1.cotipogeneral = p_cotipogeneral;
      
end;
$$;


ALTER FUNCTION maestro.fn_tipogeneral_sel_by_id(p_cotipogeneral bigint) OWNER TO postgres;

--
-- Name: fn_tipoparticular_delete_by_id(bigint, integer); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_tipoparticular_delete_by_id(p_cotipoparticular bigint, p_cousueli integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_rows integer;
BEGIN
    UPDATE maestro.trftipoparticular
       SET fldelete = true, cousueli = p_cousueli, feeli = now()
     WHERE cotipoparticular = p_cotipoparticular;
    GET DIAGNOSTICS v_rows = ROW_COUNT;
    RETURN v_rows;
END;
$$;


ALTER FUNCTION maestro.fn_tipoparticular_delete_by_id(p_cotipoparticular bigint, p_cousueli integer) OWNER TO postgres;

--
-- Name: fn_tipoparticular_insert(bigint, bigint, bigint, bigint, bigint, smallint, character varying, character varying, character varying, integer, integer); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_tipoparticular_insert(p_coempresa bigint, p_comodulo bigint, p_cogrupo bigint, cotipoparticularpadre bigint, p_cogrupopadre bigint, p_nuorden smallint, p_notipo character varying, p_nosigla character varying, p_txdescripcion character varying, p_fldefault integer, p_cousucre integer) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
DECLARE v_cotipoparticular BIGINT;
BEGIN
    IF p_fldefault IS NULL THEN p_fldefault := 0; END IF;
    IF p_fldefault = 1 THEN
        UPDATE maestro.trftipoparticular SET fldefault = false WHERE coempresa = p_coempresa AND cogrupo = p_cogrupo;
    END IF;
    
    INSERT INTO maestro.trftipoparticular(coempresa, comodulo, cogrupo, notipo, nosigla, fldefault, txdescripcion, nuorden, cotipoparticularpadre, cogrupopadre, cousucre)
    VALUES (p_coempresa, p_comodulo, p_cogrupo, p_notipo, p_nosigla, p_fldefault::boolean, p_txdescripcion, p_nuorden, p_cotipoparticularpadre, p_cogrupopadre, p_cousucre)
	RETURNING cotipoparticular INTO v_cotipoparticular;
    RETURN v_cotipoparticular;
END;
$$;


ALTER FUNCTION maestro.fn_tipoparticular_insert(p_coempresa bigint, p_comodulo bigint, p_cogrupo bigint, cotipoparticularpadre bigint, p_cogrupopadre bigint, p_nuorden smallint, p_notipo character varying, p_nosigla character varying, p_txdescripcion character varying, p_fldefault integer, p_cousucre integer) OWNER TO postgres;

--
-- Name: fn_tipoparticular_sel_all(bigint, bigint, character varying, integer, bigint, integer, integer); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_tipoparticular_sel_all(p_coempresa bigint, p_cogrupo bigint, p_noinputsearch character varying, p_flestreg integer, p_cotipoparticular bigint, p_pagesize integer, p_pageindex integer) RETURNS TABLE(rowscount bigint, coempresa bigint, comodulo bigint, cotipoparticular bigint, cogrupo bigint, notipo character varying, nosigla character varying, fldefault integer, flestreg integer, nuorden smallint, cotipoparticularpadre bigint, cogrupohijo bigint, qthijo bigint)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
       WITH hijos AS (
    SELECT t1.coempresa, t1.cotipoparticularpadre, t1.cogrupopadre, COUNT(*) AS qthijo
    FROM maestro.trftipoparticular t1 WHERE t1.fldelete = false
    GROUP BY t1.coempresa, t1.cotipoparticularpadre, t1.cogrupopadre
),
grupos AS (
    SELECT t2.cotipoparticular, t2.cogrupopadre FROM maestro.trftipoparticular t2
    WHERE t2.fldelete = false AND t2.cogrupo = 0
)
SELECT
    COUNT(*) OVER() AS rowscount, tipo.coempresa, tipo.comodulo, tipo.cotipoparticular, tipo.cogrupo,
    tipo.notipo, tipo.nosigla, tipo.fldefault::int, tipo.flestreg::int, tipo.nuorden, tipo.cotipoparticularpadre,
    g.cogrupopadre AS cogrupohijo, COALESCE(h.qthijo,0) AS qthijo
FROM maestro.trftipoparticular tipo
LEFT JOIN grupos g ON g.cotipoparticular = tipo.cogrupo
LEFT JOIN hijos h ON h.coempresa = tipo.coempresa AND h.cotipoparticularpadre = tipo.cotipoparticular AND h.cogrupopadre = tipo.cogrupo
WHERE tipo.coempresa = p_coempresa
  AND tipo.cogrupo = p_cogrupo
  AND tipo.fldelete = false
  AND (p_noinputsearch IS NULL 
  		OR tipo.notipo LIKE '%' || p_noinputsearch || '%' OR tipo.nosigla LIKE '%' || p_noinputsearch || '%' OR tipo.txdescripcion LIKE '%' || p_noinputsearch || '%'
	  )
  AND (p_flestreg IS NULL OR tipo.flestreg = p_flestreg::boolean)
  AND (p_cotipoparticular IS NULL OR tipo.cotipoparticular = p_cotipoparticular)
ORDER BY tipo.nuorden
OFFSET COALESCE(p_pageindex,0) * COALESCE(p_pagesize,10)
LIMIT COALESCE(p_pagesize,10);
END;
$$;


ALTER FUNCTION maestro.fn_tipoparticular_sel_all(p_coempresa bigint, p_cogrupo bigint, p_noinputsearch character varying, p_flestreg integer, p_cotipoparticular bigint, p_pagesize integer, p_pageindex integer) OWNER TO postgres;

--
-- Name: fn_tipoparticular_sel_all_active(bigint, bigint, character varying); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_tipoparticular_sel_all_active(p_coempresa bigint, p_cogrupo bigint, p_noinputsearch character varying) RETURNS TABLE(cotipoparticular bigint, notipo character varying, fldefault integer, flestreg integer, nuorden smallint)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT t1.cotipoparticular, t1.notipo, t1.fldefault::int, t1.flestreg::int, t1.nuorden
    FROM maestro.trftipoparticular t1
    WHERE t1.coempresa = p_coempresa AND t1.cogrupo = p_cogrupo AND t1.fldelete = false AND t1.flestreg = true
      AND (
	  		p_noinputsearch IS NULL 
			  OR t1.notipo LIKE '%' || p_noinputsearch || '%' 
			  OR t1.nosigla LIKE '%' || p_noinputsearch || '%' 
			  OR t1.txdescripcion LIKE '%' || p_noinputsearch || '%' 			
			)
    LIMIT 300;
END;
$$;


ALTER FUNCTION maestro.fn_tipoparticular_sel_all_active(p_coempresa bigint, p_cogrupo bigint, p_noinputsearch character varying) OWNER TO postgres;

--
-- Name: fn_tipoparticular_sel_all_active_hijo(bigint, bigint, bigint, character varying); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_tipoparticular_sel_all_active_hijo(p_coempresa bigint, p_cogrupo bigint, p_cotipoparticularpadre bigint, p_noinputsearch character varying) RETURNS TABLE(cotipoparticular bigint, notipo character varying, fldefault integer, nuorden smallint)
    LANGUAGE plpgsql
    AS $$
begin
    return query
    select t1.cotipoparticular, t1.notipo, t1.fldefault::int, t1.nuorden
    from maestro.trftipoparticular t1
    where t1.coempresa = p_coempresa and t1.fldelete = false and t1.flestreg = true
      and t1.cogrupo = p_cogrupo and t1.cotipoparticularpadre = p_cotipoparticularpadre
      and (p_noinputsearch is null 
	  	or (t1.notipo ILIKE '%' || p_noinputsearch || '%' or t1.nosigla ILIKE '%' || p_noinputsearch || '%' or t1.txdescripcion ILIKE '%' || p_noinputsearch || '%')
	  );
end;
$$;


ALTER FUNCTION maestro.fn_tipoparticular_sel_all_active_hijo(p_coempresa bigint, p_cogrupo bigint, p_cotipoparticularpadre bigint, p_noinputsearch character varying) OWNER TO postgres;

--
-- Name: fn_tipoparticular_sel_all_active_padre_e_hijo(bigint, bigint, character varying); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_tipoparticular_sel_all_active_padre_e_hijo(p_coempresa bigint, p_cogrupo bigint, p_noinputsearch character varying) RETURNS TABLE(cotipoparticular bigint, notipo character varying, fldefault integer, nuorden smallint, cosubtipoparticular bigint, nosubtipo character varying, flsubdefault integer, nusuborden smallint)
    LANGUAGE plpgsql
    AS $$
begin
    return query
    select t1.cotipoparticular, t1.notipo, t1.fldefault::int, t1.nuorden,
        subtipo.cotipoparticular as cosubtipoparticular, subtipo.notipo as nosubtipo, subtipo.fldefault::int as flsubdefault, subtipo.nuorden as nusuborden
    from maestro.trftipoparticular t1
    left join maestro.trftipoparticular subtipo
           on t1.cotipoparticular = subtipo.cotipoparticularpadre and t1.coempresa = subtipo.coempresa and t1.cogrupo = subtipo.cogrupopadre
          and subtipo.fldelete = false and subtipo.flestreg = true
    where t1.coempresa = p_coempresa and t1.fldelete = false and t1.flestreg = true and t1.cogrupo = p_cogrupo
      and (p_noinputsearch is null or (t1.notipo ILIKE '%' || p_noinputsearch || '%' or t1.nosigla ILIKE '%' || p_noinputsearch || '%' or t1.txdescripcion ILIKE '%' || p_noinputsearch || '%' or subtipo.notipo ILIKE '%' || p_noinputsearch || '%' or subtipo.nosigla ILIKE '%' || p_noinputsearch || '%' or subtipo.txdescripcion ILIKE '%' || p_noinputsearch || '%'))
    order by t1.nuorden, subtipo.nuorden
    limit 300;
end;
$$;


ALTER FUNCTION maestro.fn_tipoparticular_sel_all_active_padre_e_hijo(p_coempresa bigint, p_cogrupo bigint, p_noinputsearch character varying) OWNER TO postgres;

--
-- Name: fn_tipoparticular_sel_all_grupo_by_modulo(bigint, bigint); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_tipoparticular_sel_all_grupo_by_modulo(p_coempresa bigint, p_comodulo bigint) RETURNS TABLE(coempresa bigint, cotipoparticular bigint, notipo character varying, nuorden smallint)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT tipo.coempresa, tipo.cotipoparticular, tipo.notipo, tipo.nuorden
    FROM maestro.trftipoparticular tipo
        INNER JOIN seguridad.segempresamodulo empresamodulo ON tipo.comodulo = empresamodulo.comodulo
    WHERE tipo.cogrupo = 0 AND tipo.fldelete = false AND tipo.flestreg = true
      AND tipo.comodulo = p_comodulo AND empresamodulo.coempresa = p_coempresa;
END;
$$;


ALTER FUNCTION maestro.fn_tipoparticular_sel_all_grupo_by_modulo(p_coempresa bigint, p_comodulo bigint) OWNER TO postgres;

--
-- Name: fn_tipoparticular_sel_all_hijo(bigint, bigint, bigint, character varying, bigint, integer, integer); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_tipoparticular_sel_all_hijo(p_coempresa bigint, p_cogrupopadre bigint, p_cotipoparticularpadre bigint, p_noinputsearch character varying, p_cotipoparticular bigint, p_pagesize integer, p_pageindex integer) RETURNS TABLE(rowscount bigint, coempresa bigint, cotipoparticular bigint, cogrupo bigint, notipo character varying, nosigla character varying, fldefault integer, flestreg integer, nuorden smallint, cotipoparticularpadre bigint)
    LANGUAGE plpgsql
    AS $$
begin
    return query
   SELECT COUNT(*) OVER() AS rowscount, tipo.coempresa, tipo.cotipoparticular, tipo.cogrupo, tipo.notipo, tipo.nosigla,
      tipo.fldefault::int, tipo.flestreg::int, tipo.nuorden, tipo.cotipoparticularpadre
FROM maestro.trftipoparticular tipo
WHERE tipo.coempresa = p_coempresa AND tipo.fldelete = false
  AND tipo.cogrupopadre = p_cogrupopadre AND tipo.cotipoparticularpadre = p_cotipoparticularpadre
  AND (p_noinputsearch IS NULL OR tipo.notipo LIKE '%' || p_noinputsearch || '%' OR tipo.nosigla LIKE '%' || p_noinputsearch || '%' OR tipo.txdescripcion LIKE '%' || p_noinputsearch || '%')
  AND (p_cotipoparticular IS NULL OR tipo.cotipoparticular = p_cotipoparticular)
ORDER BY tipo.nuorden
OFFSET COALESCE(p_pageindex, 0) * COALESCE(p_pagesize, 10)
LIMIT COALESCE(p_pagesize, 10);
end;
$$;


ALTER FUNCTION maestro.fn_tipoparticular_sel_all_hijo(p_coempresa bigint, p_cogrupopadre bigint, p_cotipoparticularpadre bigint, p_noinputsearch character varying, p_cotipoparticular bigint, p_pagesize integer, p_pageindex integer) OWNER TO postgres;

--
-- Name: fn_tipoparticular_sel_by_grupo(bigint); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_tipoparticular_sel_by_grupo(p_cogrupo bigint) RETURNS TABLE(notipo character varying)
    LANGUAGE plpgsql
    AS $$
begin
    return query
    select t.notipo from maestro.trftipoparticular t
    where t.cogrupo = 0 And fldelete = false and t.cotipoparticular = p_cogrupo;
end;
$$;


ALTER FUNCTION maestro.fn_tipoparticular_sel_by_grupo(p_cogrupo bigint) OWNER TO postgres;

--
-- Name: fn_tipoparticular_sel_by_id(bigint, bigint, bigint); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_tipoparticular_sel_by_id(p_coempresa bigint, p_cogrupo bigint, p_cotipoparticular bigint) RETURNS TABLE(coempresa bigint, comodulo bigint, cogrupo bigint, cogrupopadre bigint, cotipoparticularpadre bigint, cotipoparticular bigint, nuorden smallint, notipo character varying, nosigla character varying, txdescripcion character varying, fldefault integer, flestreg integer, cogrupohijo bigint)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT t.coempresa, t.comodulo, t.cogrupo, t.cogrupopadre, t.cotipoparticularpadre, t.cotipoparticular, t.nuorden, t.notipo,
        t.nosigla, t.txdescripcion, t.fldefault::int, t.flestreg::int, grupohijo.cogrupopadre AS cogrupohijo
    FROM maestro.trftipoparticular t
    LEFT JOIN maestro.trftipoparticular grupohijo ON t.cogrupo = grupohijo.cotipoparticular AND grupohijo.cogrupo = 0 AND grupohijo.fldelete = false
    WHERE t.coempresa = p_coempresa AND t.cogrupo = p_cogrupo AND t.cotipoparticular = p_cotipoparticular;
END;
$$;


ALTER FUNCTION maestro.fn_tipoparticular_sel_by_id(p_coempresa bigint, p_cogrupo bigint, p_cotipoparticular bigint) OWNER TO postgres;

--
-- Name: fn_tipoparticular_sel_default(bigint, bigint); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_tipoparticular_sel_default(p_coempresa bigint, p_cogrupo bigint) RETURNS TABLE(coempresa bigint, cotipoparticular bigint, cogrupo bigint, notipo character varying, nosigla character varying, fldefault integer, nuorden smallint)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT trftipo.coempresa, trftipo.cotipoparticular, trftipo.cogrupo, trftipo.notipo, trftipo.nosigla, trftipo.fldefault::int, trftipo.nuorden
    FROM maestro.trftipoparticular
    WHERE coempresa = p_coempresa AND cogrupo = p_cogrupo AND fldelete = false AND fldefault = true;
END;
$$;


ALTER FUNCTION maestro.fn_tipoparticular_sel_default(p_coempresa bigint, p_cogrupo bigint) OWNER TO postgres;

--
-- Name: fn_tipoparticular_sel_orden_next(bigint, bigint, bigint); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_tipoparticular_sel_orden_next(p_coempresa bigint, p_cogrupo bigint, p_cotipoparticularpadre bigint) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_nuorden integer;
BEGIN
    SELECT COALESCE(MAX(t1.nuorden),0) + 1 INTO v_nuorden
    FROM maestro.trftipoparticular t1
    WHERE t1.fldelete = false AND t1.coempresa = p_coempresa AND t1.cogrupo = p_cogrupo
      AND (p_cotipoparticularpadre IS NULL OR t1.cotipoparticularpadre = p_cotipoparticularpadre);
    RETURN v_nuorden;
END;
$$;


ALTER FUNCTION maestro.fn_tipoparticular_sel_orden_next(p_coempresa bigint, p_cogrupo bigint, p_cotipoparticularpadre bigint) OWNER TO postgres;

--
-- Name: fn_tipoparticular_update_by_id(bigint, bigint, bigint, smallint, character varying, character varying, character varying, integer, integer); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_tipoparticular_update_by_id(p_coempresa bigint, p_cogrupo bigint, p_cotipoparticular bigint, p_nuorden smallint, p_notipo character varying, p_nosigla character varying, p_txdescripcion character varying, p_fldefault integer, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_rows integer;
BEGIN
    IF p_fldefault IS NULL THEN p_fldefault := 0; END IF;
    IF p_fldefault = 1 THEN
        UPDATE maestro.trftipoparticular SET fldefault = false WHERE coempresa = p_coempresa AND cogrupo = p_cogrupo;
    END IF;
    UPDATE maestro.trftipoparticular
    SET nuorden = p_nuorden, notipo = p_notipo, nosigla = p_nosigla, txdescripcion = p_txdescripcion,
        fldefault = p_fldefault::boolean, cousumod = p_cousumod, femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    WHERE coempresa = p_coempresa AND cogrupo = p_cogrupo AND cotipoparticular = p_cotipoparticular
      AND (nuorden IS DISTINCT FROM p_nuorden AND notipo IS DISTINCT FROM p_notipo AND nosigla IS DISTINCT FROM p_nosigla AND txdescripcion IS DISTINCT FROM p_txdescripcion AND fldefault IS DISTINCT FROM p_fldefault::boolean);
    GET DIAGNOSTICS v_rows = ROW_COUNT;
    RETURN v_rows;
END;
$$;


ALTER FUNCTION maestro.fn_tipoparticular_update_by_id(p_coempresa bigint, p_cogrupo bigint, p_cotipoparticular bigint, p_nuorden smallint, p_notipo character varying, p_nosigla character varying, p_txdescripcion character varying, p_fldefault integer, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_tipoparticular_update_default(bigint, bigint, bigint, integer, integer); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_tipoparticular_update_default(p_coempresa bigint, p_cotipoparticular bigint, p_cogrupo bigint, p_fldefault integer, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_rows integer;
BEGIN
    UPDATE maestro.trftipoparticular SET fldefault = false WHERE coempresa = p_coempresa AND cogrupo = p_cogrupo;
    UPDATE maestro.trftipoparticular
    SET fldefault = p_fldefault::bool, cousumod = p_cousumod, femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    WHERE coempresa = p_coempresa AND cotipoparticular = p_cotipoparticular AND cogrupo = p_cogrupo AND (fldefault IS DISTINCT FROM p_fldefault::bool);
    GET DIAGNOSTICS v_rows = ROW_COUNT;
    RETURN v_rows;
END;
$$;


ALTER FUNCTION maestro.fn_tipoparticular_update_default(p_coempresa bigint, p_cotipoparticular bigint, p_cogrupo bigint, p_fldefault integer, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_tipoparticular_update_state_by_id(bigint, integer, integer); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_tipoparticular_update_state_by_id(p_cotipoparticular bigint, p_flestreg integer, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_rows integer;
BEGIN

    UPDATE maestro.trftipoparticular
    SET flestreg = p_flestreg::boolean, cousumod = p_cousumod, femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    WHERE cotipoparticular = p_cotipoparticular 
	AND (flestreg IS DISTINCT FROM p_flestreg::bool);
	
    GET DIAGNOSTICS v_rows = ROW_COUNT;
    RETURN v_rows;
END;
$$;


ALTER FUNCTION maestro.fn_tipoparticular_update_state_by_id(p_cotipoparticular bigint, p_flestreg integer, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_ubigeo_sel_all_nivel1(bigint); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_ubigeo_sel_all_nivel1(p_copais bigint) RETURNS TABLE(conivel1 character varying, nonivel1 character varying)
    LANGUAGE plpgsql
    AS $$
begin
    return query
    select DISTINCT u.conivel1, u.nonivel1
    from maestro.trfubigeo u
    Where u.copais = p_copais;
end;
$$;


ALTER FUNCTION maestro.fn_ubigeo_sel_all_nivel1(p_copais bigint) OWNER TO postgres;

--
-- Name: fn_ubigeo_sel_all_nivel2(bigint, character varying); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_ubigeo_sel_all_nivel2(p_copais bigint, p_conivel1 character varying) RETURNS TABLE(conivel2 character varying, nonivel2 character varying)
    LANGUAGE plpgsql
    AS $$
begin
    return query
    select DISTINCT u.conivel2, u.nonivel2
    from maestro.trfubigeo u
    Where u.copais = p_copais AND u.conivel1 = p_conivel1;
end;
$$;


ALTER FUNCTION maestro.fn_ubigeo_sel_all_nivel2(p_copais bigint, p_conivel1 character varying) OWNER TO postgres;

--
-- Name: fn_ubigeo_sel_all_nivel3(bigint, character varying, character varying); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_ubigeo_sel_all_nivel3(p_copais bigint, p_conivel1 character varying, p_conivel2 character varying) RETURNS TABLE(conivel3 character varying, nonivel3 character varying)
    LANGUAGE plpgsql
    AS $$
begin
    return query
    select DISTINCT u.conivel3, u.nonivel3
    from maestro.trfubigeo u
    Where u.copais = p_copais
    AND u.conivel1 = p_conivel1
    AND u.conivel2 = p_conivel2;
end;
$$;


ALTER FUNCTION maestro.fn_ubigeo_sel_all_nivel3(p_copais bigint, p_conivel1 character varying, p_conivel2 character varying) OWNER TO postgres;

--
-- Name: fn_ubigeo_sel_by_id(bigint); Type: FUNCTION; Schema: maestro; Owner: postgres
--

CREATE FUNCTION maestro.fn_ubigeo_sel_by_id(p_coubigeo bigint) RETURNS TABLE(coubigeo bigint, copais bigint, nocodigo character varying, nodepartamento character varying, noprovincia character varying, nodistrito character varying)
    LANGUAGE plpgsql
    AS $$
begin
    return query
    select u.coubigeo, u.copais, u.nocodigo, u.nonivel1 AS nodepartamento, u.nonivel2 AS noprovincia, u.nonivel3 AS nodistrito
    from maestro.trfubigeo u
    Where u.coubigeo = p_coubigeo;
end;
$$;


ALTER FUNCTION maestro.fn_ubigeo_sel_by_id(p_coubigeo bigint) OWNER TO postgres;

--
-- Name: fn_tipo_sel_all(integer, integer, character varying, integer); Type: FUNCTION; Schema: maestrorpt; Owner: postgres
--

CREATE FUNCTION maestrorpt.fn_tipo_sel_all(p_coempresa integer, p_cogrupo integer, p_noinputsearch character varying, p_flestreg integer) RETURNS TABLE(coempresa bigint, comodulo bigint, cotipo integer, cogrupo integer, notipo character varying, nosigla character varying, fldefault integer, flestreg integer, txdescripcion character varying, nuorden smallint, nocomando character varying, novalor character varying, cotipopadre integer, cogrupopadre integer, qthijo integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
  SELECT
        t1.coempresa,
        t1.comodulo,
        t1.cotipo,
        t1.cogrupo,
        t1.notipo,
        t1.nosigla,
        t1.fldefault::int,
        t1.flestreg::int,
        t1.txdescripcion,
        t1.nuorden,            
        t1.nocomando,
        t1.novalor,
        t1.cotipopadre,
        (SELECT t3.cogrupopadre 
         FROM maestro.trftipoparticular t3 
         WHERE t3.cogrupo = 0 AND t3.cotipo = t1.cogrupo
         LIMIT 1) AS cogrupopadre,
        (SELECT COUNT(1)
         FROM maestro.trftipoparticular t2
         WHERE t2.fldelete = false 
           AND t2.coempresa = t1.coempresa 
           AND t2.cotipopadre = t1.cotipo 
           AND t2.cogrupopadre = t1.cogrupo) AS qthijo
    FROM maestro.trftipoparticular t1
    WHERE t1.coempresa = p_coempresa
      AND t1.cogrupo = p_cogrupo
      AND t1.fldelete = false
      AND (p_noinputsearch IS NULL 
           OR t1.notipo LIKE '%' || p_noinputsearch || '%'
           OR t1.nosigla LIKE '%' || p_noinputsearch || '%'
           OR t1.txdescripcion LIKE '%' || p_noinputsearch || '%'
           OR t1.novalor LIKE '%' || p_noinputsearch || '%'
		  )
      AND (p_flestreg IS NULL OR t1.flestreg::int = p_flestreg);
END;
$$;


ALTER FUNCTION maestrorpt.fn_tipo_sel_all(p_coempresa integer, p_cogrupo integer, p_noinputsearch character varying, p_flestreg integer) OWNER TO postgres;

--
-- Name: fn_empresa_insert(bigint, character varying, character varying, character varying, bigint, bigint, bigint, bigint, integer); Type: FUNCTION; Schema: seguridad; Owner: postgres
--

CREATE FUNCTION seguridad.fn_empresa_insert(p_coentidad bigint, p_nomision character varying, p_novision character varying, p_txquiensoy character varying, p_copais bigint, p_comoneda bigint, p_coidioma bigint, p_cousuario_owner bigint, p_cousucre integer) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
DECLARE v_coempresa bigint;
BEGIN
    INSERT INTO seguridad.tblempresa(coentidad, nomision, novision, txquiensoy, copais, comoneda, coidioma, cousuario_owner, cousucre)
    VALUES (p_coentidad, p_nomision, p_novision, p_txquiensoy, p_copais, p_comoneda, p_coidioma, p_cousuario_owner, p_cousucre)
    RETURNING coempresa INTO v_coempresa;
    RETURN v_coempresa;
END;
$$;


ALTER FUNCTION seguridad.fn_empresa_insert(p_coentidad bigint, p_nomision character varying, p_novision character varying, p_txquiensoy character varying, p_copais bigint, p_comoneda bigint, p_coidioma bigint, p_cousuario_owner bigint, p_cousucre integer) OWNER TO postgres;

--
-- Name: fn_empresa_insert_all(character varying, character varying, bigint, character varying, character varying, character varying, bigint, bigint, bigint, bigint[], text[], text[], bigint[], text[], bigint[], character varying, character varying, character varying, character varying, character varying, integer); Type: FUNCTION; Schema: seguridad; Owner: postgres
--

CREATE FUNCTION seguridad.fn_empresa_insert_all(p_norazonsocial character varying, p_nocomercial character varying, p_corubro bigint, p_nomision character varying, p_novision character varying, p_txquiensoy character varying, p_copais bigint, p_comoneda bigint, p_coidioma bigint, p_documentos_codigo bigint[], p_documentos_numero text[], p_direcciones text[], p_tiporedsocial bigint[], p_redsocial text[], p_modulos bigint[], p_admin_nopersona character varying, p_admin_apellidop character varying, p_admin_apellidom character varying, p_admin_nousuario character varying, p_admin_noclave character varying, p_cousucre integer) RETURNS TABLE(co_empresa bigint, co_usuario bigint)
    LANGUAGE plpgsql
    AS $$
DECLARE 
	v_coentidad_empresa bigint;
	v_coentidad_usuario bigint;
	v_coempresa bigint;
    v_empresa bigint;
    v_cousuario bigint;
    v_mod     bigint;
    v_coperfil  bigint;
    i         integer;

	C_ETIQUETA_TRABAJO CONSTANT bigint := 72;
BEGIN
	IF p_modulos IS NULL OR array_length(p_modulos,1) IS NULL THEN
	    RAISE EXCEPTION 'Debe indicar al menos un módulo para la empresa';
	END IF;

    -- 1) Entidad + Persona Jurídica (la empresa) + documentos fiscales
	
    v_coentidad_empresa := maestro.fn_entidad_insert(p_norazonsocial, p_cousucre);
	
    PERFORM maestro.fn_personajuridica_insert(
        v_coentidad_empresa, 
		p_norazonsocial,
		p_nocomercial,
		p_corubro,
		p_cousucre
	);

    IF p_documentos_codigo IS NOT NULL THEN
        FOR i IN 1 .. coalesce(array_length(p_documentos_codigo, 1), 0) LOOP
            PERFORM maestro.fn_entidaddocumento_insert(
                v_coentidad_empresa,
				p_documentos_codigo[i],
				p_documentos_numero[i],
				p_cousucre);
        END LOOP;
    END IF;
	
    -- (Direcciones / redes sociales: misma técnica con
    --  fn_entidaddireccion_insert / fn_entidadredsocial_insert si se requieren.)

 	IF p_direcciones IS NOT NULL THEN
        FOR i IN 1 .. coalesce(array_length(p_direcciones, 1), 0) LOOP
            PERFORM maestro.fn_entidaddireccion_insert(
				v_coentidad_empresa,
				C_ETIQUETA_TRABAJO,
				p_direcciones[i], 
				p_copais,
				p_cousucre
				);
        END LOOP;
    END IF;

	IF p_tiporedsocial IS NOT NULL THEN
        FOR i IN 1 .. coalesce(array_length(p_tiporedsocial, 1), 0) LOOP
            PERFORM maestro.fn_entidadredsocial_insert(
				v_coentidad_empresa,
				p_tiporedsocial[i],
				C_ETIQUETA_TRABAJO,
				p_redsocial[i],
				p_cousucre
				);
        END LOOP;
    END IF;

    -- 2) ADMIN primero: entidad + persona natural + login (para tener el owner)
    v_coentidad_usuario := maestro.fn_entidad_insert(
        concat_ws(' ', p_admin_nopersona, p_admin_apellidop, p_admin_apellidom), 
		p_cousucre);
		
    PERFORM maestro.fn_personanatural_insert(
        v_coentidad_usuario, 
		p_admin_nopersona,
		p_admin_apellidop,
		p_admin_apellidom,
        NULL::date, 
		NULL::integer,
		NULL::integer,
		NULL::integer,
		p_cousucre
	);
    v_cousuario := seguridad.fn_usuario_insert(
        v_coentidad_usuario, 
		p_admin_nousuario,
		p_admin_noclave,
		p_cousucre
	);

    -- 3) Empresa YA con owner (reusa la fn_empresa_insert nueva)
    v_coempresa := seguridad.fn_empresa_insert(
        v_coentidad_empresa,
		p_nomision,
		p_novision,
		p_txquiensoy,
        p_copais, 
		p_comoneda,
		p_coidioma,
        v_cousuario,          
        p_cousucre
	);

    -- 4) Vincular el admin (persona) a la empresa   [confirmar si aplica en tu modelo]
    PERFORM maestro.fn_entidadempresa_insert(
		v_coempresa, 
		v_coentidad_usuario,
		p_cousucre
	);

    -- 5) Módulos habilitados de la empresa
    FOREACH v_mod IN ARRAY p_modulos LOOP
        PERFORM seguridad.fn_empresamodulo_insert(v_coempresa, v_mod);
    END LOOP;

    -- 6) Acceso administrador por cada módulo (perfil con fladmin)
    --    → el owner SIEMPRE queda con rol admin.
    FOREACH v_mod IN ARRAY p_modulos LOOP
        v_coperfil := seguridad.fn_perfil_sel_admin(v_mod::integer);
        IF v_coperfil IS NULL THEN
            RAISE EXCEPTION 'El módulo % no tiene perfil administrador (fladmin) definido', v_mod;
        END IF;
        PERFORM seguridad.fn_modulousuario_insert(
			v_coempresa,
			v_cousuario,
			v_mod,
			v_coperfil,
			NULL::date
		);
    END LOOP;

    co_empresa := v_coempresa;
    co_usuario := v_cousuario;
    RETURN NEXT;
END; 
$$;


ALTER FUNCTION seguridad.fn_empresa_insert_all(p_norazonsocial character varying, p_nocomercial character varying, p_corubro bigint, p_nomision character varying, p_novision character varying, p_txquiensoy character varying, p_copais bigint, p_comoneda bigint, p_coidioma bigint, p_documentos_codigo bigint[], p_documentos_numero text[], p_direcciones text[], p_tiporedsocial bigint[], p_redsocial text[], p_modulos bigint[], p_admin_nopersona character varying, p_admin_apellidop character varying, p_admin_apellidom character varying, p_admin_nousuario character varying, p_admin_noclave character varying, p_cousucre integer) OWNER TO postgres;

--
-- Name: fn_empresa_sel_all(bigint, character varying, integer, integer); Type: FUNCTION; Schema: seguridad; Owner: postgres
--

CREATE FUNCTION seguridad.fn_empresa_sel_all(p_coempresa bigint, p_noinputsearch character varying, p_pagesize integer, p_pageindex integer) RETURNS TABLE(rowscount bigint, coempresa bigint, nocomercial character varying, norazonsocial character varying, flestreg integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
   SELECT 
   	   COUNT(*) OVER() AS rowscount,
	   e.coempresa,
	   e.nocomercial,
	   e.norazonsocial,
	   e.flestreg::int
  FROM seguridad.vw_empresa e
    WHERE e.coempresa > 0
      AND (p_coempresa IS NULL OR e.coempresa = p_coempresa)
      AND (p_noinputsearch IS NULL OR e.norazonsocial ILIKE '%' || p_noinputsearch || '%')
    ORDER BY e.coempresa
    OFFSET COALESCE(p_pageindex, 0) * COALESCE(p_pagesize, 10)
    LIMIT COALESCE(p_pagesize, 10);
END;
$$;


ALTER FUNCTION seguridad.fn_empresa_sel_all(p_coempresa bigint, p_noinputsearch character varying, p_pagesize integer, p_pageindex integer) OWNER TO postgres;

--
-- Name: fn_empresa_sel_all_active(); Type: FUNCTION; Schema: seguridad; Owner: postgres
--

CREATE FUNCTION seguridad.fn_empresa_sel_all_active() RETURNS TABLE(coempresa bigint, norazonsocial character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
		e.coempresa,
		en.norazonsocial
    FROM seguridad.vw_empresa e
    WHERE e.flestreg = true
      AND e.coempresa > 0;
END;
$$;


ALTER FUNCTION seguridad.fn_empresa_sel_all_active() OWNER TO postgres;

--
-- Name: fn_empresa_sel_by_id(bigint); Type: FUNCTION; Schema: seguridad; Owner: postgres
--

CREATE FUNCTION seguridad.fn_empresa_sel_by_id(p_coempresa bigint) RETURNS TABLE(coempresa bigint, coentidad bigint, nomision character varying, novision character varying, txquiensoy character varying, copais bigint, comoneda bigint, coidioma bigint, norazonsocial character varying, nocomercial character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
		e.coempresa,
        e.coentidad,
        e.nomision,
        e.novision,
        e.txquiensoy,
        e.copais,
        e.comoneda,
        e.coidioma,	
		e.norazonsocial,
		e.nocomercial
    FROM seguridad.vw_empresa e
    WHERE e.coempresa = p_coempresa;
END;
$$;


ALTER FUNCTION seguridad.fn_empresa_sel_by_id(p_coempresa bigint) OWNER TO postgres;

--
-- Name: fn_empresa_update_by_id(bigint, character varying, character varying, character varying, bigint, bigint, integer, integer); Type: FUNCTION; Schema: seguridad; Owner: postgres
--

CREATE FUNCTION seguridad.fn_empresa_update_by_id(p_coempresa bigint, p_nomision character varying, p_novision character varying, p_txquiensoy character varying, p_copais bigint, p_comoneda bigint, p_coidioma integer, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_rows integer;
BEGIN
UPDATE seguridad.tblempresa
   SET nomision = p_nomision, novision = p_novision, txquiensoy = p_txquiensoy, copais = p_copais,
       comoneda = p_comoneda, coidioma = p_coidioma, cousumod = p_cousumod, femod = CURRENT_TIMESTAMP
 WHERE coempresa = p_coempresa
 AND (ROW(nomision, novision, txquiensoy, copais, comoneda, coidioma) IS DISTINCT FROM ROW(p_nomision, p_novision, p_txquiensoy, p_copais, p_comoneda, p_coidioma));
  	GET DIAGNOSTICS v_rows = ROW_COUNT;
    RETURN v_rows;
END;
$$;


ALTER FUNCTION seguridad.fn_empresa_update_by_id(p_coempresa bigint, p_nomision character varying, p_novision character varying, p_txquiensoy character varying, p_copais bigint, p_comoneda bigint, p_coidioma integer, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_empresa_update_state_by_id(bigint, integer, integer); Type: FUNCTION; Schema: seguridad; Owner: postgres
--

CREATE FUNCTION seguridad.fn_empresa_update_state_by_id(p_coempresa bigint, p_flestreg integer, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_rows integer;
BEGIN
    UPDATE seguridad.tblempresa
       SET flestreg = p_flestreg::boolean, cousumod = p_cousumod, femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
     WHERE coempresa = p_coempresa
       AND (ROW(flestreg) IS DISTINCT FROM ROW(p_flestreg));
	GET DIAGNOSTICS v_rows = ROW_COUNT;
    RETURN v_rows;
END;
$$;


ALTER FUNCTION seguridad.fn_empresa_update_state_by_id(p_coempresa bigint, p_flestreg integer, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_empresamodulo_delete_by_id(bigint, integer); Type: FUNCTION; Schema: seguridad; Owner: postgres
--

CREATE FUNCTION seguridad.fn_empresamodulo_delete_by_id(p_coempresamodulo bigint, p_cousueli integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_rows integer; v_old JSONB;
BEGIN
    SELECT row_to_json(x) INTO v_old FROM seguridad.segempresamodulo x WHERE coempresamodulo = p_coempresamodulo;
    CALL seguridad.usp_auditoria(-100, 'seguridad', 'segempresamodulo', 'D', p_cousueli, jsonb_build_object('coempresamodulo', p_coempresamodulo), v_old, NULL);
    Delete From seguridad.segempresamodulo WHERE coempresamodulo = p_coempresamodulo;
    GET DIAGNOSTICS v_rows = ROW_COUNT;
    RETURN v_rows;
END;
$$;


ALTER FUNCTION seguridad.fn_empresamodulo_delete_by_id(p_coempresamodulo bigint, p_cousueli integer) OWNER TO postgres;

--
-- Name: fn_empresamodulo_insert(bigint, bigint); Type: FUNCTION; Schema: seguridad; Owner: postgres
--

CREATE FUNCTION seguridad.fn_empresamodulo_insert(p_coempresa bigint, p_comodulo bigint) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
DECLARE v_coempresamodulo BIGINT;
BEGIN
    INSERT INTO seguridad.segempresamodulo (coempresa, comodulo) VALUES (p_coempresa, p_comodulo)
    RETURNING coempresamodulo INTO v_coempresamodulo;
    RETURN v_coempresamodulo;
END;
$$;


ALTER FUNCTION seguridad.fn_empresamodulo_insert(p_coempresa bigint, p_comodulo bigint) OWNER TO postgres;

--
-- Name: fn_empresamodulo_sel_all(bigint); Type: FUNCTION; Schema: seguridad; Owner: postgres
--

CREATE FUNCTION seguridad.fn_empresamodulo_sel_all(p_coempresa bigint) RETURNS TABLE(coempresamodulo bigint, comodulo bigint, nomodulo character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT em.coempresamodulo, em.comodulo, mo.nomodulo
    FROM seguridad.segempresamodulo em
    INNER JOIN seguridad.segmodulo mo ON mo.comodulo = em.comodulo AND mo.flestreg = true
    WHERE em.coempresa = p_coempresa;
END;
$$;


ALTER FUNCTION seguridad.fn_empresamodulo_sel_all(p_coempresa bigint) OWNER TO postgres;

--
-- Name: fn_empresamodulo_sel_by_id(bigint); Type: FUNCTION; Schema: seguridad; Owner: postgres
--

CREATE FUNCTION seguridad.fn_empresamodulo_sel_by_id(p_coempresamodulo bigint) RETURNS TABLE(coempresamodulo bigint, coempresa bigint, comodulo bigint, nomodulo character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT em.coempresamodulo, em.comodulo, em.coempresa, m.nomodulo
      FROM seguridad.segempresamodulo em
      JOIN seguridad.segmodulo m ON em.comodulo = m.comodulo and m.flestreg = true
     WHERE em.coempresamodulo = p_coempresamodulo;
END;
$$;


ALTER FUNCTION seguridad.fn_empresamodulo_sel_by_id(p_coempresamodulo bigint) OWNER TO postgres;

--
-- Name: fn_menu_delete_by_id(bigint, integer); Type: FUNCTION; Schema: seguridad; Owner: postgres
--

CREATE FUNCTION seguridad.fn_menu_delete_by_id(p_comenu bigint, p_cousueli integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_rows integer; v_old JSONB;
begin
    SELECT row_to_json(x) INTO v_old FROM seguridad.segmenu x WHERE comenu = p_comenu;
    CALL seguridad.usp_auditoria(-100, 'seguridad', 'segmenu', 'D', p_cousueli, jsonb_build_object('comenu', p_comenu), v_old, NULL);
   Delete From seguridad.segmenu Where comenu = p_comenu;
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION seguridad.fn_menu_delete_by_id(p_comenu bigint, p_cousueli integer) OWNER TO postgres;

--
-- Name: fn_menu_insert(bigint, integer, character varying, integer); Type: FUNCTION; Schema: seguridad; Owner: postgres
--

CREATE FUNCTION seguridad.fn_menu_insert(p_comodulo bigint, p_nuorden integer, p_nomenu character varying, p_cousucre integer) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
DECLARE v_comenu BIGINT;
BEGIN
    INSERT INTO seguridad.segmenu (comodulo, nuorden, nomenu, cousucre) VALUES (p_comodulo, p_nuorden, p_nomenu, p_cousucre)
	RETURNING comenu INTO v_comenu;
	RETURN v_comenu;
END;
$$;


ALTER FUNCTION seguridad.fn_menu_insert(p_comodulo bigint, p_nuorden integer, p_nomenu character varying, p_cousucre integer) OWNER TO postgres;

--
-- Name: fn_menu_sel_all(bigint); Type: FUNCTION; Schema: seguridad; Owner: postgres
--

CREATE FUNCTION seguridad.fn_menu_sel_all(p_comodulo bigint) RETURNS TABLE(comenu bigint, comodulo bigint, nomenu character varying, flestreg integer, nuorden smallint)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
		segmenu.comenu,
		segmenu.comodulo,
		segmenu.nomenu,
		segmenu.flestreg::int,
		segmenu.nuorden
      FROM seguridad.segmenu WHERE segmenu.comodulo = p_comodulo;
END;
$$;


ALTER FUNCTION seguridad.fn_menu_sel_all(p_comodulo bigint) OWNER TO postgres;

--
-- Name: fn_menu_sel_all_active(bigint); Type: FUNCTION; Schema: seguridad; Owner: postgres
--

CREATE FUNCTION seguridad.fn_menu_sel_all_active(p_comodulo bigint) RETURNS TABLE(comenu bigint, comodulo bigint, nomenu character varying, nuorden smallint)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
		segmenu.comenu, 
		segmenu.comodulo, 
		segmenu.nomenu,
		segmenu.nuorden
      FROM seguridad.segmenu 
	  WHERE segmenu.flestreg = true AND segmenu.comodulo = p_comodulo;
END;
$$;


ALTER FUNCTION seguridad.fn_menu_sel_all_active(p_comodulo bigint) OWNER TO postgres;

--
-- Name: fn_menu_sel_by_id(bigint, bigint); Type: FUNCTION; Schema: seguridad; Owner: postgres
--

CREATE FUNCTION seguridad.fn_menu_sel_by_id(p_comodulo bigint, p_comenu bigint) RETURNS TABLE(comenu bigint, comodulo bigint, nomodulodescripcion character varying, nomenu character varying, nuorden smallint)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
		segmenu.comenu,
		segmenu.comodulo,		
		segmodulo.nomodulodescripcion,
		segmenu.nomenu,
		segmenu.nuorden
      FROM seguridad.segmenu JOIN seguridad.segmodulo ON segmenu.comodulo = segmodulo.comodulo
     WHERE segmenu.comenu = p_comenu AND segmenu.comodulo = p_comodulo;
END;
$$;


ALTER FUNCTION seguridad.fn_menu_sel_by_id(p_comodulo bigint, p_comenu bigint) OWNER TO postgres;

--
-- Name: fn_menu_update_by_id(bigint, integer, character varying, integer); Type: FUNCTION; Schema: seguridad; Owner: postgres
--

CREATE FUNCTION seguridad.fn_menu_update_by_id(p_comenu bigint, p_nuorden integer, p_nomenu character varying, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_rows integer;
BEGIN
    UPDATE seguridad.segmenu SET nuorden = p_nuorden, nomenu = p_nomenu, cousumod = p_cousumod, femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
     WHERE comenu = p_comenu AND (nuorden IS DISTINCT FROM p_nuorden AND nomenu IS DISTINCT FROM p_nomenu);
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION seguridad.fn_menu_update_by_id(p_comenu bigint, p_nuorden integer, p_nomenu character varying, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_menu_update_state_by_id(bigint, integer, integer); Type: FUNCTION; Schema: seguridad; Owner: postgres
--

CREATE FUNCTION seguridad.fn_menu_update_state_by_id(p_comenu bigint, p_flestreg integer, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_rows integer;
BEGIN
    UPDATE seguridad.segmenu SET flestreg = p_flestreg::boolean, cousumod = p_cousumod, femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
     WHERE comenu = p_comenu AND (flestreg IS DISTINCT FROM p_flestreg::boolean);
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION seguridad.fn_menu_update_state_by_id(p_comenu bigint, p_flestreg integer, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_modulo_delete_by_id(bigint, integer); Type: FUNCTION; Schema: seguridad; Owner: postgres
--

CREATE FUNCTION seguridad.fn_modulo_delete_by_id(p_comodulo bigint, p_cousueli integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_rows integer; v_old JSONB;
BEGIN
    SELECT row_to_json(x) INTO v_old FROM seguridad.segmodulo x WHERE comodulo = p_comodulo;
    CALL seguridad.usp_auditoria(-100, 'seguridad', 'segmodulo', 'D', p_cousueli, jsonb_build_object('comodulo', p_comodulo), v_old, NULL);
    Delete From seguridad.segmodulo WHERE comodulo = p_comodulo;
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION seguridad.fn_modulo_delete_by_id(p_comodulo bigint, p_cousueli integer) OWNER TO postgres;

--
-- Name: fn_modulo_insert(character varying, character varying, character varying, integer, character varying, integer, integer); Type: FUNCTION; Schema: seguridad; Owner: postgres
--

CREATE FUNCTION seguridad.fn_modulo_insert(p_nomodulo character varying, p_noarea character varying, p_nomodulodescripcion character varying, p_nuorden integer, p_noicono character varying, p_flarea integer, p_cousucre integer) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
DECLARE v_comodulo BIGINT;
BEGIN
    INSERT INTO seguridad.segmodulo (nomodulo, noarea, nomodulodescripcion, nuorden, noicono, flarea, cousucre)
    VALUES (p_nomodulo, p_noarea, p_nomodulodescripcion, p_nuorden, p_noicono, p_flarea::boolean, p_cousucre)
	RETURNING comodulo INTO v_comodulo;
	RETURN v_comodulo;
END;
$$;


ALTER FUNCTION seguridad.fn_modulo_insert(p_nomodulo character varying, p_noarea character varying, p_nomodulodescripcion character varying, p_nuorden integer, p_noicono character varying, p_flarea integer, p_cousucre integer) OWNER TO postgres;

--
-- Name: fn_modulo_sel_all(bigint); Type: FUNCTION; Schema: seguridad; Owner: postgres
--

CREATE FUNCTION seguridad.fn_modulo_sel_all(p_comodulo bigint) RETURNS TABLE(comodulo bigint, nuorden smallint, nomodulo character varying, flestreg integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
		m.comodulo, 
		m.nuorden,
		m.nomodulo, 
		m.flestreg::int
    FROM seguridad.segmodulo m WHERE m.comodulo > 0 AND (p_comodulo IS NULL OR m.comodulo = p_comodulo);
END;
$$;


ALTER FUNCTION seguridad.fn_modulo_sel_all(p_comodulo bigint) OWNER TO postgres;

--
-- Name: fn_modulo_sel_all_active(); Type: FUNCTION; Schema: seguridad; Owner: postgres
--

CREATE FUNCTION seguridad.fn_modulo_sel_all_active() RETURNS TABLE(comodulo bigint, nuorden smallint, nomodulo character varying)
    LANGUAGE sql
    AS $$
    SELECT 
        m.comodulo,
		m.nuorden,
        m.nomodulo
    FROM seguridad.segmodulo m
    WHERE m.flestreg = true
      AND m.comodulo > 0;
	  
$$;


ALTER FUNCTION seguridad.fn_modulo_sel_all_active() OWNER TO postgres;

--
-- Name: fn_modulo_sel_by_id(bigint); Type: FUNCTION; Schema: seguridad; Owner: postgres
--

CREATE FUNCTION seguridad.fn_modulo_sel_by_id(p_comodulo bigint) RETURNS TABLE(comodulo bigint, nomodulo character varying, nomodulodescripcion character varying, noarea character varying, flarea integer, nuorden smallint, noicono character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
		m.comodulo,
		m.nomodulo,
		m.nomodulodescripcion, 
		m.noarea,
		m.flarea::int,
		m.nuorden,
		m.noicono
    FROM seguridad.segmodulo m WHERE m.comodulo = p_comodulo;
END;
$$;


ALTER FUNCTION seguridad.fn_modulo_sel_by_id(p_comodulo bigint) OWNER TO postgres;

--
-- Name: fn_modulo_update_by_id(bigint, character varying, character varying, character varying, integer, character varying, integer, integer); Type: FUNCTION; Schema: seguridad; Owner: postgres
--

CREATE FUNCTION seguridad.fn_modulo_update_by_id(p_comodulo bigint, p_nomodulo character varying, p_noarea character varying, p_nomodulodescripcion character varying, p_nuorden integer, p_noicono character varying, p_flarea integer, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_rows integer;
BEGIN
    UPDATE seguridad.segmodulo
       SET nomodulo = p_nomodulo, noarea = p_noarea, nomodulodescripcion = p_nomodulodescripcion, nuorden = p_nuorden,
           flarea = p_flarea::boolean, noicono = p_noicono, cousumod = p_cousumod, femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
     WHERE comodulo = p_comodulo
	   AND (nomodulo IS DISTINCT FROM p_nomodulo AND noarea IS DISTINCT FROM p_noarea AND nomodulodescripcion IS DISTINCT FROM p_nomodulodescripcion AND nuorden IS DISTINCT FROM p_nuorden AND flarea IS DISTINCT FROM p_flarea::boolean AND noicono IS DISTINCT FROM p_noicono);
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION seguridad.fn_modulo_update_by_id(p_comodulo bigint, p_nomodulo character varying, p_noarea character varying, p_nomodulodescripcion character varying, p_nuorden integer, p_noicono character varying, p_flarea integer, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_modulo_update_state_by_id(bigint, integer, integer); Type: FUNCTION; Schema: seguridad; Owner: postgres
--

CREATE FUNCTION seguridad.fn_modulo_update_state_by_id(p_comodulo bigint, p_flestreg integer, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_rows integer;
BEGIN
    UPDATE seguridad.segmodulo SET flestreg = p_flestreg::boolean, cousumod = p_cousumod, femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
     WHERE comodulo = p_comodulo AND (flestreg IS DISTINCT FROM p_flestreg::boolean);
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION seguridad.fn_modulo_update_state_by_id(p_comodulo bigint, p_flestreg integer, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_modulousuario_delete_by_id(bigint, bigint, integer); Type: FUNCTION; Schema: seguridad; Owner: postgres
--

CREATE FUNCTION seguridad.fn_modulousuario_delete_by_id(p_coempresa bigint, p_comodulousuario bigint, p_cousueli integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_rows integer; v_old JSONB;
BEGIN
	
	SELECT row_to_json(x) INTO v_old FROM seguridad.segmodulousuario x 
	WHERE coempresa = p_coempresa And comodulousuario = p_comodulousuario;
	
    CALL seguridad.usp_auditoria(
		p_coempresa, 
		'seguridad',
		'segmodulousuario', 
		'D',
		p_cousueli,
		jsonb_build_object('comodulousuario', p_comodulousuario),
		v_old,
		NULL
	);
	
    DELETE FROM seguridad.segmodulousuario WHERE coempresa = p_coempresa AND comodulousuario = p_comodulousuario;
	
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION seguridad.fn_modulousuario_delete_by_id(p_coempresa bigint, p_comodulousuario bigint, p_cousueli integer) OWNER TO postgres;

--
-- Name: fn_modulousuario_insert(bigint, bigint, bigint, bigint, date); Type: FUNCTION; Schema: seguridad; Owner: postgres
--

CREATE FUNCTION seguridad.fn_modulousuario_insert(p_coempresa bigint, p_cousuario bigint, p_comodulo bigint, p_coperfil bigint, p_feexpiracion date) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
DECLARE v_comodulousuario BIGINT;
BEGIN
    INSERT INTO seguridad.segmodulousuario (coempresa, cousuario, comodulo, coperfil, feexpiracion)
    VALUES (p_coempresa, p_cousuario, p_comodulo, p_coperfil, p_feexpiracion)
	RETURNING comodulousuario INTO v_comodulousuario;
	RETURN v_comodulousuario;
END;
$$;


ALTER FUNCTION seguridad.fn_modulousuario_insert(p_coempresa bigint, p_cousuario bigint, p_comodulo bigint, p_coperfil bigint, p_feexpiracion date) OWNER TO postgres;

--
-- Name: fn_modulousuario_sel_all(bigint); Type: FUNCTION; Schema: seguridad; Owner: postgres
--

CREATE FUNCTION seguridad.fn_modulousuario_sel_all(p_cousuario bigint) RETURNS TABLE(comodulousuario bigint, feexpiracion date, nuorden smallint, noicono character varying, nomodulo character varying, noperfil character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
	SELECT 
		mous.comodulousuario,		
		mous.feexpiracion,
		m.nuorden,
		m.noicono,
        m.nomodulo, 		
		sp.noperfil
    FROM seguridad.segmodulousuario mous
	    INNER JOIN seguridad.segperfil pe ON pe.coperfil = mous.coperfil AND pe.comodulo = mous.comodulo
	    INNER JOIN seguridad.segmodulo mo ON mo.comodulo = mous.comodulo
    WHERE mous.cousuario = p_cousuario;
END;
$$;


ALTER FUNCTION seguridad.fn_modulousuario_sel_all(p_cousuario bigint) OWNER TO postgres;

--
-- Name: fn_modulousuario_sel_by_id(bigint); Type: FUNCTION; Schema: seguridad; Owner: postgres
--

CREATE FUNCTION seguridad.fn_modulousuario_sel_by_id(p_comodulousuario bigint) RETURNS TABLE(coempresa bigint, comodulousuario bigint, cousuario bigint, coentidad bigint, comodulo bigint, coperfil bigint, noperfil character varying, feexpiracion date, nomodulo character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
     SELECT
       	mous.coempresa,
	    mous.comodulousuario,
	    enem.cousuario,
		enem.coentidad,
	    mous.comodulo,
	    mous.coperfil,
	    pe.noperfil,
	    mous.feexpiracion,
	    mo.nomodulo
    FROM seguridad.segmodulousuario mous
		INNER JOIN maestro.tblentidadempresa enem ON enem.coempresa = mous.coempresa
		INNER JOIN seguridad.segmodulo mo ON mo.comodulo = mous.comodulo
		INNER JOIN seguridad.segperfil pe ON pe.comodulo = mous.comodulo AND pe.coperfil = mous.coperfil
    WHERE mous.comodulousuario = p_comodulousuario;
END;
$$;


ALTER FUNCTION seguridad.fn_modulousuario_sel_by_id(p_comodulousuario bigint) OWNER TO postgres;

--
-- Name: fn_modulousuario_update_by_id(bigint, bigint, date); Type: FUNCTION; Schema: seguridad; Owner: postgres
--

CREATE FUNCTION seguridad.fn_modulousuario_update_by_id(p_comodulousuario bigint, p_coperfil bigint, p_feexpiracion date) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_rows integer;
BEGIN
    UPDATE seguridad.segmodulousuario
    SET coperfil = p_coperfil, feexpiracion = p_feexpiracion, femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    WHERE comodulousuario = p_comodulousuario AND (coperfil IS DISTINCT FROM p_coperfil AND feexpiracion IS DISTINCT FROM p_feexpiracion);
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION seguridad.fn_modulousuario_update_by_id(p_comodulousuario bigint, p_coperfil bigint, p_feexpiracion date) OWNER TO postgres;

--
-- Name: fn_modulousuario_update_configuracion_by_id(bigint, jsonb); Type: FUNCTION; Schema: seguridad; Owner: postgres
--

CREATE FUNCTION seguridad.fn_modulousuario_update_configuracion_by_id(p_comodulousuario bigint, p_valor jsonb DEFAULT NULL::jsonb) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_rows integer;
BEGIN
    UPDATE seguridad.segmodulousuario SET valor = p_valor
    WHERE comodulousuario = p_comodulousuario AND (valor IS DISTINCT FROM p_valor);
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION seguridad.fn_modulousuario_update_configuracion_by_id(p_comodulousuario bigint, p_valor jsonb) OWNER TO postgres;

--
-- Name: fn_pagina_delete_by_id(bigint, integer); Type: FUNCTION; Schema: seguridad; Owner: postgres
--

CREATE FUNCTION seguridad.fn_pagina_delete_by_id(p_copagina bigint, p_cousueli integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_rows integer; v_old JSONB;
BEGIN
SELECT row_to_json(x) INTO v_old FROM seguridad.segpagina x WHERE copagina = p_copagina;
    CALL seguridad.usp_auditoria(-100, 'seguridad', 'segpagina', 'D', p_cousueli, jsonb_build_object('copagina', p_copagina), v_old, NULL);
    Delete From seguridad.segpagina WHERE copagina = p_copagina;
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION seguridad.fn_pagina_delete_by_id(p_copagina bigint, p_cousueli integer) OWNER TO postgres;

--
-- Name: fn_pagina_insert(bigint, bigint, bigint, character varying, integer, bigint, character varying, character varying, integer); Type: FUNCTION; Schema: seguridad; Owner: postgres
--

CREATE FUNCTION seguridad.fn_pagina_insert(p_comodulo bigint, p_coarea bigint, p_comenu bigint, p_noopcion character varying, p_nuorden integer, p_cotipopagina bigint, p_nocontrolador character varying, p_noaccion character varying, p_cousucre integer) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
DECLARE v_copagina BIGINT;
BEGIN
    INSERT INTO seguridad.segpagina (comodulo, coarea, comenu, noopcion, nuorden, cotipopagina, nocontrolador, noaccion, cousucre)
    VALUES (p_comodulo, p_coarea, p_comenu, p_noopcion, p_nuorden, p_cotipopagina, p_nocontrolador, p_noaccion, p_cousucre)
		RETURNING copagina INTO v_copagina;
	RETURN v_copagina;
END;
$$;


ALTER FUNCTION seguridad.fn_pagina_insert(p_comodulo bigint, p_coarea bigint, p_comenu bigint, p_noopcion character varying, p_nuorden integer, p_cotipopagina bigint, p_nocontrolador character varying, p_noaccion character varying, p_cousucre integer) OWNER TO postgres;

--
-- Name: fn_pagina_sel_all(bigint, bigint, integer); Type: FUNCTION; Schema: seguridad; Owner: postgres
--

CREATE FUNCTION seguridad.fn_pagina_sel_all(p_comodulo bigint, p_cotipopagina bigint, p_flestreg integer) RETURNS TABLE(copagina bigint, comenu bigint, coarea bigint, comodulo bigint, noopcion character varying, nocontrolador character varying, noaccion character varying, nuorden smallint, cotipopagina bigint, flestreg integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
     SELECT 
	 	p.copagina,
		 p.comenu,
		 p.coarea,
		 p.comodulo, 
		 p.noopcion,		
		 p.nocontrolador,
		 p.noaccion, 
		 p.nuorden,
		 p.cotipopagina,
		 p.flestreg::int
    FROM seguridad.segpagina p
    INNER JOIN seguridad.segmodulo m ON m.comodulo = p.coarea AND m.flestreg = true
    WHERE p.comodulo = p_comodulo 
		AND p.cotipopagina = p_cotipopagina
		AND (p_flestreg IS NULL OR p.flestreg = flestreg::bool)
		;
END;
$$;


ALTER FUNCTION seguridad.fn_pagina_sel_all(p_comodulo bigint, p_cotipopagina bigint, p_flestreg integer) OWNER TO postgres;

--
-- Name: fn_pagina_sel_by_id(bigint); Type: FUNCTION; Schema: seguridad; Owner: postgres
--

CREATE FUNCTION seguridad.fn_pagina_sel_by_id(p_copagina bigint) RETURNS TABLE(copagina bigint, comenu bigint, coarea bigint, comodulo bigint, nocontrolador character varying, noaccion character varying, noopcion character varying, nuorden smallint, cotipopagina bigint)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
		p.copagina,
		p.comenu,
		p.coarea,
		p.comodulo,
		p.nocontrolador, 
		p.noaccion,
		p.noopcion,
		p.nuorden,
		p.cotipopagina
    FROM seguridad.segpagina p WHERE p.copagina = p_copagina;
END;
$$;


ALTER FUNCTION seguridad.fn_pagina_sel_by_id(p_copagina bigint) OWNER TO postgres;

--
-- Name: fn_pagina_update_by_id(bigint, bigint, character varying, integer, character varying, character varying, integer); Type: FUNCTION; Schema: seguridad; Owner: postgres
--

CREATE FUNCTION seguridad.fn_pagina_update_by_id(p_copagina bigint, p_coarea bigint, p_noopcion character varying, p_nuorden integer, p_nocontrolador character varying, p_noaccion character varying, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_rows integer;
BEGIN
    UPDATE seguridad.segpagina
    SET noopcion = p_noopcion, nuorden = p_nuorden, nocontrolador = p_nocontrolador, noaccion = p_noaccion, coarea = p_coarea, cousumod = p_cousumod, femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    WHERE copagina = p_copagina
	 AND (noopcion IS DISTINCT FROM p_noopcion AND nuorden IS DISTINCT FROM p_nuorden AND nocontrolador IS DISTINCT FROM p_nocontrolador AND noaccion IS DISTINCT FROM p_noaccion AND coarea IS DISTINCT FROM p_coarea);
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION seguridad.fn_pagina_update_by_id(p_copagina bigint, p_coarea bigint, p_noopcion character varying, p_nuorden integer, p_nocontrolador character varying, p_noaccion character varying, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_pagina_update_state_by_id(bigint, integer, integer); Type: FUNCTION; Schema: seguridad; Owner: postgres
--

CREATE FUNCTION seguridad.fn_pagina_update_state_by_id(p_copagina bigint, p_flestreg integer, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_rows integer;
BEGIN
    UPDATE seguridad.segpagina SET flestreg = p_flestreg::boolean, cousumod = p_cousumod, femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    WHERE copagina = p_copagina AND (flestreg IS DISTINCT FROM p_flestreg::boolean);
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION seguridad.fn_pagina_update_state_by_id(p_copagina bigint, p_flestreg integer, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_perfil_delete_by_id(bigint, integer); Type: FUNCTION; Schema: seguridad; Owner: postgres
--

CREATE FUNCTION seguridad.fn_perfil_delete_by_id(p_coperfil bigint, p_cousueli integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_rows integer; v_old JSONB;
BEGIN
	SELECT row_to_json(x) INTO v_old FROM seguridad.segperfil x WHERE coperfil = p_coperfil;
    CALL seguridad.usp_auditoria(-100, 'seguridad', 'segperfil', 'D', p_cousueli, jsonb_build_object('coperfil', p_coperfil), v_old, NULL);
    Delete From seguridad.segperfil WHERE coperfil = p_coperfil;
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION seguridad.fn_perfil_delete_by_id(p_coperfil bigint, p_cousueli integer) OWNER TO postgres;

--
-- Name: fn_perfil_insert(bigint, character varying, integer, integer, integer); Type: FUNCTION; Schema: seguridad; Owner: postgres
--

CREATE FUNCTION seguridad.fn_perfil_insert(p_comodulo bigint, p_noperfil character varying, p_fldefault integer, p_fladmin integer, p_cousucre integer) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
DECLARE v_coperfil BIGINT;
BEGIN
    IF p_fldefault = 1 THEN
        UPDATE seguridad.segperfil SET fldefault = false WHERE comodulo = p_comodulo;
    END IF;

	IF p_fladmin = 1 THEN
	    UPDATE seguridad.segperfil SET fladmin = false WHERE comodulo = p_comodulo;
	END IF;
	
    INSERT INTO seguridad.segperfil(comodulo, noperfil, fldefault, fladmin, cousucre)
    VALUES (p_comodulo, p_noperfil, p_fldefault::boolean, p_fladmin, p_cousucre)
	RETURNING coperfil INTO v_coperfil;
	RETURN v_coperfil;
END;
$$;


ALTER FUNCTION seguridad.fn_perfil_insert(p_comodulo bigint, p_noperfil character varying, p_fldefault integer, p_fladmin integer, p_cousucre integer) OWNER TO postgres;

--
-- Name: fn_perfil_sel_admin(bigint); Type: FUNCTION; Schema: seguridad; Owner: postgres
--

CREATE FUNCTION seguridad.fn_perfil_sel_admin(p_comodulo bigint) RETURNS bigint
    LANGUAGE sql STABLE
    AS $$
    SELECT coperfil FROM seguridad.segperfil
    WHERE comodulo = p_comodulo AND fladmin AND flestreg
    LIMIT 1;
$$;


ALTER FUNCTION seguridad.fn_perfil_sel_admin(p_comodulo bigint) OWNER TO postgres;

--
-- Name: fn_perfil_sel_all_active(bigint); Type: FUNCTION; Schema: seguridad; Owner: postgres
--

CREATE FUNCTION seguridad.fn_perfil_sel_all_active(p_comodulo bigint) RETURNS TABLE(coperfil bigint, noperfil character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
		perfil.coperfil,
		perfil.noperfil	
    FROM seguridad.segperfil perfil
    WHERE perfil.comodulo = p_comodulo 
		AND perfil.flestreg = true;
		
END;
$$;


ALTER FUNCTION seguridad.fn_perfil_sel_all_active(p_comodulo bigint) OWNER TO postgres;

--
-- Name: fn_perfil_sel_by_id(bigint, bigint); Type: FUNCTION; Schema: seguridad; Owner: postgres
--

CREATE FUNCTION seguridad.fn_perfil_sel_by_id(p_comodulo bigint, p_coperfil bigint) RETURNS TABLE(coperfil bigint, comodulo bigint, fldefault integer, fladmin integer, noperfil character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
		sp.coperfil,
		sp.comodulo,
		sp.fldefault::int,
		sp.fladmin::int,
		sp.noperfil
    FROM seguridad.segperfil sp WHERE sp.coperfil = p_coperfil AND sp.comodulo = p_comodulo;
END;
$$;


ALTER FUNCTION seguridad.fn_perfil_sel_by_id(p_comodulo bigint, p_coperfil bigint) OWNER TO postgres;

--
-- Name: fn_perfil_sel_default(bigint); Type: FUNCTION; Schema: seguridad; Owner: postgres
--

CREATE FUNCTION seguridad.fn_perfil_sel_default(p_comodulo bigint) RETURNS TABLE(coperfil bigint, comodulo bigint, noperfil character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
		sp.coperfil,
		sp.comodulo,		
		sp.noperfil		
    FROM seguridad.segperfil sp    
    WHERE sp.comodulo = p_comodulo AND sp.fldefault = true;
END;
$$;


ALTER FUNCTION seguridad.fn_perfil_sel_default(p_comodulo bigint) OWNER TO postgres;

--
-- Name: fn_perfil_update_by_id(bigint, bigint, character varying, integer, integer, integer); Type: FUNCTION; Schema: seguridad; Owner: postgres
--

CREATE FUNCTION seguridad.fn_perfil_update_by_id(p_comodulo bigint, p_coperfil bigint, p_noperfil character varying, p_fldefault integer, p_fladmin integer, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_rows integer;
BEGIN
    IF p_fldefault = 1 THEN
        UPDATE seguridad.segperfil SET fldefault = false WHERE comodulo = p_comodulo;
    END IF;


	IF p_fladmin = 1 THEN
	    UPDATE seguridad.segperfil SET fladmin = false WHERE comodulo = p_comodulo;
	END IF;
	
    UPDATE seguridad.segperfil
    SET 
		noperfil = p_noperfil,
		fldefault = p_fldefault::bool,
		fladmin = p_fladmin::bool,
		cousumod = p_cousumod, 
		femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    WHERE comodulo = p_comodulo AND coperfil = p_coperfil
		 AND (noperfil IS DISTINCT FROM p_noperfil AND fldefault IS DISTINCT FROM p_fldefault::bool);
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION seguridad.fn_perfil_update_by_id(p_comodulo bigint, p_coperfil bigint, p_noperfil character varying, p_fldefault integer, p_fladmin integer, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_perfil_update_state_by_id(bigint, bigint, integer, integer); Type: FUNCTION; Schema: seguridad; Owner: postgres
--

CREATE FUNCTION seguridad.fn_perfil_update_state_by_id(p_coperfil bigint, p_comodulo bigint, p_flestreg integer, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_rows integer;
BEGIN
    UPDATE seguridad.segperfil 
		SET flestreg = p_flestreg::bool, 
			cousumod = p_cousumod, 
			femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC'
    WHERE coperfil = p_coperfil 
		AND comodulo = p_comodulo 
		AND (flestreg IS DISTINCT FROM p_flestreg::bool);
		
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION seguridad.fn_perfil_update_state_by_id(p_coperfil bigint, p_comodulo bigint, p_flestreg integer, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_perfilpagina_delete_by_modulo_and_perfil(bigint, bigint, integer); Type: FUNCTION; Schema: seguridad; Owner: postgres
--

CREATE FUNCTION seguridad.fn_perfilpagina_delete_by_modulo_and_perfil(p_comodulo bigint, p_coperfil bigint, p_cousueli integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_rows integer; v_old JSONB;
BEGIN
	SELECT row_to_json(x) INTO v_old FROM seguridad.segperfilpagina x WHERE comodulo = p_comodulo And coperfil = p_coperfil;
    CALL seguridad.usp_auditoria(-100, 'seguridad', 'segperfilpagina', 'D', p_cousueli, jsonb_build_object('coperfil', p_coperfil), v_old, NULL);
    DELETE FROM seguridad.segperfilpagina WHERE comodulo = p_comodulo And coperfil = p_coperfil;
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION seguridad.fn_perfilpagina_delete_by_modulo_and_perfil(p_comodulo bigint, p_coperfil bigint, p_cousueli integer) OWNER TO postgres;

--
-- Name: fn_perfilpagina_insert(bigint, bigint, bigint, bigint, integer); Type: FUNCTION; Schema: seguridad; Owner: postgres
--

CREATE FUNCTION seguridad.fn_perfilpagina_insert(p_comodulo bigint, p_coperfil bigint, p_copagina bigint, p_comenu bigint, p_cousucre integer) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
DECLARE v_coperfilpagina BIGINT;
BEGIN
    insert into seguridad.segperfilpagina (comodulo, comenu, coperfil, copagina, cousucre)
    values (p_comodulo, p_comenu, p_coperfil, p_copagina, p_cousucre)
	RETURNING coperfilpagina INTO v_coperfilpagina;
	RETURN v_coperfilpagina;
END;
$$;


ALTER FUNCTION seguridad.fn_perfilpagina_insert(p_comodulo bigint, p_coperfil bigint, p_copagina bigint, p_comenu bigint, p_cousucre integer) OWNER TO postgres;

--
-- Name: fn_perfilpagina_sel_all(bigint, bigint); Type: FUNCTION; Schema: seguridad; Owner: postgres
--

CREATE FUNCTION seguridad.fn_perfilpagina_sel_all(p_comodulo bigint, p_coperfil bigint) RETURNS TABLE(coperfilpagina bigint, comodulo bigint, comenu bigint, coperfil bigint, copagina bigint)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT 
		sp.coperfilpagina,
		sp.comodulo,
		sp.comenu,
		sp.coperfil,
		sp.copagina
    FROM seguridad.segperfilpagina sp 
	WHERE sp.coperfil = p_coperfil 
	AND sp.comodulo = p_comodulo;
END;
$$;


ALTER FUNCTION seguridad.fn_perfilpagina_sel_all(p_comodulo bigint, p_coperfil bigint) OWNER TO postgres;

--
-- Name: fn_usuario_insert(bigint, character varying, character varying, integer); Type: FUNCTION; Schema: seguridad; Owner: postgres
--

CREATE FUNCTION seguridad.fn_usuario_insert(p_coentidad bigint, p_nousuario character varying, p_noclave character varying, p_cousucre integer) RETURNS bigint
    LANGUAGE plpgsql
    AS $$
DECLARE v_cousuario BIGINT;
BEGIN
    INSERT INTO seguridad.tblusuario(coentidad, nousuario, noclave, cousucre) VALUES (p_coentidad, p_nousuario, p_noclave, p_cousucre)
	RETURNING cousuario INTO v_cousuario;
	RETURN v_cousuario;
END;
$$;


ALTER FUNCTION seguridad.fn_usuario_insert(p_coentidad bigint, p_nousuario character varying, p_noclave character varying, p_cousucre integer) OWNER TO postgres;

--
-- Name: fn_usuario_sel_by_id(bigint); Type: FUNCTION; Schema: seguridad; Owner: postgres
--

CREATE FUNCTION seguridad.fn_usuario_sel_by_id(p_cousuario bigint) RETURNS TABLE(cousuario bigint, coentidad bigint, nousuario character varying, noclave character varying, noentidad character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
RETURN QUERY
      SELECT 
	  	u.cousuario,
		  u.coentidad, 
		  u.nousuario,
		  u.noclave,		  
		  u.noentidad
    FROM seguridad.vw_usuario u
    WHERE u.cousuario = p_cousuario;
End;
$$;


ALTER FUNCTION seguridad.fn_usuario_sel_by_id(p_cousuario bigint) OWNER TO postgres;

--
-- Name: fn_usuario_update_by_id(bigint, character varying, character varying, integer); Type: FUNCTION; Schema: seguridad; Owner: postgres
--

CREATE FUNCTION seguridad.fn_usuario_update_by_id(p_cousuario bigint, p_nousuario character varying, p_noclave character varying, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_rows integer;
BEGIN
    UPDATE seguridad.tblusuario
    SET nousuario = p_nousuario, noclave = p_noclave, femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC', cousumod = p_cousumod
    WHERE cousuario = p_cousuario AND (nousuario IS DISTINCT FROM p_nousuario AND noclave IS DISTINCT FROM p_noclave);
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION seguridad.fn_usuario_update_by_id(p_cousuario bigint, p_nousuario character varying, p_noclave character varying, p_cousumod integer) OWNER TO postgres;

--
-- Name: fn_usuario_update_clave_by_usuario(bigint, character varying, integer); Type: FUNCTION; Schema: seguridad; Owner: postgres
--

CREATE FUNCTION seguridad.fn_usuario_update_clave_by_usuario(p_cousuario bigint, p_noclave character varying, p_cousucre integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_rows integer;
BEGIN
    UPDATE seguridad.tblusuario SET noclave = p_noclave, femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC', cousumod = p_cousucre
    WHERE cousuario = p_cousuario AND (noclave IS DISTINCT FROM p_noclave);
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION seguridad.fn_usuario_update_clave_by_usuario(p_cousuario bigint, p_noclave character varying, p_cousucre integer) OWNER TO postgres;

--
-- Name: fn_usuario_update_state_by_id(bigint, integer, integer); Type: FUNCTION; Schema: seguridad; Owner: postgres
--

CREATE FUNCTION seguridad.fn_usuario_update_state_by_id(p_cousuario bigint, p_flestreg integer, p_cousumod integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE v_rows integer;
BEGIN
    UPDATE seguridad.tblusuario SET flestreg = p_flestreg::bool, femod = CURRENT_TIMESTAMP AT TIME ZONE 'UTC', cousumod = p_cousumod
    WHERE cousuario = p_cousuario AND (flestreg IS DISTINCT FROM p_flestreg::bool);
	GET DIAGNOSTICS v_rows = ROW_COUNT;
	RETURN v_rows;
END;
$$;


ALTER FUNCTION seguridad.fn_usuario_update_state_by_id(p_cousuario bigint, p_flestreg integer, p_cousumod integer) OWNER TO postgres;

--
-- Name: usp_auditoria(bigint, character varying, character varying, character, integer, jsonb, jsonb, jsonb); Type: PROCEDURE; Schema: seguridad; Owner: postgres
--

CREATE PROCEDURE seguridad.usp_auditoria(IN p_coempresa bigint, IN p_noesquema character varying, IN p_notabla character varying, IN p_noaccion character, IN p_cousuario integer, IN p_jbpk jsonb, IN p_jbdataold jsonb DEFAULT NULL::jsonb, IN p_jbdatanew jsonb DEFAULT NULL::jsonb)
    LANGUAGE plpgsql
    AS $$
DECLARE
   v_diferencias JSONB := '{}'::jsonb;
BEGIN
   IF p_noaccion = 'U' AND p_jbdataold IS NOT NULL AND p_jbdatanew IS NOT NULL THEN
        -- Guardamos solo las columnas que cambiaron
        SELECT COALESCE(
            jsonb_object_agg(n.key, jsonb_build_object('old', o.value, 'new', n.value)),
            '{}'::jsonb
        )
        INTO v_diferencias
        FROM jsonb_each(p_jbdatanew) n
        LEFT JOIN jsonb_each(p_jbdataold) o USING (key)
        WHERE o.value IS DISTINCT FROM n.value;

        INSERT INTO seguridad.audgeneral (
            coempresa, noesquema, notabla, noaccion, cousuario,
            jbpk, jbdataold, jbdatanew, feauditoria
        )
        VALUES (
            p_coempresa, p_noesquema, p_notabla, p_noaccion, p_cousuario,
            p_jbpk, p_jbdataold, v_diferencias, (CURRENT_TIMESTAMP AT TIME ZONE 'UTC')
        );

    ELSIF p_noaccion = 'D' AND p_jbdataold IS NOT NULL THEN
        -- Para delete guardamos el registro completo eliminado
        INSERT INTO seguridad.audgeneral (
            coempresa, noesquema, notabla, noaccion, cousuario,
            jbpk, jbdataold, jbdatanew, feauditoria
        )
        VALUES (
            p_coempresa, p_noesquema, p_notabla, p_noaccion, p_cousuario,
            p_jbpk, p_jbdataold, NULL, (CURRENT_TIMESTAMP AT TIME ZONE 'UTC')
        );
    END IF;
END;
$$;


ALTER PROCEDURE seguridad.usp_auditoria(IN p_coempresa bigint, IN p_noesquema character varying, IN p_notabla character varying, IN p_noaccion character, IN p_cousuario integer, IN p_jbpk jsonb, IN p_jbdataold jsonb, IN p_jbdatanew jsonb) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: tblatributo; Type: TABLE; Schema: catalogo; Owner: postgres
--

CREATE TABLE catalogo.tblatributo (
    coatributo bigint NOT NULL,
    coempresa bigint NOT NULL,
    noatributo character varying(100) NOT NULL,
    cotipodato smallint NOT NULL,
    fecre timestamp without time zone DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC'::text) NOT NULL,
    cocategoria smallint NOT NULL,
    nuorden smallint DEFAULT 0 NOT NULL,
    flobligatorio boolean DEFAULT false NOT NULL,
    flfiltrable boolean DEFAULT true NOT NULL,
    fldescriptivo boolean DEFAULT false NOT NULL,
    cousucre integer NOT NULL,
    flestreg boolean DEFAULT true NOT NULL,
    femod timestamp without time zone,
    cousumod integer
);


ALTER TABLE catalogo.tblatributo OWNER TO postgres;

--
-- Name: tblatributoseq; Type: SEQUENCE; Schema: catalogo; Owner: postgres
--

CREATE SEQUENCE catalogo.tblatributoseq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE catalogo.tblatributoseq OWNER TO postgres;

--
-- Name: tblatributoseq; Type: SEQUENCE OWNED BY; Schema: catalogo; Owner: postgres
--

ALTER SEQUENCE catalogo.tblatributoseq OWNED BY catalogo.tblatributo.coatributo;


--
-- Name: tblproductoseq; Type: SEQUENCE; Schema: catalogo; Owner: postgres
--

CREATE SEQUENCE catalogo.tblproductoseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE catalogo.tblproductoseq OWNER TO postgres;

--
-- Name: tblproducto; Type: TABLE; Schema: catalogo; Owner: postgres
--

CREATE TABLE catalogo.tblproducto (
    coempresa bigint NOT NULL,
    coproducto bigint DEFAULT nextval('catalogo.tblproductoseq'::regclass) NOT NULL,
    nocodigointerno character varying(12),
    comarca integer,
    colaboratorio integer,
    noproducto character varying(200),
    nomodelo character varying(50),
    counidadmedidainventario bigint NOT NULL,
    counidadmedidacompra bigint NOT NULL,
    counidadmedidaventa bigint NOT NULL,
    ssfactorcompra numeric(12,4) DEFAULT 1 NOT NULL,
    coproveedorprincipal bigint,
    txdescripcioncorta character varying(200),
    cousucre integer NOT NULL,
    cousumod integer,
    fecre timestamp without time zone DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC'::text) NOT NULL,
    femod timestamp without time zone,
    cocategoria integer,
    cocategoriahijo integer,
    cotipo integer NOT NULL,
    flimpuesto smallint DEFAULT 0 NOT NULL,
    flinventario smallint DEFAULT 1 NOT NULL,
    nocodigofiscal character varying(12),
    flestreg boolean DEFAULT true NOT NULL,
    ssfactorventa numeric(12,4) DEFAULT 1 NOT NULL,
    flimpuestoexento boolean DEFAULT false NOT NULL
);


ALTER TABLE catalogo.tblproducto OWNER TO postgres;

--
-- Name: tblproductoatributo; Type: TABLE; Schema: catalogo; Owner: postgres
--

CREATE TABLE catalogo.tblproductoatributo (
    coproductoatributo bigint NOT NULL,
    coproducto bigint NOT NULL,
    coatributo bigint NOT NULL,
    novalor text,
    coempresa bigint NOT NULL,
    fecre timestamp without time zone DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC'::text) NOT NULL,
    cousucre integer NOT NULL,
    femod timestamp without time zone,
    cousumod integer,
    flestreg boolean DEFAULT true NOT NULL
);


ALTER TABLE catalogo.tblproductoatributo OWNER TO postgres;

--
-- Name: tblproductoatributoseq; Type: SEQUENCE; Schema: catalogo; Owner: postgres
--

CREATE SEQUENCE catalogo.tblproductoatributoseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE catalogo.tblproductoatributoseq OWNER TO postgres;

--
-- Name: tblproductoatributoseq; Type: SEQUENCE OWNED BY; Schema: catalogo; Owner: postgres
--

ALTER SEQUENCE catalogo.tblproductoatributoseq OWNED BY catalogo.tblproductoatributo.coproductoatributo;


--
-- Name: tblproductoimpuesto; Type: TABLE; Schema: catalogo; Owner: postgres
--

CREATE TABLE catalogo.tblproductoimpuesto (
    coempresa bigint NOT NULL,
    coproductoimpuesto bigint NOT NULL,
    coproducto bigint NOT NULL,
    coimpuesto bigint NOT NULL,
    fecre timestamp without time zone DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC'::text) NOT NULL,
    cousucre integer NOT NULL,
    coimpuestohijo bigint,
    flestreg boolean DEFAULT true NOT NULL,
    pqtaza numeric(10,4) DEFAULT 0 NOT NULL
);


ALTER TABLE catalogo.tblproductoimpuesto OWNER TO postgres;

--
-- Name: tblproductoindex; Type: TABLE; Schema: catalogo; Owner: postgres
--

CREATE TABLE catalogo.tblproductoindex (
    coproductoindex bigint NOT NULL,
    coempresa bigint NOT NULL,
    coproducto bigint NOT NULL,
    noproducto character varying(200),
    txdescripcioncorta character varying(300),
    jsonatributo jsonb,
    txbusqueda tsvector,
    cocategoria integer NOT NULL
);


ALTER TABLE catalogo.tblproductoindex OWNER TO postgres;

--
-- Name: tblproductoindexseq; Type: SEQUENCE; Schema: catalogo; Owner: postgres
--

CREATE SEQUENCE catalogo.tblproductoindexseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE catalogo.tblproductoindexseq OWNER TO postgres;

--
-- Name: tblproductoindexseq; Type: SEQUENCE OWNED BY; Schema: catalogo; Owner: postgres
--

ALTER SEQUENCE catalogo.tblproductoindexseq OWNED BY catalogo.tblproductoindex.coproductoindex;


--
-- Name: tblproductompuestoseq; Type: SEQUENCE; Schema: catalogo; Owner: postgres
--

CREATE SEQUENCE catalogo.tblproductompuestoseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE catalogo.tblproductompuestoseq OWNER TO postgres;

--
-- Name: tblproductompuestoseq; Type: SEQUENCE OWNED BY; Schema: catalogo; Owner: postgres
--

ALTER SEQUENCE catalogo.tblproductompuestoseq OWNED BY catalogo.tblproductoimpuesto.coproductoimpuesto;


--
-- Name: tblproductoprecioseq; Type: SEQUENCE; Schema: catalogo; Owner: postgres
--

CREATE SEQUENCE catalogo.tblproductoprecioseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE catalogo.tblproductoprecioseq OWNER TO postgres;

--
-- Name: tblproductoprecio; Type: TABLE; Schema: catalogo; Owner: postgres
--

CREATE TABLE catalogo.tblproductoprecio (
    coempresa bigint NOT NULL,
    coproductoprecio bigint DEFAULT nextval('catalogo.tblproductoprecioseq'::regclass) NOT NULL,
    cotipoprecio smallint NOT NULL,
    coproducto bigint NOT NULL,
    ssprecio numeric(14,6) NOT NULL,
    cousucre integer NOT NULL,
    cousumod integer,
    fecre timestamp without time zone DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC'::text) NOT NULL,
    femod timestamp without time zone,
    flestreg boolean DEFAULT true NOT NULL,
    comoneda bigint NOT NULL
);


ALTER TABLE catalogo.tblproductoprecio OWNER TO postgres;

--
-- Name: tblproductostockseq; Type: SEQUENCE; Schema: catalogo; Owner: postgres
--

CREATE SEQUENCE catalogo.tblproductostockseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE catalogo.tblproductostockseq OWNER TO postgres;

--
-- Name: tblproductostock; Type: TABLE; Schema: catalogo; Owner: postgres
--

CREATE TABLE catalogo.tblproductostock (
    coempresa bigint NOT NULL,
    coproductostock bigint DEFAULT nextval('catalogo.tblproductostockseq'::regclass) NOT NULL,
    coproducto bigint NOT NULL,
    colocal bigint NOT NULL,
    coalmacen bigint NOT NULL,
    qtinicial integer NOT NULL,
    qtmaxima integer NOT NULL,
    qtminima integer NOT NULL,
    cousucre integer NOT NULL,
    cousumod integer,
    fecre timestamp without time zone DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC'::text) NOT NULL,
    femod timestamp without time zone,
    flestreg boolean DEFAULT true NOT NULL,
    fldefault boolean DEFAULT false NOT NULL
);


ALTER TABLE catalogo.tblproductostock OWNER TO postgres;

--
-- Name: tblproductoterminadoseq; Type: SEQUENCE; Schema: catalogo; Owner: postgres
--

CREATE SEQUENCE catalogo.tblproductoterminadoseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE catalogo.tblproductoterminadoseq OWNER TO postgres;

--
-- Name: tblproductoterminado; Type: TABLE; Schema: catalogo; Owner: postgres
--

CREATE TABLE catalogo.tblproductoterminado (
    coempresa bigint NOT NULL,
    coproductoterminado bigint DEFAULT nextval('catalogo.tblproductoterminadoseq'::regclass) NOT NULL,
    coproductopadre bigint,
    nuorden smallint NOT NULL,
    coproducto bigint NOT NULL,
    qtproducto integer NOT NULL,
    cousucre integer NOT NULL,
    cousumod integer,
    fecre timestamp without time zone DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC'::text) NOT NULL,
    femod timestamp without time zone,
    flestreg boolean DEFAULT true NOT NULL
);


ALTER TABLE catalogo.tblproductoterminado OWNER TO postgres;

--
-- Name: trftipogeneral; Type: TABLE; Schema: maestro; Owner: postgres
--

CREATE TABLE maestro.trftipogeneral (
    cogrupo bigint NOT NULL,
    nuorden smallint CONSTRAINT trftipogeneral_cotipo_not_null NOT NULL,
    comodulo bigint NOT NULL,
    notipo character varying(150) NOT NULL,
    nosigla character varying(5),
    fecre timestamp without time zone DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC'::text) NOT NULL,
    nocomando character varying(50),
    flestreg boolean DEFAULT true NOT NULL,
    fldelete boolean DEFAULT false NOT NULL,
    fldefault boolean DEFAULT false NOT NULL,
    valor jsonb,
    cotipogeneral bigint NOT NULL
);


ALTER TABLE maestro.trftipogeneral OWNER TO postgres;

--
-- Name: trftipoparticular; Type: TABLE; Schema: maestro; Owner: postgres
--

CREATE TABLE maestro.trftipoparticular (
    cogrupo bigint NOT NULL,
    nuorden smallint CONSTRAINT trftipoparticular_cotipo_not_null NOT NULL,
    coempresa bigint NOT NULL,
    comodulo bigint NOT NULL,
    notipo character varying(150) NOT NULL,
    txdescripcion character varying(1000),
    nosigla character varying(5),
    cogrupopadre bigint,
    cotipoparticularpadre bigint,
    nocomando character varying(50),
    cousucre integer DEFAULT '-100'::integer,
    cousumod integer,
    cousueli integer,
    fecre timestamp without time zone DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC'::text) NOT NULL,
    femod timestamp without time zone,
    feeli timestamp without time zone,
    fldelete boolean DEFAULT false NOT NULL,
    fldefault boolean DEFAULT false NOT NULL,
    flestreg boolean DEFAULT true NOT NULL,
    cotipoparticular bigint NOT NULL
);


ALTER TABLE maestro.trftipoparticular OWNER TO postgres;

--
-- Name: trfunidadmedida; Type: TABLE; Schema: maestro; Owner: postgres
--

CREATE TABLE maestro.trfunidadmedida (
    counidadmedida bigint NOT NULL,
    copais bigint NOT NULL,
    nocodigoiso character varying(10) NOT NULL,
    nounidadmedida character varying(150) NOT NULL,
    nosimbolo character varying(10) NOT NULL,
    flestreg boolean DEFAULT true NOT NULL
);


ALTER TABLE maestro.trfunidadmedida OWNER TO postgres;

--
-- Name: vw_producto; Type: VIEW; Schema: catalogo; Owner: postgres
--

CREATE VIEW catalogo.vw_producto AS
 SELECT p.coempresa,
    p.coproducto,
    p.nocodigointerno,
    p.nocodigofiscal,
    p.cocategoria,
    p.cocategoriahijo,
    p.cotipo,
    p.comarca,
    p.colaboratorio,
    p.noproducto,
    p.nomodelo,
    p.counidadmedidainventario,
    p.counidadmedidacompra,
    p.counidadmedidaventa,
    p.ssfactorcompra,
    p.ssfactorventa,
    p.coproveedorprincipal,
    p.txdescripcioncorta,
    (p.flimpuesto)::integer AS flimpuesto,
    (p.flinventario)::integer AS flinventario,
    (p.flimpuestoexento)::integer AS flimpuestoexento,
    (p.flestreg)::integer AS flestreg,
    laboratorio.notipo AS nolaboratorio,
    marca.notipo AS nomarca,
    unidadmedidainventario.nounidadmedida AS nounidadmedidainventario,
    unidadmedidacompra.nounidadmedida AS nounidadmedidacompra,
    counidadmedidaventa.nounidadmedida AS nounidadmedidaventa,
    tipo.notipo,
    categoria.notipo AS nocatagoria,
    categoriahijo.notipo AS nocategoriahijo
   FROM ((((((((catalogo.tblproducto p
     LEFT JOIN maestro.trftipogeneral tipo ON ((p.cotipo = tipo.cotipogeneral)))
     LEFT JOIN maestro.trftipoparticular categoria ON ((p.cocategoria = categoria.cotipoparticular)))
     LEFT JOIN maestro.trftipoparticular categoriahijo ON ((p.cocategoriahijo = categoriahijo.cotipoparticular)))
     LEFT JOIN maestro.trftipoparticular laboratorio ON ((p.colaboratorio = laboratorio.cotipoparticular)))
     LEFT JOIN maestro.trftipoparticular marca ON ((p.comarca = marca.cotipoparticular)))
     LEFT JOIN maestro.trfunidadmedida unidadmedidainventario ON ((p.counidadmedidainventario = unidadmedidainventario.counidadmedida)))
     LEFT JOIN maestro.trfunidadmedida unidadmedidacompra ON ((p.counidadmedidacompra = unidadmedidacompra.counidadmedida)))
     LEFT JOIN maestro.trfunidadmedida counidadmedidaventa ON ((p.counidadmedidaventa = counidadmedidaventa.counidadmedida)));


ALTER VIEW catalogo.vw_producto OWNER TO postgres;

--
-- Name: trfimpuesto; Type: TABLE; Schema: contabilidad; Owner: postgres
--

CREATE TABLE contabilidad.trfimpuesto (
    coimpuesto bigint NOT NULL,
    nocodigo character varying(5) NOT NULL,
    noimpuesto character varying(150) NOT NULL,
    notipo character varying(20) NOT NULL,
    pqtasa numeric(7,4),
    flestreg boolean DEFAULT true NOT NULL,
    copais bigint NOT NULL,
    fecre timestamp without time zone DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC'::text) NOT NULL
);


ALTER TABLE contabilidad.trfimpuesto OWNER TO postgres;

--
-- Name: impuesto_impuesto_id_seq; Type: SEQUENCE; Schema: contabilidad; Owner: postgres
--

CREATE SEQUENCE contabilidad.impuesto_impuesto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE contabilidad.impuesto_impuesto_id_seq OWNER TO postgres;

--
-- Name: impuesto_impuesto_id_seq; Type: SEQUENCE OWNED BY; Schema: contabilidad; Owner: postgres
--

ALTER SEQUENCE contabilidad.impuesto_impuesto_id_seq OWNED BY contabilidad.trfimpuesto.coimpuesto;


--
-- Name: trfimpuestohijo; Type: TABLE; Schema: contabilidad; Owner: postgres
--

CREATE TABLE contabilidad.trfimpuestohijo (
    coimpuestohijo bigint NOT NULL,
    coimpuesto bigint NOT NULL,
    nocodigo character varying(10) NOT NULL,
    noimpuestohijo character varying(200) NOT NULL,
    nometodo character varying(20) NOT NULL,
    pqtasa numeric(7,4),
    ssmonto numeric(12,4),
    flestreg boolean DEFAULT true NOT NULL,
    counidadmedida bigint,
    copais bigint NOT NULL
);


ALTER TABLE contabilidad.trfimpuestohijo OWNER TO postgres;

--
-- Name: isc_subtipo_isc_subtipo_id_seq; Type: SEQUENCE; Schema: contabilidad; Owner: postgres
--

CREATE SEQUENCE contabilidad.isc_subtipo_isc_subtipo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE contabilidad.isc_subtipo_isc_subtipo_id_seq OWNER TO postgres;

--
-- Name: isc_subtipo_isc_subtipo_id_seq; Type: SEQUENCE OWNED BY; Schema: contabilidad; Owner: postgres
--

ALTER SEQUENCE contabilidad.isc_subtipo_isc_subtipo_id_seq OWNED BY contabilidad.trfimpuestohijo.coimpuestohijo;


--
-- Name: trftipocambioseq; Type: SEQUENCE; Schema: contabilidad; Owner: postgres
--

CREATE SEQUENCE contabilidad.trftipocambioseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE contabilidad.trftipocambioseq OWNER TO postgres;

--
-- Name: tbltipocambio; Type: TABLE; Schema: contabilidad; Owner: postgres
--

CREATE TABLE contabilidad.tbltipocambio (
    coempresa bigint NOT NULL,
    cotipocambio bigint DEFAULT nextval('contabilidad.trftipocambioseq'::regclass) NOT NULL,
    comonedaorigen bigint NOT NULL,
    sscompra numeric(20,8) CONSTRAINT tbltipocambio_sstcompra_not_null NOT NULL,
    ssventa numeric(20,8) NOT NULL,
    cousucre integer NOT NULL,
    fecre timestamp without time zone DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC'::text) NOT NULL,
    flestreg boolean DEFAULT true NOT NULL,
    flautomatico boolean DEFAULT false NOT NULL,
    femod timestamp without time zone,
    cousumod integer,
    comonedadestino bigint NOT NULL,
    cofuente smallint NOT NULL,
    fetipocambio date NOT NULL
);


ALTER TABLE contabilidad.tbltipocambio OWNER TO postgres;

--
-- Name: trfclasificacionfiscal; Type: TABLE; Schema: contabilidad; Owner: postgres
--

CREATE TABLE contabilidad.trfclasificacionfiscal (
    coclasificacionfiscal bigint NOT NULL,
    copais bigint NOT NULL,
    nocodigo character varying(10) NOT NULL,
    noclasificacionfiscal character varying(100) NOT NULL,
    fecre timestamp without time zone DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC'::text) NOT NULL,
    flestreg boolean DEFAULT true NOT NULL
);


ALTER TABLE contabilidad.trfclasificacionfiscal OWNER TO postgres;

--
-- Name: trfclasificacionfiscal_coclasificacionfiscal_seq; Type: SEQUENCE; Schema: contabilidad; Owner: postgres
--

CREATE SEQUENCE contabilidad.trfclasificacionfiscal_coclasificacionfiscal_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE contabilidad.trfclasificacionfiscal_coclasificacionfiscal_seq OWNER TO postgres;

--
-- Name: trfclasificacionfiscal_coclasificacionfiscal_seq; Type: SEQUENCE OWNED BY; Schema: contabilidad; Owner: postgres
--

ALTER SEQUENCE contabilidad.trfclasificacionfiscal_coclasificacionfiscal_seq OWNED BY contabilidad.trfclasificacionfiscal.coclasificacionfiscal;


--
-- Name: trfcomprobantepago; Type: TABLE; Schema: contabilidad; Owner: postgres
--

CREATE TABLE contabilidad.trfcomprobantepago (
    cocomprobantepago bigint NOT NULL,
    copais bigint NOT NULL,
    nocodigo character varying(10) NOT NULL,
    nocomprobantepago character varying(100) NOT NULL,
    nocomprobantepagosigla character varying(5),
    flestreg boolean DEFAULT true NOT NULL,
    fecre timestamp without time zone DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC'::text) NOT NULL
);


ALTER TABLE contabilidad.trfcomprobantepago OWNER TO postgres;

--
-- Name: trfcomprobantepago_cocomprobantepago_seq; Type: SEQUENCE; Schema: contabilidad; Owner: postgres
--

CREATE SEQUENCE contabilidad.trfcomprobantepago_cocomprobantepago_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE contabilidad.trfcomprobantepago_cocomprobantepago_seq OWNER TO postgres;

--
-- Name: trfcomprobantepago_cocomprobantepago_seq; Type: SEQUENCE OWNED BY; Schema: contabilidad; Owner: postgres
--

ALTER SEQUENCE contabilidad.trfcomprobantepago_cocomprobantepago_seq OWNED BY contabilidad.trfcomprobantepago.cocomprobantepago;


--
-- Name: trfmediopago; Type: TABLE; Schema: contabilidad; Owner: postgres
--

CREATE TABLE contabilidad.trfmediopago (
    comediopago bigint NOT NULL,
    copais bigint NOT NULL,
    nocodigo character varying(10) NOT NULL,
    nomediopago character varying(100) NOT NULL,
    flestreg boolean DEFAULT true NOT NULL
);


ALTER TABLE contabilidad.trfmediopago OWNER TO postgres;

--
-- Name: trfformapago_coformapago_seq; Type: SEQUENCE; Schema: contabilidad; Owner: postgres
--

CREATE SEQUENCE contabilidad.trfformapago_coformapago_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE contabilidad.trfformapago_coformapago_seq OWNER TO postgres;

--
-- Name: trfformapago_coformapago_seq; Type: SEQUENCE OWNED BY; Schema: contabilidad; Owner: postgres
--

ALTER SEQUENCE contabilidad.trfformapago_coformapago_seq OWNED BY contabilidad.trfmediopago.comediopago;


--
-- Name: trfmotivonotacredito; Type: TABLE; Schema: contabilidad; Owner: postgres
--

CREATE TABLE contabilidad.trfmotivonotacredito (
    comotivonotacredito bigint NOT NULL,
    copais bigint NOT NULL,
    nocodigo character varying(10) NOT NULL,
    nomotivonotacredito character varying(150) NOT NULL,
    flestreg boolean DEFAULT true NOT NULL
);


ALTER TABLE contabilidad.trfmotivonotacredito OWNER TO postgres;

--
-- Name: trfmotivonotacredito_comotivonotacredito_seq; Type: SEQUENCE; Schema: contabilidad; Owner: postgres
--

CREATE SEQUENCE contabilidad.trfmotivonotacredito_comotivonotacredito_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE contabilidad.trfmotivonotacredito_comotivonotacredito_seq OWNER TO postgres;

--
-- Name: trfmotivonotacredito_comotivonotacredito_seq; Type: SEQUENCE OWNED BY; Schema: contabilidad; Owner: postgres
--

ALTER SEQUENCE contabilidad.trfmotivonotacredito_comotivonotacredito_seq OWNED BY contabilidad.trfmotivonotacredito.comotivonotacredito;


--
-- Name: trfplancontableseq; Type: SEQUENCE; Schema: contabilidad; Owner: postgres
--

CREATE SEQUENCE contabilidad.trfplancontableseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE contabilidad.trfplancontableseq OWNER TO postgres;

--
-- Name: tblbandejaentradaseq; Type: SEQUENCE; Schema: empresa; Owner: postgres
--

CREATE SEQUENCE empresa.tblbandejaentradaseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE empresa.tblbandejaentradaseq OWNER TO postgres;

--
-- Name: tblbandejaentrada; Type: TABLE; Schema: empresa; Owner: postgres
--

CREATE TABLE empresa.tblbandejaentrada (
    coempresa bigint NOT NULL,
    cobandejaentrada bigint DEFAULT nextval('empresa.tblbandejaentradaseq'::regclass) NOT NULL,
    nopersona character varying(150) NOT NULL,
    noemail character varying(70),
    notelefono character varying(50),
    noasunto character varying(100),
    coservicio integer,
    nomensaje character varying(500) NOT NULL,
    coetiqueta integer,
    cousucre integer NOT NULL,
    fecre timestamp without time zone DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC'::text) NOT NULL,
    cousumod integer,
    femod timestamp without time zone,
    flfavorito boolean DEFAULT false NOT NULL,
    flestreg boolean DEFAULT true NOT NULL
);


ALTER TABLE empresa.tblbandejaentrada OWNER TO postgres;

--
-- Name: tblblogseq; Type: SEQUENCE; Schema: empresa; Owner: postgres
--

CREATE SEQUENCE empresa.tblblogseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE empresa.tblblogseq OWNER TO postgres;

--
-- Name: tblblog; Type: TABLE; Schema: empresa; Owner: postgres
--

CREATE TABLE empresa.tblblog (
    coempresa bigint NOT NULL,
    coblog bigint DEFAULT nextval('empresa.tblblogseq'::regclass) NOT NULL,
    coservicio integer,
    cosubservicio integer,
    notitulo character varying(150),
    txblog character varying(2500),
    noideacentral character varying(200),
    feblog character varying(8) NOT NULL,
    coautor integer NOT NULL,
    cousucre integer NOT NULL,
    fecre timestamp without time zone DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC'::text) NOT NULL,
    cousumod integer,
    femod timestamp without time zone,
    flestreg boolean DEFAULT true NOT NULL
);


ALTER TABLE empresa.tblblog OWNER TO postgres;

--
-- Name: tblblogmensajeseq; Type: SEQUENCE; Schema: empresa; Owner: postgres
--

CREATE SEQUENCE empresa.tblblogmensajeseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE empresa.tblblogmensajeseq OWNER TO postgres;

--
-- Name: tblblogmensaje; Type: TABLE; Schema: empresa; Owner: postgres
--

CREATE TABLE empresa.tblblogmensaje (
    coempresa bigint NOT NULL,
    coblog bigint NOT NULL,
    coblogmensaje bigint DEFAULT nextval('empresa.tblblogmensajeseq'::regclass) NOT NULL,
    nopersona character varying(150),
    nomensaje character varying(500),
    noemail character varying(100),
    cousucre integer NOT NULL,
    fecre timestamp without time zone DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC'::text) NOT NULL
);


ALTER TABLE empresa.tblblogmensaje OWNER TO postgres;

--
-- Name: tblclienteseq; Type: SEQUENCE; Schema: empresa; Owner: postgres
--

CREATE SEQUENCE empresa.tblclienteseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE empresa.tblclienteseq OWNER TO postgres;

--
-- Name: tblcliente; Type: TABLE; Schema: empresa; Owner: postgres
--

CREATE TABLE empresa.tblcliente (
    coempresa bigint NOT NULL,
    cocliente bigint DEFAULT nextval('empresa.tblclienteseq'::regclass) NOT NULL,
    nocliente character varying(150),
    nocargo character varying(50),
    txopinion character varying(300),
    cousucre integer NOT NULL,
    fecre timestamp without time zone DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC'::text) NOT NULL,
    flestreg boolean DEFAULT true NOT NULL,
    flopinion boolean DEFAULT true NOT NULL
);


ALTER TABLE empresa.tblcliente OWNER TO postgres;

--
-- Name: tblequiposeq; Type: SEQUENCE; Schema: empresa; Owner: postgres
--

CREATE SEQUENCE empresa.tblequiposeq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE empresa.tblequiposeq OWNER TO postgres;

--
-- Name: tblequipo; Type: TABLE; Schema: empresa; Owner: postgres
--

CREATE TABLE empresa.tblequipo (
    coempresa bigint NOT NULL,
    coequipo bigint DEFAULT nextval('empresa.tblequiposeq'::regclass) NOT NULL,
    coprofesional bigint CONSTRAINT tblequipo_copersona_not_null NOT NULL,
    noextracto character varying(1500),
    cousucre integer NOT NULL,
    fecre timestamp without time zone DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC'::text) NOT NULL,
    flestreg boolean DEFAULT true NOT NULL
);


ALTER TABLE empresa.tblequipo OWNER TO postgres;

--
-- Name: tblhorarioseq; Type: SEQUENCE; Schema: empresa; Owner: postgres
--

CREATE SEQUENCE empresa.tblhorarioseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE empresa.tblhorarioseq OWNER TO postgres;

--
-- Name: tblhorario; Type: TABLE; Schema: empresa; Owner: postgres
--

CREATE TABLE empresa.tblhorario (
    coempresa bigint NOT NULL,
    cohorario bigint DEFAULT nextval('empresa.tblhorarioseq'::regclass) NOT NULL,
    codia integer,
    hoinicio character varying(5),
    hofinal character varying(5),
    cousucre integer NOT NULL,
    fecre timestamp without time zone DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC'::text) NOT NULL,
    flestreg boolean DEFAULT true NOT NULL
);


ALTER TABLE empresa.tblhorario OWNER TO postgres;

--
-- Name: tblimagenwebseq; Type: SEQUENCE; Schema: empresa; Owner: postgres
--

CREATE SEQUENCE empresa.tblimagenwebseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE empresa.tblimagenwebseq OWNER TO postgres;

--
-- Name: trflocalseq; Type: SEQUENCE; Schema: empresa; Owner: postgres
--

CREATE SEQUENCE empresa.trflocalseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE empresa.trflocalseq OWNER TO postgres;

--
-- Name: tbllocal; Type: TABLE; Schema: empresa; Owner: postgres
--

CREATE TABLE empresa.tbllocal (
    colocal bigint DEFAULT nextval('empresa.trflocalseq'::regclass) NOT NULL,
    coempresa bigint NOT NULL,
    nolocal character varying(150),
    nodireccion character varying(300),
    nocodigopostal character varying(50),
    cousucre integer NOT NULL,
    fecre timestamp without time zone DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC'::text) NOT NULL,
    coubigeo bigint,
    flprincipal boolean DEFAULT true NOT NULL,
    flestreg boolean DEFAULT true NOT NULL
);


ALTER TABLE empresa.tbllocal OWNER TO postgres;

--
-- Name: tblpreguntaseq; Type: SEQUENCE; Schema: empresa; Owner: postgres
--

CREATE SEQUENCE empresa.tblpreguntaseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE empresa.tblpreguntaseq OWNER TO postgres;

--
-- Name: tblpregunta; Type: TABLE; Schema: empresa; Owner: postgres
--

CREATE TABLE empresa.tblpregunta (
    coempresa bigint NOT NULL,
    copregunta bigint DEFAULT nextval('empresa.tblpreguntaseq'::regclass) NOT NULL,
    nuorden smallint NOT NULL,
    nopregunta character varying(200) NOT NULL,
    norespuesta character varying(1500),
    cousucre integer NOT NULL,
    fecre timestamp without time zone DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC'::text) NOT NULL,
    flestreg boolean DEFAULT true NOT NULL
);


ALTER TABLE empresa.tblpregunta OWNER TO postgres;

--
-- Name: tblservicioseq; Type: SEQUENCE; Schema: empresa; Owner: postgres
--

CREATE SEQUENCE empresa.tblservicioseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE empresa.tblservicioseq OWNER TO postgres;

--
-- Name: tblservicio; Type: TABLE; Schema: empresa; Owner: postgres
--

CREATE TABLE empresa.tblservicio (
    coempresa bigint NOT NULL,
    coservicio bigint DEFAULT nextval('empresa.tblservicioseq'::regclass) NOT NULL,
    cotipo integer,
    cosubtipo integer,
    notitulo character varying(100),
    txdescripcion character varying(2500),
    txdescripcioncorta character varying(200),
    cousucre integer NOT NULL,
    fecre timestamp without time zone DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC'::text) NOT NULL,
    flestreg boolean DEFAULT true NOT NULL,
    flmuestraimagen boolean DEFAULT true NOT NULL
);


ALTER TABLE empresa.tblservicio OWNER TO postgres;

--
-- Name: tblserviciocaracteristicaseq; Type: SEQUENCE; Schema: empresa; Owner: postgres
--

CREATE SEQUENCE empresa.tblserviciocaracteristicaseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE empresa.tblserviciocaracteristicaseq OWNER TO postgres;

--
-- Name: tblserviciocaracteristica; Type: TABLE; Schema: empresa; Owner: postgres
--

CREATE TABLE empresa.tblserviciocaracteristica (
    coempresa bigint NOT NULL,
    coserviciocaracteristica bigint DEFAULT nextval('empresa.tblserviciocaracteristicaseq'::regclass) NOT NULL,
    coservicio integer NOT NULL,
    nuorden smallint NOT NULL,
    notitulo character varying(100),
    txdescripcion character varying(2500),
    cousucre integer NOT NULL,
    fecre timestamp without time zone DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC'::text) NOT NULL,
    flestreg boolean DEFAULT true NOT NULL
);


ALTER TABLE empresa.tblserviciocaracteristica OWNER TO postgres;

--
-- Name: tblcompraseq; Type: SEQUENCE; Schema: facturacion; Owner: postgres
--

CREATE SEQUENCE facturacion.tblcompraseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE facturacion.tblcompraseq OWNER TO postgres;

--
-- Name: tblcompra; Type: TABLE; Schema: facturacion; Owner: postgres
--

CREATE TABLE facturacion.tblcompra (
    coempresa bigint NOT NULL,
    cocompra bigint DEFAULT nextval('facturacion.tblcompraseq'::regclass) NOT NULL,
    colocal bigint NOT NULL,
    cocomprobantepago bigint NOT NULL,
    nuserie character varying(10),
    nudocumento character varying(20),
    fecompra date NOT NULL,
    fevencimiento date,
    comoneda bigint NOT NULL,
    cotipocambio bigint NOT NULL,
    coproveedor bigint NOT NULL,
    ssprecio numeric(14,4),
    ssimpuesto numeric(14,4),
    ssdescuento numeric(14,4),
    nunotaentrada integer,
    comodopago smallint NOT NULL,
    comediopago smallint,
    codocpago bigint,
    txdescripcion character varying(300),
    cousucre integer NOT NULL,
    cousumod integer,
    fecre timestamp without time zone DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC'::text) NOT NULL,
    femod timestamp without time zone,
    flestreg boolean DEFAULT true NOT NULL,
    flimpuestoincluyeprecio boolean DEFAULT false NOT NULL
);


ALTER TABLE facturacion.tblcompra OWNER TO postgres;

--
-- Name: tblcompradetalleseq; Type: SEQUENCE; Schema: facturacion; Owner: postgres
--

CREATE SEQUENCE facturacion.tblcompradetalleseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE facturacion.tblcompradetalleseq OWNER TO postgres;

--
-- Name: tblcompradetalle; Type: TABLE; Schema: facturacion; Owner: postgres
--

CREATE TABLE facturacion.tblcompradetalle (
    coempresa bigint NOT NULL,
    cocompradetalle bigint DEFAULT nextval('facturacion.tblcompradetalleseq'::regclass) NOT NULL,
    cocompra bigint NOT NULL,
    nuorden smallint NOT NULL,
    coproducto bigint NOT NULL,
    qtproducto integer NOT NULL,
    ssprecioingresado numeric(14,4),
    ssprecio numeric(14,4),
    pqdescuento numeric(14,4),
    ssdescuento numeric(14,4),
    ssimpuesto numeric(14,4),
    sspreciototal numeric(14,4),
    colocal bigint,
    coalmacen bigint,
    cousucre integer NOT NULL,
    cousumod integer,
    fecre timestamp without time zone DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC'::text) NOT NULL,
    femod timestamp without time zone,
    flestreg boolean DEFAULT true NOT NULL
);


ALTER TABLE facturacion.tblcompradetalle OWNER TO postgres;

--
-- Name: tblcompradetalleimpuesto; Type: TABLE; Schema: facturacion; Owner: postgres
--

CREATE TABLE facturacion.tblcompradetalleimpuesto (
    coempresa bigint NOT NULL,
    cocompradetalleimpuesto bigint NOT NULL,
    cocompradetalle bigint NOT NULL,
    coimpuesto bigint NOT NULL,
    ssmonto numeric(14,4) NOT NULL,
    pqtaza numeric(14,4) NOT NULL,
    coimpuestohijo bigint
);


ALTER TABLE facturacion.tblcompradetalleimpuesto OWNER TO postgres;

--
-- Name: tblcompradetalleimpuesto_cocompradetalleimpuesto_seq; Type: SEQUENCE; Schema: facturacion; Owner: postgres
--

CREATE SEQUENCE facturacion.tblcompradetalleimpuesto_cocompradetalleimpuesto_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE facturacion.tblcompradetalleimpuesto_cocompradetalleimpuesto_seq OWNER TO postgres;

--
-- Name: tblcompradetalleimpuesto_cocompradetalleimpuesto_seq; Type: SEQUENCE OWNED BY; Schema: facturacion; Owner: postgres
--

ALTER SEQUENCE facturacion.tblcompradetalleimpuesto_cocompradetalleimpuesto_seq OWNED BY facturacion.tblcompradetalleimpuesto.cocompradetalleimpuesto;


--
-- Name: tblcorrelativoseq; Type: SEQUENCE; Schema: facturacion; Owner: postgres
--

CREATE SEQUENCE facturacion.tblcorrelativoseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE facturacion.tblcorrelativoseq OWNER TO postgres;

--
-- Name: tblcorrelativo; Type: TABLE; Schema: facturacion; Owner: postgres
--

CREATE TABLE facturacion.tblcorrelativo (
    coempresa bigint NOT NULL,
    cocorrelativo bigint DEFAULT nextval('facturacion.tblcorrelativoseq'::regclass) NOT NULL,
    colocal bigint NOT NULL,
    cocomprobantepago bigint NOT NULL,
    nuserie character varying(5),
    nudocumento integer NOT NULL,
    fecre timestamp without time zone DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC'::text) NOT NULL,
    femod timestamp without time zone,
    cousucre integer NOT NULL,
    cousumod integer,
    flestreg boolean DEFAULT true NOT NULL,
    fldefault boolean DEFAULT false CONSTRAINT tblcorrelativo_fldefecto_not_null NOT NULL
);


ALTER TABLE facturacion.tblcorrelativo OWNER TO postgres;

--
-- Name: tblproformaseq; Type: SEQUENCE; Schema: facturacion; Owner: postgres
--

CREATE SEQUENCE facturacion.tblproformaseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE facturacion.tblproformaseq OWNER TO postgres;

--
-- Name: tblproforma; Type: TABLE; Schema: facturacion; Owner: postgres
--

CREATE TABLE facturacion.tblproforma (
    coempresa bigint NOT NULL,
    coproforma bigint DEFAULT nextval('facturacion.tblproformaseq'::regclass) NOT NULL,
    colocal bigint NOT NULL,
    nuserie integer NOT NULL,
    nudocumento integer NOT NULL,
    feventa date,
    comoneda bigint NOT NULL,
    cocliente bigint NOT NULL,
    ssprecio numeric(14,4),
    ssimpuesto numeric(14,4),
    ssdescuento numeric(14,4),
    txdescripcion character varying(200),
    cousucre integer NOT NULL,
    cousumod integer,
    fecre timestamp without time zone DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC'::text) NOT NULL,
    femod timestamp without time zone
);


ALTER TABLE facturacion.tblproforma OWNER TO postgres;

--
-- Name: tblproformadetalleseq; Type: SEQUENCE; Schema: facturacion; Owner: postgres
--

CREATE SEQUENCE facturacion.tblproformadetalleseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE facturacion.tblproformadetalleseq OWNER TO postgres;

--
-- Name: tblproformadetalle; Type: TABLE; Schema: facturacion; Owner: postgres
--

CREATE TABLE facturacion.tblproformadetalle (
    coempresa bigint NOT NULL,
    coproformadetalle bigint DEFAULT nextval('facturacion.tblproformadetalleseq'::regclass) NOT NULL,
    coproforma bigint NOT NULL,
    nuorden smallint NOT NULL,
    coproducto bigint NOT NULL,
    qtproducto integer NOT NULL,
    ssprecio numeric(14,4),
    coimpuesto bigint,
    pqimpuesto numeric(14,4),
    ssimpuesto numeric(14,4),
    pqdescuento numeric(14,4),
    ssdescuento numeric(14,4),
    cousucre integer NOT NULL,
    cousumod integer,
    fecre timestamp without time zone DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC'::text) NOT NULL,
    femod timestamp without time zone
);


ALTER TABLE facturacion.tblproformadetalle OWNER TO postgres;

--
-- Name: tblventaseq; Type: SEQUENCE; Schema: facturacion; Owner: postgres
--

CREATE SEQUENCE facturacion.tblventaseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE facturacion.tblventaseq OWNER TO postgres;

--
-- Name: tblventa; Type: TABLE; Schema: facturacion; Owner: postgres
--

CREATE TABLE facturacion.tblventa (
    coempresa bigint NOT NULL,
    coventa bigint DEFAULT nextval('facturacion.tblventaseq'::regclass) NOT NULL,
    colocal bigint NOT NULL,
    cocomprobantepago bigint NOT NULL,
    nuserie character varying(5),
    nudocumento integer NOT NULL,
    feventa date,
    fevencimiento date,
    comoneda bigint NOT NULL,
    cotipocambio bigint NOT NULL,
    cocliente bigint NOT NULL,
    ssprecio numeric(14,4),
    ssimpuesto numeric(14,4),
    ssdescuento numeric(14,4),
    nunotasalida integer,
    comodopago smallint NOT NULL,
    comediopago bigint,
    codocpago bigint,
    txdescripcion character varying(300),
    coestreg smallint DEFAULT 1 NOT NULL,
    cousucre integer NOT NULL,
    cousumod integer,
    fecre timestamp without time zone DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC'::text) NOT NULL,
    femod timestamp without time zone,
    flestreg boolean DEFAULT true NOT NULL
);


ALTER TABLE facturacion.tblventa OWNER TO postgres;

--
-- Name: tblventadetalleseq; Type: SEQUENCE; Schema: facturacion; Owner: postgres
--

CREATE SEQUENCE facturacion.tblventadetalleseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE facturacion.tblventadetalleseq OWNER TO postgres;

--
-- Name: tblventadetalle; Type: TABLE; Schema: facturacion; Owner: postgres
--

CREATE TABLE facturacion.tblventadetalle (
    coempresa bigint NOT NULL,
    coventadetalle bigint DEFAULT nextval('facturacion.tblventadetalleseq'::regclass) NOT NULL,
    coventa bigint NOT NULL,
    nuorden smallint NOT NULL,
    coproducto bigint NOT NULL,
    qtproducto integer NOT NULL,
    ssprecioingresado numeric(14,4) NOT NULL,
    ssprecio numeric(14,4) NOT NULL,
    ssdescuento numeric(14,4) DEFAULT 0 NOT NULL,
    ssimpuesto numeric(14,4) NOT NULL,
    sspreciototal numeric(14,4) NOT NULL,
    colocal bigint,
    coalmacen bigint,
    cousucre integer NOT NULL,
    cousumod integer,
    fecre timestamp without time zone DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC'::text) NOT NULL,
    femod timestamp without time zone,
    pqdescuento numeric(14,4) DEFAULT 0 NOT NULL,
    flestreg boolean DEFAULT true NOT NULL
);


ALTER TABLE facturacion.tblventadetalle OWNER TO postgres;

--
-- Name: tblventadetalleimpuesto; Type: TABLE; Schema: facturacion; Owner: postgres
--

CREATE TABLE facturacion.tblventadetalleimpuesto (
    coempresa bigint NOT NULL,
    coventadetalleimpuesto bigint NOT NULL,
    coventadetalle bigint NOT NULL,
    coimpuesto bigint NOT NULL,
    ssimpuesto numeric(14,4) NOT NULL,
    pqtaza numeric(14,4) NOT NULL,
    coimpuestohijo bigint
);


ALTER TABLE facturacion.tblventadetalleimpuesto OWNER TO postgres;

--
-- Name: tblventadetalleimpuesto_coventadetalleimpuesto_seq; Type: SEQUENCE; Schema: facturacion; Owner: postgres
--

CREATE SEQUENCE facturacion.tblventadetalleimpuesto_coventadetalleimpuesto_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE facturacion.tblventadetalleimpuesto_coventadetalleimpuesto_seq OWNER TO postgres;

--
-- Name: tblventadetalleimpuesto_coventadetalleimpuesto_seq; Type: SEQUENCE OWNED BY; Schema: facturacion; Owner: postgres
--

ALTER SEQUENCE facturacion.tblventadetalleimpuesto_coventadetalleimpuesto_seq OWNED BY facturacion.tblventadetalleimpuesto.coventadetalleimpuesto;


--
-- Name: tblalmacenseq; Type: SEQUENCE; Schema: inventario; Owner: postgres
--

CREATE SEQUENCE inventario.tblalmacenseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE inventario.tblalmacenseq OWNER TO postgres;

--
-- Name: tblalmacen; Type: TABLE; Schema: inventario; Owner: postgres
--

CREATE TABLE inventario.tblalmacen (
    coempresa bigint NOT NULL,
    coalmacen bigint DEFAULT nextval('inventario.tblalmacenseq'::regclass) NOT NULL,
    colocal bigint NOT NULL,
    noalmacen character varying(50),
    cousucre integer NOT NULL,
    cousumod integer,
    fecre timestamp without time zone DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC'::text) NOT NULL,
    femod timestamp without time zone,
    flestreg boolean DEFAULT true NOT NULL,
    flprincipal boolean DEFAULT false NOT NULL
);


ALTER TABLE inventario.tblalmacen OWNER TO postgres;

--
-- Name: tblinventarioseq; Type: SEQUENCE; Schema: inventario; Owner: postgres
--

CREATE SEQUENCE inventario.tblinventarioseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE inventario.tblinventarioseq OWNER TO postgres;

--
-- Name: tblinventario; Type: TABLE; Schema: inventario; Owner: postgres
--

CREATE TABLE inventario.tblinventario (
    coempresa bigint NOT NULL,
    coinventario bigint DEFAULT nextval('inventario.tblinventarioseq'::regclass) NOT NULL,
    cocompra bigint NOT NULL,
    fecre timestamp without time zone DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC'::text) NOT NULL,
    cotipomovimiento smallint NOT NULL,
    coventa bigint,
    cousucre integer,
    CONSTRAINT "Inventario_Inventario_Check" CHECK ((((cotipomovimiento = 1) AND (cocompra IS NOT NULL) AND (coventa IS NULL)) OR ((cotipomovimiento = 4) AND (coventa IS NOT NULL) AND (cocompra IS NULL)) OR ((cotipomovimiento = ANY (ARRAY[2, 3])) AND (cocompra IS NULL) AND (coventa IS NULL))))
);


ALTER TABLE inventario.tblinventario OWNER TO postgres;

--
-- Name: tblinventariodetalle; Type: TABLE; Schema: inventario; Owner: postgres
--

CREATE TABLE inventario.tblinventariodetalle (
    coempresa bigint NOT NULL,
    coinventariodetalle bigint NOT NULL,
    coinventario bigint NOT NULL,
    cocompradetalle bigint,
    coventadetalle bigint,
    coproducto bigint NOT NULL,
    qtproducto numeric(18,4) NOT NULL,
    colocal bigint NOT NULL,
    coalmacen bigint NOT NULL,
    fecre timestamp without time zone DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC'::text) NOT NULL,
    cousucre integer NOT NULL,
    CONSTRAINT "Inventario_InventarioDetalle_Check" CHECK ((((cocompradetalle IS NOT NULL) AND (coventadetalle IS NULL)) OR ((coventadetalle IS NOT NULL) AND (cocompradetalle IS NULL)) OR ((cocompradetalle IS NULL) AND (coventadetalle IS NULL))))
);


ALTER TABLE inventario.tblinventariodetalle OWNER TO postgres;

--
-- Name: tblinventariodetalleseq; Type: SEQUENCE; Schema: inventario; Owner: postgres
--

CREATE SEQUENCE inventario.tblinventariodetalleseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE inventario.tblinventariodetalleseq OWNER TO postgres;

--
-- Name: tblinventariodetalleseq; Type: SEQUENCE OWNED BY; Schema: inventario; Owner: postgres
--

ALTER SEQUENCE inventario.tblinventariodetalleseq OWNED BY inventario.tblinventariodetalle.coinventariodetalle;


--
-- Name: tblinventarioventaseq; Type: SEQUENCE; Schema: inventario; Owner: postgres
--

CREATE SEQUENCE inventario.tblinventarioventaseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE inventario.tblinventarioventaseq OWNER TO postgres;

--
-- Name: tblstock; Type: TABLE; Schema: inventario; Owner: postgres
--

CREATE TABLE inventario.tblstock (
    coempresa bigint NOT NULL,
    coalmacen bigint NOT NULL,
    coproducto bigint NOT NULL,
    qtunidad numeric(18,2) DEFAULT 0 NOT NULL,
    costock bigint NOT NULL,
    colocal bigint NOT NULL
);


ALTER TABLE inventario.tblstock OWNER TO postgres;

--
-- Name: tblstockseq; Type: SEQUENCE; Schema: inventario; Owner: postgres
--

CREATE SEQUENCE inventario.tblstockseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE inventario.tblstockseq OWNER TO postgres;

--
-- Name: tblstockseq; Type: SEQUENCE OWNED BY; Schema: inventario; Owner: postgres
--

ALTER SEQUENCE inventario.tblstockseq OWNED BY inventario.tblstock.costock;


--
-- Name: tblarchivoseq; Type: SEQUENCE; Schema: maestro; Owner: postgres
--

CREATE SEQUENCE maestro.tblarchivoseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE maestro.tblarchivoseq OWNER TO postgres;

--
-- Name: tblarchivo; Type: TABLE; Schema: maestro; Owner: postgres
--

CREATE TABLE maestro.tblarchivo (
    coempresa bigint NOT NULL,
    coarchivo bigint DEFAULT nextval('maestro.tblarchivoseq'::regclass) NOT NULL,
    cotipoentidad bigint NOT NULL,
    coentidad bigint NOT NULL,
    cotipo bigint NOT NULL,
    nuorden smallint DEFAULT 0,
    txdescripcion character varying(500),
    noarchivo character varying(250) NOT NULL,
    noextension character varying(5) NOT NULL,
    cousucre integer NOT NULL,
    cousumod integer,
    fecre timestamp without time zone DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC'::text) NOT NULL,
    femod timestamp without time zone,
    nubytes numeric,
    nualto numeric,
    nuancho numeric,
    notitulo character varying(100),
    flestreg boolean DEFAULT true NOT NULL,
    fldefault boolean DEFAULT false NOT NULL,
    noruta character varying(250) NOT NULL
);


ALTER TABLE maestro.tblarchivo OWNER TO postgres;

--
-- Name: tblentidadseq; Type: SEQUENCE; Schema: maestro; Owner: postgres
--

CREATE SEQUENCE maestro.tblentidadseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE maestro.tblentidadseq OWNER TO postgres;

--
-- Name: tblentidad; Type: TABLE; Schema: maestro; Owner: postgres
--

CREATE TABLE maestro.tblentidad (
    coentidad bigint DEFAULT nextval('maestro.tblentidadseq'::regclass) CONSTRAINT tblpersona_copersona_not_null NOT NULL,
    cousucre integer CONSTRAINT tblpersona_cousucre_not_null NOT NULL,
    cousumod integer,
    fecre timestamp without time zone DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC'::text) CONSTRAINT tblpersona_fecre_not_null NOT NULL,
    femod timestamp without time zone,
    flestreg boolean DEFAULT true CONSTRAINT tblpersona_flestreg_not_null NOT NULL,
    noentidad character varying(250)
);


ALTER TABLE maestro.tblentidad OWNER TO postgres;

--
-- Name: tblentidaddireccionseq; Type: SEQUENCE; Schema: maestro; Owner: postgres
--

CREATE SEQUENCE maestro.tblentidaddireccionseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE maestro.tblentidaddireccionseq OWNER TO postgres;

--
-- Name: tblentidaddireccion; Type: TABLE; Schema: maestro; Owner: postgres
--

CREATE TABLE maestro.tblentidaddireccion (
    coentidad bigint CONSTRAINT tbldireccion_copersona_not_null NOT NULL,
    coentidaddireccion bigint DEFAULT nextval('maestro.tblentidaddireccionseq'::regclass) CONSTRAINT tbldireccion_codireccion_not_null NOT NULL,
    coetiqueta bigint CONSTRAINT tbldireccion_cotipodireccion_not_null NOT NULL,
    nodireccionlinea1 character varying(200) CONSTRAINT tbldireccion_nodirecionlinea1_not_null NOT NULL,
    nodireccionlinea2 character varying(200),
    nodireccionlinea3 character varying(200),
    nourbanizacionbarrio character varying(200),
    nociudad character varying(100),
    nocodigopostal character varying(35),
    coubigeo bigint,
    sslatitude numeric(10,7),
    sslongitude numeric(10,7),
    noreferencia character varying(250),
    flestreg boolean DEFAULT true CONSTRAINT tbldireccion_flestreg_not_null NOT NULL,
    fldefault boolean DEFAULT false CONSTRAINT tbldireccion_fldefault_not_null NOT NULL,
    fecre timestamp without time zone DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC'::text) CONSTRAINT tbldireccion_fecre_not_null NOT NULL,
    femod timestamp without time zone,
    cousucre integer CONSTRAINT tbldireccion_cousucre_not_null NOT NULL,
    cousumod integer,
    copais bigint,
    CONSTRAINT maestro_entidaddireccion_nodireccionlinea1_not_empty CHECK ((length(TRIM(BOTH FROM nodireccionlinea1)) > 0))
);


ALTER TABLE maestro.tblentidaddireccion OWNER TO postgres;

--
-- Name: tblentidaddocumentoseq; Type: SEQUENCE; Schema: maestro; Owner: postgres
--

CREATE SEQUENCE maestro.tblentidaddocumentoseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE maestro.tblentidaddocumentoseq OWNER TO postgres;

--
-- Name: tblentidaddocumento; Type: TABLE; Schema: maestro; Owner: postgres
--

CREATE TABLE maestro.tblentidaddocumento (
    coentidaddocumento bigint DEFAULT nextval('maestro.tblentidaddocumentoseq'::regclass) CONSTRAINT maestro_entidaddocumento_coentidaddocumento_not_null NOT NULL,
    coentidad bigint CONSTRAINT maestro_entidaddocumento_coentidad_not_null NOT NULL,
    codocumentoidentidad bigint CONSTRAINT maestro_entidaddocumento_codocumentoidentidad_not_null NOT NULL,
    nudocumento character varying(50) NOT NULL,
    fldefault boolean DEFAULT false CONSTRAINT maestro_entidaddocumento_fldefault_not_null NOT NULL,
    fecre timestamp without time zone DEFAULT CURRENT_TIMESTAMP CONSTRAINT maestro_entidaddocumento_fecre_not_null NOT NULL,
    femod timestamp without time zone,
    cousucre integer CONSTRAINT maestro_entidaddocumento_cousucre_not_null NOT NULL,
    cousumod integer,
    CONSTRAINT maestro_entidaddocumento_nudocumento_not_empty CHECK ((length(TRIM(BOTH FROM nudocumento)) > 0))
);


ALTER TABLE maestro.tblentidaddocumento OWNER TO postgres;

--
-- Name: tblentidadempresa; Type: TABLE; Schema: maestro; Owner: postgres
--

CREATE TABLE maestro.tblentidadempresa (
    coentidadempresa bigint CONSTRAINT tblpersonaempresa_copersonaempresa_not_null NOT NULL,
    coempresa bigint CONSTRAINT tblpersonaempresa_coempresa_not_null NOT NULL,
    coentidad bigint CONSTRAINT tblpersonaempresa_copersona_not_null NOT NULL,
    fecre timestamp without time zone DEFAULT CURRENT_TIMESTAMP CONSTRAINT tblpersonaempresa_fecre_not_null NOT NULL,
    cousucre integer CONSTRAINT tblpersonaempresa_cousucre_not_null NOT NULL,
    fldefault boolean DEFAULT false CONSTRAINT tblpersonaempresa_fldefault_not_null NOT NULL
);


ALTER TABLE maestro.tblentidadempresa OWNER TO postgres;

--
-- Name: tblentidadempresaseq; Type: SEQUENCE; Schema: maestro; Owner: postgres
--

CREATE SEQUENCE maestro.tblentidadempresaseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE maestro.tblentidadempresaseq OWNER TO postgres;

--
-- Name: tblentidadempresaseq; Type: SEQUENCE OWNED BY; Schema: maestro; Owner: postgres
--

ALTER SEQUENCE maestro.tblentidadempresaseq OWNED BY maestro.tblentidadempresa.coentidadempresa;


--
-- Name: tblentidadredsocialseq; Type: SEQUENCE; Schema: maestro; Owner: postgres
--

CREATE SEQUENCE maestro.tblentidadredsocialseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE maestro.tblentidadredsocialseq OWNER TO postgres;

--
-- Name: tblentidadredsocial; Type: TABLE; Schema: maestro; Owner: postgres
--

CREATE TABLE maestro.tblentidadredsocial (
    coentidadredsocial bigint DEFAULT nextval('maestro.tblentidadredsocialseq'::regclass) CONSTRAINT tblredsocial_coredsocial_not_null NOT NULL,
    coentidad bigint CONSTRAINT maestro_entidadredsocial_coentidad_not_null NOT NULL,
    cotiporedsocial bigint CONSTRAINT tblredsocial_cotiporedsocial_not_null NOT NULL,
    cotipourl bigint,
    coetiqueta bigint,
    noredsocial character varying(250) CONSTRAINT tblredsocial_noredsocial_not_null NOT NULL,
    cousucre integer CONSTRAINT tblredsocial_cousucre_not_null NOT NULL,
    cousumod integer,
    fecre timestamp without time zone DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC'::text) CONSTRAINT tblredsocial_fecre_not_null NOT NULL,
    femod timestamp without time zone,
    flwhatsapp boolean DEFAULT false CONSTRAINT tblredsocial_flwhatsapp_not_null NOT NULL,
    CONSTRAINT maestro_entidadredsocial_noredsocial_not_empty CHECK ((length(TRIM(BOTH FROM noredsocial)) > 0))
);


ALTER TABLE maestro.tblentidadredsocial OWNER TO postgres;

--
-- Name: tblentidadrolseq; Type: SEQUENCE; Schema: maestro; Owner: postgres
--

CREATE SEQUENCE maestro.tblentidadrolseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE maestro.tblentidadrolseq OWNER TO postgres;

--
-- Name: tblentidadrol; Type: TABLE; Schema: maestro; Owner: postgres
--

CREATE TABLE maestro.tblentidadrol (
    coentidadrol bigint DEFAULT nextval('maestro.tblentidadrolseq'::regclass) CONSTRAINT tblpersonaempresarol_copersonaempresarol_not_null NOT NULL,
    coempresa bigint CONSTRAINT tblpersonaempresarol_coempresa_not_null NOT NULL,
    coentidad bigint CONSTRAINT tblpersonaempresarol_copersona_not_null NOT NULL,
    comodulo bigint CONSTRAINT tblpersonaempresarol_comodulo_not_null NOT NULL,
    corolnegocio bigint CONSTRAINT tblpersonaempresarol_corolnegocio_not_null NOT NULL,
    cousucre integer CONSTRAINT tblpersonaempresarol_cousucre_not_null NOT NULL,
    fecre timestamp without time zone DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC'::text) CONSTRAINT tblpersonaempresarol_fecre_not_null NOT NULL,
    cousumod integer,
    femod timestamp without time zone
);


ALTER TABLE maestro.tblentidadrol OWNER TO postgres;

--
-- Name: trfmoneda; Type: TABLE; Schema: maestro; Owner: postgres
--

CREATE TABLE maestro.trfmoneda (
    comoneda bigint NOT NULL,
    nocodigoiso character varying(3) NOT NULL,
    nucodigoiso integer NOT NULL,
    nomoneda character varying(100) NOT NULL,
    nosimbolo character varying(10) NOT NULL,
    flestreg boolean DEFAULT true NOT NULL
);


ALTER TABLE maestro.trfmoneda OWNER TO postgres;

--
-- Name: tblmonedaseq; Type: SEQUENCE; Schema: maestro; Owner: postgres
--

CREATE SEQUENCE maestro.tblmonedaseq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE maestro.tblmonedaseq OWNER TO postgres;

--
-- Name: tblmonedaseq; Type: SEQUENCE OWNED BY; Schema: maestro; Owner: postgres
--

ALTER SEQUENCE maestro.tblmonedaseq OWNED BY maestro.trfmoneda.comoneda;


--
-- Name: tblpersonajuridica; Type: TABLE; Schema: maestro; Owner: postgres
--

CREATE TABLE maestro.tblpersonajuridica (
    coentidad bigint NOT NULL,
    norazonsocial character varying(250),
    nocomercial character varying(250),
    corubro bigint,
    cousucre integer NOT NULL,
    cousumod integer,
    fecre timestamp without time zone DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC'::text) NOT NULL,
    femod timestamp without time zone
);


ALTER TABLE maestro.tblpersonajuridica OWNER TO postgres;

--
-- Name: tblpersonanatural; Type: TABLE; Schema: maestro; Owner: postgres
--

CREATE TABLE maestro.tblpersonanatural (
    coentidad bigint CONSTRAINT tblpersonanatural_copersona_not_null NOT NULL,
    nopersona character varying(200),
    noapellidop character varying(40),
    noapellidom character varying(40),
    fenacimiento date,
    cosexo bigint,
    coprofesion bigint,
    coestadocivil bigint,
    cousucre integer NOT NULL,
    cousumod integer,
    fecre timestamp without time zone DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC'::text) NOT NULL,
    femod timestamp without time zone
);


ALTER TABLE maestro.tblpersonanatural OWNER TO postgres;

--
-- Name: tblpersonatiposeq; Type: SEQUENCE; Schema: maestro; Owner: postgres
--

CREATE SEQUENCE maestro.tblpersonatiposeq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE maestro.tblpersonatiposeq OWNER TO postgres;

--
-- Name: trfdocumentoidentidad; Type: TABLE; Schema: maestro; Owner: postgres
--

CREATE TABLE maestro.trfdocumentoidentidad (
    codocumentoidentidad bigint NOT NULL,
    copais bigint NOT NULL,
    nocodigo character varying(10) NOT NULL,
    nodocumentoidentidad character varying(100) NOT NULL,
    flestreg boolean DEFAULT true NOT NULL,
    nodocumentoidentidadsigla character varying(20),
    coambito bigint CONSTRAINT "trfdocumentoidentidad_cotipopersona _not_null" NOT NULL
);


ALTER TABLE maestro.trfdocumentoidentidad OWNER TO postgres;

--
-- Name: trfdocumentoidentidadseq; Type: SEQUENCE; Schema: maestro; Owner: postgres
--

CREATE SEQUENCE maestro.trfdocumentoidentidadseq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE maestro.trfdocumentoidentidadseq OWNER TO postgres;

--
-- Name: trfdocumentoidentidadseq; Type: SEQUENCE OWNED BY; Schema: maestro; Owner: postgres
--

ALTER SEQUENCE maestro.trfdocumentoidentidadseq OWNED BY maestro.trfdocumentoidentidad.codocumentoidentidad;


--
-- Name: trfpais; Type: TABLE; Schema: maestro; Owner: postgres
--

CREATE TABLE maestro.trfpais (
    nopais character varying(150) NOT NULL,
    nocodigoiso2 character varying(2) NOT NULL,
    fecre timestamp without time zone DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC'::text) NOT NULL,
    nocodigoiso3 character varying(3) NOT NULL,
    noprefijotelefono character varying(10),
    copais bigint NOT NULL,
    flestreg boolean DEFAULT true NOT NULL,
    comoneda bigint
);


ALTER TABLE maestro.trfpais OWNER TO postgres;

--
-- Name: trfpaisseq; Type: SEQUENCE; Schema: maestro; Owner: postgres
--

CREATE SEQUENCE maestro.trfpaisseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE maestro.trfpaisseq OWNER TO postgres;

--
-- Name: trfpaisseq; Type: SEQUENCE OWNED BY; Schema: maestro; Owner: postgres
--

ALTER SEQUENCE maestro.trfpaisseq OWNED BY maestro.trfpais.copais;


--
-- Name: trftipogeneral_cotipogeneral_seq; Type: SEQUENCE; Schema: maestro; Owner: postgres
--

ALTER TABLE maestro.trftipogeneral ALTER COLUMN cotipogeneral ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME maestro.trftipogeneral_cotipogeneral_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: trftipoparticular_cotipoparticular_seq; Type: SEQUENCE; Schema: maestro; Owner: postgres
--

ALTER TABLE maestro.trftipoparticular ALTER COLUMN cotipoparticular ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME maestro.trftipoparticular_cotipoparticular_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: ubigeoseq; Type: SEQUENCE; Schema: maestro; Owner: postgres
--

CREATE SEQUENCE maestro.ubigeoseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE maestro.ubigeoseq OWNER TO postgres;

--
-- Name: trfubigeo; Type: TABLE; Schema: maestro; Owner: postgres
--

CREATE TABLE maestro.trfubigeo (
    coubigeo bigint DEFAULT nextval('maestro.ubigeoseq'::regclass) CONSTRAINT trfubigeo_coubigeo_not_null1 NOT NULL,
    copais bigint CONSTRAINT trfubigeo_copais_not_null1 NOT NULL,
    nocodigo character varying(20),
    nonivel1 character varying(100),
    nonivel2 character varying(100),
    nonivel3 character varying(100),
    conivel1 character varying(6),
    conivel2 character varying(6),
    conivel3 character varying(6)
);


ALTER TABLE maestro.trfubigeo OWNER TO postgres;

--
-- Name: trfunidadmedidaseq; Type: SEQUENCE; Schema: maestro; Owner: postgres
--

CREATE SEQUENCE maestro.trfunidadmedidaseq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE maestro.trfunidadmedidaseq OWNER TO postgres;

--
-- Name: trfunidadmedidaseq; Type: SEQUENCE OWNED BY; Schema: maestro; Owner: postgres
--

ALTER SEQUENCE maestro.trfunidadmedidaseq OWNED BY maestro.trfunidadmedida.counidadmedida;


--
-- Name: vw_personajuridica; Type: VIEW; Schema: maestro; Owner: postgres
--

CREATE VIEW maestro.vw_personajuridica AS
 SELECT ee.coempresa,
    en.coentidad,
    en.noentidad,
    pj.norazonsocial,
    pj.nocomercial,
    pj.corubro,
    en.flestreg
   FROM ((maestro.tblentidadempresa ee
     JOIN maestro.tblentidad en ON ((en.coentidad = ee.coentidad)))
     JOIN maestro.tblpersonajuridica pj ON ((pj.coentidad = en.coentidad)));


ALTER VIEW maestro.vw_personajuridica OWNER TO postgres;

--
-- Name: vw_personanatural; Type: VIEW; Schema: maestro; Owner: postgres
--

CREATE VIEW maestro.vw_personanatural AS
 SELECT ee.coempresa,
    en.coentidad,
    en.noentidad,
    pn.nopersona,
    pn.noapellidop,
    pn.noapellidom,
    pn.fenacimiento,
    pn.cosexo,
    pn.coprofesion,
    pn.coestadocivil,
    en.flestreg
   FROM ((maestro.tblentidadempresa ee
     JOIN maestro.tblentidad en ON ((en.coentidad = ee.coentidad)))
     JOIN maestro.tblpersonanatural pn ON ((pn.coentidad = en.coentidad)));


ALTER VIEW maestro.vw_personanatural OWNER TO postgres;

--
-- Name: audgeneral; Type: TABLE; Schema: seguridad; Owner: postgres
--

CREATE TABLE seguridad.audgeneral (
    coauditoria bigint NOT NULL,
    coempresa bigint NOT NULL,
    noesquema character varying(80),
    notabla character varying(80),
    noaccion character(1),
    cousuario bigint NOT NULL,
    jbpk jsonb NOT NULL,
    jbdataold jsonb,
    jbdatanew jsonb,
    feauditoria timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE seguridad.audgeneral OWNER TO postgres;

--
-- Name: audgeneral_coauditoria_seq; Type: SEQUENCE; Schema: seguridad; Owner: postgres
--

CREATE SEQUENCE seguridad.audgeneral_coauditoria_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE seguridad.audgeneral_coauditoria_seq OWNER TO postgres;

--
-- Name: audgeneral_coauditoria_seq; Type: SEQUENCE OWNED BY; Schema: seguridad; Owner: postgres
--

ALTER SEQUENCE seguridad.audgeneral_coauditoria_seq OWNED BY seguridad.audgeneral.coauditoria;


--
-- Name: segempresamoduloseq; Type: SEQUENCE; Schema: seguridad; Owner: postgres
--

CREATE SEQUENCE seguridad.segempresamoduloseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE seguridad.segempresamoduloseq OWNER TO postgres;

--
-- Name: segempresamodulo; Type: TABLE; Schema: seguridad; Owner: postgres
--

CREATE TABLE seguridad.segempresamodulo (
    coempresamodulo bigint DEFAULT nextval('seguridad.segempresamoduloseq'::regclass) NOT NULL,
    coempresa bigint NOT NULL,
    comodulo bigint NOT NULL
);


ALTER TABLE seguridad.segempresamodulo OWNER TO postgres;

--
-- Name: segmenuseq; Type: SEQUENCE; Schema: seguridad; Owner: postgres
--

CREATE SEQUENCE seguridad.segmenuseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE seguridad.segmenuseq OWNER TO postgres;

--
-- Name: segmenu; Type: TABLE; Schema: seguridad; Owner: postgres
--

CREATE TABLE seguridad.segmenu (
    comenu bigint DEFAULT nextval('seguridad.segmenuseq'::regclass) NOT NULL,
    comodulo bigint NOT NULL,
    nuorden smallint NOT NULL,
    nomenu character varying(80) NOT NULL,
    cousucre integer NOT NULL,
    cousumod integer,
    fecre timestamp without time zone DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC'::text) NOT NULL,
    femod timestamp without time zone,
    flestreg boolean DEFAULT true NOT NULL
);


ALTER TABLE seguridad.segmenu OWNER TO postgres;

--
-- Name: segmoduloseq; Type: SEQUENCE; Schema: seguridad; Owner: postgres
--

CREATE SEQUENCE seguridad.segmoduloseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE seguridad.segmoduloseq OWNER TO postgres;

--
-- Name: segmodulo; Type: TABLE; Schema: seguridad; Owner: postgres
--

CREATE TABLE seguridad.segmodulo (
    comodulo bigint DEFAULT nextval('seguridad.segmoduloseq'::regclass) NOT NULL,
    nomodulo character varying(30) NOT NULL,
    nomodulodescripcion character varying(200),
    noarea character varying(20),
    nuorden smallint,
    fecre date DEFAULT CURRENT_TIMESTAMP NOT NULL,
    femod timestamp without time zone,
    cousucre integer NOT NULL,
    cousumod integer,
    flestreg boolean DEFAULT true NOT NULL,
    flarea boolean DEFAULT true NOT NULL,
    noicono character varying(60)
);


ALTER TABLE seguridad.segmodulo OWNER TO postgres;

--
-- Name: segmodulousuarioseq; Type: SEQUENCE; Schema: seguridad; Owner: postgres
--

CREATE SEQUENCE seguridad.segmodulousuarioseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE seguridad.segmodulousuarioseq OWNER TO postgres;

--
-- Name: segmodulousuario; Type: TABLE; Schema: seguridad; Owner: postgres
--

CREATE TABLE seguridad.segmodulousuario (
    comodulousuario bigint DEFAULT nextval('seguridad.segmodulousuarioseq'::regclass) NOT NULL,
    cousuario bigint CONSTRAINT segmodulousuario_coempresa_not_null NOT NULL,
    comodulo bigint NOT NULL,
    coperfil bigint NOT NULL,
    feexpiracion date,
    fecre timestamp without time zone DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC'::text) NOT NULL,
    femod timestamp without time zone,
    valor jsonb,
    coempresa bigint CONSTRAINT segmodulousuario_coempresa_not_null1 NOT NULL
);


ALTER TABLE seguridad.segmodulousuario OWNER TO postgres;

--
-- Name: segpaginaseq; Type: SEQUENCE; Schema: seguridad; Owner: postgres
--

CREATE SEQUENCE seguridad.segpaginaseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE seguridad.segpaginaseq OWNER TO postgres;

--
-- Name: segpagina; Type: TABLE; Schema: seguridad; Owner: postgres
--

CREATE TABLE seguridad.segpagina (
    copagina bigint DEFAULT nextval('seguridad.segpaginaseq'::regclass) NOT NULL,
    comodulo bigint NOT NULL,
    nuorden smallint,
    comenu bigint NOT NULL,
    coarea bigint NOT NULL,
    noopcion character varying(50),
    cotipopagina bigint NOT NULL,
    nocontrolador character varying(50),
    noaccion character varying(50),
    cousucre integer NOT NULL,
    cousumod integer,
    fecre timestamp without time zone DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC'::text) NOT NULL,
    femod timestamp without time zone,
    flestreg boolean DEFAULT true NOT NULL
);


ALTER TABLE seguridad.segpagina OWNER TO postgres;

--
-- Name: segperfilseq; Type: SEQUENCE; Schema: seguridad; Owner: postgres
--

CREATE SEQUENCE seguridad.segperfilseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE seguridad.segperfilseq OWNER TO postgres;

--
-- Name: segperfil; Type: TABLE; Schema: seguridad; Owner: postgres
--

CREATE TABLE seguridad.segperfil (
    coperfil bigint DEFAULT nextval('seguridad.segperfilseq'::regclass) NOT NULL,
    comodulo bigint NOT NULL,
    noperfil character varying(100) NOT NULL,
    cousucre integer NOT NULL,
    cousumod integer,
    fecre timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    femod timestamp without time zone,
    flestreg boolean DEFAULT true NOT NULL,
    fldefault boolean DEFAULT false NOT NULL,
    fladmin boolean DEFAULT false NOT NULL
);


ALTER TABLE seguridad.segperfil OWNER TO postgres;

--
-- Name: segperfilpaginaseq; Type: SEQUENCE; Schema: seguridad; Owner: postgres
--

CREATE SEQUENCE seguridad.segperfilpaginaseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE seguridad.segperfilpaginaseq OWNER TO postgres;

--
-- Name: segperfilpagina; Type: TABLE; Schema: seguridad; Owner: postgres
--

CREATE TABLE seguridad.segperfilpagina (
    coperfil bigint NOT NULL,
    comodulo bigint NOT NULL,
    copagina bigint NOT NULL,
    comenu bigint NOT NULL,
    cousucre integer NOT NULL,
    cousumod integer,
    fecre timestamp without time zone DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC'::text) NOT NULL,
    femod timestamp without time zone,
    coperfilpagina bigint DEFAULT nextval('seguridad.segperfilpaginaseq'::regclass) NOT NULL
);


ALTER TABLE seguridad.segperfilpagina OWNER TO postgres;

--
-- Name: seqingreso; Type: SEQUENCE; Schema: seguridad; Owner: postgres
--

CREATE SEQUENCE seguridad.seqingreso
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE seguridad.seqingreso OWNER TO postgres;

--
-- Name: tblempresaseq; Type: SEQUENCE; Schema: seguridad; Owner: postgres
--

CREATE SEQUENCE seguridad.tblempresaseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE seguridad.tblempresaseq OWNER TO postgres;

--
-- Name: tblempresa; Type: TABLE; Schema: seguridad; Owner: postgres
--

CREATE TABLE seguridad.tblempresa (
    coempresa bigint DEFAULT nextval('seguridad.tblempresaseq'::regclass) NOT NULL,
    nomision character varying(800),
    novision character varying(800),
    txquiensoy character varying(7000),
    cousucre integer NOT NULL,
    cousumod integer,
    fecre timestamp without time zone DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC'::text) NOT NULL,
    femod timestamp without time zone,
    comoneda bigint,
    coentidad bigint CONSTRAINT tblempresa_copersona_not_null NOT NULL,
    copais bigint,
    coidioma bigint,
    configuracion jsonb,
    flestreg boolean DEFAULT true CONSTRAINT tblempresa_flsitreg_not_null NOT NULL,
    cousuario_owner bigint NOT NULL
);


ALTER TABLE seguridad.tblempresa OWNER TO postgres;

--
-- Name: tblingreso; Type: TABLE; Schema: seguridad; Owner: postgres
--

CREATE TABLE seguridad.tblingreso (
    coingreso bigint DEFAULT nextval('seguridad.seqingreso'::regclass) NOT NULL,
    cousuario bigint CONSTRAINT tblingreso_copermiso_not_null NOT NULL,
    norefreshtoken character varying(200) NOT NULL,
    noip character varying(50),
    feingreso timestamp without time zone DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC'::text) NOT NULL,
    fesalida timestamp without time zone,
    ferefreshtokenexpire timestamp without time zone NOT NULL,
    norefreshtokenprevious character varying(200),
    coestado bigint NOT NULL,
    nouseragent character varying(300)
);


ALTER TABLE seguridad.tblingreso OWNER TO postgres;

--
-- Name: trfpermisoseq; Type: SEQUENCE; Schema: seguridad; Owner: postgres
--

CREATE SEQUENCE seguridad.trfpermisoseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE seguridad.trfpermisoseq OWNER TO postgres;

--
-- Name: tblusuario; Type: TABLE; Schema: seguridad; Owner: postgres
--

CREATE TABLE seguridad.tblusuario (
    cousuario bigint DEFAULT nextval('seguridad.trfpermisoseq'::regclass) CONSTRAINT trfpermiso_copermiso_not_null NOT NULL,
    coentidad bigint CONSTRAINT trfpermiso_copersona_not_null NOT NULL,
    nousuario character varying(80),
    noclave character varying(255),
    cousucre integer,
    cousumod integer,
    fecre timestamp without time zone DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC'::text) CONSTRAINT trfpermiso_fecre_not_null NOT NULL,
    femod timestamp without time zone,
    flestreg boolean DEFAULT true CONSTRAINT trfpermiso_flestreg_not_null NOT NULL,
    flsuperadmin boolean DEFAULT false CONSTRAINT "tblusuario_flsuperadmin _not_null" NOT NULL
);


ALTER TABLE seguridad.tblusuario OWNER TO postgres;

--
-- Name: trfredirectseq; Type: SEQUENCE; Schema: seguridad; Owner: postgres
--

CREATE SEQUENCE seguridad.trfredirectseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE seguridad.trfredirectseq OWNER TO postgres;

--
-- Name: vw_empresa; Type: VIEW; Schema: seguridad; Owner: postgres
--

CREATE VIEW seguridad.vw_empresa AS
 SELECT e.coempresa,
    e.nomision,
    e.novision,
    e.txquiensoy,
    e.comoneda,
    e.coentidad,
    e.copais,
    e.coidioma,
    e.configuracion,
    e.flestreg,
    pj.norazonsocial,
    pj.nocomercial,
    pj.corubro
   FROM ((seguridad.tblempresa e
     JOIN maestro.tblentidad en ON (((en.coentidad = e.coentidad) AND (en.flestreg = true))))
     JOIN maestro.tblpersonajuridica pj ON ((pj.coentidad = e.coentidad)));


ALTER VIEW seguridad.vw_empresa OWNER TO postgres;

--
-- Name: vw_usuario; Type: VIEW; Schema: seguridad; Owner: postgres
--

CREATE VIEW seguridad.vw_usuario AS
 SELECT u.cousuario,
    u.coentidad,
    u.nousuario,
    u.noclave,
    en.noentidad,
    pe.coempresa,
    u.flestreg
   FROM (((seguridad.tblusuario u
     JOIN maestro.tblentidad en ON ((en.coentidad = u.coentidad)))
     LEFT JOIN maestro.tblpersonanatural p ON ((p.coentidad = u.coentidad)))
     LEFT JOIN maestro.tblentidadempresa pe ON ((pe.coentidad = u.coentidad)));


ALTER VIEW seguridad.vw_usuario OWNER TO postgres;

--
-- Name: tblatributo coatributo; Type: DEFAULT; Schema: catalogo; Owner: postgres
--

ALTER TABLE ONLY catalogo.tblatributo ALTER COLUMN coatributo SET DEFAULT nextval('catalogo.tblatributoseq'::regclass);


--
-- Name: tblproductoatributo coproductoatributo; Type: DEFAULT; Schema: catalogo; Owner: postgres
--

ALTER TABLE ONLY catalogo.tblproductoatributo ALTER COLUMN coproductoatributo SET DEFAULT nextval('catalogo.tblproductoatributoseq'::regclass);


--
-- Name: tblproductoimpuesto coproductoimpuesto; Type: DEFAULT; Schema: catalogo; Owner: postgres
--

ALTER TABLE ONLY catalogo.tblproductoimpuesto ALTER COLUMN coproductoimpuesto SET DEFAULT nextval('catalogo.tblproductompuestoseq'::regclass);


--
-- Name: tblproductoindex coproductoindex; Type: DEFAULT; Schema: catalogo; Owner: postgres
--

ALTER TABLE ONLY catalogo.tblproductoindex ALTER COLUMN coproductoindex SET DEFAULT nextval('catalogo.tblproductoindexseq'::regclass);


--
-- Name: trfclasificacionfiscal coclasificacionfiscal; Type: DEFAULT; Schema: contabilidad; Owner: postgres
--

ALTER TABLE ONLY contabilidad.trfclasificacionfiscal ALTER COLUMN coclasificacionfiscal SET DEFAULT nextval('contabilidad.trfclasificacionfiscal_coclasificacionfiscal_seq'::regclass);


--
-- Name: trfcomprobantepago cocomprobantepago; Type: DEFAULT; Schema: contabilidad; Owner: postgres
--

ALTER TABLE ONLY contabilidad.trfcomprobantepago ALTER COLUMN cocomprobantepago SET DEFAULT nextval('contabilidad.trfcomprobantepago_cocomprobantepago_seq'::regclass);


--
-- Name: trfimpuesto coimpuesto; Type: DEFAULT; Schema: contabilidad; Owner: postgres
--

ALTER TABLE ONLY contabilidad.trfimpuesto ALTER COLUMN coimpuesto SET DEFAULT nextval('contabilidad.impuesto_impuesto_id_seq'::regclass);


--
-- Name: trfimpuestohijo coimpuestohijo; Type: DEFAULT; Schema: contabilidad; Owner: postgres
--

ALTER TABLE ONLY contabilidad.trfimpuestohijo ALTER COLUMN coimpuestohijo SET DEFAULT nextval('contabilidad.isc_subtipo_isc_subtipo_id_seq'::regclass);


--
-- Name: trfmediopago comediopago; Type: DEFAULT; Schema: contabilidad; Owner: postgres
--

ALTER TABLE ONLY contabilidad.trfmediopago ALTER COLUMN comediopago SET DEFAULT nextval('contabilidad.trfformapago_coformapago_seq'::regclass);


--
-- Name: trfmotivonotacredito comotivonotacredito; Type: DEFAULT; Schema: contabilidad; Owner: postgres
--

ALTER TABLE ONLY contabilidad.trfmotivonotacredito ALTER COLUMN comotivonotacredito SET DEFAULT nextval('contabilidad.trfmotivonotacredito_comotivonotacredito_seq'::regclass);


--
-- Name: tblcompradetalleimpuesto cocompradetalleimpuesto; Type: DEFAULT; Schema: facturacion; Owner: postgres
--

ALTER TABLE ONLY facturacion.tblcompradetalleimpuesto ALTER COLUMN cocompradetalleimpuesto SET DEFAULT nextval('facturacion.tblcompradetalleimpuesto_cocompradetalleimpuesto_seq'::regclass);


--
-- Name: tblventadetalleimpuesto coventadetalleimpuesto; Type: DEFAULT; Schema: facturacion; Owner: postgres
--

ALTER TABLE ONLY facturacion.tblventadetalleimpuesto ALTER COLUMN coventadetalleimpuesto SET DEFAULT nextval('facturacion.tblventadetalleimpuesto_coventadetalleimpuesto_seq'::regclass);


--
-- Name: tblinventariodetalle coinventariodetalle; Type: DEFAULT; Schema: inventario; Owner: postgres
--

ALTER TABLE ONLY inventario.tblinventariodetalle ALTER COLUMN coinventariodetalle SET DEFAULT nextval('inventario.tblinventariodetalleseq'::regclass);


--
-- Name: tblstock costock; Type: DEFAULT; Schema: inventario; Owner: postgres
--

ALTER TABLE ONLY inventario.tblstock ALTER COLUMN costock SET DEFAULT nextval('inventario.tblstockseq'::regclass);


--
-- Name: tblentidadempresa coentidadempresa; Type: DEFAULT; Schema: maestro; Owner: postgres
--

ALTER TABLE ONLY maestro.tblentidadempresa ALTER COLUMN coentidadempresa SET DEFAULT nextval('maestro.tblentidadempresaseq'::regclass);


--
-- Name: trfdocumentoidentidad codocumentoidentidad; Type: DEFAULT; Schema: maestro; Owner: postgres
--

ALTER TABLE ONLY maestro.trfdocumentoidentidad ALTER COLUMN codocumentoidentidad SET DEFAULT nextval('maestro.trfdocumentoidentidadseq'::regclass);


--
-- Name: trfmoneda comoneda; Type: DEFAULT; Schema: maestro; Owner: postgres
--

ALTER TABLE ONLY maestro.trfmoneda ALTER COLUMN comoneda SET DEFAULT nextval('maestro.tblmonedaseq'::regclass);


--
-- Name: trfpais copais; Type: DEFAULT; Schema: maestro; Owner: postgres
--

ALTER TABLE ONLY maestro.trfpais ALTER COLUMN copais SET DEFAULT nextval('maestro.trfpaisseq'::regclass);


--
-- Name: trfunidadmedida counidadmedida; Type: DEFAULT; Schema: maestro; Owner: postgres
--

ALTER TABLE ONLY maestro.trfunidadmedida ALTER COLUMN counidadmedida SET DEFAULT nextval('maestro.trfunidadmedidaseq'::regclass);


--
-- Name: audgeneral coauditoria; Type: DEFAULT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.audgeneral ALTER COLUMN coauditoria SET DEFAULT nextval('seguridad.audgeneral_coauditoria_seq'::regclass);


--
-- Name: tblatributo Catalogo_Atributo_Pk; Type: CONSTRAINT; Schema: catalogo; Owner: postgres
--

ALTER TABLE ONLY catalogo.tblatributo
    ADD CONSTRAINT "Catalogo_Atributo_Pk" PRIMARY KEY (coempresa, coatributo);


--
-- Name: tblatributo Catalogo_Atributo_Uk; Type: CONSTRAINT; Schema: catalogo; Owner: postgres
--

ALTER TABLE ONLY catalogo.tblatributo
    ADD CONSTRAINT "Catalogo_Atributo_Uk" UNIQUE (coempresa, cotipodato, noatributo);


--
-- Name: tblproductoatributo Catalogo_ProductoAtributo_Pk; Type: CONSTRAINT; Schema: catalogo; Owner: postgres
--

ALTER TABLE ONLY catalogo.tblproductoatributo
    ADD CONSTRAINT "Catalogo_ProductoAtributo_Pk" PRIMARY KEY (coempresa, coproductoatributo);


--
-- Name: tblproductoatributo Catalogo_ProductoAtributo_Producto_Uk; Type: CONSTRAINT; Schema: catalogo; Owner: postgres
--

ALTER TABLE ONLY catalogo.tblproductoatributo
    ADD CONSTRAINT "Catalogo_ProductoAtributo_Producto_Uk" UNIQUE (coproducto, coempresa, coatributo);


--
-- Name: tblproductoatributo Catalogo_ProductoAtributo_Uk; Type: CONSTRAINT; Schema: catalogo; Owner: postgres
--

ALTER TABLE ONLY catalogo.tblproductoatributo
    ADD CONSTRAINT "Catalogo_ProductoAtributo_Uk" UNIQUE (coproductoatributo);


--
-- Name: tblproductoindex Catalogo_ProductoIndex_Pk; Type: CONSTRAINT; Schema: catalogo; Owner: postgres
--

ALTER TABLE ONLY catalogo.tblproductoindex
    ADD CONSTRAINT "Catalogo_ProductoIndex_Pk" PRIMARY KEY (coempresa, coproductoindex);


--
-- Name: tblproductoindex Catalogo_ProductoIndex_Uk; Type: CONSTRAINT; Schema: catalogo; Owner: postgres
--

ALTER TABLE ONLY catalogo.tblproductoindex
    ADD CONSTRAINT "Catalogo_ProductoIndex_Uk" UNIQUE (coproductoindex);


--
-- Name: tblproductostock Catalogo_ProductoStock_Pk; Type: CONSTRAINT; Schema: catalogo; Owner: postgres
--

ALTER TABLE ONLY catalogo.tblproductostock
    ADD CONSTRAINT "Catalogo_ProductoStock_Pk" PRIMARY KEY (coempresa, coproductostock);


--
-- Name: tblproducto Catalogo_Producto_Pk; Type: CONSTRAINT; Schema: catalogo; Owner: postgres
--

ALTER TABLE ONLY catalogo.tblproducto
    ADD CONSTRAINT "Catalogo_Producto_Pk" PRIMARY KEY (coempresa, coproducto);


--
-- Name: tblproducto Catalogo_Producto_Uk; Type: CONSTRAINT; Schema: catalogo; Owner: postgres
--

ALTER TABLE ONLY catalogo.tblproducto
    ADD CONSTRAINT "Catalogo_Producto_Uk" UNIQUE (coproducto);


--
-- Name: tblproductoimpuesto Inventario_ProductoImpuesto_Impuesto_Uk; Type: CONSTRAINT; Schema: catalogo; Owner: postgres
--

ALTER TABLE ONLY catalogo.tblproductoimpuesto
    ADD CONSTRAINT "Inventario_ProductoImpuesto_Impuesto_Uk" UNIQUE (coempresa, coproducto, coimpuesto);


--
-- Name: tblproductoimpuesto Inventario_ProductoImpuesto_Pk; Type: CONSTRAINT; Schema: catalogo; Owner: postgres
--

ALTER TABLE ONLY catalogo.tblproductoimpuesto
    ADD CONSTRAINT "Inventario_ProductoImpuesto_Pk" PRIMARY KEY (coempresa, coproductoimpuesto);


--
-- Name: tblproductoimpuesto Inventario_ProductoImpuesto_Uk; Type: CONSTRAINT; Schema: catalogo; Owner: postgres
--

ALTER TABLE ONLY catalogo.tblproductoimpuesto
    ADD CONSTRAINT "Inventario_ProductoImpuesto_Uk" UNIQUE (coproductoimpuesto);


--
-- Name: tblproductoprecio Inventario_ProductoPrecio_Pk; Type: CONSTRAINT; Schema: catalogo; Owner: postgres
--

ALTER TABLE ONLY catalogo.tblproductoprecio
    ADD CONSTRAINT "Inventario_ProductoPrecio_Pk" PRIMARY KEY (coempresa, coproductoprecio);


--
-- Name: tblproductoprecio Inventario_ProductoPrecio_Uk; Type: CONSTRAINT; Schema: catalogo; Owner: postgres
--

ALTER TABLE ONLY catalogo.tblproductoprecio
    ADD CONSTRAINT "Inventario_ProductoPrecio_Uk" UNIQUE (coproductoprecio);


--
-- Name: tblproductostock Inventario_ProductoStock_Uk; Type: CONSTRAINT; Schema: catalogo; Owner: postgres
--

ALTER TABLE ONLY catalogo.tblproductostock
    ADD CONSTRAINT "Inventario_ProductoStock_Uk" UNIQUE (coproductostock);


--
-- Name: tblproductoterminado Inventario_ProductoTerminado_Pk; Type: CONSTRAINT; Schema: catalogo; Owner: postgres
--

ALTER TABLE ONLY catalogo.tblproductoterminado
    ADD CONSTRAINT "Inventario_ProductoTerminado_Pk" PRIMARY KEY (coempresa, coproductoterminado);


--
-- Name: tblproductoterminado Inventario_ProductoTerminado_Uk; Type: CONSTRAINT; Schema: catalogo; Owner: postgres
--

ALTER TABLE ONLY catalogo.tblproductoterminado
    ADD CONSTRAINT "Inventario_ProductoTerminado_Uk" UNIQUE (coproductoterminado);


--
-- Name: trfclasificacionfiscal Contabilidad_ClasificacionFiscal_Pk; Type: CONSTRAINT; Schema: contabilidad; Owner: postgres
--

ALTER TABLE ONLY contabilidad.trfclasificacionfiscal
    ADD CONSTRAINT "Contabilidad_ClasificacionFiscal_Pk" PRIMARY KEY (coclasificacionfiscal);


--
-- Name: trfclasificacionfiscal Contabilidad_ClasificacionFiscal_Uk; Type: CONSTRAINT; Schema: contabilidad; Owner: postgres
--

ALTER TABLE ONLY contabilidad.trfclasificacionfiscal
    ADD CONSTRAINT "Contabilidad_ClasificacionFiscal_Uk" UNIQUE (copais, nocodigo);


--
-- Name: trfmediopago Contabilidad_FormaPago_Pk; Type: CONSTRAINT; Schema: contabilidad; Owner: postgres
--

ALTER TABLE ONLY contabilidad.trfmediopago
    ADD CONSTRAINT "Contabilidad_FormaPago_Pk" PRIMARY KEY (comediopago);


--
-- Name: trfmediopago Contabilidad_FormaPago_Uk; Type: CONSTRAINT; Schema: contabilidad; Owner: postgres
--

ALTER TABLE ONLY contabilidad.trfmediopago
    ADD CONSTRAINT "Contabilidad_FormaPago_Uk" UNIQUE (copais, nocodigo);


--
-- Name: trfimpuestohijo Contabilidad_ImpuestoHijo_Pk; Type: CONSTRAINT; Schema: contabilidad; Owner: postgres
--

ALTER TABLE ONLY contabilidad.trfimpuestohijo
    ADD CONSTRAINT "Contabilidad_ImpuestoHijo_Pk" PRIMARY KEY (coimpuestohijo);


--
-- Name: trfmotivonotacredito Contabilidad_MotivoNotacredito_Pk; Type: CONSTRAINT; Schema: contabilidad; Owner: postgres
--

ALTER TABLE ONLY contabilidad.trfmotivonotacredito
    ADD CONSTRAINT "Contabilidad_MotivoNotacredito_Pk" PRIMARY KEY (comotivonotacredito);


--
-- Name: trfmotivonotacredito Contabilidad_MotivoNotacredito_Uk; Type: CONSTRAINT; Schema: contabilidad; Owner: postgres
--

ALTER TABLE ONLY contabilidad.trfmotivonotacredito
    ADD CONSTRAINT "Contabilidad_MotivoNotacredito_Uk" UNIQUE (copais, nocodigo);


--
-- Name: tbltipocambio Contabilidad_TipoCambio_Pk; Type: CONSTRAINT; Schema: contabilidad; Owner: postgres
--

ALTER TABLE ONLY contabilidad.tbltipocambio
    ADD CONSTRAINT "Contabilidad_TipoCambio_Pk" PRIMARY KEY (coempresa, cotipocambio);


--
-- Name: trfcomprobantepago Maestro_ComprobantePago_Pk; Type: CONSTRAINT; Schema: contabilidad; Owner: postgres
--

ALTER TABLE ONLY contabilidad.trfcomprobantepago
    ADD CONSTRAINT "Maestro_ComprobantePago_Pk" PRIMARY KEY (cocomprobantepago);


--
-- Name: trfcomprobantepago Maestro_ComprobantePago_Uk; Type: CONSTRAINT; Schema: contabilidad; Owner: postgres
--

ALTER TABLE ONLY contabilidad.trfcomprobantepago
    ADD CONSTRAINT "Maestro_ComprobantePago_Uk" UNIQUE (copais, nocodigo);


--
-- Name: trfimpuesto Maestro_Impuesto_Pk; Type: CONSTRAINT; Schema: contabilidad; Owner: postgres
--

ALTER TABLE ONLY contabilidad.trfimpuesto
    ADD CONSTRAINT "Maestro_Impuesto_Pk" PRIMARY KEY (coimpuesto);


--
-- Name: trfimpuesto Maestro_Impuesto_Uk; Type: CONSTRAINT; Schema: contabilidad; Owner: postgres
--

ALTER TABLE ONLY contabilidad.trfimpuesto
    ADD CONSTRAINT "Maestro_Impuesto_Uk" UNIQUE (copais, nocodigo);


--
-- Name: trfimpuestohijo uk_isc; Type: CONSTRAINT; Schema: contabilidad; Owner: postgres
--

ALTER TABLE ONLY contabilidad.trfimpuestohijo
    ADD CONSTRAINT uk_isc UNIQUE (nocodigo, coimpuesto);


--
-- Name: tblbandejaentrada Empresa_BandejaEntrada_Pk; Type: CONSTRAINT; Schema: empresa; Owner: postgres
--

ALTER TABLE ONLY empresa.tblbandejaentrada
    ADD CONSTRAINT "Empresa_BandejaEntrada_Pk" PRIMARY KEY (coempresa, cobandejaentrada);


--
-- Name: tblbandejaentrada Empresa_BandejaEntrada_Uk; Type: CONSTRAINT; Schema: empresa; Owner: postgres
--

ALTER TABLE ONLY empresa.tblbandejaentrada
    ADD CONSTRAINT "Empresa_BandejaEntrada_Uk" UNIQUE (cobandejaentrada);


--
-- Name: tblblogmensaje Empresa_BlogMensaje_Pk; Type: CONSTRAINT; Schema: empresa; Owner: postgres
--

ALTER TABLE ONLY empresa.tblblogmensaje
    ADD CONSTRAINT "Empresa_BlogMensaje_Pk" PRIMARY KEY (coempresa, coblogmensaje);


--
-- Name: tblblogmensaje Empresa_BlogMensaje_Uk; Type: CONSTRAINT; Schema: empresa; Owner: postgres
--

ALTER TABLE ONLY empresa.tblblogmensaje
    ADD CONSTRAINT "Empresa_BlogMensaje_Uk" UNIQUE (coblogmensaje);


--
-- Name: tblblog Empresa_Blog_Pk; Type: CONSTRAINT; Schema: empresa; Owner: postgres
--

ALTER TABLE ONLY empresa.tblblog
    ADD CONSTRAINT "Empresa_Blog_Pk" PRIMARY KEY (coempresa, coblog);


--
-- Name: tblblog Empresa_Blog_Uk; Type: CONSTRAINT; Schema: empresa; Owner: postgres
--

ALTER TABLE ONLY empresa.tblblog
    ADD CONSTRAINT "Empresa_Blog_Uk" UNIQUE (coblog);


--
-- Name: tblcliente Empresa_Cliente_Pk; Type: CONSTRAINT; Schema: empresa; Owner: postgres
--

ALTER TABLE ONLY empresa.tblcliente
    ADD CONSTRAINT "Empresa_Cliente_Pk" PRIMARY KEY (coempresa, cocliente);


--
-- Name: tblcliente Empresa_Cliente_Uk; Type: CONSTRAINT; Schema: empresa; Owner: postgres
--

ALTER TABLE ONLY empresa.tblcliente
    ADD CONSTRAINT "Empresa_Cliente_Uk" UNIQUE (cocliente);


--
-- Name: tblequipo Empresa_Equipo_Pk; Type: CONSTRAINT; Schema: empresa; Owner: postgres
--

ALTER TABLE ONLY empresa.tblequipo
    ADD CONSTRAINT "Empresa_Equipo_Pk" PRIMARY KEY (coempresa, coequipo);


--
-- Name: tblequipo Empresa_Equipo_Uk; Type: CONSTRAINT; Schema: empresa; Owner: postgres
--

ALTER TABLE ONLY empresa.tblequipo
    ADD CONSTRAINT "Empresa_Equipo_Uk" UNIQUE (coequipo);


--
-- Name: tblhorario Empresa_Horario_Pk; Type: CONSTRAINT; Schema: empresa; Owner: postgres
--

ALTER TABLE ONLY empresa.tblhorario
    ADD CONSTRAINT "Empresa_Horario_Pk" PRIMARY KEY (coempresa, cohorario);


--
-- Name: tblhorario Empresa_Horario_Uk; Type: CONSTRAINT; Schema: empresa; Owner: postgres
--

ALTER TABLE ONLY empresa.tblhorario
    ADD CONSTRAINT "Empresa_Horario_Uk" UNIQUE (cohorario);


--
-- Name: tbllocal Empresa_Local_Pk; Type: CONSTRAINT; Schema: empresa; Owner: postgres
--

ALTER TABLE ONLY empresa.tbllocal
    ADD CONSTRAINT "Empresa_Local_Pk" PRIMARY KEY (coempresa, colocal);


--
-- Name: tblpregunta Empresa_Pregunta_Pk; Type: CONSTRAINT; Schema: empresa; Owner: postgres
--

ALTER TABLE ONLY empresa.tblpregunta
    ADD CONSTRAINT "Empresa_Pregunta_Pk" PRIMARY KEY (coempresa, copregunta);


--
-- Name: tblpregunta Empresa_Pregunta_Uk; Type: CONSTRAINT; Schema: empresa; Owner: postgres
--

ALTER TABLE ONLY empresa.tblpregunta
    ADD CONSTRAINT "Empresa_Pregunta_Uk" UNIQUE (copregunta);


--
-- Name: tblservicio Empresa_Servicio_Pk; Type: CONSTRAINT; Schema: empresa; Owner: postgres
--

ALTER TABLE ONLY empresa.tblservicio
    ADD CONSTRAINT "Empresa_Servicio_Pk" PRIMARY KEY (coempresa, coservicio);


--
-- Name: tblservicio Empresa_Servicio_Uk; Type: CONSTRAINT; Schema: empresa; Owner: postgres
--

ALTER TABLE ONLY empresa.tblservicio
    ADD CONSTRAINT "Empresa_Servicio_Uk" UNIQUE (coservicio);


--
-- Name: tblserviciocaracteristica Inventario_ServicioCaracteristica_Pk; Type: CONSTRAINT; Schema: empresa; Owner: postgres
--

ALTER TABLE ONLY empresa.tblserviciocaracteristica
    ADD CONSTRAINT "Inventario_ServicioCaracteristica_Pk" PRIMARY KEY (coempresa, coserviciocaracteristica);


--
-- Name: tblserviciocaracteristica Inventario_ServicioCaracteristica_Uk; Type: CONSTRAINT; Schema: empresa; Owner: postgres
--

ALTER TABLE ONLY empresa.tblserviciocaracteristica
    ADD CONSTRAINT "Inventario_ServicioCaracteristica_Uk" UNIQUE (coserviciocaracteristica);


--
-- Name: tblcompradetalleimpuesto Facturacion_CompraDetalleImpuesto_ImpuestoHijo_Uk; Type: CONSTRAINT; Schema: facturacion; Owner: postgres
--

ALTER TABLE ONLY facturacion.tblcompradetalleimpuesto
    ADD CONSTRAINT "Facturacion_CompraDetalleImpuesto_ImpuestoHijo_Uk" UNIQUE (coempresa, cocompradetalle, coimpuesto, coimpuestohijo);


--
-- Name: tblcompradetalleimpuesto Facturacion_CompraDetalleImpuesto_Pk; Type: CONSTRAINT; Schema: facturacion; Owner: postgres
--

ALTER TABLE ONLY facturacion.tblcompradetalleimpuesto
    ADD CONSTRAINT "Facturacion_CompraDetalleImpuesto_Pk" PRIMARY KEY (coempresa, cocompradetalleimpuesto);


--
-- Name: tblcompradetalleimpuesto Facturacion_CompraDetalleImpuesto_Uk; Type: CONSTRAINT; Schema: facturacion; Owner: postgres
--

ALTER TABLE ONLY facturacion.tblcompradetalleimpuesto
    ADD CONSTRAINT "Facturacion_CompraDetalleImpuesto_Uk" UNIQUE (cocompradetalleimpuesto);


--
-- Name: tblcompradetalle Facturacion_CompraDetalle_Pk; Type: CONSTRAINT; Schema: facturacion; Owner: postgres
--

ALTER TABLE ONLY facturacion.tblcompradetalle
    ADD CONSTRAINT "Facturacion_CompraDetalle_Pk" PRIMARY KEY (coempresa, cocompradetalle);


--
-- Name: tblcompra Facturacion_Compra_Pk; Type: CONSTRAINT; Schema: facturacion; Owner: postgres
--

ALTER TABLE ONLY facturacion.tblcompra
    ADD CONSTRAINT "Facturacion_Compra_Pk" PRIMARY KEY (coempresa, cocompra);


--
-- Name: tblcorrelativo Facturacion_Correlativo_Pk; Type: CONSTRAINT; Schema: facturacion; Owner: postgres
--

ALTER TABLE ONLY facturacion.tblcorrelativo
    ADD CONSTRAINT "Facturacion_Correlativo_Pk" PRIMARY KEY (coempresa, cocorrelativo);


--
-- Name: tblcorrelativo Facturacion_Correlativo_TipoComprobante_Uk; Type: CONSTRAINT; Schema: facturacion; Owner: postgres
--

ALTER TABLE ONLY facturacion.tblcorrelativo
    ADD CONSTRAINT "Facturacion_Correlativo_TipoComprobante_Uk" UNIQUE (coempresa, colocal, cocomprobantepago, nuserie);


--
-- Name: tblcorrelativo Facturacion_Correlativo_Uk; Type: CONSTRAINT; Schema: facturacion; Owner: postgres
--

ALTER TABLE ONLY facturacion.tblcorrelativo
    ADD CONSTRAINT "Facturacion_Correlativo_Uk" UNIQUE (cocorrelativo);


--
-- Name: tblproformadetalle Facturacion_ProformaDetalle_Pk; Type: CONSTRAINT; Schema: facturacion; Owner: postgres
--

ALTER TABLE ONLY facturacion.tblproformadetalle
    ADD CONSTRAINT "Facturacion_ProformaDetalle_Pk" PRIMARY KEY (coempresa, coproformadetalle);


--
-- Name: tblproformadetalle Facturacion_ProformaDetalle_Uk; Type: CONSTRAINT; Schema: facturacion; Owner: postgres
--

ALTER TABLE ONLY facturacion.tblproformadetalle
    ADD CONSTRAINT "Facturacion_ProformaDetalle_Uk" UNIQUE (coproformadetalle);


--
-- Name: tblproforma Facturacion_Proforma_Pk; Type: CONSTRAINT; Schema: facturacion; Owner: postgres
--

ALTER TABLE ONLY facturacion.tblproforma
    ADD CONSTRAINT "Facturacion_Proforma_Pk" PRIMARY KEY (coempresa, coproforma);


--
-- Name: tblventadetalleimpuesto Facturacion_VentaDetalleImpuesto_Pk; Type: CONSTRAINT; Schema: facturacion; Owner: postgres
--

ALTER TABLE ONLY facturacion.tblventadetalleimpuesto
    ADD CONSTRAINT "Facturacion_VentaDetalleImpuesto_Pk" PRIMARY KEY (coempresa, coventadetalleimpuesto);


--
-- Name: tblventadetalleimpuesto Facturacion_VentaDetalleImpuesto_Uk; Type: CONSTRAINT; Schema: facturacion; Owner: postgres
--

ALTER TABLE ONLY facturacion.tblventadetalleimpuesto
    ADD CONSTRAINT "Facturacion_VentaDetalleImpuesto_Uk" UNIQUE (coempresa, coventadetalle, coimpuesto, coimpuestohijo);


--
-- Name: tblventadetalle Facturacion_VentaDetalle_Pk; Type: CONSTRAINT; Schema: facturacion; Owner: postgres
--

ALTER TABLE ONLY facturacion.tblventadetalle
    ADD CONSTRAINT "Facturacion_VentaDetalle_Pk" PRIMARY KEY (coempresa, coventadetalle);


--
-- Name: tblventadetalle Facturacion_VentaDetalle_Producto_Uk; Type: CONSTRAINT; Schema: facturacion; Owner: postgres
--

ALTER TABLE ONLY facturacion.tblventadetalle
    ADD CONSTRAINT "Facturacion_VentaDetalle_Producto_Uk" UNIQUE (coempresa, coventa, coproducto);


--
-- Name: tblventadetalle Facturacion_VentaDetalle_Uk; Type: CONSTRAINT; Schema: facturacion; Owner: postgres
--

ALTER TABLE ONLY facturacion.tblventadetalle
    ADD CONSTRAINT "Facturacion_VentaDetalle_Uk" UNIQUE (coventadetalle);


--
-- Name: tblventa Facturacion_Venta_Pk; Type: CONSTRAINT; Schema: facturacion; Owner: postgres
--

ALTER TABLE ONLY facturacion.tblventa
    ADD CONSTRAINT "Facturacion_Venta_Pk" PRIMARY KEY (coempresa, coventa);


--
-- Name: tblventa Facturacion_Venta_Uk; Type: CONSTRAINT; Schema: facturacion; Owner: postgres
--

ALTER TABLE ONLY facturacion.tblventa
    ADD CONSTRAINT "Facturacion_Venta_Uk" UNIQUE (coventa);


--
-- Name: tblalmacen Inventario_Almacen_Pk; Type: CONSTRAINT; Schema: inventario; Owner: postgres
--

ALTER TABLE ONLY inventario.tblalmacen
    ADD CONSTRAINT "Inventario_Almacen_Pk" PRIMARY KEY (coempresa, coalmacen);


--
-- Name: tblalmacen Inventario_Almacen_Uk; Type: CONSTRAINT; Schema: inventario; Owner: postgres
--

ALTER TABLE ONLY inventario.tblalmacen
    ADD CONSTRAINT "Inventario_Almacen_Uk" UNIQUE (coalmacen);


--
-- Name: tblinventariodetalle Inventario_InventarioDetalle_Pk; Type: CONSTRAINT; Schema: inventario; Owner: postgres
--

ALTER TABLE ONLY inventario.tblinventariodetalle
    ADD CONSTRAINT "Inventario_InventarioDetalle_Pk" PRIMARY KEY (coempresa, coinventariodetalle);


--
-- Name: tblinventariodetalle Inventario_InventarioDetalle_Uk; Type: CONSTRAINT; Schema: inventario; Owner: postgres
--

ALTER TABLE ONLY inventario.tblinventariodetalle
    ADD CONSTRAINT "Inventario_InventarioDetalle_Uk" UNIQUE (coinventariodetalle);


--
-- Name: tblinventario Inventario_Inventario_Pk; Type: CONSTRAINT; Schema: inventario; Owner: postgres
--

ALTER TABLE ONLY inventario.tblinventario
    ADD CONSTRAINT "Inventario_Inventario_Pk" PRIMARY KEY (coempresa, coinventario);


--
-- Name: tblinventario Inventario_Inventario_Uk; Type: CONSTRAINT; Schema: inventario; Owner: postgres
--

ALTER TABLE ONLY inventario.tblinventario
    ADD CONSTRAINT "Inventario_Inventario_Uk" UNIQUE (coinventario);


--
-- Name: tblstock Inventario_Stock_Pk; Type: CONSTRAINT; Schema: inventario; Owner: postgres
--

ALTER TABLE ONLY inventario.tblstock
    ADD CONSTRAINT "Inventario_Stock_Pk" PRIMARY KEY (coempresa, costock);


--
-- Name: tblstock Inventario_Stock_Producto_Uk; Type: CONSTRAINT; Schema: inventario; Owner: postgres
--

ALTER TABLE ONLY inventario.tblstock
    ADD CONSTRAINT "Inventario_Stock_Producto_Uk" UNIQUE (coempresa, coalmacen, coproducto);


--
-- Name: tblstock Inventario_Stock_Uk; Type: CONSTRAINT; Schema: inventario; Owner: postgres
--

ALTER TABLE ONLY inventario.tblstock
    ADD CONSTRAINT "Inventario_Stock_Uk" UNIQUE (costock);


--
-- Name: tblarchivo Maestro_Archivo_Entidad_Uk; Type: CONSTRAINT; Schema: maestro; Owner: postgres
--

ALTER TABLE ONLY maestro.tblarchivo
    ADD CONSTRAINT "Maestro_Archivo_Entidad_Uk" UNIQUE (coempresa, cotipoentidad, coentidad, cotipo, nuorden);


--
-- Name: tblarchivo Maestro_Archivo_Pk; Type: CONSTRAINT; Schema: maestro; Owner: postgres
--

ALTER TABLE ONLY maestro.tblarchivo
    ADD CONSTRAINT "Maestro_Archivo_Pk" PRIMARY KEY (coempresa, coarchivo);


--
-- Name: tblarchivo Maestro_Archivo_Uk; Type: CONSTRAINT; Schema: maestro; Owner: postgres
--

ALTER TABLE ONLY maestro.tblarchivo
    ADD CONSTRAINT "Maestro_Archivo_Uk" UNIQUE (coarchivo);


--
-- Name: trfdocumentoidentidad Maestro_DocumentoIdentidad_Pk; Type: CONSTRAINT; Schema: maestro; Owner: postgres
--

ALTER TABLE ONLY maestro.trfdocumentoidentidad
    ADD CONSTRAINT "Maestro_DocumentoIdentidad_Pk" PRIMARY KEY (codocumentoidentidad);


--
-- Name: trfmoneda Maestro_Moneda_Pk; Type: CONSTRAINT; Schema: maestro; Owner: postgres
--

ALTER TABLE ONLY maestro.trfmoneda
    ADD CONSTRAINT "Maestro_Moneda_Pk" PRIMARY KEY (comoneda);


--
-- Name: trfmoneda Maestro_Moneda_Uk; Type: CONSTRAINT; Schema: maestro; Owner: postgres
--

ALTER TABLE ONLY maestro.trfmoneda
    ADD CONSTRAINT "Maestro_Moneda_Uk" UNIQUE (nocodigoiso);


--
-- Name: trfpais Maestro_Pais_Pk; Type: CONSTRAINT; Schema: maestro; Owner: postgres
--

ALTER TABLE ONLY maestro.trfpais
    ADD CONSTRAINT "Maestro_Pais_Pk" PRIMARY KEY (copais);


--
-- Name: trfpais Maestro_Pais_Uk; Type: CONSTRAINT; Schema: maestro; Owner: postgres
--

ALTER TABLE ONLY maestro.trfpais
    ADD CONSTRAINT "Maestro_Pais_Uk" UNIQUE (nocodigoiso3);


--
-- Name: trftipoparticular Maestro_TipoParticular_Uk; Type: CONSTRAINT; Schema: maestro; Owner: postgres
--

ALTER TABLE ONLY maestro.trftipoparticular
    ADD CONSTRAINT "Maestro_TipoParticular_Uk" UNIQUE (cogrupo, coempresa, comodulo, nuorden);


--
-- Name: trfunidadmedida Maestro_UnidadMedida_Pk; Type: CONSTRAINT; Schema: maestro; Owner: postgres
--

ALTER TABLE ONLY maestro.trfunidadmedida
    ADD CONSTRAINT "Maestro_UnidadMedida_Pk" PRIMARY KEY (counidadmedida);


--
-- Name: tblentidad maestro_entidad_pk; Type: CONSTRAINT; Schema: maestro; Owner: postgres
--

ALTER TABLE ONLY maestro.tblentidad
    ADD CONSTRAINT maestro_entidad_pk PRIMARY KEY (coentidad);


--
-- Name: tblentidaddireccion maestro_entidaddireccion_pk; Type: CONSTRAINT; Schema: maestro; Owner: postgres
--

ALTER TABLE ONLY maestro.tblentidaddireccion
    ADD CONSTRAINT maestro_entidaddireccion_pk PRIMARY KEY (coentidaddireccion);


--
-- Name: tblentidaddocumento maestro_entidaddocumento_pk; Type: CONSTRAINT; Schema: maestro; Owner: postgres
--

ALTER TABLE ONLY maestro.tblentidaddocumento
    ADD CONSTRAINT maestro_entidaddocumento_pk PRIMARY KEY (coentidaddocumento);


--
-- Name: tblentidaddocumento maestro_entidaddocumento_uk; Type: CONSTRAINT; Schema: maestro; Owner: postgres
--

ALTER TABLE ONLY maestro.tblentidaddocumento
    ADD CONSTRAINT maestro_entidaddocumento_uk UNIQUE (codocumentoidentidad, nudocumento);


--
-- Name: tblentidadempresa maestro_entidadempresa_pk; Type: CONSTRAINT; Schema: maestro; Owner: postgres
--

ALTER TABLE ONLY maestro.tblentidadempresa
    ADD CONSTRAINT maestro_entidadempresa_pk PRIMARY KEY (coentidadempresa);


--
-- Name: tblentidadempresa maestro_entidadempresa_uk; Type: CONSTRAINT; Schema: maestro; Owner: postgres
--

ALTER TABLE ONLY maestro.tblentidadempresa
    ADD CONSTRAINT maestro_entidadempresa_uk UNIQUE (coempresa, coentidad);


--
-- Name: tblentidadrol maestro_entidadempresarol_pk; Type: CONSTRAINT; Schema: maestro; Owner: postgres
--

ALTER TABLE ONLY maestro.tblentidadrol
    ADD CONSTRAINT maestro_entidadempresarol_pk PRIMARY KEY (coempresa, coentidad, corolnegocio);


--
-- Name: tblentidadredsocial maestro_entidadredsocial_pk; Type: CONSTRAINT; Schema: maestro; Owner: postgres
--

ALTER TABLE ONLY maestro.tblentidadredsocial
    ADD CONSTRAINT maestro_entidadredsocial_pk PRIMARY KEY (coentidadredsocial);


--
-- Name: tblpersonajuridica maestro_personajuridica_pk; Type: CONSTRAINT; Schema: maestro; Owner: postgres
--

ALTER TABLE ONLY maestro.tblpersonajuridica
    ADD CONSTRAINT maestro_personajuridica_pk PRIMARY KEY (coentidad);


--
-- Name: tblpersonanatural maestro_personanatural_pk; Type: CONSTRAINT; Schema: maestro; Owner: postgres
--

ALTER TABLE ONLY maestro.tblpersonanatural
    ADD CONSTRAINT maestro_personanatural_pk PRIMARY KEY (coentidad);


--
-- Name: trftipogeneral maestro_tipogeneral_pk; Type: CONSTRAINT; Schema: maestro; Owner: postgres
--

ALTER TABLE ONLY maestro.trftipogeneral
    ADD CONSTRAINT maestro_tipogeneral_pk PRIMARY KEY (cotipogeneral);


--
-- Name: trftipogeneral maestro_tipogeneral_uk; Type: CONSTRAINT; Schema: maestro; Owner: postgres
--

ALTER TABLE ONLY maestro.trftipogeneral
    ADD CONSTRAINT maestro_tipogeneral_uk UNIQUE (cogrupo, nuorden);


--
-- Name: trftipoparticular maestro_tipoparticular_pk; Type: CONSTRAINT; Schema: maestro; Owner: postgres
--

ALTER TABLE ONLY maestro.trftipoparticular
    ADD CONSTRAINT maestro_tipoparticular_pk PRIMARY KEY (cotipoparticular);


--
-- Name: trfubigeo maestro_ubigeo_Uk; Type: CONSTRAINT; Schema: maestro; Owner: postgres
--

ALTER TABLE ONLY maestro.trfubigeo
    ADD CONSTRAINT "maestro_ubigeo_Uk" UNIQUE (copais, nocodigo);


--
-- Name: trfubigeo maestro_ubigeo_pk; Type: CONSTRAINT; Schema: maestro; Owner: postgres
--

ALTER TABLE ONLY maestro.trfubigeo
    ADD CONSTRAINT maestro_ubigeo_pk PRIMARY KEY (coubigeo);


--
-- Name: trfunidadmedida uk_unidad; Type: CONSTRAINT; Schema: maestro; Owner: postgres
--

ALTER TABLE ONLY maestro.trfunidadmedida
    ADD CONSTRAINT uk_unidad UNIQUE (copais, nocodigoiso);


--
-- Name: audgeneral Seguridad_AudGeneral_Pk; Type: CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.audgeneral
    ADD CONSTRAINT "Seguridad_AudGeneral_Pk" PRIMARY KEY (coempresa, coauditoria);


--
-- Name: audgeneral Seguridad_AudGeneral_Uk; Type: CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.audgeneral
    ADD CONSTRAINT "Seguridad_AudGeneral_Uk" UNIQUE (coauditoria);


--
-- Name: segempresamodulo Seguridad_EmpresaModulo_Pk; Type: CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.segempresamodulo
    ADD CONSTRAINT "Seguridad_EmpresaModulo_Pk" PRIMARY KEY (coempresamodulo);


--
-- Name: segempresamodulo Seguridad_EmpresaModulo_Uk; Type: CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.segempresamodulo
    ADD CONSTRAINT "Seguridad_EmpresaModulo_Uk" UNIQUE (coempresa, comodulo);


--
-- Name: tblempresa Seguridad_Empresa_Pk; Type: CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.tblempresa
    ADD CONSTRAINT "Seguridad_Empresa_Pk" PRIMARY KEY (coempresa);


--
-- Name: segmenu Seguridad_Menu_Pk; Type: CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.segmenu
    ADD CONSTRAINT "Seguridad_Menu_Pk" PRIMARY KEY (comenu);


--
-- Name: segmenu Seguridad_Menu_Uk; Type: CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.segmenu
    ADD CONSTRAINT "Seguridad_Menu_Uk" UNIQUE (comodulo, comenu);


--
-- Name: segpagina Seguridad_Pagina_Pk; Type: CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.segpagina
    ADD CONSTRAINT "Seguridad_Pagina_Pk" PRIMARY KEY (copagina);


--
-- Name: segpagina Seguridad_Pagina_Uk; Type: CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.segpagina
    ADD CONSTRAINT "Seguridad_Pagina_Uk" UNIQUE (comodulo, comenu, copagina);


--
-- Name: segperfilpagina Seguridad_PerfilPagina_Pk; Type: CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.segperfilpagina
    ADD CONSTRAINT "Seguridad_PerfilPagina_Pk" PRIMARY KEY (coperfilpagina);


--
-- Name: segperfil Seguridad_Perfil_Pk; Type: CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.segperfil
    ADD CONSTRAINT "Seguridad_Perfil_Pk" PRIMARY KEY (coperfil);


--
-- Name: segperfil Seguridad_Perfil_uK; Type: CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.segperfil
    ADD CONSTRAINT "Seguridad_Perfil_uK" UNIQUE (comodulo, coperfil);


--
-- Name: tblusuario Seguridad_Usuario_Uk; Type: CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.tblusuario
    ADD CONSTRAINT "Seguridad_Usuario_Uk" UNIQUE (nousuario) INCLUDE (noclave);


--
-- Name: tblingreso maestro_ingreso_pk; Type: CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.tblingreso
    ADD CONSTRAINT maestro_ingreso_pk PRIMARY KEY (coingreso);


--
-- Name: tblempresa seguridad_empresa_uk; Type: CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.tblempresa
    ADD CONSTRAINT seguridad_empresa_uk UNIQUE (coentidad);


--
-- Name: segmodulo seguridad_modulo_pk; Type: CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.segmodulo
    ADD CONSTRAINT seguridad_modulo_pk PRIMARY KEY (comodulo);


--
-- Name: segmodulousuario seguridad_modulousuario_pk; Type: CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.segmodulousuario
    ADD CONSTRAINT seguridad_modulousuario_pk PRIMARY KEY (comodulousuario);


--
-- Name: segmodulousuario seguridad_modulousuario_uk; Type: CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.segmodulousuario
    ADD CONSTRAINT seguridad_modulousuario_uk UNIQUE (cousuario, coempresa, comodulo);


--
-- Name: tblusuario seguridad_usuario_pk; Type: CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.tblusuario
    ADD CONSTRAINT seguridad_usuario_pk PRIMARY KEY (cousuario);


--
-- Name: catalogo_productoindex_busqueda_idx; Type: INDEX; Schema: catalogo; Owner: postgres
--

CREATE INDEX catalogo_productoindex_busqueda_idx ON catalogo.tblproductoindex USING btree (txbusqueda) WITH (deduplicate_items='true');


--
-- Name: catalogo_productoindex_categoria_idx; Type: INDEX; Schema: catalogo; Owner: postgres
--

CREATE INDEX catalogo_productoindex_categoria_idx ON catalogo.tblproductoindex USING btree (cocategoria) WITH (deduplicate_items='true');


--
-- Name: catalogo_productoindex_empresa_idx; Type: INDEX; Schema: catalogo; Owner: postgres
--

CREATE INDEX catalogo_productoindex_empresa_idx ON catalogo.tblproductoindex USING btree (coempresa);


--
-- Name: catalogo_productoindex_jsonatributo_idx; Type: INDEX; Schema: catalogo; Owner: postgres
--

CREATE INDEX catalogo_productoindex_jsonatributo_idx ON catalogo.tblproductoindex USING btree (jsonatributo) WITH (deduplicate_items='true');


--
-- Name: catalogo_tblproducto_coproveedorprincipal_idx; Type: INDEX; Schema: catalogo; Owner: postgres
--

CREATE INDEX catalogo_tblproducto_coproveedorprincipal_idx ON catalogo.tblproducto USING btree (coproveedorprincipal);


--
-- Name: catalogo_tblproductostock_coalmacen_idx; Type: INDEX; Schema: catalogo; Owner: postgres
--

CREATE INDEX catalogo_tblproductostock_coalmacen_idx ON catalogo.tblproductostock USING btree (coalmacen);


--
-- Name: catalogo_tblproductostock_colocal_idx; Type: INDEX; Schema: catalogo; Owner: postgres
--

CREATE INDEX catalogo_tblproductostock_colocal_idx ON catalogo.tblproductostock USING btree (colocal);


--
-- Name: uq_catalogo_tblatributo_empresa_id; Type: INDEX; Schema: catalogo; Owner: postgres
--

CREATE UNIQUE INDEX uq_catalogo_tblatributo_empresa_id ON catalogo.tblatributo USING btree (coempresa, coatributo);


--
-- Name: uq_catalogo_tblproductoatributo_empresa_id; Type: INDEX; Schema: catalogo; Owner: postgres
--

CREATE UNIQUE INDEX uq_catalogo_tblproductoatributo_empresa_id ON catalogo.tblproductoatributo USING btree (coempresa, coproductoatributo);


--
-- Name: uq_catalogo_tblproductoindex_empresa_id; Type: INDEX; Schema: catalogo; Owner: postgres
--

CREATE UNIQUE INDEX uq_catalogo_tblproductoindex_empresa_id ON catalogo.tblproductoindex USING btree (coempresa, coproductoindex);


--
-- Name: uq_producto_tblproducto_empresa_id; Type: INDEX; Schema: catalogo; Owner: postgres
--

CREATE UNIQUE INDEX uq_producto_tblproducto_empresa_id ON catalogo.tblproducto USING btree (coempresa, coproducto);


--
-- Name: uq_producto_tblproductoimpuesto_empresa_id; Type: INDEX; Schema: catalogo; Owner: postgres
--

CREATE UNIQUE INDEX uq_producto_tblproductoimpuesto_empresa_id ON catalogo.tblproductoimpuesto USING btree (coempresa, coproductoimpuesto);


--
-- Name: uq_producto_tblproductoprecio_empresa_id; Type: INDEX; Schema: catalogo; Owner: postgres
--

CREATE UNIQUE INDEX uq_producto_tblproductoprecio_empresa_id ON catalogo.tblproductoprecio USING btree (coempresa, coproductoprecio);


--
-- Name: uq_producto_tblproductostock_empresa_id; Type: INDEX; Schema: catalogo; Owner: postgres
--

CREATE UNIQUE INDEX uq_producto_tblproductostock_empresa_id ON catalogo.tblproductostock USING btree (coempresa, coproductostock);


--
-- Name: uq_producto_tblproductoterminado_empresa_id; Type: INDEX; Schema: catalogo; Owner: postgres
--

CREATE UNIQUE INDEX uq_producto_tblproductoterminado_empresa_id ON catalogo.tblproductoterminado USING btree (coempresa, coproductoterminado);


--
-- Name: contabilidad_trfimpuestohijo_copais_idx; Type: INDEX; Schema: contabilidad; Owner: postgres
--

CREATE INDEX contabilidad_trfimpuestohijo_copais_idx ON contabilidad.trfimpuestohijo USING btree (copais);


--
-- Name: contabilidad_trfimpuestohijo_counidadmedida_idx; Type: INDEX; Schema: contabilidad; Owner: postgres
--

CREATE INDEX contabilidad_trfimpuestohijo_counidadmedida_idx ON contabilidad.trfimpuestohijo USING btree (counidadmedida);


--
-- Name: uq_contabilidad_tbltipocambio_empresa_id; Type: INDEX; Schema: contabilidad; Owner: postgres
--

CREATE UNIQUE INDEX uq_contabilidad_tbltipocambio_empresa_id ON contabilidad.tbltipocambio USING btree (coempresa, cotipocambio);


--
-- Name: empresa_tblblog_coautor_idx; Type: INDEX; Schema: empresa; Owner: postgres
--

CREATE INDEX empresa_tblblog_coautor_idx ON empresa.tblblog USING btree (coautor);


--
-- Name: empresa_tblequipo_copersona_idx; Type: INDEX; Schema: empresa; Owner: postgres
--

CREATE INDEX empresa_tblequipo_copersona_idx ON empresa.tblequipo USING btree (coprofesional);


--
-- Name: empresa_tbllocal_coubigeo_idx; Type: INDEX; Schema: empresa; Owner: postgres
--

CREATE INDEX empresa_tbllocal_coubigeo_idx ON empresa.tbllocal USING btree (coubigeo);


--
-- Name: uq_empresa_tblbandejaentrada_empresa_id; Type: INDEX; Schema: empresa; Owner: postgres
--

CREATE UNIQUE INDEX uq_empresa_tblbandejaentrada_empresa_id ON empresa.tblbandejaentrada USING btree (coempresa, cobandejaentrada);


--
-- Name: uq_empresa_tblblog_empresa_id; Type: INDEX; Schema: empresa; Owner: postgres
--

CREATE UNIQUE INDEX uq_empresa_tblblog_empresa_id ON empresa.tblblog USING btree (coempresa, coblog);


--
-- Name: uq_empresa_tblblogmensaje_empresa_id; Type: INDEX; Schema: empresa; Owner: postgres
--

CREATE UNIQUE INDEX uq_empresa_tblblogmensaje_empresa_id ON empresa.tblblogmensaje USING btree (coempresa, coblogmensaje);


--
-- Name: uq_empresa_tblcliente_empresa_id; Type: INDEX; Schema: empresa; Owner: postgres
--

CREATE UNIQUE INDEX uq_empresa_tblcliente_empresa_id ON empresa.tblcliente USING btree (coempresa, cocliente);


--
-- Name: uq_empresa_tblequipo_empresa_id; Type: INDEX; Schema: empresa; Owner: postgres
--

CREATE UNIQUE INDEX uq_empresa_tblequipo_empresa_id ON empresa.tblequipo USING btree (coempresa, coequipo);


--
-- Name: uq_empresa_tblhorario_empresa_id; Type: INDEX; Schema: empresa; Owner: postgres
--

CREATE UNIQUE INDEX uq_empresa_tblhorario_empresa_id ON empresa.tblhorario USING btree (coempresa, cohorario);


--
-- Name: uq_empresa_tbllocal_empresa_id; Type: INDEX; Schema: empresa; Owner: postgres
--

CREATE UNIQUE INDEX uq_empresa_tbllocal_empresa_id ON empresa.tbllocal USING btree (coempresa, colocal);


--
-- Name: uq_empresa_tblpregunta_empresa_id; Type: INDEX; Schema: empresa; Owner: postgres
--

CREATE UNIQUE INDEX uq_empresa_tblpregunta_empresa_id ON empresa.tblpregunta USING btree (coempresa, copregunta);


--
-- Name: uq_empresa_tblservicio_empresa_id; Type: INDEX; Schema: empresa; Owner: postgres
--

CREATE UNIQUE INDEX uq_empresa_tblservicio_empresa_id ON empresa.tblservicio USING btree (coempresa, coservicio);


--
-- Name: uq_empresa_tblserviciocaracteristica_empresa_id; Type: INDEX; Schema: empresa; Owner: postgres
--

CREATE UNIQUE INDEX uq_empresa_tblserviciocaracteristica_empresa_id ON empresa.tblserviciocaracteristica USING btree (coempresa, coserviciocaracteristica);


--
-- Name: facturacion_tblcompra_cocomprobantepago_idx; Type: INDEX; Schema: facturacion; Owner: postgres
--

CREATE INDEX facturacion_tblcompra_cocomprobantepago_idx ON facturacion.tblcompra USING btree (cocomprobantepago);


--
-- Name: facturacion_tblcompra_colocal_idx; Type: INDEX; Schema: facturacion; Owner: postgres
--

CREATE INDEX facturacion_tblcompra_colocal_idx ON facturacion.tblcompra USING btree (colocal);


--
-- Name: facturacion_tblcompra_comediopago_idx; Type: INDEX; Schema: facturacion; Owner: postgres
--

CREATE INDEX facturacion_tblcompra_comediopago_idx ON facturacion.tblcompra USING btree (comediopago);


--
-- Name: facturacion_tblcompra_comoneda_idx; Type: INDEX; Schema: facturacion; Owner: postgres
--

CREATE INDEX facturacion_tblcompra_comoneda_idx ON facturacion.tblcompra USING btree (comoneda);


--
-- Name: facturacion_tblcompra_coproveedor_idx; Type: INDEX; Schema: facturacion; Owner: postgres
--

CREATE INDEX facturacion_tblcompra_coproveedor_idx ON facturacion.tblcompra USING btree (coproveedor);


--
-- Name: facturacion_tblcompra_cotipocambio_idx; Type: INDEX; Schema: facturacion; Owner: postgres
--

CREATE INDEX facturacion_tblcompra_cotipocambio_idx ON facturacion.tblcompra USING btree (cotipocambio);


--
-- Name: facturacion_tblcompradetalle_coalmacen_idx; Type: INDEX; Schema: facturacion; Owner: postgres
--

CREATE INDEX facturacion_tblcompradetalle_coalmacen_idx ON facturacion.tblcompradetalle USING btree (coalmacen);


--
-- Name: facturacion_tblcompradetalle_colocal_idx; Type: INDEX; Schema: facturacion; Owner: postgres
--

CREATE INDEX facturacion_tblcompradetalle_colocal_idx ON facturacion.tblcompradetalle USING btree (colocal);


--
-- Name: facturacion_tblcompradetalle_coproducto_idx; Type: INDEX; Schema: facturacion; Owner: postgres
--

CREATE INDEX facturacion_tblcompradetalle_coproducto_idx ON facturacion.tblcompradetalle USING btree (coproducto);


--
-- Name: facturacion_tblproforma_cocliente_idx; Type: INDEX; Schema: facturacion; Owner: postgres
--

CREATE INDEX facturacion_tblproforma_cocliente_idx ON facturacion.tblproforma USING btree (cocliente);


--
-- Name: facturacion_tblproforma_colocal_idx; Type: INDEX; Schema: facturacion; Owner: postgres
--

CREATE INDEX facturacion_tblproforma_colocal_idx ON facturacion.tblproforma USING btree (colocal);


--
-- Name: facturacion_tblproforma_comoneda_idx; Type: INDEX; Schema: facturacion; Owner: postgres
--

CREATE INDEX facturacion_tblproforma_comoneda_idx ON facturacion.tblproforma USING btree (comoneda);


--
-- Name: facturacion_tblproformadetalle_coproducto_idx; Type: INDEX; Schema: facturacion; Owner: postgres
--

CREATE INDEX facturacion_tblproformadetalle_coproducto_idx ON facturacion.tblproformadetalle USING btree (coproducto);


--
-- Name: facturacion_tblventa_cocliente_idx; Type: INDEX; Schema: facturacion; Owner: postgres
--

CREATE INDEX facturacion_tblventa_cocliente_idx ON facturacion.tblventa USING btree (cocliente);


--
-- Name: facturacion_tblventa_cocomprobantepago_idx; Type: INDEX; Schema: facturacion; Owner: postgres
--

CREATE INDEX facturacion_tblventa_cocomprobantepago_idx ON facturacion.tblventa USING btree (cocomprobantepago);


--
-- Name: facturacion_tblventa_colocal_idx; Type: INDEX; Schema: facturacion; Owner: postgres
--

CREATE INDEX facturacion_tblventa_colocal_idx ON facturacion.tblventa USING btree (colocal);


--
-- Name: facturacion_tblventa_comediopago_idx; Type: INDEX; Schema: facturacion; Owner: postgres
--

CREATE INDEX facturacion_tblventa_comediopago_idx ON facturacion.tblventa USING btree (comediopago);


--
-- Name: facturacion_tblventa_comoneda_idx; Type: INDEX; Schema: facturacion; Owner: postgres
--

CREATE INDEX facturacion_tblventa_comoneda_idx ON facturacion.tblventa USING btree (comoneda);


--
-- Name: facturacion_tblventa_cotipocambio_idx; Type: INDEX; Schema: facturacion; Owner: postgres
--

CREATE INDEX facturacion_tblventa_cotipocambio_idx ON facturacion.tblventa USING btree (cotipocambio);


--
-- Name: facturacion_tblventadetalle_coalmacen_idx; Type: INDEX; Schema: facturacion; Owner: postgres
--

CREATE INDEX facturacion_tblventadetalle_coalmacen_idx ON facturacion.tblventadetalle USING btree (coalmacen);


--
-- Name: facturacion_tblventadetalle_colocal_idx; Type: INDEX; Schema: facturacion; Owner: postgres
--

CREATE INDEX facturacion_tblventadetalle_colocal_idx ON facturacion.tblventadetalle USING btree (colocal);


--
-- Name: uq_facturacion_tblcompra_empresa_id; Type: INDEX; Schema: facturacion; Owner: postgres
--

CREATE UNIQUE INDEX uq_facturacion_tblcompra_empresa_id ON facturacion.tblcompra USING btree (coempresa, cocompra);


--
-- Name: uq_facturacion_tblcompradetalle_empresa_id; Type: INDEX; Schema: facturacion; Owner: postgres
--

CREATE UNIQUE INDEX uq_facturacion_tblcompradetalle_empresa_id ON facturacion.tblcompradetalle USING btree (coempresa, cocompradetalle);


--
-- Name: uq_facturacion_tblcompradetalleimpuesto_empresa_id; Type: INDEX; Schema: facturacion; Owner: postgres
--

CREATE UNIQUE INDEX uq_facturacion_tblcompradetalleimpuesto_empresa_id ON facturacion.tblcompradetalleimpuesto USING btree (coempresa, cocompradetalleimpuesto);


--
-- Name: uq_facturacion_tblcorrelativo_empresa_id; Type: INDEX; Schema: facturacion; Owner: postgres
--

CREATE UNIQUE INDEX uq_facturacion_tblcorrelativo_empresa_id ON facturacion.tblcorrelativo USING btree (coempresa, cocorrelativo);


--
-- Name: uq_facturacion_tblproforma_empresa_id; Type: INDEX; Schema: facturacion; Owner: postgres
--

CREATE UNIQUE INDEX uq_facturacion_tblproforma_empresa_id ON facturacion.tblproforma USING btree (coempresa, coproforma);


--
-- Name: uq_facturacion_tblproformadetalle_empresa_id; Type: INDEX; Schema: facturacion; Owner: postgres
--

CREATE UNIQUE INDEX uq_facturacion_tblproformadetalle_empresa_id ON facturacion.tblproformadetalle USING btree (coempresa, coproformadetalle);


--
-- Name: uq_facturacion_tblventa_empresa_id; Type: INDEX; Schema: facturacion; Owner: postgres
--

CREATE UNIQUE INDEX uq_facturacion_tblventa_empresa_id ON facturacion.tblventa USING btree (coempresa, coventa);


--
-- Name: uq_facturacion_tblventadetalle_empresa_id; Type: INDEX; Schema: facturacion; Owner: postgres
--

CREATE UNIQUE INDEX uq_facturacion_tblventadetalle_empresa_id ON facturacion.tblventadetalle USING btree (coempresa, coventadetalle);


--
-- Name: uq_facturacion_tblventadetalleimpuesto_empresa_id; Type: INDEX; Schema: facturacion; Owner: postgres
--

CREATE UNIQUE INDEX uq_facturacion_tblventadetalleimpuesto_empresa_id ON facturacion.tblventadetalleimpuesto USING btree (coempresa, coventadetalleimpuesto);


--
-- Name: inventario_tblalmacen_colocal_idx; Type: INDEX; Schema: inventario; Owner: postgres
--

CREATE INDEX inventario_tblalmacen_colocal_idx ON inventario.tblalmacen USING btree (colocal);


--
-- Name: inventario_tblinventario_cocompra_idx; Type: INDEX; Schema: inventario; Owner: postgres
--

CREATE INDEX inventario_tblinventario_cocompra_idx ON inventario.tblinventario USING btree (cocompra);


--
-- Name: inventario_tblinventario_coventa_idx; Type: INDEX; Schema: inventario; Owner: postgres
--

CREATE INDEX inventario_tblinventario_coventa_idx ON inventario.tblinventario USING btree (coventa);


--
-- Name: inventario_tblinventariodetalle_coalmacen_idx; Type: INDEX; Schema: inventario; Owner: postgres
--

CREATE INDEX inventario_tblinventariodetalle_coalmacen_idx ON inventario.tblinventariodetalle USING btree (coalmacen);


--
-- Name: inventario_tblinventariodetalle_colocal_idx; Type: INDEX; Schema: inventario; Owner: postgres
--

CREATE INDEX inventario_tblinventariodetalle_colocal_idx ON inventario.tblinventariodetalle USING btree (colocal);


--
-- Name: inventario_tblinventariodetalle_coproducto_idx; Type: INDEX; Schema: inventario; Owner: postgres
--

CREATE INDEX inventario_tblinventariodetalle_coproducto_idx ON inventario.tblinventariodetalle USING btree (coproducto);


--
-- Name: inventario_tblinventariodetalle_coventadetalle_idx; Type: INDEX; Schema: inventario; Owner: postgres
--

CREATE INDEX inventario_tblinventariodetalle_coventadetalle_idx ON inventario.tblinventariodetalle USING btree (coventadetalle);


--
-- Name: inventario_tblstock_colocal_idx; Type: INDEX; Schema: inventario; Owner: postgres
--

CREATE INDEX inventario_tblstock_colocal_idx ON inventario.tblstock USING btree (colocal);


--
-- Name: uq_inventario_tblalmacen_empresa_id; Type: INDEX; Schema: inventario; Owner: postgres
--

CREATE UNIQUE INDEX uq_inventario_tblalmacen_empresa_id ON inventario.tblalmacen USING btree (coempresa, coalmacen);


--
-- Name: uq_inventario_tblinventario_empresa_id; Type: INDEX; Schema: inventario; Owner: postgres
--

CREATE UNIQUE INDEX uq_inventario_tblinventario_empresa_id ON inventario.tblinventario USING btree (coempresa, coinventario);


--
-- Name: uq_inventario_tblinventariodetalle_empresa_id; Type: INDEX; Schema: inventario; Owner: postgres
--

CREATE UNIQUE INDEX uq_inventario_tblinventariodetalle_empresa_id ON inventario.tblinventariodetalle USING btree (coempresa, coinventariodetalle);


--
-- Name: uq_inventario_tblstock_empresa_id; Type: INDEX; Schema: inventario; Owner: postgres
--

CREATE UNIQUE INDEX uq_inventario_tblstock_empresa_id ON inventario.tblstock USING btree (coempresa, costock);


--
-- Name: idx_entidaddocumento_coentidad; Type: INDEX; Schema: maestro; Owner: postgres
--

CREATE INDEX idx_entidaddocumento_coentidad ON maestro.tblentidaddocumento USING btree (coentidad);


--
-- Name: idx_personadireccion_persona; Type: INDEX; Schema: maestro; Owner: postgres
--

CREATE INDEX idx_personadireccion_persona ON maestro.tblentidaddireccion USING btree (coentidad);


--
-- Name: idx_personadireccion_persona_default; Type: INDEX; Schema: maestro; Owner: postgres
--

CREATE INDEX idx_personadireccion_persona_default ON maestro.tblentidaddireccion USING btree (coentidad, fldefault);


--
-- Name: maestro_archivo_entidad_idx; Type: INDEX; Schema: maestro; Owner: postgres
--

CREATE INDEX maestro_archivo_entidad_idx ON maestro.tblarchivo USING btree (cotipoentidad, coentidad);


--
-- Name: maestro_archivo_tipoimagen_idx; Type: INDEX; Schema: maestro; Owner: postgres
--

CREATE INDEX maestro_archivo_tipoimagen_idx ON maestro.tblarchivo USING btree (cotipo);


--
-- Name: maestro_tblredsocial_copersona_idx; Type: INDEX; Schema: maestro; Owner: postgres
--

CREATE INDEX maestro_tblredsocial_copersona_idx ON maestro.tblentidadredsocial USING btree (coentidad);


--
-- Name: maestro_trfdocumentoidentidad_copais_idx; Type: INDEX; Schema: maestro; Owner: postgres
--

CREATE INDEX maestro_trfdocumentoidentidad_copais_idx ON maestro.trfdocumentoidentidad USING btree (copais);


--
-- Name: maestro_trfpais_comoneda_idx; Type: INDEX; Schema: maestro; Owner: postgres
--

CREATE INDEX maestro_trfpais_comoneda_idx ON maestro.trfpais USING btree (comoneda);


--
-- Name: maestro_trftipogeneral_comodulo_idx; Type: INDEX; Schema: maestro; Owner: postgres
--

CREATE INDEX maestro_trftipogeneral_comodulo_idx ON maestro.trftipogeneral USING btree (comodulo);


--
-- Name: maestro_trftipogeneral_nocomando_idx; Type: INDEX; Schema: maestro; Owner: postgres
--

CREATE INDEX maestro_trftipogeneral_nocomando_idx ON maestro.trftipogeneral USING btree (nocomando);


--
-- Name: trftipoparticular_coempresa_cogrupo_idx; Type: INDEX; Schema: maestro; Owner: postgres
--

CREATE UNIQUE INDEX trftipoparticular_coempresa_cogrupo_idx ON maestro.trftipoparticular USING btree (coempresa, cogrupo) WHERE (fldefault = true);


--
-- Name: trftipoparticular_coempresa_cogrupo_idx1; Type: INDEX; Schema: maestro; Owner: postgres
--

CREATE UNIQUE INDEX trftipoparticular_coempresa_cogrupo_idx1 ON maestro.trftipoparticular USING btree (coempresa, cogrupo) WHERE (fldefault = true);


--
-- Name: trftipoparticular_coempresa_cogrupo_idx2; Type: INDEX; Schema: maestro; Owner: postgres
--

CREATE UNIQUE INDEX trftipoparticular_coempresa_cogrupo_idx2 ON maestro.trftipoparticular USING btree (coempresa, cogrupo) WHERE (fldefault = true);


--
-- Name: uq_maestro_tblarchivo_empresa_id; Type: INDEX; Schema: maestro; Owner: postgres
--

CREATE UNIQUE INDEX uq_maestro_tblarchivo_empresa_id ON maestro.tblarchivo USING btree (coempresa, coarchivo);


--
-- Name: uq_personadireccion_default; Type: INDEX; Schema: maestro; Owner: postgres
--

CREATE UNIQUE INDEX uq_personadireccion_default ON maestro.tblentidaddireccion USING btree (coentidad) WHERE (fldefault = true);


--
-- Name: uq_personadocumento_default; Type: INDEX; Schema: maestro; Owner: postgres
--

CREATE UNIQUE INDEX uq_personadocumento_default ON maestro.tblentidaddocumento USING btree (coentidad) WHERE (fldefault = true);


--
-- Name: idx_segperfilpagina_modulo_perfil; Type: INDEX; Schema: seguridad; Owner: postgres
--

CREATE INDEX idx_segperfilpagina_modulo_perfil ON seguridad.segperfilpagina USING btree (comodulo, coperfil, copagina);


--
-- Name: idx_tblingreso_usuario_fecha; Type: INDEX; Schema: seguridad; Owner: postgres
--

CREATE INDEX idx_tblingreso_usuario_fecha ON seguridad.tblingreso USING btree (cousuario, feingreso DESC);


--
-- Name: seguridad_ingreso_norefreshtoken_idx; Type: INDEX; Schema: seguridad; Owner: postgres
--

CREATE UNIQUE INDEX seguridad_ingreso_norefreshtoken_idx ON seguridad.tblingreso USING btree (norefreshtoken);


--
-- Name: seguridad_perfil_admin_uk; Type: INDEX; Schema: seguridad; Owner: postgres
--

CREATE UNIQUE INDEX seguridad_perfil_admin_uk ON seguridad.segperfil USING btree (comodulo) WHERE fladmin;


--
-- Name: seguridad_perfil_default; Type: INDEX; Schema: seguridad; Owner: postgres
--

CREATE UNIQUE INDEX seguridad_perfil_default ON seguridad.segperfil USING btree (comodulo) WHERE fldefault;


--
-- Name: seguridad_segmenu_comodulo_idx; Type: INDEX; Schema: seguridad; Owner: postgres
--

CREATE INDEX seguridad_segmenu_comodulo_idx ON seguridad.segmenu USING btree (comodulo);


--
-- Name: seguridad_segmodulousuario_coperfil_idx; Type: INDEX; Schema: seguridad; Owner: postgres
--

CREATE INDEX seguridad_segmodulousuario_coperfil_idx ON seguridad.segmodulousuario USING btree (coperfil);


--
-- Name: seguridad_segpagina_comodulo_idx; Type: INDEX; Schema: seguridad; Owner: postgres
--

CREATE INDEX seguridad_segpagina_comodulo_idx ON seguridad.segpagina USING btree (comodulo);


--
-- Name: seguridad_segperfil_comodulo_idx; Type: INDEX; Schema: seguridad; Owner: postgres
--

CREATE INDEX seguridad_segperfil_comodulo_idx ON seguridad.segperfil USING btree (comodulo);


--
-- Name: seguridad_tblempresa_comoneda_idx; Type: INDEX; Schema: seguridad; Owner: postgres
--

CREATE INDEX seguridad_tblempresa_comoneda_idx ON seguridad.tblempresa USING btree (comoneda);


--
-- Name: seguridad_trfpermiso_copersona_idx; Type: INDEX; Schema: seguridad; Owner: postgres
--

CREATE INDEX seguridad_trfpermiso_copersona_idx ON seguridad.tblusuario USING btree (coentidad);


--
-- Name: uq_seguridad_segempresamodulo_empresa_id; Type: INDEX; Schema: seguridad; Owner: postgres
--

CREATE UNIQUE INDEX uq_seguridad_segempresamodulo_empresa_id ON seguridad.segempresamodulo USING btree (coempresa, coempresamodulo);


--
-- Name: tblproductoatributo trg_productoatributo_update; Type: TRIGGER; Schema: catalogo; Owner: postgres
--

CREATE TRIGGER trg_productoatributo_update AFTER INSERT OR DELETE OR UPDATE ON catalogo.tblproductoatributo FOR EACH ROW EXECUTE FUNCTION catalogo.trg_productoindex_change();


--
-- Name: tblatributo Catalogo_Atributo_Empresa_Fk; Type: FK CONSTRAINT; Schema: catalogo; Owner: postgres
--

ALTER TABLE ONLY catalogo.tblatributo
    ADD CONSTRAINT "Catalogo_Atributo_Empresa_Fk" FOREIGN KEY (coempresa) REFERENCES seguridad.tblempresa(coempresa) NOT VALID;


--
-- Name: tblproductoatributo Catalogo_ProductoAtributo_Atributo_Fk; Type: FK CONSTRAINT; Schema: catalogo; Owner: postgres
--

ALTER TABLE ONLY catalogo.tblproductoatributo
    ADD CONSTRAINT "Catalogo_ProductoAtributo_Atributo_Fk" FOREIGN KEY (coempresa, coatributo) REFERENCES catalogo.tblatributo(coempresa, coatributo) NOT VALID;


--
-- Name: tblproductoatributo Catalogo_ProductoAtributo_Empresa_Fk; Type: FK CONSTRAINT; Schema: catalogo; Owner: postgres
--

ALTER TABLE ONLY catalogo.tblproductoatributo
    ADD CONSTRAINT "Catalogo_ProductoAtributo_Empresa_Fk" FOREIGN KEY (coempresa) REFERENCES seguridad.tblempresa(coempresa) NOT VALID;


--
-- Name: tblproductoatributo Catalogo_ProductoAtributo_Producto_Fk; Type: FK CONSTRAINT; Schema: catalogo; Owner: postgres
--

ALTER TABLE ONLY catalogo.tblproductoatributo
    ADD CONSTRAINT "Catalogo_ProductoAtributo_Producto_Fk" FOREIGN KEY (coempresa, coproducto) REFERENCES catalogo.tblproducto(coempresa, coproducto) NOT VALID;


--
-- Name: tblproductoindex Catalogo_ProductoIndex_Empresa_Fk; Type: FK CONSTRAINT; Schema: catalogo; Owner: postgres
--

ALTER TABLE ONLY catalogo.tblproductoindex
    ADD CONSTRAINT "Catalogo_ProductoIndex_Empresa_Fk" FOREIGN KEY (coempresa) REFERENCES seguridad.tblempresa(coempresa) NOT VALID;


--
-- Name: tblproductoindex Catalogo_ProductoIndex_Producto_Fk; Type: FK CONSTRAINT; Schema: catalogo; Owner: postgres
--

ALTER TABLE ONLY catalogo.tblproductoindex
    ADD CONSTRAINT "Catalogo_ProductoIndex_Producto_Fk" FOREIGN KEY (coempresa, coproducto) REFERENCES catalogo.tblproducto(coempresa, coproducto) NOT VALID;


--
-- Name: tblproductostock Catalogo_ProductoStock_Almacen_Fk; Type: FK CONSTRAINT; Schema: catalogo; Owner: postgres
--

ALTER TABLE ONLY catalogo.tblproductostock
    ADD CONSTRAINT "Catalogo_ProductoStock_Almacen_Fk" FOREIGN KEY (coempresa, coalmacen) REFERENCES inventario.tblalmacen(coempresa, coalmacen) NOT VALID;


--
-- Name: tblproductostock Catalogo_ProductoStock_Empresa_Fk; Type: FK CONSTRAINT; Schema: catalogo; Owner: postgres
--

ALTER TABLE ONLY catalogo.tblproductostock
    ADD CONSTRAINT "Catalogo_ProductoStock_Empresa_Fk" FOREIGN KEY (coempresa) REFERENCES seguridad.tblempresa(coempresa) NOT VALID;


--
-- Name: tblproductostock Catalogo_ProductoStock_Local_Fk; Type: FK CONSTRAINT; Schema: catalogo; Owner: postgres
--

ALTER TABLE ONLY catalogo.tblproductostock
    ADD CONSTRAINT "Catalogo_ProductoStock_Local_Fk" FOREIGN KEY (coempresa, colocal) REFERENCES empresa.tbllocal(coempresa, colocal) NOT VALID;


--
-- Name: tblproductostock Catalogo_ProductoStock_Producto_Fk; Type: FK CONSTRAINT; Schema: catalogo; Owner: postgres
--

ALTER TABLE ONLY catalogo.tblproductostock
    ADD CONSTRAINT "Catalogo_ProductoStock_Producto_Fk" FOREIGN KEY (coempresa, coproducto) REFERENCES catalogo.tblproducto(coempresa, coproducto) NOT VALID;


--
-- Name: tblproducto Catalogo_Producto_Empresa_Fk; Type: FK CONSTRAINT; Schema: catalogo; Owner: postgres
--

ALTER TABLE ONLY catalogo.tblproducto
    ADD CONSTRAINT "Catalogo_Producto_Empresa_Fk" FOREIGN KEY (coempresa) REFERENCES seguridad.tblempresa(coempresa) NOT VALID;


--
-- Name: tblproductoimpuesto Inventario_ProductoImpuesto_Empresa_Fk; Type: FK CONSTRAINT; Schema: catalogo; Owner: postgres
--

ALTER TABLE ONLY catalogo.tblproductoimpuesto
    ADD CONSTRAINT "Inventario_ProductoImpuesto_Empresa_Fk" FOREIGN KEY (coempresa) REFERENCES seguridad.tblempresa(coempresa) NOT VALID;


--
-- Name: tblproductoimpuesto Inventario_ProductoImpuesto_Producto_Fk; Type: FK CONSTRAINT; Schema: catalogo; Owner: postgres
--

ALTER TABLE ONLY catalogo.tblproductoimpuesto
    ADD CONSTRAINT "Inventario_ProductoImpuesto_Producto_Fk" FOREIGN KEY (coempresa, coproducto) REFERENCES catalogo.tblproducto(coempresa, coproducto) NOT VALID;


--
-- Name: tblproductoprecio Inventario_ProductoPrecio_Empresa_Fk; Type: FK CONSTRAINT; Schema: catalogo; Owner: postgres
--

ALTER TABLE ONLY catalogo.tblproductoprecio
    ADD CONSTRAINT "Inventario_ProductoPrecio_Empresa_Fk" FOREIGN KEY (coempresa) REFERENCES seguridad.tblempresa(coempresa) NOT VALID;


--
-- Name: tblproductoprecio Inventario_ProductoPrecio_Producto_Fk; Type: FK CONSTRAINT; Schema: catalogo; Owner: postgres
--

ALTER TABLE ONLY catalogo.tblproductoprecio
    ADD CONSTRAINT "Inventario_ProductoPrecio_Producto_Fk" FOREIGN KEY (coempresa, coproducto) REFERENCES catalogo.tblproducto(coempresa, coproducto) NOT VALID;


--
-- Name: tblproductoterminado Inventario_ProductoTerminado_Empresa_Fk; Type: FK CONSTRAINT; Schema: catalogo; Owner: postgres
--

ALTER TABLE ONLY catalogo.tblproductoterminado
    ADD CONSTRAINT "Inventario_ProductoTerminado_Empresa_Fk" FOREIGN KEY (coempresa) REFERENCES seguridad.tblempresa(coempresa) NOT VALID;


--
-- Name: tblproductoterminado Inventario_ProductoTerminado_Producto_Fk; Type: FK CONSTRAINT; Schema: catalogo; Owner: postgres
--

ALTER TABLE ONLY catalogo.tblproductoterminado
    ADD CONSTRAINT "Inventario_ProductoTerminado_Producto_Fk" FOREIGN KEY (coempresa, coproducto) REFERENCES catalogo.tblproducto(coempresa, coproducto) NOT VALID;


--
-- Name: trfclasificacionfiscal Contabilidad_ClasificacionFiscal_Pais_Fk; Type: FK CONSTRAINT; Schema: contabilidad; Owner: postgres
--

ALTER TABLE ONLY contabilidad.trfclasificacionfiscal
    ADD CONSTRAINT "Contabilidad_ClasificacionFiscal_Pais_Fk" FOREIGN KEY (copais) REFERENCES maestro.trfpais(copais);


--
-- Name: trfmediopago Contabilidad_FormaPago_Pais_Fk; Type: FK CONSTRAINT; Schema: contabilidad; Owner: postgres
--

ALTER TABLE ONLY contabilidad.trfmediopago
    ADD CONSTRAINT "Contabilidad_FormaPago_Pais_Fk" FOREIGN KEY (copais) REFERENCES maestro.trfpais(copais);


--
-- Name: trfimpuestohijo Contabilidad_ImpuestoHijo_Impuesto_Fk; Type: FK CONSTRAINT; Schema: contabilidad; Owner: postgres
--

ALTER TABLE ONLY contabilidad.trfimpuestohijo
    ADD CONSTRAINT "Contabilidad_ImpuestoHijo_Impuesto_Fk" FOREIGN KEY (coimpuesto) REFERENCES contabilidad.trfimpuesto(coimpuesto);


--
-- Name: trfimpuestohijo Contabilidad_ImpuestoHijo_Pais_Fk; Type: FK CONSTRAINT; Schema: contabilidad; Owner: postgres
--

ALTER TABLE ONLY contabilidad.trfimpuestohijo
    ADD CONSTRAINT "Contabilidad_ImpuestoHijo_Pais_Fk" FOREIGN KEY (copais) REFERENCES maestro.trfpais(copais) NOT VALID;


--
-- Name: trfimpuestohijo Contabilidad_ImpuestoHijo_UnidadMedida_Fk; Type: FK CONSTRAINT; Schema: contabilidad; Owner: postgres
--

ALTER TABLE ONLY contabilidad.trfimpuestohijo
    ADD CONSTRAINT "Contabilidad_ImpuestoHijo_UnidadMedida_Fk" FOREIGN KEY (counidadmedida) REFERENCES maestro.trfunidadmedida(counidadmedida) NOT VALID;


--
-- Name: trfmotivonotacredito Contabilidad_MotivoNotacredito_Pais_Fk; Type: FK CONSTRAINT; Schema: contabilidad; Owner: postgres
--

ALTER TABLE ONLY contabilidad.trfmotivonotacredito
    ADD CONSTRAINT "Contabilidad_MotivoNotacredito_Pais_Fk" FOREIGN KEY (copais) REFERENCES maestro.trfpais(copais);


--
-- Name: tbltipocambio Contabilidad_TipoCambio_Empresa_Fk; Type: FK CONSTRAINT; Schema: contabilidad; Owner: postgres
--

ALTER TABLE ONLY contabilidad.tbltipocambio
    ADD CONSTRAINT "Contabilidad_TipoCambio_Empresa_Fk" FOREIGN KEY (coempresa) REFERENCES seguridad.tblempresa(coempresa) NOT VALID;


--
-- Name: tbltipocambio Contabilidad_TipoCambio_MonedaDestino_Fk; Type: FK CONSTRAINT; Schema: contabilidad; Owner: postgres
--

ALTER TABLE ONLY contabilidad.tbltipocambio
    ADD CONSTRAINT "Contabilidad_TipoCambio_MonedaDestino_Fk" FOREIGN KEY (comonedadestino) REFERENCES maestro.trfmoneda(comoneda) NOT VALID;


--
-- Name: tbltipocambio Contabilidad_TipoCambio_MonedaOrigen_Fk; Type: FK CONSTRAINT; Schema: contabilidad; Owner: postgres
--

ALTER TABLE ONLY contabilidad.tbltipocambio
    ADD CONSTRAINT "Contabilidad_TipoCambio_MonedaOrigen_Fk" FOREIGN KEY (comonedaorigen) REFERENCES maestro.trfmoneda(comoneda) NOT VALID;


--
-- Name: trfcomprobantepago Maestro_ComprobantePago_Pais_Fk; Type: FK CONSTRAINT; Schema: contabilidad; Owner: postgres
--

ALTER TABLE ONLY contabilidad.trfcomprobantepago
    ADD CONSTRAINT "Maestro_ComprobantePago_Pais_Fk" FOREIGN KEY (copais) REFERENCES maestro.trfpais(copais);


--
-- Name: trfimpuesto Maestro_Impuesto_Pais_Fk; Type: FK CONSTRAINT; Schema: contabilidad; Owner: postgres
--

ALTER TABLE ONLY contabilidad.trfimpuesto
    ADD CONSTRAINT "Maestro_Impuesto_Pais_Fk" FOREIGN KEY (copais) REFERENCES maestro.trfpais(copais) NOT VALID;


--
-- Name: tblbandejaentrada Empresa_BandejaEntrada_Empresa_Fk; Type: FK CONSTRAINT; Schema: empresa; Owner: postgres
--

ALTER TABLE ONLY empresa.tblbandejaentrada
    ADD CONSTRAINT "Empresa_BandejaEntrada_Empresa_Fk" FOREIGN KEY (coempresa) REFERENCES seguridad.tblempresa(coempresa) NOT VALID;


--
-- Name: tblblogmensaje Empresa_BlogMensaje_Blog_Fk; Type: FK CONSTRAINT; Schema: empresa; Owner: postgres
--

ALTER TABLE ONLY empresa.tblblogmensaje
    ADD CONSTRAINT "Empresa_BlogMensaje_Blog_Fk" FOREIGN KEY (coempresa, coblog) REFERENCES empresa.tblblog(coempresa, coblog) NOT VALID;


--
-- Name: tblblogmensaje Empresa_BlogMensaje_Empresa_Fk; Type: FK CONSTRAINT; Schema: empresa; Owner: postgres
--

ALTER TABLE ONLY empresa.tblblogmensaje
    ADD CONSTRAINT "Empresa_BlogMensaje_Empresa_Fk" FOREIGN KEY (coempresa) REFERENCES seguridad.tblempresa(coempresa) NOT VALID;


--
-- Name: tblblog Empresa_Blog_Empresa_Fk; Type: FK CONSTRAINT; Schema: empresa; Owner: postgres
--

ALTER TABLE ONLY empresa.tblblog
    ADD CONSTRAINT "Empresa_Blog_Empresa_Fk" FOREIGN KEY (coempresa) REFERENCES seguridad.tblempresa(coempresa) NOT VALID;


--
-- Name: tblcliente Empresa_Cliente_Empresa_Fk; Type: FK CONSTRAINT; Schema: empresa; Owner: postgres
--

ALTER TABLE ONLY empresa.tblcliente
    ADD CONSTRAINT "Empresa_Cliente_Empresa_Fk" FOREIGN KEY (coempresa) REFERENCES seguridad.tblempresa(coempresa) NOT VALID;


--
-- Name: tblequipo Empresa_Equipo_Empresa_Fk; Type: FK CONSTRAINT; Schema: empresa; Owner: postgres
--

ALTER TABLE ONLY empresa.tblequipo
    ADD CONSTRAINT "Empresa_Equipo_Empresa_Fk" FOREIGN KEY (coempresa) REFERENCES seguridad.tblempresa(coempresa) NOT VALID;


--
-- Name: tblhorario Empresa_Horario_Empresa_Fk; Type: FK CONSTRAINT; Schema: empresa; Owner: postgres
--

ALTER TABLE ONLY empresa.tblhorario
    ADD CONSTRAINT "Empresa_Horario_Empresa_Fk" FOREIGN KEY (coempresa) REFERENCES seguridad.tblempresa(coempresa) NOT VALID;


--
-- Name: tbllocal Empresa_Local_Empresa_Fk; Type: FK CONSTRAINT; Schema: empresa; Owner: postgres
--

ALTER TABLE ONLY empresa.tbllocal
    ADD CONSTRAINT "Empresa_Local_Empresa_Fk" FOREIGN KEY (coempresa) REFERENCES seguridad.tblempresa(coempresa) NOT VALID;


--
-- Name: tblpregunta Empresa_Pregunta_Empresa_Fk; Type: FK CONSTRAINT; Schema: empresa; Owner: postgres
--

ALTER TABLE ONLY empresa.tblpregunta
    ADD CONSTRAINT "Empresa_Pregunta_Empresa_Fk" FOREIGN KEY (coempresa) REFERENCES seguridad.tblempresa(coempresa) NOT VALID;


--
-- Name: tblservicio Empresa_Servicio_Empresa_Fk; Type: FK CONSTRAINT; Schema: empresa; Owner: postgres
--

ALTER TABLE ONLY empresa.tblservicio
    ADD CONSTRAINT "Empresa_Servicio_Empresa_Fk" FOREIGN KEY (coempresa) REFERENCES seguridad.tblempresa(coempresa) NOT VALID;


--
-- Name: tblserviciocaracteristica Inventario_ServicioCaracteristica_Empresa_Fk; Type: FK CONSTRAINT; Schema: empresa; Owner: postgres
--

ALTER TABLE ONLY empresa.tblserviciocaracteristica
    ADD CONSTRAINT "Inventario_ServicioCaracteristica_Empresa_Fk" FOREIGN KEY (coempresa) REFERENCES seguridad.tblempresa(coempresa) NOT VALID;


--
-- Name: tblserviciocaracteristica Inventario_ServicioCaracteristica_Servicio_Fk; Type: FK CONSTRAINT; Schema: empresa; Owner: postgres
--

ALTER TABLE ONLY empresa.tblserviciocaracteristica
    ADD CONSTRAINT "Inventario_ServicioCaracteristica_Servicio_Fk" FOREIGN KEY (coempresa, coservicio) REFERENCES empresa.tblservicio(coempresa, coservicio) NOT VALID;


--
-- Name: tblcompradetalleimpuesto Facturacion_CompraDetalleImpuesto_CompraDetalle_Fk; Type: FK CONSTRAINT; Schema: facturacion; Owner: postgres
--

ALTER TABLE ONLY facturacion.tblcompradetalleimpuesto
    ADD CONSTRAINT "Facturacion_CompraDetalleImpuesto_CompraDetalle_Fk" FOREIGN KEY (coempresa, cocompradetalle) REFERENCES facturacion.tblcompradetalle(coempresa, cocompradetalle) NOT VALID;


--
-- Name: tblcompradetalleimpuesto Facturacion_CompraDetalleImpuesto_Empresa_Fk; Type: FK CONSTRAINT; Schema: facturacion; Owner: postgres
--

ALTER TABLE ONLY facturacion.tblcompradetalleimpuesto
    ADD CONSTRAINT "Facturacion_CompraDetalleImpuesto_Empresa_Fk" FOREIGN KEY (coempresa) REFERENCES seguridad.tblempresa(coempresa) NOT VALID;


--
-- Name: tblcompradetalleimpuesto Facturacion_CompraDetalleImpuesto_ImpuestoHijo_Fk; Type: FK CONSTRAINT; Schema: facturacion; Owner: postgres
--

ALTER TABLE ONLY facturacion.tblcompradetalleimpuesto
    ADD CONSTRAINT "Facturacion_CompraDetalleImpuesto_ImpuestoHijo_Fk" FOREIGN KEY (coimpuestohijo) REFERENCES contabilidad.trfimpuestohijo(coimpuestohijo) NOT VALID;


--
-- Name: tblcompradetalleimpuesto Facturacion_CompraDetalleImpuesto_Impuesto_Fk; Type: FK CONSTRAINT; Schema: facturacion; Owner: postgres
--

ALTER TABLE ONLY facturacion.tblcompradetalleimpuesto
    ADD CONSTRAINT "Facturacion_CompraDetalleImpuesto_Impuesto_Fk" FOREIGN KEY (coimpuesto) REFERENCES contabilidad.trfimpuesto(coimpuesto) NOT VALID;


--
-- Name: tblcompradetalle Facturacion_CompraDetalle_Almacen_Fk; Type: FK CONSTRAINT; Schema: facturacion; Owner: postgres
--

ALTER TABLE ONLY facturacion.tblcompradetalle
    ADD CONSTRAINT "Facturacion_CompraDetalle_Almacen_Fk" FOREIGN KEY (coempresa, coalmacen) REFERENCES inventario.tblalmacen(coempresa, coalmacen) NOT VALID;


--
-- Name: tblcompradetalle Facturacion_CompraDetalle_Compra_Fk; Type: FK CONSTRAINT; Schema: facturacion; Owner: postgres
--

ALTER TABLE ONLY facturacion.tblcompradetalle
    ADD CONSTRAINT "Facturacion_CompraDetalle_Compra_Fk" FOREIGN KEY (coempresa, cocompra) REFERENCES facturacion.tblcompra(coempresa, cocompra) NOT VALID;


--
-- Name: tblcompradetalle Facturacion_CompraDetalle_Empresa_Fk; Type: FK CONSTRAINT; Schema: facturacion; Owner: postgres
--

ALTER TABLE ONLY facturacion.tblcompradetalle
    ADD CONSTRAINT "Facturacion_CompraDetalle_Empresa_Fk" FOREIGN KEY (coempresa) REFERENCES seguridad.tblempresa(coempresa) NOT VALID;


--
-- Name: tblcompradetalle Facturacion_CompraDetalle_Local_Fk; Type: FK CONSTRAINT; Schema: facturacion; Owner: postgres
--

ALTER TABLE ONLY facturacion.tblcompradetalle
    ADD CONSTRAINT "Facturacion_CompraDetalle_Local_Fk" FOREIGN KEY (coempresa, colocal) REFERENCES empresa.tbllocal(coempresa, colocal) NOT VALID;


--
-- Name: tblcompra Facturacion_Compra_ComprobantePago_Fk; Type: FK CONSTRAINT; Schema: facturacion; Owner: postgres
--

ALTER TABLE ONLY facturacion.tblcompra
    ADD CONSTRAINT "Facturacion_Compra_ComprobantePago_Fk" FOREIGN KEY (cocomprobantepago) REFERENCES contabilidad.trfcomprobantepago(cocomprobantepago) NOT VALID;


--
-- Name: tblcompra Facturacion_Compra_Empresa_Fk; Type: FK CONSTRAINT; Schema: facturacion; Owner: postgres
--

ALTER TABLE ONLY facturacion.tblcompra
    ADD CONSTRAINT "Facturacion_Compra_Empresa_Fk" FOREIGN KEY (coempresa) REFERENCES seguridad.tblempresa(coempresa) NOT VALID;


--
-- Name: tblcompra Facturacion_Compra_Local_Fk; Type: FK CONSTRAINT; Schema: facturacion; Owner: postgres
--

ALTER TABLE ONLY facturacion.tblcompra
    ADD CONSTRAINT "Facturacion_Compra_Local_Fk" FOREIGN KEY (coempresa, colocal) REFERENCES empresa.tbllocal(coempresa, colocal) NOT VALID;


--
-- Name: tblcompra Facturacion_Compra_MedioPago_Fk; Type: FK CONSTRAINT; Schema: facturacion; Owner: postgres
--

ALTER TABLE ONLY facturacion.tblcompra
    ADD CONSTRAINT "Facturacion_Compra_MedioPago_Fk" FOREIGN KEY (comediopago) REFERENCES contabilidad.trfmediopago(comediopago) NOT VALID;


--
-- Name: tblcompra Facturacion_Compra_Moneda_Fk; Type: FK CONSTRAINT; Schema: facturacion; Owner: postgres
--

ALTER TABLE ONLY facturacion.tblcompra
    ADD CONSTRAINT "Facturacion_Compra_Moneda_Fk" FOREIGN KEY (comoneda) REFERENCES maestro.trfmoneda(comoneda) NOT VALID;


--
-- Name: tblcompra Facturacion_Compra_TipoCambio_Fk; Type: FK CONSTRAINT; Schema: facturacion; Owner: postgres
--

ALTER TABLE ONLY facturacion.tblcompra
    ADD CONSTRAINT "Facturacion_Compra_TipoCambio_Fk" FOREIGN KEY (coempresa, cotipocambio) REFERENCES contabilidad.tbltipocambio(coempresa, cotipocambio) NOT VALID;


--
-- Name: tblcorrelativo Facturacion_Correlativo_ComprobantePago_Fk; Type: FK CONSTRAINT; Schema: facturacion; Owner: postgres
--

ALTER TABLE ONLY facturacion.tblcorrelativo
    ADD CONSTRAINT "Facturacion_Correlativo_ComprobantePago_Fk" FOREIGN KEY (cocomprobantepago) REFERENCES contabilidad.trfcomprobantepago(cocomprobantepago) NOT VALID;


--
-- Name: tblcorrelativo Facturacion_Correlativo_Empresa_Fk; Type: FK CONSTRAINT; Schema: facturacion; Owner: postgres
--

ALTER TABLE ONLY facturacion.tblcorrelativo
    ADD CONSTRAINT "Facturacion_Correlativo_Empresa_Fk" FOREIGN KEY (coempresa) REFERENCES seguridad.tblempresa(coempresa) NOT VALID;


--
-- Name: tblcorrelativo Facturacion_Correlativo_Local_Fk; Type: FK CONSTRAINT; Schema: facturacion; Owner: postgres
--

ALTER TABLE ONLY facturacion.tblcorrelativo
    ADD CONSTRAINT "Facturacion_Correlativo_Local_Fk" FOREIGN KEY (coempresa, colocal) REFERENCES empresa.tbllocal(coempresa, colocal) NOT VALID;


--
-- Name: tblproformadetalle Facturacion_ProformaDetalle_Empresa_Fk; Type: FK CONSTRAINT; Schema: facturacion; Owner: postgres
--

ALTER TABLE ONLY facturacion.tblproformadetalle
    ADD CONSTRAINT "Facturacion_ProformaDetalle_Empresa_Fk" FOREIGN KEY (coempresa) REFERENCES seguridad.tblempresa(coempresa) NOT VALID;


--
-- Name: tblproformadetalle Facturacion_ProformaDetalle_Producto_Fk; Type: FK CONSTRAINT; Schema: facturacion; Owner: postgres
--

ALTER TABLE ONLY facturacion.tblproformadetalle
    ADD CONSTRAINT "Facturacion_ProformaDetalle_Producto_Fk" FOREIGN KEY (coempresa, coproducto) REFERENCES catalogo.tblproducto(coempresa, coproducto) NOT VALID;


--
-- Name: tblproformadetalle Facturacion_ProformaDetalle_Proforma_Fk; Type: FK CONSTRAINT; Schema: facturacion; Owner: postgres
--

ALTER TABLE ONLY facturacion.tblproformadetalle
    ADD CONSTRAINT "Facturacion_ProformaDetalle_Proforma_Fk" FOREIGN KEY (coempresa, coproforma) REFERENCES facturacion.tblproforma(coempresa, coproforma) NOT VALID;


--
-- Name: tblproforma Facturacion_Proforma_Empresa_Fk; Type: FK CONSTRAINT; Schema: facturacion; Owner: postgres
--

ALTER TABLE ONLY facturacion.tblproforma
    ADD CONSTRAINT "Facturacion_Proforma_Empresa_Fk" FOREIGN KEY (coempresa) REFERENCES seguridad.tblempresa(coempresa) NOT VALID;


--
-- Name: tblproforma Facturacion_Proforma_Local_Fk; Type: FK CONSTRAINT; Schema: facturacion; Owner: postgres
--

ALTER TABLE ONLY facturacion.tblproforma
    ADD CONSTRAINT "Facturacion_Proforma_Local_Fk" FOREIGN KEY (coempresa, colocal) REFERENCES empresa.tbllocal(coempresa, colocal) NOT VALID;


--
-- Name: tblproforma Facturacion_Proforma_Moneda_Fk; Type: FK CONSTRAINT; Schema: facturacion; Owner: postgres
--

ALTER TABLE ONLY facturacion.tblproforma
    ADD CONSTRAINT "Facturacion_Proforma_Moneda_Fk" FOREIGN KEY (comoneda) REFERENCES maestro.trfmoneda(comoneda) NOT VALID;


--
-- Name: tblventadetalleimpuesto Facturacion_VentaDetalleImpuesto_Empresa_Fk; Type: FK CONSTRAINT; Schema: facturacion; Owner: postgres
--

ALTER TABLE ONLY facturacion.tblventadetalleimpuesto
    ADD CONSTRAINT "Facturacion_VentaDetalleImpuesto_Empresa_Fk" FOREIGN KEY (coempresa) REFERENCES seguridad.tblempresa(coempresa) NOT VALID;


--
-- Name: tblventadetalleimpuesto Facturacion_VentaDetalleImpuesto_ImpuestoHijo_Fk; Type: FK CONSTRAINT; Schema: facturacion; Owner: postgres
--

ALTER TABLE ONLY facturacion.tblventadetalleimpuesto
    ADD CONSTRAINT "Facturacion_VentaDetalleImpuesto_ImpuestoHijo_Fk" FOREIGN KEY (coimpuestohijo) REFERENCES contabilidad.trfimpuestohijo(coimpuestohijo) NOT VALID;


--
-- Name: tblventadetalleimpuesto Facturacion_VentaDetalleImpuesto_Impuesto_Fk; Type: FK CONSTRAINT; Schema: facturacion; Owner: postgres
--

ALTER TABLE ONLY facturacion.tblventadetalleimpuesto
    ADD CONSTRAINT "Facturacion_VentaDetalleImpuesto_Impuesto_Fk" FOREIGN KEY (coimpuesto) REFERENCES contabilidad.trfimpuesto(coimpuesto) NOT VALID;


--
-- Name: tblventadetalleimpuesto Facturacion_VentaDetalleImpuesto_VentaDetalle_Fk; Type: FK CONSTRAINT; Schema: facturacion; Owner: postgres
--

ALTER TABLE ONLY facturacion.tblventadetalleimpuesto
    ADD CONSTRAINT "Facturacion_VentaDetalleImpuesto_VentaDetalle_Fk" FOREIGN KEY (coempresa, coventadetalle) REFERENCES facturacion.tblventadetalle(coempresa, coventadetalle) NOT VALID;


--
-- Name: tblventadetalle Facturacion_VentaDetalle_Almacen_Fk; Type: FK CONSTRAINT; Schema: facturacion; Owner: postgres
--

ALTER TABLE ONLY facturacion.tblventadetalle
    ADD CONSTRAINT "Facturacion_VentaDetalle_Almacen_Fk" FOREIGN KEY (coempresa, coalmacen) REFERENCES inventario.tblalmacen(coempresa, coalmacen) NOT VALID;


--
-- Name: tblventadetalle Facturacion_VentaDetalle_Empresa_Fk; Type: FK CONSTRAINT; Schema: facturacion; Owner: postgres
--

ALTER TABLE ONLY facturacion.tblventadetalle
    ADD CONSTRAINT "Facturacion_VentaDetalle_Empresa_Fk" FOREIGN KEY (coempresa) REFERENCES seguridad.tblempresa(coempresa) NOT VALID;


--
-- Name: tblventadetalle Facturacion_VentaDetalle_Local_Fk; Type: FK CONSTRAINT; Schema: facturacion; Owner: postgres
--

ALTER TABLE ONLY facturacion.tblventadetalle
    ADD CONSTRAINT "Facturacion_VentaDetalle_Local_Fk" FOREIGN KEY (coempresa, colocal) REFERENCES empresa.tbllocal(coempresa, colocal) NOT VALID;


--
-- Name: tblventadetalle Facturacion_VentaDetalle_Producto_Fk; Type: FK CONSTRAINT; Schema: facturacion; Owner: postgres
--

ALTER TABLE ONLY facturacion.tblventadetalle
    ADD CONSTRAINT "Facturacion_VentaDetalle_Producto_Fk" FOREIGN KEY (coempresa, coproducto) REFERENCES catalogo.tblproducto(coempresa, coproducto) NOT VALID;


--
-- Name: tblventadetalle Facturacion_VentaDetalle_Venta_Fk; Type: FK CONSTRAINT; Schema: facturacion; Owner: postgres
--

ALTER TABLE ONLY facturacion.tblventadetalle
    ADD CONSTRAINT "Facturacion_VentaDetalle_Venta_Fk" FOREIGN KEY (coempresa, coventa) REFERENCES facturacion.tblventa(coempresa, coventa) NOT VALID;


--
-- Name: tblventa Facturacion_Venta_ComprobantePago_Fk; Type: FK CONSTRAINT; Schema: facturacion; Owner: postgres
--

ALTER TABLE ONLY facturacion.tblventa
    ADD CONSTRAINT "Facturacion_Venta_ComprobantePago_Fk" FOREIGN KEY (cocomprobantepago) REFERENCES contabilidad.trfcomprobantepago(cocomprobantepago) NOT VALID;


--
-- Name: tblventa Facturacion_Venta_Empresa_Fk; Type: FK CONSTRAINT; Schema: facturacion; Owner: postgres
--

ALTER TABLE ONLY facturacion.tblventa
    ADD CONSTRAINT "Facturacion_Venta_Empresa_Fk" FOREIGN KEY (coempresa) REFERENCES seguridad.tblempresa(coempresa) NOT VALID;


--
-- Name: tblventa Facturacion_Venta_Local_Fk; Type: FK CONSTRAINT; Schema: facturacion; Owner: postgres
--

ALTER TABLE ONLY facturacion.tblventa
    ADD CONSTRAINT "Facturacion_Venta_Local_Fk" FOREIGN KEY (coempresa, colocal) REFERENCES empresa.tbllocal(coempresa, colocal) NOT VALID;


--
-- Name: tblventa Facturacion_Venta_MedioPago_Fk; Type: FK CONSTRAINT; Schema: facturacion; Owner: postgres
--

ALTER TABLE ONLY facturacion.tblventa
    ADD CONSTRAINT "Facturacion_Venta_MedioPago_Fk" FOREIGN KEY (comediopago) REFERENCES contabilidad.trfmediopago(comediopago) NOT VALID;


--
-- Name: tblventa Facturacion_Venta_Moneda_Fk; Type: FK CONSTRAINT; Schema: facturacion; Owner: postgres
--

ALTER TABLE ONLY facturacion.tblventa
    ADD CONSTRAINT "Facturacion_Venta_Moneda_Fk" FOREIGN KEY (comoneda) REFERENCES maestro.trfmoneda(comoneda) NOT VALID;


--
-- Name: tblventa Facturacion_Venta_TipoCambio_Fk; Type: FK CONSTRAINT; Schema: facturacion; Owner: postgres
--

ALTER TABLE ONLY facturacion.tblventa
    ADD CONSTRAINT "Facturacion_Venta_TipoCambio_Fk" FOREIGN KEY (coempresa, cotipocambio) REFERENCES contabilidad.tbltipocambio(coempresa, cotipocambio) NOT VALID;


--
-- Name: tblcompradetalle Inventario_CompraDetalle_Producto_Fk; Type: FK CONSTRAINT; Schema: facturacion; Owner: postgres
--

ALTER TABLE ONLY facturacion.tblcompradetalle
    ADD CONSTRAINT "Inventario_CompraDetalle_Producto_Fk" FOREIGN KEY (coempresa, coproducto) REFERENCES catalogo.tblproducto(coempresa, coproducto) NOT VALID;


--
-- Name: tblproforma facturacion_proforma_cocliente_fk; Type: FK CONSTRAINT; Schema: facturacion; Owner: postgres
--

ALTER TABLE ONLY facturacion.tblproforma
    ADD CONSTRAINT facturacion_proforma_cocliente_fk FOREIGN KEY (cocliente) REFERENCES maestro.tblentidad(coentidad);


--
-- Name: tblventa facturacion_tblventa_cliente_fk; Type: FK CONSTRAINT; Schema: facturacion; Owner: postgres
--

ALTER TABLE ONLY facturacion.tblventa
    ADD CONSTRAINT facturacion_tblventa_cliente_fk FOREIGN KEY (cocliente) REFERENCES maestro.tblentidad(coentidad);


--
-- Name: tblventa facturacion_venta_cocliente_fk; Type: FK CONSTRAINT; Schema: facturacion; Owner: postgres
--

ALTER TABLE ONLY facturacion.tblventa
    ADD CONSTRAINT facturacion_venta_cocliente_fk FOREIGN KEY (cocliente) REFERENCES maestro.tblentidad(coentidad);


--
-- Name: tblalmacen Inventario_Almacen_Empresa_Fk; Type: FK CONSTRAINT; Schema: inventario; Owner: postgres
--

ALTER TABLE ONLY inventario.tblalmacen
    ADD CONSTRAINT "Inventario_Almacen_Empresa_Fk" FOREIGN KEY (coempresa) REFERENCES seguridad.tblempresa(coempresa) NOT VALID;


--
-- Name: tblalmacen Inventario_Almacen_Local_Fk; Type: FK CONSTRAINT; Schema: inventario; Owner: postgres
--

ALTER TABLE ONLY inventario.tblalmacen
    ADD CONSTRAINT "Inventario_Almacen_Local_Fk" FOREIGN KEY (coempresa, colocal) REFERENCES empresa.tbllocal(coempresa, colocal) NOT VALID;


--
-- Name: tblinventariodetalle Inventario_InventarioDetalle_Almacen_Fk; Type: FK CONSTRAINT; Schema: inventario; Owner: postgres
--

ALTER TABLE ONLY inventario.tblinventariodetalle
    ADD CONSTRAINT "Inventario_InventarioDetalle_Almacen_Fk" FOREIGN KEY (coempresa, coalmacen) REFERENCES inventario.tblalmacen(coempresa, coalmacen) NOT VALID;


--
-- Name: tblinventariodetalle Inventario_InventarioDetalle_Empresa_Fk; Type: FK CONSTRAINT; Schema: inventario; Owner: postgres
--

ALTER TABLE ONLY inventario.tblinventariodetalle
    ADD CONSTRAINT "Inventario_InventarioDetalle_Empresa_Fk" FOREIGN KEY (coempresa) REFERENCES seguridad.tblempresa(coempresa);


--
-- Name: tblinventariodetalle Inventario_InventarioDetalle_Inventario_Fk; Type: FK CONSTRAINT; Schema: inventario; Owner: postgres
--

ALTER TABLE ONLY inventario.tblinventariodetalle
    ADD CONSTRAINT "Inventario_InventarioDetalle_Inventario_Fk" FOREIGN KEY (coempresa, coinventario) REFERENCES inventario.tblinventario(coempresa, coinventario) NOT VALID;


--
-- Name: tblinventariodetalle Inventario_InventarioDetalle_Local_Fk; Type: FK CONSTRAINT; Schema: inventario; Owner: postgres
--

ALTER TABLE ONLY inventario.tblinventariodetalle
    ADD CONSTRAINT "Inventario_InventarioDetalle_Local_Fk" FOREIGN KEY (coempresa, colocal) REFERENCES empresa.tbllocal(coempresa, colocal) NOT VALID;


--
-- Name: tblinventariodetalle Inventario_InventarioDetalle_Producto_Fk; Type: FK CONSTRAINT; Schema: inventario; Owner: postgres
--

ALTER TABLE ONLY inventario.tblinventariodetalle
    ADD CONSTRAINT "Inventario_InventarioDetalle_Producto_Fk" FOREIGN KEY (coempresa, coproducto) REFERENCES catalogo.tblproducto(coempresa, coproducto) NOT VALID;


--
-- Name: tblinventariodetalle Inventario_InventarioDetalle_VentaDetalle_Fk; Type: FK CONSTRAINT; Schema: inventario; Owner: postgres
--

ALTER TABLE ONLY inventario.tblinventariodetalle
    ADD CONSTRAINT "Inventario_InventarioDetalle_VentaDetalle_Fk" FOREIGN KEY (coempresa, coventadetalle) REFERENCES facturacion.tblventadetalle(coempresa, coventadetalle) NOT VALID;


--
-- Name: tblinventario Inventario_Inventario_Compra_Fk; Type: FK CONSTRAINT; Schema: inventario; Owner: postgres
--

ALTER TABLE ONLY inventario.tblinventario
    ADD CONSTRAINT "Inventario_Inventario_Compra_Fk" FOREIGN KEY (coempresa, cocompra) REFERENCES facturacion.tblcompra(coempresa, cocompra) NOT VALID;


--
-- Name: tblinventario Inventario_Inventario_Empresa_Fk; Type: FK CONSTRAINT; Schema: inventario; Owner: postgres
--

ALTER TABLE ONLY inventario.tblinventario
    ADD CONSTRAINT "Inventario_Inventario_Empresa_Fk" FOREIGN KEY (coempresa) REFERENCES seguridad.tblempresa(coempresa) NOT VALID;


--
-- Name: tblinventario Inventario_Inventario_Venta_Fk; Type: FK CONSTRAINT; Schema: inventario; Owner: postgres
--

ALTER TABLE ONLY inventario.tblinventario
    ADD CONSTRAINT "Inventario_Inventario_Venta_Fk" FOREIGN KEY (coempresa, coventa) REFERENCES facturacion.tblventa(coempresa, coventa) NOT VALID;


--
-- Name: tblstock Inventario_Stock_Almacen_fk; Type: FK CONSTRAINT; Schema: inventario; Owner: postgres
--

ALTER TABLE ONLY inventario.tblstock
    ADD CONSTRAINT "Inventario_Stock_Almacen_fk" FOREIGN KEY (coempresa, coalmacen) REFERENCES inventario.tblalmacen(coempresa, coalmacen) NOT VALID;


--
-- Name: tblstock Inventario_Stock_Empresa_Fk; Type: FK CONSTRAINT; Schema: inventario; Owner: postgres
--

ALTER TABLE ONLY inventario.tblstock
    ADD CONSTRAINT "Inventario_Stock_Empresa_Fk" FOREIGN KEY (coempresa) REFERENCES seguridad.tblempresa(coempresa) NOT VALID;


--
-- Name: tblstock Inventario_Stock_Local_fk; Type: FK CONSTRAINT; Schema: inventario; Owner: postgres
--

ALTER TABLE ONLY inventario.tblstock
    ADD CONSTRAINT "Inventario_Stock_Local_fk" FOREIGN KEY (coempresa, colocal) REFERENCES empresa.tbllocal(coempresa, colocal) NOT VALID;


--
-- Name: tblstock Inventario_Stock_Producto_Pk; Type: FK CONSTRAINT; Schema: inventario; Owner: postgres
--

ALTER TABLE ONLY inventario.tblstock
    ADD CONSTRAINT "Inventario_Stock_Producto_Pk" FOREIGN KEY (coempresa, coproducto) REFERENCES catalogo.tblproducto(coempresa, coproducto) NOT VALID;


--
-- Name: trfdocumentoidentidad Maestro_DocumentoIdentidad_Pais_Fk; Type: FK CONSTRAINT; Schema: maestro; Owner: postgres
--

ALTER TABLE ONLY maestro.trfdocumentoidentidad
    ADD CONSTRAINT "Maestro_DocumentoIdentidad_Pais_Fk" FOREIGN KEY (copais) REFERENCES maestro.trfpais(copais);


--
-- Name: trfpais Maestro_Pais_Moneda_Fk; Type: FK CONSTRAINT; Schema: maestro; Owner: postgres
--

ALTER TABLE ONLY maestro.trfpais
    ADD CONSTRAINT "Maestro_Pais_Moneda_Fk" FOREIGN KEY (comoneda) REFERENCES maestro.trfmoneda(comoneda) NOT VALID;


--
-- Name: trftipogeneral Maestro_TipoGeneral_Modulo_Fk; Type: FK CONSTRAINT; Schema: maestro; Owner: postgres
--

ALTER TABLE ONLY maestro.trftipogeneral
    ADD CONSTRAINT "Maestro_TipoGeneral_Modulo_Fk" FOREIGN KEY (comodulo) REFERENCES seguridad.segmodulo(comodulo) NOT VALID;


--
-- Name: trfunidadmedida Maestro_UnidadMedida_Pais_Fk; Type: FK CONSTRAINT; Schema: maestro; Owner: postgres
--

ALTER TABLE ONLY maestro.trfunidadmedida
    ADD CONSTRAINT "Maestro_UnidadMedida_Pais_Fk" FOREIGN KEY (copais) REFERENCES maestro.trfpais(copais);


--
-- Name: tblarchivo maestro_archivo_empresa_fk; Type: FK CONSTRAINT; Schema: maestro; Owner: postgres
--

ALTER TABLE ONLY maestro.tblarchivo
    ADD CONSTRAINT maestro_archivo_empresa_fk FOREIGN KEY (coempresa) REFERENCES seguridad.tblempresa(coempresa) NOT VALID;


--
-- Name: tblarchivo maestro_archivo_tipo_fk; Type: FK CONSTRAINT; Schema: maestro; Owner: postgres
--

ALTER TABLE ONLY maestro.tblarchivo
    ADD CONSTRAINT maestro_archivo_tipo_fk FOREIGN KEY (cotipo) REFERENCES maestro.trftipogeneral(cotipogeneral) NOT VALID;


--
-- Name: tblarchivo maestro_archivo_tipoentidad_fk; Type: FK CONSTRAINT; Schema: maestro; Owner: postgres
--

ALTER TABLE ONLY maestro.tblarchivo
    ADD CONSTRAINT maestro_archivo_tipoentidad_fk FOREIGN KEY (cotipoentidad) REFERENCES maestro.trftipogeneral(cotipogeneral) NOT VALID;


--
-- Name: trfdocumentoidentidad maestro_documentoidentidad_ambito_Fk; Type: FK CONSTRAINT; Schema: maestro; Owner: postgres
--

ALTER TABLE ONLY maestro.trfdocumentoidentidad
    ADD CONSTRAINT "maestro_documentoidentidad_ambito_Fk" FOREIGN KEY (coambito) REFERENCES maestro.trftipogeneral(cotipogeneral) NOT VALID;


--
-- Name: tblentidaddireccion maestro_entidaddireccion_entidad_fk; Type: FK CONSTRAINT; Schema: maestro; Owner: postgres
--

ALTER TABLE ONLY maestro.tblentidaddireccion
    ADD CONSTRAINT maestro_entidaddireccion_entidad_fk FOREIGN KEY (coentidad) REFERENCES maestro.tblentidad(coentidad) NOT VALID;


--
-- Name: tblentidaddireccion maestro_entidaddireccion_eriqueta_fk; Type: FK CONSTRAINT; Schema: maestro; Owner: postgres
--

ALTER TABLE ONLY maestro.tblentidaddireccion
    ADD CONSTRAINT maestro_entidaddireccion_eriqueta_fk FOREIGN KEY (coetiqueta) REFERENCES maestro.trftipogeneral(cotipogeneral) NOT VALID;


--
-- Name: tblentidaddocumento maestro_entidaddocumento_documentoidentidad_fk; Type: FK CONSTRAINT; Schema: maestro; Owner: postgres
--

ALTER TABLE ONLY maestro.tblentidaddocumento
    ADD CONSTRAINT maestro_entidaddocumento_documentoidentidad_fk FOREIGN KEY (codocumentoidentidad) REFERENCES maestro.trfdocumentoidentidad(codocumentoidentidad);


--
-- Name: tblentidaddocumento maestro_entidaddocumento_entidad_fk; Type: FK CONSTRAINT; Schema: maestro; Owner: postgres
--

ALTER TABLE ONLY maestro.tblentidaddocumento
    ADD CONSTRAINT maestro_entidaddocumento_entidad_fk FOREIGN KEY (coentidad) REFERENCES maestro.tblentidad(coentidad);


--
-- Name: tblentidadempresa maestro_entidadempresa_empresa_fk; Type: FK CONSTRAINT; Schema: maestro; Owner: postgres
--

ALTER TABLE ONLY maestro.tblentidadempresa
    ADD CONSTRAINT maestro_entidadempresa_empresa_fk FOREIGN KEY (coempresa) REFERENCES seguridad.tblempresa(coempresa);


--
-- Name: tblentidadempresa maestro_entidadempresa_entidad_fk; Type: FK CONSTRAINT; Schema: maestro; Owner: postgres
--

ALTER TABLE ONLY maestro.tblentidadempresa
    ADD CONSTRAINT maestro_entidadempresa_entidad_fk FOREIGN KEY (coentidad) REFERENCES maestro.tblentidad(coentidad) NOT VALID;


--
-- Name: tblentidadrol maestro_entidadempresarol_empresa_fk; Type: FK CONSTRAINT; Schema: maestro; Owner: postgres
--

ALTER TABLE ONLY maestro.tblentidadrol
    ADD CONSTRAINT maestro_entidadempresarol_empresa_fk FOREIGN KEY (coempresa) REFERENCES seguridad.tblempresa(coempresa) NOT VALID;


--
-- Name: tblentidadrol maestro_entidadempresarol_entidad_fk; Type: FK CONSTRAINT; Schema: maestro; Owner: postgres
--

ALTER TABLE ONLY maestro.tblentidadrol
    ADD CONSTRAINT maestro_entidadempresarol_entidad_fk FOREIGN KEY (coentidad) REFERENCES maestro.tblentidad(coentidad) NOT VALID;


--
-- Name: tblentidadrol maestro_entidadempresarol_modulo_fk; Type: FK CONSTRAINT; Schema: maestro; Owner: postgres
--

ALTER TABLE ONLY maestro.tblentidadrol
    ADD CONSTRAINT maestro_entidadempresarol_modulo_fk FOREIGN KEY (comodulo) REFERENCES seguridad.segmodulo(comodulo) NOT VALID;


--
-- Name: tblentidadrol maestro_entidadempresarol_rolnegocio_fk; Type: FK CONSTRAINT; Schema: maestro; Owner: postgres
--

ALTER TABLE ONLY maestro.tblentidadrol
    ADD CONSTRAINT maestro_entidadempresarol_rolnegocio_fk FOREIGN KEY (corolnegocio) REFERENCES maestro.trftipogeneral(cotipogeneral) NOT VALID;


--
-- Name: tblentidadredsocial maestro_entidadredsocial_entidad_fk; Type: FK CONSTRAINT; Schema: maestro; Owner: postgres
--

ALTER TABLE ONLY maestro.tblentidadredsocial
    ADD CONSTRAINT maestro_entidadredsocial_entidad_fk FOREIGN KEY (coentidad) REFERENCES maestro.tblentidad(coentidad) NOT VALID;


--
-- Name: tblentidadredsocial maestro_entidadredsocial_etiqueta_fk; Type: FK CONSTRAINT; Schema: maestro; Owner: postgres
--

ALTER TABLE ONLY maestro.tblentidadredsocial
    ADD CONSTRAINT maestro_entidadredsocial_etiqueta_fk FOREIGN KEY (coetiqueta) REFERENCES maestro.trftipogeneral(cotipogeneral) NOT VALID;


--
-- Name: tblentidadredsocial maestro_entidadredsocial_tiporedsocial_fk; Type: FK CONSTRAINT; Schema: maestro; Owner: postgres
--

ALTER TABLE ONLY maestro.tblentidadredsocial
    ADD CONSTRAINT maestro_entidadredsocial_tiporedsocial_fk FOREIGN KEY (cotiporedsocial) REFERENCES maestro.trftipogeneral(cotipogeneral) NOT VALID;


--
-- Name: tblentidadredsocial maestro_entidadredsocial_tipourl_fk; Type: FK CONSTRAINT; Schema: maestro; Owner: postgres
--

ALTER TABLE ONLY maestro.tblentidadredsocial
    ADD CONSTRAINT maestro_entidadredsocial_tipourl_fk FOREIGN KEY (cotipourl) REFERENCES maestro.trftipogeneral(cotipogeneral) NOT VALID;


--
-- Name: tblpersonajuridica maestro_personajuridica_entidad_fk; Type: FK CONSTRAINT; Schema: maestro; Owner: postgres
--

ALTER TABLE ONLY maestro.tblpersonajuridica
    ADD CONSTRAINT maestro_personajuridica_entidad_fk FOREIGN KEY (coentidad) REFERENCES maestro.tblentidad(coentidad);


--
-- Name: tblpersonajuridica maestro_personajuridica_rubro_fk; Type: FK CONSTRAINT; Schema: maestro; Owner: postgres
--

ALTER TABLE ONLY maestro.tblpersonajuridica
    ADD CONSTRAINT maestro_personajuridica_rubro_fk FOREIGN KEY (corubro) REFERENCES maestro.trftipoparticular(cotipoparticular) NOT VALID;


--
-- Name: tblpersonanatural maestro_personanatural_entidad_fk; Type: FK CONSTRAINT; Schema: maestro; Owner: postgres
--

ALTER TABLE ONLY maestro.tblpersonanatural
    ADD CONSTRAINT maestro_personanatural_entidad_fk FOREIGN KEY (coentidad) REFERENCES maestro.tblentidad(coentidad);


--
-- Name: tblpersonanatural maestro_personanatural_estadocivil_fk; Type: FK CONSTRAINT; Schema: maestro; Owner: postgres
--

ALTER TABLE ONLY maestro.tblpersonanatural
    ADD CONSTRAINT maestro_personanatural_estadocivil_fk FOREIGN KEY (coestadocivil) REFERENCES maestro.trftipoparticular(cotipoparticular) NOT VALID;


--
-- Name: tblpersonanatural maestro_personanatural_profesion_fk; Type: FK CONSTRAINT; Schema: maestro; Owner: postgres
--

ALTER TABLE ONLY maestro.tblpersonanatural
    ADD CONSTRAINT maestro_personanatural_profesion_fk FOREIGN KEY (coprofesion) REFERENCES maestro.trftipoparticular(cotipoparticular) NOT VALID;


--
-- Name: tblpersonanatural maestro_personanatural_sexo_fk; Type: FK CONSTRAINT; Schema: maestro; Owner: postgres
--

ALTER TABLE ONLY maestro.tblpersonanatural
    ADD CONSTRAINT maestro_personanatural_sexo_fk FOREIGN KEY (cosexo) REFERENCES maestro.trftipoparticular(cotipoparticular) NOT VALID;


--
-- Name: trftipoparticular maestro_tipoparticular_empresa_fk; Type: FK CONSTRAINT; Schema: maestro; Owner: postgres
--

ALTER TABLE ONLY maestro.trftipoparticular
    ADD CONSTRAINT maestro_tipoparticular_empresa_fk FOREIGN KEY (coempresa) REFERENCES seguridad.tblempresa(coempresa) NOT VALID;


--
-- Name: trftipoparticular maestro_tipoparticular_modulo_fk; Type: FK CONSTRAINT; Schema: maestro; Owner: postgres
--

ALTER TABLE ONLY maestro.trftipoparticular
    ADD CONSTRAINT maestro_tipoparticular_modulo_fk FOREIGN KEY (comodulo) REFERENCES seguridad.segmodulo(comodulo) NOT VALID;


--
-- Name: trfubigeo maestro_ubigeo_pais_fk; Type: FK CONSTRAINT; Schema: maestro; Owner: postgres
--

ALTER TABLE ONLY maestro.trfubigeo
    ADD CONSTRAINT maestro_ubigeo_pais_fk FOREIGN KEY (copais) REFERENCES maestro.trfpais(copais);


--
-- Name: segempresamodulo Seguridad_EmpresaModulo_Empresa_Fk; Type: FK CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.segempresamodulo
    ADD CONSTRAINT "Seguridad_EmpresaModulo_Empresa_Fk" FOREIGN KEY (coempresa) REFERENCES seguridad.tblempresa(coempresa) NOT VALID;


--
-- Name: segempresamodulo Seguridad_EmpresaModulo_Modulo_Fk; Type: FK CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.segempresamodulo
    ADD CONSTRAINT "Seguridad_EmpresaModulo_Modulo_Fk" FOREIGN KEY (comodulo) REFERENCES seguridad.segmodulo(comodulo) NOT VALID;


--
-- Name: segmenu Seguridad_Menu_Modulo_Fk; Type: FK CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.segmenu
    ADD CONSTRAINT "Seguridad_Menu_Modulo_Fk" FOREIGN KEY (comodulo) REFERENCES seguridad.segmodulo(comodulo) NOT VALID;


--
-- Name: segpagina Seguridad_Pagina_Menu$_Fk; Type: FK CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.segpagina
    ADD CONSTRAINT "Seguridad_Pagina_Menu$_Fk" FOREIGN KEY (comodulo, comenu) REFERENCES seguridad.segmenu(comodulo, comenu) NOT VALID;


--
-- Name: segpagina Seguridad_Pagina_Menu_Fk; Type: FK CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.segpagina
    ADD CONSTRAINT "Seguridad_Pagina_Menu_Fk" FOREIGN KEY (comenu) REFERENCES seguridad.segmenu(comenu) NOT VALID;


--
-- Name: segpagina Seguridad_Pagina_Modulo_Fk; Type: FK CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.segpagina
    ADD CONSTRAINT "Seguridad_Pagina_Modulo_Fk" FOREIGN KEY (comodulo) REFERENCES seguridad.segmodulo(comodulo) NOT VALID;


--
-- Name: segperfilpagina Seguridad_PerfilPagina_Menu$_Fk; Type: FK CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.segperfilpagina
    ADD CONSTRAINT "Seguridad_PerfilPagina_Menu$_Fk" FOREIGN KEY (comodulo, comenu) REFERENCES seguridad.segmenu(comodulo, comenu) NOT VALID;


--
-- Name: segperfilpagina Seguridad_PerfilPagina_Menu_Fk; Type: FK CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.segperfilpagina
    ADD CONSTRAINT "Seguridad_PerfilPagina_Menu_Fk" FOREIGN KEY (comenu) REFERENCES seguridad.segmenu(comenu) NOT VALID;


--
-- Name: segperfilpagina Seguridad_PerfilPagina_Modulo_Fk; Type: FK CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.segperfilpagina
    ADD CONSTRAINT "Seguridad_PerfilPagina_Modulo_Fk" FOREIGN KEY (comodulo) REFERENCES seguridad.segmodulo(comodulo) NOT VALID;


--
-- Name: segperfilpagina Seguridad_PerfilPagina_Pagina$_Fk; Type: FK CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.segperfilpagina
    ADD CONSTRAINT "Seguridad_PerfilPagina_Pagina$_Fk" FOREIGN KEY (comodulo, comenu, copagina) REFERENCES seguridad.segpagina(comodulo, comenu, copagina) NOT VALID;


--
-- Name: segperfilpagina Seguridad_PerfilPagina_Pagina_Fk; Type: FK CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.segperfilpagina
    ADD CONSTRAINT "Seguridad_PerfilPagina_Pagina_Fk" FOREIGN KEY (copagina) REFERENCES seguridad.segpagina(copagina) NOT VALID;


--
-- Name: segperfilpagina Seguridad_PerfilPagina_Perfil$_Fk; Type: FK CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.segperfilpagina
    ADD CONSTRAINT "Seguridad_PerfilPagina_Perfil$_Fk" FOREIGN KEY (comodulo, coperfil) REFERENCES seguridad.segperfil(comodulo, coperfil) NOT VALID;


--
-- Name: segperfilpagina Seguridad_PerfilPagina_Perfil_Fk; Type: FK CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.segperfilpagina
    ADD CONSTRAINT "Seguridad_PerfilPagina_Perfil_Fk" FOREIGN KEY (coperfil) REFERENCES seguridad.segperfil(coperfil) NOT VALID;


--
-- Name: audgeneral seguridad_audgeneral_empresa_fk; Type: FK CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.audgeneral
    ADD CONSTRAINT seguridad_audgeneral_empresa_fk FOREIGN KEY (coempresa) REFERENCES seguridad.tblempresa(coempresa) NOT VALID;


--
-- Name: tblempresa seguridad_empresa_idioma_fk; Type: FK CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.tblempresa
    ADD CONSTRAINT seguridad_empresa_idioma_fk FOREIGN KEY (coidioma) REFERENCES maestro.trftipogeneral(cotipogeneral) NOT VALID;


--
-- Name: tblempresa seguridad_empresa_moneda_fk; Type: FK CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.tblempresa
    ADD CONSTRAINT seguridad_empresa_moneda_fk FOREIGN KEY (comoneda) REFERENCES maestro.trfmoneda(comoneda) NOT VALID;


--
-- Name: tblempresa seguridad_empresa_persona_fk; Type: FK CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.tblempresa
    ADD CONSTRAINT seguridad_empresa_persona_fk FOREIGN KEY (coentidad) REFERENCES maestro.tblentidad(coentidad) NOT VALID;


--
-- Name: tblempresa seguridad_empresa_usuarioowner_fk; Type: FK CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.tblempresa
    ADD CONSTRAINT seguridad_empresa_usuarioowner_fk FOREIGN KEY (cousuario_owner) REFERENCES seguridad.tblusuario(cousuario);


--
-- Name: tblingreso seguridad_ingreso_estado_fk; Type: FK CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.tblingreso
    ADD CONSTRAINT seguridad_ingreso_estado_fk FOREIGN KEY (coestado) REFERENCES maestro.trftipogeneral(cotipogeneral) NOT VALID;


--
-- Name: tblingreso seguridad_ingreso_usuario_fk; Type: FK CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.tblingreso
    ADD CONSTRAINT seguridad_ingreso_usuario_fk FOREIGN KEY (cousuario) REFERENCES seguridad.tblusuario(cousuario) NOT VALID;


--
-- Name: segmodulousuario seguridad_modulousuario_empresa_fk; Type: FK CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.segmodulousuario
    ADD CONSTRAINT seguridad_modulousuario_empresa_fk FOREIGN KEY (coempresa) REFERENCES seguridad.tblempresa(coempresa) NOT VALID;


--
-- Name: segmodulousuario seguridad_modulousuario_modulo_fk; Type: FK CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.segmodulousuario
    ADD CONSTRAINT seguridad_modulousuario_modulo_fk FOREIGN KEY (comodulo) REFERENCES seguridad.segmodulo(comodulo) NOT VALID;


--
-- Name: segmodulousuario seguridad_modulousuario_perfil_fk; Type: FK CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.segmodulousuario
    ADD CONSTRAINT seguridad_modulousuario_perfil_fk FOREIGN KEY (comodulo, coperfil) REFERENCES seguridad.segperfil(comodulo, coperfil) NOT VALID;


--
-- Name: segmodulousuario seguridad_modulousuario_usuario_fk; Type: FK CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.segmodulousuario
    ADD CONSTRAINT seguridad_modulousuario_usuario_fk FOREIGN KEY (cousuario) REFERENCES seguridad.tblusuario(cousuario) NOT VALID;


--
-- Name: segpagina seguridad_pagina_tipopagina_Fk; Type: FK CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.segpagina
    ADD CONSTRAINT "seguridad_pagina_tipopagina_Fk" FOREIGN KEY (cotipopagina) REFERENCES maestro.trftipogeneral(cotipogeneral) NOT VALID;


--
-- Name: segperfil seguridad_perfil_modulo_fk; Type: FK CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.segperfil
    ADD CONSTRAINT seguridad_perfil_modulo_fk FOREIGN KEY (comodulo) REFERENCES seguridad.segmodulo(comodulo) NOT VALID;


--
-- Name: tblusuario seguridad_usuario_entidad_fk; Type: FK CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.tblusuario
    ADD CONSTRAINT seguridad_usuario_entidad_fk FOREIGN KEY (coentidad) REFERENCES maestro.tblentidad(coentidad) NOT VALID;


--
-- Name: SCHEMA catalogo; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA catalogo TO claude_reader;


--
-- Name: SCHEMA contabilidad; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA contabilidad TO claude_reader;


--
-- Name: SCHEMA empresa; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA empresa TO claude_reader;


--
-- Name: SCHEMA facturacion; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA facturacion TO claude_reader;


--
-- Name: SCHEMA facturacionrpt; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA facturacionrpt TO claude_reader;


--
-- Name: SCHEMA inventario; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA inventario TO claude_reader;


--
-- Name: SCHEMA login; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA login TO claude_reader;


--
-- Name: SCHEMA maestro; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA maestro TO claude_reader;


--
-- Name: SCHEMA maestrorpt; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA maestrorpt TO claude_reader;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT USAGE ON SCHEMA public TO claude_reader;


--
-- Name: SCHEMA seguridad; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA seguridad TO claude_reader;


--
-- Name: TABLE tblatributo; Type: ACL; Schema: catalogo; Owner: postgres
--

GRANT SELECT ON TABLE catalogo.tblatributo TO claude_reader;


--
-- Name: TABLE tblproducto; Type: ACL; Schema: catalogo; Owner: postgres
--

GRANT SELECT ON TABLE catalogo.tblproducto TO claude_reader;


--
-- Name: TABLE tblproductoatributo; Type: ACL; Schema: catalogo; Owner: postgres
--

GRANT SELECT ON TABLE catalogo.tblproductoatributo TO claude_reader;


--
-- Name: TABLE tblproductoimpuesto; Type: ACL; Schema: catalogo; Owner: postgres
--

GRANT SELECT ON TABLE catalogo.tblproductoimpuesto TO claude_reader;


--
-- Name: TABLE tblproductoindex; Type: ACL; Schema: catalogo; Owner: postgres
--

GRANT SELECT ON TABLE catalogo.tblproductoindex TO claude_reader;


--
-- Name: TABLE tblproductoprecio; Type: ACL; Schema: catalogo; Owner: postgres
--

GRANT SELECT ON TABLE catalogo.tblproductoprecio TO claude_reader;


--
-- Name: TABLE tblproductostock; Type: ACL; Schema: catalogo; Owner: postgres
--

GRANT SELECT ON TABLE catalogo.tblproductostock TO claude_reader;


--
-- Name: TABLE tblproductoterminado; Type: ACL; Schema: catalogo; Owner: postgres
--

GRANT SELECT ON TABLE catalogo.tblproductoterminado TO claude_reader;


--
-- Name: TABLE trftipogeneral; Type: ACL; Schema: maestro; Owner: postgres
--

GRANT SELECT ON TABLE maestro.trftipogeneral TO claude_reader;


--
-- Name: TABLE trftipoparticular; Type: ACL; Schema: maestro; Owner: postgres
--

GRANT SELECT ON TABLE maestro.trftipoparticular TO claude_reader;


--
-- Name: TABLE trfunidadmedida; Type: ACL; Schema: maestro; Owner: postgres
--

GRANT SELECT ON TABLE maestro.trfunidadmedida TO claude_reader;


--
-- Name: TABLE trfimpuesto; Type: ACL; Schema: contabilidad; Owner: postgres
--

GRANT SELECT ON TABLE contabilidad.trfimpuesto TO claude_reader;


--
-- Name: TABLE trfimpuestohijo; Type: ACL; Schema: contabilidad; Owner: postgres
--

GRANT SELECT ON TABLE contabilidad.trfimpuestohijo TO claude_reader;


--
-- Name: TABLE tbltipocambio; Type: ACL; Schema: contabilidad; Owner: postgres
--

GRANT SELECT ON TABLE contabilidad.tbltipocambio TO claude_reader;


--
-- Name: TABLE trfclasificacionfiscal; Type: ACL; Schema: contabilidad; Owner: postgres
--

GRANT SELECT ON TABLE contabilidad.trfclasificacionfiscal TO claude_reader;


--
-- Name: TABLE trfcomprobantepago; Type: ACL; Schema: contabilidad; Owner: postgres
--

GRANT SELECT ON TABLE contabilidad.trfcomprobantepago TO claude_reader;


--
-- Name: TABLE trfmediopago; Type: ACL; Schema: contabilidad; Owner: postgres
--

GRANT SELECT ON TABLE contabilidad.trfmediopago TO claude_reader;


--
-- Name: TABLE trfmotivonotacredito; Type: ACL; Schema: contabilidad; Owner: postgres
--

GRANT SELECT ON TABLE contabilidad.trfmotivonotacredito TO claude_reader;


--
-- Name: TABLE tblbandejaentrada; Type: ACL; Schema: empresa; Owner: postgres
--

GRANT SELECT ON TABLE empresa.tblbandejaentrada TO claude_reader;


--
-- Name: TABLE tblblog; Type: ACL; Schema: empresa; Owner: postgres
--

GRANT SELECT ON TABLE empresa.tblblog TO claude_reader;


--
-- Name: TABLE tblblogmensaje; Type: ACL; Schema: empresa; Owner: postgres
--

GRANT SELECT ON TABLE empresa.tblblogmensaje TO claude_reader;


--
-- Name: TABLE tblcliente; Type: ACL; Schema: empresa; Owner: postgres
--

GRANT SELECT ON TABLE empresa.tblcliente TO claude_reader;


--
-- Name: TABLE tblequipo; Type: ACL; Schema: empresa; Owner: postgres
--

GRANT SELECT ON TABLE empresa.tblequipo TO claude_reader;


--
-- Name: TABLE tblhorario; Type: ACL; Schema: empresa; Owner: postgres
--

GRANT SELECT ON TABLE empresa.tblhorario TO claude_reader;


--
-- Name: TABLE tbllocal; Type: ACL; Schema: empresa; Owner: postgres
--

GRANT SELECT ON TABLE empresa.tbllocal TO claude_reader;


--
-- Name: TABLE tblpregunta; Type: ACL; Schema: empresa; Owner: postgres
--

GRANT SELECT ON TABLE empresa.tblpregunta TO claude_reader;


--
-- Name: TABLE tblservicio; Type: ACL; Schema: empresa; Owner: postgres
--

GRANT SELECT ON TABLE empresa.tblservicio TO claude_reader;


--
-- Name: TABLE tblserviciocaracteristica; Type: ACL; Schema: empresa; Owner: postgres
--

GRANT SELECT ON TABLE empresa.tblserviciocaracteristica TO claude_reader;


--
-- Name: TABLE tblcompra; Type: ACL; Schema: facturacion; Owner: postgres
--

GRANT SELECT ON TABLE facturacion.tblcompra TO claude_reader;


--
-- Name: TABLE tblcompradetalle; Type: ACL; Schema: facturacion; Owner: postgres
--

GRANT SELECT ON TABLE facturacion.tblcompradetalle TO claude_reader;


--
-- Name: TABLE tblcompradetalleimpuesto; Type: ACL; Schema: facturacion; Owner: postgres
--

GRANT SELECT ON TABLE facturacion.tblcompradetalleimpuesto TO claude_reader;


--
-- Name: TABLE tblcorrelativo; Type: ACL; Schema: facturacion; Owner: postgres
--

GRANT SELECT ON TABLE facturacion.tblcorrelativo TO claude_reader;


--
-- Name: TABLE tblproforma; Type: ACL; Schema: facturacion; Owner: postgres
--

GRANT SELECT ON TABLE facturacion.tblproforma TO claude_reader;


--
-- Name: TABLE tblproformadetalle; Type: ACL; Schema: facturacion; Owner: postgres
--

GRANT SELECT ON TABLE facturacion.tblproformadetalle TO claude_reader;


--
-- Name: TABLE tblventa; Type: ACL; Schema: facturacion; Owner: postgres
--

GRANT SELECT ON TABLE facturacion.tblventa TO claude_reader;


--
-- Name: TABLE tblventadetalle; Type: ACL; Schema: facturacion; Owner: postgres
--

GRANT SELECT ON TABLE facturacion.tblventadetalle TO claude_reader;


--
-- Name: TABLE tblventadetalleimpuesto; Type: ACL; Schema: facturacion; Owner: postgres
--

GRANT SELECT ON TABLE facturacion.tblventadetalleimpuesto TO claude_reader;


--
-- Name: TABLE tblalmacen; Type: ACL; Schema: inventario; Owner: postgres
--

GRANT SELECT ON TABLE inventario.tblalmacen TO claude_reader;


--
-- Name: TABLE tblinventario; Type: ACL; Schema: inventario; Owner: postgres
--

GRANT SELECT ON TABLE inventario.tblinventario TO claude_reader;


--
-- Name: TABLE tblinventariodetalle; Type: ACL; Schema: inventario; Owner: postgres
--

GRANT SELECT ON TABLE inventario.tblinventariodetalle TO claude_reader;


--
-- Name: TABLE tblstock; Type: ACL; Schema: inventario; Owner: postgres
--

GRANT SELECT ON TABLE inventario.tblstock TO claude_reader;


--
-- Name: TABLE tblarchivo; Type: ACL; Schema: maestro; Owner: postgres
--

GRANT SELECT ON TABLE maestro.tblarchivo TO claude_reader;


--
-- Name: TABLE tblentidad; Type: ACL; Schema: maestro; Owner: postgres
--

GRANT SELECT ON TABLE maestro.tblentidad TO claude_reader;


--
-- Name: TABLE tblentidaddireccion; Type: ACL; Schema: maestro; Owner: postgres
--

GRANT SELECT ON TABLE maestro.tblentidaddireccion TO claude_reader;


--
-- Name: TABLE tblentidaddocumento; Type: ACL; Schema: maestro; Owner: postgres
--

GRANT SELECT ON TABLE maestro.tblentidaddocumento TO claude_reader;


--
-- Name: TABLE tblentidadempresa; Type: ACL; Schema: maestro; Owner: postgres
--

GRANT SELECT ON TABLE maestro.tblentidadempresa TO claude_reader;


--
-- Name: TABLE tblentidadredsocial; Type: ACL; Schema: maestro; Owner: postgres
--

GRANT SELECT ON TABLE maestro.tblentidadredsocial TO claude_reader;


--
-- Name: TABLE tblentidadrol; Type: ACL; Schema: maestro; Owner: postgres
--

GRANT SELECT ON TABLE maestro.tblentidadrol TO claude_reader;


--
-- Name: TABLE trfmoneda; Type: ACL; Schema: maestro; Owner: postgres
--

GRANT SELECT ON TABLE maestro.trfmoneda TO claude_reader;


--
-- Name: TABLE tblpersonajuridica; Type: ACL; Schema: maestro; Owner: postgres
--

GRANT SELECT ON TABLE maestro.tblpersonajuridica TO claude_reader;


--
-- Name: TABLE tblpersonanatural; Type: ACL; Schema: maestro; Owner: postgres
--

GRANT SELECT ON TABLE maestro.tblpersonanatural TO claude_reader;


--
-- Name: TABLE trfdocumentoidentidad; Type: ACL; Schema: maestro; Owner: postgres
--

GRANT SELECT ON TABLE maestro.trfdocumentoidentidad TO claude_reader;


--
-- Name: TABLE trfpais; Type: ACL; Schema: maestro; Owner: postgres
--

GRANT SELECT ON TABLE maestro.trfpais TO claude_reader;


--
-- Name: TABLE trfubigeo; Type: ACL; Schema: maestro; Owner: postgres
--

GRANT SELECT ON TABLE maestro.trfubigeo TO claude_reader;


--
-- Name: TABLE audgeneral; Type: ACL; Schema: seguridad; Owner: postgres
--

GRANT SELECT ON TABLE seguridad.audgeneral TO claude_reader;


--
-- Name: TABLE segempresamodulo; Type: ACL; Schema: seguridad; Owner: postgres
--

GRANT SELECT ON TABLE seguridad.segempresamodulo TO claude_reader;


--
-- Name: TABLE segmenu; Type: ACL; Schema: seguridad; Owner: postgres
--

GRANT SELECT ON TABLE seguridad.segmenu TO claude_reader;


--
-- Name: TABLE segmodulo; Type: ACL; Schema: seguridad; Owner: postgres
--

GRANT SELECT ON TABLE seguridad.segmodulo TO claude_reader;


--
-- Name: TABLE segmodulousuario; Type: ACL; Schema: seguridad; Owner: postgres
--

GRANT SELECT ON TABLE seguridad.segmodulousuario TO claude_reader;


--
-- Name: TABLE segpagina; Type: ACL; Schema: seguridad; Owner: postgres
--

GRANT SELECT ON TABLE seguridad.segpagina TO claude_reader;


--
-- Name: TABLE segperfil; Type: ACL; Schema: seguridad; Owner: postgres
--

GRANT SELECT ON TABLE seguridad.segperfil TO claude_reader;


--
-- Name: TABLE segperfilpagina; Type: ACL; Schema: seguridad; Owner: postgres
--

GRANT SELECT ON TABLE seguridad.segperfilpagina TO claude_reader;


--
-- Name: TABLE tblempresa; Type: ACL; Schema: seguridad; Owner: postgres
--

GRANT SELECT ON TABLE seguridad.tblempresa TO claude_reader;


--
-- Name: TABLE tblingreso; Type: ACL; Schema: seguridad; Owner: postgres
--

GRANT SELECT ON TABLE seguridad.tblingreso TO claude_reader;


--
-- Name: TABLE tblusuario; Type: ACL; Schema: seguridad; Owner: postgres
--

GRANT SELECT ON TABLE seguridad.tblusuario TO claude_reader;


--
-- Name: TABLE vw_usuario; Type: ACL; Schema: seguridad; Owner: postgres
--

GRANT SELECT ON TABLE seguridad.vw_usuario TO claude_reader;


--
-- PostgreSQL database dump complete
--

\unrestrict 1tlB7HECTiNEHOETkSOjIxzbTTUdPOzuv8p93gsXnjKXpDYXh0vaxwh2izL3kIU

