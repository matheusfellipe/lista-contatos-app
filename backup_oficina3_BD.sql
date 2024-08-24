--
-- PostgreSQL database dump
--

-- Dumped from database version 14.2
-- Dumped by pg_dump version 14.2

-- Started on 2024-08-23 20:10:50

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

--
-- TOC entry 226 (class 1255 OID 25495)
-- Name: gerar_cpf(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.gerar_cpf() RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
    cpf text := '';
    soma integer;
    resto integer;
    i integer;
BEGIN
    -- Gera os 9 primeiros dígitos aleatórios
    FOR i IN 1..9 LOOP
        cpf := cpf || to_char(floor(random() * 10), '9');
    END LOOP;

    -- Calcula o primeiro dígito verificador
    soma := 0;
    FOR i IN 1..9 LOOP
        soma := soma + substring(replace(cpf, ' ', ''), i, 1)::integer * (10 - i);
    END LOOP;
    resto := soma % 11;
    IF resto < 2 THEN
        cpf := cpf || '0';
    ELSE
        cpf := cpf || to_char(11 - resto, '9');
    END IF;

    -- Calcula o segundo dígito verificador
    soma := 0;
    FOR i IN 1..10 LOOP
        soma := soma + substring(cpf, i, 1)::integer * (11 - i);
    END LOOP;
    resto := soma % 11;
    IF resto < 2 THEN
        cpf := cpf || '0';
    ELSE
        cpf := cpf || to_char(11 - resto, '9');
    END IF;

    RETURN cpf;
END;
$$;


ALTER FUNCTION public.gerar_cpf() OWNER TO postgres;

--
-- TOC entry 217 (class 1255 OID 25475)
-- Name: mod11_multiplier(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.mod11_multiplier(number integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN CASE WHEN number < 2 THEN 0 ELSE number END;
END;
$$;


ALTER FUNCTION public.mod11_multiplier(number integer) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 210 (class 1259 OID 17292)
-- Name: lotacao; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lotacao (
    id_lotacao integer NOT NULL,
    departamento character varying(200),
    sigla character varying(3)
);


ALTER TABLE public.lotacao OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 17291)
-- Name: lotacao_id_lotacao_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.lotacao_id_lotacao_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lotacao_id_lotacao_seq OWNER TO postgres;

--
-- TOC entry 3331 (class 0 OID 0)
-- Dependencies: 209
-- Name: lotacao_id_lotacao_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.lotacao_id_lotacao_seq OWNED BY public.lotacao.id_lotacao;


--
-- TOC entry 213 (class 1259 OID 17300)
-- Name: pessoa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pessoa (
    id_pessoa integer NOT NULL,
    cpf character(11),
    nome character varying(200),
    dt_nascimento date,
    telefone character varying(60),
    id_lotacao integer NOT NULL,
    dt_membro date
);


ALTER TABLE public.pessoa OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 17299)
-- Name: pessoa_id_lotacao_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pessoa_id_lotacao_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pessoa_id_lotacao_seq OWNER TO postgres;

--
-- TOC entry 3332 (class 0 OID 0)
-- Dependencies: 212
-- Name: pessoa_id_lotacao_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pessoa_id_lotacao_seq OWNED BY public.pessoa.id_lotacao;


--
-- TOC entry 211 (class 1259 OID 17298)
-- Name: pessoa_id_pessoa_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pessoa_id_pessoa_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pessoa_id_pessoa_seq OWNER TO postgres;

--
-- TOC entry 3333 (class 0 OID 0)
-- Dependencies: 211
-- Name: pessoa_id_pessoa_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pessoa_id_pessoa_seq OWNED BY public.pessoa.id_pessoa;


--
-- TOC entry 3172 (class 2604 OID 17295)
-- Name: lotacao id_lotacao; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lotacao ALTER COLUMN id_lotacao SET DEFAULT nextval('public.lotacao_id_lotacao_seq'::regclass);


--
-- TOC entry 3173 (class 2604 OID 17303)
-- Name: pessoa id_pessoa; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pessoa ALTER COLUMN id_pessoa SET DEFAULT nextval('public.pessoa_id_pessoa_seq'::regclass);


--
-- TOC entry 3174 (class 2604 OID 17304)
-- Name: pessoa id_lotacao; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pessoa ALTER COLUMN id_lotacao SET DEFAULT nextval('public.pessoa_id_lotacao_seq'::regclass);


--
-- TOC entry 3322 (class 0 OID 17292)
-- Dependencies: 210
-- Data for Name: lotacao; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lotacao (id_lotacao, departamento, sigla) FROM stdin;
1	Louvor	LV
2	Diácono	DC
3	Recepção	RC
4	Intercessão	IT
5	Evangelismo	EV
6	Ensino	ES
7	Missões	MS
8	Comunicação	CM
9	Mídia	MD
10	Ação Social	AS
\.


--
-- TOC entry 3325 (class 0 OID 17300)
-- Dependencies: 213
-- Data for Name: pessoa; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pessoa (id_pessoa, cpf, nome, dt_nascimento, telefone, id_lotacao, dt_membro) FROM stdin;
232	10024233846	Ana Costa	1985-01-23	(46) 93574-3582	1	2000-01-23
233	07720900766	Carlos Lima	1990-02-14	(38) 92872-6382	2	2007-02-14
234	87439921887	Mariana Souza	1982-03-25	(41) 92362-1508	3	1999-03-25
235	36554570810	Roberto Silva	1995-04-16	(95) 93572-4728	4	2025-04-16
236	16058696941	Juliana Ferreira	1988-05-07	(89) 93610-2141	5	2005-05-07
237	87232140401	Fernanda Oliveira	1993-06-18	(86) 93337-1196	6	2020-06-18
238	57614756185	Luiz Santos	1980-07-29	(91) 92874-5857	7	2005-07-29
239	41849282854	Tatiane Almeida	1991-08-10	(87) 93345-7571	8	2010-08-10
240	75997172422	Pedro Andrade	1984-09-21	(41) 92029-3135	9	1999-09-21
241	33558223292	Claudia Ribeiro	1986-10-12	(28) 93408-8396	10	2005-10-12
242	56033245547	Roberta Martins	1992-11-23	(83) 93169-1501	1	2021-11-23
243	09324283804	Tiago Pereira	1987-12-14	(64) 92484-1322	2	2007-12-14
244	76330738530	Marcos Lima	1994-01-25	(79) 93771-0207	3	2021-01-25
245	74020010919	Camila Santos	1981-02-16	(54) 92553-5361	4	1996-02-16
246	43694984224	Julio Silva	1989-03-07	(97) 92312-5304	5	2008-03-07
247	26921723020	Bruna Oliveira	1990-04-18	(37) 92549-8277	6	2010-04-18
248	84182665546	Eduardo Costa	1982-05-29	(82) 93612-1702	7	1999-05-29
249	61284256405	Aline Almeida	1988-06-10	(82) 92336-2226	8	2003-06-10
250	07949908190	Ricardo Martins	1995-07-21	(87) 92556-9167	9	2025-07-21
251	27220731531	Tatiane Ferreira	1984-08-12	(95) 93741-6411	10	2000-08-12
252	99799534704	Paulo Lima	1983-09-23	(46) 93574-3582	1	2003-09-23
253	75070112325	Larissa Souza	1992-10-14	(38) 92872-6382	2	2022-10-14
254	89318166184	João Pereira	1986-11-25	(41) 92362-1508	3	2001-11-25
255	12389850685	Júlia Costa	1987-12-16	(95) 93572-4728	4	2005-12-16
256	67288112810	Gabriel Santos	1994-01-07	(89) 93610-2141	5	2020-01-07
257	37488632095	Vanessa Oliveira	1991-02-18	(86) 93337-1196	6	2011-02-18
258	92968549200	Mateus Ribeiro	1988-03-29	(91) 92874-5857	7	2006-03-29
259	26318907106	Isabela Almeida	1985-04-10	(87) 93345-7571	8	2000-04-10
260	51702385841	Leonardo Silva	1993-05-21	(41) 92029-3135	9	2013-05-21
261	36341789653	Sofia Costa	1990-06-12	(28) 93408-8396	10	2010-06-12
\.


--
-- TOC entry 3334 (class 0 OID 0)
-- Dependencies: 209
-- Name: lotacao_id_lotacao_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lotacao_id_lotacao_seq', 10, true);


--
-- TOC entry 3335 (class 0 OID 0)
-- Dependencies: 212
-- Name: pessoa_id_lotacao_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pessoa_id_lotacao_seq', 1, false);


--
-- TOC entry 3336 (class 0 OID 0)
-- Dependencies: 211
-- Name: pessoa_id_pessoa_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pessoa_id_pessoa_seq', 261, true);


--
-- TOC entry 3176 (class 2606 OID 17297)
-- Name: lotacao lotacao_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lotacao
    ADD CONSTRAINT lotacao_pkey PRIMARY KEY (id_lotacao);


--
-- TOC entry 3180 (class 2606 OID 17306)
-- Name: pessoa pessoa_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pessoa
    ADD CONSTRAINT pessoa_pkey PRIMARY KEY (id_pessoa);


--
-- TOC entry 3178 (class 2606 OID 17313)
-- Name: lotacao unique_sigla; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lotacao
    ADD CONSTRAINT unique_sigla UNIQUE (sigla);


--
-- TOC entry 3181 (class 2606 OID 17307)
-- Name: pessoa pessoa_id_lotacao_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pessoa
    ADD CONSTRAINT pessoa_id_lotacao_fkey FOREIGN KEY (id_lotacao) REFERENCES public.lotacao(id_lotacao);


-- Completed on 2024-08-23 20:10:54

--
-- PostgreSQL database dump complete
--

