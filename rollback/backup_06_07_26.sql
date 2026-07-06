--
-- PostgreSQL database dump
--

\restrict X3HrNe9QVIyXv1lyrS4hDrUxAv9p3OqIwA3CaAiEs5bQ3lEVetYHLrYVwJ1wRcs

-- Dumped from database version 17.10
-- Dumped by pg_dump version 17.10

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: account_certification; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account_certification (
    id bigint NOT NULL,
    account_origin character varying(100) NOT NULL,
    name character varying(225),
    document_id character varying(20),
    agent character varying(4),
    cnta character varying(20),
    cele character varying(11),
    is_active boolean,
    collector boolean,
    contract character varying(225),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.account_certification OWNER TO postgres;

--
-- Name: account_certification_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.account_certification ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.account_certification_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: resources; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resources (
    id bigint NOT NULL,
    services_id integer,
    name character varying(225),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.resources OWNER TO postgres;

--
-- Name: resources_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.resources ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.resources_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: services; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.services (
    id bigint NOT NULL,
    name character varying(225),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.services OWNER TO postgres;

--
-- Name: services_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.services ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.services_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: subresources; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subresources (
    id integer NOT NULL,
    resource_id integer,
    cod_sub_product character varying(6),
    name character varying(225),
    description text,
    create_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.subresources OWNER TO postgres;

--
-- Name: subresources_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.subresources ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.subresources_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: test_case; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.test_case (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    resource_id integer,
    subresource_id integer,
    name character varying(225),
    account_type character varying(4),
    expected_http character varying(4),
    status character varying(100),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.test_case OWNER TO postgres;

--
-- Name: transactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transactions (
    id character varying(13) NOT NULL,
    inittransactiondate timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    processtransactiondate timestamp without time zone,
    userid uuid,
    subuserid uuid,
    idconnection character varying(225),
    nameemi character varying(225),
    shcemadocumentemi character varying(10),
    iddocumentemi character varying(20),
    accountidemi character varying(20),
    typeemi character varying(4),
    bankcodeemi character varying(4),
    conceptemi text,
    namerep character varying(225),
    shcemadocumentrep character varying(10),
    iddocumentrep character varying(20),
    accountidrep character varying(20),
    typerep character varying(4),
    bankcoderep character varying(4),
    conceptrep text,
    amt double precision,
    currency character varying(4),
    convertamt character varying,
    convertcurrency character varying,
    txsts character varying(225),
    rsn text,
    state integer,
    product character varying(5),
    subproduct character varying(5),
    approvalagent character varying(100),
    refibp character varying(225),
    issypagooperation boolean,
    deliverytraces jsonb,
    endtoendid character varying(220),
    expiration character varying,
    expirationdate timestamp without time zone
);


ALTER TABLE public.transactions OWNER TO postgres;

--
-- Name: transactionsgw; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transactionsgw (
    trace_id character varying(255),
    transaction_id character varying(255),
    user_id character varying(255),
    user_reference_id character varying(255),
    user_group_id character varying(255),
    user_unique_id character varying(255),
    creation_date character varying(255),
    sypago_init_date character varying(255),
    sypago_process_date character varying(255),
    product character varying(255),
    sub_product character varying(255),
    product_sypago character varying(255),
    sub_product_sypago character varying(255),
    approval_agent character varying(255),
    sypago_creation_channel character varying(255),
    sypago_acceptance_channel character varying(255),
    issuing_agent character varying(255),
    receiving_agent character varying(255),
    amount jsonb,
    issuing_user jsonb,
    receiving_user jsonb,
    status character varying(100),
    rejected_code text,
    end_to_end character varying(30),
    inserted_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.transactionsgw OWNER TO postgres;

--
-- Data for Name: account_certification; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.account_certification (id, account_origin, name, document_id, agent, cnta, cele, is_active, collector, contract, created_at) FROM stdin;
1	Bancrecer	QA Empresas 0168	J000003505	0168	01680028785100594099	\N	t	t	\N	2026-06-22 19:37:01.316812
2	Bancamiga	QA Bancamiga	J18830040	0172	01720111511118942323	\N	t	t	\N	2026-06-22 19:39:16.217489
3	Bancrecer	Persona Natural	V22209030	0168	01680052055101259128	0424274082	t	\N	\N	2026-06-23 19:54:49.33822
4	Bancrecer	Firma Personal	R103782070	0168	01680032505101240447	04242740828	t	\N	\N	2026-06-23 19:54:49.33822
\.


--
-- Data for Name: resources; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resources (id, services_id, name, created_at) FROM stdin;
1	1	Sycloud	2026-07-02 17:55:56.909736
2	1	Gateway	2026-07-02 17:55:56.909736
3	1	Plugin	2026-07-02 17:55:56.909736
4	1	CTS	2026-07-02 17:55:56.909736
5	1	Solicitud de estado (Se va pronto)	2026-07-02 17:55:56.909736
6	2	Rest Api	2026-07-02 17:57:30.338274
7	2	MS Credito Emisor	2026-07-02 17:57:30.338274
8	2	MS Credito Emisor STS	2026-07-02 17:57:30.338274
9	2	MS Credito Receptor	2026-07-02 17:57:30.338274
10	2	MS Credito Receptor STS	2026-07-02 17:57:30.338274
11	2	MS Debito Emisor	2026-07-02 17:57:30.338274
12	2	MS Debito Emisor STS	2026-07-02 17:57:30.338274
13	2	MS Debito Receptor	2026-07-02 17:57:30.338274
14	2	MS Debito Receptor STS	2026-07-02 17:57:30.338274
15	3	MS Intra Emisor	2026-07-02 17:58:44.244808
16	3	MS Intra Emisor STS	2026-07-02 17:58:44.244808
17	3	MS Intra Receptor STS	2026-07-02 17:58:44.244808
18	3	MS Inter Emisor	2026-07-02 17:58:44.244808
19	3	MS Inter Emisor STS	2026-07-02 17:58:44.244808
20	3	MS Inter Receptor	2026-07-02 17:58:44.244808
21	3	MS Inter Receptor STS	2026-07-02 17:58:44.244808
\.


--
-- Data for Name: services; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.services (id, name, created_at) FROM stdin;
1	Sypago	2026-07-02 17:54:14.676301
2	Simf	2026-07-02 17:54:14.676301
3	Sglpar	2026-07-02 17:54:14.676301
4	Alias	2026-07-02 17:54:14.676301
5	Middleware	2026-07-02 17:54:14.676301
\.


--
-- Data for Name: subresources; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subresources (id, resource_id, cod_sub_product, name, description, create_at) FROM stdin;
1	1	220	Credito	Credito Inmediato	2026-07-06 12:14:51.900388
2	1	221	Credito	Credito Inmediato	2026-07-06 12:14:51.900388
3	1	222	Credito	Credito Inmediato	2026-07-06 12:14:51.900388
4	1	002	Debito	Debito Inmediato OTP	2026-07-06 12:14:51.900388
5	1	003	Domiciliacion	Debito Domiciliacion	2026-07-06 12:14:51.900388
6	1	050	Generador OTP	Generador OTP	2026-07-06 12:14:51.900388
\.


--
-- Data for Name: test_case; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.test_case (id, resource_id, subresource_id, name, account_type, expected_http, status, created_at) FROM stdin;
b3c8fff0-d1a4-40af-bf77-e036df4bb565	1	2	Caso Inicial de Credito Exitoso (CNTA)	CNTA	201	ACCP	2026-07-06 15:30:38.597107
\.


--
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transactions (id, inittransactiondate, processtransactiondate, userid, subuserid, idconnection, nameemi, shcemadocumentemi, iddocumentemi, accountidemi, typeemi, bankcodeemi, conceptemi, namerep, shcemadocumentrep, iddocumentrep, accountidrep, typerep, bankcoderep, conceptrep, amt, currency, convertamt, convertcurrency, txsts, rsn, state, product, subproduct, approvalagent, refibp, issypagooperation, deliverytraces, endtoendid, expiration, expirationdate) FROM stdin;
\.


--
-- Data for Name: transactionsgw; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transactionsgw (trace_id, transaction_id, user_id, user_reference_id, user_group_id, user_unique_id, creation_date, sypago_init_date, sypago_process_date, product, sub_product, product_sypago, sub_product_sypago, approval_agent, sypago_creation_channel, sypago_acceptance_channel, issuing_agent, receiving_agent, amount, issuing_user, receiving_user, status, rejected_code, end_to_end, inserted_at) FROM stdin;
5C8C38B0735B	72542B3CD041	371D2E119F49	A9C46BCAEF43	D3EE2EA3F757	371D2E119F52	2025-03-21T09:11:09	2025-03-21T09:11:09	2026-07-01T08:43:58	040	220	DEBIT	SYPAGO	OTHE	WEB-APP	WEB-CHECKOUT	0168	0168	{"Amt": 1, "Ccy": "VES", "Commission": 10.25}	{"UserId": "0efe4730-9c2c-457d-a736-675a58c4e87c", "Account": {"Id": "01680028785100594099", "Tp": "CNTA"}, "Document": {"Id": "J000003505", "SchmeNm": "SRIF"}, "LinkUserId": "0efe4730-9c2c-457d-a736-675a58c4e87c"}	{"UserId": "0efe4730-9c2c-457d-a736-675a58c4e87c", "Account": {"Id": "01680001505100865475", "Tp": "CNTA"}, "Document": {"Id": "J002664436", "Nm": "Firma Personal", "SchmeNm": "SRIF"}, "LinkUserId": "0efe4730-9c2c-457d-a736-675a58c4e87c"}	ACCP		01682026070108435605350777	2026-07-01 12:43:58.762081
CAA650C478A0	734D2D288A77	371D2E119F49	A9C46BCAEF43	D3EE2EA3F757	371D2E119F52	2025-03-21T09:11:09	2025-03-21T09:11:09	2026-07-01T11:44:02	040	220	CREDIT	SYPAGO	OTHE	TOOLS-QA	TOOLS-QA	0168	0168	{"Amt": 1, "Ccy": "VES", "Commission": 10.25}	{"UserId": "0efe4730-9c2c-457d-a736-675a58c4e87c", "Account": {"Id": "01680028785100594099", "Tp": "CNTA"}, "Document": {"Id": "J000003505", "SchmeNm": "SRIF"}, "LinkUserId": "0efe4730-9c2c-457d-a736-675a58c4e87c"}	{"UserId": "0efe4730-9c2c-457d-a736-675a58c4e87c", "Account": {"Id": "01680001505100865475", "Tp": "CNTA"}, "Document": {"Id": "J002664436", "Nm": "Firma Personal", "SchmeNm": "SRIF"}, "LinkUserId": "0efe4730-9c2c-457d-a736-675a58c4e87c"}	ACCP		01682026070111440005350778	2026-07-01 15:44:02.83308
4583876A1B3C	283961BCC6C9	371D2E119F49	A9C46BCAEF43	D3EE2EA3F757	371D2E119F52	2025-03-21T09:11:09	2025-03-21T09:11:09	2026-07-01T11:45:32	040	220	CREDIT	SYPAGO	OTHE	TOOLS-QA	TOOLS-QA	0168	0168	{"Amt": 1, "Ccy": "VES", "Commission": 10.25}	{"UserId": "0efe4730-9c2c-457d-a736-675a58c4e87c", "Account": {"Id": "01680028785100594099", "Tp": "CNTA"}, "Document": {"Id": "J000003505", "SchmeNm": "SRIF"}, "LinkUserId": "0efe4730-9c2c-457d-a736-675a58c4e87c"}	{"UserId": "0efe4730-9c2c-457d-a736-675a58c4e87c", "Account": {"Id": "01680001505100865475", "Tp": "CNTA"}, "Document": {"Id": "J002664436", "Nm": "Firma Personal", "SchmeNm": "SRIF"}, "LinkUserId": "0efe4730-9c2c-457d-a736-675a58c4e87c"}	ACCP		01682026070111453105350779	2026-07-01 15:45:32.672248
A8C32DC5DCBD	3C9A7537A8A4	371D2E119F49	A9C46BCAEF43	D3EE2EA3F757	371D2E119F52	2025-03-21T09:11:09	2025-03-21T09:11:09	2026-07-01T18:09:20	040	220	DEBIT	SYPAGO	OTHE	WEB-APP	WEB-CHECKOUT	0168	0168	{"Amt": 1, "Ccy": "VES", "Commission": 10.25}	{"UserId": "0efe4730-9c2c-457d-a736-675a58c4e87c", "Account": {"Id": "01680028785100594099", "Tp": "CNTA"}, "Document": {"Id": "J000003505", "SchmeNm": "SRIF"}, "LinkUserId": "0efe4730-9c2c-457d-a736-675a58c4e87c"}	{"UserId": "0efe4730-9c2c-457d-a736-675a58c4e87c", "Account": {"Id": "01680001505100865475", "Tp": "CNTA"}, "Document": {"Id": "J002664436", "Nm": "Firma Personal", "SchmeNm": "SRIF"}, "LinkUserId": "0efe4730-9c2c-457d-a736-675a58c4e87c"}	\N	\N	\N	2026-07-01 18:09:20.828706
42ADD0A50DC0	BA8C65D9B2BA	371D2E119F49	A9C46BCAEF43	D3EE2EA3F757	371D2E119F52	2025-03-21T09:11:09	2025-03-21T09:11:09	2026-07-01T18:10:40	040	220	DEBIT	SYPAGO	OTHE	WEB-APP	WEB-CHECKOUT	0168	0168	{"Amt": 1, "Ccy": "VES", "Commission": 10.25}	{"UserId": "0efe4730-9c2c-457d-a736-675a58c4e87c", "Account": {"Id": "01680028785100594099", "Tp": "CNTA"}, "Document": {"Id": "J000003505", "SchmeNm": "SRIF"}, "LinkUserId": "0efe4730-9c2c-457d-a736-675a58c4e87c"}	{"UserId": "0efe4730-9c2c-457d-a736-675a58c4e87c", "Account": {"Id": "01680001505100865475", "Tp": "CNTA"}, "Document": {"Id": "J002664436", "Nm": "Firma Personal", "SchmeNm": "SRIF"}, "LinkUserId": "0efe4730-9c2c-457d-a736-675a58c4e87c"}	\N	\N	\N	2026-07-01 18:10:40.073136
C59492C62D6C	6C0A72B244D1	371D2E119F49	A9C46BCAEF43	D3EE2EA3F757	371D2E119F52	2025-03-21T09:11:09	2025-03-21T09:11:09	2026-07-01T18:10:58	040	220	DEBIT	SYPAGO	OTHE	WEB-APP	WEB-CHECKOUT	0168	0168	{"Amt": 1, "Ccy": "VES", "Commission": 10.25}	{"UserId": "0efe4730-9c2c-457d-a736-675a58c4e87c", "Account": {"Id": "01680028785100594099", "Tp": "CNTA"}, "Document": {"Id": "J000003505", "SchmeNm": "SRIF"}, "LinkUserId": "0efe4730-9c2c-457d-a736-675a58c4e87c"}	{"UserId": "0efe4730-9c2c-457d-a736-675a58c4e87c", "Account": {"Id": "01680001505100865475", "Tp": "CNTA"}, "Document": {"Id": "J002664436", "Nm": "Firma Personal", "SchmeNm": "SRIF"}, "LinkUserId": "0efe4730-9c2c-457d-a736-675a58c4e87c"}	\N	\N	\N	2026-07-01 18:10:58.650551
7CA7C7BA4449	72D9691D1628	371D2E119F49	A9C46BCAEF43	D3EE2EA3F757	371D2E119F52	2025-03-21T09:11:09	2025-03-21T09:11:09	2026-07-02T12:55:00	040	220	DEBIT	SYPAGO	OTHE	WEB-APP	WEB-CHECKOUT	0168	0168	{"Amt": 1, "Ccy": "VES", "Commission": 10.25}	{"UserId": "0efe4730-9c2c-457d-a736-675a58c4e87c", "Account": {"Id": "01680028785100594099", "Tp": "CNTA"}, "Document": {"Id": "J000003505", "SchmeNm": "SRIF"}, "LinkUserId": "0efe4730-9c2c-457d-a736-675a58c4e87c"}	{"UserId": "0efe4730-9c2c-457d-a736-675a58c4e87c", "Account": {"Id": "01680001505100865475", "Tp": "CNTA"}, "Document": {"Id": "J002664436", "Nm": "Firma Personal", "SchmeNm": "SRIF"}, "LinkUserId": "0efe4730-9c2c-457d-a736-675a58c4e87c"}	\N	\N	\N	2026-07-02 12:55:00.312965
3BA4D6CC229A	B8D3A092B364	371D2E119F49	A9C46BCAEF43	D3EE2EA3F757	371D2E119F52	2025-03-21T09:11:09	2025-03-21T09:11:09	2026-07-06T16:16:01	040	220	CREDIT	SYPAGO	OTHE	TOOLS-QA	TOOLS-QA	0168	0168	{"Amt": 1, "Ccy": "VES", "Commission": 10.25}	{"UserId": "0efe4730-9c2c-457d-a736-675a58c4e87c", "Account": {"Id": "01680028785100594099", "Tp": "CNTA"}, "Document": {"Id": "J000003505", "SchmeNm": "SRIF"}, "LinkUserId": "0efe4730-9c2c-457d-a736-675a58c4e87c"}	{"UserId": "0efe4730-9c2c-457d-a736-675a58c4e87c", "Account": {"Id": "01680001505100865475", "Tp": "CNTA"}, "Document": {"Id": "J002664436", "Nm": "Firma Personal", "SchmeNm": "SRIF"}, "LinkUserId": "0efe4730-9c2c-457d-a736-675a58c4e87c"}	PEND			2026-07-06 16:16:02.005743
82C1A3C9D464	2A236D177C72	371D2E119F49	A9C46BCAEF43	D3EE2EA3F757	371D2E119F52	2025-03-21T09:11:09	2025-03-21T09:11:09	2026-07-06T16:16:09	040	220	CREDIT	SYPAGO	OTHE	TOOLS-QA	TOOLS-QA	0168	0168	{"Amt": 1, "Ccy": "VES", "Commission": 10.25}	{"UserId": "0efe4730-9c2c-457d-a736-675a58c4e87c", "Account": {"Id": "01680028785100594099", "Tp": "CNTA"}, "Document": {"Id": "J000003505", "SchmeNm": "SRIF"}, "LinkUserId": "0efe4730-9c2c-457d-a736-675a58c4e87c"}	{"UserId": "0efe4730-9c2c-457d-a736-675a58c4e87c", "Account": {"Id": "01680001505100865475", "Tp": "CNTA"}, "Document": {"Id": "J002664436", "Nm": "Firma Personal", "SchmeNm": "SRIF"}, "LinkUserId": "0efe4730-9c2c-457d-a736-675a58c4e87c"}	ACCP		01682026070612160805350811	2026-07-06 16:16:09.749672
\.


--
-- Name: account_certification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.account_certification_id_seq', 4, true);


--
-- Name: resources_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.resources_id_seq', 22, true);


--
-- Name: services_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.services_id_seq', 5, true);


--
-- Name: subresources_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subresources_id_seq', 6, true);


--
-- Name: account_certification account_certification_cnta_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_certification
    ADD CONSTRAINT account_certification_cnta_key UNIQUE (cnta);


--
-- Name: account_certification account_certification_document_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_certification
    ADD CONSTRAINT account_certification_document_id_key UNIQUE (document_id);


--
-- Name: account_certification account_certification_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_certification
    ADD CONSTRAINT account_certification_pkey PRIMARY KEY (id);


--
-- Name: resources resources_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resources
    ADD CONSTRAINT resources_name_key UNIQUE (name);


--
-- Name: resources resources_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resources
    ADD CONSTRAINT resources_pkey PRIMARY KEY (id);


--
-- Name: services services_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_name_key UNIQUE (name);


--
-- Name: services services_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_pkey PRIMARY KEY (id);


--
-- Name: subresources subresources_cod_sub_product_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subresources
    ADD CONSTRAINT subresources_cod_sub_product_key UNIQUE (cod_sub_product);


--
-- Name: subresources subresources_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subresources
    ADD CONSTRAINT subresources_pkey PRIMARY KEY (id);


--
-- Name: test_case test_case_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_case
    ADD CONSTRAINT test_case_pkey PRIMARY KEY (id);


--
-- Name: transactions transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (id);


--
-- Name: test_case fk_resource_case; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_case
    ADD CONSTRAINT fk_resource_case FOREIGN KEY (resource_id) REFERENCES public.resources(id) ON UPDATE CASCADE;


--
-- Name: subresources fk_resources; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subresources
    ADD CONSTRAINT fk_resources FOREIGN KEY (resource_id) REFERENCES public.resources(id) ON UPDATE CASCADE;


--
-- Name: resources fk_services_resources; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resources
    ADD CONSTRAINT fk_services_resources FOREIGN KEY (services_id) REFERENCES public.services(id) ON UPDATE CASCADE;


--
-- Name: test_case fk_sub_resource_case; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_case
    ADD CONSTRAINT fk_sub_resource_case FOREIGN KEY (subresource_id) REFERENCES public.subresources(id) ON UPDATE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict X3HrNe9QVIyXv1lyrS4hDrUxAv9p3OqIwA3CaAiEs5bQ3lEVetYHLrYVwJ1wRcs

