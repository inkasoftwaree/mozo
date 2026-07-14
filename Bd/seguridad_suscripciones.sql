--
-- Gestión de Suscripciones (modelo por planes)
-- Schema: seguridad
--
-- Agrega el catálogo de planes, los módulos que incluye cada plan,
-- la suscripción de cada empresa a un plan y el historial de pagos/renovaciones.
-- Sigue las convenciones del dump: prefijos seg/tbl, columnas co*/no*/fe*/fl*/im*,
-- auditoría cousucre/cousumod + fecre/femod + flestreg, y secuencias <tabla>seq.
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- ============================================================
-- 1) segplan: catálogo de planes de suscripción
-- ============================================================
--

CREATE SEQUENCE seguridad.segplanseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE seguridad.segplanseq OWNER TO postgres;

CREATE TABLE seguridad.segplan (
    coplan bigint DEFAULT nextval('seguridad.segplanseq'::regclass) NOT NULL,
    noplan character varying(100) NOT NULL,
    noplandescripcion character varying(500),
    nuorden smallint,
    imprecio numeric(18,2) DEFAULT 0 NOT NULL,          -- precio de lista del plan
    comoneda bigint,                                     -- FK maestro.trfmoneda
    nuciclomeses smallint DEFAULT 1 NOT NULL,            -- ciclo de facturación en meses (1=mensual, 12=anual)
    nudiasprueba smallint DEFAULT 0 NOT NULL,            -- días de prueba (trial)
    numaxusuarios integer,                               -- límite de usuarios (NULL = ilimitado)
    valor jsonb,                                         -- límites/características adicionales del plan
    cousucre integer NOT NULL,
    cousumod integer,
    fecre timestamp without time zone DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC'::text) NOT NULL,
    femod timestamp without time zone,
    flpublico boolean DEFAULT true NOT NULL,             -- visible para contratación
    fldefault boolean DEFAULT false NOT NULL,            -- plan por defecto
    flestreg boolean DEFAULT true NOT NULL
);

ALTER TABLE seguridad.segplan OWNER TO postgres;

--
-- ============================================================
-- 2) segplanmodulo: módulos incluidos en cada plan
-- ============================================================
--

CREATE SEQUENCE seguridad.segplanmoduloseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE seguridad.segplanmoduloseq OWNER TO postgres;

CREATE TABLE seguridad.segplanmodulo (
    coplanmodulo bigint DEFAULT nextval('seguridad.segplanmoduloseq'::regclass) NOT NULL,
    coplan bigint NOT NULL,
    comodulo bigint NOT NULL,
    fecre timestamp without time zone DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC'::text) NOT NULL,
    flestreg boolean DEFAULT true NOT NULL
);

ALTER TABLE seguridad.segplanmodulo OWNER TO postgres;

--
-- ============================================================
-- 3) segsuscripcion: suscripción de una empresa a un plan
-- ============================================================
--

CREATE SEQUENCE seguridad.segsuscripcionseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE seguridad.segsuscripcionseq OWNER TO postgres;

CREATE TABLE seguridad.segsuscripcion (
    cosuscripcion bigint DEFAULT nextval('seguridad.segsuscripcionseq'::regclass) NOT NULL,
    coempresa bigint NOT NULL,
    coplan bigint NOT NULL,
    feinicio date NOT NULL,                              -- inicio de la suscripción
    fefin date,                                          -- fin del periodo vigente pagado
    ferenovacion date,                                   -- próxima fecha de renovación/cobro
    coestado bigint NOT NULL,                            -- estado: trial/activa/vencida/suspendida/cancelada (maestro.trftipoparticular)
    nuciclomeses smallint DEFAULT 1 NOT NULL,            -- ciclo pactado en meses
    imprecio numeric(18,2) DEFAULT 0 NOT NULL,           -- precio pactado (snapshot del plan al contratar)
    comoneda bigint,                                     -- FK maestro.trfmoneda
    flautorenovar boolean DEFAULT true NOT NULL,         -- renovación automática
    fecancelacion timestamp without time zone,           -- momento de cancelación (si aplica)
    valor jsonb,                                         -- overrides/notas de la suscripción
    cousucre integer NOT NULL,
    cousumod integer,
    fecre timestamp without time zone DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC'::text) NOT NULL,
    femod timestamp without time zone,
    flestreg boolean DEFAULT true NOT NULL
);

ALTER TABLE seguridad.segsuscripcion OWNER TO postgres;

--
-- ============================================================
-- 4) segsuscripcionhistorial: pagos / renovaciones / cambios de estado
-- ============================================================
--

CREATE SEQUENCE seguridad.segsuscripcionhistorialseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE seguridad.segsuscripcionhistorialseq OWNER TO postgres;

