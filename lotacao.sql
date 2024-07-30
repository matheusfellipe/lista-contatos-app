--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3 (Debian 16.3-1.pgdg120+1)
-- Dumped by pg_dump version 16.3 (Debian 16.3-1.pgdg120+1)

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
-- Name: lotacao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lotacao (
    id_lotacao integer NOT NULL,
    departamento character varying(200),
    sigla character varying(3)
);


ALTER TABLE public.lotacao OWNER TO postgres;

--
-- Name: lotacao_id_lotacao_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.lotacao_id_lotacao_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.lotacao_id_lotacao_seq OWNER TO postgres;

--
-- Name: lotacao_id_lotacao_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.lotacao_id_lotacao_seq OWNED BY public.lotacao.id_lotacao;


--
-- Name: lotacao id_lotacao; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lotacao ALTER COLUMN id_lotacao SET DEFAULT nextval('public.lotacao_id_lotacao_seq'::regclass);


--
-- Data for Name: lotacao; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lotacao (id_lotacao, departamento, sigla) FROM stdin;
2	Missionário	MIS
3	Discipulado	DIS
4	Infantil	INF
5	Adolescente	ADO
6	Jovens	JOV
7	Adultos	ADT
8	Terceira Idade	TI
9	Administrativo	ADM
10	Manutenção	MAN
11	Comunicação	COM
12	Eventos	EVT
13	Recepção	REC
14	Tesouraria	TES
1	Louvor	LVR
\.


--
-- Name: lotacao_id_lotacao_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lotacao_id_lotacao_seq', 14, true);


--
-- Name: lotacao lotacao_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lotacao
    ADD CONSTRAINT lotacao_pkey PRIMARY KEY (id_lotacao);


--
-- Name: lotacao unique_sigla; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lotacao
    ADD CONSTRAINT unique_sigla UNIQUE (sigla);


--
-- PostgreSQL database dump complete
--

