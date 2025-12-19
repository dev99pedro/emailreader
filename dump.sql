--
-- PostgreSQL database dump
--

\restrict 7celmcbmOLKAWlFwzNislPYPVAgZfqWufK7lgfGcb2A8zk46QYdTvCcc9cGNn5z

-- Dumped from database version 16.11 (Ubuntu 16.11-0ubuntu0.24.04.1)
-- Dumped by pg_dump version 16.11 (Ubuntu 16.11-0ubuntu0.24.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
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
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.ar_internal_metadata OWNER TO postgres;

--
-- Name: customers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customers (
    id bigint NOT NULL,
    code character varying,
    email character varying,
    name character varying,
    subject character varying,
    tel character varying
);


ALTER TABLE public.customers OWNER TO postgres;

--
-- Name: customers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.customers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.customers_id_seq OWNER TO postgres;

--
-- Name: customers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.customers_id_seq OWNED BY public.customers.id;


--
-- Name: process_logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.process_logs (
    id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    error character varying,
    extracteddata json,
    filename character varying,
    status character varying,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.process_logs OWNER TO postgres;

--
-- Name: process_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.process_logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.process_logs_id_seq OWNER TO postgres;

--
-- Name: process_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.process_logs_id_seq OWNED BY public.process_logs.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO postgres;

--
-- Name: customers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers ALTER COLUMN id SET DEFAULT nextval('public.customers_id_seq'::regclass);


--
-- Name: process_logs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.process_logs ALTER COLUMN id SET DEFAULT nextval('public.process_logs_id_seq'::regclass);


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	development	2025-12-17 11:15:39.223549	2025-12-17 11:15:39.223554
schema_sha1	f98ea829c4967fd41b5e6c56c83dbe072babea43	2025-12-17 11:15:39.231771	2025-12-17 11:15:39.231774
\.


--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customers (id, code, email, name, subject, tel) FROM stdin;
1	ABC123.	joao.silva@example.com	João da Silva	Pedido de orçamento - Produto ABC123	11912345678
2	ABC123.	joao.silva@example.com	João da Silva	Pedido de orçamento - Produto ABC123	11912345678
3	XYZ987.	maria.oliveira@example.com	Maria Oliveira	Interesse no produto XYZ987	21998765432
4	ABC123.	joao.silva@example.com	João da Silva	Pedido de orçamento - Produto ABC123	11912345678
\.


--
-- Data for Name: process_logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.process_logs (id, created_at, error, extracteddata, filename, status, updated_at) FROM stdin;
1	2025-12-17 11:18:15.562519	\N	{"name":"João da Silva","tel":"(11) 91234-5678","email":"joao.silva@example.com","code":"ABC123.","subject":"Pedido de orçamento - Produto ABC123"}	email1.eml	completed	2025-12-17 11:18:17.59926
2	2025-12-17 11:18:33.430206	\N	{"name":"João da Silva","tel":"(11) 91234-5678","email":"joao.silva@example.com","code":"ABC123.","subject":"Pedido de orçamento - Produto ABC123"}	email1.eml	completed	2025-12-17 11:18:35.449053
3	2025-12-17 11:18:41.53177	Email somdomarx10@gmail.com não é um remetente	\N	[new booking] 13_10_2025 09_00.eml	failed	2025-12-17 11:18:43.570078
4	2025-12-17 11:18:57.753294	Email assinatura@clicksign.com não é um remetente	\N	assinar documento_ pedro ascari azevedo - contrato de prestação de serviços.pdf.eml	failed	2025-12-17 11:18:59.780523
5	2025-12-17 11:19:05.911947	\N	{"name":"Maria Oliveira","tel":"21 99876-5432","email":"maria.oliveira@example.com","code":"XYZ987.","subject":"Interesse no produto XYZ987"}	email2.eml	completed	2025-12-17 11:19:07.933041
6	2025-12-17 11:19:11.982779	\N	{"name":"João da Silva","tel":"(11) 91234-5678","email":"joao.silva@example.com","code":"ABC123.","subject":"Pedido de orçamento - Produto ABC123"}	email1.eml	completed	2025-12-17 11:19:14.000851
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schema_migrations (version) FROM stdin;
20251204123231
20251204120503
\.


--
-- Name: customers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.customers_id_seq', 4, true);


--
-- Name: process_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.process_logs_id_seq', 6, true);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);


--
-- Name: process_logs process_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.process_logs
    ADD CONSTRAINT process_logs_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- PostgreSQL database dump complete
--

\unrestrict 7celmcbmOLKAWlFwzNislPYPVAgZfqWufK7lgfGcb2A8zk46QYdTvCcc9cGNn5z

