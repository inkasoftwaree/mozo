--
-- Gestión de Suscripciones (modelo por planes)
-- Schema: suscripcion  (dominio comercial de la plataforma)
--
-- Separa el dominio comercial (planes, precios, suscripción, pagos) del schema
-- 'seguridad' (identidad + control de acceso). El enforcement de acceso sigue
-- en seguridad.segempresamodulo / seguridad.segmodulousuario: al activar o
-- renovar una suscripción, las funciones deben PROYECTAR los módulos del plan
-- (suscripcion.trfplanmodulo) hacia seguridad.segempresamodulo.
--
-- Convenciones del dump respetadas:
--   * tablas de referencia/paramétricas -> prefijo trf; operativas -> prefijo tbl
--   * columnas co*/no*/fe*/fl*, dinero ss* con numeric(14,4)
--   * auditoría cousucre/cousumod + fecre/femod + flestreg
--   * secuencias <tabla>seq
--   * estados globales -> FK a maestro.trftipogeneral (cotipogeneral)
--   * los cambios de estado se auditan vía seguridad.usp_auditoria / audgeneral
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Schema
--

CREATE SCHEMA suscripcion;
ALTER SCHEMA suscripcion OWNER TO postgres;

SET default_table_access_method = heap;

--
-- ============================================================
-- 1) trfplan: catálogo de planes de suscripción
-- ============================================================
--

CREATE SEQUENCE suscripcion.trfplanseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE suscripcion.trfplanseq OWNER TO postgres;

CREATE TABLE suscripcion.trfplan (
    coplan bigint DEFAULT nextval('suscripcion.trfplanseq'::regclass) NOT NULL,
    noplan character varying(100) NOT NULL,
    noplandescripcion character varying(500),
    nuorden smallint,
    nudiasprueba smallint DEFAULT 0 NOT NULL,            -- días de prueba (trial)
    valor jsonb,                                         -- límites/características (usuarios, locales, docs, etc.)
    cousucre integer NOT NULL,
    cousumod integer,
    fecre timestamp without time zone DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC'::text) NOT NULL,
    femod timestamp without time zone,
    flpublico boolean DEFAULT true NOT NULL,             -- visible para contratación
    fldefault boolean DEFAULT false NOT NULL,            -- plan por defecto
    flestreg boolean DEFAULT true NOT NULL
);

ALTER TABLE suscripcion.trfplan OWNER TO postgres;

--
-- ============================================================
-- 2) trfplanprecio: precios por plan × moneda × ciclo
--    (un plan puede tener precio mensual/anual y en varias monedas)
-- ============================================================
--

CREATE SEQUENCE suscripcion.trfplanprecioseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE suscripcion.trfplanprecioseq OWNER TO postgres;

CREATE TABLE suscripcion.trfplanprecio (
    coplanprecio bigint DEFAULT nextval('suscripcion.trfplanprecioseq'::regclass) NOT NULL,
    coplan bigint NOT NULL,
    comoneda bigint NOT NULL,                            -- FK maestro.trfmoneda
    nuciclomeses smallint DEFAULT 1 NOT NULL,            -- ciclo de facturación en meses (1=mensual, 12=anual)
    ssprecio numeric(14,4) DEFAULT 0 NOT NULL,           -- precio del ciclo
    fecre timestamp without time zone DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC'::text) NOT NULL,
    femod timestamp without time zone,
    flvigente boolean DEFAULT true NOT NULL,             -- precio vigente para contratación
    flestreg boolean DEFAULT true NOT NULL
);

ALTER TABLE suscripcion.trfplanprecio OWNER TO postgres;

--
-- ============================================================
-- 3) trfplanmodulo: módulos incluidos en cada plan
-- ============================================================
--

CREATE SEQUENCE suscripcion.trfplanmoduloseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE suscripcion.trfplanmoduloseq OWNER TO postgres;

CREATE TABLE suscripcion.trfplanmodulo (
    coplanmodulo bigint DEFAULT nextval('suscripcion.trfplanmoduloseq'::regclass) NOT NULL,
    coplan bigint NOT NULL,
    comodulo bigint NOT NULL,                            -- FK seguridad.segmodulo
    fecre timestamp without time zone DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC'::text) NOT NULL,
    flestreg boolean DEFAULT true NOT NULL
);

ALTER TABLE suscripcion.trfplanmodulo OWNER TO postgres;

--
-- ============================================================
-- 4) tblsuscripcion: suscripción de una empresa a un plan
-- ============================================================
--

CREATE SEQUENCE suscripcion.tblsuscripcionseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE suscripcion.tblsuscripcionseq OWNER TO postgres;