CREATE TABLE seguridad.segsuscripcionhistorial (
    cosuscripcionhistorial bigint DEFAULT nextval('seguridad.segsuscripcionhistorialseq'::regclass) NOT NULL,
    cosuscripcion bigint NOT NULL,
    coempresa bigint NOT NULL,
    feperiodoinicio date,                                -- periodo cubierto: inicio
    feperiodofin date,                                   -- periodo cubierto: fin
    impago numeric(18,2) DEFAULT 0 NOT NULL,             -- monto del pago/cargo
    comoneda bigint,                                     -- FK maestro.trfmoneda
    fepago timestamp without time zone,                  -- fecha efectiva del pago
    coestado bigint NOT NULL,                            -- estado del pago: pendiente/pagado/fallido/reembolsado (maestro.trftipoparticular)
    noreferenciapago character varying(100),             -- referencia externa (pasarela / voucher)
    txnota character varying(500),
    cousucre integer NOT NULL,
    cousumod integer,
    fecre timestamp without time zone DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC'::text) NOT NULL,
    femod timestamp without time zone,
    flestreg boolean DEFAULT true NOT NULL
);

ALTER TABLE seguridad.segsuscripcionhistorial OWNER TO postgres;

--
-- ============================================================
-- Primary Keys
-- ============================================================
--

ALTER TABLE ONLY seguridad.segplan
    ADD CONSTRAINT "Seguridad_Plan_Pk" PRIMARY KEY (coplan);

ALTER TABLE ONLY seguridad.segplanmodulo
    ADD CONSTRAINT "Seguridad_PlanModulo_Pk" PRIMARY KEY (coplanmodulo);

ALTER TABLE ONLY seguridad.segsuscripcion
    ADD CONSTRAINT "Seguridad_Suscripcion_Pk" PRIMARY KEY (cosuscripcion);

ALTER TABLE ONLY seguridad.segsuscripcionhistorial
    ADD CONSTRAINT "Seguridad_SuscripcionHistorial_Pk" PRIMARY KEY (cosuscripcionhistorial);

--
-- Unicidad: un módulo no se repite dentro del mismo plan
--

ALTER TABLE ONLY seguridad.segplanmodulo
    ADD CONSTRAINT "Seguridad_PlanModulo_Uk" UNIQUE (coplan, comodulo);

--
-- ============================================================
-- Foreign Keys
-- ============================================================
--

ALTER TABLE ONLY seguridad.segplan
    ADD CONSTRAINT "Seguridad_Plan_Moneda_Fk" FOREIGN KEY (comoneda) REFERENCES maestro.trfmoneda(comoneda) NOT VALID;

ALTER TABLE ONLY seguridad.segplanmodulo
    ADD CONSTRAINT "Seguridad_PlanModulo_Plan_Fk" FOREIGN KEY (coplan) REFERENCES seguridad.segplan(coplan) NOT VALID;

ALTER TABLE ONLY seguridad.segplanmodulo
    ADD CONSTRAINT "Seguridad_PlanModulo_Modulo_Fk" FOREIGN KEY (comodulo) REFERENCES seguridad.segmodulo(comodulo) NOT VALID;

ALTER TABLE ONLY seguridad.segsuscripcion
    ADD CONSTRAINT "Seguridad_Suscripcion_Empresa_Fk" FOREIGN KEY (coempresa) REFERENCES seguridad.tblempresa(coempresa) NOT VALID;

ALTER TABLE ONLY seguridad.segsuscripcion
    ADD CONSTRAINT "Seguridad_Suscripcion_Plan_Fk" FOREIGN KEY (coplan) REFERENCES seguridad.segplan(coplan) NOT VALID;

ALTER TABLE ONLY seguridad.segsuscripcion
    ADD CONSTRAINT "Seguridad_Suscripcion_Moneda_Fk" FOREIGN KEY (comoneda) REFERENCES maestro.trfmoneda(comoneda) NOT VALID;

ALTER TABLE ONLY seguridad.segsuscripcionhistorial
    ADD CONSTRAINT "Seguridad_SuscripcionHistorial_Suscripcion_Fk" FOREIGN KEY (cosuscripcion) REFERENCES seguridad.segsuscripcion(cosuscripcion) NOT VALID;

ALTER TABLE ONLY seguridad.segsuscripcionhistorial
    ADD CONSTRAINT "Seguridad_SuscripcionHistorial_Empresa_Fk" FOREIGN KEY (coempresa) REFERENCES seguridad.tblempresa(coempresa) NOT VALID;

ALTER TABLE ONLY seguridad.segsuscripcionhistorial
    ADD CONSTRAINT "Seguridad_SuscripcionHistorial_Moneda_Fk" FOREIGN KEY (comoneda) REFERENCES maestro.trfmoneda(comoneda) NOT VALID;

--
-- ============================================================
-- Índices de apoyo
-- ============================================================
--

CREATE INDEX "Seguridad_Suscripcion_Empresa_Idx" ON seguridad.segsuscripcion USING btree (coempresa);
CREATE INDEX "Seguridad_Suscripcion_Estado_Idx" ON seguridad.segsuscripcion USING btree (coestado);
CREATE INDEX "Seguridad_SuscripcionHistorial_Suscripcion_Idx" ON seguridad.segsuscripcionhistorial USING btree (cosuscripcion);
