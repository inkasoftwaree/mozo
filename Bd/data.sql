--
-- PostgreSQL database dump
--

\restrict cWs8r6fGx7dG9V0J3Bt8fYAPFyrRek2h8aTAiCRvlUTTP5m4r5aRMKPbqk2Hl5I

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
-- Data for Name: tblentidad; Type: TABLE DATA; Schema: maestro; Owner: postgres
--

COPY maestro.tblentidad (coentidad, cousucre, cousumod, fecre, femod, flestreg, noentidad) FROM stdin;
18	1	\N	2019-07-04 14:46:29.1	\N	t	persona59
19	1	\N	2019-07-04 15:05:43.393	\N	t	persona60
22	1	\N	2019-07-15 14:11:31.087	\N	t	Jonatan Abregu Chalco
16	1	\N	2019-07-04 12:44:12.207	\N	t	persona57
17	1	\N	2019-07-04 13:02:08.5	\N	t	persona58
20	1	\N	2019-07-04 15:25:32.497	\N	t	persona61
21	1	\N	2019-07-05 08:07:31.947	\N	t	Carlos Slim Helú
1	1	\N	2018-11-18 16:22:17.28	\N	t	Inkasoftware IRL
6	1	\N	2019-06-02 22:18:45.477	\N	t	persona6
7	1	\N	2019-06-19 17:40:43.297	\N	t	persona7
15	1	\N	2019-07-04 10:57:47.277	\N	t	persona15
-1	-1	\N	2019-08-09 12:09:10.44	\N	t	persona-1
4	1	\N	2019-06-02 11:59:19.443	\N	t	persona4
5	1	\N	2019-06-02 22:18:01.53	\N	t	Novaterra
-100	-100	\N	2019-07-21 21:11:52.853	\N	t	persona-100
10	1	\N	2019-06-20 18:25:07.39	\N	t	persona10
11	1	\N	2019-07-03 10:50:47.143	\N	t	persona11
12	1	\N	2019-07-03 21:10:23.957	\N	t	persona12
13	1	\N	2019-07-04 10:54:35.827	\N	t	persona13
14	1	\N	2019-07-04 10:54:46.77	\N	t	persona14
8	1	\N	2019-06-20 17:56:58.293	\N	t	persona8
9	1	\N	2019-06-20 18:15:16.207	\N	t	persona9
2	1	\N	2018-12-29 11:25:10.47	\N	t	Claro
3	1	\N	2018-12-29 11:41:35.32	\N	t	Novaterra
\.


--
-- Data for Name: trfmoneda; Type: TABLE DATA; Schema: maestro; Owner: postgres
--

COPY maestro.trfmoneda (comoneda, nocodigoiso, nucodigoiso, nomoneda, nosimbolo, flestreg) FROM stdin;
1	AED	784	Dirham de los Emiratos Árabes Unidos	د.إ	t
2	AFN	971	Afghani afgano	؋	t
3	ALL	8	Lek albanés	L	t
4	AMD	51	Dram armenio	֏	t
5	ANG	532	Florín de las Antillas Neerlandesas	ƒ	t
6	AOA	973	Kwanza angoleño	Kz	t
7	ARS	32	Peso argentino	$	t
8	AUD	36	Dólar australiano	$	t
9	AWG	533	Florín arubeño	ƒ	t
10	AZN	944	Manat azerbaiyano	₼	t
11	BAM	977	Marco convertible de Bosnia y Herzegovina	KM	t
12	BBD	52	Dólar de Barbados	$	t
13	BDT	50	Taka de Bangladés	৳	t
14	BGN	975	Lev búlgaro	лв	t
15	BHD	48	Dinar bahreiní	.د.ب	t
16	BIF	108	Franco burundés	FBu	t
17	BMD	60	Dólar bermudeño	$	t
18	BND	96	Dólar de Brunéi	$	t
19	BOB	68	Boliviano	Bs	t
20	BRL	986	Real brasileño	R$	t
21	BSD	44	Dólar de las Bahamas	$	t
22	BTN	64	Ngultrum butanés	Nu.	t
23	BWP	72	Pula botsuano	P	t
24	BYN	933	Rublo bielorruso	Br	t
25	BZD	84	Dólar beliceño	$	t
26	CAD	124	Dólar canadiense	$	t
27	CDF	976	Franco congoleño	FC	t
28	CHF	756	Franco suizo	CHF	t
29	CLP	152	Peso chileno	$	t
30	CNY	156	Yuan renminbi	¥	t
31	COP	170	Peso colombiano	$	t
32	CRC	188	Colón costarricense	₡	t
33	CUP	192	Peso cubano	$	t
34	CVE	132	Escudo caboverdiano	$	t
35	CZK	203	Corona checa	Kč	t
36	DJF	262	Franco yibutiano	Fdj	t
37	DKK	208	Corona danesa	kr	t
38	DOP	214	Peso dominicano	RD$	t
39	DZD	12	Dinar argelino	دج	t
40	EGP	818	Libra egipcia	£	t
41	ERN	232	Nakfa eritreo	Nfk	t
42	ETB	230	Birr etíope	Br	t
43	EUR	978	Euro	€	t
44	FJD	242	Dólar fiyiano	$	t
45	FKP	238	Libra malvinense	£	t
46	FOK	234	Corona feroesa	kr	t
47	GBP	826	Libra esterlina	£	t
48	GEL	981	Lari georgiano	₾	t
49	GHS	936	Cedi ghanés	₵	t
50	GIP	292	Libra gibraltareña	£	t
51	GMD	270	Dalasi gambiano	D	t
52	GNF	324	Franco guineano	FG	t
53	GTQ	320	Quetzal guatemalteco	Q	t
54	GYD	328	Dólar guyanés	$	t
55	HKD	344	Dólar de Hong Kong	$	t
56	HNL	340	Lempira hondureño	L	t
57	HRK	191	Kuna croata	kn	t
58	HTG	332	Gourde haitiano	G	t
59	HUF	348	Florín húngaro	Ft	t
60	IDR	360	Rupia indonesia	Rp	t
61	ILS	376	Nuevo shéquel israelí	₪	t
62	INR	356	Rupia india	₹	t
63	IQD	368	Dinar iraquí	ع.د	t
64	IRR	364	Rial iraní	﷼	t
65	ISK	352	Corona islandesa	kr	t
66	JMD	388	Dólar jamaicano	J$	t
67	JOD	400	Dinar jordano	د.ا	t
68	JPY	392	Yen japonés	¥	t
69	KES	404	Chelín keniano	Sh	t
70	KGS	417	Som kirguís	с	t
71	KHR	116	Riel camboyano	៛	t
72	KID	36	Dólar de Kiribati	$	t
73	KMF	174	Franco comorense	CF	t
74	KRW	410	Won surcoreano	₩	t
75	KWD	414	Dinar kuwaití	د.ك	t
76	KYD	136	Dólar de las Islas Caimán	$	t
77	KZT	398	Tenge kazajo	₸	t
78	LAK	418	Kip laosiano	₭	t
79	LBP	422	Libra libanesa	ل.ل	t
80	LKR	144	Rupia de Sri Lanka	Rs	t
81	LRD	430	Dólar liberiano	$	t
82	LSL	426	Loti lesothense	L	t
83	LYD	434	Dinar libio	ل.د	t
84	MAD	504	Dírham marroquí	د.م.	t
85	MDL	498	Leu moldavo	L	t
86	MGA	969	Ariary malgache	Ar	t
87	MKD	807	Denar macedonio	ден	t
88	MMK	104	Kyat birmano	Ks	t
89	MNT	496	Tugrik mongol	₮	t
90	MOP	446	Pataca de Macao	P	t
91	MRU	929	Ouguiya mauritano	UM	t
92	MUR	480	Rupia de Mauricio	₨	t
93	MVR	462	Rufiyaa maldiva	Rf	t
94	MWK	454	Kwacha malauí	MK	t
95	MXN	484	Peso mexicano	$	t
96	MYR	458	Ringgit malayo	RM	t
97	MZN	943	Metical mozambiqueño	MT	t
98	NAD	516	Dólar namibio	$	t
99	NGN	566	Naira nigeriana	₦	t
100	NIO	558	Córdoba nicaragüense	C$	t
101	NOK	578	Corona noruega	kr	t
102	NPR	524	Rupia nepalí	₨	t
103	NZD	554	Dólar neozelandés	$	t
104	OMR	512	Rial omaní	﷼	t
105	PAB	590	Balboa panameño	B/.	t
106	PEN	604	Sol peruano	S/	t
107	PGK	598	Kina de Papúa Nueva Guinea	K	t
108	PHP	608	Peso filipino	₱	t
109	PKR	586	Rupia pakistaní	₨	t
110	PLN	985	Zloty polaco	zł	t
111	PYG	600	Guaraní paraguayo	₲	t
112	QAR	634	Rial catarí	ر.ق	t
113	RON	946	Leu rumano	lei	t
114	RSD	941	Dinar serbio	дин	t
115	RUB	643	Rublo ruso	₽	t
116	RWF	646	Franco ruandés	FRw	t
117	SAR	682	Rial saudí	ر.س	t
118	SBD	90	Dólar de las Islas Salomón	$	t
119	SCR	690	Rupia seychelense	₨	t
120	SDG	938	Libra sudanesa	ج.س.	t
121	SEK	752	Corona sueca	kr	t
122	SGD	702	Dólar de Singapur	$	t
123	SHP	654	Libra de Santa Elena	£	t
124	SLE	925	Leone sierraleonés	Le	t
125	SOS	706	Chelín somalí	Sh	t
126	SRD	968	Dólar surinamés	$	t
127	SSP	728	Libra sursudanesa	£	t
128	STN	930	Dobra de Santo Tomé y Príncipe	Db	t
129	SYP	760	Libra siria	£	t
130	SZL	748	Lilangeni suazi	E	t
131	THB	764	Baht tailandés	฿	t
132	TJS	972	Somoni tayiko	ЅМ	t
133	TMT	934	Manat turcomano	m	t
134	TND	788	Dinar tunecino	د.ت	t
135	TOP	776	Paʻanga tongano	T$	t
136	TRY	949	Lira turca	₺	t
137	TTD	780	Dólar de Trinidad y Tobago	TT$	t
138	TVD	36	Dólar tuvaluano	$	t
139	TWD	901	Nuevo dólar taiwanés	NT$	t
140	TZS	834	Chelín tanzano	Sh	t
141	UAH	980	Grivna ucraniana	₴	t
142	UGX	800	Chelín ugandés	Sh	t
143	USD	840	Dólar estadounidense	$	t
144	UYU	858	Peso uruguayo	$	t
145	UZS	860	Som uzbeko	soʻm	t
146	VED	926	Bolívar digital venezolano	Bs.	t
147	VES	928	Bolívar soberano venezolano	Bs.	t
148	VND	704	Dong vietnamita	₫	t
149	VUV	548	Vatu vanuatuense	VT	t
150	WST	882	Tala samoano	T	t
151	XAF	950	Franco CFA de África Central	FCFA	t
152	XCD	951	Dólar del Caribe Oriental	$	t
153	XOF	952	Franco CFA de África Occidental	CFA	t
154	XPF	953	Franco CFP	₣	t
155	YER	886	Rial yemení	﷼	t
156	ZAR	710	Rand sudafricano	R	t
157	ZMW	967	Kwacha zambiano	ZK	t
158	ZWL	932	Dólar zimbabuense	$	t
\.


--
-- Data for Name: segmodulo; Type: TABLE DATA; Schema: seguridad; Owner: postgres
--

COPY seguridad.segmodulo (comodulo, nomodulo, nomodulodescripcion, noarea, nuorden, fecre, femod, cousucre, cousumod, flestreg, flarea, noicono) FROM stdin;
5	Soporte y Monitoreo	Módulo de gestión de Soporte Técnico y monitoreo	soporte	5	2018-11-21	\N	1	22	t	t	lucideLifeBuoy
7	Contabilidad	Módulo de gestión de la Contabilidad	contabilidad	7	2018-12-29	2019-08-12 00:00:00	1	22	t	t	lucideCalculator
11	Matricula	Módulo de gestón de Matrícula	matricula	10	2021-03-17	\N	22	22	t	t	lucideGraduationCap
9	Facturacion	Módulo de Gestion compras, ventas y inventarios.	facturacion	12	2021-09-26	\N	22	22	t	t	lucidePackage
13	Creditos	Módulo de Gestion de Créditos	credito	11	2021-09-23	\N	22	22	t	t	lucidePackage
-1	Seguridad	Módulo de gestión de perfiles, menús de los aplicativos; y gestión la de las Empresas	seguridad	-1	2018-11-21	2026-04-07 23:01:31.023381	1	22	t	t	lucideShieldUser
-100	Sin Modulo-100	Sin Modulo 1009	sinmodulo100	-100	2020-04-19	2026-04-10 20:06:52.464294	1	22	t	t	lucidePackage
-2	Maestros	Módulo de maestros	maestro	0	2020-04-20	2026-05-07 23:21:32.27067	1	22	t	t	lucideDatabaseZap
4	Biblioteca	Módulo de gestión de Biblioteca	biblioteca	8	2018-11-21	2026-06-18 22:59:50.420568	1	22	t	t	lucidePackage
2	Condominio	Módulo de gestión de Condominios, para el control y administracion de pago de servicios y alquileres.	condominio	3	2018-11-21	2026-06-20 00:00:16.37249	1	22	t	t	lucideBuilding2
12	Inventarios	Módulo de Gestion de  Inventarios	inventario	9	2021-09-23	2026-06-20 00:00:19.039036	22	22	t	t	lucidePackage
15	Creditos Hipotecarios	Módulo de Gestion de Créditos Hipotecarios	creditohipotecario	13	2021-11-16	2026-06-20 00:00:21.444535	22	22	t	t	lucidePackage
3	Finanzas Personales	Módulo de gestión de Gastos Personales	gastos	6	2018-11-21	2026-06-12 23:17:43.723695	1	22	t	t	lucidePackage
8	Trámite Expediente	Módulo de gestión de Expedientes	expediente	4	2020-04-20	2026-06-15 16:15:28.187543	1	22	t	t	lucideFileStack
6	Catalogo	Módulo de Catalogo	catalogo	14	2020-04-20	2026-06-15 16:43:14.331257	1	22	t	t	lucideShoppingBasket
1	Empresa	Módulo de gestión de la información de la empresa como servicios brindados, clientes, preguntas frecuentes, bandeja de mensajes, configuraciones y otros. 	empresa	2	2020-04-20	2026-06-18 20:55:27.251441	1	22	t	t	lucideSchool
\.


--
-- Data for Name: trftipogeneral; Type: TABLE DATA; Schema: maestro; Owner: postgres
--

COPY maestro.trftipogeneral (cogrupo, nuorden, comodulo, notipo, nosigla, fecre, nocomando, flestreg, fldelete, fldefault, valor, cotipogeneral) FROM stdin;
9	3	2	Apartamento		2018-12-05 12:07:23.897	9x3	t	f	f	\N	2
9	4	2	Cochera		2018-12-05 12:07:33.41	9x4	t	f	f	\N	3
38	12	-2	catalogo.producto	\N	2025-09-17 19:32:51.581781	\N	t	f	f	\N	4
38	11	-2	soporte.seguimiento	\N	2025-09-17 19:32:51.581781	\N	t	f	f	\N	5
38	10	-2	soporte.soporte	\N	2025-09-17 19:32:51.581781	\N	t	f	f	\N	6
38	9	-2	condominio.predioalquiler	\N	2025-09-17 19:32:51.581781	\N	t	f	f	\N	7
34	1	-2	Miniatura	\N	2025-09-10 16:00:13.069004	34x1	t	f	f	\N	8
7	0	-1	Menú	\N	2018-11-07 15:56:50.01	7x0	t	f	f	\N	9
8	1	2	Medidor externo y medidor interno	2|3	2018-12-03 12:32:12.86	condominio.calculoservicio1	t	f	f	{"txDescripcion": "Con medidor externo (padre) y medidor interno, en donde el medidor externo tiene el monto del servicio y lectura del consumo del servicio. Se divide entre todos los predios con la medida del medidor interno."}	10
8	2	2	Monto consumo fijo entre los predios, sin medidor	2	2018-12-03 12:33:05.893	condominio.calculoservicio2	t	f	f	{"txDescripcion": "Se divide el monto fijo del servicio entre todos los predios"}	11
8	3	2	Monto consumo fijo entre los predios alquilados, sin medidor	2	2018-12-03 12:33:41.733	condominio.calculoservicio3	t	f	f	{"txDescripcion": "Se divide el monto fijo del servicio, entre los predios alquilados"}	12
8	8	2	Monto consumo, de los predios segun su área	2|3	2020-02-07 18:10:17.377	condominio.calculoservicio8	t	f	f	{"txDescripcion": null}	13
11	3	-1	Usuario del sistema	\N	2020-04-18 20:41:48.183	seguridad.sistema	t	f	f	{"txDescripcion": "Módulo de Seguridad"}	14
11	4	2	Inquilino	1	2020-04-18 20:43:00.497	condominio.inquilino	t	f	f	{"txDescripcion": "Módulo de Condominio"}	15
11	5	2	Propietario	1	2020-04-18 20:43:48.687	condominio.propietario	t	f	f	{"txDescripcion": "Módulo de Condominio"}	16
38	2	-2	seguridad.empresa	\N	2025-09-17 19:32:51.581781	\N	t	f	f	\N	18
6	6	1	Imagen	\N	2020-04-18 12:45:27.21	empresa.blog.imagen	t	f	f	{"coTabla": 3, "noTitulo": "Imagen", "flGaleria": 0, "txExtensiones": "image/*"}	19
6	9	1	Foto	\N	2020-04-18 12:45:27.21	empresa.cliente.foto	t	f	f	{"coTabla": 4, "noTitulo": "Foto", "flGaleria": 0, "txExtensiones": "image/*"}	20
6	15	1	Imagen	\N	2019-06-08 16:36:50.777	empresa.serviciocaracteristica.imagen	t	f	f	{"coTabla": 7, "noTitulo": "Imagen", "flGaleria": 0, "txExtensiones": "image/*"}	21
15	1	7	Credito	\N	2021-09-20 16:39:45.647	202w9200439w5	t	f	f	\N	22
15	2	7	Contado	\N	2021-09-20 16:39:45.647	15x1	t	f	f	\N	23
23	1	-100	SIN EDUCACIÓN FORMAL		2021-09-20 14:27:24.693	23x1	t	f	f	\N	24
23	13	-100	EDUCACIÓN UNIVERSITARIA COMPLETA		2021-09-20 14:27:24.693	23x13	t	f	f	\N	25
23	14	-100	GRADO DE BACHILLER		2021-09-20 14:27:24.693	23x14	t	f	f	\N	26
23	15	-100	TITULADO		2021-09-20 14:27:24.693	23x15	t	f	f	\N	27
23	16	-100	ESTUDIOS DE MAESTRÍA INCOMPLETA		2021-09-20 14:27:24.693	23x16	t	f	f	\N	28
23	17	-100	ESTUDIOS DE MAESTRÍA COMPLETA		2021-09-20 14:27:24.693	23x17	t	f	f	\N	29
23	18	-100	GRADO DE MAESTRÍA		2021-09-20 14:27:24.693	23x18	t	f	f	\N	30
23	19	-100	ESTUDIOS DE DOCTORADO INCOMPLETO		2021-09-20 14:27:24.693	23x19	t	f	f	\N	31
23	20	-100	ESTUDIOS DE DOCTORADO COMPLETO		2021-09-20 14:27:24.693	23x20	t	f	f	\N	32
23	21	-100	GRADO DE DOCTOR		2021-09-20 14:27:24.693	23x21	t	f	f	\N	33
25	1	-100	Teléfono Movil		2021-09-20 14:27:24.693	25x1	t	f	f	\N	34
25	2	-100	Correo Electronico		2021-09-20 14:27:24.693	25x2	t	f	f	\N	35
25	3	-100	Teléfono Fijo		2021-09-20 14:27:24.693	25x3	t	f	f	\N	36
25	4	-100	Url		2021-09-20 14:27:24.693	25x4	t	f	f	\N	37
27	1	-100	Página Web		2021-09-20 14:27:24.693	27x1	t	f	f	\N	38
27	2	-100	Facebook		2021-09-20 14:27:24.693	27x2	t	f	f	\N	39
27	3	-100	X		2021-09-20 14:27:24.693	27x3	t	f	f	\N	40
27	4	-100	Youtube		2021-09-20 14:27:24.693	27x4	t	f	f	\N	41
27	5	-100	LinkedIn		2021-09-20 14:27:24.693	27x5	t	f	f	\N	42
27	6	-100	Instagram		2021-09-20 14:27:24.693	27x6	t	f	f	\N	43
27	7	-100	Tiktok		2021-09-20 14:27:24.693	27x7	t	f	f	\N	44
28	1	15	Inicial		2021-09-20 14:27:24.693	28x1	t	f	f	\N	45
28	2	15	Separación		2021-09-20 14:27:24.693	28x2	t	f	f	\N	46
28	3	15	Penalidad		2021-09-20 14:27:24.693	28x3	t	f	f	\N	47
28	4	15	Abono		2021-09-20 14:27:24.693	28x4	t	f	f	\N	48
28	6	15	Cuota Manual		2021-09-20 14:27:24.693	28x6	t	f	f	\N	50
29	0	15	Anulado		2021-09-20 14:27:24.693	29x1	t	f	f	\N	51
29	1	15	Valido		2021-09-20 14:27:24.693	29x111	t	f	f	\N	52
31	1	15	Cambio de Titularidad		2021-09-20 14:27:24.693	31x1	t	f	f	\N	53
31	2	15	Cambio de Ubicación		2021-09-20 14:27:24.693	31x2	t	f	f	\N	54
31	3	15	Desistio Compra		2021-09-20 14:27:24.693	31x3	t	f	f	\N	55
32	1	15	Lote		2021-09-20 14:28:18.66	32x1	t	f	f	\N	56
32	2	15	Jardin		2021-09-20 14:28:18.66	32x2	t	f	f	\N	57
32	3	15	Mercado		2021-09-20 14:28:18.66	32x3	t	f	f	\N	58
32	4	15	Colegio		2021-09-20 14:28:18.66	32x4	t	f	f	\N	59
32	5	15	Universidad		2021-09-20 14:28:18.66	32x5	t	f	f	\N	60
11	10	1	Bloguero	1	2020-04-30 13:52:04.677	empresa.bloguero	t	f	f	{"txDescripcion": "Módulo de Empresa"}	64
19	1	12	Entrada	\N	2025-09-17 17:42:25.671708	\N	t	f	f	{"txDescripcion": "ingreso de stock"}	65
12	3	-2	Ambos	\N	2025-09-16 14:33:12.373692	\N	t	f	f	\N	63
28	5	15	Cuota Automático		2021-09-20 14:27:24.693	28x5	t	f	f	\N	49
38	1	-2	maestro.entidad	\N	2025-09-17 19:31:55.716431	\N	t	f	f	\N	17
19	3	12	Ajuste	\N	2025-09-17 17:43:48.749502	\N	t	f	f	{"txDescripcion": "corrección manual (inventario físico)"}	66
19	4	12	Salida	\N	2025-09-17 17:43:48.749502	\N	t	f	f	{"txDescripcion": "egreso de stock"}	67
19	2	12	Transferencia	\N	2025-09-17 17:43:48.749502	\N	t	f	f	{"txDescripcion": "salida de un almacén y entrada a otro"}	68
11	11	1	Cliente	1	2020-04-30 13:52:04.677	empresa.cliente	t	f	f	{"txDescripcion": "Módulo de Empresa"}	69
0	17	-2	Etiqueta red social		2018-05-17 15:30:53.993	maestro.redsocial.etiqueta	t	f	f	\N	71
17	1	-100	Trabajo	\N	2021-09-20 16:39:45.647	17x1	t	f	f	\N	72
0	5	-2	Estado Civil		2018-05-17 15:30:53.993	maestro.personanatural.estadocivil	t	f	f	\N	73
11	14	11	Alumno	1	2021-03-17 12:18:48.96	matricula.alumno	t	f	f	{"txDescripcion": "Módulo de Matrícula"}	76
11	15	11	Profesor	\N	2021-03-17 12:18:48.96	matricula.profesor	t	f	f	{"txDescripcion": "Módulo de Matrícula"}	77
11	16	9	Proveedor	1	2021-09-23 21:26:19.33	facturacion.proveedor	t	f	f	{"txDescripcion": "Módulo de Facturación"}	78
6	10	1	Imagen	\N	2020-04-18 12:45:27.21	empresa.servicio.imagen	t	f	f	{"coTabla": 5, "noTitulo": "Imagen", "flGaleria": 0, "txExtensiones": "image/*"}	81
6	13	5	Sustento	\N	2019-06-08 16:36:50.777	soporte.seguimiento.sustento	t	f	f	{"coTabla": 11, "noTitulo": "Sustento", "flGaleria": 1, "txExtensiones": "image/*,.pdf,.doc,.docx,.msg,.sql,.txt"}	82
2	1	6	Bienes / Mercancías (tangibles con stock)	\N	2025-09-25 17:18:39.863449	\N	t	f	f	{"txDescripcion": "maneja stock e inventario."}	83
2	3	6	Consumible	\N	2025-09-25 17:20:30.017911	\N	t	f	f	{"txDescripcion": "stock opcional, más flexible."}	84
6	14	6	Imagen	\N	2019-06-08 16:36:50.777	catalogo.producto.imagen	t	f	f	{"coTabla": 12, "noTitulo": "Imagen", "flGaleria": 1, "txExtensiones": "image/*"}	85
34	2	-2	Mediano	\N	2025-09-10 16:01:18.944261	34x2	t	f	f	\N	87
34	3	-2	Grande	\N	2025-09-10 16:02:21.951777	35x3	t	f	f	\N	88
6	7	8	Documento	\N	2019-06-08 16:36:50.777	expediente.documento.escrito	t	f	f	{"coTabla": 13, "noTitulo": "Documento", "flGaleria": 0, "txExtensiones": ".pdf,.doc,.docx"}	89
6	8	8	Notificación	\N	2019-06-08 16:36:50.777	expediente.notificacion.constancia	t	f	f	{"coTabla": 14, "noTitulo": "Notificación", "flGaleria": 0, "txExtensiones": ".pdf,.doc,.docx"}	90
2	4	6	Compuestos / Kits / Paquetes	\N	2025-09-25 17:21:12.090473	\N	t	f	f	{"txDescripcion": "se vende como uno, pero descuenta varios productos hijos."}	91
2	5	6	Virtuales / Descargables / Licencias	\N	2025-09-25 17:22:37.570346	\N	t	f	f	{"txDescripcion": "No tienen stock físico, pero sí control digital."}	92
11	17	9	Cliente	1	2021-09-23 21:27:37.777	facturacion.cliente	t	f	f	{"txDescripcion": "Módulo de Facturación"}	97
11	18	15	Cliente	\N	2021-09-23 21:27:37.777	urbano.cliente	t	f	f	{"txDescripcion": "Módulo de Urbano"}	98
11	19	15	Vendedor	1	2021-12-15 18:51:34.31	urbano.vendedor	t	f	f	{"txDescripcion": "Módulo de Urbano"}	99
11	20	1	Equipo	1	2020-04-30 13:52:04	empresa.equipo	t	f	f	{"txDescripcion": "Módulo de Empresa"}	100
11	23	9	Vendedor	1	2020-04-30 13:52:04	facturacion.vendedor	t	f	f	{"txDescripcion": "Módulo de Facturación"}	101
8	4	2	Monto consumo fijo del predio, sin medidor	3|4	2018-12-03 12:34:02.01	condominio.calculoservicio4	t	f	f	{"txDescripcion": "El monto del servicio es fijo va directo al monto del servicio del predio"}	102
8	5	2	Monto consumo variable del predio, con medidor	3	2018-12-12 14:19:06.83	condominio.calculoservicio5	t	f	f	{"txDescripcion": "El monto del servicio es fijo va directo al monto del servicio del predio, con medidor"}	103
8	6	2	Monto consumo variable entre los predios alquilados, con medidor	2	2019-07-24 12:02:56.98	condominio.calculoservicio6	t	f	f	{"txDescripcion": "Monto consumo variable entre los predios alquilados, con medidor"}	104
8	7	2	Medidor externo	2|3	2018-12-03 12:32:12.86	condominio.calculoservicio7	t	f	f	{"txDescripcion": "Con medidor externo (padre) , en donde el medidor externo tiene el monto del servicio y lectura del consumo del servicio. Se divide entre todos los predios."}	105
38	3	-2	empresa.blog	\N	2025-09-17 19:32:51.581781	\N	t	f	f	\N	106
38	4	-2	empresa.cliente	\N	2025-09-17 19:32:51.581781	\N	t	f	f	\N	107
38	5	-2	empresa.servicio	\N	2025-09-17 19:32:51.581781	\N	t	f	f	\N	108
38	6	-2	empresa.imagenweb	\N	2025-09-17 19:32:51.581781	\N	t	f	f	\N	109
38	7	-2	empresa.serviciocaracteristica	\N	2025-09-17 19:32:51.581781	\N	t	f	f	\N	110
38	8	-2	condominio.predio	\N	2025-09-17 19:32:51.581781	\N	t	f	f	\N	111
6	12	1	Imagen	\N	2020-04-18 12:45:27.21	empresa.imagenweb.imagen	t	f	f	{"coTabla": 6, "noTitulo": "Imagen", "flGaleria": 0, "txExtensiones": "image/*"}	112
6	11	11	Recibo	\N	2020-04-18 12:45:27.21	matricula.matriculapension.recibo	t	f	f	{"coTabla": 15, "noTitulo": "Recibo", "flGaleria": 0, "txExtensiones": "image/*,.pdf,.doc,.docx"}	113
0	39	-1	Estado token	\N	2025-09-17 19:30:22.918168	seguridad.estadotoken	t	f	f	\N	114
0	18	5	Grupo de Soporte		2018-05-17 15:30:53.993	soporte.soporte.grupo	t	f	f	\N	79
0	12	-2	Ámbito Documento Identidad	\N	2020-04-18 20:24:53.453	maestro.documentoidentidad.ambito	t	t	f	\N	74
11	6	5	Soporte	1	2020-04-18 20:44:21.99	soporte.cliente	t	f	f	{"txDescripcion": "Módulo de Soporte"}	93
11	9	8	Abogado	1	2020-04-30 13:52:04.677	Expediente.abogado	t	f	f	{"txDescripcion": "Módulo de Abogado"}	96
11	12	8	Notificado	1	2020-04-30 13:52:04.677	Expediente.notificado	t	f	f	{"txDescripcion": "Módulo de Abogado"}	70
11	13	8	Parte	0	2020-04-30 13:52:04.677	Expediente.parte	t	f	f	{"txDescripcion": "Módulo de Abogado"}	75
39	1	-1	Activo	\N	2025-09-25 17:18:39.863449	\N	t	f	f	\N	115
0	33	-2	Etiqueta dirección	\N	2020-04-18 20:24:53.453	maestro.direccion.etiqueta	t	f	f	\N	119
33	1	-2	Legal	\N	2021-09-20 16:39:45.647	33x1	t	f	f	\N	120
33	3	-2	Trabajo	\N	2021-09-20 16:39:45.647	33x3	t	f	f	\N	121
33	2	-2	Casa	\N	2021-09-20 16:39:45.647	33x2	t	f	f	\N	122
6	5	-2	Foto	\N	2020-04-18 12:45:27.21	maestro.entidad.foto	t	f	f	{"coTabla": 1, "noTitulo": "Foto", "flGaleria": 0, "txExtensiones": "image/*"}	123
11	22	15	Tabla	\N	2020-04-30 13:52:04	urbano.entidad	t	f	f	{"txDescripcion": "Módulo de Urbano"}	125
0	38	-2	Tabla	\N	2025-09-17 19:30:22.918168	maestro.tabla.tipo	t	f	f	{"Job": "DELETE FROM seguridad.tblingreso WHERE coestreg IN (2,3,4) AND feingreso < CURRENT_TIMESTAMP - INTERVAL '90 days';"}	126
0	9	2	Predio		2018-12-05 12:05:52.523	condominio.predio.tipo	t	f	f	\N	127
23	2	-100	EDUCACIÓN ESPECIAL INCOMPLETA		2021-09-20 14:27:24.693	23x2	t	f	f	\N	128
23	3	-100	EDUCACIÓN ESPECIAL COMPLETA		2021-09-20 14:27:24.693	23x3	t	f	f	\N	129
23	4	-100	EDUCACIÓN PRIMARIA INCOMPLETA		2021-09-20 14:27:24.693	23x4	t	f	f	\N	130
23	5	-100	EDUCACIÓN PRIMARIA COMPLETA		2021-09-20 14:27:24.693	23x5	t	f	f	\N	131
23	6	-100	EDUCACIÓN SECUNDARIA INCOMPLETA		2021-09-20 14:27:24.693	23x6	t	f	f	\N	132
23	7	-100	EDUCACIÓN SECUNDARIA COMPLETA		2021-09-20 14:27:24.693	23x7	t	f	f	\N	133
23	8	-100	EDUCACIÓN TÉCNICA INCOMPLETA		2021-09-20 14:27:24.693	23x8	t	f	f	\N	134
23	9	-100	EDUCACIÓN TÉCNICA COMPLETA		2021-09-20 14:27:24.693	23x9	t	f	f	\N	135
23	10	-100	EDUCACIÓN SUPERIOR (INSTITUTO SUPERIOR, ETC) INCOMPLETA		2021-09-20 14:27:24.693	23x10	t	f	f	\N	136
23	11	-100	EDUCACIÓN SUPERIOR (INSTITUTO SUPERIOR, ETC) COMPLETA		2021-09-20 14:27:24.693	23x11	t	f	f	\N	137
23	12	-100	EDUCACIÓN UNIVERSITARIA INCOMPLETA		2021-09-20 14:27:24.693	23x12	t	f	f	\N	138
6	4	-1	Logo	\N	2018-08-31 17:14:42.617	seguridad.empresa.logo	t	f	f	{"coTabla": 2, "noTitulo": "Logo", "flGaleria": 0, "txExtensiones": "image/*"}	139
6	1	2	Minuta	\N	2018-08-31 17:14:42.617	condominio.predio.minuta	t	f	f	{"coTabla": 8, "noTitulo": "Minuta", "flGaleria": 0, "txExtensiones": ".pdf,.doc,.docx"}	140
6	2	2	Contrato	\N	2019-06-08 16:36:50.777	condominio.predioalquiler.contrato	t	f	f	{"coTabla": 9, "noTitulo": "Contrato", "flGaleria": 0, "txExtensiones": ".pdf,.doc,.docx"}	141
6	3	5	Sustento	\N	2019-06-08 16:36:50.777	soporte.soporte.sustento	t	f	f	{"coTabla": 10, "noTitulo": "Sustento", "flGaleria": 1, "txExtensiones": "image/*,.pdf,.doc,.docx,.msg,.sql,.txt"}	142
5	1	-100	Soltero(a)		2012-10-13 17:54:20.607	5x1	t	f	f	\N	145
5	2	-100	Viudo(a)		2012-10-13 17:54:25.873	5x2	t	f	f	\N	146
5	3	-100	Divorciado(a)		2012-10-13 17:54:31.67	5x3	t	f	f	\N	147
5	4	-100	Casado(a)		2012-10-13 17:54:52.327	5x4	t	f	f	\N	148
5	5	-100	Conviviente		2012-11-05 16:27:26.297	5x5	t	f	f	\N	149
7	1	-1	Página	\N	2018-11-07 15:56:50.01	7x1	t	f	f	\N	150
7	2	-1	Sub página	\N	2018-11-07 15:57:00.593	7x2	t	f	f	\N	151
7	3	-1	Vista flotante	\N	2018-11-07 15:57:12.33	7x3	t	f	f	\N	152
7	4	-1	Servicio web	\N	2020-04-17 14:53:24.48	7x4	t	f	f	\N	153
17	2	-100	Casa	\N	2021-09-20 16:39:45.647	17x2	t	f	f	\N	154
17	3	-100	Otro	\N	2021-09-20 16:39:45.647	17x3	t	f	f	\N	155
38	15	-2	matricula.matriculapension	\N	2025-09-17 19:32:51.581781	\N	t	f	f	\N	159
38	14	-2	expediente.notificacion	\N	2025-09-17 19:32:51.581781	\N	t	f	f	\N	160
38	13	-2	expediente.documento	\N	2025-09-17 19:32:51.581781	\N	t	f	f	\N	161
9	1	2	Condominio		2018-12-05 12:06:59.767	9x1	t	f	f	\N	162
9	2	2	Edificio		2018-12-05 12:07:13.4	9x2	t	f	f	\N	163
0	27	-2	Url red social	\N	2020-04-18 20:24:53.453	maestro.redsocial.url	t	f	f	\N	164
0	11	-2	Persona	\N	2020-04-18 20:24:53.453	maestro.entidad.rol	t	f	f	\N	165
0	34	-2	Calidad de la imagen	\N	2025-09-10 15:57:18.020869	maestro.archivo.calidadimagen	t	f	f	\N	166
0	6	-2	Formatos de archivo		2018-05-17 15:31:02.347	maestro.archivo.formato	t	f	f	\N	167
0	15	7	Modo Pago	\N	2021-09-20 16:33:49.96	contabilidad.credito.modopago	t	f	f	\N	168
0	23	11	Situación educativa	\N	2020-04-18 20:24:53.453	matricula.situacioneducativa	t	f	f	\N	169
2	2	6	Servicios (intangibles, sin stock)	\N	2025-09-25 17:19:58.704677	\N	t	f	f	{"txDescripcion": "no maneja stock."}	171
39	4	-1	Reemplazado	\N	2025-09-25 17:18:39.863449	\N	t	f	f	\N	118
39	2	-1	Revocado	\N	2025-09-25 17:18:39.863449	\N	t	f	f	\N	116
39	3	-1	Expirado	\N	2025-09-25 17:18:39.863449	\N	t	f	f	\N	117
0	8	2	Calculo servicio		2018-12-03 12:31:27.31	condominio.servicio.calculo	t	f	f	\N	144
0	29	-2	Estado registro	\N	2020-04-18 20:24:53.453	maestro.registro.estado	t	f	f	\N	156
0	7	-1	Página		2018-11-07 15:56:09.217	seguridad.pagina.tipo	t	f	f	\N	143
0	32	15	Manzana	\N	2020-04-18 20:24:53.453	urbano.manzana.tipo	t	f	f	\N	158
0	31	15	Motivo Anulación Credito	\N	2020-04-18 20:24:53.453	urbano.credito.motivoanulacion	t	f	f	\N	157
0	19	12	Operación inventario		2018-05-17 15:30:53.993	inventario.inventario.operacion	t	f	f	\N	170
11	21	6	Entidad	\N	2020-04-30 13:52:04	maestro.entidad	t	f	f	{"txDescripcion": "Módulo de Maestro"}	124
0	28	15	Cuota	\N	2020-04-18 20:24:53.453	urbano.cuota.tipo	t	f	f	\N	80
0	25	-2	Red social	\N	2020-04-18 20:24:53.453	maestro.redsocial.tipo	t	f	f	\N	1
0	2	6	Tipos de producto	\N	2025-09-25 17:16:23.560611	catalogo.producto.tipo	t	f	f	\N	86
0	1	-2	Idioma	\N	2026-07-08 19:26:39.254616	maestro.empresa.idioma	t	f	f	\N	172
12	1	-2	Persona Natural	\N	2025-09-16 14:34:16.842904	\N	t	f	f	\N	61
12	2	-2	Persona Jurídica	\N	2025-09-16 14:34:42.012056	\N	t	f	f	\N	62
11	7	3	Beneficiario	\N	2020-04-18 20:45:13.633	finanzapersonal.beneficiario	t	f	f	{"txDescripcion": "Módulo de Finanzas o gastos"}	94
11	8	3	Proveedor	\N	2020-04-18 20:45:44.51	finanzapersonal.proveedor	t	f	f	{"txDescripcion": "Módulo de Finanzas o gastos"}	95
11	24	6	Contacto	\N	2020-04-30 13:52:04	maestro.contacto	t	f	f	{"txDescripcion": "Módulo de Maestro"}	174
\.


--
-- Data for Name: tblusuario; Type: TABLE DATA; Schema: seguridad; Owner: postgres
--

COPY seguridad.tblusuario (cousuario, coentidad, nousuario, noclave, cousucre, cousumod, fecre, femod, flestreg, flsuperadmin) FROM stdin;
3	3	mbalcazar	$2a$11$QOuI0wbqeJtyCPoALNShwOknA2cM9YDppswBmBI7LywE34GkN34aq	-100	\N	2021-12-22 19:14:16.683	\N	t	f
-1	-1	system	9d29a69a-b2ab-499c-bd2c-2ac075d92a5c	\N	\N	2018-06-13 12:01:35.98	\N	t	f
1	22	jabregu	$2a$11$QOuI0wbqeJtyCPoALNShwOknA2cM9YDppswBmBI7LywE34GkN34aq	-100	\N	2018-12-29 11:36:30.437	\N	t	f
2	21	cslim	$2a$11$QOuI0wbqeJtyCPoALNShwOknA2cM9YDppswBmBI7LywE34GkN34aq	-100	\N	2021-12-15 15:57:24.1	\N	t	f
4	4	shuanca	iso123	-100	\N	2021-12-22 22:35:34.4	\N	t	f
5	5	jbaldera	123456	-100	\N	2021-12-22 22:36:24.967	\N	t	f
6	6	eespinoza	47975123	-100	\N	2022-01-13 15:37:38.313	\N	t	f
7	7	nbalcazar	47839732	-100	\N	2022-01-20 17:17:39.43	\N	t	f
8	8	csilva	48383275	-100	\N	2022-02-07 19:47:17.487	\N	t	f
9	9	gbalcazar	123456	-100	\N	2022-03-22 00:29:14.26	\N	t	f
10	10	kleva	123456	-100	\N	2022-04-01 17:18:49.813	\N	t	f
11	11	gvicario	123456	-100	\N	2022-04-06 19:27:11.273	\N	t	f
12	12	frojas	123456	-100	\N	2022-04-20 02:45:22.027	\N	t	f
13	13	ngastelo	43323596	-100	\N	2022-05-28 11:20:44.603	\N	t	f
14	14	mchavez	43201488	-100	\N	2022-05-28 11:22:29.243	\N	t	f
-100	-100	system-100	9d29a69a-b2ab-499c-bd2c-2ac075d92a5c	\N	\N	2018-06-13 12:01:35.98	\N	t	f
\.


--
-- Data for Name: tblempresa; Type: TABLE DATA; Schema: seguridad; Owner: postgres
--

COPY seguridad.tblempresa (coempresa, nomision, novision, txquiensoy, cousucre, cousumod, fecre, femod, comoneda, coentidad, copais, coidioma, configuracion, flestreg, cousuario_owner) FROM stdin;
5	\N	\N	\N	-100	22	2019-08-12 01:43:37.483	2026-04-28 23:28:01.064073	156	5	137	1	\N	t	5
9	\N	\N	\N	-100	22	2024-12-10 09:31:41.03	2026-06-15 15:44:08.551096	156	9	137	1	\N	t	9
10	wewewe 	eeweweew	eweew ere\nrer\nre\nre\ner\nre\ner	-100	22	2024-12-10 09:32:07.33	2026-04-29 22:31:05.065664	156	10	137	1	\N	t	10
12	\N	\N	\N	22	\N	2025-02-27 11:16:56.42	\N	156	12	137	1	\N	t	12
-1	\N	\N	\N	-1	22	2019-08-09 12:07:15.717	2021-08-25 14:07:32.34	156	-1	137	1	\N	t	-1
-100	\N	\N	\N	-1	\N	2020-04-19 19:36:21.087	\N	156	-100	137	1	\N	t	-100
1	Nuestra empresa tiene como objetivo de contribuir al desarrollo de nuestros clientes utilizando la tecnología como herramienta estratégica. 2	En un horizonte de 5 años ser reconocidos entre las destacadas  empresas Peruanas de tecnológica, brindando servicios para   soluciones y soporte efectivas y de calidad para nuestros clientes.	Somos una empresa que se dedica a crear soluciones de software, para mejorar y simplificar los procesos más críticos de su compañía.\nPor ello hacemos uso de las mejores prácticas en el análisis, desarrollo, implementación y soporte técnico.\nAdemás brindamos soporte técnico de hardware.	-1	22	2018-12-04 15:48:51.047	2026-06-18 00:22:30.215663	156	1	137	1	\N	t	1
2	Promover, gestionar y dirigir las diversas especialidades en soluciones de controversias, con metodologías y modelos innovadores.	Ser una organización líder en servicios de conciliación con predominio a la búsqueda de la excelencia en las diversas áreas de solución de controversias, regidos bajo nuestros principios rectores establecidos por la Ley de Conciliación y su Reglamento, promoviendo como elementos básicos el respeto, ética, diálogo, calidad, solidez humana, jurídica y social y en donde el objeto primordial son nuestros clientes.	Somos un equipo de especialistas, debidamente acreditados en el MINJUS, actualizados con las nuevas técnicas de negociación, mediación, normatividad y otras materias pertinentes, que busca resolver las controversias existentes en forma pacífica, con soluciones beneficiosas para ambas partes, transformandolas en oportunidades de desarrollo con el objeto de fortalecer la cultura de paz en nuestro país, ofreciendo un servicio de calidad  y garantía, contribuyendo así, a la mejora en la calidad de vida de las personas.\nsomos una Institución líder e innovadora atendido por Abogados Conciliadores, especialistas en Empresas, Familia y Contrataciones del Estado; dedicada a promover una cultura de paz, cuyo objetivo fundamental es la de prestar servicios en el área de Medios Alternativos de Resolución de Conflictos, estamos debidamente autorizados, mediante Resolución Directoral N° ……………… del Ministerio de Justicia, brindando un servicio de calidad, tecnología, asesoría y soporte en resolver las controversias que mantenga su empresa, garantizándoles acuerdos exigibles y ejecutables ante el Poder Judicial.  Contamos para ello con profesionales de primer nivel para cada tipo de servicio que ofrecemos, tales como la Conciliación Extrajudicial y con especialización en Familia, brindando servicios de Conciliación a Personas Naturales, Personas Jurídicas y Conciliaciones con el Estado.\n\nContamos con un equipo profesional de vasta experiencia, que están capacitados y cuentan con la vocación de servicio y dinámica necesaria para lograr las Conciliaciones Extrajudiciales, además de contar con ambientes organizacionales seguros, higiénicos, agradables, para ello nuestras Oficinas cuentan con una infraestructura moderna, especialmente diseñada para realizar la función conciliadora, que aseguran una óptima y eficaz prestación del servicio conciliatorio, además de tener un sólido compromiso de trabajo, siendo confidencial, imparcial, rápido y económico, que son el respaldo e importantes principios de nuestro Centro de Conciliación.\n\nPor todo ello, ustedes pueden estar seguros que nuestro Centro de Conciliación, le ofrecerá un servicio de primer nivel, que garantiza el éxito en resolver sus controversias.\n\nTe esperamos para poder trabajar de manera conjunta con ustedes, y podrán comprobar que es realidad nuestro compromiso de acuerdo a lo expresado líneas arriba; expresándoles nuestras consideraciones y deferencia personal.	-1	22	2019-08-09 16:06:15.117	2026-06-19 23:44:59.3741	156	2	137	1	\N	t	2
3	Impartir justicia, pedir justicia, defender la causa de la justicia, es la más alta misión humana.	En un horizonte de 5 años consolidarse entre los consultorios más destacados de Lima, ofreciendo a nuestros clientes un servicio eficaz y de calidad, teniendo a nuestra disposición profesionales destacados.	Somos un equipo de abogados cuya finalidad es brindar el mejor asesoramiento para los casos.	-1	22	2019-08-09 16:06:15.117	2026-06-12 23:56:56.210303	156	3	137	1	\N	t	3
4	DOLCI CONSULTORES & MULTISERVICIOS, es una empresa especializada en consultoría, asesoría legal y multiservicios especializada en gestión pública y privada; busca la excelencia no sólo en la calidad técnica del trabajo de sus especialistas, sino también contribuir activamente al desarrollo empresarial, institucional, personal de nuestros clientes y colaboradores.	DOLCI CONSULTORES & MULTISERVICIOS, es una empresa que aspira a la excelencia en la prestación de consultorías, asesorías y servicios gracias a un asesoramiento de alta calidad a nivel nacional y mundial, y ser referente en cuanto a satisfacción de nuestros clientes y resultados, apostando por la innovación para superar los retos que se presenten en el futuro.	<h5>Presentación</h5>\n<p style='text-align:justify;'>Somos una Institución innovadora atendido por Especialistas de diferentes materias (Economistas, Administradores de Empresas, Contadores, Abogados, Ingenieros y Otros), cuyo objetivo fundamental es la de prestar servicios de Consultoría y Asesoría Legal, Empresarial, Informática, Imagen, Protocolo y de  Gestión Pública y Privada, así como en Organización de Eventos Académicos, Talleres, Conferencias, Fórums, Congresos, Seminarios.</p>\n<p style='text-align:justify;'>Estamos debidamente inscritos en la Superintendencia Nacional de los Registros Públicos – Partida N° 12536784 – Zona Registral N° IX – Sede Lima – Oficina Registral Lima, con fecha 01 de septiembre de 2010, con RUC 20537360179, inscritos en el Registro Nacional de Proveedores – RNP del Organismo Supervisor de las Contrataciones del Estado – OSCE.</p>\n<p style='text-align:justify;'>Brindamos un servicio de calidad, en asesoría y soporte en gestión pública y privada que requiera vuestra empresa y/o institución, garantizándoles eficiencia y calidad en nuestros servicios. Contando para ello con profesionales de primer nivel por cada tipo de servicio que ofrecemos, tales como Consultoría y Asesoría Legal, ofreciendo los servicios a Personas Naturales, Personas Jurídicas y/o Instituciones del Estado.</p>\n<p style='text-align:justify;'>Basamos nuestra relación en la generación de confianza a largo plazo, convirtiéndonos en socios estratégicos de las empresas y/o instituciones con las que trabajamos y posibilitando la aplicación de nuestros servicios a lo largo de toda la cadena de valor.\nNuestra filosofía de trabajo, es tratar de relacionarnos de la misma manera que nos gusta ser tratados: Con seriedad, compromiso, transparencia y confianza, estamos fuertemente comprometidos con nuestros clientes, hasta llegar al más alto nivel de servicio personalizado y de alta calidad.\n<p style='text-align:justify;'>Contamos con un equipo profesional de vasta experiencia, que están capacitados y cuentan con la vocación de servicio y dinámica necesaria para lograr los trabajos de Consultoría y Asesoría Legal, lo que asegura una óptima y eficaz prestación del servicio contratado, además de tener un sólido compromiso de trabajo, siendo confidencial, imparcial, rápido y económico, que son el respaldo e importantes principios de nuestra Empresa.</p>\n\n\n<h5>Objetivos</h5>\n<ol style='color: #495057; font-size: 15px; text-transform: capitalize; line-height: 31px; margin-bottom: 30px;' type='A'>\n<li>Que adquieran nuevos conocimientos, destrezas y habilidades.</li>\n<li>Estar en la vanguardia de mejora en el nivel de eficiencia en su área (mejora de procesos).</li>\n<li>Contribuir con la actualización de los documentos de gestión, aplicando y respetando la normativa vigente.</li>\n<li>Favorecer que los trabajadores logren estar con satisfacción, motivación, y su integración en la empresa y/o institución.</li>\n<li>Propiciar un mejor ambiente y atención para sus colaboradores, proveedores, usuarios, consumidores y/o clientes, empleando para ello los documentos actualizados y de simple aplicación.</li>\n<li>Activar la participación y compromiso de sus colaboradores y/o trabajadores.</li>\n<li>Posibilitar el conocimiento de nuevas tecnologías y formas de trabajar.</li>\n<li>Reducir el número de accidentes laborales.</li>\n<li>Permitir al trabajador prepararse para la asunción de responsabilidades, la toma de decisiones eficientes y la resolución de problemas.</li>\n<li>Ahorrar el tiempo y costo que implica resolver las controversias. </li>\n<li>Eficiencia en el costo beneficio de la Empresa y/o Institución.</li>\n<li>Mejora continua de la Empresa y/o Institución.</li>\n<li>Generar ventaja competitiva de la Empresa y/o Institución.</li>\n<li>Lograr crecimiento en los beneficios económicos.</li>\n<li>Garantía de un confiable y eficiente servicio.</li>\n<li>Mayores posibilidades de posicionarse en el mercado.</li>\n<li>Credibilidad y confianza entre trabajadores, proveedores y usuarios.</li>\n</ol>\n<h5>Ventajas de nuestra empresa</h5>\n<ol style='color: #495057; font-size: 15px; text-transform: capitalize; line-height: 31px; margin-bottom: 30px;' type='A'>\n<li>Favorecer los procesos de gestión de calidad.</li>\n<li>Aumentar el nivel de competitividad y rentabilidad de la empresa.</li>\n<li>Incrementar el compromiso del personal con la institución.</li>\n<li>Mejorar  la cualificación de los trabajadores.</li>\n<li>Disminuir el tiempo y los costos.</li>\n<li>Es confidencial y reservada.</li>\n<li>Evita procesos judiciales.</li>\n<li>Incrementar la calidad de los productos y/o servicios.</li>\n</ol>	-100	22	2019-08-10 17:38:19.363	2025-04-10 10:25:22.977	156	4	137	1	\N	t	4
6	La misión de la escuela es brindar formación académica de alto nivel en temas electorales, de democracia y de gobernabilidad, contribuyendo a fomentar conocimiento e investigación, así como generar debate en dichas materias, con alcance nacional e internacional.	La Escuela Electoral y de Gobernabilidad del Jurado Nacional de Elecciones tiene como visión ser el más prestigioso centro académico de estudios especializados en temas electorales, de democracia y de gobernabilidad en América Latina y constituirse en la máxima referencia a nivel de los centros académicos de los organismos electorales de la región.	La Escuela Electoral y de Gobernabilidad es el órgano de altos estudios electorales, de investigación académica y de apoyo técnico al desarrollo y cumplimiento de los objetivos del Jurado Nacional de Elecciones.\n\n###Nuestro objetivo es ofrecer una formación de calidad, al más alto nivel, a través de acciones académicas especializadas y del empleo de recursos tecnológicos eficientes, en el marco de los Pilares y Principios de la política institucional del Jurado Nacional de Elecciones, y en coherencia con el objetivo estratégico institucional OE4 orientado a mejorar los conocimientos y capacidades en materia cívico-electoral y de gobernabilidad de la ciudadanía y organizaciones políticas.###\n\nAdemás tenemos como objetivos específicos, brindar formación académica de alto nivel en temas electorales, de democracia y de gobernabilidad, a través de la realización y desarrollo de programas, investigaciones académicas y publicaciones que generen conocimiento científico, debate y análisis crítico de los fenómenos estudiados en dichas materias.\n\nContribuir al desarrollo de la educación electoral a través de la promoción de actividades académicas descentralizadas.\nFortalecer la educación electoral a nivel nacional principalmente a favor de la juventud y actores políticos.\nFomentar el debate y conocimiento de los principios y reglas que rigen la resolución de los conflictos electorales a través del estudio de la jurisprudencia del Jurado Nacional de Elecciones\nBrindar programas de capacitación en materia electoral y de gestión pública al personal interno.	-100	22	2019-08-12 14:11:43.453	2025-04-11 16:28:06.803	156	6	137	1	\N	t	6
7	\N	\N	Nuestra empresa cuenta con mas de 10 años de experiencia en los diferentes tipos de traslados en los que disponemos de conductores calificados en el manejo y cuidado de las unidades.\nAsimismo, tenemos personal capacitado en la calidad de servicios para entregas de unidades a clientes finales, como también flotas y licitaciones a entidades del Estado.\nLos conductores cuentan con el seguro contra todo riesgo (SCTR), certificado negativo del COVID-19 y todos los trabajos son realizados bajo los protocolos sanitarios establecidos.\nTodos los servicios brindados por nuestro personal se realizarán con el\nuniforme adecuado, identificación respectiva e indumentaria sanitaria para\nel COVID-19.	22	689	2022-04-01 17:16:11.72	2022-04-06 02:33:29.053	156	7	137	1	\N	t	7
8	Administrar la justicia electoral, fiscalizar los procesos electorales, impartir la educación electoral y mantener el registro de las organizaciones políticas; orientado a garantizar el respeto de la voluntad ciudadana, consolidar el sistema de partidos políticos y fortalecer la institucionalidad democrática del Perú, de forma transparente, eficiente y moderna.\n\n	Organismo electoral transparente, eficiente y moderno, que promueve una democracia estable, para un país próspero y sostenible. \n\n	Es un organismo constitucionalmente autónomo con competencias a nivel nacional. Su máxima autoridad es el Pleno, que está integrado por cinco miembros elegidos en diferentes instancias: uno por la Sala Plena de la Corte Suprema de Justicia de la República (quien lo preside); uno por la Junta de Fiscales Supremos, uno por el Colegio de Abogados de Lima, uno por los Decanos de las Facultades de Derecho de las Universidades Públicas y uno por los Decanos de las Facultades de Derecho de las Universidades Privadas. La conformación colegiada y la forma de elección del Pleno garantizan la independencia e imparcialidad en la toma de decisiones de cada uno de sus miembros.	22	22	2022-04-22 21:58:46.277	2026-04-28 23:27:53.30053	156	8	137	1	\N	t	8
11	324234	q4	23423	-100	22	2024-12-10 15:31:27.343	2026-04-29 23:04:32.571165	156	11	137	1	\N	t	11
13	\N	\N	\N	22	\N	2025-03-31 15:36:31.407	\N	156	13	137	1	\N	t	13
14	\N	\N	\N	22	\N	2026-06-19 23:18:16.304066	\N	156	14	137	1	\N	t	14
\.


--
-- Data for Name: tblatributo; Type: TABLE DATA; Schema: catalogo; Owner: postgres
--

COPY catalogo.tblatributo (coatributo, coempresa, noatributo, cotipodato, fecre, cocategoria, nuorden, flobligatorio, flfiltrable, fldescriptivo, cousucre, flestreg, femod, cousumod) FROM stdin;
\.


--
-- Data for Name: tblproducto; Type: TABLE DATA; Schema: catalogo; Owner: postgres
--

COPY catalogo.tblproducto (coempresa, coproducto, nocodigointerno, comarca, colaboratorio, noproducto, nomodelo, counidadmedidainventario, counidadmedidacompra, counidadmedidaventa, ssfactorcompra, coproveedorprincipal, txdescripcioncorta, cousucre, cousumod, fecre, femod, cocategoria, cocategoriahijo, cotipo, flimpuesto, flinventario, nocodigofiscal, flestreg, ssfactorventa, flimpuestoexento) FROM stdin;
1	5	\N	\N	\N	Google Pixel 9	\N	1	1	1	1.0000	\N	Para limpiarse el pop	1	\N	2025-10-23 17:21:49.150202	\N	\N	\N	1	0	1	\N	t	1.0000	f
1	7	\N	\N	\N	DJI Action 2	\N	1	1	1	1.0000	\N	para limpiears la cara	1	\N	2025-10-29 14:44:26.111185	\N	\N	\N	1	0	1	\N	t	1.0000	f
1	10	PRD-001	2	3	Paracetamol 500mg	Tabletas	1	1	1	1.0000	\N	Medicamento analgésico	100	\N	2025-10-31 15:55:44.547823	\N	5	6	1	0	1	PF-001	t	1.0000	f
1	11	PRD-002	2	3	Galaxy Tab S6	SM-2625	1	1	1	1.0000	\N	Tablet Galaxy Tab S6	100	\N	2025-10-31 15:56:38.093443	\N	5	6	1	0	1	PF-002	t	1.0000	f
1	12	PRD-003	2	3	Galaxy Tab S7	SM-2625	1	1	1	1.0000	\N	Tablet Galaxy Tab S7	100	\N	2025-10-31 15:56:49.700949	\N	5	6	1	0	1	PF-003	t	1.0000	f
1	13	PRD-004	2	3	Galaxy Tab S8	SM-2625	1	1	1	1.0000	\N	Tablet Galaxy Tab S8	100	\N	2025-10-31 15:57:02.575409	\N	5	6	1	0	1	PF-004	t	1.0000	f
1	14	PRD-009	2	3	Galaxy Tab S9	SM-2625	1	1	1	1.0000	\N	Tablet Galaxy Tab S9	100	\N	2025-10-31 15:57:15.342582	\N	5	6	1	0	1	PF-009	t	1.0000	f
1	15	PRD-010	2	3	Galaxy Tab S10	SM-2625	1	1	1	1.0000	\N	Tablet Galaxy Tab S10	100	\N	2025-10-31 15:57:31.767937	\N	5	6	1	0	1	PF-010	t	1.0000	f
1	16	PRD-011	2	3	Galaxy Tab S11	SM-2625	1	1	1	1.0000	\N	Tablet Galaxy Tab S11	100	\N	2025-10-31 15:57:40.752884	\N	5	6	1	0	1	PF-011	t	1.0000	f
1	17	PRD-012	2	3	Galaxy Tab S12	SM-2625	1	1	1	1.0000	\N	Tablet Galaxy Tab S12	100	\N	2025-10-31 15:57:51.495568	\N	5	6	1	0	1	PF-012	t	1.0000	f
1	18	\N	2	3	Google Pixel 4	SM-2625	1	1	1	1.0000	\N	Teléfono Google Pixel 4	100	\N	2025-10-31 15:58:29.081894	\N	5	6	1	0	1	\N	t	1.0000	f
1	19	\N	2	3	Google Pixel 5	SM-2625	1	1	1	1.0000	\N	Teléfono Google Pixel 5	100	\N	2025-10-31 15:58:35.208803	\N	5	6	1	0	1	\N	t	1.0000	f
1	20	\N	2	3	Google Pixel 6	SM-2625	1	1	1	1.0000	\N	Teléfono Google Pixel 6	100	\N	2025-10-31 15:58:41.650041	\N	5	6	1	0	1	\N	t	1.0000	f
1	21	\N	2	3	Google Pixel 6a	SM-2625	1	1	1	1.0000	\N	Teléfono Google Pixel 6a	100	\N	2025-10-31 15:58:47.322609	\N	5	6	1	0	1	\N	t	1.0000	f
1	22	\N	2	3	Google Pixel 8	SM-2625	1	1	1	1.0000	\N	Teléfono Google Pixel 8	100	\N	2025-10-31 15:58:59.71662	\N	5	6	1	0	1	\N	t	1.0000	f
1	23	\N	2	3	Google Pixel 9	SM-2625	1	1	1	1.0000	\N	Teléfono Google Pixel 9	100	\N	2025-10-31 15:59:05.706357	\N	5	6	1	0	1	\N	t	1.0000	f
1	24	\N	2	3	Google Pixel 10	SM-2625	1	1	1	1.0000	\N	Teléfono Google Pixel 10	100	\N	2025-10-31 15:59:12.417703	\N	5	6	1	0	1	\N	t	1.0000	f
1	25	\N	2	3	Google Pixel 11	SM-262s25	1	1	1	1.0000	\N	Teléfono Google Pixel 11	100	\N	2025-10-31 15:59:21.793841	\N	5	6	1	0	1	\N	t	1.0000	f
1	26	\N	2	3	DJI Action 2	SM-262s25	1	1	1	1.0000	\N	Camara DJI Action 2	100	\N	2025-10-31 15:59:55.044482	\N	5	6	1	0	1	\N	t	1.0000	f
1	27	\N	2	3	DJI Action 3	SM-262s25	1	1	1	1.0000	\N	Camara DJI Action 3	100	\N	2025-10-31 16:00:00.621476	\N	5	6	1	0	1	\N	t	1.0000	f
1	28	\N	2	3	DJI Action 4	SM-262s25	1	1	1	1.0000	\N	Camara DJI Action 4	100	\N	2025-10-31 16:00:04.835515	\N	5	6	1	0	1	\N	t	1.0000	f
1	29	\N	2	3	GO PRO 8	SM-262s25	1	1	1	1.0000	\N	Camara GO PRO 8	100	\N	2025-10-31 16:00:22.878201	\N	5	6	1	0	1	\N	t	1.0000	f
1	30	\N	2	3	GO PRO 9	SM-262s25	1	1	1	1.0000	\N	Camara GO PRO 9	100	\N	2025-10-31 16:00:29.156176	\N	5	6	1	0	1	\N	t	1.0000	f
1	31	\N	2	3	GO PRO 10	SM-262s25	1	1	1	1.0000	\N	Camara GO PRO 10	100	\N	2025-10-31 16:00:35.204653	\N	5	6	1	0	1	\N	t	1.0000	f
1	32	\N	2	3	GO PRO 11	SM-262s25	1	1	1	1.0000	\N	Camara GO PRO 11	100	\N	2025-10-31 16:00:39.926641	\N	5	6	1	0	1	\N	t	1.0000	f
1	33	\N	2	3	GO PRO 12	SM-262s25	1	1	1	1.0000	\N	Camara GO PRO 12	100	\N	2025-10-31 16:00:43.741606	\N	5	6	1	0	1	\N	t	1.0000	f
1	34	\N	2	3	GO PRO 13	SM-262s25	1	1	1	1.0000	\N	Camara GO PRO 13	100	\N	2025-10-31 16:00:48.292139	\N	5	6	1	0	1	\N	t	1.0000	f
\.


--
-- Data for Name: tblproductoatributo; Type: TABLE DATA; Schema: catalogo; Owner: postgres
--

COPY catalogo.tblproductoatributo (coproductoatributo, coproducto, coatributo, novalor, coempresa, fecre, cousucre, femod, cousumod, flestreg) FROM stdin;
\.


--
-- Data for Name: tblproductoimpuesto; Type: TABLE DATA; Schema: catalogo; Owner: postgres
--

COPY catalogo.tblproductoimpuesto (coempresa, coproductoimpuesto, coproducto, coimpuesto, fecre, cousucre, coimpuestohijo, flestreg, pqtaza) FROM stdin;
\.


--
-- Data for Name: tblproductoindex; Type: TABLE DATA; Schema: catalogo; Owner: postgres
--

COPY catalogo.tblproductoindex (coproductoindex, coempresa, coproducto, noproducto, txdescripcioncorta, jsonatributo, txbusqueda, cocategoria) FROM stdin;
\.


--
-- Data for Name: tblproductoprecio; Type: TABLE DATA; Schema: catalogo; Owner: postgres
--

COPY catalogo.tblproductoprecio (coempresa, coproductoprecio, cotipoprecio, coproducto, ssprecio, cousucre, cousumod, fecre, femod, flestreg, comoneda) FROM stdin;
\.


--
-- Data for Name: tbllocal; Type: TABLE DATA; Schema: empresa; Owner: postgres
--

COPY empresa.tbllocal (colocal, coempresa, nolocal, nodireccion, nocodigopostal, cousucre, fecre, coubigeo, flprincipal, flestreg) FROM stdin;
0	1	Blanco	\N	\N	0	2018-01-01 00:00:00	\N	t	t
1	1	Carapongo	Mz. L1 Lote 16 Urbanización San Antonio de Carapongo Calle 27	Lima 37	1	2018-11-22 15:20:55.183	\N	t	t
2	1	ss	ssss	\N	1	2018-11-22 15:21:41.673	\N	t	t
3	1	Huampani Sol	Mz . g6 Lot 3 	\N	1	2018-11-22 15:27:26.39	\N	t	t
4	1	Breña	Jr. 231,Jr. 231,Jr. 231,Jr. 231 d	\N	1	2019-05-31 11:22:00.21	\N	t	t
5	1	saraaaaaaa	ffggg	\N	1	2019-06-01 22:11:21.513	\N	t	t
6	-1	q	2131,2131,2131,2131	\N	22	2020-04-22 13:36:56.873	\N	t	t
7	1	RETER	3rrrr	\N	22	2020-05-03 01:06:20.133	\N	t	t
8	2	Local 1	Direccion	\N	126	2020-05-04 22:22:50.793	\N	t	t
9	1	Local 1	Local 1 ..	\N	22	2020-06-15 11:20:29.48	\N	t	t
11	-1	656	dfg	\N	22	2020-09-27 01:55:41.173	\N	t	t
12	3	3ew	we	\N	22	2020-10-04 20:02:32.97	\N	t	t
13	4	Local 1	xxx	\N	22	2020-10-25 13:30:38.227	\N	t	t
14	1	w	qw	\N	22	2021-07-05 12:43:29.737	\N	t	t
15	6	Local 1	Direccio xxxx	\N	229	2021-08-19 00:39:05.6	\N	t	t
16	1	45	56	\N	22	2021-09-01 15:52:56.663	\N	t	t
17	6	ESEG	Jirón Nazca 598, Jesús María 15072	15072	702	2022-04-06 19:47:44.08	\N	t	t
\.


--
-- Data for Name: tblalmacen; Type: TABLE DATA; Schema: inventario; Owner: postgres
--

COPY inventario.tblalmacen (coempresa, coalmacen, colocal, noalmacen, cousucre, cousumod, fecre, femod, flestreg, flprincipal) FROM stdin;
\.


--
-- Data for Name: tblproductostock; Type: TABLE DATA; Schema: catalogo; Owner: postgres
--

COPY catalogo.tblproductostock (coempresa, coproductostock, coproducto, colocal, coalmacen, qtinicial, qtmaxima, qtminima, cousucre, cousumod, fecre, femod, flestreg, fldefault) FROM stdin;
\.


--
-- Data for Name: tblproductoterminado; Type: TABLE DATA; Schema: catalogo; Owner: postgres
--

COPY catalogo.tblproductoterminado (coempresa, coproductoterminado, coproductopadre, nuorden, coproducto, qtproducto, cousucre, cousumod, fecre, femod, flestreg) FROM stdin;
\.


--
-- Data for Name: tbltipocambio; Type: TABLE DATA; Schema: contabilidad; Owner: postgres
--

COPY contabilidad.tbltipocambio (coempresa, cotipocambio, comonedaorigen, sscompra, ssventa, cousucre, fecre, flestreg, flautomatico, femod, cousumod, comonedadestino, cofuente, fetipocambio) FROM stdin;
1	1	106	3.92600000	3.93800000	22	2021-10-18 11:39:56.043	t	f	\N	\N	143	1	2026-07-07
1	2	106	3.92600000	3.93800000	22	2021-10-18 11:44:37.463	t	f	\N	\N	143	1	2026-07-07
1	3	106	3.94300000	3.95100000	22	2021-10-18 11:44:50.87	t	f	\N	\N	143	1	2026-07-07
1	5	106	3.00000000	3.00000000	22	2021-10-18 14:11:55.037	t	f	\N	\N	143	1	2026-07-07
1	6	106	9.00000000	6.00000000	22	2021-10-18 17:16:44.233	t	f	\N	\N	143	1	2026-07-07
1	7	106	4.00000000	3.00000000	22	2021-10-18 17:16:51.073	t	f	\N	\N	143	1	2026-07-07
1	8	106	4.13200000	4.13600000	22	2021-10-18 22:28:24.523	t	f	\N	\N	143	1	2026-07-07
1	9	106	4.12700000	4.13400000	22	2021-10-18 22:28:40.343	t	f	\N	\N	143	1	2026-07-07
1	10	106	4.12800000	4.13400000	22	2021-10-18 22:28:57.78	t	f	\N	\N	143	1	2026-07-07
1	11	106	4.12700000	4.13400000	22	2021-10-18 22:29:13.077	t	f	\N	\N	143	1	2026-07-07
1	12	106	4.12700000	4.13600000	22	2021-10-18 22:29:28.09	t	f	\N	\N	143	1	2026-07-07
1	13	106	4.12800000	4.13300000	22	2021-10-18 22:37:37.75	t	f	\N	\N	143	1	2026-07-07
1	14	106	4.13100000	4.13500000	22	2021-10-18 22:37:50.77	t	f	\N	\N	143	1	2026-07-07
1	15	106	4.09800000	4.10900000	22	2021-10-18 22:38:05.73	t	f	\N	\N	143	1	2026-07-07
1	16	106	4.09800000	4.10900000	22	2021-10-18 22:38:17.267	t	f	\N	\N	143	1	2026-07-07
1	17	106	4.09800000	4.10900000	22	2021-10-18 22:38:29.513	t	f	\N	\N	143	1	2026-07-07
1	18	106	4.09800000	4.10900000	22	2021-10-18 22:38:41.13	t	f	\N	\N	143	1	2026-07-07
1	19	106	4.07200000	4.08000000	22	2021-10-18 22:38:55.297	t	f	\N	\N	143	1	2026-07-07
1	20	106	4.06200000	4.06700000	22	2021-10-18 22:39:14.427	t	f	\N	\N	143	1	2026-07-07
1	21	106	3.99700000	4.00200000	22	2021-10-18 22:39:27.707	t	f	\N	\N	143	1	2026-07-07
1	22	106	3.93600000	3.95000000	22	2021-10-18 22:39:41.75	t	f	\N	\N	143	1	2026-07-07
1	23	106	3.92600000	3.93800000	22	2021-10-18 22:39:53.707	t	f	\N	\N	143	1	2026-07-07
1	24	106	4.12500000	4.13000000	22	2021-10-18 22:41:08.82	t	f	\N	\N	143	1	2026-07-07
1	25	106	3.20000000	3.90000000	22	2021-10-19 21:17:48.143	t	f	\N	\N	143	1	2026-07-07
1	26	106	4.00000000	3.00000000	-100	2021-10-19 23:20:53.33	t	f	\N	\N	143	1	2026-07-07
1	27	106	5.00000000	6.00000000	22	2021-10-19 23:21:58.317	t	f	\N	\N	143	1	2026-07-07
1	28	106	5.00000000	6.00000000	-100	2021-10-20 12:21:51.453	t	f	\N	\N	143	1	2026-07-07
1	29	106	5.00000000	6.00000000	-100	2021-11-08 18:35:17.093	t	f	\N	\N	143	1	2026-07-07
1	30	106	5.00000000	6.00000000	-100	2022-09-23 02:03:39.787	t	f	\N	\N	143	1	2026-07-07
\.


--
-- Data for Name: trfpais; Type: TABLE DATA; Schema: maestro; Owner: postgres
--

COPY maestro.trfpais (nopais, nocodigoiso2, fecre, nocodigoiso3, noprefijotelefono, copais, flestreg, comoneda) FROM stdin;
Corea del Norte	KP	2025-09-15 14:27:05.575167	PRK	\N	3	f	\N
Bielorrusia	BY	2025-09-15 14:27:05.575167	BLR	\N	42	f	\N
Bosnia y Herzegovina	BA	2025-09-15 14:27:05.575167	BIH	\N	44	f	\N
Guinea-Bisáu	GW	2025-09-15 14:27:05.575167	GNB	\N	75	f	\N
Liechtenstein	LI	2025-09-15 14:27:05.575167	LIE	\N	102	f	\N
Macedonia del Norte	MK	2025-09-15 14:27:05.575167	MKD	\N	105	f	\N
Micronesia	FM	2025-09-15 14:27:05.575167	FSM	\N	116	f	\N
Moldavia	MD	2025-09-15 14:27:05.575167	MDA	\N	117	f	\N
Bulgaria	BG	2025-09-15 14:27:05.575167	BGR	\N	48	f	14
Burkina Faso	BF	2025-09-15 14:27:05.575167	BFA	\N	49	f	153
Burundi	BI	2025-09-15 14:27:05.575167	BDI	\N	50	f	16
Bután	BT	2025-09-15 14:27:05.575167	BTN	\N	51	f	22
Cabo Verde	CV	2025-09-15 14:27:05.575167	CPV	\N	52	f	34
Camboya	KH	2025-09-15 14:27:05.575167	KHM	\N	53	f	71
Camerún	CM	2025-09-15 14:27:05.575167	CMR	\N	54	f	151
Chipre	CY	2025-09-15 14:27:05.575167	CYP	\N	59	f	43
Comoras	KM	2025-09-15 14:27:05.575167	COM	\N	61	f	73
Congo	CG	2025-09-15 14:27:05.575167	COG	\N	62	f	151
Fiyi	FJ	2025-09-15 14:27:05.575167	FJI	\N	64	f	44
Gabón	GA	2025-09-15 14:27:05.575167	GAB	\N	66	f	151
Gambia	GM	2025-09-15 14:27:05.575167	GMB	\N	67	f	51
Georgia	GE	2025-09-15 14:27:05.575167	GEO	\N	68	f	48
Ghana	GH	2025-09-15 14:27:05.575167	GHA	\N	69	f	49
Grecia	GR	2025-09-15 14:27:05.575167	GRC	\N	70	f	43
Granada	GD	2025-09-15 14:27:05.575167	GRD	\N	71	f	152
Guatemala	GT	2025-09-15 14:27:05.575167	GTM	\N	72	f	53
Guinea	GN	2025-09-15 14:27:05.575167	GIN	\N	73	f	52
Guinea Ecuatorial	GQ	2025-09-15 14:27:05.575167	GNQ	\N	74	f	151
Guyana	GY	2025-09-15 14:27:05.575167	GUY	\N	76	f	54
Haití	HT	2025-09-15 14:27:05.575167	HTI	\N	77	f	58
Honduras	HN	2025-09-15 14:27:05.575167	HND	\N	78	f	56
Hungría	HU	2025-09-15 14:27:05.575167	HUN	\N	79	f	59
Indonesia	ID	2025-09-15 14:27:05.575167	IDN	\N	81	f	60
Irak	IQ	2025-09-15 14:27:05.575167	IRQ	\N	82	f	63
Irán	IR	2025-09-15 14:27:05.575167	IRN	\N	83	f	64
Irlanda	IE	2025-09-15 14:27:05.575167	IRL	\N	84	f	43
Islandia	IS	2025-09-15 14:27:05.575167	ISL	\N	85	f	65
Jamaica	JM	2025-09-15 14:27:05.575167	JAM	\N	88	f	66
Jordania	JO	2025-09-15 14:27:05.575167	JOR	\N	90	f	67
Kazajistán	KZ	2025-09-15 14:27:05.575167	KAZ	\N	91	f	77
Kenia	KE	2025-09-15 14:27:05.575167	KEN	\N	92	f	69
Kirguistán	KG	2025-09-15 14:27:05.575167	KGZ	\N	93	f	70
Kiribati	KI	2025-09-15 14:27:05.575167	KIR	\N	94	f	8
Kuwait	KW	2025-09-15 14:27:05.575167	KWT	\N	95	f	75
Laos	LA	2025-09-15 14:27:05.575167	LAO	\N	96	f	78
Lesoto	LS	2025-09-15 14:27:05.575167	LSO	\N	97	f	82
Letonia	LV	2025-09-15 14:27:05.575167	LVA	\N	98	f	43
Líbano	LB	2025-09-15 14:27:05.575167	LBN	\N	99	f	79
Liberia	LR	2025-09-15 14:27:05.575167	LBR	\N	100	f	81
Libia	LY	2025-09-15 14:27:05.575167	LBY	\N	101	f	83
Lituania	LT	2025-09-15 14:27:05.575167	LTU	\N	103	f	43
Luxemburgo	LU	2025-09-15 14:27:05.575167	LUX	\N	104	f	43
Madagascar	MG	2025-09-15 14:27:05.575167	MDG	\N	106	f	86
Malasia	MY	2025-09-15 14:27:05.575167	MYS	\N	107	f	96
Malaui	MW	2025-09-15 14:27:05.575167	MWI	\N	108	f	94
Maldivas	MV	2025-09-15 14:27:05.575167	MDV	\N	109	f	93
Malí	ML	2025-09-15 14:27:05.575167	MLI	\N	110	f	153
Malta	MT	2025-09-15 14:27:05.575167	MLT	\N	111	f	43
Marruecos	MA	2025-09-15 14:27:05.575167	MAR	\N	112	f	84
Mauricio	MU	2025-09-15 14:27:05.575167	MUS	\N	113	f	92
Mauritania	MR	2025-09-15 14:27:05.575167	MRT	\N	114	f	91
Mónaco	MC	2025-09-15 14:27:05.575167	MCO	\N	118	f	43
Mongolia	MN	2025-09-15 14:27:05.575167	MNG	\N	119	f	89
Montenegro	ME	2025-09-15 14:27:05.575167	MNE	\N	120	f	43
Mozambique	MZ	2025-09-15 14:27:05.575167	MOZ	\N	121	f	97
Namibia	NA	2025-09-15 14:27:05.575167	NAM	\N	122	f	98
Nauru	NR	2025-09-15 14:27:05.575167	NRU	\N	123	f	8
Nepal	NP	2025-09-15 14:27:05.575167	NPL	\N	124	f	102
Nicaragua	NI	2025-09-15 14:27:05.575167	NIC	\N	125	f	100
Níger	NE	2025-09-15 14:27:05.575167	NER	\N	126	f	153
Nigeria	NG	2025-09-15 14:27:05.575167	NGA	\N	127	f	99
Noruega	NO	2025-09-15 14:27:05.575167	NOR	\N	128	f	101
Omán	OM	2025-09-15 14:27:05.575167	OMN	\N	130	f	104
Países Bajos	NL	2025-09-15 14:27:05.575167	NLD	\N	131	f	43
Pakistán	PK	2025-09-15 14:27:05.575167	PAK	\N	132	f	109
Panamá	PA	2025-09-15 14:27:05.575167	PAN	\N	134	f	105
Papúa Nueva Guinea	PG	2025-09-15 14:27:05.575167	PNG	\N	135	f	107
Portugal	PT	2025-09-15 14:27:05.575167	PRT	\N	139	f	43
República Centroafricana	CF	2025-09-15 14:27:05.575167	CAF	\N	141	f	151
República Checa	CZ	2025-09-15 14:27:05.575167	CZE	\N	142	f	35
República Dominicana	DO	2025-09-15 14:27:05.575167	DOM	\N	143	f	38
Ruanda	RW	2025-09-15 14:27:05.575167	RWA	\N	144	f	116
Canadá	CA	2025-09-15 14:27:05.575167	CAN	\N	55	t	26
Catar	QA	2025-09-15 14:27:05.575167	QAT	\N	56	t	112
Chile	CL	2025-09-15 14:27:05.575167	CHL	\N	57	t	29
China	CN	2025-09-15 14:27:05.575167	CHN	\N	58	t	30
Colombia	CO	2025-09-15 14:27:05.575167	COL	\N	60	t	31
Finlandia	FI	2025-09-15 14:27:05.575167	FIN	\N	63	t	43
Francia	FR	2025-09-15 14:27:05.575167	FRA	\N	65	t	43
México	MX	2025-09-15 14:27:05.575167	MEX	\N	115	t	95
Nueva Zelanda	NZ	2025-09-15 14:27:05.575167	NZL	\N	129	t	103
Paraguay	PY	2025-09-15 14:27:05.575167	PRY	\N	136	t	111
Polonia	PL	2025-09-15 14:27:05.575167	POL	\N	138	t	110
Reino Unido	GB	2025-09-15 14:27:05.575167	GBR	\N	140	t	47
Palaos	PW	2025-09-15 14:27:05.575167	PLW	\N	133	f	\N
Somalia	SO	2025-09-15 14:27:05.575167	SOM	\N	159	f	\N
Ucrania	UA	2025-09-15 14:27:05.575167	UKR	\N	178	f	\N
Congo (Rep. Dem.)	CD	2025-09-15 14:27:05.575167	COD	\N	1	f	27
Costa de Marfil	CI	2025-09-15 14:27:05.575167	CIV	\N	5	f	153
Croacia	HR	2025-09-15 14:27:05.575167	HRV	\N	6	f	43
Cuba	CU	2025-09-15 14:27:05.575167	CUB	\N	7	f	33
Dominica	DM	2025-09-15 14:27:05.575167	DMA	\N	9	f	152
Afganistán	AF	2025-09-15 14:27:05.575167	AFG	\N	11	f	2
Albania	AL	2025-09-15 14:27:05.575167	ALB	\N	12	f	3
Andorra	AD	2025-09-15 14:27:05.575167	AND	\N	14	f	43
Angola	AO	2025-09-15 14:27:05.575167	AGO	\N	15	f	6
Antigua y Barbuda	AG	2025-09-15 14:27:05.575167	ATG	\N	16	f	152
Arabia Saudita	SA	2025-09-15 14:27:05.575167	SAU	\N	17	f	117
Argelia	DZ	2025-09-15 14:27:05.575167	DZA	\N	18	f	39
Armenia	AM	2025-09-15 14:27:05.575167	ARM	\N	20	f	4
Eritrea	ER	2025-09-15 14:27:05.575167	ERI	\N	25	f	41
Eslovaquia	SK	2025-09-15 14:27:05.575167	SVK	\N	26	f	43
Eslovenia	SI	2025-09-15 14:27:05.575167	SVN	\N	27	f	43
Estonia	EE	2025-09-15 14:27:05.575167	EST	\N	30	f	43
Etiopía	ET	2025-09-15 14:27:05.575167	ETH	\N	31	f	42
Filipinas	PH	2025-09-15 14:27:05.575167	PHL	\N	32	f	108
Azerbaiyán	AZ	2025-09-15 14:27:05.575167	AZE	\N	34	f	10
Bahamas	BS	2025-09-15 14:27:05.575167	BHS	\N	35	f	21
Bangladés	BD	2025-09-15 14:27:05.575167	BGD	\N	36	f	13
Barbados	BB	2025-09-15 14:27:05.575167	BRB	\N	37	f	12
Baréin	BH	2025-09-15 14:27:05.575167	BHR	\N	38	f	15
Bélgica	BE	2025-09-15 14:27:05.575167	BEL	\N	39	f	43
Belice	BZ	2025-09-15 14:27:05.575167	BLZ	\N	40	f	25
Benín	BJ	2025-09-15 14:27:05.575167	BEN	\N	41	f	153
Botsuana	BW	2025-09-15 14:27:05.575167	BWA	\N	45	f	23
Brunéi	BN	2025-09-15 14:27:05.575167	BRN	\N	47	f	18
Rumanía	RO	2025-09-15 14:27:05.575167	ROU	\N	145	f	113
Samoa	WS	2025-09-15 14:27:05.575167	WSM	\N	147	f	150
San Cristóbal y Nieves	KN	2025-09-15 14:27:05.575167	KNA	\N	148	f	152
San Marino	SM	2025-09-15 14:27:05.575167	SMR	\N	149	f	43
San Vicente y las Granadinas	VC	2025-09-15 14:27:05.575167	VCT	\N	150	f	152
Santa Lucía	LC	2025-09-15 14:27:05.575167	LCA	\N	151	f	152
Santo Tomé y Príncipe	ST	2025-09-15 14:27:05.575167	STP	\N	152	f	128
Senegal	SN	2025-09-15 14:27:05.575167	SEN	\N	153	f	153
Serbia	RS	2025-09-15 14:27:05.575167	SRB	\N	154	f	114
Seychelles	SC	2025-09-15 14:27:05.575167	SYC	\N	155	f	119
Sierra Leona	SL	2025-09-15 14:27:05.575167	SLE	\N	156	f	124
Corea del Sur	KR	2025-09-15 14:27:05.575167	KOR	\N	2	t	74
Costa Rica	CR	2025-09-15 14:27:05.575167	CRI	\N	4	t	32
Dinamarca	DK	2025-09-15 14:27:05.575167	DNK	\N	8	t	37
Ecuador	EC	2025-09-15 14:27:05.575167	ECU	\N	10	t	143
Alemania	DE	2025-09-15 14:27:05.575167	DEU	\N	13	t	43
Argentina	AR	2025-09-15 14:27:05.575167	ARG	\N	19	t	7
Australia	AU	2025-09-15 14:27:05.575167	AUS	\N	21	t	8
Egipto	EG	2025-09-15 14:27:05.575167	EGY	\N	22	t	40
El Salvador	SV	2025-09-15 14:27:05.575167	SLV	\N	23	t	143
Emiratos Árabes Unidos	AE	2025-09-15 14:27:05.575167	ARE	\N	24	t	1
España	ES	2025-09-15 14:27:05.575167	ESP	\N	28	t	43
Austria	AT	2025-09-15 14:27:05.575167	AUT	\N	33	t	43
Bolivia	BO	2025-09-15 14:27:05.575167	BOL	\N	43	t	19
Brasil	BR	2025-09-15 14:27:05.575167	BRA	\N	46	t	20
India	IN	2025-09-15 14:27:05.575167	IND	\N	80	t	62
Israel	IL	2025-09-15 14:27:05.575167	ISR	\N	86	t	61
Italia	IT	2025-09-15 14:27:05.575167	ITA	\N	87	t	43
Japón	JP	2025-09-15 14:27:05.575167	JPN	\N	89	t	68
Rusia	RU	2025-09-15 14:27:05.575167	RUS	\N	146	t	\N
Singapur	SG	2025-09-15 14:27:05.575167	SGP	\N	157	f	122
Siria	SY	2025-09-15 14:27:05.575167	SYR	\N	158	f	129
Sri Lanka	LK	2025-09-15 14:27:05.575167	LKA	\N	160	f	80
Sudán	SD	2025-09-15 14:27:05.575167	SDN	\N	162	f	120
Sudán del Sur	SS	2025-09-15 14:27:05.575167	SSD	\N	163	f	127
Suecia	SE	2025-09-15 14:27:05.575167	SWE	\N	164	f	121
Surinam	SR	2025-09-15 14:27:05.575167	SUR	\N	166	f	126
Tailandia	TH	2025-09-15 14:27:05.575167	THA	\N	167	f	131
Tanzania	TZ	2025-09-15 14:27:05.575167	TZA	\N	168	f	140
Tayikistán	TJ	2025-09-15 14:27:05.575167	TJK	\N	169	f	132
Timor Oriental	TL	2025-09-15 14:27:05.575167	TLS	\N	170	f	143
Togo	TG	2025-09-15 14:27:05.575167	TGO	\N	171	f	153
Tonga	TO	2025-09-15 14:27:05.575167	TON	\N	172	f	135
Trinidad y Tobago	TT	2025-09-15 14:27:05.575167	TTO	\N	173	f	137
Túnez	TN	2025-09-15 14:27:05.575167	TUN	\N	174	f	134
Turkmenistán	TM	2025-09-15 14:27:05.575167	TKM	\N	175	f	133
Tuvalu	TV	2025-09-15 14:27:05.575167	TUV	\N	177	f	8
Uganda	UG	2025-09-15 14:27:05.575167	UGA	\N	179	f	142
Uruguay	UY	2025-09-15 14:27:05.575167	URY	\N	180	f	144
Uzbekistán	UZ	2025-09-15 14:27:05.575167	UZB	\N	181	f	145
Vanuatu	VU	2025-09-15 14:27:05.575167	VUT	\N	182	f	149
Venezuela	VE	2025-09-15 14:27:05.575167	VEN	\N	183	f	147
Vietnam	VN	2025-09-15 14:27:05.575167	VNM	\N	184	f	148
Yemen	YE	2025-09-15 14:27:05.575167	YEM	\N	185	f	155
Yibuti	DJ	2025-09-15 14:27:05.575167	DJI	\N	186	f	36
Zambia	ZM	2025-09-15 14:27:05.575167	ZMB	\N	187	f	157
Zimbabue	ZW	2025-09-15 14:27:05.575167	ZWE	\N	188	f	158
Estados Unidos	US	2025-09-15 14:27:05.575167	USA	\N	29	t	143
Perú	PE	2025-09-15 14:27:05.575167	PER	\N	137	t	106
Sudáfrica	ZA	2025-09-15 14:27:05.575167	ZAF	\N	161	t	156
Suiza	CH	2025-09-15 14:27:05.575167	CHE	\N	165	t	28
Turquía	TR	2025-09-15 14:27:05.575167	TUR	\N	176	t	136
\.


--
-- Data for Name: trfclasificacionfiscal; Type: TABLE DATA; Schema: contabilidad; Owner: postgres
--

COPY contabilidad.trfclasificacionfiscal (coclasificacionfiscal, copais, nocodigo, noclasificacionfiscal, fecre, flestreg) FROM stdin;
\.


--
-- Data for Name: trfcomprobantepago; Type: TABLE DATA; Schema: contabilidad; Owner: postgres
--

COPY contabilidad.trfcomprobantepago (cocomprobantepago, copais, nocodigo, nocomprobantepago, nocomprobantepagosigla, flestreg, fecre) FROM stdin;
2	137	00	Otros (especificar)		t	2025-09-19 10:44:07.149389
3	137	01	Factura	FA	t	2025-09-19 10:44:07.149389
4	137	02	Recibo por Honorarios	RH	t	2025-09-19 10:44:07.149389
5	137	03	Boleta de Venta	BO	t	2025-09-19 10:44:07.149389
6	137	04	Liquidación de compra		t	2025-09-19 10:44:07.149389
7	137	05	Boleto de compañía de aviación comercial por el servicio de transporte aéreo de pasajeros		t	2025-09-19 10:44:07.149389
8	137	06	Carta de porte aéreo por el servicio de transporte de carga aérea		t	2025-09-19 10:44:07.149389
9	137	07	Nota de crédito	NC	t	2025-09-19 10:44:07.149389
10	137	08	Nota de débito	ND	t	2025-09-19 10:44:07.149389
11	137	09	Guía de remisión - Remitente		t	2025-09-19 10:44:07.149389
12	137	10	Recibo por Arrendamiento		t	2025-09-19 10:44:07.149389
13	137	12	Ticket o cinta emitido por máquina registradora		t	2025-09-19 10:44:07.149389
14	137	15	Boleto emitido por las empresas de transporte público urbano de pasajeros		t	2025-09-19 10:44:07.149389
15	137	16	Boleto de viaje de las empresas de transporte público interprov de pasajeros dentro del país		t	2025-09-19 10:44:07.149389
16	137	17	Documento emitido por la Iglesia Católica por el arrendamiento de bienes inmuebles		t	2025-09-19 10:44:07.149389
17	137	19	Boleto o entrada por atracciones y espectáculos públicos		t	2025-09-19 10:44:07.149389
18	137	20	Comprobante de Retención		t	2025-09-19 10:44:07.149389
19	137	21	Conocimiento de embarque por el servicio de transporte de carga marítima		t	2025-09-19 10:44:07.149389
20	137	22	Comprobante por Operaciones No Habituales		t	2025-09-19 10:44:07.149389
21	137	24	Certificado de pago de regalías emitidas por PERUPETRO S.A		t	2025-09-19 10:44:07.149389
22	137	27	Seguro Complementario de Trabajo de Riesgo		t	2025-09-19 10:44:07.149389
23	137	28	Tarifa Unificada de Uso de Aeropuerto		t	2025-09-19 10:44:07.149389
24	137	31	Guía de Remisión - Transportista		t	2025-09-19 10:44:07.149389
25	137	34	Documento del Operador		t	2025-09-19 10:44:07.149389
26	137	35	Documento del Partícipe		t	2025-09-19 10:44:07.149389
27	137	36	Recibo de Distribución de Gas Natural		t	2025-09-19 10:44:07.149389
28	137	50	Declaración Única de Aduanas - Importación definitiva                 		t	2025-09-19 10:44:07.149389
29	137	52	Despacho Simplificado - Importación Simplificada                        		t	2025-09-19 10:44:07.149389
30	137	53	Declaración de Mensajería o Courier                                         		t	2025-09-19 10:44:07.149389
31	137	54	Liquidación de Cobranza                                                     		t	2025-09-19 10:44:07.149389
32	137	87	Nota de Crédito Especial		t	2025-09-19 10:44:07.149389
33	137	88	Nota de Débito Especial		t	2025-09-19 10:44:07.149389
34	137	91	Comprobante de No Domiciliado                                                 		t	2025-09-19 10:44:07.149389
35	137	96	Exceso de crédito fiscal por retiro de bienes                           		t	2025-09-19 10:44:07.149389
36	137	97	Nota de Crédito - No Domiciliado		t	2025-09-19 10:44:07.149389
37	137	98	Nota de Débito - No Domiciliado		t	2025-09-19 10:44:07.149389
38	137	99	Otros -Consolidado de Boletas de Venta		t	2025-09-19 10:44:07.149389
\.


--
-- Data for Name: trfimpuesto; Type: TABLE DATA; Schema: contabilidad; Owner: postgres
--

COPY contabilidad.trfimpuesto (coimpuesto, nocodigo, noimpuesto, notipo, pqtasa, flestreg, copais, fecre) FROM stdin;
1	1000	IGV Impuesto General a las Ventas	IGV	18.0000	t	137	2025-09-19 15:04:36.35018
2	2000	ISC Impuesto Selectivo al Consumo	ISC	\N	t	137	2025-09-19 15:04:36.35018
3	7152	ICBPER Impuesto al Consumo de Bolsas de Plástico	ICBPER	\N	t	137	2025-09-19 15:04:36.35018
4	9995	Exportación	IGV	0.0000	t	137	2025-09-19 15:04:36.35018
5	9996	Gratuito	IGV	0.0000	t	137	2025-09-19 15:04:36.35018
6	9997	Exonerado	IGV	0.0000	t	137	2025-09-19 15:04:36.35018
7	9998	Inafecto	IGV	0.0000	t	137	2025-09-19 15:04:36.35018
8	9999	Otros tributos	OTROS	\N	t	137	2025-09-19 15:04:36.35018
\.


--
-- Data for Name: trfunidadmedida; Type: TABLE DATA; Schema: maestro; Owner: postgres
--

COPY maestro.trfunidadmedida (counidadmedida, copais, nocodigoiso, nounidadmedida, nosimbolo, flestreg) FROM stdin;
1	137	NIU	Unidad (item)	u	t
2	137	KGM	Kilogramo	kg	t
3	137	GRM	Gramo	g	t
4	137	LTR	Litro	L	t
5	137	MLT	Mililitro	ml	t
6	137	MTR	Metro	m	t
7	137	MTK	Metro cuadrado	m²	t
8	137	MTQ	Metro cúbico	m³	t
9	137	HUR	Hora	h	t
10	137	DIA	Día	d	t
11	137	WEE	Semana	sem	t
12	137	MON	Mes	mes	t
13	137	ANN	Año	a	t
14	137	PR	Par	par	t
15	137	SET	Set	set	t
16	137	PK	Paquete	paq	t
17	137	CT	Caja	caj	t
18	137	BG	Bolsa	bolsa	t
19	137	BO	Botella	bot	t
20	137	TN	Tonelada	tn	t
23	137	GLL	Galón (US líquido)	gal	t
24	137	GLN	Galón (US seco)	gal seco	t
\.


--
-- Data for Name: trfimpuestohijo; Type: TABLE DATA; Schema: contabilidad; Owner: postgres
--

COPY contabilidad.trfimpuestohijo (coimpuestohijo, coimpuesto, nocodigo, noimpuestohijo, nometodo, pqtasa, ssmonto, flestreg, counidadmedida, copais) FROM stdin;
1	2	A	ISC Bebidas alcohólicas (ad-valorem)	AD-VALOREM	40.0000	\N	t	\N	137
2	2	B	ISC Cerveza (ad-valorem + monto fijo por litro)	MIXTO	30.0000	1.2500	t	4	137
3	2	C	ISC Tabaco (monto fijo por unidad)	ESPECIFICO	\N	0.3500	t	1	137
4	2	D	ISC Combustibles (monto fijo por galón)	ESPECIFICO	\N	1.5000	t	23	137
\.


--
-- Data for Name: trfmediopago; Type: TABLE DATA; Schema: contabilidad; Owner: postgres
--

COPY contabilidad.trfmediopago (comediopago, copais, nocodigo, nomediopago, flestreg) FROM stdin;
1	137	001	DEPÓSITO EN CUENTA	t
2	137	002	GIRO	t
3	137	003	TRANSFERENCIA DE FONDOS	t
4	137	004	ORDEN DE PAGO	t
5	137	005	TARJETA DE DÉBITO	t
6	137	006	TARJETA DE CRÉDITO EMITIDA EN EL PAÍS POR UNA EMPRESA DEL SISTEMA FINANCIERO	t
7	137	007	CHEQUES CON LA CLÁUSULA DE "NO NEGOCIABLE", "INTRANSFERIBLES", "NO A LA ORDEN" U OTRA EQUIVALENTE	t
8	137	008	EFECTIVO, POR OPERACIONES EN LAS QUE NO EXISTE OBLIGACIÓN DE UTILIZAR MEDIO DE PAGO	t
9	137	009	EFECTIVO, EN LOS DEMÁS CASOS	t
10	137	010	MEDIOS DE PAGO USADOS EN COMERCIO EXTERIOR	t
11	137	011	DOCUMENTOS EMITIDOS POR LAS EDPYMES Y LAS COOPERATIVAS DE AHORRO Y CRÉDITO NO AUTORIZADAS	t
12	137	012	TARJETA DE CRÉDITO EMITIDA EN EL PAÍS O EN EL EXTERIOR POR UNA EMPRESA ..	t
13	137	013	TARJETAS DE CRÉDITO EMITIDAS EN EL EXTERIOR POR EMPRESAS BANCARIAS ..	t
14	137	101	TRANSFERENCIAS - COMERCIO EXTERIOR	t
15	137	102	CHEQUES BANCARIOS - COMERCIO EXTERIOR	t
16	137	103	ORDEN DE PAGO SIMPLE - COMERCIO EXTERIOR	t
17	137	104	ORDEN DE PAGO DOCUMENTARIO - COMERCIO EXTERIOR	t
18	137	105	REMESA SIMPLE - COMERCIO EXTERIOR	t
19	137	106	REMESA DOCUMENTARIA - COMERCIO EXTERIOR	t
20	137	107	CARTA DE CRÉDITO SIMPLE - COMERCIO EXTERIOR	t
21	137	108	CARTA DE CRÉDITO DOCUMENTARIO - COMERCIO EXTERIOR	t
22	137	999	OTROS MEDIOS DE PAGO	t
\.


--
-- Data for Name: trfmotivonotacredito; Type: TABLE DATA; Schema: contabilidad; Owner: postgres
--

COPY contabilidad.trfmotivonotacredito (comotivonotacredito, copais, nocodigo, nomotivonotacredito, flestreg) FROM stdin;
1	137	01	Anulación de la operación	t
2	137	02	Anulación por error en el RUC	t
3	137	03	Corrección por error en la descripción	t
4	137	04	Descuento global	t
5	137	05	Descuento por ítem	t
6	137	06	Devolución total	t
7	137	07	Devolución por ítem	t
8	137	08	Bonificación	t
9	137	09	Disminución en el valor	t
\.


--
-- Data for Name: tblbandejaentrada; Type: TABLE DATA; Schema: empresa; Owner: postgres
--

COPY empresa.tblbandejaentrada (coempresa, cobandejaentrada, nopersona, noemail, notelefono, noasunto, coservicio, nomensaje, coetiqueta, cousucre, fecre, cousumod, femod, flfavorito, flestreg) FROM stdin;
2	1	Jonatan A	jabreguch@gmai.com	99988571565	Consulta externa	24	Por favor neceisto aur,ds	\N	-100	2020-06-09 14:14:54.67	\N	\N	f	t
2	2	Perez	joff@com.pe	98546464654	Consulta externa	28	Este subn m,enmskasa	\N	-100	2020-06-09 14:15:20.517	\N	\N	f	t
2	3	2332	233@g.com	3223	Consulta externa	19	weqqweqw	\N	-100	2020-06-11 16:49:18.203	\N	\N	f	t
2	4	32	dd@f.cpm	23	Consulta externa	29	qwewq	\N	-100	2020-06-11 16:56:41.683	\N	\N	f	t
2	5	3232	ed@dd.cpo	233232	Consulta externa	21	32332	\N	-100	2020-06-11 16:57:01.69	\N	\N	f	t
2	6	323	dd@dd.com	2323	Consulta externa	26	3weqweqweq	\N	-100	2020-06-11 16:58:31.94	\N	\N	f	t
2	7	asdasdas	sdas@dd.com	9998567466	asdad ad asdsad asd asd asd asd a aasd 	\N		\N	-100	2020-10-23 22:58:24.967	\N	\N	f	t
2	8	ewqrew	erew@sds.com	865465465	Consulta externa	\N		\N	-100	2020-10-23 23:14:37.813	\N	\N	f	t
2	9	werwerwe	wer@dd.com	654564465	Consulta externa	\N		\N	-100	2020-10-23 23:16:10.29	\N	\N	f	t
2	10	werwe	wre@ff.vcp	34534543543543	Consulta externa	\N		\N	-100	2020-10-23 23:17:02.557	\N	\N	f	t
2	11	werwer	wre@ff.com	4535345435	Consulta externa	\N		\N	-100	2020-10-23 23:17:59.687	\N	\N	f	t
2	12	weq	eqweqwe@eew.com	333223	Consulta externa	\N	qeqweqw q wq qw qw qwe qwq qwe qw e	\N	-100	2020-10-24 00:29:15.113	\N	\N	f	t
2	13	rwefwe	sdaad@ff.com	32423432432	Consulta externa	\N	324234234324432	\N	-100	2020-10-24 23:10:17	\N	\N	f	t
3	14	Jonatán 	jabreguch@gmail.com	999885710	Consulta externa	\N	Hola	\N	-100	2022-03-22 01:41:15.907	\N	\N	f	t
3	15	Kevin	kevin@gmail.com	999865482	Consulta externa	\N	Mensaje	\N	-100	2022-03-23 03:07:41.287	\N	\N	f	t
7	16	ssss	sss@sss	ssss	Consulta externa	\N	ssssssss	\N	-100	2022-04-06 02:38:25.757	\N	\N	f	t
7	17	ssss	sss@sss	sssss	Consulta externa	\N	ffdgfdgfdgfdgfd	\N	-100	2022-04-06 02:40:31.43	\N	\N	f	t
\.


--
-- Data for Name: tblblog; Type: TABLE DATA; Schema: empresa; Owner: postgres
--

COPY empresa.tblblog (coempresa, coblog, coservicio, cosubservicio, notitulo, txblog, noideacentral, feblog, coautor, cousucre, fecre, cousumod, femod, flestreg) FROM stdin;
1	14	1	\N	Immediately-Invoked Function Expression (IIFE)	In case you hadn’t noticed, I’m a bit of a stickler for terminology. So, after hearing the popular, yet misleading, JavaScript term “self-executing anonymous function” (or self-invoked anonymous function) one too many times, I’ve finally decided to organize my thoughts into an article.\n\nIn addition to providing some very thorough information about how this pattern actually works, I’ve actually made a recommendation on what we should call it, moving forward. Also, If you want to skip ahead, you can just check out some actual Immediately-Invoked Function Expressions, but I recommend reading the entire article.\n\nPlease understand that this article isn’t intended to be an “I’m right, you’re wrong” kind of thing. I’m genuinely interested in helping people understand potentially complex concepts, and feel that using consistent and accurate terminology is one of the easiest things that people can do to facilitate understanding.	\N	20101115	690	22	2021-09-03 21:52:36.537	\N	\N	t
1	13	\N	2	XMLHttpRequest	XMLHttpRequest is a built-in browser object that allows to make HTTP requests in JavaScript.\n\nDespite of having the word “XML” in its name, it can operate on any data, not only in XML format. We can upload/download files, track progress and much more.\n\nRight now, there’s another, more modern method fetch, that somewhat deprecates XMLHttpRequest.\n\nIn modern web-development XMLHttpRequest is used for three reasons:\n\nHistorical reasons: we need to support existing scripts with XMLHttpRequest.\nWe need to support old browsers, and don’t want polyfills (e.g. to keep scripts tiny).\nWe need something that fetch can’t do yet, e.g. to track upload progress.\nDoes that sound familiar? If yes, then all right, go on with XMLHttpRequest. Otherwise, please head on to Fetch.	\N	20210901	690	22	2021-09-01 16:29:46.62	\N	\N	t
1	12	\N	1	Do GET, POST, PUT, --DELETE--in ASP.NET MVC with Jquery Ajax	\N	\N	20210924	22	22	2021-09-01 16:29:05.183	\N	\N	t
1	11	\N	6	dqwewqe	\N	\N	20210716	241	22	2021-07-12 14:29:11.837	\N	\N	t
1	10	\N	4	zdcfdsacsadsad	\N	\N	20210722	10	22	2021-07-05 17:20:50.597	\N	\N	t
1	9	\N	5	ewew	\N	\N	20210714	10	22	2021-07-05 12:45:33.82	\N	\N	t
4	7	\N	3	Crisis ética y disciplina escolar	La relación que tenemos con las normas se forma en diversos ámbitos de la vida, siendo la escuela uno crucial. Durante muchos años, las personas viven en un ambiente escolar en el que se aprenden modos de sentir y actuar frente a las normas y los valores. Estas vivencias suelen formar parte de un currículo oculto, es decir, de un conjunto de mensajes y aprendizajes no reconocidos oficialmente, que se construyen principalmente a través de las interacciones dentro de la escuela[1]. Atendiendo al currículo oculto, debemos concebir “… la escuela como una pequeña sociedad con sus propias reglas, obligaciones y su sentido de la cohesión social”[2]. Las vivencias que se tienen en esa “pequeña sociedad” dejan aprendizajes, que luego influirán en nuestros modos de relacionarnos con las normas a nivel estatal como ciudadanos[3].\n\nAsí, por ejemplo, si el docente no actúa conforme a las normas y valores que sí exige a sus estudiantes, se aprende que no hay igualdad ante la ley: quien tiene poder puede incumplir. Si el docente trata mal, y los estudiantes no pueden hacer nada frente a eso, se aprende que quien tiene poder no puede ser cuestionado y que, frente a lo incorrecto, uno debe callar. Si los estudiantes no participan en la creación de las normas y no les encuentran un sentido asociado a valores, se aprende que las normas se cumplen solo por miedo a la sanción y que, por tanto, si uno puede “hacerla caleta”, no hay problema. Si los docentes, autoridades y estudiantes obtienen beneficios cuando están cerca de quien tiene poder, se aprende que más importan los contactos que el mérito y lo justo.\n\nNo será posible mejorar el nivel ético de nuestra sociedad si no atendemos a cómo se forma el vínculo con la autoridad y las normas en las escuelas de nuestro país. La disciplina escolar debe ser un foco de propuestas e investigaciones, si es que queremos una maduración moral a largo plazo.	Suena bien, pero en nuestras experiencias solemos aprender, también, que una cosa es la palabra ley y otra la realidad. De algún modo, existe también una normatividad oculta, que enseña cosas muy dist	20201031	222	221	2020-10-25 22:49:59.587	\N	\N	t
4	6	\N	2	Críticas al Proyecto de Ley de la Abogacía Peruana	El dictamen emitido por la Comisión de Justicia y Derechos Humanos del Congreso, relativo al Proyecto de Ley de la Abogacía Peruana[1], tiene muchos problemas. En concreto no ha incluido puntos centrales (contemplados en el “Proyecto de Ley para incentivar la probidad en el ejercicio de la abogacía”, que presentó el Poder Ejecutivo, y que fue rechazado por la Comisión) e incluye disposiciones que suponen retrocesos y muy probablemente generará confusiones en el sistema de control ético de la abogacía. A lo anterior, habría que agregar que el Proyecto carece de la legitimidad necesaria, debido a que no se ha escuchado al sector académico. Por ello, considero que sería un error aprobar el dictamen en el Pleno del Congreso.\n\nEn concreto, los puntos que me parecen más cuestionables y preocupantes son los siguientes:	Llama poderosamente la atención que los colegios de abogados hayan buscado incluir esta disposición, abiertamente inconstitucional, máxime cuando el 2 de mayo del año en curso, el Colegio de Abogados 	20201022	222	221	2020-10-25 22:48:31.5	\N	\N	t
4	5	\N	1	El caso Marbury versus Madison (1803)	El caso Marbury vs. Madison, no cabe duda, constituye uno de los principales hitos (e íconos) del constitucionalismo. Ello está plenamente justificado, pues es la primera ocasión en la que, de manera clara, una corte de vértice, afirmando la supremacía de la Constitución frente a la ley, determina la inaplicación de esta última por ser inconstitucional.\n\nAhora bien, contra lo que podría pensarse desde la perspectiva actual –es decir, desde el “constitucionalismo de los derechos”– no se trata de un caso en el que una norma legal fue inaplicada por ser lesiva de derechos constitucionales. En Marbury vs. Madison se resolvió más bien un writ of mandamus, es decir, algo equivalente a nuestro proceso de cumplimiento.\n\nAdemás de la ya indicada, el caso presenta muchas otras singularidades y es importante (e incluso actual) por varias razones. Lo primero que podríamos tener en cuenta al respecto es el contexto en que surgió el caso.\n\nDe inicio, conviene mencionar es que el ponente en el caso Marbury (para abreviar) fue John Marshall, tal vez el más importante juez en la historia de la Corte Suprema de Estados Unidos. Marshall asumió la Presidencia de la Suprema Corte en 1801, en un contexto en que el Poder Judicial se encontraba devaluado y carecía de protagonismo. Durante un tiempo, además Presidente de la Corte, Marshall fue a la vez Secretario de Estado del presidente John Adams, del partido federal.\n\nJusto antes de que Adams deje la presidencia, para ser relevado por Thomas Jefferson (del partido republicano), el gobierno del partido federal designó a varios jueces de paz. Este proceso de designación involucraba el nombramiento por parte del Presidente con la posterior ratificación del Congreso; tras ello, correspondía, como acto de perfeccionamiento formal, que el documento de nombramiento sea sellado y remitido por correo por el Secretario de Estado (cargo que, hasta el momento de los mencionados nombramientos, tenía Marshall).\n\nLo cierto es que William Marbury fue nombrado juez de paz casi el último día de gobierno del partido federal y a John Marshall no le alcanzó el tiempo para sellar o enviar todos los nombramientos que acaban de hacerse, entre ellos el de Marbury.	Ahora bien, contra lo que podría pensarse desde la perspectiva actual –es decir, desde el “constitucionalismo de los derechos”– no se trata de un caso en el que una norma legal fue inaplicada por ser 	20201025	222	221	2020-10-25 22:47:26.64	\N	\N	t
4	8	\N	4	Avivar la justicia en las facultades de derecho	La justicia puede ser comprendida y sentida como una fuerza anímica que, como el amor o el miedo, motiva nuestros pensamientos y acciones. En ese sentido, lo más importante que tenemos que hacer, si queremos transformar el sistema, es avivar la justicia en el corazón de quienes lo habitan.\n\nEsto debe ser hecho, principalmente, en donde se forma el “ser” profesional de los abogados: las facultades de derecho. ¿Estamos avivando la justicia en el corazón de quienes serán en el futuro jueces, fiscales, funcionarios, asesores, litigantes, árbitros?\n\nA continuación, planteo cuatro aprendizajes que pueden darse en las facultades de derecho, y que forman en lo opuesto a la justicia. Lo hago con miras a que quienes las conforman se pregunten, con sinceridad, cómo están formando el ánimo de quienes en el futuro serán profesionales del Derecho. Por supuesto, son reflexiones para quienes están interesados e interesadas en transformar la realidad actual desde las aulas, y no para quienes abierta y dolosamente destruyen la justicia en nuestro país. Con estos últimos, no toca reflexionar sino luchar.	Se aprende también que lo que no se puede probar no es verdad, lo que, proyectado al ámbito profesional, puede conducir a defender cosas que uno sabe que no son ciertas, pero que la parte contraria no	20200928	222	221	2020-10-25 22:50:40.85	\N	\N	t
1	4	\N	7	tu mamam	\N	sdasdasdas	20201107	10	22	2020-10-19 22:06:23.193	\N	\N	t
1	3	\N	8	aaa	aaa	aaaaa	20201019	237	22	2020-10-19 22:05:55.137	\N	\N	t
2	2	\N	22	Derecho de familia	Asesoría expeditiva enfocada a obtener soluciones sin judicializar los casos y orientada a garantizar el bienestar de nuestros clientes, de sus seres queridos y a proteger su patrimonio. \n\nSi es inevitable judicializarlos, la actuación tiene que destinarse a obtener medidas cautelares sin dilación, a fin de no alterar la economía de las partes.	Privilegiamos una asesoría familiar que impida abusos de cualquiera de las partes y nos concentramos en la protección de la parte débil y de los hijos	20200514	126	126	2020-05-22 21:25:25.977	\N	\N	t
2	1	\N	25	Interrdicto	on este artículo vamos a dar algunas nociones básicas sobre el juicio de interdicto de retener o de recobrar la posesión. El llamado juicio de interdicto de retener o de recobrar la posesión es un procedimiento sumario (teóricamente rápido y sencillo), destinado a proteger la posesión como hecho o el hecho mismo de la posesión, contra las perturbaciones que la dañan.\n\nEl interdicto de retener la posesión se dará cuando el poseedor es inquietado o perturbado por otra persona en la posesión, sin que se la haya despojado todavía.\nEl interdicto de recuperar la posesión se dará cuando haya sido ya despojado de dicha posesión o tenencia.	El interdicto de retener o de recobrar la posesión es un procedimiento sumario destinado a proteger la posesión de cualquier bien contra perturbaciones.	21211212	192	126	2020-05-09 22:12:39.72	\N	\N	t
\.


--
-- Data for Name: tblblogmensaje; Type: TABLE DATA; Schema: empresa; Owner: postgres
--

COPY empresa.tblblogmensaje (coempresa, coblog, coblogmensaje, nopersona, nomensaje, noemail, cousucre, fecre) FROM stdin;
2	1	1	weqw	wewqe	j@jnco.com	-100	2020-05-10 02:41:53.643
2	1	2	Medalid	Felicitaciones	meddolci@gmail.com	-100	2020-06-08 01:48:32.647
2	1	3	Medalid	Felicitaciones	meddolci@gmail.com	-100	2020-06-08 01:48:32.8
1	13	4	sdsa	asdasdsa	ssad@dd.pe	-100	2022-04-11 01:59:36.2
\.


--
-- Data for Name: tblcliente; Type: TABLE DATA; Schema: empresa; Owner: postgres
--

COPY empresa.tblcliente (coempresa, cocliente, nocliente, nocargo, txopinion, cousucre, fecre, flestreg, flopinion) FROM stdin;
2	1	Jonatan Abregu	Gerente General	Esta es mi opinión.	126	2020-05-07 20:30:46.267	t	t
2	2	Carlos Cardenas de la Cruz	Jefe	Esta es mi opinión	126	2020-05-07 20:31:20.007	t	t
2	3	Alicorp	.		126	2020-05-07 20:43:08.69	t	t
2	4	Carsa			126	2020-05-07 20:43:34.857	t	t
1	5	IL POSTINO	Doménico Gallotta	Sistema de Restaurante	22	2020-10-19 23:58:23.68	t	t
4	6	Empresa X1	Gerente General	Yo opino, bla, bla, bla	221	2020-10-25 22:51:39.443	t	t
4	7	Empresa X2	Jefe del Area de XXXX	Yo opino, bla, bla, bla	221	2020-10-25 22:52:25.833	t	t
4	8	Empresa X3	Gerente General	Yo opino, bla, bla, bla	221	2020-10-25 22:53:00.167	t	t
1	9	NOVATERRA	Manuel Balcazar Olivos	Sistema de Gestión de Créditos	22	2021-07-13 18:05:32.5	t	t
1	10	GRUPO SERVIMEDIC	Rodrigo Zubiate	Sistema de Facturacion	22	2021-07-13 18:07:22.15	t	t
1	11	Martínez Ingeniería Geotécnica	José Martínez Del Rosario	Sistema de Puntos Sismicos	22	2021-07-13 18:08:05.427	t	t
1	12	Leva Traser	Kevin Leva Trujillo	Mantenimiento de Portal Web	22	2021-07-13 18:08:15.34	t	t
1	13	ewrf	werew	rwr	22	2021-07-13 18:14:09.127	t	t
1	14	ewr	qweq	wer	22	2021-07-22 17:38:26.68	t	t
1	15	33333	3333333	3333	22	2021-07-22 17:38:36.633	t	t
1	16	444444	44	444	22	2021-07-22 17:38:41.807	t	t
1	17	uuuuuuuuuuuuuuuuuuuu	uuuuuuuuuuuuuu	uuuuuuuuu	22	2021-09-01 16:12:47.24	t	t
1	18	ert	ert	ertre	22	2021-09-01 16:14:03.04	t	t
1	19	ertert	\N	ertertertre	22	2021-09-01 16:14:10.557	t	t
7	20	Pepe Lopez	Gerente	Es una buena empresa bla 	689	2022-04-01 19:41:12.13	t	t
7	21	Juan Rodriguez	Gerente	Servicio de calidad	689	2022-04-06 02:24:35.98	t	t
7	22	Paul Martinez	Operaciones	Buena	689	2022-04-06 02:26:43.243	t	t
\.


--
-- Data for Name: tblequipo; Type: TABLE DATA; Schema: empresa; Owner: postgres
--

COPY empresa.tblequipo (coempresa, coequipo, coprofesional, noextracto, cousucre, fecre, flestreg) FROM stdin;
3	1	644	Abogado en el ejercicio de la defensa libre, litigación, con 12 de años de experiencia en intervención en Procesos Judiciales, Civiles, Penales, Familia, entre otros.  Así mismo investigaciones a nivel Fiscal.\n\nMagister en Derecho Registral y Notarial.	644	2022-03-22 00:56:31.947	t
1	2	22	.	22	2022-09-30 10:55:25.373	t
1	3	928	.	22	2022-09-30 10:56:07.24	t
1	4	930	.	22	2022-09-30 11:02:35.547	t
\.


--
-- Data for Name: tblhorario; Type: TABLE DATA; Schema: empresa; Owner: postgres
--

COPY empresa.tblhorario (coempresa, cohorario, codia, hoinicio, hofinal, cousucre, fecre, flestreg) FROM stdin;
-1	1	1	21:02	23:32	22	2020-04-15 18:48:28.077	t
-1	2	4	21:02	21:22	22	2020-04-15 18:48:53.027	t
-1	3	3	03:04	03:04	22	2020-04-15 19:22:03.763	t
1	4	5	23:03	03:02	22	2020-04-15 19:39:44.76	t
1	5	3	03:23	23:23	22	2020-04-15 19:43:49.173	t
1	6	7	03:23	23:32	22	2020-04-15 19:48:39.62	t
1	7	2	\N	\N	22	2020-04-15 19:48:53.327	t
1	8	5	23:03	03:02	22	2020-04-15 21:02:52.07	t
1	9	1	21:02	23:23	22	2020-04-15 21:03:00.143	t
1	10	4	01:23	23:23	22	2020-04-15 21:03:07.583	t
1	11	4	21:21	21:02	22	2020-04-21 14:59:18.627	t
1	12	2	02:33	23:23	22	2020-04-21 21:41:24.68	t
2	13	1	08:00	18:00	126	2020-05-04 22:01:50.737	t
2	14	2	08:00	18:00	126	2020-05-04 22:09:57.81	t
2	15	3	08:00	18:00	126	2020-05-04 22:10:10.28	t
2	16	4	08:00	18:00	126	2020-05-04 22:10:19.67	t
2	17	5	08:00	18:00	126	2020-05-04 22:10:31.087	t
2	18	6	08:00	13:00	126	2020-05-04 22:21:29.283	t
4	19	1	08:00	17:00	221	2020-10-25 23:20:58.91	t
4	20	2	08:00	17:00	221	2020-10-25 23:21:08.69	t
4	21	3	08:00	17:00	221	2020-10-25 23:21:17.243	t
4	22	4	08:00	17:00	221	2020-10-25 23:21:30.887	t
4	23	5	08:00	17:00	221	2020-10-25 23:21:42.193	t
4	24	6	08:00	13:00	221	2020-10-25 23:21:53.357	t
\.


--
-- Data for Name: tblpregunta; Type: TABLE DATA; Schema: empresa; Owner: postgres
--

COPY empresa.tblpregunta (coempresa, copregunta, nuorden, nopregunta, norespuesta, cousucre, fecre, flestreg) FROM stdin;
1	1	1	¿Donde se encuentra mi información ?	Se encuentran en nuestros servidores (la nube) que cuentan con la seguridad necesaria para proteger su información y su integridad de ello.	22	2020-04-21 19:59:43.113	t
1	2	2	¿Como me contacto con ustedes?	Llamenos y haga las consultas necesarias en la sección contactos.	22	2020-04-21 20:04:03.61	t
1	3	3	POrre est ala enlejkwe	ekjdhnqwljednqwljdals alwdh odh a	22	2020-04-21 21:41:44.78	t
2	4	1	¿QUÉ ES LA CONCILIACIÓN?	Es un mecanismo alternativo de solución de conflictos, por el cual un conciliador les asiste en la búsqueda de una solución consensual a un conflicto: los acuerdos adoptados obedecen única y exclusivamente a la voluntad de las partes. La conciliación no es un acto jurisdiccional y es un procedimiento independiente a la conciliación que regula el Código Procesal Civil.	126	2020-05-04 22:13:48.537	t
2	5	2	¿QUIÉN ES EL CONCILIADOR?	Es la persona capacitada, acreditada y autorizada por el Ministerio de Justicia, para ejercer la función conciliadora. Entre sus funciones está promover la comunicación entre las partes, conducir el procedimiento conciliatorio con libertad de acción (siguiendo los principios de la conciliación) y proponer fórmulas conciliatorias no obligatorias. Para ejercer como conciliador, se requiere estar adscrito ante un Centro de Conciliación autorizado y tener vigente la habilitación en el Registro de Conciliadores en el MINJUS. Para conciliar en materia laboral o de familia el conciliador debe contar con la debida especialización, acreditación y autorización expedida por el MINJUS.	126	2020-05-04 22:17:50.08	t
2	6	3	¿QUÉ ES UN CENTRO DE CONCILIACIÓN?	Es una entidad que tiene por objeto ejercer la función conciliadora conforme a ley. Puede ser constituido por personas jurídicas de derecho público o privado sin fines de lucro, que tengan entre sus finalidades el ejercicio de la función conciliadora. En caso de ser un centro privado, su funcionamiento es autorizado por el MINJUS sólo en locales que reúnan las condiciones adecuadas para garantizar la calidad e idoneidad del servicio conciliatorio. Los servicios de un centro de conciliación serán pagados por quien solicita la conciliación, salvo pacto en contrario.	126	2020-05-04 22:18:05.517	t
2	7	4	¿QUÉ ES LA AUDIENCIA ÚNICA?	Es la reunión entre el conciliador y las partes (solicitante e invitado) para resolver una controversia sobre una materia conciliable. Se realizará en el local del centro de conciliación, tiene el carácter de única, pero puede hacerse en una o varias sesiones. El plazo podrá ser de hasta 30 días calendarios desde la fecha de la primera sesión. Sólo puede prorrogarse por acuerdo de las partes.	126	2020-05-04 22:18:22.277	t
2	8	5	¿QUÉ ES EL ACTA DE CONCILIACIÓN?	Es el documento que expresa la manifestación de voluntad de las partes en la conciliación extrajudicial. Debe contener necesariamente una de las formas de conclusión del procedimiento conciliatorio señalado en el artículo 15° de la ley de Conciliación Extrajudicial. Lo que debe contener el acta se señala en el artículo 16° de la ley.	126	2020-05-04 22:18:34.24	t
2	9	6	¿CUÁLES SON LAS MATERIAS CONCILIABLES?	Son todas las pretensiones determinadas o determinables que versen sobre derechos disponibles de las partes. En materia de familia, son conciliables las pretensiones que versen sobre pensión de alimentos, régimen de visitas, tenencia, y otras que se deriven de la relación familiar sobre las partes tengan libre disposición. En materia contractual, se aplicará la ley de contrataciones Del Estado. En materia laboral, se debe respetar el carácter irrenunciable de los derechos del trabajador.	126	2020-05-04 22:18:51.927	t
2	10	7	¿CUÁLES SON LAS MATERIAS NO CONCILIABLES?	No procede la conciliación cuando se trate de derechos y bienes de incapaces (Arts. 43 y 44 Código Civil), en procesos cautelares, procesos de garantías constitucionales, procesos de nulidad, ineficacia y anulabilidad del acto jurídico, petición de herencia, los casos de violencia familiar, y todas las demás pretensiones que no sean de libre disposición por las partes conciliantes.	126	2020-05-04 22:19:04.067	t
2	11	10	¿CUÁNDO NO ES EXIGIBLE LA CONCILIACIÓN?	No se exige la conciliación para calificar una demanda judicial en: los procesos de ejecución, de tercería, prescripción adquisitiva de dominio, retracto, convocatoria a asamblea general de socios o asociados, indemnización por delitos, faltas y daños ambientales, en los procesos de impugnación judicial de acuerdos de junta general de accionistas y acciones de nulidad según la Ley General de Sociedades, y en los procesos contencioso administrativos. En todos, la conciliación es facultativa.	126	2020-05-04 22:19:14.66	t
2	12	11	¿CUÁL ES EL VALOR DEL ACTA DE CONCILIACIÓN?	Toda acta con acuerdo conciliatorio constituye título de ejecución, esto es, que los derechos, deberes u obligaciones ciertas, expresas y exigibles que constan en la misma se ejecutarán a través del proceso de ejecución de resoluciones judiciales.	126	2020-05-04 22:19:25.54	t
2	13	12	¿CÓMO CONCLUYE UN PROCEDIMIENTO CONCILIATORIO?	El procedimiento conciliatorio concluye por acuerdo total de las partes, acuerdo parcial de las partes, falta de acuerdo entre las partes, inasistencia de una parte a dos sesiones, inasistencia de ambas partes a una sesión, o por decisión debidamente motivada del conciliador por advertir violación a los principios de la conciliación, por retirarse alguna de las partes antes de concluir la audiencia, o por negarse a firmar el acta de conciliación.	126	2020-05-04 22:19:39.71	t
2	14	13	¿CÓMO SE REGISTRAN Y ARCHIVAN LOS EXPEDIENTES Y LAS ACTAS?	El Centro de Conciliación Extrajudicial debe llevar, archivar y custodiar, bajo responsabilidad: a) Los Expedientes, que deben almacenarse en orden cronológico, b) Los Libros de Registro de Actas, y c) el Archivo de Actas. Pueden expedirse copias certificadas de los expedientes y actas a pedido de alguna parte interviniente, del Ministerio de Justicia o del Poder Judicial. Si hubiera destrucción, deterioro, pérdida o sustracción parcial o total de las actas o expedientes, debe informarse al Ministerio de Justicia quien aplicará su facultad sancionadora prevista en el artículo 19B de la Ley de Conciliación.	126	2020-05-04 22:20:00.89	t
2	15	14	¿QUÉ EFECTOS TIENE NO ASISTIR A UNA CONCILIACIÓN?	La inasistencia de la parte invitada produce en el proceso judicial la presunción legal relativa de verdad sobre los hechos expuestos en el acta de conciliación y en la demanda. La misma presunción se aplica a favor del invitado cuando el solicitante no asiste. Además, el juez impondrá una multa no menor de 2 ni mayor de 10 URP a la parte que no asistió a la audiencia. Asimismo, la reconvención que haga un invitado en vía judicial solo se admitirá si no produjo la conclusión del procedimiento conciliatorio por inasistencia a dos sesiones o por decisión debidamente motivada del conciliador.	126	2020-05-04 22:20:12.07	t
2	16	15	¿QUÉ SUCEDE SI SE VA A JUICIO SIN IR ANTES A UNA CONCILIACIÓN?	El juez competente, al momento de calificar la demanda, puede declararla improcedente por causa de manifiesta falta de interés para obrar. Por el contrario, en los procesos judiciales cuya materia se encuentre sujeta a conciliación previa, un requisito de admisibilidad es la copia certificada del Acta de Conciliación Extrajudicial.	126	2020-05-04 22:20:22.93	t
2	17	16	¿CUÁLES SON LOS REQUISITOS PARA SER CONCILIADOR EXTRAJUDICIAL?	Se requiere ser ciudadano en ejercicio, haber aprobado el Curso de Formación y Capacitación de Conciliadores dictado por una entidad autorizada por el MINJUS, carecer de antecedentes penales, y cumplir con los demás requisitos que exige el Reglamento.	126	2020-05-04 22:20:35.923	t
2	18	17	¿CUÁL ES EL PAPEL DEL MINISTERIO DE JUSTICIA?	El MINJUS tiene a su cargo la acreditación, registro, autorización, renovación, habilitación, supervisión y sanción de los operadores del sistema conciliatorio, y es el Reglamento el que especifica la forma cómo serán ejercidas estas facultades.	126	2020-05-04 22:20:47.603	t
2	19	18	¿CUÁLES SON LAS NORMAS QUE RIGEN LA CONCILIACIÓN EXTRAJUDICIAL?	Las normas son: Ley 26872 y sus modificatorias Ley 27398, Decreto Legislativo 1070 y Ley 30514, y su Reglamento el Decreto Supremo 014-2008-JUS.	126	2020-05-04 22:20:58.77	t
2	20	8	¿CUANDO SE LLEVA CONCILIACIÓN EXTRAJUDICIAL EN FAMILIA?	Para facilitar un acuerdo entre los Padres relacionado a los alimentos, régimen de visitas y tenencia de sus hijos.	126	2020-06-08 00:50:32.02	t
2	21	9	¿QUIENES HACEN LA CONCILIACIÓN EXTRAJUDICIAL EN FAMILIA?	Se desarrolla la Conciliación Extrajudicial en Familia por nuestros expertos y especialistas en Familia acreditadas por el Ministerio de Justicia.	126	2020-06-08 00:54:13.063	t
2	22	6	¿CUALES SON LOS DERECHOS DISPONIBLES?	De acuerdo al artículo 7 de la Ley de Conciliación Extrajudicial, y el artículo 7 de su propio Reglamento señala: \n\nDerechos disponibles.-  Son aquellos que tienen un contenido patrimonial, es decir, los que son supceptibles de ser valorados económicamente.\n\n\nSon también derechos disponible aquellos que no siendo necesariamente patrimoniales, pueden ser objetos de libre disposición.\n\n\nLibre disposición.-  Pueden ser objetos de libre disposión, aquellos derechos en los cuales el titular ejercite facultades que demuestren su capacidad de dominio, enajenación o de gravar dichos derechos, sin ningún tipo de prohibición legal que limite o restrinja esas facultades.	126	2020-06-08 01:23:42.377	t
1	23	3	ewBu b Hhhhh	wewe	22	2020-10-19 21:11:17.073	t
4	24	1	Pregunta 1	Respuesta 1	221	2020-10-25 23:20:29.273	t
4	25	2	Pregunta 2	Respuesta 2	221	2020-10-25 23:20:43.31	t
1	26	4	preP	ww	22	2021-01-28 21:22:16.12	t
3	27	1	¿La primera consulta es totalmente gratuita?	Si, la primera consulta recibida, por teléfono, email, Whatsapp o Telegrám, es totalmente gratuita y sin compromiso, en donde tras recibir los primeros datos de su caso y/o documentos, le facilitamos una orientación jurídica de su asunto y si ello es posible, una primera aproximación sobre la viabilidad y prosperabilidad del mismo e incluso un presupuesto aproximado.	644	2022-03-22 02:14:02	t
3	28	2	¿Qué tipo de asesoramiento y atención voy a recibir?	Un asesoramiento y estudio altamente especializado y personalizado de su caso en concreto, como un traje a medida y enfocado totalmente a la función pública como Guardia Civil, Policía Nacional, autonómico y local:\n\n- Defensa y dirección letrada en el Recurso Contencioso-Administrativo que se interpone contra la prueba en la que nuestro cliente ha sido declarado no apto.\n\nContacto permanente con su letrado por teléfono, email, por Whatsapp o Telegram.\n\nInformación puntual del estado de tramitación de su asunto, con envío inmediato de todo lo que se reciba en el despacho de su asunto, por email, app o llamada telefónica, así como participación y colaboración con el cliente de todos los escritos que se originen desde el despacho, en aplicación del principio de que nadie mejor que el cliente conoce su caso, y puede aportar datos y detalles que el abogado desconoce.	644	2022-03-22 02:14:10.987	t
3	29	3	¿Puedo contar con ustedes para otros asuntos que no sean relacionados con mi profesión?	No, salvo que se trate de un asunto que afecte o entre en colisión con su profesión. Como puede ser la asistencia y dirección letrada por investigación, acusación y condena por un delito de malos tratos, conducir bajo la influencia de drogas y bebidas alcohólicas, divorcio contencioso con domicilio conyugal del pabellón. Etc.	644	2022-03-22 02:14:24.377	t
3	30	4	¿Por qué motivo asesoran también en asuntos netamente no relacionados con mi profesión pero que pueden afectarla?	El motivo, es simple, los abogados en general desconocen las consecuencias que para un Policía supone el haber sido condenado por un delito doloso, aunque sus consecuencias no se perciban como tal, bien porque la condena es o bien una multa, o trabajos en beneficio a la comunidad o siendo de prisión, esta se suspenda al ser la primera vez y reunir otros requisitos para ello.\n\nEn estos casos, el abogado, debe de conocer no solo como asistir a su cliente en la jurisdicción ordinaria, sino también conocer todas las repercusiones que puede haber si se toman decisiones erróneas o equivocadas producto de un mal asesoramiento, que, en otras condiciones, sería bueno, pero que en su condición de Policía, pueden ser letales y conllevar una condena y sus efectos mucho más gravosa que la que aparentemente se ve en principio.	644	2022-03-22 02:14:41.313	t
3	31	5	¿Son baratos sus honorarios?	No pueden considerarse ni caros ni baratos, sino justos y adecuados en consonancia con el esfuerzo y dedicación que necesite cada asunto. En vez de facturar por horas de trabajo, nosotros ya hemos calculado en todos los procedimientos en los que prestamos nuestros servicios, el precio de los mismos, trasladando al cliente un precio global que, como asunto vivo que es, puede llegar a requerir más o menos dedicación, pero sin que estas variaciones se trasladen de forma sorpresiva al cliente. El cliente una vez conoce y acepta el presupuesto, hace la provisión de fondos acordada y reflejada en el contrato que previamente se firma, lo que nos permite en determinados casos dar la facilidad de poder acceder a nuestros servicios si ello fuera necesario mediante un pago fraccionado mensual sin intereses. El cliente desde que acepta el presupuesto y firma la hoja de encargo profesional, sabe lo q	644	2022-03-22 02:14:50.533	t
3	32	6	¿Qué es eso de estrategia orientada al cliente y al resultado final buscado?	Los abogados no somos magos que conseguimos en el ámbito jurídico aquello que parece imposible, sino conocedores del derecho y su aplicación, con las armas permanentemente afiladas en la defensa de los intereses de nuestros clientes.\n\nCuando decimos que la estrategia está orientada al cliente, queremos decir que toda nuestra actuación se dirige a su beneficio y no al de los propios abogados, como en otros casos. Si el cliente gana nosotros ganamos. En el mundo judicial como en todos los aspectos de la vida, no todo es blanco o negro, sino que hay muchos tipos de grises y dentro de este abanico de posibilidades, la pericia del abogado es fundamental para conseguir que la balanza se incline hacia un lado o hacia otro, orientando la estrategia hacia el mejor resultado posible de su asunto.	644	2022-03-22 02:14:59.33	t
3	33	7	Si comenten alguna negligencia ¿son ustedes de los que cumplen o desaparecen?	Nadie está exento de cometer un error o negligencia profesional que pueda repercutir en el cliente. Pero en el caso de que esto ocurriera, contamos con un seguro profesional de hasta un millón de euros, lo que nos permite trabajar y atender a nuestros clientes con la tranquilidad de que, si se da un evento dañoso no querido, nuestro cliente no salga perjudicado o por lo menos sea debidamente resarcido e indemnizado.	644	2022-03-22 02:15:08.377	t
3	34	8	¿Por qué he de elegirlos a ustedes?	Existen numerosos despachos de abogados que se denominan especialistas en Derecho Militar, de la Guardia Civil, y Policial pero, sin embargo, además de estos asuntos, lo mismo llevan un divorcio, que una cláusula suelo, un arrendamiento, un despido improcedente, etc. Son especialistas en todo y especialistas en nada.\n\nExisten también otros despachos de abogados que están especializados únicamente en Derecho Militar, de la Guardia Civil y Policía, como el nuestro, pero que sin embargo se orientan al asesoramiento de asociaciones o Sindicatos, con precios muy bajos y prestación de servicios acordes a esos precios, ofreciendo una calidad de servicio muy escasa debido todo ello al gran volumen de casos y clientes que tienen que atender, lo que imposibilita una atención personalizada y de calidad, que luego se refleja en sus resultados.\n\nNuestro despacho, busca atender a un perfil de cliente que precisa de una gran especialización jurídica centrada en su profesión, una atención preferente en los asuntos encomendados, permanentemente informados de su estado, con participación del cliente en su asunto y con gran accesibilidad a su abogado por teléfono, email y apps, y todo ello a unos precios adecuados a los servicios y valor añadido prestados y con unos resultados finales acordes con todo ello.	644	2022-03-22 02:15:16.36	t
7	35	1	Pregunta 1	Respuesta 2	689	2022-04-01 19:37:13.68	t
\.


--
-- Data for Name: tblservicio; Type: TABLE DATA; Schema: empresa; Owner: postgres
--

COPY empresa.tblservicio (coempresa, coservicio, cotipo, cosubtipo, notitulo, txdescripcion, txdescripcioncorta, cousucre, fecre, flestreg, flmuestraimagen) FROM stdin;
1	39	1	2	Sistema de Condominio		Administre el pago de servicios y alquileres de sus departamentos. 	22	2022-09-30 15:54:22.1	t	t
1	38	1	2	Sistema de Soporte Técnico		Gestione las tareas de Soporte tecnico de su empresa efectivamente y en orden.	22	2022-09-30 15:52:10.63	t	t
1	37	1	2	Sistema de Matrícula		Sistema de Matrícula para mejorar la Gestión de su centro de labores y optimizar sus tiempos y recursos posibles. Adaptable para todos los usuarios.	22	2022-09-30 15:46:41.11	t	t
7	36	\N	5	Trasaldoss 	bla vla bla 		689	2022-04-01 19:53:11.167	t	t
7	35	1	\N	proceso de traslado	Bl bla bla klasnlksadsa		689	2022-04-01 19:52:01.807	t	t
4	21	\N	9	\N	...		221	2020-11-21 23:39:52.867	t	t
4	18	\N	6	\N	...		221	2020-10-25 22:55:33.817	t	t
4	17	\N	5	\N	...		221	2020-10-25 22:55:15.36	t	t
4	16	\N	4	\N	...		221	2020-10-25 22:55:07.04	t	t
4	34	\N	25	\N	...		221	2020-11-21 23:56:44.21	t	t
4	33	\N	24	\N	...		221	2020-11-21 23:55:44.673	t	t
4	32	\N	23	\N	...		221	2020-11-21 23:53:32.58	t	t
4	31	\N	22	\N	...		221	2020-11-21 23:48:31.703	t	t
4	30	\N	19	\N	...		221	2020-11-21 23:47:28.473	t	t
4	29	\N	18	\N	...		221	2020-11-21 23:46:33.477	t	t
4	28	\N	17	\N	...		221	2020-11-21 23:45:31.87	t	t
4	27	\N	16	\N	...		221	2020-11-21 23:44:51.603	t	t
4	26	\N	15	\N	...		221	2020-11-21 23:44:20.2	t	t
4	25	\N	14	\N	...		221	2020-11-21 23:43:44.117	t	t
4	24	\N	13	\N	...		221	2020-11-21 23:42:46.213	t	t
4	23	\N	12	\N	...		221	2020-11-21 23:41:40.457	t	t
4	22	\N	11	\N	...		221	2020-11-21 23:40:39.85	t	t
4	20	\N	8	\N	...		221	2020-11-21 23:29:01	t	t
4	19	\N	7	\N	...		221	2020-10-25 22:55:45.49	t	t
4	15	\N	3	\N	...		221	2020-10-25 22:54:56.323	t	t
4	14	\N	2	\N	...		221	2020-10-25 22:54:45.71	t	t
4	13	\N	1	\N	...		221	2020-10-25 22:54:14.223	t	t
1	12	1	2	Sistema de Creditos Inmobiliarios	<p>descsc</p>	Gestione sus prestamos de su negocio, en forma efectiva. 	22	2020-10-20 00:24:04.343	t	t
1	11	1	2	Sistema de Facturación		Sistema de Facturación facil de usar y con acceso desde cualquier parte, con el  cual ganas tiempo y tranquilidad en tu negocio.	22	2020-10-20 00:19:48.13	t	t
2	9	\N	13	\N	Es el Procediendo mediante el cual se verifica el cumplimiento de las Prestaciones materia del Contrato; Ya sea en el caso de bienes y servicios ,suscribiendo el Acta de Conformidad correspondiente y en el caso de obras, se suscribirá el Acta correspondiente de entrega de la misma.		126	2020-05-09 22:14:39.05	t	t
2	8	\N	12	\N	Es el derecho del Contratista a ampliar el plazo de ejecución Contractual, en caso que sobrevengan las causales taxativas establecidas en el Reglamento de la ley y se haya seguido el procedimiento para su implementación.		126	2020-05-09 22:14:33.157	t	t
2	3	\N	1	\N	La palabra resolución (del latín resolutio) significa deshacer, destruir, desatar, disolver, extinguir un contrato. La resolución deja sin efecto, judicial o extrajudicialmente, un contrato válido por causal sobreviniente a su celebración que impide que cumpla su finalidad económica.		126	2020-05-09 22:13:27.43	t	t
2	10	\N	7	\N	 El Régimen de Visitas es un Derecho Optimo e inherente para el desarrollo emocional del Menor, es decir es el Derecho que tiene todo menor de mantener el vínculo PATERNO-FILIAL activo .\n\nAl Disolverse el vínculo Matrimonial o Con vivencial, si bien es cierto ambos padres ejercen la Patria Potestad, solo uno de ellos ejercerá la Tenencia y al otro se le asignara un Régimen de Visitas, La Doctrina propone el sistema de Coparentaleidad a fin de asegurar vínculos familiares sólidos.\n		126	2020-05-10 00:49:25.18	t	t
2	7	\N	11	\N	Es el acto mediante el cual, una de las partes de forma unilateral pone fin a la relación contractual, ya sea por incumplimiento de las Obligaciones esenciales, caso fortuito o fuerza mayor; En el caso de las Entidades, estas se encuentran en la potestad de resolverlas, si el Contratista llega a la máxima penalidad según la ley.		126	2020-05-09 22:14:24.17	t	t
2	6	\N	6	\N	El derecho alimentario peruano acepta como pretensión a reclamar en sede judicial, la exoneración de la pensión alimenticia, que consiste en el cese del cumplimiento de la obligación alimentaria dispuesta por la Ley, por lo que al obligado se le exime de continuar prestando asistencia económica a favor del alimentista ...		126	2020-05-09 22:14:18.403	t	t
2	5	\N	5	\N	El monto establecido como Pensión Alimentaria, en una Sentencia o Acta Conciliatoria puede ser materia de variación en aumento o reducción de la misma\nAl ser un Derecho Asistencial NO ESTATICO, Los requerimientos del acreedor alimentista varían con el tiempo, es por ello que en materia procesal, en estos casos las sentencias no adquieren calidad de Cosa Juzgada.\n		126	2020-05-09 22:14:05.74	t	t
2	4	\N	4	\N	Nuestra Constitución reconoce al Matrimonio y  a la Unión de Hecho como fuentes generadoras de Familia; En ese sentido se brinda protección Jurídica garantizando la Pensión de Alimentaria\nLos Concubinos pueden solicitar pensión de Alimentos entre si como Deber de Asistencia.\nAsí mismo, nuestra Legislación solo reconoce la prestación de Alimentos entre Concubinos que se encuentran separados de hecho.		126	2020-05-09 22:13:56.41	t	t
2	2	\N	2	\N	Toda persona tiene Derecho a solicitar la “restitución” del bien a ello se debe entender como entrega de la posesión que protege el artículo 911° del Código Civil, para garantizar al sujeto a quien corresponde dicho derecho a ejercer el pleno disfrute del mismo, independientemente si es que es propietario o no.\n el sujeto que goza de legitimación para obrar activa no sólo puede ser el propietario, sino también, el administrador y todo aquel que se considere tener derecho a la restitución de un predio e iniciar un Proceso de Desalojo.\n		126	2020-05-09 22:11:18.573	t	t
2	1	\N	3	\N	La pensión de Alimentos es Derecho Personalísimo con valor económico, Es un deber impuesto jurídicamente a una Persona para asegurar la subsistencia de otra.\nConforme a ello se considera Alimentos a todo lo necesario para el sustento, habitación, vestido, educación, instrucción y capacitación para el trabajo, asistencia médica y psicológica y recreación del niño y el adolescente. \n		126	2020-05-09 21:58:10.273	t	t
\.


--
-- Data for Name: tblserviciocaracteristica; Type: TABLE DATA; Schema: empresa; Owner: postgres
--

COPY empresa.tblserviciocaracteristica (coempresa, coserviciocaracteristica, coservicio, nuorden, notitulo, txdescripcion, cousucre, fecre, flestreg) FROM stdin;
1	2	12	1	Demo del Sistema	<p>Ingrese al sistema mediante este Link:&nbsp;&nbsp;<a href="../../../Mozo.Urbano/Account/Login">http://167.86.102.149/Mozo.Urbano/Account/Login</a> y registrese.</p>	22	2022-10-18 03:14:59.84	t
1	1	11	1	Demo del Sistema	<p>Ingrese al sistema mediante este Link:&nbsp;&nbsp;<a href="http://167.86.102.149/Mozo.Facturacion/Account/Login">http://167.86.102.149/Mozo.Facturacion/Account/Login</a> y registrese.</p>	22	2022-09-30 15:55:14.67	t
\.


--
-- Data for Name: tblcompra; Type: TABLE DATA; Schema: facturacion; Owner: postgres
--

COPY facturacion.tblcompra (coempresa, cocompra, colocal, cocomprobantepago, nuserie, nudocumento, fecompra, fevencimiento, comoneda, cotipocambio, coproveedor, ssprecio, ssimpuesto, ssdescuento, nunotaentrada, comodopago, comediopago, codocpago, txdescripcion, cousucre, cousumod, fecre, femod, flestreg, flimpuestoincluyeprecio) FROM stdin;
\.


--
-- Data for Name: tblcompradetalle; Type: TABLE DATA; Schema: facturacion; Owner: postgres
--

COPY facturacion.tblcompradetalle (coempresa, cocompradetalle, cocompra, nuorden, coproducto, qtproducto, ssprecioingresado, ssprecio, pqdescuento, ssdescuento, ssimpuesto, sspreciototal, colocal, coalmacen, cousucre, cousumod, fecre, femod, flestreg) FROM stdin;
\.


--
-- Data for Name: tblcompradetalleimpuesto; Type: TABLE DATA; Schema: facturacion; Owner: postgres
--

COPY facturacion.tblcompradetalleimpuesto (coempresa, cocompradetalleimpuesto, cocompradetalle, coimpuesto, ssmonto, pqtaza, coimpuestohijo) FROM stdin;
\.


--
-- Data for Name: tblcorrelativo; Type: TABLE DATA; Schema: facturacion; Owner: postgres
--

COPY facturacion.tblcorrelativo (coempresa, cocorrelativo, colocal, cocomprobantepago, nuserie, nudocumento, fecre, femod, cousucre, cousumod, flestreg, fldefault) FROM stdin;
\.


--
-- Data for Name: tblproforma; Type: TABLE DATA; Schema: facturacion; Owner: postgres
--

COPY facturacion.tblproforma (coempresa, coproforma, colocal, nuserie, nudocumento, feventa, comoneda, cocliente, ssprecio, ssimpuesto, ssdescuento, txdescripcion, cousucre, cousumod, fecre, femod) FROM stdin;
\.


--
-- Data for Name: tblproformadetalle; Type: TABLE DATA; Schema: facturacion; Owner: postgres
--

COPY facturacion.tblproformadetalle (coempresa, coproformadetalle, coproforma, nuorden, coproducto, qtproducto, ssprecio, coimpuesto, pqimpuesto, ssimpuesto, pqdescuento, ssdescuento, cousucre, cousumod, fecre, femod) FROM stdin;
\.


--
-- Data for Name: tblventa; Type: TABLE DATA; Schema: facturacion; Owner: postgres
--

COPY facturacion.tblventa (coempresa, coventa, colocal, cocomprobantepago, nuserie, nudocumento, feventa, fevencimiento, comoneda, cotipocambio, cocliente, ssprecio, ssimpuesto, ssdescuento, nunotasalida, comodopago, comediopago, codocpago, txdescripcion, coestreg, cousucre, cousumod, fecre, femod, flestreg) FROM stdin;
\.


--
-- Data for Name: tblventadetalle; Type: TABLE DATA; Schema: facturacion; Owner: postgres
--

COPY facturacion.tblventadetalle (coempresa, coventadetalle, coventa, nuorden, coproducto, qtproducto, ssprecioingresado, ssprecio, ssdescuento, ssimpuesto, sspreciototal, colocal, coalmacen, cousucre, cousumod, fecre, femod, pqdescuento, flestreg) FROM stdin;
\.


--
-- Data for Name: tblventadetalleimpuesto; Type: TABLE DATA; Schema: facturacion; Owner: postgres
--

COPY facturacion.tblventadetalleimpuesto (coempresa, coventadetalleimpuesto, coventadetalle, coimpuesto, ssimpuesto, pqtaza, coimpuestohijo) FROM stdin;
\.


--
-- Data for Name: tblinventario; Type: TABLE DATA; Schema: inventario; Owner: postgres
--

COPY inventario.tblinventario (coempresa, coinventario, cocompra, fecre, cotipomovimiento, coventa, cousucre) FROM stdin;
\.


--
-- Data for Name: tblinventariodetalle; Type: TABLE DATA; Schema: inventario; Owner: postgres
--

COPY inventario.tblinventariodetalle (coempresa, coinventariodetalle, coinventario, cocompradetalle, coventadetalle, coproducto, qtproducto, colocal, coalmacen, fecre, cousucre) FROM stdin;
\.


--
-- Data for Name: tblstock; Type: TABLE DATA; Schema: inventario; Owner: postgres
--

COPY inventario.tblstock (coempresa, coalmacen, coproducto, qtunidad, costock, colocal) FROM stdin;
\.


--
-- Data for Name: tblarchivo; Type: TABLE DATA; Schema: maestro; Owner: postgres
--

COPY maestro.tblarchivo (coempresa, coarchivo, cotipoentidad, coentidad, cotipo, nuorden, txdescripcion, noarchivo, noextension, cousucre, cousumod, fecre, femod, nubytes, nualto, nuancho, notitulo, flestreg, fldefault, noruta) FROM stdin;
\.


--
-- Data for Name: tblentidaddireccion; Type: TABLE DATA; Schema: maestro; Owner: postgres
--

COPY maestro.tblentidaddireccion (coentidad, coentidaddireccion, coetiqueta, nodireccionlinea1, nodireccionlinea2, nodireccionlinea3, nourbanizacionbarrio, nociudad, nocodigopostal, coubigeo, sslatitude, sslongitude, noreferencia, flestreg, fldefault, fecre, femod, cousucre, cousumod, copais) FROM stdin;
\.


--
-- Data for Name: trfdocumentoidentidad; Type: TABLE DATA; Schema: maestro; Owner: postgres
--

COPY maestro.trfdocumentoidentidad (codocumentoidentidad, copais, nocodigo, nodocumentoidentidad, flestreg, nodocumentoidentidadsigla, coambito) FROM stdin;
3	137	04	Carnet de extranjería	t	CARNÉ EXT.	1
5	137	07	Pasaporte	t	PASAPORTE	1
6	137	A	Cédula diplomática de identidad	t	A	1
7	137	B	Documento identificación extranjero - Pasaporte	t	B	1
9	137	D	Documento identificación extranjero - N° de identificación	t	D	1
10	137	E	Tax Identification Number (TIN) - solo extranjero	t	E	1
11	137	09	CARNÉ DE SOLICIT DE REFUGIO	t	CARNÉ SOLIC REFUGIO	1
2	137	01	Documento Nacional de Identidad	t	DNI	1
1	137	00	DOC.TRIB.NO.DOM.SIN.RUC	t	\N	0
4	137	06	Registro Único de Contribuyentes	t	RUC	2
8	137	C	Documento identificación extranjero - Documento Tributario	t	C	2
\.


--
-- Data for Name: tblentidaddocumento; Type: TABLE DATA; Schema: maestro; Owner: postgres
--

COPY maestro.tblentidaddocumento (coentidaddocumento, coentidad, codocumentoidentidad, nudocumento, fldefault, fecre, femod, cousucre, cousumod) FROM stdin;
\.


--
-- Data for Name: tblentidadempresa; Type: TABLE DATA; Schema: maestro; Owner: postgres
--

COPY maestro.tblentidadempresa (coentidadempresa, coempresa, coentidad, fecre, cousucre, fldefault) FROM stdin;
1	1	22	2026-06-24 12:37:29.545404	-100	f
3	2	21	2026-06-24 12:37:29.545404	-100	f
5	1	1	2026-06-26 12:19:01.599706	-100	f
6	2	2	2026-06-26 12:19:50.32096	-100	f
7	3	3	2026-06-26 12:19:50.32096	-100	f
8	4	4	2026-06-26 12:19:50.32096	-100	f
9	5	5	2026-06-26 12:19:50.32096	-100	f
10	6	6	2026-06-26 12:19:50.32096	-100	f
2	2	22	2026-06-24 12:37:29.545404	-100	f
\.


--
-- Data for Name: tblentidadredsocial; Type: TABLE DATA; Schema: maestro; Owner: postgres
--

COPY maestro.tblentidadredsocial (coentidadredsocial, coentidad, cotiporedsocial, cotipourl, coetiqueta, noredsocial, cousucre, cousumod, fecre, femod, flwhatsapp) FROM stdin;
\.


--
-- Data for Name: tblentidadrol; Type: TABLE DATA; Schema: maestro; Owner: postgres
--

COPY maestro.tblentidadrol (coentidadrol, coempresa, coentidad, comodulo, corolnegocio, cousucre, fecre, cousumod, femod) FROM stdin;
\.


--
-- Data for Name: trftipoparticular; Type: TABLE DATA; Schema: maestro; Owner: postgres
--

COPY maestro.trftipoparticular (cogrupo, nuorden, coempresa, comodulo, notipo, txdescripcion, nosigla, cogrupopadre, cotipoparticularpadre, nocomando, cousucre, cousumod, cousueli, fecre, femod, feeli, fldelete, fldefault, flestreg, cotipoparticular) FROM stdin;
12	17	1	5	Uno		U	19	1	\N	22	22	\N	2026-06-22 13:55:22.74969	2026-06-22 14:43:15.975691	\N	f	f	t	1
0	8	-100	1	Área prácticas	Área practicas		\N	0	empresa.areapractica	-100	\N	\N	2020-04-22 12:29:56.4	\N	\N	f	f	t	2
0	7	-100	1	Sub Servicios	Sub Servicios		0	0	empresa.serviciohijo	-100	\N	\N	2020-04-22 12:29:56.4	\N	\N	f	f	t	3
0	5	-100	1	Etiquetas de la bandeja	Etiqueta		\N	0	empresa.bandejaetiqueta	-100	\N	\N	2020-04-22 12:29:56.4	\N	\N	f	f	t	4
0	6	-100	1	Servicios de la empresa	Servicios		31	0	empresa.servicio	-100	\N	\N	2020-04-22 12:29:56.4	\N	\N	f	f	t	5
0	28	-100	8	Máteria expediente	Máteria expediente		32	0	boga.materiaexpediente	-100	\N	\N	2020-04-22 12:29:56.4	\N	\N	f	f	t	6
0	29	-100	8	Tipo documento	Tipo documento		\N	0	boga.tipodocumento	-100	\N	\N	2020-04-22 12:29:56.4	\N	\N	f	f	t	7
0	30	-100	8	Estado expediente	Estado expediente		\N	0	boga.estadoexpediente	-100	\N	\N	2020-04-22 12:29:56.4	\N	\N	f	f	t	8
19	17	1	5	334334			\N	\N	\N	22	\N	\N	2026-06-19 23:46:40.656705	\N	\N	f	f	t	9
0	31	-100	8	Sub Máteria expediente	Sub Máteria expediente		\N	0	boga.submateriaexpediente	-100	\N	\N	2020-04-22 12:29:56.4	\N	\N	f	f	t	10
0	32	-100	8	Parte expediente	Parte del expediente		0	0	boga.parteexpediente	-100	\N	\N	2020-04-22 12:29:56.4	\N	\N	f	f	t	11
0	1	-100	-2	Rubros	Rubros		0	0	maestro.rubro	-100	\N	\N	2018-05-17 15:28:52.003	\N	\N	f	f	t	12
0	2	-100	-2	Profesiones	Profesiones		0	0	maestro.profesion	-100	\N	\N	2018-05-17 15:29:24.9	\N	\N	f	f	t	13
0	3	-100	1	Grupo Estadística	Estadistica		0	0	empresa.estadistica	-100	\N	\N	2018-05-17 15:28:52.003	\N	\N	f	f	t	14
0	4	-100	1	Ventajas Empresa	Ventajas Empresa		0	0	empresa.ventaja	-100	\N	\N	2018-05-17 15:30:33.637	\N	\N	f	f	t	15
0	40	-100	15	Bono	Bono		0	0	urbano.bono	-100	\N	\N	2018-05-17 15:29:17.9	\N	\N	f	f	t	16
0	23	-100	6	Categorias del producto	Categorias del producto		0	0	producto.categoria	-100	\N	\N	2020-04-22 12:29:56.4	\N	\N	f	f	t	17
0	24	-100	6	Categorias hijos del producto	Categorias hijos del producto		0	0	producto.categoriahijo	-100	\N	\N	2020-04-22 12:29:56.4	\N	\N	f	f	t	18
0	9	-100	2	Servicios	Servicios		0	0	condominio.servicio	-100	\N	\N	2018-11-23 00:49:05.687	\N	\N	f	f	t	19
0	10	-100	3	Categoria	Categoria		15	0	gasto.categoria	-100	\N	\N	2019-07-15 11:36:23.873	\N	\N	f	f	t	20
0	11	-100	3	Sub Categoria	Sub Categoria		0	0	gasto.categoriahijo	-100	\N	\N	2019-07-15 11:36:43.64	\N	\N	f	f	t	21
0	12	-100	3	Cuenta	Cuenta de Ahorro		0	0	gasto.cuenta	-100	\N	\N	2019-07-15 11:40:17.233	\N	\N	f	f	t	22
0	13	-100	4	Formato material	Formato material		0	0	biblioteca.formatomaterial	-100	\N	\N	2020-01-07 18:39:02.247	\N	\N	f	f	t	23
0	14	-100	4	Idioma	Idioma		\N	0	biblioteca.idioma	-100	\N	\N	2020-01-07 18:41:31.283	\N	\N	f	f	t	24
0	15	-100	4	Forma adquisición	Forma adquisición		\N	0	biblioteca.formaadquisicion	-100	\N	\N	2020-01-07 18:42:01.537	\N	\N	f	f	t	25
0	33	-100	11	Grado academico	Grado Academico		0	0	matricula.gradoacademico	-100	\N	\N	2020-04-22 12:29:56.4	\N	\N	f	f	t	26
0	34	-100	11	Tipo Notas	Notas		0	0	matricula.tiponota	-100	\N	\N	2020-04-22 12:29:56.4	\N	\N	f	f	t	27
0	35	-100	11	Tipo Horario	Horario		0	0	matricula.tipohorario	-100	\N	\N	2020-04-22 12:29:56.4	\N	\N	f	f	t	28
0	36	-100	11	Tipo Pensión	Pensión		0	0	matricula.tipopension	-100	\N	\N	2020-04-22 12:29:56.4	\N	\N	f	f	t	29
12	2	1	5	Tres		T	19	1	\N	22	22	\N	2026-06-19 20:51:57.094765	2026-06-22 13:54:55.026323	\N	f	f	t	30
12	4	1	5	CUatro		F	19	1	\N	22	22	\N	2026-06-19 21:10:09.696758	2026-06-22 13:55:06.96142	\N	f	f	t	31
0	37	-100	11	Categoria Curso	Categoria Curso		0	0	matricula.categoriacurso	-100	\N	\N	2020-04-22 12:29:56.4	\N	\N	f	f	t	32
0	38	-100	11	Categoria Carrera	Categoria Carrera		0	0	matricula.categoriacarrera	-100	\N	\N	2020-04-22 12:29:56.4	\N	\N	f	f	t	33
0	16	-100	4	Perioricidad	Perioricidad		\N	0	biblioteca.periodicidad	-100	\N	\N	2020-01-07 18:42:24.703	\N	\N	f	f	t	34
0	17	-100	4	Documento	Documento		\N	0	biblioteca.documento	-100	\N	\N	2020-01-07 18:43:45.657	\N	\N	f	f	t	35
0	18	-100	4	Sección Periodico	Sección Periodico		\N	0	biblioteca.seccionperiodico	-100	\N	\N	2020-01-07 18:44:04.897	\N	\N	f	f	t	36
12	16	1	5	434		434	19	17	\N	22	\N	\N	2026-06-19 23:46:46.9361	\N	\N	f	f	t	37
0	19	-100	5	Soporte	Soporte		12	0	soporte.categoria	-100	\N	\N	2019-07-02 10:28:05.927	\N	\N	f	f	t	38
0	26	-100	7	Bancos	Bancos		0	0	contabilidad.banco	-100	\N	\N	2019-07-29 12:40:05.347	\N	\N	f	f	t	39
0	21	-100	6	Marcas de producto	Marcas de producto	\N	\N	\N	producto.marca	-100	\N	\N	2025-09-17 15:39:50.424309	\N	\N	f	f	t	40
0	27	-100	7	Tazas de interes	Tazas de interes		0	0	contabilidad.tazainteres	-100	\N	\N	2020-04-22 12:29:56.4	\N	\N	f	f	t	41
0	22	-100	6	Laboratorios del producto	Laboratorios del producto		0	0	producto.laboratorio	-100	\N	\N	2020-04-22 12:29:56.4	\N	\N	f	f	t	42
0	39	-100	6	Precios de productos	Precios de productos		0	0	producto.precio	-100	\N	\N	2020-04-22 12:29:56.4	\N	\N	f	f	t	43
9	1	1	2	Nomre	DESCR	SIG	\N	\N	\N	22	22	\N	2026-06-18 19:41:41.796067	2026-06-18 23:29:02.976564	\N	f	t	t	44
9	4	1	2	fsfsdfwewe	43434		\N	\N	\N	22	22	\N	2026-06-18 22:44:57.16778	2026-06-19 15:12:42.765509	\N	f	f	t	45
0	20	-100	5	Sub soporte	Sub soporte		0	0	soporte.categoriahijo	-100	\N	\N	2019-07-02 10:29:01.44	\N	\N	f	f	f	46
12	8	1	5	eerer			19	14	\N	22	\N	\N	2026-06-19 23:10:34.71997	\N	\N	f	f	t	47
9	2	1	2	33	323r234234234	33	\N	\N	\N	22	22	22	2026-06-18 20:40:35.39197	2026-06-18 20:53:01.505391	2026-06-18 15:47:01.426363	t	f	t	48
9	3	1	2	3242342	34234324	2342	\N	\N	\N	22	22	\N	2026-06-18 20:40:42.095124	2026-06-19 15:10:59.000135	\N	f	f	t	49
12	1	1	5	uno			19	1	\N	22	22	22	2026-06-19 20:50:08.244972	2026-06-19 21:12:51.650236	2026-06-19 16:19:32.999259	t	f	t	50
12	3	1	5	dos		D	19	1	\N	22	22	\N	2026-06-19 20:54:24.245198	2026-06-19 21:38:21.102587	\N	f	f	t	51
12	5	1	5	3333		3323	19	1	\N	22	\N	22	2026-06-19 21:38:17.386265	\N	2026-06-19 16:38:38.908789	t	f	t	52
12	9	1	5	ddfweeewew			19	14	\N	22	\N	\N	2026-06-19 23:10:37.825623	\N	\N	f	f	t	53
12	7	1	5	rwe			19	14	\N	22	22	\N	2026-06-19 23:10:31.44263	2026-06-19 23:10:52.757253	\N	f	f	t	54
12	6	1	5	tttttt		32332	19	2	\N	22	22	22	2026-06-19 21:47:38.621572	2026-06-19 23:16:19.990839	2026-06-19 18:16:26.717517	t	f	t	55
12	10	1	5	4r34r34			19	2	\N	22	22	\N	2026-06-19 23:16:30.497943	2026-06-19 23:16:54.847117	\N	f	f	t	56
12	11	1	5	4343			19	2	\N	22	22	\N	2026-06-19 23:16:36.411573	2026-06-19 23:16:56.773218	\N	f	f	t	57
12	12	1	5	344334			19	2	\N	22	22	\N	2026-06-19 23:16:41.608945	2026-06-19 23:16:58.94841	\N	f	t	t	58
19	3	1	5	323		23233	\N	\N	\N	22	\N	\N	2026-06-19 22:06:15.778013	\N	\N	f	f	t	59
19	2	1	5	44343434	23223	3232	\N	\N	\N	22	22	\N	2026-06-19 21:47:29.515319	2026-06-20 00:00:57.817496	\N	f	f	t	60
19	4	1	5	32		344	\N	\N	\N	22	\N	\N	2026-06-19 22:16:10.614149	\N	\N	f	f	t	61
19	5	1	5	r4r		43443	\N	\N	\N	22	\N	\N	2026-06-19 22:16:45.862818	\N	\N	f	f	t	62
19	6	1	5	434		43	\N	\N	\N	22	\N	\N	2026-06-19 22:17:19.713819	\N	\N	f	f	t	63
19	7	1	5	342			\N	\N	\N	22	\N	\N	2026-06-19 22:20:20.708349	\N	\N	f	f	t	64
19	8	1	5	3434			\N	\N	\N	22	22	\N	2026-06-19 22:24:05.084557	2026-06-20 00:01:00.522718	\N	f	f	t	65
19	9	1	5	rwrwer		werwe	\N	\N	\N	22	\N	\N	2026-06-19 22:25:45.210972	\N	\N	f	f	t	66
19	10	1	5	43234233			\N	\N	\N	22	\N	\N	2026-06-19 22:30:36.670229	\N	\N	f	f	t	67
19	11	1	5	6534			\N	\N	\N	22	\N	\N	2026-06-19 22:31:56.544988	\N	\N	f	f	t	68
19	12	1	5	43434			\N	\N	\N	22	\N	\N	2026-06-19 22:57:21.335022	\N	\N	f	f	t	69
19	13	1	5	e43w4			\N	\N	\N	22	\N	\N	2026-06-19 22:57:52.215158	\N	\N	f	f	t	70
19	14	1	5	fffffff			\N	\N	\N	22	22	\N	2026-06-19 23:10:28.122861	2026-06-19 23:10:58.667792	\N	f	f	t	71
12	13	1	5	3443			19	15	\N	22	\N	\N	2026-06-19 23:17:40.39558	\N	\N	f	f	t	72
3	1	1	1	344334			\N	\N	\N	22	\N	\N	2026-06-19 23:17:48.006311	\N	\N	f	f	t	73
3	2	1	1	344334			\N	\N	\N	22	\N	\N	2026-06-19 23:17:50.743963	\N	\N	f	f	t	74
3	3	1	1	rfwefewfwe		43	\N	\N	\N	22	22	\N	2026-06-19 23:17:53.450074	2026-06-19 23:17:58.205374	\N	f	f	t	75
3	4	1	1	3g3ferre			\N	\N	\N	22	\N	\N	2026-06-19 23:18:02.850627	\N	\N	f	f	t	76
12	14	1	5	4343			19	16	\N	22	\N	\N	2026-06-19 23:21:47.542874	\N	\N	f	f	t	77
12	15	1	5	43443			19	16	\N	22	\N	\N	2026-06-19 23:21:50.119032	\N	\N	f	f	t	78
19	15	1	5	343443343443			\N	\N	\N	22	\N	\N	2026-06-19 23:17:36.841936	\N	\N	f	f	t	79
19	16	1	5	r3434			\N	\N	\N	22	\N	\N	2026-06-19 23:21:44.784941	\N	\N	f	f	t	80
19	1	1	5	33333333		333	\N	\N	\N	22	22	\N	2026-06-18 23:29:12.793986	2026-06-22 14:43:16.623282	\N	f	t	t	81
\.


--
-- Data for Name: tblpersonajuridica; Type: TABLE DATA; Schema: maestro; Owner: postgres
--

COPY maestro.tblpersonajuridica (coentidad, norazonsocial, nocomercial, corubro, cousucre, cousumod, fecre, femod) FROM stdin;
1	Inkasoftwrare	\N	\N	-100	\N	2020-04-19 19:36:21.087	\N
3	Novaterra	\N	\N	-100	\N	2020-04-19 19:36:21.087	\N
2	Claro	\N	\N	-100	\N	2020-04-19 19:36:21.087	\N
\.


--
-- Data for Name: tblpersonanatural; Type: TABLE DATA; Schema: maestro; Owner: postgres
--

COPY maestro.tblpersonanatural (coentidad, nopersona, noapellidop, noapellidom, fenacimiento, cosexo, coprofesion, coestadocivil, cousucre, cousumod, fecre, femod) FROM stdin;
21	Carlos	Slim	Helu	\N	\N	\N	\N	-100	\N	2026-06-25 23:54:13.125952	\N
22	Jonatan	Abregu	Chalco	\N	\N	\N	\N	-100	\N	2026-06-25 23:54:13.125952	\N
\.


--
-- Data for Name: trfubigeo; Type: TABLE DATA; Schema: maestro; Owner: postgres
--

COPY maestro.trfubigeo (coubigeo, copais, nocodigo, nonivel1, nonivel2, nonivel3, conivel1, conivel2, conivel3) FROM stdin;
1699	137	240101	CALLAO	CALLAO	CALLAO	24	01	01
1700	137	240102	CALLAO	CALLAO	BELLAVISTA	24	01	02
1701	137	240103	CALLAO	CALLAO	LA PUNTA	24	01	03
1702	137	240104	CALLAO	CALLAO	CARMEN DE LA LEGUA-REYNOSO	24	01	04
1703	137	240105	CALLAO	CALLAO	LA PERLA	24	01	05
1704	137	240106	CALLAO	CALLAO	VENTANILLA	24	01	06
1705	137	240107	CALLAO	CALLAO	MI PERU	24	01	07
1664	137	220110	TACNA	TACNA	SAMA	22	01	10
1665	137	220111	TACNA	TACNA	ALTO DE LA ALIANZA	22	01	11
1666	137	220112	TACNA	TACNA	CIUDAD NUEVA	22	01	12
1667	137	220113	TACNA	TACNA	CORONEL GREGORIO ALBARRACIN L.	22	01	13
1668	137	220114	TACNA	TACNA	LA YARADA LOS PALOS	22	01	14
1669	137	220201	TACNA	TARATA	TARATA	22	02	01
1670	137	220205	TACNA	TARATA	HEROES ALBARRACIN	22	02	05
1793	137	920301	AMERICA	BAHAMAS, ISLAS	NASSAU	92	03	01
1794	137	920401	AMERICA	BOLIVIA	COCHABAMBA	92	04	01
1795	137	920403	AMERICA	BOLIVIA	LA PAZ	92	04	03
1796	137	920404	AMERICA	BOLIVIA	ORURO	92	04	04
1797	137	920405	AMERICA	BOLIVIA	SANTA CRUZ	92	04	05
1798	137	920406	AMERICA	BOLIVIA	BENI	92	04	06
1799	137	920407	AMERICA	BOLIVIA	PANDO	92	04	07
1800	137	920408	AMERICA	BOLIVIA	CHUQUISACA	92	04	08
1801	137	920409	AMERICA	BOLIVIA	TARIJA	92	04	09
1802	137	920410	AMERICA	BOLIVIA	POTOSI	92	04	10
1803	137	920411	AMERICA	BOLIVIA	EL ALTO	92	04	11
1804	137	920501	AMERICA	BRASIL	BELEN DO PARA	92	05	01
1805	137	920502	AMERICA	BRASIL	BELO HORIZONTE	92	05	02
1806	137	920503	AMERICA	BRASIL	BRASILIA	92	05	03
1807	137	920504	AMERICA	BRASIL	CURITIBA	92	05	04
1808	137	920505	AMERICA	BRASIL	MANAOS	92	05	05
1809	137	920506	AMERICA	BRASIL	PORTO ALEGRE	92	05	06
1	137	020804	ANCASH	HUARI	HUACACHI	02	08	04
2	137	020805	ANCASH	HUARI	HUACHIS	02	08	05
3	137	020806	ANCASH	HUARI	HUACCHIS	02	08	06
4	137	020807	ANCASH	HUARI	HUANTAR	02	08	07
5	137	020808	ANCASH	HUARI	MASIN	02	08	08
6	137	020809	ANCASH	HUARI	PAUCAS	02	08	09
7	137	020810	ANCASH	HUARI	PONTO	02	08	10
8	137	020811	ANCASH	HUARI	RAHUAPAMPA	02	08	11
9	137	020812	ANCASH	HUARI	RAPAYAN	02	08	12
10	137	020813	ANCASH	HUARI	SAN MARCOS	02	08	13
11	137	020814	ANCASH	HUARI	SAN PEDRO DE CHANA	02	08	14
12	137	020815	ANCASH	HUARI	UCO	02	08	15
13	137	020816	ANCASH	HUARI	ANRA	02	08	16
14	137	020901	ANCASH	MARISCAL LUZURIAGA	PISCOBAMBA	02	09	01
15	137	020902	ANCASH	MARISCAL LUZURIAGA	CASCA	02	09	02
16	137	020903	ANCASH	MARISCAL LUZURIAGA	LUCMA	02	09	03
17	137	020904	ANCASH	MARISCAL LUZURIAGA	FIDEL OLIVAS ESCUDERO	02	09	04
18	137	020905	ANCASH	MARISCAL LUZURIAGA	LLAMA	02	09	05
19	137	020906	ANCASH	MARISCAL LUZURIAGA	LLUMPA	02	09	06
20	137	020907	ANCASH	MARISCAL LUZURIAGA	MUSGA	02	09	07
21	137	020908	ANCASH	MARISCAL LUZURIAGA	ELEAZAR GUZMAN BARRON	02	09	08
22	137	021001	ANCASH	PALLASCA	CABANA	02	10	01
23	137	021002	ANCASH	PALLASCA	BOLOGNESI	02	10	02
24	137	021003	ANCASH	PALLASCA	CONCHUCOS	02	10	03
25	137	021004	ANCASH	PALLASCA	HUACASCHUQUE	02	10	04
26	137	021005	ANCASH	PALLASCA	HUANDOVAL	02	10	05
27	137	021006	ANCASH	PALLASCA	LACABAMBA	02	10	06
28	137	021007	ANCASH	PALLASCA	LLAPO	02	10	07
29	137	021008	ANCASH	PALLASCA	PALLASCA	02	10	08
30	137	021009	ANCASH	PALLASCA	PAMPAS	02	10	09
31	137	021010	ANCASH	PALLASCA	SANTA ROSA	02	10	10
32	137	021011	ANCASH	PALLASCA	TAUCA	02	10	11
33	137	021101	ANCASH	POMABAMBA	POMABAMBA	02	11	01
34	137	021102	ANCASH	POMABAMBA	HUAYLLAN	02	11	02
35	137	021103	ANCASH	POMABAMBA	PAROBAMBA	02	11	03
36	137	021104	ANCASH	POMABAMBA	QUINUABAMBA	02	11	04
37	137	021201	ANCASH	RECUAY	RECUAY	02	12	01
38	137	021202	ANCASH	RECUAY	COTAPARACO	02	12	02
39	137	021203	ANCASH	RECUAY	HUAYLLAPAMPA	02	12	03
40	137	021204	ANCASH	RECUAY	MARCA	02	12	04
41	137	021205	ANCASH	RECUAY	PAMPAS CHICO	02	12	05
42	137	021206	ANCASH	RECUAY	PARARIN	02	12	06
43	137	021207	ANCASH	RECUAY	TAPACOCHA	02	12	07
44	137	021208	ANCASH	RECUAY	TICAPAMPA	02	12	08
45	137	021209	ANCASH	RECUAY	LLACLLIN	02	12	09
1125	137	140103	LIMA	LIMA	ATE	14	01	03
46	137	021210	ANCASH	RECUAY	CATAC	02	12	10
47	137	021301	ANCASH	SANTA	CHIMBOTE	02	13	01
48	137	021302	ANCASH	SANTA	CACERES DEL PERU	02	13	02
49	137	021303	ANCASH	SANTA	MACATE	02	13	03
50	137	021304	ANCASH	SANTA	MORO	02	13	04
51	137	021305	ANCASH	SANTA	NEPEÑA	02	13	05
52	137	021306	ANCASH	SANTA	SAMANCO	02	13	06
53	137	021307	ANCASH	SANTA	SANTA	02	13	07
54	137	021308	ANCASH	SANTA	COISHCO	02	13	08
55	137	021309	ANCASH	SANTA	NUEVO CHIMBOTE	02	13	09
56	137	021401	ANCASH	SIHUAS	SIHUAS	02	14	01
57	137	021402	ANCASH	SIHUAS	ALFONSO UGARTE	02	14	02
58	137	021403	ANCASH	SIHUAS	CHINGALPO	02	14	03
59	137	021404	ANCASH	SIHUAS	HUAYLLABAMBA	02	14	04
60	137	021405	ANCASH	SIHUAS	QUICHES	02	14	05
61	137	021406	ANCASH	SIHUAS	SICSIBAMBA	02	14	06
62	137	021407	ANCASH	SIHUAS	ACOBAMBA	02	14	07
63	137	021408	ANCASH	SIHUAS	CASHAPAMPA	02	14	08
64	137	021409	ANCASH	SIHUAS	RAGASH	02	14	09
65	137	021410	ANCASH	SIHUAS	SAN JUAN	02	14	10
66	137	021501	ANCASH	YUNGAY	YUNGAY	02	15	01
67	137	021502	ANCASH	YUNGAY	CASCAPARA	02	15	02
68	137	021503	ANCASH	YUNGAY	MANCOS	02	15	03
69	137	021504	ANCASH	YUNGAY	MATACOTO	02	15	04
70	137	021505	ANCASH	YUNGAY	QUILLO	02	15	05
71	137	021506	ANCASH	YUNGAY	RANRAHIRCA	02	15	06
72	137	021507	ANCASH	YUNGAY	SHUPLUY	02	15	07
73	137	021508	ANCASH	YUNGAY	YANAMA	02	15	08
74	137	021601	ANCASH	ANTONIO RAIMONDI	LLAMELLIN	02	16	01
75	137	021602	ANCASH	ANTONIO RAIMONDI	ACZO	02	16	02
76	137	021603	ANCASH	ANTONIO RAIMONDI	CHACCHO	02	16	03
77	137	021604	ANCASH	ANTONIO RAIMONDI	CHINGAS	02	16	04
78	137	021605	ANCASH	ANTONIO RAIMONDI	MIRGAS	02	16	05
79	137	021606	ANCASH	ANTONIO RAIMONDI	SAN JUAN DE RONTOY	02	16	06
80	137	021701	ANCASH	CARLOS FERMIN FITZCARRALD	SAN LUIS	02	17	01
81	137	021702	ANCASH	CARLOS FERMIN FITZCARRALD	YAUYA	02	17	02
82	137	021703	ANCASH	CARLOS FERMIN FITZCARRALD	SAN NICOLAS	02	17	03
83	137	021801	ANCASH	ASUNCION	CHACAS	02	18	01
84	137	021802	ANCASH	ASUNCION	ACOCHACA	02	18	02
85	137	021901	ANCASH	HUARMEY	HUARMEY	02	19	01
86	137	021902	ANCASH	HUARMEY	COCHAPETI	02	19	02
87	137	021903	ANCASH	HUARMEY	HUAYAN	02	19	03
88	137	021904	ANCASH	HUARMEY	MALVAS	02	19	04
89	137	021905	ANCASH	HUARMEY	CULEBRAS	02	19	05
90	137	022001	ANCASH	OCROS	ACAS	02	20	01
91	137	022002	ANCASH	OCROS	CAJAMARQUILLA	02	20	02
92	137	022003	ANCASH	OCROS	CARHUAPAMPA	02	20	03
93	137	022004	ANCASH	OCROS	COCHAS	02	20	04
94	137	022005	ANCASH	OCROS	CONGAS	02	20	05
95	137	022006	ANCASH	OCROS	LLIPA	02	20	06
96	137	022007	ANCASH	OCROS	OCROS	02	20	07
97	137	022008	ANCASH	OCROS	SAN CRISTOBAL DE RAJAN	02	20	08
98	137	022009	ANCASH	OCROS	SAN PEDRO	02	20	09
99	137	022010	ANCASH	OCROS	SANTIAGO DE CHILCAS	02	20	10
100	137	030101	APURIMAC	ABANCAY	ABANCAY	03	01	01
101	137	030102	APURIMAC	ABANCAY	CIRCA	03	01	02
102	137	030103	APURIMAC	ABANCAY	CURAHUASI	03	01	03
103	137	030104	APURIMAC	ABANCAY	CHACOCHE	03	01	04
104	137	030105	APURIMAC	ABANCAY	HUANIPACA	03	01	05
105	137	030106	APURIMAC	ABANCAY	LAMBRAMA	03	01	06
106	137	030107	APURIMAC	ABANCAY	PICHIRHUA	03	01	07
107	137	030108	APURIMAC	ABANCAY	SAN PEDRO DE CACHORA	03	01	08
108	137	030109	APURIMAC	ABANCAY	TAMBURCO	03	01	09
109	137	030201	APURIMAC	AYMARAES	CHALHUANCA	03	02	01
110	137	030202	APURIMAC	AYMARAES	CAPAYA	03	02	02
111	137	030203	APURIMAC	AYMARAES	CARAYBAMBA	03	02	03
112	137	030204	APURIMAC	AYMARAES	COLCABAMBA	03	02	04
113	137	030205	APURIMAC	AYMARAES	COTARUSE	03	02	05
114	137	030206	APURIMAC	AYMARAES	CHAPIMARCA	03	02	06
115	137	030207	APURIMAC	AYMARAES	HUAYLLO	03	02	07
116	137	030208	APURIMAC	AYMARAES	LUCRE	03	02	08
117	137	030209	APURIMAC	AYMARAES	POCOHUANCA	03	02	09
118	137	030210	APURIMAC	AYMARAES	SAÑAYCA	03	02	10
119	137	030211	APURIMAC	AYMARAES	SORAYA	03	02	11
120	137	030212	APURIMAC	AYMARAES	TAPAIRIHUA	03	02	12
121	137	030213	APURIMAC	AYMARAES	TINTAY	03	02	13
122	137	030214	APURIMAC	AYMARAES	TORAYA	03	02	14
123	137	030215	APURIMAC	AYMARAES	YANACA	03	02	15
124	137	030216	APURIMAC	AYMARAES	SAN JUAN DE CHACÑA	03	02	16
125	137	030217	APURIMAC	AYMARAES	JUSTO APU SAHUARAURA	03	02	17
126	137	030301	APURIMAC	ANDAHUAYLAS	ANDAHUAYLAS	03	03	01
127	137	030302	APURIMAC	ANDAHUAYLAS	ANDARAPA	03	03	02
128	137	030303	APURIMAC	ANDAHUAYLAS	CHIARA	03	03	03
129	137	030304	APURIMAC	ANDAHUAYLAS	HUANCARAMA	03	03	04
130	137	030305	APURIMAC	ANDAHUAYLAS	HUANCARAY	03	03	05
131	137	030306	APURIMAC	ANDAHUAYLAS	KISHUARA	03	03	06
132	137	030307	APURIMAC	ANDAHUAYLAS	PACOBAMBA	03	03	07
133	137	030308	APURIMAC	ANDAHUAYLAS	PAMPACHIRI	03	03	08
134	137	030309	APURIMAC	ANDAHUAYLAS	SAN ANTONIO DE CACHI	03	03	09
135	137	030310	APURIMAC	ANDAHUAYLAS	SAN JERONIMO	03	03	10
136	137	030311	APURIMAC	ANDAHUAYLAS	TALAVERA	03	03	11
137	137	030312	APURIMAC	ANDAHUAYLAS	TURPO	03	03	12
138	137	030313	APURIMAC	ANDAHUAYLAS	PACUCHA	03	03	13
139	137	030314	APURIMAC	ANDAHUAYLAS	POMACOCHA	03	03	14
140	137	030315	APURIMAC	ANDAHUAYLAS	SANTA MARIA DE CHICMO	03	03	15
141	137	030316	APURIMAC	ANDAHUAYLAS	TUMAY HUARACA	03	03	16
142	137	030317	APURIMAC	ANDAHUAYLAS	HUAYANA	03	03	17
143	137	030318	APURIMAC	ANDAHUAYLAS	SAN MIGUEL DE CHACCRAMPA	03	03	18
144	137	030319	APURIMAC	ANDAHUAYLAS	KAQUIABAMBA	03	03	19
145	137	030320	APURIMAC	ANDAHUAYLAS	JOSE MARIA ARGUEDAS	03	03	20
146	137	030401	APURIMAC	ANTABAMBA	ANTABAMBA	03	04	01
147	137	030402	APURIMAC	ANTABAMBA	EL ORO	03	04	02
148	137	030403	APURIMAC	ANTABAMBA	HUAQUIRCA	03	04	03
149	137	030404	APURIMAC	ANTABAMBA	JUAN ESPINOZA MEDRANO	03	04	04
150	137	030405	APURIMAC	ANTABAMBA	OROPESA	03	04	05
151	137	030406	APURIMAC	ANTABAMBA	PACHACONAS	03	04	06
152	137	050113	AYACUCHO	HUAMANGA	OCROS	05	01	13
153	137	050114	AYACUCHO	HUAMANGA	PACAYCASA	05	01	14
154	137	050115	AYACUCHO	HUAMANGA	JESUS NAZARENO	05	01	15
155	137	050116	AYACUCHO	HUAMANGA	ANDRES AVELINO CACERES D.	05	01	16
156	137	050201	AYACUCHO	CANGALLO	CANGALLO	05	02	01
157	137	050204	AYACUCHO	CANGALLO	CHUSCHI	05	02	04
158	137	050206	AYACUCHO	CANGALLO	LOS MOROCHUCOS	05	02	06
159	137	050207	AYACUCHO	CANGALLO	PARAS	05	02	07
160	137	050208	AYACUCHO	CANGALLO	TOTOS	05	02	08
161	137	050211	AYACUCHO	CANGALLO	MARIA PARADO DE BELLIDO	05	02	11
162	137	050301	AYACUCHO	HUANTA	HUANTA	05	03	01
163	137	050302	AYACUCHO	HUANTA	AYAHUANCO	05	03	02
164	137	050303	AYACUCHO	HUANTA	HUAMANGUILLA	05	03	03
165	137	050304	AYACUCHO	HUANTA	IGUAIN	05	03	04
166	137	050305	AYACUCHO	HUANTA	LURICOCHA	05	03	05
167	137	050307	AYACUCHO	HUANTA	SANTILLANA	05	03	07
168	137	050308	AYACUCHO	HUANTA	SIVIA	05	03	08
169	137	050309	AYACUCHO	HUANTA	LLOCHEGUA	05	03	09
170	137	050310	AYACUCHO	HUANTA	CANAYRE	05	03	10
171	137	050311	AYACUCHO	HUANTA	UCHURACCAY	05	03	11
172	137	050312	AYACUCHO	HUANTA	PUCACOLPA	05	03	12
173	137	050401	AYACUCHO	LA MAR	SAN MIGUEL	05	04	01
174	137	050402	AYACUCHO	LA MAR	ANCO	05	04	02
175	137	050403	AYACUCHO	LA MAR	AYNA	05	04	03
176	137	050404	AYACUCHO	LA MAR	CHILCAS	05	04	04
177	137	050405	AYACUCHO	LA MAR	CHUNGUI	05	04	05
178	137	050406	AYACUCHO	LA MAR	TAMBO	05	04	06
179	137	050407	AYACUCHO	LA MAR	LUIS CARRANZA	05	04	07
180	137	050408	AYACUCHO	LA MAR	SANTA ROSA	05	04	08
181	137	050409	AYACUCHO	LA MAR	SAMUGARI	05	04	09
182	137	050410	AYACUCHO	LA MAR	ANCHIHUAY	05	04	10
183	137	050501	AYACUCHO	LUCANAS	PUQUIO	05	05	01
184	137	050502	AYACUCHO	LUCANAS	AUCARA	05	05	02
185	137	050503	AYACUCHO	LUCANAS	CABANA	05	05	03
186	137	050504	AYACUCHO	LUCANAS	CARMEN SALCEDO	05	05	04
187	137	050506	AYACUCHO	LUCANAS	CHAVIÑA	05	05	06
188	137	050508	AYACUCHO	LUCANAS	CHIPAO	05	05	08
189	137	050510	AYACUCHO	LUCANAS	HUAC-HUAS	05	05	10
190	137	050511	AYACUCHO	LUCANAS	LARAMATE	05	05	11
191	137	050512	AYACUCHO	LUCANAS	LEONCIO PRADO	05	05	12
192	137	050513	AYACUCHO	LUCANAS	LUCANAS	05	05	13
193	137	050514	AYACUCHO	LUCANAS	LLAUTA	05	05	14
194	137	050516	AYACUCHO	LUCANAS	OCAÑA	05	05	16
195	137	050517	AYACUCHO	LUCANAS	OTOCA	05	05	17
196	137	050520	AYACUCHO	LUCANAS	SANCOS	05	05	20
197	137	050521	AYACUCHO	LUCANAS	SAN JUAN	05	05	21
198	137	050522	AYACUCHO	LUCANAS	SAN PEDRO	05	05	22
199	137	050524	AYACUCHO	LUCANAS	SANTA ANA DE HUAYCAHUACHO	05	05	24
200	137	050525	AYACUCHO	LUCANAS	SANTA LUCIA	05	05	25
201	137	050529	AYACUCHO	LUCANAS	SAISA	05	05	29
202	137	050531	AYACUCHO	LUCANAS	SAN PEDRO DE PALCO	05	05	31
203	137	050532	AYACUCHO	LUCANAS	SAN CRISTOBAL	05	05	32
204	137	050601	AYACUCHO	PARINACOCHAS	CORACORA	05	06	01
205	137	050604	AYACUCHO	PARINACOCHAS	CORONEL CASTAÑEDA	05	06	04
206	137	050605	AYACUCHO	PARINACOCHAS	CHUMPI	05	06	05
207	137	050608	AYACUCHO	PARINACOCHAS	PACAPAUSA	05	06	08
208	137	050611	AYACUCHO	PARINACOCHAS	PULLO	05	06	11
209	137	050612	AYACUCHO	PARINACOCHAS	PUYUSCA	05	06	12
210	137	050615	AYACUCHO	PARINACOCHAS	SAN FRANCISCO DE RAVACAYCO	05	06	15
211	137	050616	AYACUCHO	PARINACOCHAS	UPAHUACHO	05	06	16
212	137	050701	AYACUCHO	VICTOR FAJARDO	HUANCAPI	05	07	01
213	137	050702	AYACUCHO	VICTOR FAJARDO	ALCAMENCA	05	07	02
214	137	050703	AYACUCHO	VICTOR FAJARDO	APONGO	05	07	03
215	137	050704	AYACUCHO	VICTOR FAJARDO	CANARIA	05	07	04
216	137	050706	AYACUCHO	VICTOR FAJARDO	CAYARA	05	07	06
217	137	050707	AYACUCHO	VICTOR FAJARDO	COLCA	05	07	07
218	137	050708	AYACUCHO	VICTOR FAJARDO	HUALLA	05	07	08
219	137	050709	AYACUCHO	VICTOR FAJARDO	HUAMANQUIQUIA	05	07	09
545	137	070202	CUSCO	ACOMAYO	ACOPIA	07	02	02
220	137	050710	AYACUCHO	VICTOR FAJARDO	HUANCARAYLLA	05	07	10
221	137	050713	AYACUCHO	VICTOR FAJARDO	SARHUA	05	07	13
222	137	050714	AYACUCHO	VICTOR FAJARDO	VILCANCHOS	05	07	14
223	137	050715	AYACUCHO	VICTOR FAJARDO	ASQUIPATA	05	07	15
224	137	050801	AYACUCHO	HUANCA SANCOS	SANCOS	05	08	01
225	137	050802	AYACUCHO	HUANCA SANCOS	SACSAMARCA	05	08	02
226	137	050803	AYACUCHO	HUANCA SANCOS	SANTIAGO DE LUCANAMARCA	05	08	03
227	137	050804	AYACUCHO	HUANCA SANCOS	CARAPO	05	08	04
228	137	050901	AYACUCHO	VILCAS HUAMAN	VILCAS HUAMAN	05	09	01
229	137	050902	AYACUCHO	VILCAS HUAMAN	VISCHONGO	05	09	02
230	137	050903	AYACUCHO	VILCAS HUAMAN	ACCOMARCA	05	09	03
231	137	050904	AYACUCHO	VILCAS HUAMAN	CARHUANCA	05	09	04
232	137	050905	AYACUCHO	VILCAS HUAMAN	CONCEPCION	05	09	05
233	137	050906	AYACUCHO	VILCAS HUAMAN	HUAMBALPA	05	09	06
234	137	050907	AYACUCHO	VILCAS HUAMAN	SAURAMA	05	09	07
235	137	050908	AYACUCHO	VILCAS HUAMAN	INDEPENDENCIA	05	09	08
236	137	051001	AYACUCHO	PAUCAR DEL SARA SARA	PAUSA	05	10	01
237	137	051002	AYACUCHO	PAUCAR DEL SARA SARA	COLTA	05	10	02
1124	137	140102	LIMA	LIMA	ANCON	14	01	02
238	137	051003	AYACUCHO	PAUCAR DEL SARA SARA	CORCULLA	05	10	03
239	137	051004	AYACUCHO	PAUCAR DEL SARA SARA	LAMPA	05	10	04
240	137	051005	AYACUCHO	PAUCAR DEL SARA SARA	MARCABAMBA	05	10	05
241	137	051006	AYACUCHO	PAUCAR DEL SARA SARA	OYOLO	05	10	06
242	137	051007	AYACUCHO	PAUCAR DEL SARA SARA	PARARCA	05	10	07
243	137	051008	AYACUCHO	PAUCAR DEL SARA SARA	SAN JAVIER DE ALPABAMBA	05	10	08
244	137	051009	AYACUCHO	PAUCAR DEL SARA SARA	SAN JOSE DE USHUA	05	10	09
245	137	051010	AYACUCHO	PAUCAR DEL SARA SARA	SARA SARA	05	10	10
246	137	051101	AYACUCHO	SUCRE	QUEROBAMBA	05	11	01
247	137	051102	AYACUCHO	SUCRE	BELEN	05	11	02
248	137	051103	AYACUCHO	SUCRE	CHALCOS	05	11	03
249	137	051104	AYACUCHO	SUCRE	SAN SALVADOR DE QUIJE	05	11	04
250	137	051105	AYACUCHO	SUCRE	PAICO	05	11	05
251	137	051106	AYACUCHO	SUCRE	SANTIAGO DE PAUCARAY	05	11	06
252	137	051107	AYACUCHO	SUCRE	SAN PEDRO DE LARCAY	05	11	07
253	137	051108	AYACUCHO	SUCRE	SORAS	05	11	08
254	137	051109	AYACUCHO	SUCRE	HUACAÑA	05	11	09
255	137	051110	AYACUCHO	SUCRE	CHILCAYOC	05	11	10
256	137	051111	AYACUCHO	SUCRE	MORCOLLA	05	11	11
257	137	060101	CAJAMARCA	CAJAMARCA	CAJAMARCA	06	01	01
258	137	060102	CAJAMARCA	CAJAMARCA	ASUNCION	06	01	02
259	137	060103	CAJAMARCA	CAJAMARCA	COSPAN	06	01	03
260	137	060104	CAJAMARCA	CAJAMARCA	CHETILLA	06	01	04
261	137	060105	CAJAMARCA	CAJAMARCA	ENCAÑADA	06	01	05
262	137	060106	CAJAMARCA	CAJAMARCA	JESUS	06	01	06
263	137	060107	CAJAMARCA	CAJAMARCA	LOS BAÑOS DEL INCA	06	01	07
264	137	060108	CAJAMARCA	CAJAMARCA	LLACANORA	06	01	08
265	137	060109	CAJAMARCA	CAJAMARCA	MAGDALENA	06	01	09
266	137	060110	CAJAMARCA	CAJAMARCA	MATARA	06	01	10
267	137	060111	CAJAMARCA	CAJAMARCA	NAMORA	06	01	11
268	137	060112	CAJAMARCA	CAJAMARCA	SAN JUAN	06	01	12
269	137	060201	CAJAMARCA	CAJABAMBA	CAJABAMBA	06	02	01
270	137	060202	CAJAMARCA	CAJABAMBA	CACHACHI	06	02	02
271	137	060203	CAJAMARCA	CAJABAMBA	CONDEBAMBA	06	02	03
272	137	060205	CAJAMARCA	CAJABAMBA	SITACOCHA	06	02	05
273	137	060301	CAJAMARCA	CELENDIN	CELENDIN	06	03	01
274	137	060302	CAJAMARCA	CELENDIN	CORTEGANA	06	03	02
275	137	060303	CAJAMARCA	CELENDIN	CHUMUCH	06	03	03
276	137	060304	CAJAMARCA	CELENDIN	HUASMIN	06	03	04
277	137	060305	CAJAMARCA	CELENDIN	JORGE CHAVEZ	06	03	05
278	137	060306	CAJAMARCA	CELENDIN	JOSE GALVEZ	06	03	06
279	137	060307	CAJAMARCA	CELENDIN	MIGUEL IGLESIAS	06	03	07
280	137	060308	CAJAMARCA	CELENDIN	OXAMARCA	06	03	08
281	137	060309	CAJAMARCA	CELENDIN	SOROCHUCO	06	03	09
282	137	060310	CAJAMARCA	CELENDIN	SUCRE	06	03	10
283	137	060311	CAJAMARCA	CELENDIN	UTCO	06	03	11
284	137	060312	CAJAMARCA	CELENDIN	LA LIBERTAD DE PALLAN	06	03	12
285	137	060401	CAJAMARCA	CONTUMAZA	CONTUMAZA	06	04	01
286	137	060403	CAJAMARCA	CONTUMAZA	CHILETE	06	04	03
287	137	060404	CAJAMARCA	CONTUMAZA	GUZMANGO	06	04	04
288	137	060405	CAJAMARCA	CONTUMAZA	SAN BENITO	06	04	05
289	137	060406	CAJAMARCA	CONTUMAZA	CUPISNIQUE	06	04	06
290	137	060407	CAJAMARCA	CONTUMAZA	TANTARICA	06	04	07
291	137	060408	CAJAMARCA	CONTUMAZA	YONAN	06	04	08
292	137	010101	AMAZONAS	CHACHAPOYAS	CHACHAPOYAS	01	01	01
293	137	010102	AMAZONAS	CHACHAPOYAS	ASUNCION	01	01	02
294	137	010103	AMAZONAS	CHACHAPOYAS	BALSAS	01	01	03
295	137	010104	AMAZONAS	CHACHAPOYAS	CHETO	01	01	04
296	137	010105	AMAZONAS	CHACHAPOYAS	CHILIQUIN	01	01	05
297	137	010106	AMAZONAS	CHACHAPOYAS	CHUQUIBAMBA	01	01	06
298	137	010107	AMAZONAS	CHACHAPOYAS	GRANADA	01	01	07
299	137	010108	AMAZONAS	CHACHAPOYAS	HUANCAS	01	01	08
300	137	010109	AMAZONAS	CHACHAPOYAS	LA JALCA	01	01	09
301	137	010110	AMAZONAS	CHACHAPOYAS	LEIMEBAMBA	01	01	10
302	137	010111	AMAZONAS	CHACHAPOYAS	LEVANTO	01	01	11
303	137	010112	AMAZONAS	CHACHAPOYAS	MAGDALENA	01	01	12
304	137	010113	AMAZONAS	CHACHAPOYAS	MARISCAL CASTILLA	01	01	13
305	137	010114	AMAZONAS	CHACHAPOYAS	MOLINOPAMPA	01	01	14
306	137	010115	AMAZONAS	CHACHAPOYAS	MONTEVIDEO	01	01	15
307	137	010116	AMAZONAS	CHACHAPOYAS	OLLEROS	01	01	16
308	137	010117	AMAZONAS	CHACHAPOYAS	QUINJALCA	01	01	17
309	137	010118	AMAZONAS	CHACHAPOYAS	SAN FRANCISCO DE DAGUAS	01	01	18
310	137	010119	AMAZONAS	CHACHAPOYAS	SAN ISIDRO DE MAINO	01	01	19
311	137	010120	AMAZONAS	CHACHAPOYAS	SOLOCO	01	01	20
312	137	010121	AMAZONAS	CHACHAPOYAS	SONCHE	01	01	21
313	137	010201	AMAZONAS	BAGUA	LA PECA	01	02	01
314	137	010202	AMAZONAS	BAGUA	ARAMANGO	01	02	02
315	137	010203	AMAZONAS	BAGUA	COPALLIN	01	02	03
316	137	010204	AMAZONAS	BAGUA	EL PARCO	01	02	04
317	137	010205	AMAZONAS	BAGUA	BAGUA	01	02	05
318	137	010206	AMAZONAS	BAGUA	IMAZA	01	02	06
319	137	010301	AMAZONAS	BONGARA	JUMBILLA	01	03	01
320	137	010302	AMAZONAS	BONGARA	COROSHA	01	03	02
321	137	010303	AMAZONAS	BONGARA	CUISPES	01	03	03
322	137	010304	AMAZONAS	BONGARA	CHISQUILLA	01	03	04
323	137	010305	AMAZONAS	BONGARA	CHURUJA	01	03	05
324	137	010306	AMAZONAS	BONGARA	FLORIDA	01	03	06
325	137	010307	AMAZONAS	BONGARA	RECTA	01	03	07
326	137	010308	AMAZONAS	BONGARA	SAN CARLOS	01	03	08
327	137	010309	AMAZONAS	BONGARA	SHIPASBAMBA	01	03	09
328	137	010310	AMAZONAS	BONGARA	VALERA	01	03	10
329	137	010311	AMAZONAS	BONGARA	YAMBRASBAMBA	01	03	11
330	137	010312	AMAZONAS	BONGARA	JAZAN	01	03	12
331	137	010401	AMAZONAS	LUYA	LAMUD	01	04	01
332	137	010402	AMAZONAS	LUYA	CAMPORREDONDO	01	04	02
333	137	010403	AMAZONAS	LUYA	COCABAMBA	01	04	03
334	137	010404	AMAZONAS	LUYA	COLCAMAR	01	04	04
335	137	010405	AMAZONAS	LUYA	CONILA	01	04	05
336	137	010406	AMAZONAS	LUYA	INGUILPATA	01	04	06
337	137	010407	AMAZONAS	LUYA	LONGUITA	01	04	07
338	137	010408	AMAZONAS	LUYA	LONYA CHICO	01	04	08
339	137	010409	AMAZONAS	LUYA	LUYA	01	04	09
340	137	010410	AMAZONAS	LUYA	LUYA VIEJO	01	04	10
341	137	010411	AMAZONAS	LUYA	MARIA	01	04	11
342	137	010412	AMAZONAS	LUYA	OCALLI	01	04	12
343	137	010413	AMAZONAS	LUYA	OCUMAL	01	04	13
344	137	010414	AMAZONAS	LUYA	PISUQUIA	01	04	14
345	137	010415	AMAZONAS	LUYA	SAN CRISTOBAL	01	04	15
346	137	010416	AMAZONAS	LUYA	SAN FRANCISCO DE YESO	01	04	16
347	137	010417	AMAZONAS	LUYA	SAN JERONIMO	01	04	17
348	137	010418	AMAZONAS	LUYA	SAN JUAN DE LOPECANCHA	01	04	18
349	137	010419	AMAZONAS	LUYA	SANTA CATALINA	01	04	19
350	137	010420	AMAZONAS	LUYA	SANTO TOMAS	01	04	20
351	137	010421	AMAZONAS	LUYA	TINGO	01	04	21
352	137	010422	AMAZONAS	LUYA	TRITA	01	04	22
353	137	010423	AMAZONAS	LUYA	PROVIDENCIA	01	04	23
354	137	010501	AMAZONAS	RODRIGUEZ DE MENDOZA	SAN NICOLAS	01	05	01
355	137	010502	AMAZONAS	RODRIGUEZ DE MENDOZA	COCHAMAL	01	05	02
356	137	010503	AMAZONAS	RODRIGUEZ DE MENDOZA	CHIRIMOTO	01	05	03
357	137	010504	AMAZONAS	RODRIGUEZ DE MENDOZA	HUAMBO	01	05	04
358	137	010505	AMAZONAS	RODRIGUEZ DE MENDOZA	LIMABAMBA	01	05	05
359	137	010506	AMAZONAS	RODRIGUEZ DE MENDOZA	LONGAR	01	05	06
360	137	010507	AMAZONAS	RODRIGUEZ DE MENDOZA	MILPUCC	01	05	07
361	137	010508	AMAZONAS	RODRIGUEZ DE MENDOZA	MARISCAL BENAVIDES	01	05	08
362	137	010509	AMAZONAS	RODRIGUEZ DE MENDOZA	OMIA	01	05	09
363	137	010510	AMAZONAS	RODRIGUEZ DE MENDOZA	SANTA ROSA	01	05	10
364	137	010511	AMAZONAS	RODRIGUEZ DE MENDOZA	TOTORA	01	05	11
365	137	010512	AMAZONAS	RODRIGUEZ DE MENDOZA	VISTA ALEGRE	01	05	12
366	137	010601	AMAZONAS	CONDORCANQUI	NIEVA	01	06	01
367	137	010602	AMAZONAS	CONDORCANQUI	RIO SANTIAGO	01	06	02
368	137	010603	AMAZONAS	CONDORCANQUI	EL CENEPA	01	06	03
369	137	010701	AMAZONAS	UTCUBAMBA	BAGUA GRANDE	01	07	01
370	137	010702	AMAZONAS	UTCUBAMBA	CAJARURO	01	07	02
371	137	010703	AMAZONAS	UTCUBAMBA	CUMBA	01	07	03
372	137	010704	AMAZONAS	UTCUBAMBA	EL MILAGRO	01	07	04
373	137	010705	AMAZONAS	UTCUBAMBA	JAMALCA	01	07	05
374	137	010706	AMAZONAS	UTCUBAMBA	LONYA GRANDE	01	07	06
375	137	010707	AMAZONAS	UTCUBAMBA	YAMON	01	07	07
376	137	020101	ANCASH	HUARAZ	HUARAZ	02	01	01
377	137	020102	ANCASH	HUARAZ	INDEPENDENCIA	02	01	02
378	137	020103	ANCASH	HUARAZ	COCHABAMBA	02	01	03
379	137	020104	ANCASH	HUARAZ	COLCABAMBA	02	01	04
380	137	020105	ANCASH	HUARAZ	HUANCHAY	02	01	05
381	137	020106	ANCASH	HUARAZ	JANGAS	02	01	06
382	137	020107	ANCASH	HUARAZ	LA LIBERTAD	02	01	07
383	137	020108	ANCASH	HUARAZ	OLLEROS	02	01	08
384	137	020109	ANCASH	HUARAZ	PAMPAS GRANDE	02	01	09
385	137	020110	ANCASH	HUARAZ	PARIACOTO	02	01	10
386	137	020111	ANCASH	HUARAZ	PIRA	02	01	11
387	137	020112	ANCASH	HUARAZ	TARICA	02	01	12
388	137	020201	ANCASH	AIJA	AIJA	02	02	01
389	137	020203	ANCASH	AIJA	CORIS	02	02	03
390	137	020205	ANCASH	AIJA	HUACLLAN	02	02	05
391	137	020206	ANCASH	AIJA	LA MERCED	02	02	06
392	137	020208	ANCASH	AIJA	SUCCHA	02	02	08
393	137	020301	ANCASH	BOLOGNESI	CHIQUIAN	02	03	01
394	137	020302	ANCASH	BOLOGNESI	ABELARDO PARDO LEZAMETA	02	03	02
395	137	020304	ANCASH	BOLOGNESI	AQUIA	02	03	04
396	137	020305	ANCASH	BOLOGNESI	CAJACAY	02	03	05
397	137	020310	ANCASH	BOLOGNESI	HUAYLLACAYAN	02	03	10
398	137	020311	ANCASH	BOLOGNESI	HUASTA	02	03	11
399	137	020313	ANCASH	BOLOGNESI	MANGAS	02	03	13
400	137	020315	ANCASH	BOLOGNESI	PACLLON	02	03	15
401	137	020317	ANCASH	BOLOGNESI	SAN MIGUEL DE CORPANQUI	02	03	17
402	137	020320	ANCASH	BOLOGNESI	TICLLOS	02	03	20
403	137	020321	ANCASH	BOLOGNESI	ANTONIO RAIMONDI	02	03	21
404	137	020322	ANCASH	BOLOGNESI	CANIS	02	03	22
405	137	020323	ANCASH	BOLOGNESI	COLQUIOC	02	03	23
406	137	020324	ANCASH	BOLOGNESI	LA PRIMAVERA	02	03	24
407	137	020325	ANCASH	BOLOGNESI	HUALLANCA	02	03	25
408	137	020401	ANCASH	CARHUAZ	CARHUAZ	02	04	01
409	137	020402	ANCASH	CARHUAZ	ACOPAMPA	02	04	02
410	137	020403	ANCASH	CARHUAZ	AMASHCA	02	04	03
411	137	020404	ANCASH	CARHUAZ	ANTA	02	04	04
412	137	020405	ANCASH	CARHUAZ	ATAQUERO	02	04	05
413	137	020406	ANCASH	CARHUAZ	MARCARA	02	04	06
414	137	020407	ANCASH	CARHUAZ	PARIAHUANCA	02	04	07
415	137	020408	ANCASH	CARHUAZ	SAN MIGUEL DE ACO	02	04	08
416	137	020409	ANCASH	CARHUAZ	SHILLA	02	04	09
417	137	020410	ANCASH	CARHUAZ	TINCO	02	04	10
418	137	020411	ANCASH	CARHUAZ	YUNGAR	02	04	11
419	137	020501	ANCASH	CASMA	CASMA	02	05	01
420	137	020502	ANCASH	CASMA	BUENA VISTA ALTA	02	05	02
421	137	020503	ANCASH	CASMA	COMANDANTE NOEL	02	05	03
422	137	020505	ANCASH	CASMA	YAUTAN	02	05	05
423	137	020601	ANCASH	CORONGO	CORONGO	02	06	01
424	137	020602	ANCASH	CORONGO	ACO	02	06	02
425	137	020603	ANCASH	CORONGO	BAMBAS	02	06	03
426	137	020604	ANCASH	CORONGO	CUSCA	02	06	04
427	137	020605	ANCASH	CORONGO	LA PAMPA	02	06	05
428	137	020606	ANCASH	CORONGO	YANAC	02	06	06
429	137	020607	ANCASH	CORONGO	YUPAN	02	06	07
430	137	020701	ANCASH	HUAYLAS	CARAZ	02	07	01
431	137	020702	ANCASH	HUAYLAS	HUALLANCA	02	07	02
432	137	020703	ANCASH	HUAYLAS	HUATA	02	07	03
433	137	020704	ANCASH	HUAYLAS	HUAYLAS	02	07	04
434	137	020705	ANCASH	HUAYLAS	MATO	02	07	05
435	137	020706	ANCASH	HUAYLAS	PAMPAROMAS	02	07	06
436	137	020707	ANCASH	HUAYLAS	PUEBLO LIBRE	02	07	07
546	137	070203	CUSCO	ACOMAYO	ACOS	07	02	03
437	137	020708	ANCASH	HUAYLAS	SANTA CRUZ	02	07	08
438	137	020709	ANCASH	HUAYLAS	YURACMARCA	02	07	09
439	137	020710	ANCASH	HUAYLAS	SANTO TORIBIO	02	07	10
440	137	020801	ANCASH	HUARI	HUARI	02	08	01
441	137	020802	ANCASH	HUARI	CAJAY	02	08	02
442	137	020803	ANCASH	HUARI	CHAVIN DE HUANTAR	02	08	03
443	137	120609	LA LIBERTAD	PATAZ	PATAZ	12	06	09
444	137	060409	CAJAMARCA	CONTUMAZA	SANTA CRUZ DE TOLED	06	04	09
445	137	060501	CAJAMARCA	CUTERVO	CUTERVO	06	05	01
446	137	060502	CAJAMARCA	CUTERVO	CALLAYUC	06	05	02
447	137	060503	CAJAMARCA	CUTERVO	CUJILLO	06	05	03
448	137	060504	CAJAMARCA	CUTERVO	CHOROS	06	05	04
449	137	060505	CAJAMARCA	CUTERVO	LA RAMADA	06	05	05
450	137	060506	CAJAMARCA	CUTERVO	PIMPINGOS	06	05	06
451	137	060507	CAJAMARCA	CUTERVO	QUEROCOTILLO	06	05	07
452	137	060508	CAJAMARCA	CUTERVO	SAN ANDRES DE CUTERVO	06	05	08
453	137	060509	CAJAMARCA	CUTERVO	SAN JUAN DE CUTERVO	06	05	09
454	137	060510	CAJAMARCA	CUTERVO	SAN LUIS DE LUCMA	06	05	10
455	137	060511	CAJAMARCA	CUTERVO	SANTA CRUZ	06	05	11
456	137	060512	CAJAMARCA	CUTERVO	SANTO DOMINGO DE LA CAPILLA	06	05	12
457	137	060513	CAJAMARCA	CUTERVO	SANTO TOMAS	06	05	13
458	137	060514	CAJAMARCA	CUTERVO	SOCOTA	06	05	14
459	137	060515	CAJAMARCA	CUTERVO	TORIBIO CASANOVA	06	05	15
460	137	060601	CAJAMARCA	CHOTA	CHOTA	06	06	01
461	137	060602	CAJAMARCA	CHOTA	ANGUIA	06	06	02
462	137	060603	CAJAMARCA	CHOTA	COCHABAMBA	06	06	03
463	137	060604	CAJAMARCA	CHOTA	CONCHAN	06	06	04
464	137	060605	CAJAMARCA	CHOTA	CHADIN	06	06	05
465	137	060606	CAJAMARCA	CHOTA	CHIGUIRIP	06	06	06
466	137	060607	CAJAMARCA	CHOTA	CHIMBAN	06	06	07
467	137	060608	CAJAMARCA	CHOTA	HUAMBOS	06	06	08
468	137	060609	CAJAMARCA	CHOTA	LAJAS	06	06	09
469	137	060610	CAJAMARCA	CHOTA	LLAMA	06	06	10
470	137	060611	CAJAMARCA	CHOTA	MIRACOSTA	06	06	11
471	137	060612	CAJAMARCA	CHOTA	PACCHA	06	06	12
472	137	060613	CAJAMARCA	CHOTA	PION	06	06	13
473	137	060614	CAJAMARCA	CHOTA	QUEROCOTO	06	06	14
474	137	060615	CAJAMARCA	CHOTA	TACABAMBA	06	06	15
475	137	060616	CAJAMARCA	CHOTA	TOCMOCHE	06	06	16
476	137	060617	CAJAMARCA	CHOTA	SAN JUAN DE LICUPIS	06	06	17
477	137	060618	CAJAMARCA	CHOTA	CHOROPAMPA	06	06	18
478	137	060619	CAJAMARCA	CHOTA	CHALAMARCA	06	06	19
479	137	060701	CAJAMARCA	HUALGAYOC	BAMBAMARCA	06	07	01
480	137	060702	CAJAMARCA	HUALGAYOC	CHUGUR	06	07	02
481	137	060703	CAJAMARCA	HUALGAYOC	HUALGAYOC	06	07	03
482	137	060801	CAJAMARCA	JAEN	JAEN	06	08	01
483	137	060802	CAJAMARCA	JAEN	BELLAVISTA	06	08	02
484	137	060803	CAJAMARCA	JAEN	COLASAY	06	08	03
485	137	060804	CAJAMARCA	JAEN	CHONTALI	06	08	04
486	137	060805	CAJAMARCA	JAEN	POMAHUACA	06	08	05
487	137	060806	CAJAMARCA	JAEN	PUCARA	06	08	06
488	137	060807	CAJAMARCA	JAEN	SALLIQUE	06	08	07
489	137	060808	CAJAMARCA	JAEN	SAN FELIPE	06	08	08
490	137	060809	CAJAMARCA	JAEN	SAN JOSE DEL ALTO	06	08	09
491	137	060810	CAJAMARCA	JAEN	SANTA ROSA	06	08	10
492	137	060811	CAJAMARCA	JAEN	LAS PIRIAS	06	08	11
493	137	060812	CAJAMARCA	JAEN	HUABAL	06	08	12
494	137	060901	CAJAMARCA	SANTA CRUZ	SANTA CRUZ	06	09	01
495	137	060902	CAJAMARCA	SANTA CRUZ	CATACHE	06	09	02
496	137	060903	CAJAMARCA	SANTA CRUZ	CHANCAYBAÑOS	06	09	03
497	137	060904	CAJAMARCA	SANTA CRUZ	LA ESPERANZA	06	09	04
498	137	060905	CAJAMARCA	SANTA CRUZ	NINABAMBA	06	09	05
499	137	060906	CAJAMARCA	SANTA CRUZ	PULAN	06	09	06
500	137	060907	CAJAMARCA	SANTA CRUZ	SEXI	06	09	07
501	137	060908	CAJAMARCA	SANTA CRUZ	UTICYACU	06	09	08
502	137	060909	CAJAMARCA	SANTA CRUZ	YAUYUCAN	06	09	09
503	137	060910	CAJAMARCA	SANTA CRUZ	ANDABAMBA	06	09	10
504	137	060911	CAJAMARCA	SANTA CRUZ	SAUCEPAMPA	06	09	11
505	137	061001	CAJAMARCA	SAN MIGUEL	SAN MIGUEL	06	10	01
506	137	061002	CAJAMARCA	SAN MIGUEL	CALQUIS	06	10	02
507	137	061003	CAJAMARCA	SAN MIGUEL	LA FLORIDA	06	10	03
508	137	061004	CAJAMARCA	SAN MIGUEL	LLAPA	06	10	04
509	137	061005	CAJAMARCA	SAN MIGUEL	NANCHOC	06	10	05
510	137	061006	CAJAMARCA	SAN MIGUEL	NIEPOS	06	10	06
511	137	061007	CAJAMARCA	SAN MIGUEL	SAN GREGORIO	06	10	07
512	137	061008	CAJAMARCA	SAN MIGUEL	SAN SILVESTRE DE COCHAN	06	10	08
513	137	061009	CAJAMARCA	SAN MIGUEL	EL PRADO	06	10	09
514	137	061010	CAJAMARCA	SAN MIGUEL	UNION AGUA BLANCA	06	10	10
515	137	061011	CAJAMARCA	SAN MIGUEL	TONGOD	06	10	11
516	137	061012	CAJAMARCA	SAN MIGUEL	CATILLUC	06	10	12
517	137	061013	CAJAMARCA	SAN MIGUEL	BOLIVAR	06	10	13
518	137	061101	CAJAMARCA	SAN IGNACIO	SAN IGNACIO	06	11	01
519	137	061102	CAJAMARCA	SAN IGNACIO	CHIRINOS	06	11	02
520	137	061103	CAJAMARCA	SAN IGNACIO	HUARANGO	06	11	03
521	137	061104	CAJAMARCA	SAN IGNACIO	NAMBALLE	06	11	04
522	137	061105	CAJAMARCA	SAN IGNACIO	LA COIPA	06	11	05
523	137	061106	CAJAMARCA	SAN IGNACIO	SAN JOSE DE LOURDES	06	11	06
524	137	061107	CAJAMARCA	SAN IGNACIO	TABACONAS	06	11	07
525	137	061201	CAJAMARCA	SAN MARCOS	PEDRO GALVEZ	06	12	01
526	137	061202	CAJAMARCA	SAN MARCOS	ICHOCAN	06	12	02
527	137	061203	CAJAMARCA	SAN MARCOS	GREGORIO PITA	06	12	03
528	137	061204	CAJAMARCA	SAN MARCOS	JOSE MANUEL QUIROZ	06	12	04
529	137	061205	CAJAMARCA	SAN MARCOS	EDUARDO VILLANUEVA	06	12	05
530	137	061206	CAJAMARCA	SAN MARCOS	JOSE SABOGAL	06	12	06
531	137	061207	CAJAMARCA	SAN MARCOS	CHANCAY	06	12	07
532	137	061301	CAJAMARCA	SAN PABLO	SAN PABLO	06	13	01
533	137	061302	CAJAMARCA	SAN PABLO	SAN BERNARDINO	06	13	02
534	137	061303	CAJAMARCA	SAN PABLO	SAN LUIS	06	13	03
535	137	061304	CAJAMARCA	SAN PABLO	TUMBADEN	06	13	04
536	137	070101	CUSCO	CUSCO	CUSCO	07	01	01
537	137	070102	CUSCO	CUSCO	CCORCA	07	01	02
538	137	070103	CUSCO	CUSCO	POROY	07	01	03
539	137	070104	CUSCO	CUSCO	SAN JERONIMO	07	01	04
540	137	070105	CUSCO	CUSCO	SAN SEBASTIAN	07	01	05
541	137	070106	CUSCO	CUSCO	SANTIAGO	07	01	06
542	137	070107	CUSCO	CUSCO	SAYLLA	07	01	07
543	137	070108	CUSCO	CUSCO	WANCHAQ	07	01	08
544	137	070201	CUSCO	ACOMAYO	ACOMAYO	07	02	01
547	137	070204	CUSCO	ACOMAYO	POMACANCHI	07	02	04
548	137	070205	CUSCO	ACOMAYO	RONDOCAN	07	02	05
549	137	070206	CUSCO	ACOMAYO	SANGARARA	07	02	06
550	137	070207	CUSCO	ACOMAYO	MOSOC LLACTA	07	02	07
551	137	070301	CUSCO	ANTA	ANTA	07	03	01
552	137	070302	CUSCO	ANTA	CHINCHAYPUJIO	07	03	02
553	137	070303	CUSCO	ANTA	HUAROCONDO	07	03	03
554	137	070304	CUSCO	ANTA	LIMATAMBO	07	03	04
555	137	070305	CUSCO	ANTA	MOLLEPATA	07	03	05
556	137	070306	CUSCO	ANTA	PUCYURA	07	03	06
557	137	070307	CUSCO	ANTA	ZURITE	07	03	07
558	137	070308	CUSCO	ANTA	CACHIMAYO	07	03	08
559	137	070309	CUSCO	ANTA	ANCAHUASI	07	03	09
560	137	070401	CUSCO	CALCA	CALCA	07	04	01
561	137	070402	CUSCO	CALCA	COYA	07	04	02
562	137	070403	CUSCO	CALCA	LAMAY	07	04	03
563	137	070404	CUSCO	CALCA	LARES	07	04	04
564	137	070405	CUSCO	CALCA	PISAC	07	04	05
565	137	070406	CUSCO	CALCA	SAN SALVADOR	07	04	06
566	137	070407	CUSCO	CALCA	TARAY	07	04	07
567	137	070408	CUSCO	CALCA	YANATILE	07	04	08
568	137	070501	CUSCO	CANAS	YANAOCA	07	05	01
569	137	070502	CUSCO	CANAS	CHECCA	07	05	02
570	137	070503	CUSCO	CANAS	KUNTURKANKI	07	05	03
571	137	070504	CUSCO	CANAS	LANGUI	07	05	04
572	137	070505	CUSCO	CANAS	LAYO	07	05	05
573	137	070506	CUSCO	CANAS	PAMPAMARCA	07	05	06
574	137	070507	CUSCO	CANAS	QUEHUE	07	05	07
575	137	070508	CUSCO	CANAS	TUPAC AMARU	07	05	08
576	137	070601	CUSCO	CANCHIS	SICUANI	07	06	01
577	137	070602	CUSCO	CANCHIS	COMBAPATA	07	06	02
578	137	070603	CUSCO	CANCHIS	CHECACUPE	07	06	03
579	137	070604	CUSCO	CANCHIS	MARANGANI	07	06	04
580	137	070605	CUSCO	CANCHIS	PITUMARCA	07	06	05
581	137	070606	CUSCO	CANCHIS	SAN PABLO	07	06	06
582	137	070607	CUSCO	CANCHIS	SAN PEDRO	07	06	07
583	137	070608	CUSCO	CANCHIS	TINTA	07	06	08
584	137	070701	CUSCO	CHUMBIVILCAS	SANTO TOMAS	07	07	01
585	137	070702	CUSCO	CHUMBIVILCAS	CAPACMARCA	07	07	02
586	137	070703	CUSCO	CHUMBIVILCAS	COLQUEMARCA	07	07	03
587	137	070704	CUSCO	CHUMBIVILCAS	CHAMACA	07	07	04
588	137	070705	CUSCO	CHUMBIVILCAS	LIVITACA	07	07	05
589	137	070706	CUSCO	CHUMBIVILCAS	LLUSCO	07	07	06
590	137	070707	CUSCO	CHUMBIVILCAS	QUIÑOTA	07	07	07
591	137	070708	CUSCO	CHUMBIVILCAS	VELILLE	07	07	08
592	137	070801	CUSCO	ESPINAR	ESPINAR	07	08	01
593	137	070802	CUSCO	ESPINAR	CONDOROMA	07	08	02
594	137	070803	CUSCO	ESPINAR	COPORAQUE	07	08	03
595	137	030407	APURIMAC	ANTABAMBA	SABAINO	03	04	07
596	137	030501	APURIMAC	COTABAMBAS	TAMBOBAMBA	03	05	01
597	137	030502	APURIMAC	COTABAMBAS	COYLLURQUI	03	05	02
598	137	030503	APURIMAC	COTABAMBAS	COTABAMBAS	03	05	03
599	137	030504	APURIMAC	COTABAMBAS	HAQUIRA	03	05	04
600	137	030505	APURIMAC	COTABAMBAS	MARA	03	05	05
601	137	030506	APURIMAC	COTABAMBAS	CHALLHUAHUACHO	03	05	06
602	137	030601	APURIMAC	GRAU	CHUQUIBAMBILLA	03	06	01
603	137	030602	APURIMAC	GRAU	CURPAHUASI	03	06	02
604	137	030603	APURIMAC	GRAU	HUAILLATI	03	06	03
605	137	030604	APURIMAC	GRAU	MAMARA	03	06	04
606	137	030605	APURIMAC	GRAU	MARISCAL GAMARRA	03	06	05
607	137	030606	APURIMAC	GRAU	MICAELA BASTIDAS	03	06	06
608	137	030607	APURIMAC	GRAU	PROGRESO	03	06	07
609	137	030608	APURIMAC	GRAU	PATAYPAMPA	03	06	08
610	137	030609	APURIMAC	GRAU	SAN ANTONIO	03	06	09
611	137	030610	APURIMAC	GRAU	TURPAY	03	06	10
612	137	030611	APURIMAC	GRAU	VILCABAMBA	03	06	11
613	137	030612	APURIMAC	GRAU	VIRUNDO	03	06	12
614	137	030613	APURIMAC	GRAU	SANTA ROSA	03	06	13
615	137	030614	APURIMAC	GRAU	CURASCO	03	06	14
616	137	030701	APURIMAC	CHINCHEROS	CHINCHEROS	03	07	01
617	137	030702	APURIMAC	CHINCHEROS	ONGOY	03	07	02
618	137	030703	APURIMAC	CHINCHEROS	OCOBAMBA	03	07	03
619	137	030704	APURIMAC	CHINCHEROS	COCHARCAS	03	07	04
620	137	030705	APURIMAC	CHINCHEROS	ANCO HUALLO	03	07	05
621	137	030706	APURIMAC	CHINCHEROS	HUACCANA	03	07	06
622	137	030707	APURIMAC	CHINCHEROS	URANMARCA	03	07	07
623	137	030708	APURIMAC	CHINCHEROS	RANRACANCHA	03	07	08
624	137	040101	AREQUIPA	AREQUIPA	AREQUIPA	04	01	01
625	137	040102	AREQUIPA	AREQUIPA	CAYMA	04	01	02
626	137	040103	AREQUIPA	AREQUIPA	CERRO COLORADO	04	01	03
627	137	040104	AREQUIPA	AREQUIPA	CHARACATO	04	01	04
628	137	040105	AREQUIPA	AREQUIPA	CHIGUATA	04	01	05
629	137	040106	AREQUIPA	AREQUIPA	LA JOYA	04	01	06
630	137	040107	AREQUIPA	AREQUIPA	MIRAFLORES	04	01	07
631	137	040108	AREQUIPA	AREQUIPA	MOLLEBAYA	04	01	08
632	137	040109	AREQUIPA	AREQUIPA	PAUCARPATA	04	01	09
633	137	040110	AREQUIPA	AREQUIPA	POCSI	04	01	10
634	137	040111	AREQUIPA	AREQUIPA	POLOBAYA	04	01	11
635	137	040112	AREQUIPA	AREQUIPA	QUEQUEÑA	04	01	12
636	137	040113	AREQUIPA	AREQUIPA	SABANDIA	04	01	13
637	137	040114	AREQUIPA	AREQUIPA	SACHACA	04	01	14
638	137	040115	AREQUIPA	AREQUIPA	SAN JUAN DE SIGUAS	04	01	15
639	137	040116	AREQUIPA	AREQUIPA	SAN JUAN DE TARUCANI	04	01	16
640	137	040117	AREQUIPA	AREQUIPA	SANTA ISABEL DE SIGUAS	04	01	17
641	137	040118	AREQUIPA	AREQUIPA	SANTA RITA DE SIHUAS	04	01	18
642	137	040119	AREQUIPA	AREQUIPA	SOCABAYA	04	01	19
643	137	040120	AREQUIPA	AREQUIPA	TIABAYA	04	01	20
644	137	040121	AREQUIPA	AREQUIPA	UCHUMAYO	04	01	21
645	137	040122	AREQUIPA	AREQUIPA	VITOR	04	01	22
646	137	040123	AREQUIPA	AREQUIPA	YANAHUARA	04	01	23
647	137	040124	AREQUIPA	AREQUIPA	YARABAMBA	04	01	24
648	137	040125	AREQUIPA	AREQUIPA	YURA	04	01	25
649	137	040126	AREQUIPA	AREQUIPA	MARIANO MELGAR	04	01	26
650	137	040127	AREQUIPA	AREQUIPA	JACOBO HUNTER	04	01	27
651	137	040128	AREQUIPA	AREQUIPA	ALTO SELVA ALEGRE	04	01	28
652	137	040129	AREQUIPA	AREQUIPA	JOSE LUIS BUSTAMANTE Y RIVERO	04	01	29
653	137	040201	AREQUIPA	CAYLLOMA	CHIVAY	04	02	01
654	137	040202	AREQUIPA	CAYLLOMA	ACHOMA	04	02	02
655	137	040203	AREQUIPA	CAYLLOMA	CABANACONDE	04	02	03
656	137	040204	AREQUIPA	CAYLLOMA	CAYLLOMA	04	02	04
657	137	040205	AREQUIPA	CAYLLOMA	CALLALLI	04	02	05
658	137	040206	AREQUIPA	CAYLLOMA	COPORAQUE	04	02	06
659	137	040207	AREQUIPA	CAYLLOMA	HUAMBO	04	02	07
660	137	040208	AREQUIPA	CAYLLOMA	HUANCA	04	02	08
661	137	040209	AREQUIPA	CAYLLOMA	ICHUPAMPA	04	02	09
662	137	040210	AREQUIPA	CAYLLOMA	LARI	04	02	10
663	137	040211	AREQUIPA	CAYLLOMA	LLUTA	04	02	11
664	137	040212	AREQUIPA	CAYLLOMA	MACA	04	02	12
665	137	040213	AREQUIPA	CAYLLOMA	MADRIGAL	04	02	13
666	137	040214	AREQUIPA	CAYLLOMA	SAN ANTONIO DE CHUCA	04	02	14
667	137	040215	AREQUIPA	CAYLLOMA	SIBAYO	04	02	15
668	137	040216	AREQUIPA	CAYLLOMA	TAPAY	04	02	16
669	137	040217	AREQUIPA	CAYLLOMA	TISCO	04	02	17
670	137	040218	AREQUIPA	CAYLLOMA	TUTI	04	02	18
671	137	040219	AREQUIPA	CAYLLOMA	YANQUE	04	02	19
672	137	040220	AREQUIPA	CAYLLOMA	MAJES	04	02	20
673	137	040301	AREQUIPA	CAMANA	CAMANA	04	03	01
674	137	040302	AREQUIPA	CAMANA	JOSE MARIA QUIMPER	04	03	02
675	137	040303	AREQUIPA	CAMANA	MARIANO NICOLAS VALCARCEL	04	03	03
676	137	040304	AREQUIPA	CAMANA	MARISCAL CACERES	04	03	04
677	137	040305	AREQUIPA	CAMANA	NICOLAS DE PIEROLA	04	03	05
678	137	040306	AREQUIPA	CAMANA	OCOÑA	04	03	06
679	137	040307	AREQUIPA	CAMANA	QUILCA	04	03	07
680	137	040308	AREQUIPA	CAMANA	SAMUEL PASTOR	04	03	08
681	137	040401	AREQUIPA	CARAVELI	CARAVELI	04	04	01
682	137	040402	AREQUIPA	CARAVELI	ACARI	04	04	02
683	137	040403	AREQUIPA	CARAVELI	ATICO	04	04	03
684	137	040404	AREQUIPA	CARAVELI	ATIQUIPA	04	04	04
685	137	040405	AREQUIPA	CARAVELI	BELLA UNION	04	04	05
686	137	040406	AREQUIPA	CARAVELI	CAHUACHO	04	04	06
687	137	040407	AREQUIPA	CARAVELI	CHALA	04	04	07
688	137	040408	AREQUIPA	CARAVELI	CHAPARRA	04	04	08
689	137	040409	AREQUIPA	CARAVELI	HUANUHUANU	04	04	09
690	137	040410	AREQUIPA	CARAVELI	JAQUI	04	04	10
691	137	040411	AREQUIPA	CARAVELI	LOMAS	04	04	11
692	137	040412	AREQUIPA	CARAVELI	QUICACHA	04	04	12
693	137	040413	AREQUIPA	CARAVELI	YAUCA	04	04	13
694	137	040501	AREQUIPA	CASTILLA	APLAO	04	05	01
695	137	040502	AREQUIPA	CASTILLA	ANDAGUA	04	05	02
696	137	040503	AREQUIPA	CASTILLA	AYO	04	05	03
697	137	040504	AREQUIPA	CASTILLA	CHACHAS	04	05	04
698	137	040505	AREQUIPA	CASTILLA	CHILCAYMARCA	04	05	05
699	137	040506	AREQUIPA	CASTILLA	CHOCO	04	05	06
700	137	040507	AREQUIPA	CASTILLA	HUANCARQUI	04	05	07
701	137	040508	AREQUIPA	CASTILLA	MACHAGUAY	04	05	08
702	137	040509	AREQUIPA	CASTILLA	ORCOPAMPA	04	05	09
703	137	040510	AREQUIPA	CASTILLA	PAMPACOLCA	04	05	10
704	137	040511	AREQUIPA	CASTILLA	TIPAN	04	05	11
705	137	040512	AREQUIPA	CASTILLA	URACA	04	05	12
706	137	040513	AREQUIPA	CASTILLA	UÑON	04	05	13
707	137	040514	AREQUIPA	CASTILLA	VIRACO	04	05	14
708	137	040601	AREQUIPA	CONDESUYOS	CHUQUIBAMBA	04	06	01
709	137	040602	AREQUIPA	CONDESUYOS	ANDARAY	04	06	02
710	137	040603	AREQUIPA	CONDESUYOS	CAYARANI	04	06	03
711	137	040604	AREQUIPA	CONDESUYOS	CHICHAS	04	06	04
712	137	040605	AREQUIPA	CONDESUYOS	IRAY	04	06	05
713	137	040606	AREQUIPA	CONDESUYOS	SALAMANCA	04	06	06
714	137	040607	AREQUIPA	CONDESUYOS	YANAQUIHUA	04	06	07
715	137	040608	AREQUIPA	CONDESUYOS	RIO GRANDE	04	06	08
716	137	040701	AREQUIPA	ISLAY	MOLLENDO	04	07	01
717	137	040702	AREQUIPA	ISLAY	COCACHACRA	04	07	02
718	137	040703	AREQUIPA	ISLAY	DEAN VALDIVIA	04	07	03
719	137	040704	AREQUIPA	ISLAY	ISLAY	04	07	04
720	137	040705	AREQUIPA	ISLAY	MEJIA	04	07	05
721	137	040706	AREQUIPA	ISLAY	PUNTA DE BOMBON	04	07	06
722	137	040801	AREQUIPA	LA UNION	COTAHUASI	04	08	01
723	137	040802	AREQUIPA	LA UNION	ALCA	04	08	02
724	137	040803	AREQUIPA	LA UNION	CHARCANA	04	08	03
725	137	040804	AREQUIPA	LA UNION	HUAYNACOTAS	04	08	04
726	137	040805	AREQUIPA	LA UNION	PAMPAMARCA	04	08	05
727	137	040806	AREQUIPA	LA UNION	PUYCA	04	08	06
728	137	040807	AREQUIPA	LA UNION	QUECHUALLA	04	08	07
729	137	040808	AREQUIPA	LA UNION	SAYLA	04	08	08
730	137	040809	AREQUIPA	LA UNION	TAURIA	04	08	09
731	137	040810	AREQUIPA	LA UNION	TOMEPAMPA	04	08	10
732	137	040811	AREQUIPA	LA UNION	TORO	04	08	11
733	137	050101	AYACUCHO	HUAMANGA	AYACUCHO	05	01	01
734	137	050102	AYACUCHO	HUAMANGA	ACOS VINCHOS	05	01	02
735	137	050103	AYACUCHO	HUAMANGA	CARMEN ALTO	05	01	03
736	137	050104	AYACUCHO	HUAMANGA	CHIARA	05	01	04
737	137	050105	AYACUCHO	HUAMANGA	QUINUA	05	01	05
738	137	050106	AYACUCHO	HUAMANGA	SAN JOSE DE TICLLAS	05	01	06
739	137	050107	AYACUCHO	HUAMANGA	SAN JUAN BAUTISTA	05	01	07
740	137	050108	AYACUCHO	HUAMANGA	SANTIAGO DE PISCHA	05	01	08
741	137	050109	AYACUCHO	HUAMANGA	VINCHOS	05	01	09
742	137	050110	AYACUCHO	HUAMANGA	TAMBILLO	05	01	10
743	137	050111	AYACUCHO	HUAMANGA	ACOCRO	05	01	11
744	137	050112	AYACUCHO	HUAMANGA	SOCOS	05	01	12
745	137	080703	HUANCAVELICA	CHURCAMPA	CHINCHIHUASI	08	07	03
746	137	080704	HUANCAVELICA	CHURCAMPA	EL CARMEN	08	07	04
747	137	080705	HUANCAVELICA	CHURCAMPA	LA MERCED	08	07	05
748	137	080706	HUANCAVELICA	CHURCAMPA	LOCROJA	08	07	06
749	137	080707	HUANCAVELICA	CHURCAMPA	PAUCARBAMBA	08	07	07
750	137	080708	HUANCAVELICA	CHURCAMPA	SAN MIGUEL DE MAYOCC	08	07	08
751	137	080709	HUANCAVELICA	CHURCAMPA	SAN PEDRO DE CORIS	08	07	09
752	137	080710	HUANCAVELICA	CHURCAMPA	PACHAMARCA	08	07	10
753	137	080711	HUANCAVELICA	CHURCAMPA	COSME	08	07	11
754	137	090101	HUANUCO	HUANUCO	HUANUCO	09	01	01
755	137	090102	HUANUCO	HUANUCO	CHINCHAO	09	01	02
756	137	090103	HUANUCO	HUANUCO	CHURUBAMBA	09	01	03
757	137	090104	HUANUCO	HUANUCO	MARGOS	09	01	04
758	137	090105	HUANUCO	HUANUCO	QUISQUI	09	01	05
759	137	090106	HUANUCO	HUANUCO	SAN FRANCISCO DE CAYRAN	09	01	06
760	137	090107	HUANUCO	HUANUCO	SAN PEDRO DE CHAULAN	09	01	07
761	137	090108	HUANUCO	HUANUCO	SANTA MARIA DEL VALLE	09	01	08
762	137	090109	HUANUCO	HUANUCO	YARUMAYO	09	01	09
763	137	090110	HUANUCO	HUANUCO	AMARILIS	09	01	10
764	137	090111	HUANUCO	HUANUCO	PILLCO MARCA	09	01	11
765	137	090112	HUANUCO	HUANUCO	YACUS	09	01	12
766	137	090201	HUANUCO	AMBO	AMBO	09	02	01
767	137	090202	HUANUCO	AMBO	CAYNA	09	02	02
768	137	090203	HUANUCO	AMBO	COLPAS	09	02	03
769	137	090204	HUANUCO	AMBO	CONCHAMARCA	09	02	04
770	137	090205	HUANUCO	AMBO	HUACAR	09	02	05
771	137	090206	HUANUCO	AMBO	SAN FRANCISCO	09	02	06
772	137	090207	HUANUCO	AMBO	SAN RAFAEL	09	02	07
773	137	090208	HUANUCO	AMBO	TOMAY-KICHWA	09	02	08
774	137	090301	HUANUCO	DOS DE MAYO	LA UNION	09	03	01
775	137	090307	HUANUCO	DOS DE MAYO	CHUQUIS	09	03	07
776	137	090312	HUANUCO	DOS DE MAYO	MARIAS	09	03	12
777	137	090314	HUANUCO	DOS DE MAYO	PACHAS	09	03	14
778	137	090316	HUANUCO	DOS DE MAYO	QUIVILLA	09	03	16
779	137	090317	HUANUCO	DOS DE MAYO	RIPAN	09	03	17
780	137	090321	HUANUCO	DOS DE MAYO	SHUNQUI	09	03	21
781	137	090322	HUANUCO	DOS DE MAYO	SILLAPATA	09	03	22
782	137	090323	HUANUCO	DOS DE MAYO	YANAS	09	03	23
783	137	090401	HUANUCO	HUAMALIES	LLATA	09	04	01
784	137	090402	HUANUCO	HUAMALIES	ARANCAY	09	04	02
785	137	090403	HUANUCO	HUAMALIES	CHAVIN DE PARIARCA	09	04	03
786	137	090404	HUANUCO	HUAMALIES	JACAS GRANDE	09	04	04
787	137	090405	HUANUCO	HUAMALIES	JIRCAN	09	04	05
788	137	090406	HUANUCO	HUAMALIES	MIRAFLORES	09	04	06
789	137	090407	HUANUCO	HUAMALIES	MONZON	09	04	07
790	137	090408	HUANUCO	HUAMALIES	PUNCHAO	09	04	08
791	137	090409	HUANUCO	HUAMALIES	PUÑOS	09	04	09
792	137	090410	HUANUCO	HUAMALIES	SINGA	09	04	10
793	137	090411	HUANUCO	HUAMALIES	TANTAMAYO	09	04	11
794	137	090501	HUANUCO	MARAÑON	HUACRACHUCO	09	05	01
795	137	090502	HUANUCO	MARAÑON	CHOLON	09	05	02
796	137	090505	HUANUCO	MARAÑON	SAN BUENAVENTURA	09	05	05
797	137	090506	HUANUCO	MARAÑON	LA MORADA	09	05	06
798	137	090601	HUANUCO	LEONCIO PRADO	RUPA-RUPA	09	06	01
799	137	090602	HUANUCO	LEONCIO PRADO	DANIEL ALOMIA ROBLES	09	06	02
800	137	090603	HUANUCO	LEONCIO PRADO	HERMILIO VALDIZAN	09	06	03
801	137	090604	HUANUCO	LEONCIO PRADO	LUYANDO	09	06	04
802	137	090605	HUANUCO	LEONCIO PRADO	MARIANO DAMASO BERAUN	09	06	05
803	137	090606	HUANUCO	LEONCIO PRADO	JOSE CRESPO Y CASTILLO	09	06	06
804	137	090608	HUANUCO	LEONCIO PRADO	CASTILLO GRANDE	09	06	08
805	137	090701	HUANUCO	PACHITEA	PANAO	09	07	01
806	137	090702	HUANUCO	PACHITEA	CHAGLLA	09	07	02
807	137	090704	HUANUCO	PACHITEA	MOLINO	09	07	04
808	137	090706	HUANUCO	PACHITEA	UMARI	09	07	06
809	137	090801	HUANUCO	PUERTO INCA	HONORIA	09	08	01
810	137	090802	HUANUCO	PUERTO INCA	PUERTO INCA	09	08	02
811	137	090803	HUANUCO	PUERTO INCA	CODO DEL POZUZO	09	08	03
812	137	090804	HUANUCO	PUERTO INCA	TOURNAVISTA	09	08	04
813	137	090805	HUANUCO	PUERTO INCA	YUYAPICHIS	09	08	05
814	137	090901	HUANUCO	HUACAYBAMBA	HUACAYBAMBA	09	09	01
815	137	090902	HUANUCO	HUACAYBAMBA	PINRA	09	09	02
816	137	090903	HUANUCO	HUACAYBAMBA	CANCHABAMBA	09	09	03
817	137	090904	HUANUCO	HUACAYBAMBA	COCHABAMBA	09	09	04
818	137	091001	HUANUCO	LAURICOCHA	JESUS	09	10	01
819	137	091002	HUANUCO	LAURICOCHA	BAÑOS	09	10	02
820	137	091003	HUANUCO	LAURICOCHA	SAN FRANCISCO DE ASIS	09	10	03
821	137	091004	HUANUCO	LAURICOCHA	QUEROPALCA	09	10	04
822	137	091005	HUANUCO	LAURICOCHA	SAN MIGUEL DE CAURI	09	10	05
823	137	091006	HUANUCO	LAURICOCHA	RONDOS	09	10	06
824	137	091007	HUANUCO	LAURICOCHA	JIVIA	09	10	07
825	137	091101	HUANUCO	YAROWILCA	CHAVINILLO	09	11	01
826	137	091102	HUANUCO	YAROWILCA	APARICIO POMARES	09	11	02
827	137	091103	HUANUCO	YAROWILCA	CAHUAC	09	11	03
828	137	091104	HUANUCO	YAROWILCA	CHACABAMBA	09	11	04
829	137	091105	HUANUCO	YAROWILCA	JACAS CHICO	09	11	05
830	137	091106	HUANUCO	YAROWILCA	OBAS	09	11	06
831	137	091107	HUANUCO	YAROWILCA	PAMPAMARCA	09	11	07
832	137	091108	HUANUCO	YAROWILCA	CHORAS	09	11	08
833	137	100101	ICA	ICA	ICA	10	01	01
834	137	100102	ICA	ICA	LA TINGUIÑA	10	01	02
835	137	100103	ICA	ICA	LOS AQUIJES	10	01	03
836	137	100104	ICA	ICA	PARCONA	10	01	04
837	137	100105	ICA	ICA	PUEBLO NUEVO	10	01	05
838	137	100106	ICA	ICA	SALAS	10	01	06
839	137	100107	ICA	ICA	SAN JOSE DE LOS MOLINOS	10	01	07
840	137	100108	ICA	ICA	SAN JUAN BAUTISTA	10	01	08
841	137	100109	ICA	ICA	SANTIAGO	10	01	09
842	137	100110	ICA	ICA	SUBTANJALLA	10	01	10
843	137	100111	ICA	ICA	YAUCA DEL ROSARIO	10	01	11
844	137	100112	ICA	ICA	TATE	10	01	12
845	137	100113	ICA	ICA	PACHACUTEC	10	01	13
846	137	100114	ICA	ICA	OCUCAJE	10	01	14
847	137	100201	ICA	CHINCHA	CHINCHA ALTA	10	02	01
848	137	100202	ICA	CHINCHA	CHAVIN	10	02	02
849	137	100203	ICA	CHINCHA	CHINCHA BAJA	10	02	03
850	137	100204	ICA	CHINCHA	EL CARMEN	10	02	04
851	137	100205	ICA	CHINCHA	GROCIO PRADO	10	02	05
852	137	100206	ICA	CHINCHA	SAN PEDRO DE HUACARPANA	10	02	06
853	137	100207	ICA	CHINCHA	SUNAMPE	10	02	07
854	137	100208	ICA	CHINCHA	TAMBO DE MORA	10	02	08
855	137	100209	ICA	CHINCHA	ALTO LARAN	10	02	09
856	137	100210	ICA	CHINCHA	PUEBLO NUEVO	10	02	10
857	137	100211	ICA	CHINCHA	SAN JUAN DE YANAC	10	02	11
858	137	100301	ICA	NAZCA	NAZCA	10	03	01
859	137	100302	ICA	NAZCA	CHANGUILLO	10	03	02
860	137	100303	ICA	NAZCA	EL INGENIO	10	03	03
861	137	100304	ICA	NAZCA	MARCONA	10	03	04
862	137	100305	ICA	NAZCA	VISTA ALEGRE	10	03	05
863	137	100401	ICA	PISCO	PISCO	10	04	01
864	137	100402	ICA	PISCO	HUANCANO	10	04	02
865	137	100403	ICA	PISCO	HUMAY	10	04	03
866	137	100404	ICA	PISCO	INDEPENDENCIA	10	04	04
867	137	100405	ICA	PISCO	PARACAS	10	04	05
868	137	100406	ICA	PISCO	SAN ANDRES	10	04	06
869	137	100407	ICA	PISCO	SAN CLEMENTE	10	04	07
870	137	100408	ICA	PISCO	TUPAC AMARU INCA	10	04	08
871	137	100501	ICA	PALPA	PALPA	10	05	01
872	137	100502	ICA	PALPA	LLIPATA	10	05	02
873	137	100503	ICA	PALPA	RIO GRANDE	10	05	03
874	137	100504	ICA	PALPA	SANTA CRUZ	10	05	04
875	137	100505	ICA	PALPA	TIBILLO	10	05	05
876	137	110101	JUNIN	HUANCAYO	HUANCAYO	11	01	01
877	137	110103	JUNIN	HUANCAYO	CARHUACALLANGA	11	01	03
878	137	110104	JUNIN	HUANCAYO	COLCA	11	01	04
879	137	110105	JUNIN	HUANCAYO	CULLHUAS	11	01	05
880	137	110106	JUNIN	HUANCAYO	CHACAPAMPA	11	01	06
881	137	110107	JUNIN	HUANCAYO	CHICCHE	11	01	07
882	137	110108	JUNIN	HUANCAYO	CHILCA	11	01	08
883	137	110109	JUNIN	HUANCAYO	CHONGOS ALTO	11	01	09
884	137	110112	JUNIN	HUANCAYO	CHUPURO	11	01	12
885	137	110113	JUNIN	HUANCAYO	EL TAMBO	11	01	13
886	137	110114	JUNIN	HUANCAYO	HUACRAPUQUIO	11	01	14
887	137	110116	JUNIN	HUANCAYO	HUALHUAS	11	01	16
888	137	110118	JUNIN	HUANCAYO	HUANCAN	11	01	18
889	137	110119	JUNIN	HUANCAYO	HUASICANCHA	11	01	19
890	137	110120	JUNIN	HUANCAYO	HUAYUCACHI	11	01	20
891	137	110121	JUNIN	HUANCAYO	INGENIO	11	01	21
892	137	110122	JUNIN	HUANCAYO	PARIAHUANCA	11	01	22
893	137	110123	JUNIN	HUANCAYO	PILCOMAYO	11	01	23
894	137	110124	JUNIN	HUANCAYO	PUCARA	11	01	24
895	137	110125	JUNIN	HUANCAYO	QUICHUAY	11	01	25
896	137	110126	JUNIN	HUANCAYO	QUILCAS	11	01	26
897	137	110127	JUNIN	HUANCAYO	SAN AGUSTIN	11	01	27
898	137	110128	JUNIN	HUANCAYO	SAN JERONIMO DE TUNAN	11	01	28
899	137	110131	JUNIN	HUANCAYO	SANTO DOMINGO DE ACOBAMBA	11	01	31
900	137	110132	JUNIN	HUANCAYO	SAÑO	11	01	32
901	137	110133	JUNIN	HUANCAYO	SAPALLANGA	11	01	33
902	137	110134	JUNIN	HUANCAYO	SICAYA	11	01	34
903	137	110136	JUNIN	HUANCAYO	VIQUES	11	01	36
904	137	110201	JUNIN	CONCEPCION	CONCEPCION	11	02	01
905	137	110202	JUNIN	CONCEPCION	ACO	11	02	02
906	137	110203	JUNIN	CONCEPCION	ANDAMARCA	11	02	03
907	137	110204	JUNIN	CONCEPCION	COMAS	11	02	04
908	137	110205	JUNIN	CONCEPCION	COCHAS	11	02	05
909	137	110206	JUNIN	CONCEPCION	CHAMBARA	11	02	06
910	137	110207	JUNIN	CONCEPCION	HEROINAS TOLEDO	11	02	07
911	137	110208	JUNIN	CONCEPCION	MANZANARES	11	02	08
912	137	110209	JUNIN	CONCEPCION	MARISCAL CASTILLA	11	02	09
913	137	110210	JUNIN	CONCEPCION	MATAHUASI	11	02	10
914	137	110211	JUNIN	CONCEPCION	MITO	11	02	11
915	137	110212	JUNIN	CONCEPCION	NUEVE DE JULIO	11	02	12
916	137	110213	JUNIN	CONCEPCION	ORCOTUNA	11	02	13
917	137	110214	JUNIN	CONCEPCION	SANTA ROSA DE OCOPA	11	02	14
918	137	110215	JUNIN	CONCEPCION	SAN JOSE DE QUERO	11	02	15
919	137	110301	JUNIN	JAUJA	JAUJA	11	03	01
920	137	110302	JUNIN	JAUJA	ACOLLA	11	03	02
921	137	110303	JUNIN	JAUJA	APATA	11	03	03
922	137	110304	JUNIN	JAUJA	ATAURA	11	03	04
923	137	110305	JUNIN	JAUJA	CANCHAYLLO	11	03	05
924	137	110306	JUNIN	JAUJA	EL MANTARO	11	03	06
925	137	110307	JUNIN	JAUJA	HUAMALI	11	03	07
926	137	110308	JUNIN	JAUJA	HUARIPAMPA	11	03	08
927	137	110309	JUNIN	JAUJA	HUERTAS	11	03	09
928	137	110310	JUNIN	JAUJA	JANJAILLO	11	03	10
929	137	110311	JUNIN	JAUJA	JULCAN	11	03	11
930	137	110312	JUNIN	JAUJA	LEONOR ORDOÑEZ	11	03	12
931	137	110313	JUNIN	JAUJA	LLOCLLAPAMPA	11	03	13
932	137	110314	JUNIN	JAUJA	MARCO	11	03	14
933	137	110315	JUNIN	JAUJA	MASMA	11	03	15
934	137	110316	JUNIN	JAUJA	MOLINOS	11	03	16
935	137	110317	JUNIN	JAUJA	MONOBAMBA	11	03	17
936	137	110318	JUNIN	JAUJA	MUQUI	11	03	18
937	137	110319	JUNIN	JAUJA	MUQUIYAUYO	11	03	19
938	137	110320	JUNIN	JAUJA	PACA	11	03	20
939	137	110321	JUNIN	JAUJA	PACCHA	11	03	21
940	137	110322	JUNIN	JAUJA	PANCAN	11	03	22
941	137	110323	JUNIN	JAUJA	PARCO	11	03	23
942	137	110324	JUNIN	JAUJA	POMACANCHA	11	03	24
943	137	110325	JUNIN	JAUJA	RICRAN	11	03	25
944	137	110326	JUNIN	JAUJA	SAN LORENZO	11	03	26
945	137	110327	JUNIN	JAUJA	SAN PEDRO DE CHUNAN	11	03	27
946	137	110328	JUNIN	JAUJA	SINCOS	11	03	28
947	137	110329	JUNIN	JAUJA	TUNAN MARCA	11	03	29
948	137	110330	JUNIN	JAUJA	YAULI	11	03	30
949	137	110331	JUNIN	JAUJA	CURICACA	11	03	31
950	137	110332	JUNIN	JAUJA	MASMA CHICCHE	11	03	32
951	137	110333	JUNIN	JAUJA	SAUSA	11	03	33
952	137	110334	JUNIN	JAUJA	YAUYOS	11	03	34
953	137	110401	JUNIN	JUNIN	JUNIN	11	04	01
954	137	110402	JUNIN	JUNIN	CARHUAMAYO	11	04	02
955	137	110403	JUNIN	JUNIN	ONDORES	11	04	03
956	137	110404	JUNIN	JUNIN	ULCUMAYO	11	04	04
957	137	110501	JUNIN	TARMA	TARMA	11	05	01
958	137	110502	JUNIN	TARMA	ACOBAMBA	11	05	02
959	137	110503	JUNIN	TARMA	HUARICOLCA	11	05	03
960	137	110504	JUNIN	TARMA	HUASAHUASI	11	05	04
961	137	110505	JUNIN	TARMA	LA UNION	11	05	05
962	137	110506	JUNIN	TARMA	PALCA	11	05	06
963	137	110507	JUNIN	TARMA	PALCAMAYO	11	05	07
964	137	110508	JUNIN	TARMA	SAN PEDRO DE CAJAS	11	05	08
965	137	110509	JUNIN	TARMA	TAPO	11	05	09
966	137	110601	JUNIN	YAULI	LA OROYA	11	06	01
967	137	110602	JUNIN	YAULI	CHACAPALPA	11	06	02
968	137	110603	JUNIN	YAULI	HUAY HUAY	11	06	03
969	137	110604	JUNIN	YAULI	MARCAPOMACOCHA	11	06	04
970	137	110605	JUNIN	YAULI	MOROCOCHA	11	06	05
971	137	110606	JUNIN	YAULI	PACCHA	11	06	06
972	137	110607	JUNIN	YAULI	SANTA BARBARA DE CARHUACAYAN	11	06	07
973	137	110608	JUNIN	YAULI	SUITUCANCHA	11	06	08
974	137	110609	JUNIN	YAULI	YAULI	11	06	09
975	137	110610	JUNIN	YAULI	SANTA ROSA DE SACCO	11	06	10
976	137	110701	JUNIN	SATIPO	SATIPO	11	07	01
977	137	110702	JUNIN	SATIPO	COVIRIALI	11	07	02
978	137	110703	JUNIN	SATIPO	LLAYLLA	11	07	03
979	137	110704	JUNIN	SATIPO	MAZAMARI	11	07	04
980	137	110705	JUNIN	SATIPO	PAMPA HERMOSA	11	07	05
981	137	110706	JUNIN	SATIPO	PANGOA	11	07	06
982	137	110707	JUNIN	SATIPO	RIO NEGRO	11	07	07
983	137	110708	JUNIN	SATIPO	RIO TAMBO	11	07	08
984	137	110709	JUNIN	SATIPO	VIZCATAN DEL ENE	11	07	09
985	137	110801	JUNIN	CHANCHAMAYO	CHANCHAMAYO	11	08	01
986	137	110802	JUNIN	CHANCHAMAYO	SAN RAMON	11	08	02
987	137	110803	JUNIN	CHANCHAMAYO	VITOC	11	08	03
988	137	110804	JUNIN	CHANCHAMAYO	SAN LUIS DE SHUARO	11	08	04
989	137	110805	JUNIN	CHANCHAMAYO	PICHANAQUI	11	08	05
990	137	110806	JUNIN	CHANCHAMAYO	PERENE	11	08	06
991	137	110901	JUNIN	CHUPACA	CHUPACA	11	09	01
992	137	110902	JUNIN	CHUPACA	AHUAC	11	09	02
993	137	110903	JUNIN	CHUPACA	CHONGOS BAJO	11	09	03
994	137	110904	JUNIN	CHUPACA	HUACHAC	11	09	04
995	137	110905	JUNIN	CHUPACA	HUAMANCACA CHICO	11	09	05
996	137	110906	JUNIN	CHUPACA	SAN JUAN DE YSCOS	11	09	06
997	137	110907	JUNIN	CHUPACA	SAN JUAN DE JARPA	11	09	07
998	137	110908	JUNIN	CHUPACA	TRES DE DICIEMBRE	11	09	08
999	137	110909	JUNIN	CHUPACA	YANACANCHA	11	09	09
1000	137	120101	LA LIBERTAD	TRUJILLO	TRUJILLO	12	01	01
1001	137	120102	LA LIBERTAD	TRUJILLO	HUANCHACO	12	01	02
1002	137	120103	LA LIBERTAD	TRUJILLO	LAREDO	12	01	03
1003	137	120104	LA LIBERTAD	TRUJILLO	MOCHE	12	01	04
1004	137	120105	LA LIBERTAD	TRUJILLO	SALAVERRY	12	01	05
1005	137	120106	LA LIBERTAD	TRUJILLO	SIMBAL	12	01	06
1006	137	120107	LA LIBERTAD	TRUJILLO	VICTOR LARCO HERRERA	12	01	07
1007	137	120109	LA LIBERTAD	TRUJILLO	POROTO	12	01	09
1008	137	120110	LA LIBERTAD	TRUJILLO	EL PORVENIR	12	01	10
1009	137	120111	LA LIBERTAD	TRUJILLO	LA ESPERANZA	12	01	11
1010	137	120112	LA LIBERTAD	TRUJILLO	FLORENCIA DE MORA	12	01	12
1011	137	120201	LA LIBERTAD	BOLIVAR	BOLIVAR	12	02	01
1012	137	120202	LA LIBERTAD	BOLIVAR	BAMBAMARCA	12	02	02
1013	137	120203	LA LIBERTAD	BOLIVAR	CONDORMARCA	12	02	03
1014	137	120204	LA LIBERTAD	BOLIVAR	LONGOTEA	12	02	04
1015	137	120205	LA LIBERTAD	BOLIVAR	UCUNCHA	12	02	05
1016	137	120206	LA LIBERTAD	BOLIVAR	UCHUMARCA	12	02	06
1017	137	120301	LA LIBERTAD	SANCHEZ CARRION	HUAMACHUCO	12	03	01
1018	137	120302	LA LIBERTAD	SANCHEZ CARRION	COCHORCO	12	03	02
1019	137	120303	LA LIBERTAD	SANCHEZ CARRION	CURGOS	12	03	03
1020	137	120304	LA LIBERTAD	SANCHEZ CARRION	CHUGAY	12	03	04
1021	137	120305	LA LIBERTAD	SANCHEZ CARRION	MARCABAL	12	03	05
1022	137	120306	LA LIBERTAD	SANCHEZ CARRION	SANAGORAN	12	03	06
1023	137	120307	LA LIBERTAD	SANCHEZ CARRION	SARIN	12	03	07
1024	137	120308	LA LIBERTAD	SANCHEZ CARRION	SARTIMBAMBA	12	03	08
1025	137	120401	LA LIBERTAD	OTUZCO	OTUZCO	12	04	01
1026	137	120402	LA LIBERTAD	OTUZCO	AGALLPAMPA	12	04	02
1027	137	120403	LA LIBERTAD	OTUZCO	CHARAT	12	04	03
1028	137	120404	LA LIBERTAD	OTUZCO	HUARANCHAL	12	04	04
1029	137	120405	LA LIBERTAD	OTUZCO	LA CUESTA	12	04	05
1030	137	120408	LA LIBERTAD	OTUZCO	PARANDAY	12	04	08
1031	137	120409	LA LIBERTAD	OTUZCO	SALPO	12	04	09
1032	137	120410	LA LIBERTAD	OTUZCO	SINSICAP	12	04	10
1033	137	120411	LA LIBERTAD	OTUZCO	USQUIL	12	04	11
1034	137	120413	LA LIBERTAD	OTUZCO	MACHE	12	04	13
1035	137	120501	LA LIBERTAD	PACASMAYO	SAN PEDRO DE LLOC	12	05	01
1036	137	120503	LA LIBERTAD	PACASMAYO	GUADALUPE	12	05	03
1037	137	120504	LA LIBERTAD	PACASMAYO	JEQUETEPEQUE	12	05	04
1038	137	120506	LA LIBERTAD	PACASMAYO	PACASMAYO	12	05	06
1039	137	120508	LA LIBERTAD	PACASMAYO	SAN JOSE	12	05	08
1040	137	120601	LA LIBERTAD	PATAZ	TAYABAMBA	12	06	01
1041	137	120602	LA LIBERTAD	PATAZ	BULDIBUYO	12	06	02
1042	137	120603	LA LIBERTAD	PATAZ	CHILLIA	12	06	03
1043	137	120604	LA LIBERTAD	PATAZ	HUAYLILLAS	12	06	04
1044	137	120605	LA LIBERTAD	PATAZ	HUANCASPATA	12	06	05
1045	137	120606	LA LIBERTAD	PATAZ	HUAYO	12	06	06
1046	137	120607	LA LIBERTAD	PATAZ	ONGON	12	06	07
1047	137	120608	LA LIBERTAD	PATAZ	PARCOY	12	06	08
1048	137	921205	AMERICA	EL SALVADOR	SAN MIGUEL	92	12	05
1049	137	921206	AMERICA	EL SALVADOR	LA PAZ	92	12	06
1050	137	921207	AMERICA	EL SALVADOR	LA LIBERTAD	92	12	07
1051	137	120610	LA LIBERTAD	PATAZ	PIAS	12	06	10
1052	137	120611	LA LIBERTAD	PATAZ	TAURIJA	12	06	11
1053	137	120612	LA LIBERTAD	PATAZ	URPAY	12	06	12
1054	137	120613	LA LIBERTAD	PATAZ	SANTIAGO DE CHALLAS	12	06	13
1055	137	120701	LA LIBERTAD	SANTIAGO DE CHUCO	SANTIAGO DE CHUCO	12	07	01
1056	137	120702	LA LIBERTAD	SANTIAGO DE CHUCO	CACHICADAN	12	07	02
1057	137	120703	LA LIBERTAD	SANTIAGO DE CHUCO	MOLLEBAMBA	12	07	03
1058	137	120704	LA LIBERTAD	SANTIAGO DE CHUCO	MOLLEPATA	12	07	04
1059	137	120705	LA LIBERTAD	SANTIAGO DE CHUCO	QUIRUVILCA	12	07	05
1060	137	120706	LA LIBERTAD	SANTIAGO DE CHUCO	SANTA CRUZ DE CHUCA	12	07	06
1061	137	120707	LA LIBERTAD	SANTIAGO DE CHUCO	SITABAMBA	12	07	07
1062	137	120708	LA LIBERTAD	SANTIAGO DE CHUCO	ANGASMARCA	12	07	08
1063	137	120801	LA LIBERTAD	ASCOPE	ASCOPE	12	08	01
1064	137	120802	LA LIBERTAD	ASCOPE	CHICAMA	12	08	02
1065	137	120803	LA LIBERTAD	ASCOPE	CHOCOPE	12	08	03
1066	137	120804	LA LIBERTAD	ASCOPE	SANTIAGO DE CAO	12	08	04
1067	137	120805	LA LIBERTAD	ASCOPE	MAGDALENA DE CAO	12	08	05
1068	137	120806	LA LIBERTAD	ASCOPE	PAIJAN	12	08	06
1069	137	120807	LA LIBERTAD	ASCOPE	RAZURI	12	08	07
1070	137	120808	LA LIBERTAD	ASCOPE	CASA GRANDE	12	08	08
1071	137	120901	LA LIBERTAD	CHEPEN	CHEPEN	12	09	01
1072	137	120902	LA LIBERTAD	CHEPEN	PACANGA	12	09	02
1073	137	120903	LA LIBERTAD	CHEPEN	PUEBLO NUEVO	12	09	03
1074	137	121001	LA LIBERTAD	JULCAN	JULCAN	12	10	01
1075	137	121002	LA LIBERTAD	JULCAN	CARABAMBA	12	10	02
1076	137	121003	LA LIBERTAD	JULCAN	CALAMARCA	12	10	03
1077	137	121004	LA LIBERTAD	JULCAN	HUASO	12	10	04
1078	137	121101	LA LIBERTAD	GRAN CHIMU	CASCAS	12	11	01
1079	137	121102	LA LIBERTAD	GRAN CHIMU	LUCMA	12	11	02
1080	137	121103	LA LIBERTAD	GRAN CHIMU	MARMOT	12	11	03
1081	137	121104	LA LIBERTAD	GRAN CHIMU	SAYAPULLO	12	11	04
1082	137	121201	LA LIBERTAD	VIRU	VIRU	12	12	01
1083	137	121202	LA LIBERTAD	VIRU	CHAO	12	12	02
1084	137	121203	LA LIBERTAD	VIRU	GUADALUPITO	12	12	03
1085	137	130101	LAMBAYEQUE	CHICLAYO	CHICLAYO	13	01	01
1086	137	130102	LAMBAYEQUE	CHICLAYO	CHONGOYAPE	13	01	02
1087	137	130103	LAMBAYEQUE	CHICLAYO	ETEN	13	01	03
1088	137	130104	LAMBAYEQUE	CHICLAYO	ETEN PUERTO	13	01	04
1089	137	130105	LAMBAYEQUE	CHICLAYO	LAGUNAS	13	01	05
1090	137	130106	LAMBAYEQUE	CHICLAYO	MONSEFU	13	01	06
1091	137	130107	LAMBAYEQUE	CHICLAYO	NUEVA ARICA	13	01	07
1092	137	130108	LAMBAYEQUE	CHICLAYO	OYOTUN	13	01	08
1093	137	130109	LAMBAYEQUE	CHICLAYO	PICSI	13	01	09
1094	137	130110	LAMBAYEQUE	CHICLAYO	PIMENTEL	13	01	10
1095	137	130111	LAMBAYEQUE	CHICLAYO	REQUE	13	01	11
1096	137	130112	LAMBAYEQUE	CHICLAYO	JOSE LEONARDO ORTIZ	13	01	12
1097	137	130113	LAMBAYEQUE	CHICLAYO	SANTA ROSA	13	01	13
1098	137	130114	LAMBAYEQUE	CHICLAYO	SAÑA	13	01	14
1099	137	130115	LAMBAYEQUE	CHICLAYO	LA VICTORIA	13	01	15
1100	137	130116	LAMBAYEQUE	CHICLAYO	CAYALTI	13	01	16
1101	137	130117	LAMBAYEQUE	CHICLAYO	PATAPO	13	01	17
1102	137	130118	LAMBAYEQUE	CHICLAYO	POMALCA	13	01	18
1103	137	130119	LAMBAYEQUE	CHICLAYO	PUCALA	13	01	19
1104	137	130120	LAMBAYEQUE	CHICLAYO	TUMAN	13	01	20
1105	137	130201	LAMBAYEQUE	FERREÑAFE	FERREÑAFE	13	02	01
1106	137	130202	LAMBAYEQUE	FERREÑAFE	INCAHUASI	13	02	02
1107	137	130203	LAMBAYEQUE	FERREÑAFE	CAÑARIS	13	02	03
1108	137	130204	LAMBAYEQUE	FERREÑAFE	PITIPO	13	02	04
1109	137	130205	LAMBAYEQUE	FERREÑAFE	PUEBLO NUEVO	13	02	05
1110	137	130206	LAMBAYEQUE	FERREÑAFE	MANUEL ANTONIO MESONES MURO	13	02	06
1111	137	130301	LAMBAYEQUE	LAMBAYEQUE	LAMBAYEQUE	13	03	01
1112	137	130302	LAMBAYEQUE	LAMBAYEQUE	CHOCHOPE	13	03	02
1113	137	130303	LAMBAYEQUE	LAMBAYEQUE	ILLIMO	13	03	03
1114	137	130304	LAMBAYEQUE	LAMBAYEQUE	JAYANCA	13	03	04
1115	137	130305	LAMBAYEQUE	LAMBAYEQUE	MOCHUMI	13	03	05
1116	137	130306	LAMBAYEQUE	LAMBAYEQUE	MORROPE	13	03	06
1117	137	130307	LAMBAYEQUE	LAMBAYEQUE	MOTUPE	13	03	07
1118	137	130308	LAMBAYEQUE	LAMBAYEQUE	OLMOS	13	03	08
1119	137	130309	LAMBAYEQUE	LAMBAYEQUE	PACORA	13	03	09
1120	137	130310	LAMBAYEQUE	LAMBAYEQUE	SALAS	13	03	10
1121	137	130311	LAMBAYEQUE	LAMBAYEQUE	SAN JOSE	13	03	11
1122	137	130312	LAMBAYEQUE	LAMBAYEQUE	TUCUME	13	03	12
1123	137	140101	LIMA	LIMA	LIMA	14	01	01
1126	137	140104	LIMA	LIMA	BREÑA	14	01	04
1127	137	140105	LIMA	LIMA	CARABAYLLO	14	01	05
1128	137	140106	LIMA	LIMA	COMAS	14	01	06
1129	137	140107	LIMA	LIMA	CHACLACAYO	14	01	07
1130	137	140108	LIMA	LIMA	CHORRILLOS	14	01	08
1131	137	140109	LIMA	LIMA	LA VICTORIA	14	01	09
1132	137	140110	LIMA	LIMA	LA MOLINA	14	01	10
1133	137	140111	LIMA	LIMA	LINCE	14	01	11
1134	137	140112	LIMA	LIMA	LURIGANCHO	14	01	12
1135	137	140113	LIMA	LIMA	LURIN	14	01	13
1136	137	140114	LIMA	LIMA	MAGDALENA DEL MAR	14	01	14
1137	137	140115	LIMA	LIMA	MIRAFLORES	14	01	15
1138	137	140116	LIMA	LIMA	PACHACAMAC	14	01	16
1139	137	140117	LIMA	LIMA	PUEBLO LIBRE	14	01	17
1140	137	140118	LIMA	LIMA	PUCUSANA	14	01	18
1141	137	140119	LIMA	LIMA	PUENTE PIEDRA	14	01	19
1142	137	140120	LIMA	LIMA	PUNTA HERMOSA	14	01	20
1143	137	140121	LIMA	LIMA	PUNTA NEGRA	14	01	21
1144	137	140122	LIMA	LIMA	RIMAC	14	01	22
1145	137	140123	LIMA	LIMA	SAN BARTOLO	14	01	23
1146	137	140124	LIMA	LIMA	SAN ISIDRO	14	01	24
1147	137	140125	LIMA	LIMA	BARRANCO	14	01	25
1148	137	140126	LIMA	LIMA	SAN MARTIN DE PORRES	14	01	26
1149	137	140127	LIMA	LIMA	SAN MIGUEL	14	01	27
1150	137	140128	LIMA	LIMA	SANTA MARIA DEL MAR	14	01	28
1151	137	140129	LIMA	LIMA	SANTA ROSA	14	01	29
1152	137	140130	LIMA	LIMA	SANTIAGO DE SURCO	14	01	30
1153	137	140131	LIMA	LIMA	SURQUILLO	14	01	31
1154	137	140132	LIMA	LIMA	VILLA MARIA DEL TRIUNFO	14	01	32
1155	137	140133	LIMA	LIMA	JESUS MARIA	14	01	33
1156	137	140134	LIMA	LIMA	INDEPENDENCIA	14	01	34
1157	137	140135	LIMA	LIMA	EL AGUSTINO	14	01	35
1158	137	140136	LIMA	LIMA	SAN JUAN DE MIRAFLORES	14	01	36
1159	137	140137	LIMA	LIMA	SAN JUAN DE LURIGANCHO	14	01	37
1160	137	140138	LIMA	LIMA	SAN LUIS	14	01	38
1161	137	140139	LIMA	LIMA	CIENEGUILLA	14	01	39
1162	137	140140	LIMA	LIMA	SAN BORJA	14	01	40
1163	137	140141	LIMA	LIMA	VILLA EL SALVADOR	14	01	41
1164	137	140142	LIMA	LIMA	LOS OLIVOS	14	01	42
1165	137	140143	LIMA	LIMA	SANTA ANITA	14	01	43
1166	137	140201	LIMA	CAJATAMBO	CAJATAMBO	14	02	01
1167	137	140205	LIMA	CAJATAMBO	COPA	14	02	05
1168	137	140206	LIMA	CAJATAMBO	GORGOR	14	02	06
1169	137	140207	LIMA	CAJATAMBO	HUANCAPON	14	02	07
1170	137	140208	LIMA	CAJATAMBO	MANAS	14	02	08
1171	137	140301	LIMA	CANTA	CANTA	14	03	01
1172	137	140302	LIMA	CANTA	ARAHUAY	14	03	02
1173	137	140303	LIMA	CANTA	HUAMANTANGA	14	03	03
1174	137	140304	LIMA	CANTA	HUAROS	14	03	04
1175	137	140305	LIMA	CANTA	LACHAQUI	14	03	05
1176	137	140306	LIMA	CANTA	SAN BUENAVENTURA	14	03	06
1177	137	140307	LIMA	CANTA	SANTA ROSA DE QUIVES	14	03	07
1178	137	140401	LIMA	CAÑETE	SAN VICENTE DE CAÑETE	14	04	01
1179	137	140402	LIMA	CAÑETE	CALANGO	14	04	02
1180	137	140403	LIMA	CAÑETE	CERRO AZUL	14	04	03
1181	137	140404	LIMA	CAÑETE	COAYLLO	14	04	04
1182	137	140405	LIMA	CAÑETE	CHILCA	14	04	05
1183	137	140406	LIMA	CAÑETE	IMPERIAL	14	04	06
1184	137	140407	LIMA	CAÑETE	LUNAHUANA	14	04	07
1185	137	140408	LIMA	CAÑETE	MALA	14	04	08
1186	137	140409	LIMA	CAÑETE	NUEVO IMPERIAL	14	04	09
1187	137	140410	LIMA	CAÑETE	PACARAN	14	04	10
1188	137	140411	LIMA	CAÑETE	QUILMANA	14	04	11
1189	137	140412	LIMA	CAÑETE	SAN ANTONIO	14	04	12
1190	137	140413	LIMA	CAÑETE	SAN LUIS	14	04	13
1191	137	140414	LIMA	CAÑETE	SANTA CRUZ DE FLORES	14	04	14
1192	137	140415	LIMA	CAÑETE	ZUÑIGA	14	04	15
1193	137	140416	LIMA	CAÑETE	ASIA	14	04	16
1194	137	140501	LIMA	HUAURA	HUACHO	14	05	01
1195	137	140502	LIMA	HUAURA	AMBAR	14	05	02
1196	137	140504	LIMA	HUAURA	CALETA DE CARQUIN	14	05	04
1197	137	140505	LIMA	HUAURA	CHECRAS	14	05	05
1198	137	140506	LIMA	HUAURA	HUALMAY	14	05	06
1199	137	140507	LIMA	HUAURA	HUAURA	14	05	07
1200	137	140508	LIMA	HUAURA	LEONCIO PRADO	14	05	08
1201	137	140509	LIMA	HUAURA	PACCHO	14	05	09
1202	137	140511	LIMA	HUAURA	SANTA LEONOR	14	05	11
1203	137	140512	LIMA	HUAURA	SANTA MARIA	14	05	12
1204	137	140513	LIMA	HUAURA	SAYAN	14	05	13
1205	137	140516	LIMA	HUAURA	VEGUETA	14	05	16
1206	137	140601	LIMA	HUAROCHIRI	MATUCANA	14	06	01
1207	137	140602	LIMA	HUAROCHIRI	ANTIOQUIA	14	06	02
1208	137	140603	LIMA	HUAROCHIRI	CALLAHUANCA	14	06	03
1209	137	140604	LIMA	HUAROCHIRI	CARAMPOMA	14	06	04
1210	137	140605	LIMA	HUAROCHIRI	CASTA	14	06	05
1211	137	140606	LIMA	HUAROCHIRI	SAN JOSE DE LOS CHORRILLOS	14	06	06
1212	137	140607	LIMA	HUAROCHIRI	CHICLA	14	06	07
1213	137	140608	LIMA	HUAROCHIRI	HUANZA	14	06	08
1214	137	140609	LIMA	HUAROCHIRI	HUAROCHIRI	14	06	09
1215	137	140610	LIMA	HUAROCHIRI	LAHUAYTAMBO	14	06	10
1216	137	140611	LIMA	HUAROCHIRI	LANGA	14	06	11
1217	137	140612	LIMA	HUAROCHIRI	MARIATANA	14	06	12
1218	137	140613	LIMA	HUAROCHIRI	RICARDO PALMA	14	06	13
1219	137	140614	LIMA	HUAROCHIRI	SAN ANDRES DE TUPICOCHA	14	06	14
1220	137	140615	LIMA	HUAROCHIRI	SAN ANTONIO	14	06	15
1221	137	140616	LIMA	HUAROCHIRI	SAN BARTOLOME	14	06	16
1222	137	140617	LIMA	HUAROCHIRI	SAN DAMIAN	14	06	17
1223	137	140618	LIMA	HUAROCHIRI	SANGALLAYA	14	06	18
1224	137	140619	LIMA	HUAROCHIRI	SAN JUAN DE TANTARANCHE	14	06	19
1225	137	140620	LIMA	HUAROCHIRI	SAN LORENZO DE QUINTI	14	06	20
1226	137	140621	LIMA	HUAROCHIRI	SAN MATEO	14	06	21
1227	137	140622	LIMA	HUAROCHIRI	SAN MATEO DE OTAO	14	06	22
1228	137	140623	LIMA	HUAROCHIRI	SAN PEDRO DE HUANCAYRE	14	06	23
1229	137	140624	LIMA	HUAROCHIRI	SANTA CRUZ DE COCACHACRA	14	06	24
1230	137	140625	LIMA	HUAROCHIRI	SANTA EULALIA	14	06	25
1231	137	140626	LIMA	HUAROCHIRI	SANTIAGO DE ANCHUCAYA	14	06	26
1232	137	140627	LIMA	HUAROCHIRI	SANTIAGO DE TUNA	14	06	27
1233	137	140628	LIMA	HUAROCHIRI	SANTO DOMINGO DE LOS OLLEROS	14	06	28
1234	137	140629	LIMA	HUAROCHIRI	SURCO	14	06	29
1235	137	140630	LIMA	HUAROCHIRI	HUACHUPAMPA	14	06	30
1236	137	140631	LIMA	HUAROCHIRI	LARAOS	14	06	31
1237	137	140632	LIMA	HUAROCHIRI	SAN JUAN DE IRIS	14	06	32
1238	137	140701	LIMA	YAUYOS	YAUYOS	14	07	01
1239	137	140702	LIMA	YAUYOS	ALIS	14	07	02
1240	137	140703	LIMA	YAUYOS	ALLAUCA	14	07	03
1241	137	140704	LIMA	YAUYOS	AYAVIRI	14	07	04
1242	137	140705	LIMA	YAUYOS	AZANGARO	14	07	05
1243	137	140706	LIMA	YAUYOS	CACRA	14	07	06
1244	137	140707	LIMA	YAUYOS	CARANIA	14	07	07
1245	137	140708	LIMA	YAUYOS	COCHAS	14	07	08
1246	137	140709	LIMA	YAUYOS	COLONIA	14	07	09
1247	137	140710	LIMA	YAUYOS	CHOCOS	14	07	10
1248	137	140711	LIMA	YAUYOS	HUAMPARA	14	07	11
1249	137	140712	LIMA	YAUYOS	HUANCAYA	14	07	12
1250	137	140713	LIMA	YAUYOS	HUANGASCAR	14	07	13
1251	137	140714	LIMA	YAUYOS	HUANTAN	14	07	14
1252	137	140715	LIMA	YAUYOS	HUAÑEC	14	07	15
1253	137	140716	LIMA	YAUYOS	LARAOS	14	07	16
1254	137	140717	LIMA	YAUYOS	LINCHA	14	07	17
1255	137	140718	LIMA	YAUYOS	MIRAFLORES	14	07	18
1256	137	140719	LIMA	YAUYOS	OMAS	14	07	19
1257	137	140720	LIMA	YAUYOS	QUINCHES	14	07	20
1258	137	140721	LIMA	YAUYOS	QUINOCAY	14	07	21
1259	137	140722	LIMA	YAUYOS	SAN JOAQUIN	14	07	22
1260	137	140723	LIMA	YAUYOS	SAN PEDRO DE PILAS	14	07	23
1261	137	140724	LIMA	YAUYOS	TANTA	14	07	24
1262	137	140725	LIMA	YAUYOS	TAURIPAMPA	14	07	25
1263	137	140726	LIMA	YAUYOS	TUPE	14	07	26
1264	137	140727	LIMA	YAUYOS	TOMAS	14	07	27
1265	137	140728	LIMA	YAUYOS	VIÑAC	14	07	28
1266	137	140729	LIMA	YAUYOS	VITIS	14	07	29
1267	137	140730	LIMA	YAUYOS	HONGOS	14	07	30
1268	137	140731	LIMA	YAUYOS	MADEAN	14	07	31
1269	137	140732	LIMA	YAUYOS	PUTINZA	14	07	32
1270	137	140733	LIMA	YAUYOS	CATAHUASI	14	07	33
1271	137	140801	LIMA	HUARAL	HUARAL	14	08	01
1272	137	140802	LIMA	HUARAL	ATAVILLOS ALTO	14	08	02
1273	137	140803	LIMA	HUARAL	ATAVILLOS BAJO	14	08	03
1274	137	140804	LIMA	HUARAL	AUCALLAMA	14	08	04
1275	137	140805	LIMA	HUARAL	CHANCAY	14	08	05
1276	137	140806	LIMA	HUARAL	IHUARI	14	08	06
1277	137	140807	LIMA	HUARAL	LAMPIAN	14	08	07
1278	137	140808	LIMA	HUARAL	PACARAOS	14	08	08
1279	137	140809	LIMA	HUARAL	SAN MIGUEL DE ACOS	14	08	09
1280	137	140810	LIMA	HUARAL	VEINTISIETE DE NOVIEMBRE	14	08	10
1281	137	140811	LIMA	HUARAL	SANTA CRUZ DE ANDAMARCA	14	08	11
1282	137	140812	LIMA	HUARAL	SUMBILCA	14	08	12
1283	137	140901	LIMA	BARRANCA	BARRANCA	14	09	01
1284	137	140902	LIMA	BARRANCA	PARAMONGA	14	09	02
1285	137	140903	LIMA	BARRANCA	PATIVILCA	14	09	03
1286	137	140904	LIMA	BARRANCA	SUPE	14	09	04
1287	137	140905	LIMA	BARRANCA	SUPE PUERTO	14	09	05
1288	137	141001	LIMA	OYON	OYON	14	10	01
1289	137	141002	LIMA	OYON	NAVAN	14	10	02
1290	137	141003	LIMA	OYON	CAUJUL	14	10	03
1291	137	141004	LIMA	OYON	ANDAJES	14	10	04
1292	137	141005	LIMA	OYON	PACHANGARA	14	10	05
1293	137	141006	LIMA	OYON	COCHAMARCA	14	10	06
1294	137	150101	LORETO	MAYNAS	IQUITOS	15	01	01
1295	137	150102	LORETO	MAYNAS	ALTO NANAY	15	01	02
1296	137	150103	LORETO	MAYNAS	FERNANDO LORES	15	01	03
1297	137	150104	LORETO	MAYNAS	LAS AMAZONAS	15	01	04
1298	137	150105	LORETO	MAYNAS	MAZAN	15	01	05
1299	137	150106	LORETO	MAYNAS	NAPO	15	01	06
1300	137	150108	LORETO	MAYNAS	TORRES CAUSANA	15	01	08
1301	137	150110	LORETO	MAYNAS	INDIANA	15	01	10
1302	137	150111	LORETO	MAYNAS	PUNCHANA	15	01	11
1303	137	150112	LORETO	MAYNAS	BELEN	15	01	12
1304	137	150113	LORETO	MAYNAS	SAN JUAN BAUTISTA	15	01	13
1305	137	150201	LORETO	ALTO AMAZONAS	YURIMAGUAS	15	02	01
1306	137	150202	LORETO	ALTO AMAZONAS	BALSAPUERTO	15	02	02
1307	137	150205	LORETO	ALTO AMAZONAS	JEBEROS	15	02	05
1308	137	150206	LORETO	ALTO AMAZONAS	LAGUNAS	15	02	06
1309	137	150210	LORETO	ALTO AMAZONAS	SANTA CRUZ	15	02	10
1310	137	150211	LORETO	ALTO AMAZONAS	TENIENTE CESAR LOPEZ ROJAS	15	02	11
1311	137	150301	LORETO	LORETO	NAUTA	15	03	01
1312	137	150302	LORETO	LORETO	PARINARI	15	03	02
1313	137	150303	LORETO	LORETO	TIGRE	15	03	03
1314	137	150304	LORETO	LORETO	URARINAS	15	03	04
1315	137	150305	LORETO	LORETO	TROMPETEROS	15	03	05
1316	137	150401	LORETO	REQUENA	REQUENA	15	04	01
1317	137	150402	LORETO	REQUENA	ALTO TAPICHE	15	04	02
1318	137	150403	LORETO	REQUENA	CAPELO	15	04	03
1319	137	150404	LORETO	REQUENA	EMILIO SAN MARTIN	15	04	04
1320	137	150405	LORETO	REQUENA	MAQUIA	15	04	05
1321	137	150406	LORETO	REQUENA	PUINAHUA	15	04	06
1322	137	150407	LORETO	REQUENA	SAQUENA	15	04	07
1323	137	150408	LORETO	REQUENA	SOPLIN	15	04	08
1324	137	150409	LORETO	REQUENA	TAPICHE	15	04	09
1325	137	150410	LORETO	REQUENA	JENARO HERRERA	15	04	10
1326	137	150411	LORETO	REQUENA	YAQUERANA	15	04	11
1327	137	150501	LORETO	UCAYALI	CONTAMANA	15	05	01
1328	137	150502	LORETO	UCAYALI	VARGAS GUERRA	15	05	02
1329	137	150503	LORETO	UCAYALI	PADRE MARQUEZ	15	05	03
1330	137	150504	LORETO	UCAYALI	PAMPA HERMOSA	15	05	04
1331	137	150505	LORETO	UCAYALI	SARAYACU	15	05	05
1332	137	150506	LORETO	UCAYALI	INAHUAYA	15	05	06
1333	137	150601	LORETO	MARISCAL RAMON CASTILLA	RAMON CASTILLA	15	06	01
1334	137	150602	LORETO	MARISCAL RAMON CASTILLA	PEBAS	15	06	02
1335	137	150603	LORETO	MARISCAL RAMON CASTILLA	YAVARI	15	06	03
1336	137	150604	LORETO	MARISCAL RAMON CASTILLA	SAN PABLO	15	06	04
1337	137	150701	LORETO	DATEM DEL MARAÑON	BARRANCA	15	07	01
1338	137	150702	LORETO	DATEM DEL MARAÑON	ANDOAS	15	07	02
1339	137	150703	LORETO	DATEM DEL MARAÑON	CAHUAPANAS	15	07	03
1340	137	150704	LORETO	DATEM DEL MARAÑON	MANSERICHE	15	07	04
1341	137	150705	LORETO	DATEM DEL MARAÑON	MORONA	15	07	05
1342	137	150706	LORETO	DATEM DEL MARAÑON	PASTAZA	15	07	06
1343	137	150901	LORETO	PUTUMAYO	PUTUMAYO	15	09	01
1344	137	150902	LORETO	PUTUMAYO	ROSA PANDURO	15	09	02
1345	137	150903	LORETO	PUTUMAYO	TENIENTE MANUEL CLAVERO	15	09	03
1346	137	150904	LORETO	PUTUMAYO	YAGUAS	15	09	04
1347	137	160101	MADRE DE DIOS	TAMBOPATA	TAMBOPATA	16	01	01
1348	137	160102	MADRE DE DIOS	TAMBOPATA	INAMBARI	16	01	02
1349	137	160103	MADRE DE DIOS	TAMBOPATA	LAS PIEDRAS	16	01	03
1350	137	160104	MADRE DE DIOS	TAMBOPATA	LABERINTO	16	01	04
1351	137	160201	MADRE DE DIOS	MANU	MANU	16	02	01
1352	137	160202	MADRE DE DIOS	MANU	FITZCARRALD	16	02	02
1353	137	160203	MADRE DE DIOS	MANU	MADRE DE DIOS	16	02	03
1354	137	160204	MADRE DE DIOS	MANU	HUEPETUHE	16	02	04
1355	137	160301	MADRE DE DIOS	TAHUAMANU	IÑAPARI	16	03	01
1356	137	160302	MADRE DE DIOS	TAHUAMANU	IBERIA	16	03	02
1357	137	160303	MADRE DE DIOS	TAHUAMANU	TAHUAMANU	16	03	03
1358	137	170101	MOQUEGUA	MARISCAL NIETO	MOQUEGUA	17	01	01
1359	137	170102	MOQUEGUA	MARISCAL NIETO	CARUMAS	17	01	02
1360	137	170103	MOQUEGUA	MARISCAL NIETO	CUCHUMBAYA	17	01	03
1361	137	170104	MOQUEGUA	MARISCAL NIETO	SAN CRISTOBAL	17	01	04
1362	137	170105	MOQUEGUA	MARISCAL NIETO	TORATA	17	01	05
1363	137	170106	MOQUEGUA	MARISCAL NIETO	SAMEGUA	17	01	06
1364	137	170201	MOQUEGUA	GENERAL SANCHEZ CERRO	OMATE	17	02	01
1365	137	170202	MOQUEGUA	GENERAL SANCHEZ CERRO	COALAQUE	17	02	02
1366	137	170203	MOQUEGUA	GENERAL SANCHEZ CERRO	CHOJATA	17	02	03
1367	137	170204	MOQUEGUA	GENERAL SANCHEZ CERRO	ICHUÑA	17	02	04
1368	137	170205	MOQUEGUA	GENERAL SANCHEZ CERRO	LA CAPILLA	17	02	05
1369	137	170206	MOQUEGUA	GENERAL SANCHEZ CERRO	LLOQUE	17	02	06
1370	137	170207	MOQUEGUA	GENERAL SANCHEZ CERRO	MATALAQUE	17	02	07
1371	137	170208	MOQUEGUA	GENERAL SANCHEZ CERRO	PUQUINA	17	02	08
1372	137	170209	MOQUEGUA	GENERAL SANCHEZ CERRO	QUINISTAQUILLAS	17	02	09
1373	137	170210	MOQUEGUA	GENERAL SANCHEZ CERRO	UBINAS	17	02	10
1374	137	170211	MOQUEGUA	GENERAL SANCHEZ CERRO	YUNGA	17	02	11
1375	137	170301	MOQUEGUA	ILO	ILO	17	03	01
1376	137	170302	MOQUEGUA	ILO	EL ALGARROBAL	17	03	02
1377	137	170303	MOQUEGUA	ILO	PACOCHA	17	03	03
1378	137	180101	PASCO	PASCO	CHAUPIMARCA	18	01	01
1379	137	180103	PASCO	PASCO	HUACHON	18	01	03
1380	137	180104	PASCO	PASCO	HUARIACA	18	01	04
1381	137	180105	PASCO	PASCO	HUAYLLAY	18	01	05
1382	137	180106	PASCO	PASCO	NINACACA	18	01	06
1383	137	180107	PASCO	PASCO	PALLANCHACRA	18	01	07
1384	137	180108	PASCO	PASCO	PAUCARTAMBO	18	01	08
1385	137	180109	PASCO	PASCO	SAN FCO DE ASIS DE YARUSYACAN	18	01	09
1386	137	180110	PASCO	PASCO	SIMON BOLIVAR	18	01	10
1387	137	180111	PASCO	PASCO	TICLACAYAN	18	01	11
1388	137	180112	PASCO	PASCO	TINYAHUARCO	18	01	12
1389	137	180113	PASCO	PASCO	VICCO	18	01	13
1390	137	180114	PASCO	PASCO	YANACANCHA	18	01	14
1391	137	180201	PASCO	DANIEL ALCIDES CARRION	YANAHUANCA	18	02	01
1392	137	180202	PASCO	DANIEL ALCIDES CARRION	CHACAYAN	18	02	02
1393	137	180203	PASCO	DANIEL ALCIDES CARRION	GOYLLARISQUIZGA	18	02	03
1394	137	180204	PASCO	DANIEL ALCIDES CARRION	PAUCAR	18	02	04
1395	137	180205	PASCO	DANIEL ALCIDES CARRION	SAN PEDRO DE PILLAO	18	02	05
1396	137	180206	PASCO	DANIEL ALCIDES CARRION	SANTA ANA DE TUSI	18	02	06
1397	137	180207	PASCO	DANIEL ALCIDES CARRION	TAPUC	18	02	07
1398	137	180208	PASCO	DANIEL ALCIDES CARRION	VILCABAMBA	18	02	08
1399	137	180301	PASCO	OXAPAMPA	OXAPAMPA	18	03	01
1400	137	180302	PASCO	OXAPAMPA	CHONTABAMBA	18	03	02
1401	137	180303	PASCO	OXAPAMPA	HUANCABAMBA	18	03	03
1402	137	180304	PASCO	OXAPAMPA	PUERTO BERMUDEZ	18	03	04
1403	137	180305	PASCO	OXAPAMPA	VILLA RICA	18	03	05
1404	137	180306	PASCO	OXAPAMPA	POZUZO	18	03	06
1405	137	180307	PASCO	OXAPAMPA	PALCAZU	18	03	07
1406	137	180308	PASCO	OXAPAMPA	CONSTITUCION	18	03	08
1407	137	190101	PIURA	PIURA	PIURA	19	01	01
1408	137	190103	PIURA	PIURA	CASTILLA	19	01	03
1409	137	190104	PIURA	PIURA	CATACAOS	19	01	04
1410	137	190105	PIURA	PIURA	LA ARENA	19	01	05
1411	137	190106	PIURA	PIURA	LA UNION	19	01	06
1412	137	190107	PIURA	PIURA	LAS LOMAS	19	01	07
1413	137	190109	PIURA	PIURA	TAMBO GRANDE	19	01	09
1414	137	190113	PIURA	PIURA	CURA MORI	19	01	13
1415	137	190114	PIURA	PIURA	EL TALLAN	19	01	14
1416	137	190115	PIURA	PIURA	VEINTISEIS DE OCTUBRE	19	01	15
1417	137	190201	PIURA	AYABACA	AYABACA	19	02	01
1418	137	190202	PIURA	AYABACA	FRIAS	19	02	02
1419	137	190203	PIURA	AYABACA	LAGUNAS	19	02	03
1420	137	190204	PIURA	AYABACA	MONTERO	19	02	04
1421	137	190205	PIURA	AYABACA	PACAIPAMPA	19	02	05
1422	137	190206	PIURA	AYABACA	SAPILLICA	19	02	06
1423	137	190207	PIURA	AYABACA	SICCHEZ	19	02	07
1424	137	190208	PIURA	AYABACA	SUYO	19	02	08
1425	137	190209	PIURA	AYABACA	JILILI	19	02	09
1426	137	190210	PIURA	AYABACA	PAIMAS	19	02	10
1427	137	190301	PIURA	HUANCABAMBA	HUANCABAMBA	19	03	01
1428	137	190302	PIURA	HUANCABAMBA	CANCHAQUE	19	03	02
1429	137	190303	PIURA	HUANCABAMBA	HUARMACA	19	03	03
1430	137	190304	PIURA	HUANCABAMBA	SONDOR	19	03	04
1431	137	190305	PIURA	HUANCABAMBA	SONDORILLO	19	03	05
1432	137	190306	PIURA	HUANCABAMBA	EL CARMEN DE LA FRONTERA	19	03	06
1433	137	190307	PIURA	HUANCABAMBA	SAN MIGUEL DE EL FAIQUE	19	03	07
1434	137	190308	PIURA	HUANCABAMBA	LALAQUIZ	19	03	08
1435	137	190401	PIURA	MORROPON	CHULUCANAS	19	04	01
1436	137	190402	PIURA	MORROPON	BUENOS AIRES	19	04	02
1437	137	190403	PIURA	MORROPON	CHALACO	19	04	03
1438	137	190404	PIURA	MORROPON	MORROPON	19	04	04
1439	137	190405	PIURA	MORROPON	SALITRAL	19	04	05
1440	137	190406	PIURA	MORROPON	SANTA CATALINA DE MOSSA	19	04	06
1441	137	190407	PIURA	MORROPON	SANTO DOMINGO	19	04	07
1442	137	190408	PIURA	MORROPON	LA MATANZA	19	04	08
1443	137	190409	PIURA	MORROPON	YAMANGO	19	04	09
1444	137	190410	PIURA	MORROPON	SAN JUAN DE BIGOTE	19	04	10
1445	137	190501	PIURA	PAITA	PAITA	19	05	01
1446	137	190502	PIURA	PAITA	AMOTAPE	19	05	02
1447	137	190503	PIURA	PAITA	ARENAL	19	05	03
1448	137	190504	PIURA	PAITA	LA HUACA	19	05	04
1449	137	190505	PIURA	PAITA	COLAN	19	05	05
1450	137	190506	PIURA	PAITA	TAMARINDO	19	05	06
1451	137	190507	PIURA	PAITA	VICHAYAL	19	05	07
1452	137	190601	PIURA	SULLANA	SULLANA	19	06	01
1453	137	190602	PIURA	SULLANA	BELLAVISTA	19	06	02
1454	137	190603	PIURA	SULLANA	LANCONES	19	06	03
1455	137	190604	PIURA	SULLANA	MARCAVELICA	19	06	04
1456	137	190605	PIURA	SULLANA	MIGUEL CHECA	19	06	05
1457	137	190606	PIURA	SULLANA	QUERECOTILLO	19	06	06
1458	137	190607	PIURA	SULLANA	SALITRAL	19	06	07
1459	137	190608	PIURA	SULLANA	IGNACIO ESCUDERO	19	06	08
1460	137	190701	PIURA	TALARA	PARIÑAS	19	07	01
1461	137	190702	PIURA	TALARA	EL ALTO	19	07	02
1462	137	190703	PIURA	TALARA	LA BREA	19	07	03
1463	137	190704	PIURA	TALARA	LOBITOS	19	07	04
1464	137	190705	PIURA	TALARA	MANCORA	19	07	05
1465	137	190706	PIURA	TALARA	LOS ORGANOS	19	07	06
1466	137	190801	PIURA	SECHURA	SECHURA	19	08	01
1467	137	190802	PIURA	SECHURA	VICE	19	08	02
1468	137	190803	PIURA	SECHURA	BERNAL	19	08	03
1469	137	190804	PIURA	SECHURA	BELLAVISTA DE LA UNION	19	08	04
1470	137	190805	PIURA	SECHURA	CRISTO NOS VALGA	19	08	05
1471	137	190806	PIURA	SECHURA	RINCONADA-LLICUAR	19	08	06
1472	137	200101	PUNO	PUNO	PUNO	20	01	01
1473	137	200102	PUNO	PUNO	ACORA	20	01	02
1474	137	200103	PUNO	PUNO	ATUNCOLLA	20	01	03
1475	137	200104	PUNO	PUNO	CAPACHICA	20	01	04
1476	137	200105	PUNO	PUNO	COATA	20	01	05
1477	137	200106	PUNO	PUNO	CHUCUITO	20	01	06
1478	137	200107	PUNO	PUNO	HUATA	20	01	07
1479	137	200108	PUNO	PUNO	MAÑAZO	20	01	08
1480	137	200109	PUNO	PUNO	PAUCARCOLLA	20	01	09
1481	137	200110	PUNO	PUNO	PICHACANI	20	01	10
1482	137	200111	PUNO	PUNO	SAN ANTONIO	20	01	11
1483	137	200112	PUNO	PUNO	TIQUILLACA	20	01	12
1484	137	200113	PUNO	PUNO	VILQUE	20	01	13
1485	137	200114	PUNO	PUNO	PLATERIA	20	01	14
1486	137	200115	PUNO	PUNO	AMANTANI	20	01	15
1487	137	200201	PUNO	AZANGARO	AZANGARO	20	02	01
1488	137	200202	PUNO	AZANGARO	ACHAYA	20	02	02
1489	137	200203	PUNO	AZANGARO	ARAPA	20	02	03
1490	137	200204	PUNO	AZANGARO	ASILLO	20	02	04
1491	137	200205	PUNO	AZANGARO	CAMINACA	20	02	05
1492	137	200206	PUNO	AZANGARO	CHUPA	20	02	06
1493	137	200207	PUNO	AZANGARO	JOSE DOMINGO CHOQUEHUANCA	20	02	07
1494	137	200208	PUNO	AZANGARO	MUÑANI	20	02	08
1495	137	200210	PUNO	AZANGARO	POTONI	20	02	10
1496	137	200212	PUNO	AZANGARO	SAMAN	20	02	12
1497	137	200213	PUNO	AZANGARO	SAN ANTON	20	02	13
1498	137	200214	PUNO	AZANGARO	SAN JOSE	20	02	14
1499	137	200215	PUNO	AZANGARO	SAN JUAN DE SALINAS	20	02	15
1500	137	200216	PUNO	AZANGARO	SANTIAGO DE PUPUJA	20	02	16
1501	137	200217	PUNO	AZANGARO	TIRAPATA	20	02	17
1502	137	200301	PUNO	CARABAYA	MACUSANI	20	03	01
1503	137	200302	PUNO	CARABAYA	AJOYANI	20	03	02
1504	137	200303	PUNO	CARABAYA	AYAPATA	20	03	03
1505	137	200304	PUNO	CARABAYA	COASA	20	03	04
1506	137	200305	PUNO	CARABAYA	CORANI	20	03	05
1507	137	200306	PUNO	CARABAYA	CRUCERO	20	03	06
1508	137	200307	PUNO	CARABAYA	ITUATA	20	03	07
1509	137	200308	PUNO	CARABAYA	OLLACHEA	20	03	08
1510	137	200309	PUNO	CARABAYA	SAN GABAN	20	03	09
1511	137	200310	PUNO	CARABAYA	USICAYOS	20	03	10
1512	137	200401	PUNO	CHUCUITO	JULI	20	04	01
1513	137	200402	PUNO	CHUCUITO	DESAGUADERO	20	04	02
1514	137	200403	PUNO	CHUCUITO	HUACULLANI	20	04	03
1515	137	200406	PUNO	CHUCUITO	PISACOMA	20	04	06
1516	137	200407	PUNO	CHUCUITO	POMATA	20	04	07
1517	137	200410	PUNO	CHUCUITO	ZEPITA	20	04	10
1518	137	200412	PUNO	CHUCUITO	KELLUYO	20	04	12
1519	137	200501	PUNO	HUANCANE	HUANCANE	20	05	01
1520	137	200502	PUNO	HUANCANE	COJATA	20	05	02
1521	137	200504	PUNO	HUANCANE	INCHUPALLA	20	05	04
1522	137	200506	PUNO	HUANCANE	PUSI	20	05	06
1523	137	200507	PUNO	HUANCANE	ROSASPATA	20	05	07
1524	137	200508	PUNO	HUANCANE	TARACO	20	05	08
1525	137	200509	PUNO	HUANCANE	VILQUE CHICO	20	05	09
1526	137	200511	PUNO	HUANCANE	HUATASANI	20	05	11
1527	137	200601	PUNO	LAMPA	LAMPA	20	06	01
1528	137	200602	PUNO	LAMPA	CABANILLA	20	06	02
1529	137	200603	PUNO	LAMPA	CALAPUJA	20	06	03
1530	137	200604	PUNO	LAMPA	NICASIO	20	06	04
1531	137	200605	PUNO	LAMPA	OCUVIRI	20	06	05
1532	137	200606	PUNO	LAMPA	PALCA	20	06	06
1533	137	200607	PUNO	LAMPA	PARATIA	20	06	07
1534	137	200608	PUNO	LAMPA	PUCARA	20	06	08
1535	137	200609	PUNO	LAMPA	SANTA LUCIA	20	06	09
1536	137	200610	PUNO	LAMPA	VILAVILA	20	06	10
1537	137	200701	PUNO	MELGAR	AYAVIRI	20	07	01
1538	137	200702	PUNO	MELGAR	ANTAUTA	20	07	02
1539	137	200703	PUNO	MELGAR	CUPI	20	07	03
1540	137	200704	PUNO	MELGAR	LLALLI	20	07	04
1541	137	200705	PUNO	MELGAR	MACARI	20	07	05
1542	137	200706	PUNO	MELGAR	NUÑOA	20	07	06
1543	137	200707	PUNO	MELGAR	ORURILLO	20	07	07
1544	137	200708	PUNO	MELGAR	SANTA ROSA	20	07	08
1545	137	200709	PUNO	MELGAR	UMACHIRI	20	07	09
1546	137	200801	PUNO	SANDIA	SANDIA	20	08	01
1547	137	200803	PUNO	SANDIA	CUYOCUYO	20	08	03
1548	137	200804	PUNO	SANDIA	LIMBANI	20	08	04
1549	137	200805	PUNO	SANDIA	PHARA	20	08	05
1550	137	200806	PUNO	SANDIA	PATAMBUCO	20	08	06
1551	137	200807	PUNO	SANDIA	QUIACA	20	08	07
1552	137	200808	PUNO	SANDIA	SAN JUAN DEL ORO	20	08	08
1553	137	200810	PUNO	SANDIA	YANAHUAYA	20	08	10
1554	137	200811	PUNO	SANDIA	ALTO INAMBARI	20	08	11
1555	137	200812	PUNO	SANDIA	SAN PEDRO DE PUTINA PUNCO	20	08	12
1556	137	200901	PUNO	SAN ROMAN	JULIACA	20	09	01
1557	137	200902	PUNO	SAN ROMAN	CABANA	20	09	02
1558	137	200903	PUNO	SAN ROMAN	CABANILLAS	20	09	03
1559	137	200904	PUNO	SAN ROMAN	CARACOTO	20	09	04
1560	137	201001	PUNO	YUNGUYO	YUNGUYO	20	10	01
1561	137	201002	PUNO	YUNGUYO	UNICACHI	20	10	02
1562	137	201003	PUNO	YUNGUYO	ANAPIA	20	10	03
1563	137	201004	PUNO	YUNGUYO	COPANI	20	10	04
1564	137	201005	PUNO	YUNGUYO	CUTURAPI	20	10	05
1565	137	201006	PUNO	YUNGUYO	OLLARAYA	20	10	06
1566	137	201007	PUNO	YUNGUYO	TINICACHI	20	10	07
1567	137	201101	PUNO	SAN ANTONIO DE PUTINA	PUTINA	20	11	01
1568	137	201102	PUNO	SAN ANTONIO DE PUTINA	PEDRO VILCA APAZA	20	11	02
1569	137	201103	PUNO	SAN ANTONIO DE PUTINA	QUILCAPUNCU	20	11	03
1570	137	201104	PUNO	SAN ANTONIO DE PUTINA	ANANEA	20	11	04
1571	137	201105	PUNO	SAN ANTONIO DE PUTINA	SINA	20	11	05
1572	137	201201	PUNO	EL COLLAO	ILAVE	20	12	01
1573	137	201202	PUNO	EL COLLAO	PILCUYO	20	12	02
1574	137	201203	PUNO	EL COLLAO	SANTA ROSA	20	12	03
1575	137	201204	PUNO	EL COLLAO	CAPASO	20	12	04
1576	137	201205	PUNO	EL COLLAO	CONDURIRI	20	12	05
1577	137	201301	PUNO	MOHO	MOHO	20	13	01
1578	137	201302	PUNO	MOHO	CONIMA	20	13	02
1579	137	201303	PUNO	MOHO	TILALI	20	13	03
1580	137	201304	PUNO	MOHO	HUAYRAPATA	20	13	04
1581	137	210101	SAN MARTIN	MOYOBAMBA	MOYOBAMBA	21	01	01
1582	137	210102	SAN MARTIN	MOYOBAMBA	CALZADA	21	01	02
1583	137	210103	SAN MARTIN	MOYOBAMBA	HABANA	21	01	03
1584	137	210104	SAN MARTIN	MOYOBAMBA	JEPELACIO	21	01	04
1585	137	210105	SAN MARTIN	MOYOBAMBA	SORITOR	21	01	05
1586	137	210106	SAN MARTIN	MOYOBAMBA	YANTALO	21	01	06
1587	137	210201	SAN MARTIN	HUALLAGA	SAPOSOA	21	02	01
1588	137	210202	SAN MARTIN	HUALLAGA	PISCOYACU	21	02	02
1589	137	210203	SAN MARTIN	HUALLAGA	SACANCHE	21	02	03
1590	137	210204	SAN MARTIN	HUALLAGA	TINGO DE SAPOSOA	21	02	04
1591	137	210205	SAN MARTIN	HUALLAGA	ALTO SAPOSOA	21	02	05
1592	137	210206	SAN MARTIN	HUALLAGA	EL ESLABON	21	02	06
1593	137	210301	SAN MARTIN	LAMAS	LAMAS	21	03	01
1594	137	210303	SAN MARTIN	LAMAS	BARRANQUITA	21	03	03
1595	137	210304	SAN MARTIN	LAMAS	CAYNARACHI	21	03	04
1596	137	210305	SAN MARTIN	LAMAS	CUÑUMBUQUI	21	03	05
1597	137	210306	SAN MARTIN	LAMAS	PINTO RECODO	21	03	06
1598	137	210307	SAN MARTIN	LAMAS	RUMISAPA	21	03	07
1599	137	210311	SAN MARTIN	LAMAS	SHANAO	21	03	11
1600	137	210313	SAN MARTIN	LAMAS	TABALOSOS	21	03	13
1601	137	210314	SAN MARTIN	LAMAS	ZAPATERO	21	03	14
1602	137	210315	SAN MARTIN	LAMAS	ALONSO DE ALVARADO	21	03	15
1603	137	210316	SAN MARTIN	LAMAS	SAN ROQUE DE CUMBAZA	21	03	16
1604	137	210401	SAN MARTIN	MARISCAL CACERES	JUANJUI	21	04	01
1605	137	210402	SAN MARTIN	MARISCAL CACERES	CAMPANILLA	21	04	02
1606	137	210403	SAN MARTIN	MARISCAL CACERES	HUICUNGO	21	04	03
1607	137	210404	SAN MARTIN	MARISCAL CACERES	PACHIZA	21	04	04
1608	137	210405	SAN MARTIN	MARISCAL CACERES	PAJARILLO	21	04	05
1609	137	210501	SAN MARTIN	RIOJA	RIOJA	21	05	01
1610	137	210502	SAN MARTIN	RIOJA	POSIC	21	05	02
1611	137	210503	SAN MARTIN	RIOJA	YORONGOS	21	05	03
1612	137	210504	SAN MARTIN	RIOJA	YURACYACU	21	05	04
1613	137	210505	SAN MARTIN	RIOJA	NUEVA CAJAMARCA	21	05	05
1614	137	210506	SAN MARTIN	RIOJA	ELIAS SOPLIN VARGAS	21	05	06
1615	137	210507	SAN MARTIN	RIOJA	SAN FERNANDO	21	05	07
1616	137	210508	SAN MARTIN	RIOJA	PARDO MIGUEL	21	05	08
1617	137	210509	SAN MARTIN	RIOJA	AWAJUN	21	05	09
1618	137	210601	SAN MARTIN	SAN MARTIN	TARAPOTO	21	06	01
1619	137	210602	SAN MARTIN	SAN MARTIN	ALBERTO LEVEAU	21	06	02
1620	137	210604	SAN MARTIN	SAN MARTIN	CACATACHI	21	06	04
1621	137	210606	SAN MARTIN	SAN MARTIN	CHAZUTA	21	06	06
1622	137	210607	SAN MARTIN	SAN MARTIN	CHIPURANA	21	06	07
1623	137	210608	SAN MARTIN	SAN MARTIN	EL PORVENIR	21	06	08
1624	137	210609	SAN MARTIN	SAN MARTIN	HUIMBAYOC	21	06	09
1625	137	210610	SAN MARTIN	SAN MARTIN	JUAN GUERRA	21	06	10
1626	137	210611	SAN MARTIN	SAN MARTIN	MORALES	21	06	11
1627	137	210612	SAN MARTIN	SAN MARTIN	PAPAPLAYA	21	06	12
1628	137	210616	SAN MARTIN	SAN MARTIN	SAN ANTONIO	21	06	16
1629	137	210619	SAN MARTIN	SAN MARTIN	SAUCE	21	06	19
1630	137	210620	SAN MARTIN	SAN MARTIN	SHAPAJA	21	06	20
1631	137	210621	SAN MARTIN	SAN MARTIN	LA BANDA DE SHILCAYO	21	06	21
1632	137	210701	SAN MARTIN	BELLAVISTA	BELLAVISTA	21	07	01
1633	137	210702	SAN MARTIN	BELLAVISTA	SAN RAFAEL	21	07	02
1634	137	210703	SAN MARTIN	BELLAVISTA	SAN PABLO	21	07	03
1635	137	210704	SAN MARTIN	BELLAVISTA	ALTO BIAVO	21	07	04
1636	137	210705	SAN MARTIN	BELLAVISTA	HUALLAGA	21	07	05
1637	137	210706	SAN MARTIN	BELLAVISTA	BAJO BIAVO	21	07	06
1638	137	210801	SAN MARTIN	TOCACHE	TOCACHE	21	08	01
1639	137	210802	SAN MARTIN	TOCACHE	NUEVO PROGRESO	21	08	02
1640	137	210803	SAN MARTIN	TOCACHE	POLVORA	21	08	03
1641	137	210804	SAN MARTIN	TOCACHE	SHUNTE	21	08	04
1642	137	210805	SAN MARTIN	TOCACHE	UCHIZA	21	08	05
1643	137	210901	SAN MARTIN	PICOTA	PICOTA	21	09	01
1644	137	210902	SAN MARTIN	PICOTA	BUENOS AIRES	21	09	02
1645	137	210903	SAN MARTIN	PICOTA	CASPIZAPA	21	09	03
1646	137	210904	SAN MARTIN	PICOTA	PILLUANA	21	09	04
1647	137	210905	SAN MARTIN	PICOTA	PUCACACA	21	09	05
1648	137	210906	SAN MARTIN	PICOTA	SAN CRISTOBAL	21	09	06
1649	137	210907	SAN MARTIN	PICOTA	SAN HILARION	21	09	07
1650	137	210908	SAN MARTIN	PICOTA	TINGO DE PONASA	21	09	08
1651	137	210909	SAN MARTIN	PICOTA	TRES UNIDOS	21	09	09
1652	137	210910	SAN MARTIN	PICOTA	SHAMBOYACU	21	09	10
1653	137	211001	SAN MARTIN	EL DORADO	SAN JOSE DE SISA	21	10	01
1654	137	211002	SAN MARTIN	EL DORADO	AGUA BLANCA	21	10	02
1655	137	211003	SAN MARTIN	EL DORADO	SHATOJA	21	10	03
1656	137	211004	SAN MARTIN	EL DORADO	SAN MARTIN	21	10	04
1657	137	211005	SAN MARTIN	EL DORADO	SANTA ROSA	21	10	05
1658	137	220101	TACNA	TACNA	TACNA	22	01	01
1659	137	220102	TACNA	TACNA	CALANA	22	01	02
1660	137	220104	TACNA	TACNA	INCLAN	22	01	04
1661	137	220107	TACNA	TACNA	PACHIA	22	01	07
1662	137	220108	TACNA	TACNA	PALCA	22	01	08
1663	137	220109	TACNA	TACNA	POCOLLAY	22	01	09
1671	137	220206	TACNA	TARATA	ESTIQUE	22	02	06
1672	137	220207	TACNA	TARATA	ESTIQUE PAMPA	22	02	07
1673	137	220210	TACNA	TARATA	SITAJARA	22	02	10
1674	137	220211	TACNA	TARATA	SUSAPAYA	22	02	11
1675	137	220212	TACNA	TARATA	TARUCACHI	22	02	12
1676	137	220213	TACNA	TARATA	TICACO	22	02	13
1677	137	220301	TACNA	JORGE BASADRE	LOCUMBA	22	03	01
1678	137	220302	TACNA	JORGE BASADRE	ITE	22	03	02
1679	137	220303	TACNA	JORGE BASADRE	ILABAYA	22	03	03
1680	137	220401	TACNA	CANDARAVE	CANDARAVE	22	04	01
1681	137	220402	TACNA	CANDARAVE	CAIRANI	22	04	02
1682	137	220403	TACNA	CANDARAVE	CURIBAYA	22	04	03
1683	137	220404	TACNA	CANDARAVE	HUANUARA	22	04	04
1684	137	220405	TACNA	CANDARAVE	QUILAHUANI	22	04	05
1685	137	220406	TACNA	CANDARAVE	CAMILACA	22	04	06
1686	137	230101	TUMBES	TUMBES	TUMBES	23	01	01
1687	137	230102	TUMBES	TUMBES	CORRALES	23	01	02
1688	137	230103	TUMBES	TUMBES	LA CRUZ	23	01	03
1689	137	230104	TUMBES	TUMBES	PAMPAS DE HOSPITAL	23	01	04
1690	137	230105	TUMBES	TUMBES	SAN JACINTO	23	01	05
1691	137	230106	TUMBES	TUMBES	SAN JUAN DE LA VIRGEN	23	01	06
1692	137	230201	TUMBES	CONTRALMIRANTE VILLAR	ZORRITOS	23	02	01
1693	137	230202	TUMBES	CONTRALMIRANTE VILLAR	CASITAS	23	02	02
1694	137	230203	TUMBES	CONTRALMIRANTE VILLAR	CANOAS DE PUNTA SAL	23	02	03
1695	137	230301	TUMBES	ZARUMILLA	ZARUMILLA	23	03	01
1696	137	230302	TUMBES	ZARUMILLA	MATAPALO	23	03	02
1697	137	230303	TUMBES	ZARUMILLA	PAPAYAL	23	03	03
1698	137	230304	TUMBES	ZARUMILLA	AGUAS VERDES	23	03	04
1706	137	250101	UCAYALI	CORONEL PORTILLO	CALLERIA	25	01	01
1707	137	250102	UCAYALI	CORONEL PORTILLO	YARINACOCHA	25	01	02
1708	137	250103	UCAYALI	CORONEL PORTILLO	MASISEA	25	01	03
1709	137	250104	UCAYALI	CORONEL PORTILLO	CAMPOVERDE	25	01	04
1710	137	250105	UCAYALI	CORONEL PORTILLO	IPARIA	25	01	05
1711	137	250106	UCAYALI	CORONEL PORTILLO	NUEVA REQUENA	25	01	06
1712	137	250107	UCAYALI	CORONEL PORTILLO	MANANTAY	25	01	07
1713	137	250201	UCAYALI	PADRE ABAD	PADRE ABAD	25	02	01
1714	137	250202	UCAYALI	PADRE ABAD	IRAZOLA	25	02	02
1715	137	250203	UCAYALI	PADRE ABAD	CURIMANA	25	02	03
1716	137	250204	UCAYALI	PADRE ABAD	NESHUYA	25	02	04
1717	137	250205	UCAYALI	PADRE ABAD	ALEXANDER VON HUMBOLDT	25	02	05
1718	137	250301	UCAYALI	ATALAYA	RAIMONDI	25	03	01
1719	137	250302	UCAYALI	ATALAYA	TAHUANIA	25	03	02
1720	137	250303	UCAYALI	ATALAYA	YURUA	25	03	03
1721	137	250304	UCAYALI	ATALAYA	SEPAHUA	25	03	04
1722	137	250401	UCAYALI	PURUS	PURUS	25	04	01
1726	137	910201	AFRICA	COSTA DE MARFIL	ABYDJAN	91	02	01
1727	137	910302	AFRICA	EGIPTO, REPUBLICA ARABE	EL CAIRO	91	03	02
1728	137	910401	AFRICA	KENIA	NAIROBI	91	04	01
1729	137	910502	AFRICA	MARRUECOS	RABAT	91	05	02
1730	137	910503	AFRICA	MARRUECOS	AGADIR	91	05	03
1731	137	910504	AFRICA	MARRUECOS	CASABLANCA	91	05	04
1732	137	910506	AFRICA	MARRUECOS	TETOUAN	91	05	06
1733	137	910507	AFRICA	MARRUECOS	TANGER	91	05	07
1734	137	910513	AFRICA	MARRUECOS	MARRAKECH-TENSIFT-AL HAUZ	91	05	13
1735	137	910601	AFRICA	SUDAFRICA	CIUDAD DEL CABO	91	06	01
1736	137	910603	AFRICA	SUDAFRICA	PRETORIA	91	06	03
1737	137	910604	AFRICA	SUDAFRICA	JOHANNESBURGO	91	06	04
1738	137	910605	AFRICA	SUDAFRICA	DURBAN	91	06	05
1739	137	910606	AFRICA	SUDAFRICA	EL CABO ORIENTAL	91	06	06
1740	137	910701	AFRICA	ZAMBIA	LUSAKA	91	07	01
1741	137	910702	AFRICA	ZAMBIA	COPPERBELT	91	07	02
1742	137	910703	AFRICA	ZAMBIA	KITWE	91	07	03
1743	137	910901	AFRICA	TUNEZ	TUNEZ	91	09	01
1744	137	911102	AFRICA	NIGERIA	LAGOS	91	11	02
1745	137	911201	AFRICA	GHANA	ACCRA	91	12	01
1746	137	911301	AFRICA	ANGOLA	LUANDA	91	13	01
1747	137	911602	AFRICA	LIBIA	TRIPOLI	91	16	02
1748	137	911701	AFRICA	MOZAMBIQUE	MAPUTO	91	17	01
1749	137	911702	AFRICA	MOZAMBIQUE	NAMPULA	91	17	02
1750	137	911703	AFRICA	MOZAMBIQUE	TETE	91	17	03
1751	137	911801	AFRICA	SWAZILANDIA	MBABANE	91	18	01
1752	137	912101	AFRICA	SENEGAL	DAKAR	91	21	01
1753	137	912201	AFRICA	GUINEA ECUATORIAL	BIOKO	91	22	01
1754	137	912202	AFRICA	GUINEA ECUATORIAL	BATA	91	22	02
1755	137	912301	AFRICA	CAMERUN	YAUNDE	91	23	01
1756	137	912401	AFRICA	REP. DEMOCRATICA DEL CONGO	KINSHASA	91	24	01
1757	137	912901	AFRICA	MAURICIO	PORT LOUIS	91	29	01
1758	137	912903	AFRICA	MAURICIO	BLACK RIVER	91	29	03
1759	137	913001	AFRICA	BOTSUANA	GABORONE	91	30	01
1760	137	913602	AFRICA	REPUBLICA DE CABO VERDE	SANTIAGO	91	36	02
1761	137	913603	AFRICA	REPUBLICA DE CABO VERDE	ILHA DO SAL	91	36	03
1762	137	920101	AMERICA	ANTILLAS HOLANDESAS	ARUBA	92	01	01
1763	137	920102	AMERICA	ANTILLAS HOLANDESAS	CURAZAO	92	01	02
1764	137	920103	AMERICA	ANTILLAS HOLANDESAS	ST MAARTEN	92	01	03
1765	137	920104	AMERICA	ANTILLAS HOLANDESAS	BONAIRE	92	01	04
1766	19	920201	AMERICA	ARGENTINA	BAHIA BLANCA	92	02	01
1767	19	920202	AMERICA	ARGENTINA	BUENOS AIRES	92	02	02
1810	137	920507	AMERICA	BRASIL	RECIFE	92	05	07
1811	137	070804	CUSCO	ESPINAR	OCORURO	07	08	04
1812	137	070805	CUSCO	ESPINAR	PALLPATA	07	08	05
1813	137	070806	CUSCO	ESPINAR	PICHIGUA	07	08	06
1814	137	070807	CUSCO	ESPINAR	SUYCKUTAMBO	07	08	07
1815	137	070808	CUSCO	ESPINAR	ALTO PICHIGUA	07	08	08
1816	137	070901	CUSCO	LA CONVENCION	SANTA ANA	07	09	01
1817	137	070902	CUSCO	LA CONVENCION	ECHARATE	07	09	02
1818	137	070903	CUSCO	LA CONVENCION	HUAYOPATA	07	09	03
1819	137	070904	CUSCO	LA CONVENCION	MARANURA	07	09	04
1820	137	070905	CUSCO	LA CONVENCION	OCOBAMBA	07	09	05
1821	137	070906	CUSCO	LA CONVENCION	SANTA TERESA	07	09	06
1822	137	070907	CUSCO	LA CONVENCION	VILCABAMBA	07	09	07
1823	137	070908	CUSCO	LA CONVENCION	QUELLOUNO	07	09	08
1824	137	070909	CUSCO	LA CONVENCION	KIMBIRI	07	09	09
1825	137	070910	CUSCO	LA CONVENCION	PICHARI	07	09	10
1826	137	070911	CUSCO	LA CONVENCION	INKAWASI	07	09	11
1827	137	070912	CUSCO	LA CONVENCION	VILLA VIRGEN	07	09	12
1828	137	070913	CUSCO	LA CONVENCION	VILLA KINTIARINA	07	09	13
1829	137	071001	CUSCO	PARURO	PARURO	07	10	01
1830	137	071002	CUSCO	PARURO	ACCHA	07	10	02
1831	137	071003	CUSCO	PARURO	CCAPI	07	10	03
1832	137	071004	CUSCO	PARURO	COLCHA	07	10	04
1833	137	071005	CUSCO	PARURO	HUANOQUITE	07	10	05
1834	137	071006	CUSCO	PARURO	OMACHA	07	10	06
1835	137	071007	CUSCO	PARURO	YAURISQUE	07	10	07
1836	137	071008	CUSCO	PARURO	PACCARITAMBO	07	10	08
1837	137	071009	CUSCO	PARURO	PILLPINTO	07	10	09
1838	137	071101	CUSCO	PAUCARTAMBO	PAUCARTAMBO	07	11	01
1839	137	071102	CUSCO	PAUCARTAMBO	CAICAY	07	11	02
1840	137	071103	CUSCO	PAUCARTAMBO	COLQUEPATA	07	11	03
1841	137	071104	CUSCO	PAUCARTAMBO	CHALLABAMBA	07	11	04
1842	137	071105	CUSCO	PAUCARTAMBO	KOSÑIPATA	07	11	05
1843	137	071106	CUSCO	PAUCARTAMBO	HUANCARANI	07	11	06
1844	137	071201	CUSCO	QUISPICANCHI	URCOS	07	12	01
1845	137	071202	CUSCO	QUISPICANCHI	ANDAHUAYLILLAS	07	12	02
1846	137	071203	CUSCO	QUISPICANCHI	CAMANTI	07	12	03
1847	137	071204	CUSCO	QUISPICANCHI	CCARHUAYO	07	12	04
1848	137	071205	CUSCO	QUISPICANCHI	CCATCA	07	12	05
1849	137	071206	CUSCO	QUISPICANCHI	CUSIPATA	07	12	06
1850	137	071207	CUSCO	QUISPICANCHI	HUARO	07	12	07
1851	137	071208	CUSCO	QUISPICANCHI	LUCRE	07	12	08
1852	137	071209	CUSCO	QUISPICANCHI	MARCAPATA	07	12	09
1853	137	071210	CUSCO	QUISPICANCHI	OCONGATE	07	12	10
1854	137	071211	CUSCO	QUISPICANCHI	OROPESA	07	12	11
1855	137	071212	CUSCO	QUISPICANCHI	QUIQUIJANA	07	12	12
1856	137	071301	CUSCO	URUBAMBA	URUBAMBA	07	13	01
1857	137	071302	CUSCO	URUBAMBA	CHINCHERO	07	13	02
1858	137	071303	CUSCO	URUBAMBA	HUAYLLABAMBA	07	13	03
1859	137	071304	CUSCO	URUBAMBA	MACHUPICCHU	07	13	04
1860	137	071305	CUSCO	URUBAMBA	MARAS	07	13	05
1861	137	071306	CUSCO	URUBAMBA	OLLANTAYTAMBO	07	13	06
1862	137	071307	CUSCO	URUBAMBA	YUCAY	07	13	07
1863	137	080101	HUANCAVELICA	HUANCAVELICA	HUANCAVELICA	08	01	01
1864	137	080102	HUANCAVELICA	HUANCAVELICA	ACOBAMBILLA	08	01	02
1865	137	080103	HUANCAVELICA	HUANCAVELICA	ACORIA	08	01	03
1866	137	080104	HUANCAVELICA	HUANCAVELICA	CONAYCA	08	01	04
1867	137	080105	HUANCAVELICA	HUANCAVELICA	CUENCA	08	01	05
1868	137	080106	HUANCAVELICA	HUANCAVELICA	HUACHOCOLPA	08	01	06
1869	137	080108	HUANCAVELICA	HUANCAVELICA	HUAYLLAHUARA	08	01	08
1870	137	080109	HUANCAVELICA	HUANCAVELICA	IZCUCHACA	08	01	09
1871	137	080110	HUANCAVELICA	HUANCAVELICA	LARIA	08	01	10
1872	137	080111	HUANCAVELICA	HUANCAVELICA	MANTA	08	01	11
1873	137	080112	HUANCAVELICA	HUANCAVELICA	MARISCAL CACERES	08	01	12
1874	137	080113	HUANCAVELICA	HUANCAVELICA	MOYA	08	01	13
1875	137	080114	HUANCAVELICA	HUANCAVELICA	NUEVO OCCORO	08	01	14
1876	137	080115	HUANCAVELICA	HUANCAVELICA	PALCA	08	01	15
1877	137	080116	HUANCAVELICA	HUANCAVELICA	PILCHACA	08	01	16
1878	137	080117	HUANCAVELICA	HUANCAVELICA	VILCA	08	01	17
1879	137	080118	HUANCAVELICA	HUANCAVELICA	YAULI	08	01	18
1880	137	080119	HUANCAVELICA	HUANCAVELICA	ASCENSION	08	01	19
1881	137	080120	HUANCAVELICA	HUANCAVELICA	HUANDO	08	01	20
1882	137	080201	HUANCAVELICA	ACOBAMBA	ACOBAMBA	08	02	01
1883	137	080202	HUANCAVELICA	ACOBAMBA	ANTA	08	02	02
1884	137	080203	HUANCAVELICA	ACOBAMBA	ANDABAMBA	08	02	03
1885	137	080204	HUANCAVELICA	ACOBAMBA	CAJA	08	02	04
1886	137	080205	HUANCAVELICA	ACOBAMBA	MARCAS	08	02	05
1887	137	080206	HUANCAVELICA	ACOBAMBA	PAUCARA	08	02	06
1888	137	080207	HUANCAVELICA	ACOBAMBA	POMACOCHA	08	02	07
1889	137	080208	HUANCAVELICA	ACOBAMBA	ROSARIO	08	02	08
1890	137	080301	HUANCAVELICA	ANGARAES	LIRCAY	08	03	01
1891	137	080302	HUANCAVELICA	ANGARAES	ANCHONGA	08	03	02
1892	137	080303	HUANCAVELICA	ANGARAES	CALLANMARCA	08	03	03
1893	137	080304	HUANCAVELICA	ANGARAES	CONGALLA	08	03	04
1894	137	080305	HUANCAVELICA	ANGARAES	CHINCHO	08	03	05
1895	137	080306	HUANCAVELICA	ANGARAES	HUALLAY-GRANDE	08	03	06
1896	137	080307	HUANCAVELICA	ANGARAES	HUANCA-HUANCA	08	03	07
1897	137	080308	HUANCAVELICA	ANGARAES	JULCAMARCA	08	03	08
1898	137	080309	HUANCAVELICA	ANGARAES	SAN ANTONIO DE ANTAPARCO	08	03	09
1899	137	080310	HUANCAVELICA	ANGARAES	SANTO TOMAS DE PATA	08	03	10
1900	137	080311	HUANCAVELICA	ANGARAES	SECCLLA	08	03	11
1901	137	080312	HUANCAVELICA	ANGARAES	CCOCHACCASA	08	03	12
1902	137	080401	HUANCAVELICA	CASTROVIRREYNA	CASTROVIRREYNA	08	04	01
1903	137	080402	HUANCAVELICA	CASTROVIRREYNA	ARMA	08	04	02
1904	137	080403	HUANCAVELICA	CASTROVIRREYNA	AURAHUA	08	04	03
1905	137	080405	HUANCAVELICA	CASTROVIRREYNA	CAPILLAS	08	04	05
1906	137	080406	HUANCAVELICA	CASTROVIRREYNA	COCAS	08	04	06
1907	137	080408	HUANCAVELICA	CASTROVIRREYNA	CHUPAMARCA	08	04	08
1908	137	080409	HUANCAVELICA	CASTROVIRREYNA	HUACHOS	08	04	09
1909	137	080410	HUANCAVELICA	CASTROVIRREYNA	HUAMATAMBO	08	04	10
1910	137	080414	HUANCAVELICA	CASTROVIRREYNA	MOLLEPAMPA	08	04	14
1911	137	080422	HUANCAVELICA	CASTROVIRREYNA	SAN JUAN	08	04	22
1912	137	080427	HUANCAVELICA	CASTROVIRREYNA	TANTARA	08	04	27
1913	137	080428	HUANCAVELICA	CASTROVIRREYNA	TICRAPO	08	04	28
1914	137	080429	HUANCAVELICA	CASTROVIRREYNA	SANTA ANA	08	04	29
1915	137	080501	HUANCAVELICA	TAYACAJA	PAMPAS	08	05	01
1916	137	080502	HUANCAVELICA	TAYACAJA	ACOSTAMBO	08	05	02
1917	137	080503	HUANCAVELICA	TAYACAJA	ACRAQUIA	08	05	03
1918	137	080504	HUANCAVELICA	TAYACAJA	AHUAYCHA	08	05	04
1919	137	080506	HUANCAVELICA	TAYACAJA	COLCABAMBA	08	05	06
1920	137	080509	HUANCAVELICA	TAYACAJA	DANIEL HERNANDEZ	08	05	09
1921	137	080511	HUANCAVELICA	TAYACAJA	HUACHOCOLPA	08	05	11
1922	137	080512	HUANCAVELICA	TAYACAJA	HUARIBAMBA	08	05	12
1923	137	080515	HUANCAVELICA	TAYACAJA	ÑAHUIMPUQUIO	08	05	15
1924	137	080517	HUANCAVELICA	TAYACAJA	PAZOS	08	05	17
1925	137	080518	HUANCAVELICA	TAYACAJA	QUISHUAR	08	05	18
1926	137	080519	HUANCAVELICA	TAYACAJA	SALCABAMBA	08	05	19
1927	137	080520	HUANCAVELICA	TAYACAJA	SAN MARCOS DE ROCCHAC	08	05	20
1928	137	080523	HUANCAVELICA	TAYACAJA	SURCUBAMBA	08	05	23
1929	137	080525	HUANCAVELICA	TAYACAJA	TINTAY PUNCU	08	05	25
1930	137	080526	HUANCAVELICA	TAYACAJA	SALCAHUASI	08	05	26
1931	137	080528	HUANCAVELICA	TAYACAJA	QUICHUAS	08	05	28
1932	137	080529	HUANCAVELICA	TAYACAJA	ANDAYMARCA	08	05	29
1933	137	080601	HUANCAVELICA	HUAYTARA	AYAVI	08	06	01
1934	137	080602	HUANCAVELICA	HUAYTARA	CORDOVA	08	06	02
1935	137	080603	HUANCAVELICA	HUAYTARA	HUAYACUNDO ARMA	08	06	03
1936	137	080604	HUANCAVELICA	HUAYTARA	HUAYTARA	08	06	04
1937	137	080605	HUANCAVELICA	HUAYTARA	LARAMARCA	08	06	05
1938	137	080606	HUANCAVELICA	HUAYTARA	OCOYO	08	06	06
1939	137	080607	HUANCAVELICA	HUAYTARA	PILPICHACA	08	06	07
1940	137	080608	HUANCAVELICA	HUAYTARA	QUERCO	08	06	08
1941	137	080609	HUANCAVELICA	HUAYTARA	QUITO ARMA	08	06	09
1942	137	080610	HUANCAVELICA	HUAYTARA	SAN ANTONIO DE CUSICANCHA	08	06	10
1943	137	080611	HUANCAVELICA	HUAYTARA	SAN FRANCISCO DE SANGAYAICO	08	06	11
1944	137	080612	HUANCAVELICA	HUAYTARA	SAN ISIDRO	08	06	12
1945	137	080613	HUANCAVELICA	HUAYTARA	SANTIAGO DE CHOCORVOS	08	06	13
1946	137	080614	HUANCAVELICA	HUAYTARA	SANTIAGO DE QUIRAHUARA	08	06	14
1947	137	080615	HUANCAVELICA	HUAYTARA	SANTO DOMINGO DE CAPILLAS	08	06	15
1948	137	080616	HUANCAVELICA	HUAYTARA	TAMBO	08	06	16
1949	137	080701	HUANCAVELICA	CHURCAMPA	CHURCAMPA	08	07	01
1950	137	080702	HUANCAVELICA	CHURCAMPA	ANCO	08	07	02
1951	137	920512	AMERICA	BRASIL	BAHIA	92	05	12
1952	137	920513	AMERICA	BRASIL	RONDONIA	92	05	13
1953	137	920514	AMERICA	BRASIL	CEARA	92	05	14
1954	137	920515	AMERICA	BRASIL	RIO GRANDE DEL SUR	92	05	15
1955	137	920517	AMERICA	BRASIL	PARAIBA	92	05	17
1956	137	920518	AMERICA	BRASIL	ESPIRITO SANTO	92	05	18
1957	137	920519	AMERICA	BRASIL	ALAGOAS	92	05	19
1958	137	920520	AMERICA	BRASIL	MINAS GERAIS	92	05	20
1959	137	920521	AMERICA	BRASIL	AMAZONAS	92	05	21
1960	137	920522	AMERICA	BRASIL	ACRE	92	05	22
1961	137	920523	AMERICA	BRASIL	PERNAMBUCO	92	05	23
1962	137	920524	AMERICA	BRASIL	RIO GRANDE DEL NORTE	92	05	24
1963	137	920525	AMERICA	BRASIL	RORAIMA	92	05	25
1964	137	920526	AMERICA	BRASIL	PARANA	92	05	26
1965	137	920527	AMERICA	BRASIL	SANTA CATALINA	92	05	27
1966	137	920528	AMERICA	BRASIL	MARANHAO	92	05	28
1967	137	920529	AMERICA	BRASIL	SERGIPE	92	05	29
1968	137	920530	AMERICA	BRASIL	PIAUI	92	05	30
1969	137	920531	AMERICA	BRASIL	TOCANTINS	92	05	31
1970	137	920532	AMERICA	BRASIL	GOIAS	92	05	32
1971	137	920533	AMERICA	BRASIL	PARÁ	92	05	33
1972	137	920534	AMERICA	BRASIL	MATO GROSSO	92	05	34
1973	137	920535	AMERICA	BRASIL	MATO GROSSO DO SUL	92	05	35
1974	137	920536	AMERICA	BRASIL	FORTALEZA	92	05	36
1975	137	920537	AMERICA	BRASIL	AMAPA	92	05	37
1976	137	920601	AMERICA	CANADA	MONTREAL	92	06	01
1977	137	920602	AMERICA	CANADA	OTTAWA	92	06	02
1978	137	920603	AMERICA	CANADA	TORONTO	92	06	03
1979	137	920604	AMERICA	CANADA	VANCOUVER	92	06	04
1980	137	920605	AMERICA	CANADA	MANITOBA	92	06	05
1981	137	920606	AMERICA	CANADA	ONTARIO	92	06	06
1982	137	920607	AMERICA	CANADA	SASKATCHEWAN	92	06	07
1983	137	920608	AMERICA	CANADA	ALBERTA	92	06	08
1984	137	920609	AMERICA	CANADA	QUEBEC	92	06	09
1985	137	920610	AMERICA	CANADA	NUEVA ESCOCIA	92	06	10
1986	137	920612	AMERICA	CANADA	COLUMBIA BRITANICA	92	06	12
1987	137	920613	AMERICA	CANADA	PRINCIPE EDUARDO	92	06	13
1988	137	920614	AMERICA	CANADA	TERRANOVA	92	06	14
1989	137	920615	AMERICA	CANADA	NUEVO BRUNSWICK	92	06	15
1990	137	920701	AMERICA	COLOMBIA	BARRANQUILLA	92	07	01
1991	137	920702	AMERICA	COLOMBIA	BOGOTA	92	07	02
1992	137	920703	AMERICA	COLOMBIA	CALI	92	07	03
1993	137	920704	AMERICA	COLOMBIA	BOLIVAR	92	07	04
1994	137	920705	AMERICA	COLOMBIA	LETICIA	92	07	05
1995	137	920706	AMERICA	COLOMBIA	MEDELLIN	92	07	06
1996	137	920707	AMERICA	COLOMBIA	SANTA MARIA	92	07	07
1997	137	920708	AMERICA	COLOMBIA	MANIZALES	92	07	08
1998	137	920709	AMERICA	COLOMBIA	SANTANDER	92	07	09
1999	137	920710	AMERICA	COLOMBIA	VALLE	92	07	10
2000	137	920711	AMERICA	COLOMBIA	BOYACA	92	07	11
2001	137	920712	AMERICA	COLOMBIA	TOLIMA	92	07	12
2002	137	920713	AMERICA	COLOMBIA	NORTE DE SANTANDER	92	07	13
2003	137	920714	AMERICA	COLOMBIA	CALDAS	92	07	14
2004	137	920715	AMERICA	COLOMBIA	MAGDALENA	92	07	15
2005	137	920716	AMERICA	COLOMBIA	RISARALDA	92	07	16
2006	137	920717	AMERICA	COLOMBIA	NARIÑO	92	07	17
2007	137	920718	AMERICA	COLOMBIA	ANTIOQUIA	92	07	18
2008	137	920719	AMERICA	COLOMBIA	AMAZONAS	92	07	19
2009	137	920720	AMERICA	COLOMBIA	CASANARE	92	07	20
2010	137	920721	AMERICA	COLOMBIA	CUNDINAMARCA	92	07	21
2011	137	920722	AMERICA	COLOMBIA	HUILA	92	07	22
2012	137	920723	AMERICA	COLOMBIA	META	92	07	23
2013	137	920724	AMERICA	COLOMBIA	CORDOBA	92	07	24
2014	137	920725	AMERICA	COLOMBIA	CESAR	92	07	25
2015	137	920726	AMERICA	COLOMBIA	CHOCO	92	07	26
2016	137	920727	AMERICA	COLOMBIA	SUCRE	92	07	27
2017	137	920728	AMERICA	COLOMBIA	VICHADA	92	07	28
2018	137	920729	AMERICA	COLOMBIA	ARAUCA	92	07	29
2019	137	920730	AMERICA	COLOMBIA	POPAYAN	92	07	30
2020	137	920731	AMERICA	COLOMBIA	CAQUETA	92	07	31
2021	137	920732	AMERICA	COLOMBIA	CUCUTA	92	07	32
2022	137	920733	AMERICA	COLOMBIA	QUINDIO	92	07	33
2023	137	920735	AMERICA	COLOMBIA	GUAINIA	92	07	35
2024	137	920736	AMERICA	COLOMBIA	PUTUMAYO	92	07	36
2025	137	920737	AMERICA	COLOMBIA	CARTAGENA	92	07	37
2026	137	920739	AMERICA	COLOMBIA	LA GUAJIRA	92	07	39
2027	137	920740	AMERICA	COLOMBIA	CAUCA	92	07	40
2028	137	920741	AMERICA	COLOMBIA	SAN ANDRES	92	07	41
2029	137	920801	AMERICA	COSTA RICA	LIMON	92	08	01
2030	137	920802	AMERICA	COSTA RICA	PUNTARENAS	92	08	02
2031	137	920803	AMERICA	COSTA RICA	SAN JOSE	92	08	03
2032	137	920804	AMERICA	COSTA RICA	GUANACASTE	92	08	04
2033	137	920805	AMERICA	COSTA RICA	CARTAGO	92	08	05
2034	137	920806	AMERICA	COSTA RICA	ALAJUELA	92	08	06
2035	137	920807	AMERICA	COSTA RICA	TURRIALBA	92	08	07
2036	137	920808	AMERICA	COSTA RICA	HEREDIA	92	08	08
2037	137	920901	AMERICA	CUBA	LA HABANA	92	09	01
2038	137	920902	AMERICA	CUBA	CAMAGUEY	92	09	02
2039	137	920903	AMERICA	CUBA	SANTIAGO DE CUBA	92	09	03
2040	137	920905	AMERICA	CUBA	MATANZAS	92	09	05
2041	137	920906	AMERICA	CUBA	VILLA CLARA	92	09	06
2042	137	920907	AMERICA	CUBA	GRANMA	92	09	07
2043	137	920908	AMERICA	CUBA	PINAR DEL RIO	92	09	08
2044	137	920909	AMERICA	CUBA	SANCTI SPIRITUS	92	09	09
2045	137	920910	AMERICA	CUBA	CIENFUEGOS	92	09	10
2046	137	920912	AMERICA	CUBA	LAS TUNAS	92	09	12
2047	137	920914	AMERICA	CUBA	HOLGUIN	92	09	14
2048	137	920915	AMERICA	CUBA	CIEGO DE AVILA	92	09	15
2049	137	921001	AMERICA	CHILE	ANTOFAGASTA	92	10	01
2050	137	921002	AMERICA	CHILE	ARICA	92	10	02
2051	137	921003	AMERICA	CHILE	CONCEPCION	92	10	03
2052	137	921004	AMERICA	CHILE	COQUIMBO	92	10	04
2053	137	921005	AMERICA	CHILE	IQUIQUE	92	10	05
2054	137	921006	AMERICA	CHILE	SANTIAGO	92	10	06
2055	137	921007	AMERICA	CHILE	VALPARAISO	92	10	07
2056	137	921008	AMERICA	CHILE	LOS LAGOS	92	10	08
2057	137	921009	AMERICA	CHILE	LA ARAUCANIA	92	10	09
2058	137	921010	AMERICA	CHILE	O'HIGGINS	92	10	10
2059	137	921011	AMERICA	CHILE	ACONCAGUA	92	10	11
2060	137	921012	AMERICA	CHILE	MAULE	92	10	12
2061	137	921013	AMERICA	CHILE	MAGALLANES	92	10	13
2062	137	921014	AMERICA	CHILE	BIOBIO	92	10	14
2063	137	921015	AMERICA	CHILE	TARAPACA	92	10	15
2064	137	921017	AMERICA	CHILE	LINARES	92	10	17
2065	137	921018	AMERICA	CHILE	NUBLE	92	10	18
2066	137	921020	AMERICA	CHILE	ATACAMA	92	10	20
2067	137	921021	AMERICA	CHILE	REGION METROPOLITANA	92	10	21
2068	137	921022	AMERICA	CHILE	MALLECO	92	10	22
2069	137	921024	AMERICA	CHILE	AISEN	92	10	24
2070	137	921025	AMERICA	CHILE	LOS RIOS	92	10	25
2071	137	921026	AMERICA	CHILE	COPIAPO	92	10	26
2072	137	921101	AMERICA	ECUADOR	GUAYAQUIL	92	11	01
2073	137	921102	AMERICA	ECUADOR	LOJA	92	11	02
2074	137	921103	AMERICA	ECUADOR	MACARA	92	11	03
2075	137	921104	AMERICA	ECUADOR	MACHALA	92	11	04
2076	137	921105	AMERICA	ECUADOR	QUITO	92	11	05
2077	137	921106	AMERICA	ECUADOR	ESMERALDAS	92	11	06
2078	137	921107	AMERICA	ECUADOR	MANABI	92	11	07
2079	137	921108	AMERICA	ECUADOR	CHIMBORAZO	92	11	08
2080	137	921109	AMERICA	ECUADOR	LOS RIOS	92	11	09
2081	137	921110	AMERICA	ECUADOR	AZUAY	92	11	10
2082	137	921111	AMERICA	ECUADOR	EL ORO	92	11	11
2083	137	921112	AMERICA	ECUADOR	GUAYAS	92	11	12
2084	137	921113	AMERICA	ECUADOR	TUNGURAHUA	92	11	13
2085	137	921114	AMERICA	ECUADOR	CARCHI	92	11	14
2086	137	921115	AMERICA	ECUADOR	IMBABURA	92	11	15
2087	137	921116	AMERICA	ECUADOR	CAÑAR	92	11	16
2088	137	921117	AMERICA	ECUADOR	PICHINCHA	92	11	17
2089	137	921118	AMERICA	ECUADOR	ZAMORA CHINCHIPE	92	11	18
2090	137	921120	AMERICA	ECUADOR	COTOPAXI	92	11	20
2091	137	921121	AMERICA	ECUADOR	PASTAZA	92	11	21
2092	137	921122	AMERICA	ECUADOR	BOLIVAR	92	11	22
2093	137	921123	AMERICA	ECUADOR	MORONA SANTIAGO	92	11	23
2094	137	921124	AMERICA	ECUADOR	NAPO	92	11	24
2095	137	921125	AMERICA	ECUADOR	SUCUMBIOS	92	11	25
2096	137	921126	AMERICA	ECUADOR	SANTA ELENA	92	11	26
2097	137	921127	AMERICA	ECUADOR	SANTO DOMINGO DE LOS TSACHILAS	92	11	27
2098	137	921128	AMERICA	ECUADOR	ORELLANA	92	11	28
2099	137	921201	AMERICA	EL SALVADOR	SAN SALVADOR	92	12	01
2100	137	921202	AMERICA	EL SALVADOR	SANTA ANA	92	12	02
2101	137	921203	AMERICA	EL SALVADOR	LA UNION	92	12	03
2102	137	921204	AMERICA	EL SALVADOR	CABAÑAS	92	12	04
2103	137	942717	EUROPA	SUECIA	VÄRMLAND	94	27	17
2104	137	942718	EUROPA	SUECIA	GÄVLEBORG	94	27	18
2105	137	942719	EUROPA	SUECIA	DALARNA	94	27	19
2106	137	942720	EUROPA	SUECIA	ESCANIA	94	27	20
2107	137	921209	AMERICA	EL SALVADOR	SONSONATE	92	12	09
2108	137	921301	AMERICA	ESTADOS UNIDOS DE AMERICA	GEORGIA	92	13	01
2109	137	921302	AMERICA	ESTADOS UNIDOS DE AMERICA	BALTIMORE	92	13	02
2110	137	921303	AMERICA	ESTADOS UNIDOS DE AMERICA	BOSTON	92	13	03
2111	137	921304	AMERICA	ESTADOS UNIDOS DE AMERICA	CHICAGO	92	13	04
2112	137	921305	AMERICA	ESTADOS UNIDOS DE AMERICA	CINCINNATI	92	13	05
2113	137	921306	AMERICA	ESTADOS UNIDOS DE AMERICA	CORAL GABLES (FLORIDA)	92	13	06
2114	137	921307	AMERICA	ESTADOS UNIDOS DE AMERICA	NUEVO MEXICO	92	13	07
2115	137	921308	AMERICA	ESTADOS UNIDOS DE AMERICA	DENVER	92	13	08
2116	137	921309	AMERICA	ESTADOS UNIDOS DE AMERICA	INDIANA	92	13	09
2117	137	921310	AMERICA	ESTADOS UNIDOS DE AMERICA	FORT LAUDERDALE	92	13	10
2118	137	921311	AMERICA	ESTADOS UNIDOS DE AMERICA	TENNESSEE	92	13	11
2119	137	921312	AMERICA	ESTADOS UNIDOS DE AMERICA	HONOLULU	92	13	12
2120	137	921313	AMERICA	ESTADOS UNIDOS DE AMERICA	HOUSTON	92	13	13
2121	137	921314	AMERICA	ESTADOS UNIDOS DE AMERICA	ALABAMA	92	13	14
2122	137	921315	AMERICA	ESTADOS UNIDOS DE AMERICA	LOS ANGELES	92	13	15
2123	137	921316	AMERICA	ESTADOS UNIDOS DE AMERICA	MINNESOTA	92	13	16
2124	137	921317	AMERICA	ESTADOS UNIDOS DE AMERICA	MIAMI	92	13	17
2125	137	921318	AMERICA	ESTADOS UNIDOS DE AMERICA	NUEVA ORLEANS	92	13	18
2126	137	921319	AMERICA	ESTADOS UNIDOS DE AMERICA	NUEVA YORK	92	13	19
2127	137	921320	AMERICA	ESTADOS UNIDOS DE AMERICA	ORLANDO	92	13	20
2128	137	921321	AMERICA	ESTADOS UNIDOS DE AMERICA	PITTSBURGH	92	13	21
2129	137	921322	AMERICA	ESTADOS UNIDOS DE AMERICA	OKLAHOMA	92	13	22
2130	137	921323	AMERICA	ESTADOS UNIDOS DE AMERICA	SAN ANTONIO	92	13	23
2131	137	921324	AMERICA	ESTADOS UNIDOS DE AMERICA	SAN DIEGO	92	13	24
2132	137	921325	AMERICA	ESTADOS UNIDOS DE AMERICA	SAN FRANCISCO	92	13	25
2133	137	921326	AMERICA	ESTADOS UNIDOS DE AMERICA	SAN LOUIS	92	13	26
2134	137	921327	AMERICA	ESTADOS UNIDOS DE AMERICA	SANTA BARBARA	92	13	27
2135	137	921328	AMERICA	ESTADOS UNIDOS DE AMERICA	SEATLE	92	13	28
2136	137	921329	AMERICA	ESTADOS UNIDOS DE AMERICA	TUCSON	92	13	29
2137	137	921330	AMERICA	ESTADOS UNIDOS DE AMERICA	TULSA	92	13	30
2138	137	921331	AMERICA	ESTADOS UNIDOS DE AMERICA	WASHINGTON D. C.	92	13	31
2139	137	921332	AMERICA	ESTADOS UNIDOS DE AMERICA	PATERSON	92	13	32
2140	137	921333	AMERICA	ESTADOS UNIDOS DE AMERICA	CONNECTICUT	92	13	33
2141	137	921334	AMERICA	ESTADOS UNIDOS DE AMERICA	OREGON	92	13	34
2142	137	921335	AMERICA	ESTADOS UNIDOS DE AMERICA	NUEVA JERSEY	92	13	35
2143	137	921336	AMERICA	ESTADOS UNIDOS DE AMERICA	PENNSYLVANIA	92	13	36
2144	137	921337	AMERICA	ESTADOS UNIDOS DE AMERICA	UTAH	92	13	37
2145	137	921338	AMERICA	ESTADOS UNIDOS DE AMERICA	KANSAS	92	13	38
2146	137	921340	AMERICA	ESTADOS UNIDOS DE AMERICA	OHIO	92	13	40
2147	137	921341	AMERICA	ESTADOS UNIDOS DE AMERICA	TEXAS	92	13	41
2148	137	921342	AMERICA	ESTADOS UNIDOS DE AMERICA	VIRGINIA	92	13	42
2149	137	921343	AMERICA	ESTADOS UNIDOS DE AMERICA	FLORIDA	92	13	43
2150	137	921344	AMERICA	ESTADOS UNIDOS DE AMERICA	MARYLAND	92	13	44
2151	137	921345	AMERICA	ESTADOS UNIDOS DE AMERICA	WISCONSIN	92	13	45
2152	137	921346	AMERICA	ESTADOS UNIDOS DE AMERICA	KENTUCKY	92	13	46
2153	137	921347	AMERICA	ESTADOS UNIDOS DE AMERICA	ILLINOIS	92	13	47
2154	137	921348	AMERICA	ESTADOS UNIDOS DE AMERICA	MICHIGAN	92	13	48
2155	137	921349	AMERICA	ESTADOS UNIDOS DE AMERICA	MISSOURI	92	13	49
2156	137	921350	AMERICA	ESTADOS UNIDOS DE AMERICA	CAROLINA DEL NORTE	92	13	50
2157	137	921351	AMERICA	ESTADOS UNIDOS DE AMERICA	IOWA	92	13	51
2158	137	921352	AMERICA	ESTADOS UNIDOS DE AMERICA	LOUISIANA	92	13	52
2159	137	921353	AMERICA	ESTADOS UNIDOS DE AMERICA	DAKOTA DEL SUR	92	13	53
2160	137	921354	AMERICA	ESTADOS UNIDOS DE AMERICA	RHODE ISLAND	92	13	54
2161	137	921355	AMERICA	ESTADOS UNIDOS DE AMERICA	WASHINGTON	92	13	55
2162	137	921356	AMERICA	ESTADOS UNIDOS DE AMERICA	ARIZONA	92	13	56
2163	137	921357	AMERICA	ESTADOS UNIDOS DE AMERICA	MASSACHUSETTS	92	13	57
2164	137	921358	AMERICA	ESTADOS UNIDOS DE AMERICA	COLORADO	92	13	58
2165	137	921359	AMERICA	ESTADOS UNIDOS DE AMERICA	NEBRASKA	92	13	59
2166	137	921360	AMERICA	ESTADOS UNIDOS DE AMERICA	WYOMING	92	13	60
2167	137	921361	AMERICA	ESTADOS UNIDOS DE AMERICA	DELAWARE	92	13	61
2168	137	921362	AMERICA	ESTADOS UNIDOS DE AMERICA	ARKANSAS	92	13	62
2169	137	921363	AMERICA	ESTADOS UNIDOS DE AMERICA	MONTANA	92	13	63
2170	137	921364	AMERICA	ESTADOS UNIDOS DE AMERICA	TAMPA	92	13	64
2171	137	921365	AMERICA	ESTADOS UNIDOS DE AMERICA	LAS VEGAS	92	13	65
2172	137	921366	AMERICA	ESTADOS UNIDOS DE AMERICA	VIRGINIA DEL OESTE	92	13	66
2173	137	921367	AMERICA	ESTADOS UNIDOS DE AMERICA	CAROLINA DEL SUR	92	13	67
2174	137	921368	AMERICA	ESTADOS UNIDOS DE AMERICA	DAKOTA DEL NORTE	92	13	68
2175	137	921369	AMERICA	ESTADOS UNIDOS DE AMERICA	MAINE	92	13	69
2176	137	921370	AMERICA	ESTADOS UNIDOS DE AMERICA	ALASKA	92	13	70
2177	137	921371	AMERICA	ESTADOS UNIDOS DE AMERICA	JACKSONVILLE	92	13	71
2178	137	921372	AMERICA	ESTADOS UNIDOS DE AMERICA	PHOENIX	92	13	72
2179	137	921373	AMERICA	ESTADOS UNIDOS DE AMERICA	DALLAS	92	13	73
2180	137	921374	AMERICA	ESTADOS UNIDOS DE AMERICA	SALT LAKE CITY	92	13	74
2181	137	921375	AMERICA	ESTADOS UNIDOS DE AMERICA	SACRAMENTO	92	13	75
2182	137	921376	AMERICA	ESTADOS UNIDOS DE AMERICA	AUSTIN	92	13	76
2183	137	921377	AMERICA	ESTADOS UNIDOS DE AMERICA	NEW HAMPSHIRE	92	13	77
2184	137	921378	AMERICA	ESTADOS UNIDOS DE AMERICA	NEVADA	92	13	78
2185	137	921379	AMERICA	ESTADOS UNIDOS DE AMERICA	IDAHO	92	13	79
2186	137	921380	AMERICA	ESTADOS UNIDOS DE AMERICA	FILADELFIA	92	13	80
2187	137	921381	AMERICA	ESTADOS UNIDOS DE AMERICA	ATLANTA	92	13	81
2188	137	921382	AMERICA	ESTADOS UNIDOS DE AMERICA	GUAM	92	13	82
2189	137	921383	AMERICA	ESTADOS UNIDOS DE AMERICA	MISSISSIPPI	92	13	83
2190	137	921384	AMERICA	ESTADOS UNIDOS DE AMERICA	VERMONT	92	13	84
2191	137	921385	AMERICA	ESTADOS UNIDOS DE AMERICA	HARTFORD	92	13	85
2192	137	921386	AMERICA	ESTADOS UNIDOS DE AMERICA	ISLAS MARIANAS DEL NORTE	92	13	86
2193	137	921387	AMERICA	ESTADOS UNIDOS DE AMERICA	ISLAS VIRGENES	92	13	87
2194	137	921388	AMERICA	ESTADOS UNIDOS DE AMERICA	HAWAII	92	13	88
2195	137	921501	AMERICA	GUATEMALA	GUATEMALA	92	15	01
2196	137	921503	AMERICA	GUATEMALA	QUETZALTENANGO	92	15	03
2197	137	921504	AMERICA	GUATEMALA	SACATEPEQUEZ	92	15	04
2198	137	921601	AMERICA	HAITI	PUERTO PRINCIPE	92	16	01
2199	137	921701	AMERICA	HONDURAS	TEGUCIGALPA	92	17	01
2200	137	921703	AMERICA	HONDURAS	CORTES	92	17	03
2201	137	921704	AMERICA	HONDURAS	VALLE	92	17	04
2202	137	921705	AMERICA	HONDURAS	YORO	92	17	05
2203	137	921706	AMERICA	HONDURAS	FRANCISCO MORAZAN	92	17	06
2204	137	921707	AMERICA	HONDURAS	LA CEIBA	92	17	07
2205	137	921708	AMERICA	HONDURAS	SAN PEDRO DE SULA	92	17	08
2206	137	921709	AMERICA	HONDURAS	OLANCHO	92	17	09
2207	137	921710	AMERICA	HONDURAS	ATLANTIDA	92	17	10
2208	137	921711	AMERICA	HONDURAS	COMAYAGUA	92	17	11
2209	137	921714	AMERICA	HONDURAS	ISLAS DE LA BAHIA	92	17	14
2210	137	921801	AMERICA	JAMAICA	KINGSTON	92	18	01
2211	137	921901	AMERICA	MEXICO	GUADALAJARA	92	19	01
2212	137	921902	AMERICA	MEXICO	MEXICO D.F.	92	19	02
2213	137	921903	AMERICA	MEXICO	MONTERREY	92	19	03
2214	137	921904	AMERICA	MEXICO	COAHUILA	92	19	04
2215	137	921905	AMERICA	MEXICO	CHIHUAHUA	92	19	05
2216	137	921906	AMERICA	MEXICO	MICHOACAN	92	19	06
2217	137	921907	AMERICA	MEXICO	SONORA	92	19	07
2218	137	921908	AMERICA	MEXICO	PUEBLA	92	19	08
2219	137	921909	AMERICA	MEXICO	SAN LUIS POTOSI	92	19	09
2220	137	921910	AMERICA	MEXICO	TABASCO	92	19	10
2221	137	921911	AMERICA	MEXICO	VERACRUZ	92	19	11
2222	137	921912	AMERICA	MEXICO	NUEVO LEON	92	19	12
2223	137	921913	AMERICA	MEXICO	YUCATAN	92	19	13
2224	137	940220	EUROPA	ALEMANIA	BAJA SAJONIA	94	02	20
2225	137	940222	EUROPA	ALEMANIA	BIELEFELD	94	02	22
2226	137	940223	EUROPA	ALEMANIA	RENANIA DEL NORTE-WESTFA	94	02	23
2227	137	940224	EUROPA	ALEMANIA	TURINGIA	94	02	24
2228	137	940227	EUROPA	ALEMANIA	DORTMUND	94	02	27
2229	137	940228	EUROPA	ALEMANIA	LUBËCK	94	02	28
2230	137	940230	EUROPA	ALEMANIA	SCHLESWIG-HOLSTEIN	94	02	30
2231	137	940232	EUROPA	ALEMANIA	MECKLEMBURGO-VORPOMMERN	94	02	32
2232	137	940234	EUROPA	ALEMANIA	GÖTTINGEN	94	02	34
2233	137	940235	EUROPA	ALEMANIA	HESSEN	94	02	35
2234	137	940236	EUROPA	ALEMANIA	ROSTOCK	94	02	36
2235	137	940237	EUROPA	ALEMANIA	RENANIA-PALATINADO	94	02	37
2236	137	940238	EUROPA	ALEMANIA	NUREMBERG	94	02	38
2237	137	940239	EUROPA	ALEMANIA	MAGDEBURG	94	02	39
2238	137	940241	EUROPA	ALEMANIA	BRANDENBURGO	94	02	41
2239	137	940242	EUROPA	ALEMANIA	MAGUNCIA	94	02	42
2240	137	940243	EUROPA	ALEMANIA	DUISBURGO	94	02	43
2241	137	940244	EUROPA	ALEMANIA	ERFURT	94	02	44
2242	137	940245	EUROPA	ALEMANIA	MUNICH	94	02	45
2243	137	940246	EUROPA	ALEMANIA	SARRE	94	02	46
2244	137	940248	EUROPA	ALEMANIA	ERLANGEN	94	02	48
2245	137	940251	EUROPA	ALEMANIA	SAJONIA ANHALT	94	02	51
2246	137	940301	EUROPA	AUSTRIA	SALZBURGO	94	03	01
2247	137	940302	EUROPA	AUSTRIA	VIENA	94	03	02
2248	137	940303	EUROPA	AUSTRIA	TIROL	94	03	03
2249	137	940304	EUROPA	AUSTRIA	VORALBERG	94	03	04
2250	137	940305	EUROPA	AUSTRIA	ALTA AUSTRIA	94	03	05
2251	137	940306	EUROPA	AUSTRIA	WIENER NEUSTADT	94	03	06
2252	137	940307	EUROPA	AUSTRIA	BAJA AUSTRIA	94	03	07
2253	137	940309	EUROPA	AUSTRIA	LINZ	94	03	09
2254	137	940310	EUROPA	AUSTRIA	KLAGENFURT	94	03	10
2255	137	940311	EUROPA	AUSTRIA	CARINTHIA	94	03	11
2256	137	940312	EUROPA	AUSTRIA	ESTIRIA	94	03	12
2257	137	940313	EUROPA	AUSTRIA	BURGENLAND	94	03	13
2258	137	940401	EUROPA	BELGICA	AMBERES	94	04	01
2259	137	940402	EUROPA	BELGICA	BRUSELAS	94	04	02
2260	137	940403	EUROPA	BELGICA	GANTE	94	04	03
2261	137	940404	EUROPA	BELGICA	LIEJA	94	04	04
2262	137	940405	EUROPA	BELGICA	LOVAINA	94	04	05
2263	137	940406	EUROPA	BELGICA	NAMUR	94	04	06
2264	137	940407	EUROPA	BELGICA	MAINAUT	94	04	07
2265	137	940408	EUROPA	BELGICA	BRABANTE	94	04	08
2266	137	940409	EUROPA	BELGICA	BRUJAS	94	04	09
2267	137	940410	EUROPA	BELGICA	FLANDES OCCIDENTAL	94	04	10
2268	137	940412	EUROPA	BELGICA	FLANDES ORIENTAL	94	04	12
2269	137	940413	EUROPA	BELGICA	VALONIA	94	04	13
2270	137	940414	EUROPA	BELGICA	LIMBURGO	94	04	14
2271	137	940501	EUROPA	BULGARIA	SOFIA	94	05	01
2272	137	940502	EUROPA	BULGARIA	PLOVDIV	94	05	02
2273	137	940507	EUROPA	BULGARIA	VARNA	94	05	07
2274	137	940601	EUROPA	REPUBLICA CHECA	PRAGA	94	06	01
2275	137	940602	EUROPA	REPUBLICA CHECA	ZLIN	94	06	02
2276	137	940603	EUROPA	REPUBLICA CHECA	PARDUBICE	94	06	03
2277	137	940607	EUROPA	REPUBLICA CHECA	OSTRAVA	94	06	07
2278	137	940608	EUROPA	REPUBLICA CHECA	PILSEN	94	06	08
2279	137	940610	EUROPA	REPUBLICA CHECA	MORAVIA	94	06	10
2280	137	940611	EUROPA	REPUBLICA CHECA	LIBEREC	94	06	11
2281	137	940612	EUROPA	REPUBLICA CHECA	USTI NAD LABEM	94	06	12
2282	137	940614	EUROPA	REPUBLICA CHECA	PLZEÑ	94	06	14
2283	137	940615	EUROPA	REPUBLICA CHECA	BRNO	94	06	15
2284	137	940616	EUROPA	REPUBLICA CHECA	HRADEC KRÁLOVÉ	94	06	16
2285	137	940620	EUROPA	REPUBLICA CHECA	BOHEMIA SEPTENTRIONAL	94	06	20
2286	137	940624	EUROPA	REPUBLICA CHECA	BOHEMIA CENTRAL	94	06	24
2287	137	940701	EUROPA	CHIPRE	LIMASSOL	94	07	01
2288	137	940702	EUROPA	CHIPRE	NICOSIA	94	07	02
2289	137	940801	EUROPA	DINAMARCA	COPENHAGUE	94	08	01
2290	137	940802	EUROPA	DINAMARCA	KOLDING	94	08	02
2291	137	940803	EUROPA	DINAMARCA	ODENSE	94	08	03
2292	137	940804	EUROPA	DINAMARCA	ROSKILDE	94	08	04
2293	137	940805	EUROPA	DINAMARCA	ARHUS	94	08	05
2294	137	940806	EUROPA	DINAMARCA	VEJLE	94	08	06
2295	137	940807	EUROPA	DINAMARCA	JUTLANDIA DEL NORTE	94	08	07
2296	137	940808	EUROPA	DINAMARCA	SEELANDIA OCCIDENTAL	94	08	08
2297	137	940901	EUROPA	ESPAÑA	ALICANTE	94	09	01
2298	137	940902	EUROPA	ESPAÑA	BARCELONA	94	09	02
2299	137	940903	EUROPA	ESPAÑA	BILBAO	94	09	03
2300	137	940904	EUROPA	ESPAÑA	CADIZ	94	09	04
2301	137	940905	EUROPA	ESPAÑA	SALAMANCA	94	09	05
2302	137	940906	EUROPA	ESPAÑA	GIJON	94	09	06
2303	137	940907	EUROPA	ESPAÑA	CACERES	94	09	07
2304	137	940908	EUROPA	ESPAÑA	LA CORUÑA	94	09	08
2305	137	940909	EUROPA	ESPAÑA	LAS PALMAS	94	09	09
2306	137	940910	EUROPA	ESPAÑA	MADRID	94	09	10
2307	137	940911	EUROPA	ESPAÑA	MALAGA	94	09	11
2308	137	940912	EUROPA	ESPAÑA	TOLEDO	94	09	12
2309	137	940913	EUROPA	ESPAÑA	MALLORCA	94	09	13
2310	137	940914	EUROPA	ESPAÑA	SAN SEBASTIAN	94	09	14
2311	137	940915	EUROPA	ESPAÑA	TENERIFE	94	09	15
2312	137	940916	EUROPA	ESPAÑA	SANTANDER	94	09	16
2313	137	940917	EUROPA	ESPAÑA	ZARAGOZA	94	09	17
2314	137	940918	EUROPA	ESPAÑA	SEVILLA	94	09	18
2315	137	940919	EUROPA	ESPAÑA	TARRAGONA	94	09	19
2316	137	940920	EUROPA	ESPAÑA	VALENCIA	94	09	20
2317	137	940921	EUROPA	ESPAÑA	VALLADOLID	94	09	21
2318	137	940922	EUROPA	ESPAÑA	VIGO	94	09	22
2319	137	940923	EUROPA	ESPAÑA	NAVARRA	94	09	23
2320	137	940924	EUROPA	ESPAÑA	LOGROÑO	94	09	24
2321	137	940925	EUROPA	ESPAÑA	GRANADA	94	09	25
2322	137	940926	EUROPA	ESPAÑA	LEON	94	09	26
2323	137	940927	EUROPA	ESPAÑA	ASTURIAS	94	09	27
2324	137	940928	EUROPA	ESPAÑA	SORIA	94	09	28
2325	137	940929	EUROPA	ESPAÑA	BURGOS	94	09	29
2326	137	940930	EUROPA	ESPAÑA	MURCIA	94	09	30
2327	137	940931	EUROPA	ESPAÑA	OVIEDO	94	09	31
2328	137	940932	EUROPA	ESPAÑA	BADAJOZ	94	09	32
2329	137	940933	EUROPA	ESPAÑA	GUADALAJARA	94	09	33
2330	137	940934	EUROPA	ESPAÑA	HUESCA	94	09	34
2331	137	940935	EUROPA	ESPAÑA	ALMERIA	94	09	35
2332	137	940936	EUROPA	ESPAÑA	ZAMORA	94	09	36
2333	137	940937	EUROPA	ESPAÑA	PONTEVEDRA	94	09	37
2334	137	940938	EUROPA	ESPAÑA	PALENCIA	94	09	38
2335	137	940939	EUROPA	ESPAÑA	ORENSE	94	09	39
2336	137	940940	EUROPA	ESPAÑA	AVILA	94	09	40
2337	137	940941	EUROPA	ESPAÑA	CORDOBA	94	09	41
2338	137	940942	EUROPA	ESPAÑA	LERIDA	94	09	42
2339	137	940943	EUROPA	ESPAÑA	JAEN	94	09	43
2340	137	940944	EUROPA	ESPAÑA	CIUDAD REAL	94	09	44
2341	137	940945	EUROPA	ESPAÑA	GERONA	94	09	45
2342	137	940946	EUROPA	ESPAÑA	VICTORIA	94	09	46
2343	137	940947	EUROPA	ESPAÑA	VIZCAYA	94	09	47
2344	137	940948	EUROPA	ESPAÑA	CUENCA	94	09	48
2345	137	940949	EUROPA	ESPAÑA	CASTELLON	94	09	49
2346	137	940950	EUROPA	ESPAÑA	LUGO	94	09	50
2347	137	940951	EUROPA	ESPAÑA	HUELVA	94	09	51
2348	137	940952	EUROPA	ESPAÑA	SEGOVIA	94	09	52
2349	137	940953	EUROPA	ESPAÑA	ALBACETE	94	09	53
2350	137	940954	EUROPA	ESPAÑA	LOS LLANOS DE ARIDANE	94	09	54
2351	137	940955	EUROPA	ESPAÑA	TERUEL	94	09	55
2352	137	940956	EUROPA	ESPAÑA	GUIPUZCOA	94	09	56
2353	137	940957	EUROPA	ESPAÑA	BALEARES	94	09	57
2354	137	940958	EUROPA	ESPAÑA	ALAVA	94	09	58
2355	137	940960	EUROPA	ESPAÑA	CATALUÑA	94	09	60
2356	137	940961	EUROPA	ESPAÑA	CANTABRIA	94	09	61
2357	137	940962	EUROPA	ESPAÑA	GALICIA	94	09	62
2358	137	940963	EUROPA	ESPAÑA	MELILLA	94	09	63
2359	137	940964	EUROPA	ESPAÑA	CEUTA	94	09	64
2360	137	940965	EUROPA	ESPAÑA	LA RIOJA	94	09	65
2361	137	941001	EUROPA	FINLANDIA	HELSINKY	94	10	01
2362	137	941003	EUROPA	FINLANDIA	KOTKA	94	10	03
2363	137	941004	EUROPA	FINLANDIA	OULU	94	10	04
2364	137	941005	EUROPA	FINLANDIA	KUOPIO	94	10	05
2365	137	941006	EUROPA	FINLANDIA	HAME	94	10	06
2366	137	941007	EUROPA	FINLANDIA	TURKU	94	10	07
2367	137	941008	EUROPA	FINLANDIA	FINLANDIA MERIDIONAL	94	10	08
2368	137	941009	EUROPA	FINLANDIA	FINLANDIA ORIENTAL	94	10	09
2369	137	941010	EUROPA	FINLANDIA	UUSIMAA	94	10	10
2370	137	941011	EUROPA	FINLANDIA	TAMPERE	94	10	11
2371	137	941012	EUROPA	FINLANDIA	OSTROBOTNIA DEL SUR	94	10	12
2372	137	941013	EUROPA	FINLANDIA	OSTROBOTNIA	94	10	13
2373	137	941015	EUROPA	FINLANDIA	SATAKUNTA	94	10	15
2374	137	941016	EUROPA	FINLANDIA	ESPOO	94	10	16
2375	137	941101	EUROPA	FRANCIA	BURDEOS	94	11	01
2376	137	941102	EUROPA	FRANCIA	EL HAVRE	94	11	02
2377	137	941103	EUROPA	FRANCIA	ESTRASBURGO	94	11	03
2378	137	941104	EUROPA	FRANCIA	LA ROCHELLE	94	11	04
2379	137	941105	EUROPA	FRANCIA	LYON	94	11	05
2380	137	941106	EUROPA	FRANCIA	MARSELLA	94	11	06
2381	137	941107	EUROPA	FRANCIA	NIZA	94	11	07
2382	137	941108	EUROPA	FRANCIA	PARIS	94	11	08
2383	137	941109	EUROPA	FRANCIA	GRENOBLE	94	11	09
2384	137	941110	EUROPA	FRANCIA	TOULOUSE	94	11	10
2385	137	941111	EUROPA	FRANCIA	REIMS	94	11	11
2386	137	941112	EUROPA	FRANCIA	AQUITANIA	94	11	12
2387	137	941113	EUROPA	FRANCIA	ISLA DE FRANCIA	94	11	13
2388	137	941114	EUROPA	FRANCIA	QUIMPER	94	11	14
2389	137	941115	EUROPA	FRANCIA	BORGOÑA	94	11	15
2390	137	941117	EUROPA	FRANCIA	LORENA	94	11	17
2391	137	941119	EUROPA	FRANCIA	BRETAÑA	94	11	19
2392	137	941120	EUROPA	FRANCIA	LANGUEDOC-ROUSSILLON	94	11	20
2393	137	941121	EUROPA	FRANCIA	RHONE - ALPES	94	11	21
2394	137	941122	EUROPA	FRANCIA	PUY DE DOME	94	11	22
2395	137	941123	EUROPA	FRANCIA	CHAMPAÑA Y ARDENA	94	11	23
2396	137	941124	EUROPA	FRANCIA	LILLE	94	11	24
2397	137	941125	EUROPA	FRANCIA	NORMANDIA	94	11	25
2398	137	941126	EUROPA	FRANCIA	BARBENTANE	94	11	26
2399	137	941127	EUROPA	FRANCIA	GIRONDE	94	11	27
2400	137	941128	EUROPA	FRANCIA	MARTINICA	94	11	28
2401	137	941129	EUROPA	FRANCIA	BLOIS	94	11	29
2402	137	941130	EUROPA	FRANCIA	ANNEMASSE	94	11	30
2403	137	941131	EUROPA	FRANCIA	AUVERNIA	94	11	31
2404	137	941132	EUROPA	FRANCIA	LIMOUSIN	94	11	32
2405	137	941133	EUROPA	FRANCIA	NORTE PASO DE CALAIS	94	11	33
2406	137	941134	EUROPA	FRANCIA	ALSACIA	94	11	34
2407	137	941135	EUROPA	FRANCIA	PIRINEOS MERIDIONALES	94	11	35
2408	137	941136	EUROPA	FRANCIA	PROVENZA-COSTA AZUL	94	11	36
2409	137	941137	EUROPA	FRANCIA	CENTRO VALLE DEL LOIRA	94	11	37
2410	137	941138	EUROPA	FRANCIA	LANGUEDOC-ROSELLON	94	11	38
2411	137	941139	EUROPA	FRANCIA	BAJA NORMANDIA	94	11	39
2412	137	941140	EUROPA	FRANCIA	POLINESIA FRANCESA	94	11	40
2413	137	941142	EUROPA	FRANCIA	PAIS DEL LOIRA	94	11	42
2414	137	941143	EUROPA	FRANCIA	POITOU-CHARENTES	94	11	43
2415	137	941144	EUROPA	FRANCIA	ILE DE FRANCE	94	11	44
2416	137	941145	EUROPA	FRANCIA	PICARDIA	94	11	45
2417	137	941146	EUROPA	FRANCIA	NUEVA CALEDONIA	94	11	46
2418	137	941147	EUROPA	FRANCIA	ALTA NORMANDIA	94	11	47
2419	137	941148	EUROPA	FRANCIA	FRANCO CONDADO	94	11	48
2420	137	941149	EUROPA	FRANCIA	GUAYANA FRANCESA CAYENA	94	11	49
2421	137	941150	EUROPA	FRANCIA	GUAYANA FRANCESA KURU	94	11	50
2422	137	941151	EUROPA	FRANCIA	GUAYANA FRANCESA ST.LAURENT	94	11	51
2423	137	941152	EUROPA	FRANCIA	MONTPELLIER	94	11	52
2424	137	941154	EUROPA	FRANCIA	LA REUNION	94	11	54
2425	137	941155	EUROPA	FRANCIA	PIRINEOS ORIENTALES	94	11	55
2426	137	941156	EUROPA	FRANCIA	CORCEGA	94	11	56
2427	137	941161	EUROPA	FRANCIA	CENTRO	94	11	61
2428	137	941165	EUROPA	FRANCIA	MEDIODIA PIRINEOS	94	11	65
2429	137	941201	EUROPA	GRAN BRETAÑA	GLASGOW	94	12	01
2430	137	941202	EUROPA	GRAN BRETAÑA	HULL	94	12	02
2431	137	941203	EUROPA	GRAN BRETAÑA	LIVERPOOL	94	12	03
2432	137	941204	EUROPA	GRAN BRETAÑA	LONDRES	94	12	04
2433	137	941205	EUROPA	GRAN BRETAÑA	MANCHESTER	94	12	05
2434	137	941206	EUROPA	GRAN BRETAÑA	ESCOCIA	94	12	06
2435	137	941207	EUROPA	GRAN BRETAÑA	CAMBRIDGESHIRE	94	12	07
2436	137	941208	EUROPA	GRAN BRETAÑA	WARWICKSHIRE	94	12	08
2437	137	941209	EUROPA	GRAN BRETAÑA	EDIMBURGO	94	12	09
2438	137	941210	EUROPA	GRAN BRETAÑA	HERTFORDSHIRE	94	12	10
2439	137	941211	EUROPA	GRAN BRETAÑA	YORKSHIRE	94	12	11
2440	137	941212	EUROPA	GRAN BRETAÑA	WILTSHIRE	94	12	12
2441	137	941213	EUROPA	GRAN BRETAÑA	STAFFORDSHIRE	94	12	13
2442	137	941214	EUROPA	GRAN BRETAÑA	OXFORD	94	12	14
2443	137	941216	EUROPA	GRAN BRETAÑA	DURHAM	94	12	16
2444	137	941217	EUROPA	GRAN BRETAÑA	HAMPSHIRE	94	12	17
2445	137	941218	EUROPA	GRAN BRETAÑA	PENZANCE	94	12	18
2446	137	941219	EUROPA	GRAN BRETAÑA	LANCASHIRE	94	12	19
2447	137	941220	EUROPA	GRAN BRETAÑA	WEST YORKSHIRE	94	12	20
2448	137	941221	EUROPA	GRAN BRETAÑA	SURREY	94	12	21
2449	137	941222	EUROPA	GRAN BRETAÑA	SHEFFIELD	94	12	22
2450	137	941223	EUROPA	GRAN BRETAÑA	NEWCASTLE	94	12	23
2451	137	941224	EUROPA	GRAN BRETAÑA	EAST SUSSEX	94	12	24
2452	137	941225	EUROPA	GRAN BRETAÑA	DEVON	94	12	25
2453	137	941226	EUROPA	GRAN BRETAÑA	GALES	94	12	26
2454	137	941227	EUROPA	GRAN BRETAÑA	KENT	94	12	27
2455	137	941228	EUROPA	GRAN BRETAÑA	CUMBRIA	94	12	28
2456	137	941229	EUROPA	GRAN BRETAÑA	CHESHIRE	94	12	29
2457	137	941230	EUROPA	GRAN BRETAÑA	BIRMINGHAM	94	12	30
2458	137	941231	EUROPA	GRAN BRETAÑA	SHROPSHIRE	94	12	31
2459	137	941232	EUROPA	GRAN BRETAÑA	ESSEX	94	12	32
2460	137	941233	EUROPA	GRAN BRETAÑA	DERBYSHIRE	94	12	33
2461	137	941234	EUROPA	GRAN BRETAÑA	WEST SUSSEX	94	12	34
2462	137	941235	EUROPA	GRAN BRETAÑA	LINCOLNSHIRE	94	12	35
2463	137	941236	EUROPA	GRAN BRETAÑA	READING	94	12	36
2464	137	941237	EUROPA	GRAN BRETAÑA	CORNWALL	94	12	37
2465	137	941239	EUROPA	GRAN BRETAÑA	SOMERSET	94	12	39
2466	137	941240	EUROPA	GRAN BRETAÑA	BRADFORD	94	12	40
2467	137	941241	EUROPA	GRAN BRETAÑA	LEEDS	94	12	41
2468	137	941242	EUROPA	GRAN BRETAÑA	LANCASTER	94	12	42
2469	137	941243	EUROPA	GRAN BRETAÑA	LEICESTER	94	12	43
2470	137	941244	EUROPA	GRAN BRETAÑA	GLOUCESTERSHIRE	94	12	44
2471	137	941245	EUROPA	GRAN BRETAÑA	HEREFORDSHIRE	94	12	45
2472	137	941246	EUROPA	GRAN BRETAÑA	SUFFOLK	94	12	46
2473	137	941247	EUROPA	GRAN BRETAÑA	WORCESTERSHIRE	94	12	47
2474	137	941248	EUROPA	GRAN BRETAÑA	NORTHAMPTONSHIRE	94	12	48
2475	137	941249	EUROPA	GRAN BRETAÑA	BOURNEMOUTH	94	12	49
2476	137	941250	EUROPA	GRAN BRETAÑA	BRISTOL	94	12	50
2477	137	941251	EUROPA	GRAN BRETAÑA	BUCKINGHAMSHIRE	94	12	51
2478	137	941252	EUROPA	GRAN BRETAÑA	LUTON	94	12	52
2479	137	941253	EUROPA	GRAN BRETAÑA	BEDFORDSHIRE	94	12	53
2480	137	941255	EUROPA	GRAN BRETAÑA	BRIGHTON & HOVE	94	12	55
2481	137	941257	EUROPA	GRAN BRETAÑA	ROTHERHAM	94	12	57
2482	137	941259	EUROPA	GRAN BRETAÑA	WOLVERHAMPTON	94	12	59
2483	137	941260	EUROPA	GRAN BRETAÑA	NORWICH	94	12	60
2484	137	941261	EUROPA	GRAN BRETAÑA	WALSALL	94	12	61
2485	137	941262	EUROPA	GRAN BRETAÑA	DORSET	94	12	62
2486	137	941263	EUROPA	GRAN BRETAÑA	NOTTINGHAMSHIRE	94	12	63
2487	137	941264	EUROPA	GRAN BRETAÑA	SOUTHAMPTON	94	12	64
2488	137	941301	EUROPA	GRECIA	ATENAS	94	13	01
2489	137	941302	EUROPA	GRECIA	SALONICA	94	13	02
2490	137	941303	EUROPA	GRECIA	EL PIREO	94	13	03
2491	137	941304	EUROPA	GRECIA	CRETA	94	13	04
2492	137	941305	EUROPA	GRECIA	LEFKADA	94	13	05
2493	137	941306	EUROPA	GRECIA	EGINA	94	13	06
2494	137	941307	EUROPA	GRECIA	SANTORINI	94	13	07
2495	137	941308	EUROPA	GRECIA	THASOS	94	13	08
2496	137	941309	EUROPA	GRECIA	LACONIA	94	13	09
2497	137	941310	EUROPA	GRECIA	PAROS	94	13	10
2498	137	941312	EUROPA	GRECIA	RODAS	94	13	12
2499	137	941315	EUROPA	GRECIA	MESENIA	94	13	15
2500	137	941401	EUROPA	HOLANDA	AMSTERDAM	94	14	01
2501	137	941402	EUROPA	HOLANDA	ROTERDAM	94	14	02
2502	137	941403	EUROPA	HOLANDA	EINDHOVEN	94	14	03
2503	137	941404	EUROPA	HOLANDA	LA HAYA	94	14	04
2504	137	941405	EUROPA	HOLANDA	ZELANDE	94	14	05
2505	137	941406	EUROPA	HOLANDA	OVERIJSSEL	94	14	06
2506	137	941407	EUROPA	HOLANDA	HOLANDA SEPTENTRIONAL	94	14	07
2507	137	941408	EUROPA	HOLANDA	GELDRE	94	14	08
2508	137	941409	EUROPA	HOLANDA	UTRECHT	94	14	09
2509	137	941410	EUROPA	HOLANDA	HOLANDA MERIDIONAL	94	14	10
2510	137	941411	EUROPA	HOLANDA	ZAANDAM	94	14	11
2511	137	941412	EUROPA	HOLANDA	LIMBURGO	94	14	12
2512	137	941413	EUROPA	HOLANDA	ANTILLAS NEERLANDESAS	94	14	13
2513	137	941414	EUROPA	HOLANDA	BRABANTE SEPTENTRIONAL	94	14	14
2514	137	941416	EUROPA	HOLANDA	FRISIA	94	14	16
2515	137	941418	EUROPA	HOLANDA	GRONINGEN	94	14	18
2516	137	941419	EUROPA	HOLANDA	DELFT	94	14	19
2517	137	941420	EUROPA	HOLANDA	FLEVOLAND	94	14	20
2518	137	941421	EUROPA	HOLANDA	DRENTHE	94	14	21
2519	137	941501	EUROPA	HUNGRIA	BUDAPEST	94	15	01
2520	137	941502	EUROPA	HUNGRIA	SZEGED	94	15	02
2521	137	941503	EUROPA	HUNGRIA	VESZPREM	94	15	03
2522	137	941504	EUROPA	HUNGRIA	NOGRAD	94	15	04
2523	137	941507	EUROPA	HUNGRIA	BARANYA	94	15	07
2524	137	941508	EUROPA	HUNGRIA	DEBRECEN	94	15	08
2525	137	941512	EUROPA	HUNGRIA	GYÖR	94	15	12
2526	137	941513	EUROPA	HUNGRIA	VAS	94	15	13
2527	137	941514	EUROPA	HUNGRIA	BEKES	94	15	14
2528	137	941516	EUROPA	HUNGRIA	PEST	94	15	16
2529	137	941601	EUROPA	ISLANDIA	REYKJAVIK	94	16	01
2530	137	941701	EUROPA	ITALIA	BOLONIA	94	17	01
2531	137	941702	EUROPA	ITALIA	CHIAVARI	94	17	02
2532	137	941703	EUROPA	ITALIA	FLORENCIA	94	17	03
2533	137	941704	EUROPA	ITALIA	GENOVA	94	17	04
2534	137	941705	EUROPA	ITALIA	LIVORNO	94	17	05
2535	137	941706	EUROPA	ITALIA	MILAN	94	17	06
2536	137	941707	EUROPA	ITALIA	NAPOLES	94	17	07
2537	137	941708	EUROPA	ITALIA	PALERMO	94	17	08
2538	137	941709	EUROPA	ITALIA	ROMA	94	17	09
2539	137	941710	EUROPA	ITALIA	TRIESTE	94	17	10
2540	137	941711	EUROPA	ITALIA	TURIN	94	17	11
2541	137	941712	EUROPA	ITALIA	VENETO	94	17	12
2542	137	941713	EUROPA	ITALIA	CERDEÑA	94	17	13
2543	137	941714	EUROPA	ITALIA	UMBRIA	94	17	14
2544	137	941715	EUROPA	ITALIA	LACIO	94	17	15
2545	137	941716	EUROPA	ITALIA	ABRUZOS	94	17	16
2546	137	941717	EUROPA	ITALIA	MARCAS	94	17	17
2547	137	941718	EUROPA	ITALIA	BASILICATA	94	17	18
2548	137	941719	EUROPA	ITALIA	SICILIA	94	17	19
2549	137	941720	EUROPA	ITALIA	VERCELLI	94	17	20
2550	137	941721	EUROPA	ITALIA	MOLISE	94	17	21
2551	137	941722	EUROPA	ITALIA	LA SPEZIA	94	17	22
2552	137	941723	EUROPA	ITALIA	SIENA	94	17	23
2553	137	941724	EUROPA	ITALIA	PADUA	94	17	24
2554	137	941725	EUROPA	ITALIA	PIAMONTE	94	17	25
2555	137	941726	EUROPA	ITALIA	TRENTINO ALTO ADIGIO	94	17	26
2556	137	941727	EUROPA	ITALIA	FRIULI VENEZIA GIULIA	94	17	27
2557	137	941728	EUROPA	ITALIA	CALABRIA	94	17	28
2558	137	941729	EUROPA	ITALIA	APULIA	94	17	29
2559	137	941730	EUROPA	ITALIA	LIGURIA	94	17	30
2560	137	941731	EUROPA	ITALIA	LOMBARDIA	94	17	31
2561	137	941732	EUROPA	ITALIA	LUCA	94	17	32
2562	137	941734	EUROPA	ITALIA	BARI	94	17	34
2563	137	941735	EUROPA	ITALIA	CATANIA	94	17	35
2564	137	941736	EUROPA	ITALIA	CAMPANIA	94	17	36
2565	137	941737	EUROPA	ITALIA	REGGIO	94	17	37
2566	137	941738	EUROPA	ITALIA	FORLI	94	17	38
2567	137	941739	EUROPA	ITALIA	PARMA	94	17	39
2568	137	941740	EUROPA	ITALIA	TOSCANA	94	17	40
2569	137	941741	EUROPA	ITALIA	VALLE DE AOSTA	94	17	41
2570	137	941742	EUROPA	ITALIA	CESENA	94	17	42
2571	137	941743	EUROPA	ITALIA	EMILIA ROMAGNA	94	17	43
2572	137	941744	EUROPA	ITALIA	LE MARCHE	94	17	44
2573	137	941746	EUROPA	ITALIA	BRESCIA	94	17	46
2574	137	941747	EUROPA	ITALIA	PIACENZA	94	17	47
2575	137	941748	EUROPA	ITALIA	PERUGIA	94	17	48
2576	137	941749	EUROPA	ITALIA	BERGAMO	94	17	49
2577	137	941750	EUROPA	ITALIA	SAVONA	94	17	50
2578	137	941752	EUROPA	ITALIA	LECCE-GALLIPOLI	94	17	52
2579	137	941753	EUROPA	ITALIA	VICENZA	94	17	53
2580	137	941754	EUROPA	ITALIA	VENECIA	94	17	54
2581	137	941755	EUROPA	ITALIA	BOLZANO	94	17	55
2582	137	941756	EUROPA	ITALIA	VARESE	94	17	56
2583	137	941757	EUROPA	ITALIA	IMPERIA	94	17	57
2584	137	941758	EUROPA	ITALIA	LECCO	94	17	58
2585	137	941759	EUROPA	ITALIA	NOVARA	94	17	59
2586	137	941761	EUROPA	ITALIA	LODI	94	17	61
2587	137	941762	EUROPA	ITALIA	COMO	94	17	62
2588	137	941764	EUROPA	ITALIA	CUNEO	94	17	64
2589	137	941765	EUROPA	ITALIA	ASTI	94	17	65
2590	137	941766	EUROPA	ITALIA	BIELLA	94	17	66
2591	137	941767	EUROPA	ITALIA	VERBANIA	94	17	67
2592	137	941768	EUROPA	ITALIA	VERBANO CUSIO OSSOLA	94	17	68
2593	137	941770	EUROPA	ITALIA	PAVIA	94	17	70
2594	137	941801	EUROPA	IRLANDA	DUBLIN	94	18	01
2595	137	941802	EUROPA	IRLANDA	LEINSTER	94	18	02
2596	137	941803	EUROPA	IRLANDA	MUNSTER	94	18	03
2597	137	941804	EUROPA	IRLANDA	GALWAY	94	18	04
2598	137	941806	EUROPA	IRLANDA	DONEGAL	94	18	06
2599	137	941807	EUROPA	IRLANDA	KILKENNY	94	18	07
2600	137	941808	EUROPA	IRLANDA	CORK	94	18	08
2601	137	941809	EUROPA	IRLANDA	WATERFORD	94	18	09
2602	137	941810	EUROPA	IRLANDA	KILDARE	94	18	10
2603	137	941812	EUROPA	IRLANDA	ROSCOMMON	94	18	12
2604	137	941813	EUROPA	IRLANDA	WICKLOW	94	18	13
2605	137	941901	EUROPA	LIECHTENSTEIN, PRINCIPADO DE	VADUZ	94	19	01
2606	137	942001	EUROPA	LUXEMBURGO, GRAN DUCADO DE	LUXEMBURGO	94	20	01
2607	137	942101	EUROPA	MALTA	LA VALETTA	94	21	01
2608	137	942201	EUROPA	MONACO, PRINCIPADO DE	MONTECARLO	94	22	01
2609	137	942202	EUROPA	MONACO, PRINCIPADO DE	MONACO	94	22	02
2610	137	942301	EUROPA	NORUEGA	BERGEN	94	23	01
2611	137	942302	EUROPA	NORUEGA	OSLO	94	23	02
2612	137	942303	EUROPA	NORUEGA	OSTFOLD	94	23	03
2613	137	942304	EUROPA	NORUEGA	TRONDHEIM	94	23	04
2614	137	942305	EUROPA	NORUEGA	FINNMARK	94	23	05
2615	137	942306	EUROPA	NORUEGA	SOGN OG FJORDANE	94	23	06
2616	137	942307	EUROPA	NORUEGA	ROGALAND	94	23	07
2617	137	942308	EUROPA	NORUEGA	TROMS	94	23	08
2618	137	942309	EUROPA	NORUEGA	HORDALAND	94	23	09
2619	137	942310	EUROPA	NORUEGA	NORDLAND	94	23	10
2620	137	942311	EUROPA	NORUEGA	VESTFOLD	94	23	11
2621	137	942312	EUROPA	NORUEGA	BUSKERUD	94	23	12
2622	137	942313	EUROPA	NORUEGA	HEDMARK	94	23	13
2623	137	942315	EUROPA	NORUEGA	AUST-AGDER	94	23	15
2624	137	942316	EUROPA	NORUEGA	AKERSHUS	94	23	16
2625	137	942317	EUROPA	NORUEGA	STAVANGER	94	23	17
2626	137	942318	EUROPA	NORUEGA	TELEMARK	94	23	18
2627	137	942320	EUROPA	NORUEGA	MORE OG ROMSDAL	94	23	20
2628	137	942401	EUROPA	POLONIA	VARSOVIA	94	24	01
2629	137	942402	EUROPA	POLONIA	GDYNIA	94	24	02
2630	137	942403	EUROPA	POLONIA	LODZ	94	24	03
2631	137	942407	EUROPA	POLONIA	SZCZECIN	94	24	07
2632	137	942410	EUROPA	POLONIA	KATOWICE	94	24	10
2633	137	942412	EUROPA	POLONIA	ZAMOSC	94	24	12
2634	137	942415	EUROPA	POLONIA	GDANSK	94	24	15
2635	137	942424	EUROPA	POLONIA	BIALYSTOK	94	24	24
2636	137	942427	EUROPA	POLONIA	CRACOVIA	94	24	27
2637	137	942428	EUROPA	POLONIA	WROCLAW	94	24	28
2638	137	942429	EUROPA	POLONIA	POZNAN	94	24	29
2639	137	942431	EUROPA	POLONIA	OLSZTYN	94	24	31
2640	137	942433	EUROPA	POLONIA	ELK	94	24	33
2641	137	942434	EUROPA	POLONIA	BIELSKO-BIALA	94	24	34
2642	137	942438	EUROPA	POLONIA	BAJA SILESIA	94	24	38
2643	137	942439	EUROPA	POLONIA	TARNOW	94	24	39
2644	137	942501	EUROPA	PORTUGAL	FUNCHAL	94	25	01
2645	137	942502	EUROPA	PORTUGAL	LISBOA	94	25	02
2646	137	942504	EUROPA	PORTUGAL	OPORTO	94	25	04
2647	137	942505	EUROPA	PORTUGAL	BRAGA	94	25	05
2648	137	942506	EUROPA	PORTUGAL	COIMBRA	94	25	06
2649	137	942507	EUROPA	PORTUGAL	VIANA DO CASTELO	94	25	07
2650	137	942508	EUROPA	PORTUGAL	AVEIRO	94	25	08
2651	137	942509	EUROPA	PORTUGAL	LEIRIA	94	25	09
2652	137	942510	EUROPA	PORTUGAL	MADEIRA	94	25	10
2653	137	942511	EUROPA	PORTUGAL	SANTAREM	94	25	11
2654	137	942512	EUROPA	PORTUGAL	FARO	94	25	12
2655	137	942513	EUROPA	PORTUGAL	VISEU	94	25	13
2656	137	942514	EUROPA	PORTUGAL	CASTELO BRANCO	94	25	14
2657	137	942515	EUROPA	PORTUGAL	SETUBAL	94	25	15
2658	137	942516	EUROPA	PORTUGAL	EVORA	94	25	16
2659	137	942517	EUROPA	PORTUGAL	ALGARVE	94	25	17
2660	137	942601	EUROPA	RUMANIA	BUCAREST	94	26	01
2661	137	942604	EUROPA	RUMANIA	TIMISOARA	94	26	04
2662	137	942606	EUROPA	RUMANIA	IASI	94	26	06
2663	137	942608	EUROPA	RUMANIA	SATU MARE	94	26	08
2664	137	942609	EUROPA	RUMANIA	CRAIOVA	94	26	09
2665	137	942612	EUROPA	RUMANIA	BRASOV	94	26	12
2666	137	942613	EUROPA	RUMANIA	CLUJ-NAPOCA	94	26	13
2667	137	942616	EUROPA	RUMANIA	BACAU	94	26	16
2668	137	942617	EUROPA	RUMANIA	SIBIU	94	26	17
2669	137	942618	EUROPA	RUMANIA	TIMIS	94	26	18
2670	137	942626	EUROPA	RUMANIA	NEAMT	94	26	26
2671	137	942628	EUROPA	RUMANIA	GORJ	94	26	28
2672	137	942632	EUROPA	RUMANIA	ILFOV	94	26	32
2673	137	942634	EUROPA	RUMANIA	ARAD	94	26	34
2674	137	942701	EUROPA	SUECIA	ESTOCOLMO	94	27	01
2675	137	942702	EUROPA	SUECIA	GOTEMBURGO	94	27	02
2676	137	942703	EUROPA	SUECIA	MALMO	94	27	03
2677	137	942704	EUROPA	SUECIA	SÖDERMANLAND	94	27	04
2678	137	942705	EUROPA	SUECIA	UPPSALA	94	27	05
2679	137	942706	EUROPA	SUECIA	VÄSTERBOTTEN	94	27	06
2680	137	942707	EUROPA	SUECIA	VÄSTERÅS	94	27	07
2681	137	942708	EUROPA	SUECIA	ÖSTERGÖTLAND	94	27	08
2682	137	942709	EUROPA	SUECIA	VÄSTERNORRLAND	94	27	09
2683	137	942710	EUROPA	SUECIA	ÖREBRO	94	27	10
2684	137	942711	EUROPA	SUECIA	NORRBOTTEN	94	27	11
2685	137	942712	EUROPA	SUECIA	JÖNKÖPING	94	27	12
2686	137	942713	EUROPA	SUECIA	KOPPARBERG	94	27	13
2687	137	942714	EUROPA	SUECIA	KRONOBERG	94	27	14
2688	137	942715	EUROPA	SUECIA	GOTLAND	94	27	15
2689	137	942716	EUROPA	SUECIA	KALMAR	94	27	16
2690	137	921914	AMERICA	MEXICO	GUANAJUATO	92	19	14
2691	137	921915	AMERICA	MEXICO	OAXACA	92	19	15
2692	137	921916	AMERICA	MEXICO	CHIAPAS	92	19	16
2693	137	921917	AMERICA	MEXICO	SINALOA	92	19	17
2694	137	921918	AMERICA	MEXICO	TAMAULIPAS	92	19	18
2695	137	921919	AMERICA	MEXICO	MORELOS	92	19	19
2696	137	921920	AMERICA	MEXICO	BAJA CALIFORNIA NORTE	92	19	20
2697	137	921921	AMERICA	MEXICO	HIDALGO	92	19	21
2698	137	921922	AMERICA	MEXICO	CAMPECHE	92	19	22
2699	137	921923	AMERICA	MEXICO	CANCUN	92	19	23
2700	137	921924	AMERICA	MEXICO	BAJA CALIFORNIA SUR	92	19	24
2701	137	921925	AMERICA	MEXICO	QUERETARO	92	19	25
2702	137	921926	AMERICA	MEXICO	GUERRERO	92	19	26
2703	137	921927	AMERICA	MEXICO	AGUASCALIENTES	92	19	27
2704	137	921928	AMERICA	MEXICO	NAYARIT	92	19	28
2705	137	921929	AMERICA	MEXICO	JALISCO	92	19	29
2706	137	921930	AMERICA	MEXICO	MEXICO	92	19	30
2707	137	921931	AMERICA	MEXICO	QUINTANA ROO	92	19	31
2708	137	921932	AMERICA	MEXICO	ZACATECAS	92	19	32
2709	137	921933	AMERICA	MEXICO	COLIMA	92	19	33
2710	137	921934	AMERICA	MEXICO	DURANGO	92	19	34
2711	137	921935	AMERICA	MEXICO	TLAXCALA	92	19	35
2712	137	922001	AMERICA	NICARAGUA	MANAGUA	92	20	01
2713	137	922004	AMERICA	NICARAGUA	LEON	92	20	04
2714	137	922005	AMERICA	NICARAGUA	RIVAS	92	20	05
2715	137	922006	AMERICA	NICARAGUA	ESTELI	92	20	06
2716	137	922007	AMERICA	NICARAGUA	CHINANDEGA	92	20	07
2717	137	922008	AMERICA	NICARAGUA	JINOTEPE	92	20	08
2718	137	922010	AMERICA	NICARAGUA	MATAGALPA	92	20	10
2719	137	922011	AMERICA	NICARAGUA	MASAYA	92	20	11
2720	137	922012	AMERICA	NICARAGUA	GRANADA	92	20	12
2721	137	922014	AMERICA	NICARAGUA	CARAZO	92	20	14
2722	137	922101	AMERICA	PANAMA	PANAMA	92	21	01
2723	137	922102	AMERICA	PANAMA	DAVID	92	21	02
2724	137	922103	AMERICA	PANAMA	COLON	92	21	03
2725	137	922104	AMERICA	PANAMA	CHIRIQUI	92	21	04
2726	137	922105	AMERICA	PANAMA	HERRERA	92	21	05
2727	137	922106	AMERICA	PANAMA	SAN MIGUELITO	92	21	06
2728	137	922107	AMERICA	PANAMA	COCLE	92	21	07
2729	137	922108	AMERICA	PANAMA	VERAGUAS	92	21	08
2730	137	922109	AMERICA	PANAMA	LOS SANTOS	92	21	09
2731	137	922111	AMERICA	PANAMA	BOCAS DEL TORO	92	21	11
2732	137	922201	AMERICA	PARAGUAY	ASUNCION	92	22	01
2733	137	922202	AMERICA	PARAGUAY	BOQUERON	92	22	02
2734	137	922203	AMERICA	PARAGUAY	CAAZAPA	92	22	03
2735	137	922204	AMERICA	PARAGUAY	ITAPUA	92	22	04
2736	137	922205	AMERICA	PARAGUAY	CENTRAL	92	22	05
2737	137	922206	AMERICA	PARAGUAY	ÑEEMBUCU	92	22	06
2738	137	922207	AMERICA	PARAGUAY	PARAGUARI	92	22	07
2739	137	922208	AMERICA	PARAGUAY	AMAMBAY	92	22	08
2740	137	922209	AMERICA	PARAGUAY	LA CORDILLERA	92	22	09
2741	137	922210	AMERICA	PARAGUAY	ALTO PARANA	92	22	10
2742	137	922211	AMERICA	PARAGUAY	CAAGUAZU	92	22	11
2743	137	922212	AMERICA	PARAGUAY	MISIONES	92	22	12
2744	137	922213	AMERICA	PARAGUAY	CANINDEYU	92	22	13
2745	137	922214	AMERICA	PARAGUAY	GUAIRA	92	22	14
2746	137	922301	AMERICA	PUERTO RICO	CAGUAS	92	23	01
2747	137	922302	AMERICA	PUERTO RICO	PONCE	92	23	02
2748	137	922303	AMERICA	PUERTO RICO	SAN JUAN	92	23	03
2749	137	922304	AMERICA	PUERTO RICO	MOCA	92	23	04
2750	137	922305	AMERICA	PUERTO RICO	RIO GRANDE	92	23	05
2751	137	922306	AMERICA	PUERTO RICO	AIBONITO	92	23	06
2752	137	922307	AMERICA	PUERTO RICO	MAYAGÜEZ	92	23	07
2753	137	922308	AMERICA	PUERTO RICO	HORMIGUEROS	92	23	08
2754	137	922309	AMERICA	PUERTO RICO	ARECIBO	92	23	09
2755	137	922310	AMERICA	PUERTO RICO	HUMACAO	92	23	10
2756	137	922311	AMERICA	PUERTO RICO	BAYAMON	92	23	11
2861	137	930413	ASIA	INDIA	UTTARAKHAND	93	04	13
2757	137	922312	AMERICA	PUERTO RICO	MANATI	92	23	12
2758	137	922313	AMERICA	PUERTO RICO	AGUADILLA	92	23	13
2759	137	922314	AMERICA	PUERTO RICO	GUAYNABO	92	23	14
2760	137	922401	AMERICA	REPUBLICA DOMINICANA	SANTO DOMINGO	92	24	01
2761	137	922402	AMERICA	REPUBLICA DOMINICANA	SANTIAGO RODRIGUEZ	92	24	02
2762	137	922403	AMERICA	REPUBLICA DOMINICANA	SANTIAGO DE LOS CABALLEROS	92	24	03
2763	137	922404	AMERICA	REPUBLICA DOMINICANA	SAN PEDRO DE MACORIS	92	24	04
2764	137	922405	AMERICA	REPUBLICA DOMINICANA	PUERTO PLATA	92	24	05
2765	137	922406	AMERICA	REPUBLICA DOMINICANA	LA ALTAGRACIA	92	24	06
2766	137	922407	AMERICA	REPUBLICA DOMINICANA	AZUA	92	24	07
2767	137	922408	AMERICA	REPUBLICA DOMINICANA	SAN CRISTOBAL	92	24	08
2768	137	922409	AMERICA	REPUBLICA DOMINICANA	LA VEGA	92	24	09
2769	137	922412	AMERICA	REPUBLICA DOMINICANA	SAN JUAN	92	24	12
2770	137	922413	AMERICA	REPUBLICA DOMINICANA	SAN FRANCISCO DE MACORIS	92	24	13
2771	137	922414	AMERICA	REPUBLICA DOMINICANA	LA ROMANA	92	24	14
2772	137	922415	AMERICA	REPUBLICA DOMINICANA	SAMANA	92	24	15
2773	137	922416	AMERICA	REPUBLICA DOMINICANA	MARIA TRINIDAD SANCHEZ	92	24	16
2774	137	922417	AMERICA	REPUBLICA DOMINICANA	MONSEÑOR NOUEL	92	24	17
2775	137	922501	AMERICA	SURINAM	PARANARIBO	92	25	01
2776	137	922601	AMERICA	TRINIDAD TOBAGO	PUERTO ESPAÑA	92	26	01
2777	137	922602	AMERICA	TRINIDAD Y TOBAGO	SAN FERNANDO	92	26	02
2778	137	922701	AMERICA	URUGUAY	MONTEVIDEO	92	27	01
2779	137	922702	AMERICA	URUGUAY	SAN JOSE	92	27	02
2780	137	922703	AMERICA	URUGUAY	PAYSANDU	92	27	03
2781	137	922704	AMERICA	URUGUAY	COLONIA	92	27	04
2782	137	922705	AMERICA	URUGUAY	TREINTA Y TRES	92	27	05
2783	137	922706	AMERICA	URUGUAY	RIVERA	92	27	06
2784	137	922707	AMERICA	URUGUAY	SALTO	92	27	07
2785	137	922709	AMERICA	URUGUAY	ROCHA	92	27	09
2786	137	922710	AMERICA	URUGUAY	MALDONADO	92	27	10
2787	137	922711	AMERICA	URUGUAY	RIO NEGRO	92	27	11
2788	137	922712	AMERICA	URUGUAY	CANELONES	92	27	12
2789	137	922713	AMERICA	URUGUAY	FLORIDA	92	27	13
2790	137	922714	AMERICA	URUGUAY	CERRO LARGO	92	27	14
2791	137	922715	AMERICA	URUGUAY	ARTIGAS	92	27	15
2792	137	922716	AMERICA	URUGUAY	TACUAREMBO	92	27	16
2793	137	922718	AMERICA	URUGUAY	SORIANO	92	27	18
2794	137	922719	AMERICA	URUGUAY	LAVALLEJA	92	27	19
2795	137	922801	AMERICA	VENEZUELA	BARQUISIMETO	92	28	01
2796	137	922802	AMERICA	VENEZUELA	CARACAS	92	28	02
2797	137	922803	AMERICA	VENEZUELA	LA GUAIRA	92	28	03
2798	137	922804	AMERICA	VENEZUELA	MARACAIBO	92	28	04
2799	137	922805	AMERICA	VENEZUELA	PUERTO ORDAZ	92	28	05
2800	137	922806	AMERICA	VENEZUELA	BOLIVAR	92	28	06
2801	137	922807	AMERICA	VENEZUELA	CARABOBO	92	28	07
2802	137	922808	AMERICA	VENEZUELA	ARAGUA	92	28	08
2803	137	922809	AMERICA	VENEZUELA	ANZOATEGUI	92	28	09
2804	137	922810	AMERICA	VENEZUELA	MERIDA	92	28	10
2805	137	922811	AMERICA	VENEZUELA	PORTUGUESA	92	28	11
2806	137	922812	AMERICA	VENEZUELA	BARINAS	92	28	12
2807	137	922813	AMERICA	VENEZUELA	ZULIA	92	28	13
2808	137	922814	AMERICA	VENEZUELA	LARA	92	28	14
2809	137	922815	AMERICA	VENEZUELA	TACHIRA	92	28	15
2810	137	922816	AMERICA	VENEZUELA	MIRANDA	92	28	16
2811	137	922817	AMERICA	VENEZUELA	MONAGAS	92	28	17
2812	137	922818	AMERICA	VENEZUELA	SUCRE	92	28	18
2813	137	922819	AMERICA	VENEZUELA	NUEVA ESPARTA	92	28	19
2814	137	922820	AMERICA	VENEZUELA	FALCON	92	28	20
2815	137	922821	AMERICA	VENEZUELA	APURE	92	28	21
2816	137	922822	AMERICA	VENEZUELA	YARACUY	92	28	22
2817	137	922823	AMERICA	VENEZUELA	GUARICO	92	28	23
2818	137	922824	AMERICA	VENEZUELA	VARGAS	92	28	24
2819	137	922825	AMERICA	VENEZUELA	TRUJILLO	92	28	25
2820	137	922826	AMERICA	VENEZUELA	AMAZONAS	92	28	26
2821	137	922827	AMERICA	VENEZUELA	COJEDES	92	28	27
2822	137	922828	AMERICA	VENEZUELA	DELTA AMACURO	92	28	28
2823	137	922901	AMERICA	BARBADOS	BRIDGETOWN	92	29	01
2824	137	923001	AMERICA	GUAYANA FRANCESA	CAYENA	92	30	01
2825	137	923002	AMERICA	GUAYANA FRANCESA	KURU	92	30	02
2826	137	923003	AMERICA	GUAYANA FRANCESA	ST. LAURENT	92	30	03
2827	137	923201	AMERICA	BELICE	BELICE	92	32	01
2828	137	923501	AMERICA	SANTA LUCIA	CASTRIES	92	35	01
2829	137	923601	AMERICA	ISLAS CAIMAN	GEORGE TOWN	92	36	01
2830	137	923801	AMERICA	ISLAS BERMUDAS	HAMILTON	92	38	01
2831	137	930101	ASIA	COREA DEL SUR, REPUBLICA DE	SEUL	93	01	01
2832	137	930104	ASIA	COREA DEL SUR, REPUBLICA DE	KYONGGI-DO	93	01	04
2833	137	930201	ASIA	CHINA, REPUBLICA POPULAR	BEIJING (PEKIN)	93	02	01
2834	137	930202	ASIA	CHINA, REPUBLICA POPULAR	CANTON	93	02	02
2835	137	930203	ASIA	CHINA, REPUBLICA POPULAR	GUANCHONG	93	02	03
2836	137	930204	ASIA	CHINA, REPUBLICA POPULAR	GUANGDONG	93	02	04
2837	137	930206	ASIA	CHINA, REPUBLICA POPULAR	SHANGHAI	93	02	06
2838	137	930207	ASIA	CHINA, REPUBLICA POPULAR	JIANGSU	93	02	07
2839	137	930208	ASIA	CHINA, REPUBLICA POPULAR	LIAONING	93	02	08
2840	137	930209	ASIA	CHINA, REPUBLICA POPULAR	FUJIAN	93	02	09
2841	137	930212	ASIA	CHINA, REPUBLICA POPULAR	SICHUAN	93	02	12
2842	137	930215	ASIA	CHINA, REPUBLICA POPULAR	HUNAN	93	02	15
2843	137	930218	ASIA	CHINA, REPUBLICA POPULAR	HENAN	93	02	18
2844	137	930219	ASIA	CHINA, REPUBLICA POPULAR	GUANGXI ZHUANG	93	02	19
2845	137	930220	ASIA	CHINA, REPUBLICA POPULAR	ZHEJIANG	93	02	20
2846	137	930221	ASIA	CHINA, REPUBLICA POPULAR	SHANDONG	93	02	21
2847	137	930222	ASIA	CHINA, REPUBLICA POPULAR	TIANJIN (TIENTSIN)	93	02	22
2848	137	930223	ASIA	CHINA, REPUBLICA POPULAR	SHAANXI	93	02	23
2849	137	930226	ASIA	CHINA, REPUBLICA POPULAR	HONG KONG	93	02	26
2850	137	930227	ASIA	CHINA, REPUBLICA POPULAR	MACAO	93	02	27
2851	137	930231	ASIA	CHINA, REPUBLICA POPULAR	YUNNAN	93	02	31
2852	137	930232	ASIA	CHINA, REPUBLICA POPULAR	GUANGZHOU	93	02	32
2853	137	930401	ASIA	INDIA	BOMBAY	93	04	01
2854	137	930402	ASIA	INDIA	NUEVA DELHI	93	04	02
2855	137	930404	ASIA	INDIA	CALCUTA	93	04	04
2856	137	930406	ASIA	INDIA	PUNJAB	93	04	06
2857	137	930409	ASIA	INDIA	ANDHRA PRADESH	93	04	09
2858	137	930410	ASIA	INDIA	KARNATAKA	93	04	10
2859	137	930411	ASIA	INDIA	HARYANA	93	04	11
2860	137	930412	ASIA	INDIA	UTTAR PRADESH	93	04	12
2862	137	930417	ASIA	INDIA	TAMIL NADU	93	04	17
2863	137	930501	ASIA	IRAK	BAGDAD	93	05	01
2864	137	930601	ASIA	ISRAEL	HAIFA	93	06	01
2865	137	930602	ASIA	ISRAEL	TEL AVIV	93	06	02
2866	137	930603	ASIA	ISRAEL	JERUSALEN	93	06	03
2867	137	930604	ASIA	ISRAEL	PATAH - TIQVRA	93	06	04
2868	137	930605	ASIA	ISRAEL	MERIDIANO	93	06	05
2869	137	930606	ASIA	ISRAEL	SIGET	93	06	06
2870	137	930607	ASIA	ISRAEL	CENTRAL	93	06	07
2871	137	930611	ASIA	ISRAEL	EILAT	93	06	11
2872	137	930701	ASIA	JAPON	KAGOSHIMA	93	07	01
2873	137	930702	ASIA	JAPON	KYOTO	93	07	02
2874	137	930703	ASIA	JAPON	TOKIO	93	07	03
2875	137	930704	ASIA	JAPON	OKINAWA	93	07	04
2876	137	930705	ASIA	JAPON	FUKUOKA	93	07	05
2877	137	930706	ASIA	JAPON	OSAKA	93	07	06
2878	137	930708	ASIA	JAPON	YOKOHAMA	93	07	08
2879	137	930709	ASIA	JAPON	HIROSHIMA	93	07	09
2880	137	930710	ASIA	JAPON	KUMAMOTO	93	07	10
2881	137	930711	ASIA	JAPON	HOKKAIDO	93	07	11
2882	137	930712	ASIA	JAPON	TOKUSHIMA	93	07	12
2883	137	930713	ASIA	JAPON	NAGOYA	93	07	13
2884	137	930714	ASIA	JAPON	NAGASAKI	93	07	14
2885	137	930715	ASIA	JAPON	TOCHIGI	93	07	15
2886	137	930716	ASIA	JAPON	EHIME	93	07	16
2887	137	930717	ASIA	JAPON	YAMAGUCHI	93	07	17
2888	137	930718	ASIA	JAPON	ISHIKAWA	93	07	18
2889	137	930719	ASIA	JAPON	KANAGAWA	93	07	19
2890	137	930720	ASIA	JAPON	SAITAMA	93	07	20
2891	137	930721	ASIA	JAPON	GUNMA	93	07	21
2892	137	930722	ASIA	JAPON	YAMANASHI	93	07	22
2893	137	930723	ASIA	JAPON	AICHI	93	07	23
2894	137	930724	ASIA	JAPON	IBARAKI	93	07	24
2895	137	930725	ASIA	JAPON	GIFU	93	07	25
2896	137	930726	ASIA	JAPON	SHIZUOKA	93	07	26
2897	137	930727	ASIA	JAPON	MIE	93	07	27
2898	137	930728	ASIA	JAPON	CHIBA	93	07	28
2899	137	930729	ASIA	JAPON	NAGANO	93	07	29
2900	137	930730	ASIA	JAPON	NARA	93	07	30
2901	137	930731	ASIA	JAPON	HYOGO	93	07	31
2902	137	930732	ASIA	JAPON	FUKUSHIMA	93	07	32
2903	137	930733	ASIA	JAPON	NIIGATA	93	07	33
2904	137	930734	ASIA	JAPON	YAMAGATA	93	07	34
2905	137	930735	ASIA	JAPON	KAGAWA	93	07	35
2906	137	930736	ASIA	JAPON	SHIGA	93	07	36
2907	137	930737	ASIA	JAPON	FUKUI	93	07	37
2908	137	930738	ASIA	JAPON	AKITA	93	07	38
2909	137	930739	ASIA	JAPON	OKAYAMA	93	07	39
2910	137	930740	ASIA	JAPON	OITA	93	07	40
2911	137	930741	ASIA	JAPON	MIYAGI	93	07	41
2912	137	930743	ASIA	JAPON	TOTTORI	93	07	43
2913	137	930744	ASIA	JAPON	WAKAYAMA	93	07	44
2914	137	930745	ASIA	JAPON	TOYAMA	93	07	45
2915	137	930746	ASIA	JAPON	AOMORI	93	07	46
2916	137	930747	ASIA	JAPON	IWATE	93	07	47
2917	137	930748	ASIA	JAPON	KOCHI	93	07	48
2918	137	930750	ASIA	JAPON	SHIMANE	93	07	50
2919	137	930751	ASIA	JAPON	MIYAZAKI	93	07	51
2920	137	930752	ASIA	JAPON	KOBE	93	07	52
2921	137	930801	ASIA	LIBANO	BEIRUT	93	08	01
2922	137	930802	ASIA	LIBANO	EL BATROUN	93	08	02
2923	137	930804	ASIA	LIBANO	BALBAK	93	08	04
2924	137	930805	ASIA	LIBANO	SAIDA	93	08	05
2925	137	930807	ASIA	LIBANO	DARBECHTAR	93	08	07
2926	137	930901	ASIA	SRI LANKA	COLOMBO	93	09	01
2927	137	931001	ASIA	TAILANDIA	BANGKOK	93	10	01
2928	137	931002	ASIA	TAILANDIA	SURAT THANI	93	10	02
2929	137	931003	ASIA	TAILANDIA	NAKHON RATSACHIMA	93	10	03
2930	137	931004	ASIA	TAILANDIA	CHON BURI	93	10	04
2931	137	931006	ASIA	TAILANDIA	SISAKET	93	10	06
2932	137	931007	ASIA	TAILANDIA	CHIANG MAI	93	10	07
2933	137	931101	ASIA	INDONESIA	JAKARTA	93	11	01
2934	137	931102	ASIA	INDONESIA	BALI	93	11	02
2935	137	931103	ASIA	INDONESIA	BANDUNG	93	11	03
2936	137	931105	ASIA	INDONESIA	NUSA TENGGARA ORIENTAL	93	11	05
2937	137	931201	ASIA	SIRIA	DAMASCO	93	12	01
2938	137	931302	ASIA	JORDANIA	AMMAN	93	13	02
2939	137	931303	ASIA	JORDANIA	RAMALLAH	93	13	03
2940	137	931401	ASIA	PALESTINA	BETHLEHEM	93	14	01
2941	137	931402	ASIA	PALESTINA	BELEN	93	14	02
2942	137	931404	ASIA	PALESTINA	BEIT-JALA	93	14	04
2943	137	931408	ASIA	PALESTINA	HEBRON	93	14	08
2944	137	931501	ASIA	TURQUIA	ESTAMBUL	93	15	01
2945	137	931503	ASIA	TURQUIA	ANKARA	93	15	03
2946	137	931701	ASIA	MONGOLIA	ULAM BATOR	93	17	01
2947	137	931802	ASIA	PAKISTAN	SINDH	93	18	02
2948	137	931901	ASIA	ARABIA SAUDITA	JIDDAH	93	19	01
2949	137	931902	ASIA	ARABIA SAUDITA	ASH-SHARQIYAH	93	19	02
2950	137	931903	ASIA	ARABIA SAUDITA	DAMMAM	93	19	03
2951	137	931904	ASIA	ARABIA SAUDITA	RIAD	93	19	04
2952	137	932001	ASIA	VIETNAN	SAIGON	93	20	01
2953	137	932002	ASIA	VIETNAN	HANOI	93	20	02
2954	137	932101	ASIA	KAZAJSTAN	ALMATY	93	21	01
2955	137	932301	ASIA	TAIWAN	TAIPEI	93	23	01
2956	137	932302	ASIA	TAIWAN	MIAO-LI	93	23	02
2957	137	932303	ASIA	TAIWAN	CHIA-I	93	23	03
2958	137	932305	ASIA	TAIWAN	T'AICHUNG	93	23	05
2959	137	932306	ASIA	TAIWAN	KAOHSIUNG	93	23	06
2960	137	932307	ASIA	TAIWAN	PING TUNG	93	23	07
2961	137	932308	ASIA	TAIWAN	NEW TAIPEI CITY	93	23	08
2962	137	932401	ASIA	IRAN	TEHERAN	93	24	01
2963	137	932501	ASIA	SINGAPUR	SINGAPUR	93	25	01
2964	137	932801	ASIA	KUWAIT	AL - KUWAIT	93	28	01
2965	137	933001	ASIA	MALASIA	KUALA LUMPUR	93	30	01
2966	137	933002	ASIA	MALASIA	JOHOR	93	30	02
2967	137	933007	ASIA	MALASIA	SELANGOR	93	30	07
2968	137	933201	ASIA	FILIPINAS	MANILA	93	32	01
2969	137	933202	ASIA	FILIPINAS	CEBU	93	32	02
2970	137	933205	ASIA	FILIPINAS	PAMPANGA	93	32	05
2971	137	933402	ASIA	BANGLADESH	DHAKA	93	34	02
2972	137	933501	ASIA	AZERBAIYAN	BAKU	93	35	01
2973	137	933701	ASIA	EMIRATOS ARABES UNIDOS	DUBAI	93	37	01
2974	137	933702	ASIA	EMIRATOS ARABES UNIDOS	ABU DHABI	93	37	02
2975	137	933703	ASIA	EMIRATOS ARABES UNIDOS	AJMAN	93	37	03
2976	137	933801	ASIA	QATAR	DOHA	93	38	01
2977	137	933901	ASIA	OMAN	MASCATE	93	39	01
2978	137	934101	ASIA	BAREIN	HAMAD	93	41	01
2979	137	940201	EUROPA	ALEMANIA	BERLIN	94	02	01
2980	137	940202	EUROPA	ALEMANIA	BONN	94	02	02
2981	137	940203	EUROPA	ALEMANIA	BREMEN	94	02	03
2982	137	940204	EUROPA	ALEMANIA	ESSEN	94	02	04
2983	137	940205	EUROPA	ALEMANIA	FRANKFURT	94	02	05
2984	137	940206	EUROPA	ALEMANIA	HAMBURGO	94	02	06
2985	137	940207	EUROPA	ALEMANIA	HANNOVER	94	02	07
2986	137	940208	EUROPA	ALEMANIA	BAVIERA	94	02	08
2987	137	940209	EUROPA	ALEMANIA	STUTTGART	94	02	09
2988	137	940210	EUROPA	ALEMANIA	DUSSELDORF	94	02	10
2989	137	940211	EUROPA	ALEMANIA	HEIDELBERG	94	02	11
2990	137	940212	EUROPA	ALEMANIA	RAVENSBURGO	94	02	12
2991	137	940213	EUROPA	ALEMANIA	COLONIA	94	02	13
2992	137	940214	EUROPA	ALEMANIA	MANNHEIM	94	02	14
2993	137	940215	EUROPA	ALEMANIA	SAJONIA	94	02	15
2994	137	940217	EUROPA	ALEMANIA	BADEN-WÜRTTEMBERG	94	02	17
2995	137	940218	EUROPA	ALEMANIA	OLDEMBURGO	94	02	18
2996	137	940219	EUROPA	ALEMANIA	MÖNCHENGLADBACH	94	02	19
2997	137	920508	AMERICA	BRASIL	RIO BRANCO	92	05	08
2998	137	920509	AMERICA	BRASIL	RIO DE JANEIRO	92	05	09
2999	137	920510	AMERICA	BRASIL	SAO PAULO	92	05	10
3000	137	920511	AMERICA	BRASIL	SALVADOR	92	05	11
3001	137	942801	EUROPA	SUIZA	BASILEA CIUDAD	94	28	01
3002	137	942802	EUROPA	SUIZA	BERNA	94	28	02
3003	137	942803	EUROPA	SUIZA	GINEBRA	94	28	03
3004	137	942804	EUROPA	SUIZA	LAUSSANE	94	28	04
3005	137	942805	EUROPA	SUIZA	LUCERNA	94	28	05
3006	137	942806	EUROPA	SUIZA	LUGANO	94	28	06
3007	137	942807	EUROPA	SUIZA	NEUCHATEL	94	28	07
3008	137	942808	EUROPA	SUIZA	SCHAFFNAUSEN	94	28	08
3009	137	942809	EUROPA	SUIZA	ZURICH	94	28	09
3010	137	942810	EUROPA	SUIZA	FRIBURGO	94	28	10
3011	137	942811	EUROPA	SUIZA	TESINO	94	28	11
3012	137	942812	EUROPA	SUIZA	ARGOVIA	94	28	12
3013	137	942813	EUROPA	SUIZA	VAUD	94	28	13
3014	137	942815	EUROPA	SUIZA	ZUG	94	28	15
3015	137	942816	EUROPA	SUIZA	SAN GALL	94	28	16
3016	137	942817	EUROPA	SUIZA	GLARUS	94	28	17
3017	137	942818	EUROPA	SUIZA	SCHWYZ	94	28	18
3018	137	942819	EUROPA	SUIZA	LOCARNO	94	28	19
3019	137	942820	EUROPA	SUIZA	TURGOVIA	94	28	20
3020	137	942821	EUROPA	SUIZA	THURGAU	94	28	21
3021	137	942822	EUROPA	SUIZA	STANS	94	28	22
3022	137	942823	EUROPA	SUIZA	JURA	94	28	23
3023	137	942824	EUROPA	SUIZA	BASILEA CAMPIÑA	94	28	24
3024	137	942825	EUROPA	SUIZA	SOLOTHURN	94	28	25
3025	137	942826	EUROPA	SUIZA	VALAIS	94	28	26
3026	137	942827	EUROPA	SUIZA	AARGAU	94	28	27
3027	137	942828	EUROPA	SUIZA	GRAUBÜNDEN	94	28	28
3028	137	942829	EUROPA	SUIZA	URI	94	28	29
3029	137	942830	EUROPA	SUIZA	APPENZELL RODAS EXTERIORES	94	28	30
3030	137	942901	EUROPA	RUSIA	MOSCU	94	29	01
3031	137	942904	EUROPA	RUSIA	ASTRAKHAN	94	29	04
3032	137	942905	EUROPA	RUSIA	MURMANSK	94	29	05
3033	137	942907	EUROPA	RUSIA	ROSTOV	94	29	07
3034	137	942909	EUROPA	RUSIA	OMSK	94	29	09
3035	137	942910	EUROPA	RUSIA	SAN PETERSBURGO	94	29	10
3036	137	942912	EUROPA	RUSIA	KRASNODAR	94	29	12
3037	137	942918	EUROPA	RUSIA	TVER	94	29	18
3038	137	942921	EUROPA	RUSIA	STAVROPOL	94	29	21
3039	137	942924	EUROPA	RUSIA	PERM	94	29	24
3040	137	942925	EUROPA	RUSIA	VORONEZH	94	29	25
3041	137	942926	EUROPA	RUSIA	VLADIMIR	94	29	26
3042	137	942927	EUROPA	RUSIA	VOLGOGRADO	94	29	27
3043	137	942931	EUROPA	RUSIA	NIZHNIY NOVGOROD	94	29	31
3044	137	942932	EUROPA	RUSIA	BELGOROD	94	29	32
3045	137	942934	EUROPA	RUSIA	NOVGOROD	94	29	34
3046	137	942936	EUROPA	RUSIA	ARJANGUELSK	94	29	36
3047	137	942942	EUROPA	RUSIA	YAROSLAVL	94	29	42
3048	137	942949	EUROPA	RUSIA	SAMARA	94	29	49
3049	137	943001	EUROPA	YUGOSLAVIA	BELGRADO	94	30	01
3050	137	943002	EUROPA	YUGOSLAVIA	MONTENEGRO	94	30	02
3051	137	943008	EUROPA	YUGOSLAVIA	SERBIA	94	30	08
3052	137	943101	EUROPA	CROACIA	ZADAR	94	31	01
3053	137	943104	EUROPA	CROACIA	RIJEKA	94	31	04
3054	137	943105	EUROPA	CROACIA	PULA	94	31	05
3055	137	943108	EUROPA	CROACIA	ZAGREB	94	31	08
3056	137	943110	EUROPA	CROACIA	DUBROVNIK	94	31	10
3057	137	943202	EUROPA	MOLDAVIA	KISHINEV	94	32	02
3058	137	943301	EUROPA	ESLOVENIA	LIUBLIANA	94	33	01
3059	137	943303	EUROPA	ESLOVENIA	POSTOJNA	94	33	03
3060	137	943307	EUROPA	ESLOVENIA	MARIBOR	94	33	07
3061	137	943308	EUROPA	ESLOVENIA	HRASTNIK	94	33	08
3062	137	943309	EUROPA	ESLOVENIA	KOBARID	94	33	09
3063	137	943312	EUROPA	ESLOVENIA	CELJE	94	33	12
3064	137	943313	EUROPA	ESLOVENIA	GORISKA	94	33	13
3065	137	943402	EUROPA	UCRANIA	ODESSA	94	34	02
3066	137	943403	EUROPA	UCRANIA	KIEV	94	34	03
3067	137	943404	EUROPA	UCRANIA	KHARKOV	94	34	04
3068	137	943405	EUROPA	UCRANIA	DNIPROPETROVSK	94	34	05
3069	137	943408	EUROPA	UCRANIA	DONETSK	94	34	08
3070	137	943412	EUROPA	UCRANIA	POLTAVA	94	34	12
3071	137	943414	EUROPA	UCRANIA	VINNITSA	94	34	14
3072	137	943415	EUROPA	UCRANIA	LUHANSK	94	34	15
3073	137	943416	EUROPA	UCRANIA	ZAPOROZHIE	94	34	16
3074	137	943601	EUROPA	BIELORRUSIA	MINSK	94	36	01
3075	137	943602	EUROPA	BIELORRUSIA	MOGILEV	94	36	02
3076	137	943603	EUROPA	BIELORRUSIA	VITEBSK	94	36	03
3077	137	943701	EUROPA	MACEDONIA	SKOPJE	94	37	01
3078	137	943703	EUROPA	MACEDONIA	OHRID	94	37	03
3079	137	943801	EUROPA	ESLOVAQUIA	BRATISLAVA	94	38	01
3080	137	943802	EUROPA	ESLOVAQUIA	NITRA	94	38	02
3081	137	943834	EUROPA	ESLOVAQUIA	KOSICE	94	38	34
3082	137	943835	EUROPA	ESLOVAQUIA	BANSKA BYSTRICKA	94	38	35
3083	137	943838	EUROPA	ESLOVAQUIA	PRESOV	94	38	38
3084	137	943839	EUROPA	ESLOVAQUIA	TRNAVA	94	38	39
3085	137	943840	EUROPA	ESLOVAQUIA	TRENCIN	94	38	40
3086	137	943901	EUROPA	LETONIA	RIGA	94	39	01
3087	137	943904	EUROPA	LETONIA	LIEPAJA	94	39	04
3088	137	944001	EUROPA	LITUANIA	VILNA	94	40	01
3089	137	944003	EUROPA	LITUANIA	KAUNAS	94	40	03
3090	137	944101	EUROPA	IRLANDA DEL NORTE	BELFAST	94	41	01
3091	137	944201	EUROPA	ANDORRA, PRINCIPADO DE	LES ESCALDES	94	42	01
3092	137	944202	EUROPA	ANDORRA, PRINCIPADO DE	ANDORRA LA VELLA	94	42	02
3093	137	944203	EUROPA	ANDORRA, PRINCIPADO DE	CANILLO	94	42	03
3094	137	944204	EUROPA	ANDORRA, PRINCIPADO DE	LA MASSANA	94	42	04
3095	137	944205	EUROPA	ANDORRA, PRINCIPADO DE	SAN JULIAN DE LORIA	94	42	05
3096	137	944206	EUROPA	ANDORRA, PRINCIPADO DE	ENCAMP	94	42	06
3097	137	944301	EUROPA	ALBANIA	TIRANA	94	43	01
3098	137	944401	EUROPA	ESTONIA	TALLINN	94	44	01
3099	137	944402	EUROPA	ESTONIA	TARTU	94	44	02
3100	137	944801	EUROPA	SERBIA	BELGRADO	94	48	01
3101	137	944802	EUROPA	SERBIA	SUMADIJA	94	48	02
3102	137	945001	EUROPA	REINO UNIDO DE GRAN BRETAÑA E	ESCOCIA	94	50	01
3103	137	945002	EUROPA	REINO UNIDO DE GRAN BRETAÑA E	GALES	94	50	02
3104	137	945003	EUROPA	REINO UNIDO DE GRAN BRETAÑA E	INGLATERRA	94	50	03
3105	137	945004	EUROPA	REINO UNIDO DE GRAN BRETAÑA E	IRLANDA DEL NORTE	94	50	04
3106	137	950101	OCEANIA	AUSTRALIA	ADELAIDA	95	01	01
3107	137	950102	OCEANIA	AUSTRALIA	BRISBANE	95	01	02
3108	137	950103	OCEANIA	AUSTRALIA	CAMBERRA	95	01	03
3109	137	950104	OCEANIA	AUSTRALIA	MELBOURNE	95	01	04
3110	137	950105	OCEANIA	AUSTRALIA	SIDNEY	95	01	05
3111	137	950106	OCEANIA	AUSTRALIA	PERTH	95	01	06
3112	137	950107	OCEANIA	AUSTRALIA	VICTORIA	95	01	07
3113	137	950108	OCEANIA	AUSTRALIA	QUEENSLAND	95	01	08
3114	137	950109	OCEANIA	AUSTRALIA	TASMANIA	95	01	09
3115	137	950110	OCEANIA	AUSTRALIA	NUEVA GALES DEL SUR	95	01	10
3116	137	950111	OCEANIA	AUSTRALIA	TERRITORIO DEL NORTE	95	01	11
3117	137	950201	OCEANIA	NUEVA ZELANDA	AUCKLAND	95	02	01
3118	137	950202	OCEANIA	NUEVA ZELANDA	WELLINGTON	95	02	02
3119	137	950203	OCEANIA	NUEVA ZELANDA	OTAGO	95	02	03
3120	137	950206	OCEANIA	NUEVA ZELANDA	CHRISTCHURCH	95	02	06
3121	137	950207	OCEANIA	NUEVA ZELANDA	BAHIA DE PLENTY	95	02	07
3122	137	950209	OCEANIA	NUEVA ZELANDA	HAMILTON	95	02	09
3123	137	950210	OCEANIA	NUEVA ZELANDA	MANAWATU-WANGANUI	95	02	10
3124	137	950211	OCEANIA	NUEVA ZELANDA	CANTERBURY	95	02	11
3125	137	950401	OCEANIA	SAMOA AMERICANA	PAGO PAGO	95	04	01
1723	18	910101	AFRICA	ARGELIA	ARGEL	91	01	01
1724	18	910102	AFRICA	ARGELIA	ORAN	91	01	02
1725	18	910108	AFRICA	ARGELIA	BUGIA	91	01	08
1768	19	920203	AMERICA	ARGENTINA	CORDOBA	92	02	03
1769	19	920204	AMERICA	ARGENTINA	CORRIENTES	92	02	04
1770	19	920205	AMERICA	ARGENTINA	LA PLATA	92	02	05
1771	19	920206	AMERICA	ARGENTINA	MENDOZA	92	02	06
1772	19	920207	AMERICA	ARGENTINA	ROSARIO DE SANTA FE	92	02	07
1773	19	920208	AMERICA	ARGENTINA	SALTA	92	02	08
1774	19	920209	AMERICA	ARGENTINA	TUCUMAN	92	02	09
1775	19	920210	AMERICA	ARGENTINA	SAN JUAN	92	02	10
1776	19	920211	AMERICA	ARGENTINA	CHACO	92	02	11
1777	19	920212	AMERICA	ARGENTINA	RIO NEGRO	92	02	12
1778	19	920213	AMERICA	ARGENTINA	CHUBUT	92	02	13
1779	19	920214	AMERICA	ARGENTINA	SANTA FE	92	02	14
1780	19	920215	AMERICA	ARGENTINA	ENTRE RIOS	92	02	15
1781	19	920216	AMERICA	ARGENTINA	JUJUY	92	02	16
1782	19	920217	AMERICA	ARGENTINA	MISIONES	92	02	17
1783	19	920218	AMERICA	ARGENTINA	NEUQUEN	92	02	18
1784	19	920219	AMERICA	ARGENTINA	SAN LUIS	92	02	19
1785	19	920220	AMERICA	ARGENTINA	LA PAMPA	92	02	20
1786	19	920221	AMERICA	ARGENTINA	SANTA CRUZ	92	02	21
1787	19	920222	AMERICA	ARGENTINA	SANTIAGO DEL ESTERO	92	02	22
1788	19	920223	AMERICA	ARGENTINA	FORMOSA	92	02	23
1789	19	920224	AMERICA	ARGENTINA	CATAMARCA	92	02	24
1790	19	920225	AMERICA	ARGENTINA	TIERRA DEL FUEGO	92	02	25
1791	19	920226	AMERICA	ARGENTINA	LA RIOJA	92	02	26
1792	19	920227	AMERICA	ARGENTINA	MAR DEL PLATA	92	02	27
\.


--
-- Data for Name: audgeneral; Type: TABLE DATA; Schema: seguridad; Owner: postgres
--

COPY seguridad.audgeneral (coauditoria, coempresa, noesquema, notabla, noaccion, cousuario, jbpk, jbdataold, jbdatanew, feauditoria) FROM stdin;
1	-100	seguridad	segmodulo	D	22	{"comodulo": 16}	{"fecre": "2026-06-12", "femod": "2026-06-12T21:32:04.901406", "flarea": true, "noarea": "modulo23", "noicono": "33", "nuorden": 1, "comodulo": 16, "cousucre": 22, "cousumod": 22, "flestreg": false, "nomodulo": "Nuevo modulo2", "nomodulodescripcion": "322"}	\N	2026-06-12 21:32:08.35898-05
2	1	maestro	tblredsocial	D	22	{"coredsocial": 1}	{"fecre": "2025-02-14T15:21:22.393", "femod": "2026-04-29T22:23:51.412565", "cousucre": -100, "cousumod": 22, "coempresa": 1, "copersona": null, "cotipourl": null, "flpersona": false, "coetiqueta": 1, "flwhatsapp": true, "coredsocial": 1, "noredsocial": "dqwqweqweqwe", "cotiporedsocial": 1}	\N	2026-06-12 21:33:22.887312-05
3	-100	seguridad	tblempresa	D	22	{"coempresa": 21}	{"fecre": "2026-06-12T22:09:02.050875", "femod": null, "noseo": null, "copais": null, "comoneda": null, "cousucre": 22, "cousumod": null, "flestreg": true, "nomision": null, "novision": null, "coempresa": 21, "noempresa": "333", "txquiensoy": null, "noempresacorto": null, "nudocumentofiscal": null, "codocumentoidentidad": null}	\N	2026-06-12 22:09:15.309939-05
4	1	maestro	tblredsocial	D	22	{"coredsocial": 384}	{"fecre": "2026-06-15T22:22:34.63462", "femod": "2026-06-15T22:22:54.937419", "cousucre": 22, "cousumod": 22, "coempresa": 1, "copersona": null, "cotipourl": null, "flpersona": false, "coetiqueta": 2, "flwhatsapp": false, "coredsocial": 384, "noredsocial": "434343", "cotiporedsocial": 1}	\N	2026-06-15 22:22:59.3679-05
5	-100	seguridad	tblempresa	D	22	{"coempresa": 22}	{"fecre": "2026-06-15T22:27:24.695736", "femod": "2026-06-15T22:27:54.90695", "noseo": "2e2", "copais": 56, "comoneda": 112, "cousucre": 22, "cousumod": 22, "flestreg": false, "nomision": "3ddf", "novision": "dd", "coempresa": 22, "noempresa": "prueba", "txquiensoy": "2e23", "noempresacorto": "33", "nudocumentofiscal": "434", "codocumentoidentidad": 6}	\N	2026-06-15 22:27:58.341641-05
6	1	maestro	tblredsocial	D	22	{"coredsocial": 383}	{"fecre": "2026-06-15T15:44:27.620159", "femod": "2026-06-18T22:26:41.570229", "cousucre": 22, "cousumod": 22, "coempresa": 1, "copersona": null, "cotipourl": null, "flpersona": false, "coetiqueta": 2, "flwhatsapp": false, "coredsocial": 383, "noredsocial": "87887", "cotiporedsocial": 1}	\N	2026-06-18 22:40:32.789975-05
7	1	maestro	tblredsocial	D	22	{"coredsocial": 387}	{"fecre": "2026-06-22T14:46:58.055787", "femod": "2026-06-22T14:47:03.262043", "cousucre": 22, "cousumod": 22, "coempresa": 1, "copersona": null, "cotipourl": null, "flpersona": false, "coetiqueta": 2, "flwhatsapp": false, "coredsocial": 387, "noredsocial": "3", "cotiporedsocial": 2}	\N	2026-06-22 14:47:06.655822-05
\.


--
-- Data for Name: segempresamodulo; Type: TABLE DATA; Schema: seguridad; Owner: postgres
--

COPY seguridad.segempresamodulo (coempresamodulo, coempresa, comodulo) FROM stdin;
2	1	1
3	1	2
6	4	-2
7	9	1
8	9	-2
12	1	5
15	2	-2
16	2	1
17	4	8
18	4	2
1	1	-2
5	4	1
9	6	-2
10	6	1
11	1	8
13	1	3
14	2	2
19	4	5
\.


--
-- Data for Name: segmenu; Type: TABLE DATA; Schema: seguridad; Owner: postgres
--

COPY seguridad.segmenu (comenu, comodulo, nuorden, nomenu, cousucre, cousumod, fecre, femod, flestreg) FROM stdin;
-2	-1	2	Mantenimiento	-1	\N	2020-04-20 12:09:44.17	\N	t
-11	-2	1	Mantenimiento	-1	\N	2020-04-20 12:09:44.17	\N	t
-1	-1	1	Configuración	-1	\N	2018-05-22 13:45:22.617	\N	t
7	5	1	Menu 1	22	22	2026-06-15 17:57:37.509423	2026-06-15 19:28:42.946352	t
\.


--
-- Data for Name: segperfil; Type: TABLE DATA; Schema: seguridad; Owner: postgres
--

COPY seguridad.segperfil (coperfil, comodulo, noperfil, cousucre, cousumod, fecre, femod, flestreg, fldefault, fladmin) FROM stdin;
-1	-1	Admistrador de Mozo	-1	\N	2018-05-18 15:47:56.32	\N	t	f	f
-11	-2	Admistrador de Mozo	-1	\N	2018-05-18 15:47:56.32	\N	t	f	f
2	5	ee2332	22	22	2026-06-15 16:55:20.769665	2026-06-15 21:56:36.299346	t	f	f
1	5	222	22	22	2026-06-15 14:31:06.812751	2026-06-18 23:02:25.239121	t	f	f
\.


--
-- Data for Name: segmodulousuario; Type: TABLE DATA; Schema: seguridad; Owner: postgres
--

COPY seguridad.segmodulousuario (comodulousuario, cousuario, comodulo, coperfil, feexpiracion, fecre, femod, valor, coempresa) FROM stdin;
2	1	-1	-1	2030-12-31	2020-05-04 20:37:37.62	\N	\N	1
3	1	-2	-11	2030-12-31	2020-05-04 20:37:37.62	\N	\N	1
1	-1	-1	-1	2030-12-31	2020-05-04 20:37:37.62	\N	\N	1
\.


--
-- Data for Name: segpagina; Type: TABLE DATA; Schema: seguridad; Owner: postgres
--

COPY seguridad.segpagina (copagina, comodulo, nuorden, comenu, coarea, noopcion, cotipopagina, nocontrolador, noaccion, cousucre, cousumod, fecre, femod, flestreg) FROM stdin;
-12	-2	2	-11	-2	Usuarios	150	persona	list	-1	\N	2020-10-28 15:07:10.39	2021-07-22 13:31:32.86	t
-11	-2	1	-11	-2	Tipos	150	tipo-particular	list	-1	\N	2020-10-28 15:07:10.39	2021-07-22 13:31:32.86	t
-4	-1	1	-2	-1	Empresas	150	empresa	list	-1	\N	2020-10-28 15:07:10.39	2021-07-22 13:31:32.86	t
-3	-1	3	-1	-1	Perfiles	150	perfil	list	-1	\N	2020-10-28 15:07:10.39	2021-07-22 13:31:32.86	t
-2	-1	2	-1	-1	Menus	150	menu	list	-1	\N	2020-10-28 15:07:10.39	2021-07-22 13:31:32.86	t
-1	-1	1	-1	-1	Módulos	150	modulo	list	-1	\N	2020-10-28 15:07:10.39	2021-07-22 13:31:32.86	t
1	5	1	7	5	Opcion 1	150	2e	33	22	22	2026-06-15 19:07:43.706014	2026-06-20 00:00:27.566936	t
2	5	2	7	5	Opcion 2	150	33d	3d33	22	22	2026-06-15 19:08:18.590117	2026-06-15 21:56:26.354155	t
\.


--
-- Data for Name: segperfilpagina; Type: TABLE DATA; Schema: seguridad; Owner: postgres
--

COPY seguridad.segperfilpagina (coperfil, comodulo, copagina, comenu, cousucre, cousumod, fecre, femod, coperfilpagina) FROM stdin;
-11	-2	-11	-11	22	\N	2021-07-22 14:05:42.303	\N	-11
-11	-2	-12	-11	22	\N	2021-07-22 14:05:42.303	\N	-12
-1	-1	-4	-2	22	\N	2021-07-22 14:05:42.303	\N	-1
-1	-1	-3	-1	22	\N	2021-07-22 14:05:42.303	\N	-2
-1	-1	-2	-1	22	\N	2021-07-22 14:05:42.303	\N	-3
-1	-1	-1	-1	22	\N	2021-07-22 14:05:42.303	\N	-4
1	5	1	7	22	\N	2026-06-20 00:00:40.658744	\N	1
1	5	2	7	22	\N	2026-06-20 00:00:40.662608	\N	2
\.


--
-- Data for Name: tblingreso; Type: TABLE DATA; Schema: seguridad; Owner: postgres
--

COPY seguridad.tblingreso (coingreso, cousuario, norefreshtoken, noip, feingreso, fesalida, ferefreshtokenexpire, norefreshtokenprevious, coestado, nouseragent) FROM stdin;
150	1	1F5456B5F70D9C9237621D7180CA8A233D2CDB65AABED4EE9CB845C435255E3F	::1	2026-07-09 16:27:55.057258	\N	2026-08-08 11:27:55.051029	\N	115	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 S
151	1	97E7E6C2F16218435F392468D3F83C38FE51111650B29BE9456210BB4EBB2184	::1	2026-07-09 20:33:00.656873	\N	2026-08-08 15:33:00.651009	\N	115	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 S
152	2	7A5993A2DD4627126F52E47B2D3C717E95660E65B110408DDCC298A381E852D2	::1	2026-07-09 21:05:04.040865	\N	2026-08-08 16:05:04.028599	\N	115	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 S
\.


--
-- Name: tblatributoseq; Type: SEQUENCE SET; Schema: catalogo; Owner: postgres
--

SELECT pg_catalog.setval('catalogo.tblatributoseq', 1, false);


--
-- Name: tblproductoatributoseq; Type: SEQUENCE SET; Schema: catalogo; Owner: postgres
--

SELECT pg_catalog.setval('catalogo.tblproductoatributoseq', 1, false);


--
-- Name: tblproductoindexseq; Type: SEQUENCE SET; Schema: catalogo; Owner: postgres
--

SELECT pg_catalog.setval('catalogo.tblproductoindexseq', 1, false);


--
-- Name: tblproductompuestoseq; Type: SEQUENCE SET; Schema: catalogo; Owner: postgres
--

SELECT pg_catalog.setval('catalogo.tblproductompuestoseq', 1, false);


--
-- Name: tblproductoprecioseq; Type: SEQUENCE SET; Schema: catalogo; Owner: postgres
--

SELECT pg_catalog.setval('catalogo.tblproductoprecioseq', 1, false);


--
-- Name: tblproductoseq; Type: SEQUENCE SET; Schema: catalogo; Owner: postgres
--

SELECT pg_catalog.setval('catalogo.tblproductoseq', 34, true);


--
-- Name: tblproductostockseq; Type: SEQUENCE SET; Schema: catalogo; Owner: postgres
--

SELECT pg_catalog.setval('catalogo.tblproductostockseq', 1, false);


--
-- Name: tblproductoterminadoseq; Type: SEQUENCE SET; Schema: catalogo; Owner: postgres
--

SELECT pg_catalog.setval('catalogo.tblproductoterminadoseq', 1, false);


--
-- Name: impuesto_impuesto_id_seq; Type: SEQUENCE SET; Schema: contabilidad; Owner: postgres
--

SELECT pg_catalog.setval('contabilidad.impuesto_impuesto_id_seq', 8, true);


--
-- Name: isc_subtipo_isc_subtipo_id_seq; Type: SEQUENCE SET; Schema: contabilidad; Owner: postgres
--

SELECT pg_catalog.setval('contabilidad.isc_subtipo_isc_subtipo_id_seq', 4, true);


--
-- Name: trfclasificacionfiscal_coclasificacionfiscal_seq; Type: SEQUENCE SET; Schema: contabilidad; Owner: postgres
--

SELECT pg_catalog.setval('contabilidad.trfclasificacionfiscal_coclasificacionfiscal_seq', 1, false);


--
-- Name: trfcomprobantepago_cocomprobantepago_seq; Type: SEQUENCE SET; Schema: contabilidad; Owner: postgres
--

SELECT pg_catalog.setval('contabilidad.trfcomprobantepago_cocomprobantepago_seq', 38, true);


--
-- Name: trfformapago_coformapago_seq; Type: SEQUENCE SET; Schema: contabilidad; Owner: postgres
--

SELECT pg_catalog.setval('contabilidad.trfformapago_coformapago_seq', 22, true);


--
-- Name: trfmotivonotacredito_comotivonotacredito_seq; Type: SEQUENCE SET; Schema: contabilidad; Owner: postgres
--

SELECT pg_catalog.setval('contabilidad.trfmotivonotacredito_comotivonotacredito_seq', 9, true);


--
-- Name: trfplancontableseq; Type: SEQUENCE SET; Schema: contabilidad; Owner: postgres
--

SELECT pg_catalog.setval('contabilidad.trfplancontableseq', 1, false);


--
-- Name: trftipocambioseq; Type: SEQUENCE SET; Schema: contabilidad; Owner: postgres
--

SELECT pg_catalog.setval('contabilidad.trftipocambioseq', 31, false);


--
-- Name: tblbandejaentradaseq; Type: SEQUENCE SET; Schema: empresa; Owner: postgres
--

SELECT pg_catalog.setval('empresa.tblbandejaentradaseq', 18, false);


--
-- Name: tblblogmensajeseq; Type: SEQUENCE SET; Schema: empresa; Owner: postgres
--

SELECT pg_catalog.setval('empresa.tblblogmensajeseq', 5, false);


--
-- Name: tblblogseq; Type: SEQUENCE SET; Schema: empresa; Owner: postgres
--

SELECT pg_catalog.setval('empresa.tblblogseq', 15, false);


--
-- Name: tblclienteseq; Type: SEQUENCE SET; Schema: empresa; Owner: postgres
--

SELECT pg_catalog.setval('empresa.tblclienteseq', 23, false);


--
-- Name: tblequiposeq; Type: SEQUENCE SET; Schema: empresa; Owner: postgres
--

SELECT pg_catalog.setval('empresa.tblequiposeq', 5, false);


--
-- Name: tblhorarioseq; Type: SEQUENCE SET; Schema: empresa; Owner: postgres
--

SELECT pg_catalog.setval('empresa.tblhorarioseq', 25, false);


--
-- Name: tblimagenwebseq; Type: SEQUENCE SET; Schema: empresa; Owner: postgres
--

SELECT pg_catalog.setval('empresa.tblimagenwebseq', 19, false);


--
-- Name: tblpreguntaseq; Type: SEQUENCE SET; Schema: empresa; Owner: postgres
--

SELECT pg_catalog.setval('empresa.tblpreguntaseq', 36, false);


--
-- Name: tblserviciocaracteristicaseq; Type: SEQUENCE SET; Schema: empresa; Owner: postgres
--

SELECT pg_catalog.setval('empresa.tblserviciocaracteristicaseq', 3, false);


--
-- Name: tblservicioseq; Type: SEQUENCE SET; Schema: empresa; Owner: postgres
--

SELECT pg_catalog.setval('empresa.tblservicioseq', 40, false);


--
-- Name: trflocalseq; Type: SEQUENCE SET; Schema: empresa; Owner: postgres
--

SELECT pg_catalog.setval('empresa.trflocalseq', 18, false);


--
-- Name: tblcompradetalleimpuesto_cocompradetalleimpuesto_seq; Type: SEQUENCE SET; Schema: facturacion; Owner: postgres
--

SELECT pg_catalog.setval('facturacion.tblcompradetalleimpuesto_cocompradetalleimpuesto_seq', 1, false);


--
-- Name: tblcompradetalleseq; Type: SEQUENCE SET; Schema: facturacion; Owner: postgres
--

SELECT pg_catalog.setval('facturacion.tblcompradetalleseq', 1, false);


--
-- Name: tblcompraseq; Type: SEQUENCE SET; Schema: facturacion; Owner: postgres
--

SELECT pg_catalog.setval('facturacion.tblcompraseq', 1, false);


--
-- Name: tblcorrelativoseq; Type: SEQUENCE SET; Schema: facturacion; Owner: postgres
--

SELECT pg_catalog.setval('facturacion.tblcorrelativoseq', 1, false);


--
-- Name: tblproformadetalleseq; Type: SEQUENCE SET; Schema: facturacion; Owner: postgres
--

SELECT pg_catalog.setval('facturacion.tblproformadetalleseq', 1, false);


--
-- Name: tblproformaseq; Type: SEQUENCE SET; Schema: facturacion; Owner: postgres
--

SELECT pg_catalog.setval('facturacion.tblproformaseq', 1, false);


--
-- Name: tblventadetalleimpuesto_coventadetalleimpuesto_seq; Type: SEQUENCE SET; Schema: facturacion; Owner: postgres
--

SELECT pg_catalog.setval('facturacion.tblventadetalleimpuesto_coventadetalleimpuesto_seq', 1, false);


--
-- Name: tblventadetalleseq; Type: SEQUENCE SET; Schema: facturacion; Owner: postgres
--

SELECT pg_catalog.setval('facturacion.tblventadetalleseq', 1, false);


--
-- Name: tblventaseq; Type: SEQUENCE SET; Schema: facturacion; Owner: postgres
--

SELECT pg_catalog.setval('facturacion.tblventaseq', 1, false);


--
-- Name: tblalmacenseq; Type: SEQUENCE SET; Schema: inventario; Owner: postgres
--

SELECT pg_catalog.setval('inventario.tblalmacenseq', 1, false);


--
-- Name: tblinventariodetalleseq; Type: SEQUENCE SET; Schema: inventario; Owner: postgres
--

SELECT pg_catalog.setval('inventario.tblinventariodetalleseq', 1, false);


--
-- Name: tblinventarioseq; Type: SEQUENCE SET; Schema: inventario; Owner: postgres
--

SELECT pg_catalog.setval('inventario.tblinventarioseq', 1, false);


--
-- Name: tblinventarioventaseq; Type: SEQUENCE SET; Schema: inventario; Owner: postgres
--

SELECT pg_catalog.setval('inventario.tblinventarioventaseq', 1, false);


--
-- Name: tblstockseq; Type: SEQUENCE SET; Schema: inventario; Owner: postgres
--

SELECT pg_catalog.setval('inventario.tblstockseq', 1, false);


--
-- Name: tblarchivoseq; Type: SEQUENCE SET; Schema: maestro; Owner: postgres
--

SELECT pg_catalog.setval('maestro.tblarchivoseq', 51, true);


--
-- Name: tblentidaddireccionseq; Type: SEQUENCE SET; Schema: maestro; Owner: postgres
--

SELECT pg_catalog.setval('maestro.tblentidaddireccionseq', 1, false);


--
-- Name: tblentidaddocumentoseq; Type: SEQUENCE SET; Schema: maestro; Owner: postgres
--

SELECT pg_catalog.setval('maestro.tblentidaddocumentoseq', 1, false);


--
-- Name: tblentidadempresaseq; Type: SEQUENCE SET; Schema: maestro; Owner: postgres
--

SELECT pg_catalog.setval('maestro.tblentidadempresaseq', 10, true);


--
-- Name: tblentidadredsocialseq; Type: SEQUENCE SET; Schema: maestro; Owner: postgres
--

SELECT pg_catalog.setval('maestro.tblentidadredsocialseq', 387, true);


--
-- Name: tblentidadrolseq; Type: SEQUENCE SET; Schema: maestro; Owner: postgres
--

SELECT pg_catalog.setval('maestro.tblentidadrolseq', 1, false);


--
-- Name: tblentidadseq; Type: SEQUENCE SET; Schema: maestro; Owner: postgres
--

SELECT pg_catalog.setval('maestro.tblentidadseq', 936, false);


--
-- Name: tblmonedaseq; Type: SEQUENCE SET; Schema: maestro; Owner: postgres
--

SELECT pg_catalog.setval('maestro.tblmonedaseq', 158, true);


--
-- Name: tblpersonatiposeq; Type: SEQUENCE SET; Schema: maestro; Owner: postgres
--

SELECT pg_catalog.setval('maestro.tblpersonatiposeq', 840, false);


--
-- Name: trfdocumentoidentidadseq; Type: SEQUENCE SET; Schema: maestro; Owner: postgres
--

SELECT pg_catalog.setval('maestro.trfdocumentoidentidadseq', 11, true);


--
-- Name: trfpaisseq; Type: SEQUENCE SET; Schema: maestro; Owner: postgres
--

SELECT pg_catalog.setval('maestro.trfpaisseq', 188, true);


--
-- Name: trftipogeneral_cotipogeneral_seq; Type: SEQUENCE SET; Schema: maestro; Owner: postgres
--

SELECT pg_catalog.setval('maestro.trftipogeneral_cotipogeneral_seq', 174, true);


--
-- Name: trftipoparticular_cotipoparticular_seq; Type: SEQUENCE SET; Schema: maestro; Owner: postgres
--

SELECT pg_catalog.setval('maestro.trftipoparticular_cotipoparticular_seq', 81, true);


--
-- Name: trfunidadmedidaseq; Type: SEQUENCE SET; Schema: maestro; Owner: postgres
--

SELECT pg_catalog.setval('maestro.trfunidadmedidaseq', 24, true);


--
-- Name: ubigeoseq; Type: SEQUENCE SET; Schema: maestro; Owner: postgres
--

SELECT pg_catalog.setval('maestro.ubigeoseq', 3125, true);


--
-- Name: audgeneral_coauditoria_seq; Type: SEQUENCE SET; Schema: seguridad; Owner: postgres
--

SELECT pg_catalog.setval('seguridad.audgeneral_coauditoria_seq', 7, true);


--
-- Name: segempresamoduloseq; Type: SEQUENCE SET; Schema: seguridad; Owner: postgres
--

SELECT pg_catalog.setval('seguridad.segempresamoduloseq', 20, false);


--
-- Name: segmenuseq; Type: SEQUENCE SET; Schema: seguridad; Owner: postgres
--

SELECT pg_catalog.setval('seguridad.segmenuseq', 7, true);


--
-- Name: segmoduloseq; Type: SEQUENCE SET; Schema: seguridad; Owner: postgres
--

SELECT pg_catalog.setval('seguridad.segmoduloseq', 16, true);


--
-- Name: segmodulousuarioseq; Type: SEQUENCE SET; Schema: seguridad; Owner: postgres
--

SELECT pg_catalog.setval('seguridad.segmodulousuarioseq', 4, false);


--
-- Name: segpaginaseq; Type: SEQUENCE SET; Schema: seguridad; Owner: postgres
--

SELECT pg_catalog.setval('seguridad.segpaginaseq', 2, true);


--
-- Name: segperfilpaginaseq; Type: SEQUENCE SET; Schema: seguridad; Owner: postgres
--

SELECT pg_catalog.setval('seguridad.segperfilpaginaseq', 2, true);


--
-- Name: segperfilseq; Type: SEQUENCE SET; Schema: seguridad; Owner: postgres
--

SELECT pg_catalog.setval('seguridad.segperfilseq', 2, true);


--
-- Name: seqingreso; Type: SEQUENCE SET; Schema: seguridad; Owner: postgres
--

SELECT pg_catalog.setval('seguridad.seqingreso', 152, true);


--
-- Name: tblempresaseq; Type: SEQUENCE SET; Schema: seguridad; Owner: postgres
--

SELECT pg_catalog.setval('seguridad.tblempresaseq', 23, true);


--
-- Name: trfpermisoseq; Type: SEQUENCE SET; Schema: seguridad; Owner: postgres
--

SELECT pg_catalog.setval('seguridad.trfpermisoseq', 17, false);


--
-- Name: trfredirectseq; Type: SEQUENCE SET; Schema: seguridad; Owner: postgres
--

SELECT pg_catalog.setval('seguridad.trfredirectseq', 1, false);


--
-- PostgreSQL database dump complete
--

\unrestrict cWs8r6fGx7dG9V0J3Bt8fYAPFyrRek2h8aTAiCRvlUTTP5m4r5aRMKPbqk2Hl5I