CREATE TABLE suscripcion.tblsuscripcion (
    cosuscripcion bigint DEFAULT nextval('suscripcion.tblsuscripcionseq'::regclass) NOT NULL,
    coempresa bigint NOT NULL,                           -- FK seguridad.tblempresa
    coplan bigint NOT NULL,                              -- FK suscripcion.trfplan
    coplanprecio bigint,                                 -- FK suscripcion.trfplanprecio (precio contratado)
    feinicio date NOT NULL,                              -- inicio de la suscripción
    fefin date,                                          -- fin del periodo vigente pagado
    ferenovacion date,                                   -- próxima fecha de renovación/cobro
    coestado bigint NOT NULL,                            -- FK maestro.trftipogeneral (trial/activa/vencida/suspendida/cancelada)
    nuciclomeses smallint DEFAULT 1 NOT NULL,            -- ciclo pactado en meses
    ssprecio numeric(14,4) DEFAULT 0 NOT NULL,           -- precio pactado (snapshot al contratar)
    comoneda bigint,                                     -- FK maestro.trfmoneda
    flautorenovar boolean DEFAULT true NOT NULL,         -- renovación automática
    flvigente boolean DEFAULT true NOT NULL,             -- suscripción vigente (una por empresa)
    fecancelacion timestamp without time zone,           -- momento de cancelación (si aplica)
    valor jsonb,                                         -- overrides/notas de la suscripción
    cousucre integer NOT NULL,
    cousumod integer,
    fecre timestamp without time zone DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC'::text) NOT NULL,
    femod timestamp without time zone,
    flestreg boolean DEFAULT true NOT NULL
);

ALTER TABLE suscripcion.tblsuscripcion OWNER TO postgres;

--
-- ============================================================
-- 5) tblsuscripcionpago: ledger de pagos / renovaciones
-- ============================================================
--

CREATE SEQUENCE suscripcion.tblsuscripcionpagoseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE suscripcion.tblsuscripcionpagoseq OWNER TO postgres;

CREATE TABLE suscripcion.tblsuscripcionpago (
    cosuscripcionpago bigint DEFAULT nextval('suscripcion.tblsuscripcionpagoseq'::regclass) NOT NULL,
    cosuscripcion bigint NOT NULL,                       -- FK suscripcion.tblsuscripcion
    coempresa bigint NOT NULL,                           -- FK seguridad.tblempresa (aislamiento por tenant)
    feperiodoinicio date,                                -- periodo cubierto: inicio
    feperiodofin date,                                   -- periodo cubierto: fin
    ssmonto numeric(14,4) DEFAULT 0 NOT NULL,            -- monto del pago/cargo
    comoneda bigint,                                     -- FK maestro.trfmoneda
    fepago timestamp without time zone,                  -- fecha efectiva del pago
    coestado bigint NOT NULL,                            -- FK maestro.trftipogeneral (pendiente/pagado/fallido/reembolsado)
    noreferenciapago character varying(100),             -- referencia externa (pasarela / voucher)
    txnota character varying(500),
    cousucre integer NOT NULL,
    cousumod integer,
    fecre timestamp without time zone DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC'::text) NOT NULL,
    femod timestamp without time zone,
    flestreg boolean DEFAULT true NOT NULL
);

ALTER TABLE suscripcion.tblsuscripcionpago OWNER TO postgres;

--
-- ============================================================
-- Primary Keys
-- ============================================================
--

ALTER TABLE ONLY suscripcion.trfplan
    ADD CONSTRAINT "Suscripcion_Plan_Pk" PRIMARY KEY (coplan);

ALTER TABLE ONLY suscripcion.trfplanprecio
    ADD CONSTRAINT "Suscripcion_PlanPrecio_Pk" PRIMARY KEY (coplanprecio);

ALTER TABLE ONLY suscripcion.trfplanmodulo
    ADD CONSTRAINT "Suscripcion_PlanModulo_Pk" PRIMARY KEY (coplanmodulo);

ALTER TABLE ONLY suscripcion.tblsuscripcion
    ADD CONSTRAINT "Suscripcion_Suscripcion_Pk" PRIMARY KEY (cosuscripcion);

ALTER TABLE ONLY suscripcion.tblsuscripcionpago
    ADD CONSTRAINT "Suscripcion_SuscripcionPago_Pk" PRIMARY KEY (cosuscripcionpago);

--
-- ============================================================
-- Unicidad / reglas de negocio
-- ============================================================
--

