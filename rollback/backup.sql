--
-- PostgreSQL database dump
--

--\restrict WgYIYyq16b7h7LczXXc755pwxoQpcL6kbma6Teq7Fy1e85Tv8Wr4Nt53hV79Ue4

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
    trace_id character varying(50) NOT NULL,
    transaction_id character varying(50) NOT NULL,
    user_id character varying(50),
    user_reference_id character varying(50),
    user_group_id character varying(50),
    user_unique_id character varying(50),
    creation_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    sypago_init_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    sypago_process_date timestamp without time zone,
    product character varying(10),
    sub_product character varying(10),
    product_sypago character varying(20),
    sub_product_sypago character varying(20),
    approval_agent character varying(10),
    sypago_creation_channel character varying(30),
    sypago_acceptance_channel character varying(30),
    issuing_agent character varying(10),
    receiving_agent character varying(10),
    amount jsonb NOT NULL,
    issuing_user jsonb NOT NULL,
    receiving_user jsonb NOT NULL,
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
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transactions (id, inittransactiondate, processtransactiondate, userid, subuserid, idconnection, nameemi, shcemadocumentemi, iddocumentemi, accountidemi, typeemi, bankcodeemi, conceptemi, namerep, shcemadocumentrep, iddocumentrep, accountidrep, typerep, bankcoderep, conceptrep, amt, currency, convertamt, convertcurrency, txsts, rsn, state, product, subproduct, approvalagent, refibp, issypagooperation, deliverytraces, endtoendid, expiration, expirationdate) FROM stdin;
\.


--
-- Data for Name: transactionsgw; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transactionsgw (trace_id, transaction_id, user_id, user_reference_id, user_group_id, user_unique_id, creation_date, sypago_init_date, sypago_process_date, product, sub_product, product_sypago, sub_product_sypago, approval_agent, sypago_creation_channel, sypago_acceptance_channel, issuing_agent, receiving_agent, amount, issuing_user, receiving_user, inserted_at) FROM stdin;
C9636C4704C6	82123901B3C2	371D2E119F49	A9C46BCAEF43	D3EE2EA3F757	371D2E119F52	2025-03-21 09:11:09	2025-03-21 09:11:09	2026-06-23 17:25:37	040	220	DEBIT	SYPAGO	OTHE	WEB-APP	WEB-CHECKOUT	0168	0168	{"Amt": 1, "Ccy": "VES", "Commission": 10.25}	{"UserId": "0efe4730-9c2c-457d-a736-675a58c4e87c", "Account": {"Id": "01680028785100594099", "Tp": "CNTA"}, "Document": {"Id": "J000003505", "SchmeNm": "SRIF"}, "LinkUserId": "0efe4730-9c2c-457d-a736-675a58c4e87c"}	{"UserId": "0efe4730-9c2c-457d-a736-675a58c4e87c", "Account": {"Id": "01680001505100865475", "Tp": "CNTA"}, "Document": {"Id": "J002664436", "Nm": "Firma Personal", "SchmeNm": "SRIF"}, "LinkUserId": "0efe4730-9c2c-457d-a736-675a58c4e87c"}	2026-06-23 21:25:37.710762
32A377645AAB	6D2A20676A2D	371D2E119F49	A9C46BCAEF43	D3EE2EA3F757	371D2E119F52	2025-03-21 09:11:09	2025-03-21 09:11:09	2026-06-23 17:26:35	040	220	DEBIT	SYPAGO	OTHE	WEB-APP	WEB-CHECKOUT	0168	0168	{"Amt": 1, "Ccy": "VES", "Commission": 10.25}	{"UserId": "0efe4730-9c2c-457d-a736-675a58c4e87c", "Account": {"Id": "01680028785100594099", "Tp": "CNTA"}, "Document": {"Id": "J000003505", "SchmeNm": "SRIF"}, "LinkUserId": "0efe4730-9c2c-457d-a736-675a58c4e87c"}	{"UserId": "0efe4730-9c2c-457d-a736-675a58c4e87c", "Account": {"Id": "01680001505100865475", "Tp": "CNTA"}, "Document": {"Id": "J002664436", "Nm": "Firma Personal", "SchmeNm": "SRIF"}, "LinkUserId": "0efe4730-9c2c-457d-a736-675a58c4e87c"}	2026-06-23 21:26:35.467139
21CB945817B5	A4CDCDDB6B7A	371D2E119F49	A9C46BCAEF43	D3EE2EA3F757	371D2E119F52	2025-03-21 09:11:09	2025-03-21 09:11:09	2026-06-24 09:11:50	040	220	DEBIT	SYPAGO	OTHE	WEB-APP	WEB-CHECKOUT	0168	0168	{"Amt": 1, "Ccy": "VES", "Commission": 10.25}	{"UserId": "0efe4730-9c2c-457d-a736-675a58c4e87c", "Account": {"Id": "01680028785100594099", "Tp": "CNTA"}, "Document": {"Id": "J000003505", "SchmeNm": "SRIF"}, "LinkUserId": "0efe4730-9c2c-457d-a736-675a58c4e87c"}	{"UserId": "0efe4730-9c2c-457d-a736-675a58c4e87c", "Account": {"Id": "01680001505100865475", "Tp": "CNTA"}, "Document": {"Id": "J002664436", "Nm": "Firma Personal", "SchmeNm": "SRIF"}, "LinkUserId": "0efe4730-9c2c-457d-a736-675a58c4e87c"}	2026-06-24 13:11:50.289902
DDA71AA47A38	8C730B0CD953	371D2E119F49	A9C46BCAEF43	D3EE2EA3F757	371D2E119F52	2025-03-21 09:11:09	2025-03-21 09:11:09	2026-06-24 09:14:41	040	220	DEBIT	SYPAGO	OTHE	WEB-APP	WEB-CHECKOUT	0168	0168	{"Amt": 1, "Ccy": "VES", "Commission": 10.25}	{"UserId": "0efe4730-9c2c-457d-a736-675a58c4e87c", "Account": {"Id": "01680028785100594099", "Tp": "CNTA"}, "Document": {"Id": "J000003505", "SchmeNm": "SRIF"}, "LinkUserId": "0efe4730-9c2c-457d-a736-675a58c4e87c"}	{"UserId": "0efe4730-9c2c-457d-a736-675a58c4e87c", "Account": {"Id": "01680001505100865475", "Tp": "CNTA"}, "Document": {"Id": "J002664436", "Nm": "Firma Personal", "SchmeNm": "SRIF"}, "LinkUserId": "0efe4730-9c2c-457d-a736-675a58c4e87c"}	2026-06-24 13:14:41.352056
\.


--
-- Name: account_certification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.account_certification_id_seq', 4, true);


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
-- Name: transactions transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (id);


--
-- Name: transactionsgw transactionsgw_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactionsgw
    ADD CONSTRAINT transactionsgw_pkey PRIMARY KEY (trace_id);


--
-- Name: transactionsgw transactionsgw_transaction_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactionsgw
    ADD CONSTRAINT transactionsgw_transaction_id_key UNIQUE (transaction_id);


--
-- PostgreSQL database dump complete
--

--\unrestrict WgYIYyq16b7h7LczXXc755pwxoQpcL6kbma6Teq7Fy1e85Tv8Wr4Nt53hV79Ue4

