--
-- PostgreSQL database dump
--

\restrict p4sQ9LR8SRLCVoL115uHKnBTheeKzRamrJ0AcrprNJf8q1gM3TZCR9AYhJDjKdI

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
-- Name: account_list; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account_list (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    environments_id integer,
    account_origin character varying(225),
    name character varying(225) NOT NULL,
    document_id character varying(15) NOT NULL,
    agent character varying(4) NOT NULL,
    cnta character varying(20),
    cele character varying(11),
    is_active boolean,
    collector boolean,
    contract character varying(225),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.account_list OWNER TO postgres;

--
-- Name: departament; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.departament (
    id integer NOT NULL,
    name character varying(225),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.departament OWNER TO postgres;

--
-- Name: departament_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.departament ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.departament_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: endpoints_manager; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.endpoints_manager (
    id integer NOT NULL,
    subresource_id integer,
    path text,
    method character varying(10),
    default_headers jsonb,
    request_body jsonb,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.endpoints_manager OWNER TO postgres;

--
-- Name: COLUMN endpoints_manager.request_body; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.endpoints_manager.request_body IS 'Plantilla JSON base del contrato del servicio con marcadores {{variable}}';


--
-- Name: endpoints_manager_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.endpoints_manager ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.endpoints_manager_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: environments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.environments (
    id integer NOT NULL,
    name character varying(225),
    global_domain text,
    global_headers jsonb,
    global_auth jsonb,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.environments OWNER TO postgres;

--
-- Name: environments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.environments ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.environments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.permissions (
    id integer NOT NULL,
    name character varying(225),
    module character varying(225),
    description text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.permissions OWNER TO postgres;

--
-- Name: permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.permissions ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.permissions_id_seq
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
    id integer NOT NULL,
    service_id integer,
    environment_id integer,
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
-- Name: role_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role_permissions (
    role_id integer,
    permissions_id integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.role_permissions OWNER TO postgres;

--
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id integer NOT NULL,
    name character varying(225),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.roles ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.roles_id_seq
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
    id integer NOT NULL,
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
    name character varying(225),
    cod_sub_product character varying(10),
    description text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
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
    endpoint_id integer,
    name character varying(225),
    request_body jsonb,
    custom_headers jsonb,
    expected_http character varying(100),
    assertions jsonb,
    status character varying(225),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.test_case OWNER TO postgres;

--
-- Name: COLUMN test_case.request_body; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN public.test_case.request_body IS 'Mapa clave-valor con las variables/deltas a inyectar en la plantilla base';


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id character varying(15) NOT NULL,
    alias character varying(100) NOT NULL,
    name character varying(100) NOT NULL,
    surname character varying(100) NOT NULL,
    email character varying(225) NOT NULL,
    phone character varying(11),
    password_hash text,
    departament_id integer,
    role_id integer,
    is_active boolean,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Data for Name: account_list; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.account_list (id, environments_id, account_origin, name, document_id, agent, cnta, cele, is_active, collector, contract, created_at) FROM stdin;
a9c8ea33-fc4d-441d-bc93-022faa3f4ccc	16	Bancamiga	QA Juridico Bancamiga	J410035552	0172	01720106961064006008	04129854529	t	t	\N	2026-07-24 02:12:55.58721
\.


--
-- Data for Name: departament; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.departament (id, name, created_at) FROM stdin;
1	QA	2026-07-16 09:54:24.849773
\.


--
-- Data for Name: endpoints_manager; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.endpoints_manager (id, subresource_id, path, method, default_headers, request_body, created_at) FROM stdin;
4	5	api/v1/transaction/credit	POST	{"Content-Type": "application/json", "X-Service-Source": "Opengine-Core"}	\N	2026-07-24 02:00:07.764794
5	5	/v1/transaction/credit	POST	{"Content-Type": "application/json", "X-Service-Source": "Opengine-Core"}	{"Amount": {"Amt": "{{monto}}", "Ccy": "VES", "Commission": 10.25}, "UserId": "371D2E119F49", "Product": "040", "TraceId": "{{trace_id}}", "SubProduct": "220", "IssuingUser": {"UserId": "0efe4730-9c2c-457d-a736-675a58c4e87c", "Account": {"Id": "{{emisor.cnta}}", "Tp": "{{tp.cnta}}"}, "Document": {"Id": "{{emisor.rif}}", "SchmeNm": "{{tp.schme}}"}, "LinkUserId": "0efe4730-9c2c-457d-a736-675a58c4e87c"}, "UserGroupId": "D3EE2EA3F757", "CreationDate": "{{now}}", "IssuingAgent": "{{emisor.bank}}", "UserUniqueId": "371D2E119F52", "ApprovalAgent": "OTHE", "ProductSypago": "CREDIT", "ReceivingUser": {"UserId": "0efe4730-9c2c-457d-a736-675a58c4e87c", "Account": {"Id": "{{receptor.cnta}}", "Tp": "{{tp.cnta}}"}, "Document": {"Id": "{{receptor.rif}}", "Nm": "{{nm.receptor}}", "SchmeNm": "{{tp.schme}}"}, "LinkUserId": "0efe4730-9c2c-457d-a736-675a58c4e87c"}, "TransactionId": "{{transaction_id}}", "ReceivingAgent": "{{receptor.bank}}", "SypagoInitDate": "{{now}}", "UserReferenceId": "A9C46BCAEF43", "SubProductSypago": "SYPAGO", "SypagoProcessDate": "{{now}}", "SyPagoCreationChannel": "WEB-APP", "SyPagoAcceptanceChannel": "WEB-CHECKOUT"}	2026-07-24 02:40:46.871956
\.


--
-- Data for Name: environments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.environments (id, name, global_domain, global_headers, global_auth, created_at) FROM stdin;
16	Certificación Sycloud	https://pruebas.app.sypago.net/	{"Accept": "application/json", "Content-Type": "application/json", "X-Client-Type": "Sycloud"}	{"token": "eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJmZXpQcl9HSWhIZ05jOVc1cU5Td2FIQXBRMVRqeUlqbWtpY0d5V1hHUjFzIn0.eyJleHAiOjE4NzA5NTk1ODgsImlhdCI6MTc4NDU1OTU4OCwianRpIjoiN2JlNDMxNWEtNTg1Ny00Y2Y0LWJiZTktOWM5ZjcxMGI0MjJlIiwiaXNzIjoiaHR0cHM6Ly9wcnVlYmFzLnN5cGFnby5uZXQ6ODA4MS9yZWFsbXMvc3lwYWdvIiwiYXVkIjoiYWNjb3VudCIsInN1YiI6IjVlZmVjMmE2LTc2YjAtNGU3OC1iN2Q3LTYzNzAwYWIyNDA3ZCIsInR5cCI6IkJlYXJlciIsImF6cCI6InN5cGFnb19hcGlrZXlfYWRtaW4iLCJhY3IiOiIxIiwiYWxsb3dlZC1vcmlnaW5zIjpbIi8qIl0sInJlYWxtX2FjY2VzcyI6eyJyb2xlcyI6WyJkZWZhdWx0LXJvbGVzLXN5cGFnbyIsIm9mZmxpbmVfYWNjZXNzIiwidW1hX2F1dGhvcml6YXRpb24iXX0sInJlc291cmNlX2FjY2VzcyI6eyJhY2NvdW50Ijp7InJvbGVzIjpbIm1hbmFnZS1hY2NvdW50IiwibWFuYWdlLWFjY291bnQtbGlua3MiLCJ2aWV3LXByb2ZpbGUiXX19LCJzY29wZSI6Im9mZmxpbmVfYWNjZXNzIHN5YXBwX3Njb3BlIHByb2ZpbGUgZW1haWwgc3lwYWdvX2FwaV9rZXlfc2NvcGU6NzA2NmNmNmYtNWY2Zi00ZDUxLTg0ZjMtMjY4NDAyOWI0ZjNhLlVzZXIiLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsImNsaWVudEhvc3QiOiIxMC4xMDAuMy4xIiwicHJlZmVycmVkX3VzZXJuYW1lIjoic2VydmljZS1hY2NvdW50LXN5cGFnb19hcGlrZXlfYWRtaW4iLCJjbGllbnRBZGRyZXNzIjoiMTAuMTAwLjMuMSIsImNsaWVudF9pZCI6InN5cGFnb19hcGlrZXlfYWRtaW4ifQ.FbS4QzcP62WIy2fhe_uEqT4IhPefOEL3vXZcCZ5MRXJeAykOLrj9hz3odUvJ2hcHNEeI94yUIAu7plOZQickDrZCMMRe08RapTrV985uvXfAsBG0hQE62pKsAXq0Ko_z40ItuOJsjsLDjHIFn6jhaag1oUQgnTFJBICYvGfu1NyzTl0ZF5nTlKXXpCEjJKVnyDVCnsJoGyhHfehWWYpnHb0zWmJiXGXB7etvtrlJrNLT8ft9zyl6yBmZmTVFbTh7Ts8Q4OhYdDBXukL5kmPoN28lGQuX9snd5kbLeJYoHbOkJSwmaS7hupOw2JxNEnyjG_l07NrPQR4rsQxtqg70NA", "auth_type": "bearer"}	2026-07-20 15:00:38.31512
\.


--
-- Data for Name: permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.permissions (id, name, module, description, created_at) FROM stdin;
\.


--
-- Data for Name: resources; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resources (id, service_id, environment_id, name, created_at) FROM stdin;
4	8	16	Sycloud	2026-07-20 15:55:19.341491
\.


--
-- Data for Name: role_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role_permissions (role_id, permissions_id, created_at) FROM stdin;
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id, name, created_at) FROM stdin;
1	administrator	2026-07-16 09:55:37.640849
2	read	2026-07-16 09:55:37.640849
3	QA	2026-07-16 09:55:37.640849
\.


--
-- Data for Name: services; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.services (id, name, created_at) FROM stdin;
8	Sypago	2026-07-20 14:58:15.391185
\.


--
-- Data for Name: subresources; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subresources (id, resource_id, name, cod_sub_product, description, created_at) FROM stdin;
5	4	Credito 220	220	Sub producto de Credito Inmediato	2026-07-20 16:46:40.154968
7	4	Debito 002	002	Sub producto de Debito Inmediato OTP	2026-07-20 18:30:41.704994
\.


--
-- Data for Name: test_case; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.test_case (id, endpoint_id, name, request_body, custom_headers, expected_http, assertions, status, created_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, alias, name, surname, email, phone, password_hash, departament_id, role_id, is_active, created_at) FROM stdin;
V123456789	batman	batman	destroy	batman@gmail.com	04121234456	$2a$10$ji7i55Bw.gCLaBI0AQdpjOwwvQy/067U88AjHnCpsYzaI4GWKmcwa	1	1	t	2026-07-16 14:08:32.880641
\.


--
-- Name: departament_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.departament_id_seq', 1, true);


--
-- Name: endpoints_manager_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.endpoints_manager_id_seq', 5, true);


--
-- Name: environments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.environments_id_seq', 16, true);


--
-- Name: permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.permissions_id_seq', 1, false);


--
-- Name: resources_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.resources_id_seq', 4, true);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 3, true);


--
-- Name: services_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.services_id_seq', 8, true);


--
-- Name: subresources_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subresources_id_seq', 7, true);


--
-- Name: account_list account_list_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_list
    ADD CONSTRAINT account_list_pkey PRIMARY KEY (id);


--
-- Name: departament departament_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departament
    ADD CONSTRAINT departament_name_key UNIQUE (name);


--
-- Name: departament departament_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departament
    ADD CONSTRAINT departament_pkey PRIMARY KEY (id);


--
-- Name: endpoints_manager endpoints_manager_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endpoints_manager
    ADD CONSTRAINT endpoints_manager_pkey PRIMARY KEY (id);


--
-- Name: environments environments_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.environments
    ADD CONSTRAINT environments_name_key UNIQUE (name);


--
-- Name: environments environments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.environments
    ADD CONSTRAINT environments_pkey PRIMARY KEY (id);


--
-- Name: resources fk_name_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resources
    ADD CONSTRAINT fk_name_unique UNIQUE (name);


--
-- Name: permissions permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (id);


--
-- Name: resources resources_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resources
    ADD CONSTRAINT resources_pkey PRIMARY KEY (id);


--
-- Name: roles roles_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_name_key UNIQUE (name);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: services services_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT services_pkey PRIMARY KEY (id);


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
-- Name: account_list unique_account_cnta; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_list
    ADD CONSTRAINT unique_account_cnta UNIQUE (cnta);


--
-- Name: services unique_service_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.services
    ADD CONSTRAINT unique_service_name UNIQUE (name);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users fk_departament; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT fk_departament FOREIGN KEY (departament_id) REFERENCES public.departament(id) ON UPDATE CASCADE;


--
-- Name: test_case fk_endpoint_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_case
    ADD CONSTRAINT fk_endpoint_id FOREIGN KEY (endpoint_id) REFERENCES public.endpoints_manager(id) ON UPDATE CASCADE;


--
-- Name: account_list fk_environment; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_list
    ADD CONSTRAINT fk_environment FOREIGN KEY (environments_id) REFERENCES public.environments(id) ON UPDATE CASCADE;


--
-- Name: resources fk_environment_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resources
    ADD CONSTRAINT fk_environment_id FOREIGN KEY (environment_id) REFERENCES public.environments(id) ON UPDATE CASCADE;


--
-- Name: role_permissions fk_permissions_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_permissions
    ADD CONSTRAINT fk_permissions_id FOREIGN KEY (permissions_id) REFERENCES public.permissions(id) ON UPDATE CASCADE;


--
-- Name: subresources fk_resources_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subresources
    ADD CONSTRAINT fk_resources_id FOREIGN KEY (resource_id) REFERENCES public.resources(id) ON UPDATE CASCADE;


--
-- Name: role_permissions fk_role_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_permissions
    ADD CONSTRAINT fk_role_id FOREIGN KEY (role_id) REFERENCES public.roles(id) ON UPDATE CASCADE;


--
-- Name: users fk_roles; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT fk_roles FOREIGN KEY (role_id) REFERENCES public.roles(id) ON UPDATE CASCADE;


--
-- Name: resources fk_services; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resources
    ADD CONSTRAINT fk_services FOREIGN KEY (service_id) REFERENCES public.services(id) ON UPDATE CASCADE;


--
-- Name: endpoints_manager fk_subresource_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endpoints_manager
    ADD CONSTRAINT fk_subresource_id FOREIGN KEY (subresource_id) REFERENCES public.subresources(id) ON UPDATE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict p4sQ9LR8SRLCVoL115uHKnBTheeKzRamrJ0AcrprNJf8q1gM3TZCR9AYhJDjKdI