-- Un módulo no se repite dentro del mismo plan
ALTER TABLE ONLY suscripcion.trfplanmodulo
    ADD CONSTRAINT "Suscripcion_PlanModulo_Uk" UNIQUE (coplan, comodulo);

-- Un solo precio vigente por (plan, moneda, ciclo)
CREATE UNIQUE INDEX "Suscripcion_PlanPrecio_Uk"
    ON suscripcion.trfplanprecio USING btree (coplan, comoneda, nuciclomeses)
    WHERE (flvigente AND flestreg);

-- Una sola suscripción vigente por empresa
CREATE UNIQUE INDEX "Suscripcion_Suscripcion_Vigente_Uk"
    ON suscripcion.tblsuscripcion USING btree (coempresa)
    WHERE (flvigente AND flestreg);

--
-- ============================================================
-- Foreign Keys
-- ============================================================
--

ALTER TABLE ONLY suscripcion.trfplanprecio
    ADD CONSTRAINT "Suscripcion_PlanPrecio_Plan_Fk" FOREIGN KEY (coplan) REFERENCES suscripcion.trfplan(coplan);

ALTER TABLE ONLY suscripcion.trfplanprecio
    ADD CONSTRAINT "Suscripcion_PlanPrecio_Moneda_Fk" FOREIGN KEY (comoneda) REFERENCES maestro.trfmoneda(comoneda);

ALTER TABLE ONLY suscripcion.trfplanmodulo
    ADD CONSTRAINT "Suscripcion_PlanModulo_Plan_Fk" FOREIGN KEY (coplan) REFERENCES suscripcion.trfplan(coplan);

ALTER TABLE ONLY suscripcion.trfplanmodulo
    ADD CONSTRAINT "Suscripcion_PlanModulo_Modulo_Fk" FOREIGN KEY (comodulo) REFERENCES seguridad.segmodulo(comodulo);

ALTER TABLE ONLY suscripcion.tblsuscripcion
    ADD CONSTRAINT "Suscripcion_Suscripcion_Empresa_Fk" FOREIGN KEY (coempresa) REFERENCES seguridad.tblempresa(coempresa);

ALTER TABLE ONLY suscripcion.tblsuscripcion
    ADD CONSTRAINT "Suscripcion_Suscripcion_Plan_Fk" FOREIGN KEY (coplan) REFERENCES suscripcion.trfplan(coplan);

ALTER TABLE ONLY suscripcion.tblsuscripcion
    ADD CONSTRAINT "Suscripcion_Suscripcion_PlanPrecio_Fk" FOREIGN KEY (coplanprecio) REFERENCES suscripcion.trfplanprecio(coplanprecio);

ALTER TABLE ONLY suscripcion.tblsuscripcion
    ADD CONSTRAINT "Suscripcion_Suscripcion_Moneda_Fk" FOREIGN KEY (comoneda) REFERENCES maestro.trfmoneda(comoneda);

ALTER TABLE ONLY suscripcion.tblsuscripcion
    ADD CONSTRAINT "Suscripcion_Suscripcion_Estado_Fk" FOREIGN KEY (coestado) REFERENCES maestro.trftipogeneral(cotipogeneral);

ALTER TABLE ONLY suscripcion.tblsuscripcionpago
    ADD CONSTRAINT "Suscripcion_SuscripcionPago_Suscripcion_Fk" FOREIGN KEY (cosuscripcion) REFERENCES suscripcion.tblsuscripcion(cosuscripcion);

ALTER TABLE ONLY suscripcion.tblsuscripcionpago
    ADD CONSTRAINT "Suscripcion_SuscripcionPago_Empresa_Fk" FOREIGN KEY (coempresa) REFERENCES seguridad.tblempresa(coempresa);

ALTER TABLE ONLY suscripcion.tblsuscripcionpago
    ADD CONSTRAINT "Suscripcion_SuscripcionPago_Moneda_Fk" FOREIGN KEY (comoneda) REFERENCES maestro.trfmoneda(comoneda);

ALTER TABLE ONLY suscripcion.tblsuscripcionpago
    ADD CONSTRAINT "Suscripcion_SuscripcionPago_Estado_Fk" FOREIGN KEY (coestado) REFERENCES maestro.trftipogeneral(cotipogeneral);

--
-- ============================================================
-- Índices de apoyo
-- ============================================================
--

CREATE INDEX "Suscripcion_PlanPrecio_Plan_Idx" ON suscripcion.trfplanprecio USING btree (coplan);
CREATE INDEX "Suscripcion_PlanModulo_Plan_Idx" ON suscripcion.trfplanmodulo USING btree (coplan);
CREATE INDEX "Suscripcion_Suscripcion_Empresa_Idx" ON suscripcion.tblsuscripcion USING btree (coempresa);
CREATE INDEX "Suscripcion_Suscripcion_Estado_Idx" ON suscripcion.tblsuscripcion USING btree (coestado);
CREATE INDEX "Suscripcion_Suscripcion_Renovacion_Idx" ON suscripcion.tblsuscripcion USING btree (ferenovacion);
CREATE INDEX "Suscripcion_SuscripcionPago_Suscripcion_Idx" ON suscripcion.tblsuscripcionpago USING btree (cosuscripcion);
CREATE INDEX "Suscripcion_SuscripcionPago_Empresa_Idx" ON suscripcion.tblsuscripcionpago USING btree (coempresa);

--
-- ============================================================
-- 6) tblsuscripcionmovimiento: historial FUNCIONAL de la suscripción
--    (activación / renovación / cambio de estado / cancelación).
--    Es dato de negocio, INDEPENDIENTE del log técnico seguridad.audgeneral
--    (que registra ediciones/borrados de todas las tablas, no la historia).
-- ============================================================
--

CREATE SEQUENCE suscripcion.tblsuscripcionmovimientoseq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE suscripcion.tblsuscripcionmovimientoseq OWNER TO postgres;

CREATE TABLE suscripcion.tblsuscripcionmovimiento (
    cosuscripcionmovimiento bigint DEFAULT nextval('suscripcion.tblsuscripcionmovimientoseq'::regclass) NOT NULL,
    cosuscripcion bigint NOT NULL,                       -- FK suscripcion.tblsuscripcion
    coempresa bigint NOT NULL,                           -- FK seguridad.tblempresa
    cotipomovimiento bigint NOT NULL,                    -- FK maestro.trftipogeneral (cogrupo 42)
    coestadoanterior bigint,                             -- FK maestro.trftipogeneral (NULL en la activación)
    coestadonuevo bigint NOT NULL,                       -- FK maestro.trftipogeneral
    fefinanterior date,                                  -- vigencia antes del movimiento
    fefinactual date,                                    -- vigencia después del movimiento
    femovimiento timestamp without time zone DEFAULT (CURRENT_TIMESTAMP AT TIME ZONE 'UTC'::text) NOT NULL,
    txnota character varying(500),
    cousucre integer NOT NULL,
    flestreg boolean DEFAULT true NOT NULL
);

ALTER TABLE suscripcion.tblsuscripcionmovimiento OWNER TO postgres;

ALTER TABLE ONLY suscripcion.tblsuscripcionmovimiento
    ADD CONSTRAINT "Suscripcion_SuscripcionMovimiento_Pk" PRIMARY KEY (cosuscripcionmovimiento);

ALTER TABLE ONLY suscripcion.tblsuscripcionmovimiento
    ADD CONSTRAINT "Suscripcion_SuscripcionMovimiento_Suscripcion_Fk" FOREIGN KEY (cosuscripcion) REFERENCES suscripcion.tblsuscripcion(cosuscripcion);

ALTER TABLE ONLY suscripcion.tblsuscripcionmovimiento
    ADD CONSTRAINT "Suscripcion_SuscripcionMovimiento_Empresa_Fk" FOREIGN KEY (coempresa) REFERENCES seguridad.tblempresa(coempresa);

ALTER TABLE ONLY suscripcion.tblsuscripcionmovimiento
    ADD CONSTRAINT "Suscripcion_SuscripcionMovimiento_Tipo_Fk" FOREIGN KEY (cotipomovimiento) REFERENCES maestro.trftipogeneral(cotipogeneral);

ALTER TABLE ONLY suscripcion.tblsuscripcionmovimiento
    ADD CONSTRAINT "Suscripcion_SuscripcionMovimiento_EstadoAnt_Fk" FOREIGN KEY (coestadoanterior) REFERENCES maestro.trftipogeneral(cotipogeneral);

ALTER TABLE ONLY suscripcion.tblsuscripcionmovimiento
    ADD CONSTRAINT "Suscripcion_SuscripcionMovimiento_EstadoNue_Fk" FOREIGN KEY (coestadonuevo) REFERENCES maestro.trftipogeneral(cotipogeneral);

CREATE INDEX "Suscripcion_SuscripcionMovimiento_Suscripcion_Idx" ON suscripcion.tblsuscripcionmovimiento USING btree (cosuscripcion);
CREATE INDEX "Suscripcion_SuscripcionMovimiento_Empresa_Idx" ON suscripcion.tblsuscripcionmovimiento USING btree (coempresa);
