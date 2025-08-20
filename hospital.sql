--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3
-- Dumped by pg_dump version 16.3

-- Started on 2025-08-20 22:18:58

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
-- TOC entry 215 (class 1259 OID 16862)
-- Name: administrator; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.administrator (
    username character varying(10) NOT NULL,
    password character varying(20) NOT NULL,
    firstname character varying(50) NOT NULL,
    lastname character varying(50) NOT NULL,
    email character varying(20) NOT NULL
);


ALTER TABLE public.administrator OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16891)
-- Name: admission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admission (
    admissionid integer NOT NULL,
    admissiontype integer NOT NULL,
    department integer NOT NULL,
    patient character varying(10) NOT NULL,
    administrator character varying(10) NOT NULL,
    fee numeric(7,2),
    dischargedate date,
    condition character varying(500)
);


ALTER TABLE public.admission OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16890)
-- Name: admission_admissionid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.admission_admissionid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.admission_admissionid_seq OWNER TO postgres;

--
-- TOC entry 4883 (class 0 OID 0)
-- Dependencies: 221
-- Name: admission_admissionid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.admission_admissionid_seq OWNED BY public.admission.admissionid;


--
-- TOC entry 218 (class 1259 OID 16873)
-- Name: admissiontype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admissiontype (
    admissiontypeid integer NOT NULL,
    admissiontypename character varying(20) NOT NULL
);


ALTER TABLE public.admissiontype OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16872)
-- Name: admissiontype_admissiontypeid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.admissiontype_admissiontypeid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.admissiontype_admissiontypeid_seq OWNER TO postgres;

--
-- TOC entry 4884 (class 0 OID 0)
-- Dependencies: 217
-- Name: admissiontype_admissiontypeid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.admissiontype_admissiontypeid_seq OWNED BY public.admissiontype.admissiontypeid;


--
-- TOC entry 220 (class 1259 OID 16882)
-- Name: department; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.department (
    deptid integer NOT NULL,
    deptname character varying(20) NOT NULL
);


ALTER TABLE public.department OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16881)
-- Name: department_deptid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.department_deptid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.department_deptid_seq OWNER TO postgres;

--
-- TOC entry 4885 (class 0 OID 0)
-- Dependencies: 219
-- Name: department_deptid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.department_deptid_seq OWNED BY public.department.deptid;


--
-- TOC entry 216 (class 1259 OID 16867)
-- Name: patient; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.patient (
    patientid character varying(10) NOT NULL,
    password character varying(20) NOT NULL,
    firstname character varying(50) NOT NULL,
    lastname character varying(50) NOT NULL,
    mobile character varying(20) NOT NULL
);


ALTER TABLE public.patient OWNER TO postgres;

--
-- TOC entry 4708 (class 2604 OID 16894)
-- Name: admission admissionid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admission ALTER COLUMN admissionid SET DEFAULT nextval('public.admission_admissionid_seq'::regclass);


--
-- TOC entry 4706 (class 2604 OID 16876)
-- Name: admissiontype admissiontypeid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admissiontype ALTER COLUMN admissiontypeid SET DEFAULT nextval('public.admissiontype_admissiontypeid_seq'::regclass);


--
-- TOC entry 4707 (class 2604 OID 16885)
-- Name: department deptid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department ALTER COLUMN deptid SET DEFAULT nextval('public.department_deptid_seq'::regclass);


--
-- TOC entry 4870 (class 0 OID 16862)
-- Dependencies: 215
-- Data for Name: administrator; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.administrator VALUES ('jdoe', 'Pass1234', 'John', 'Doe', 'jdoe@csh.com');
INSERT INTO public.administrator VALUES ('jsmith', 'Pass5678', 'Jane', 'Smith', 'jsmith@csh.com');
INSERT INTO public.administrator VALUES ('ajohnson', 'Passabcd', 'Alice', 'Johnson', 'ajohnson@csh.com');
INSERT INTO public.administrator VALUES ('bbrown', 'Passwxyz', 'Bob', 'Brown', 'bbrown@csh.com');
INSERT INTO public.administrator VALUES ('cdavis', 'Pass9876', 'Charlie', 'Davis', 'cdavis@csh.com');
INSERT INTO public.administrator VALUES ('ksmith', 'Pass5566', 'Karen', 'Smith', 'ksmith@csh.com');


--
-- TOC entry 4877 (class 0 OID 16891)
-- Dependencies: 222
-- Data for Name: admission; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.admission VALUES (1, 4, 1, 'lroberts', 'jdoe', 666.00, '2024-02-28', 'a red patch on my skin that looks irritated. It started small but has been spreading and feels warm to the touch');
INSERT INTO public.admission VALUES (2, 2, 1, 'gthomas', 'jdoe', 100.00, '2021-09-11', NULL);
INSERT INTO public.admission VALUES (3, 1, 2, 'lroberts', 'jsmith', NULL, '2019-09-02', 'Admitted to the emergency department after suffering head trauma from a fall, requiring a CT scan and observation for potential concussion.');
INSERT INTO public.admission VALUES (4, 2, 3, 'dwilson', 'ajohnson', 7688.00, '2022-12-01', NULL);
INSERT INTO public.admission VALUES (5, 2, 6, 'faderson', 'ajohnson', 1600.00, '2014-09-03', 'Child admitted to the hospital with a severe asthma attack, requiring oxygen therapy and nebulizer treatment.');
INSERT INTO public.admission VALUES (6, 4, 1, 'gthomas', 'ksmith', 90.00, '2021-07-04', 'Routine follow-up consultation to review progress after recent knee surgery, with positive recovery observed.');
INSERT INTO public.admission VALUES (7, 1, 2, 'smartinez', 'jsmith', 1450.00, NULL, 'Admitted to the emergency department with severe food poisoning, requiring IV fluids and anti-nausea medication for recovery.');
INSERT INTO public.admission VALUES (8, 4, 5, 'dwilson', 'cdavis', 180.95, '2021-11-06', 'Attended a physiotherapy session as part of an ongoing rehabilitation program following shoulder surgery.');
INSERT INTO public.admission VALUES (9, 3, 1, 'etylor', 'ajohnson', 2000.00, '2021-09-10', NULL);
INSERT INTO public.admission VALUES (10, 2, 4, 'gthomas', 'jsmith', 8290.00, '2024-09-01', 'Postpartum care following a natural childbirth, including monitoring of both the mother and the newborn for potential complications.');
INSERT INTO public.admission VALUES (11, 2, 6, 'faderson', 'bbrown', 1800.00, NULL, 'Child admitted to the paediatrics department for severe pneumonia, requiring intravenous antibiotics and respiratory therapy.');
INSERT INTO public.admission VALUES (12, 4, 1, 'gthomas', 'bbrown', 75.00, '2023-11-19', 'Routine general practitioner consultation for a follow-up after a recent bout of seasonal allergies.');
INSERT INTO public.admission VALUES (13, 3, 3, 'smartinez', 'jdoe', 7000.50, '2024-10-15', NULL);
INSERT INTO public.admission VALUES (14, 1, 2, 'etylor', 'jdoe', NULL, NULL, 'I am having intense, crushing pain in my chest that feels like an elephant is sitting on it. It is spreading to my left arm and neck.');


--
-- TOC entry 4873 (class 0 OID 16873)
-- Dependencies: 218
-- Data for Name: admissiontype; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.admissiontype VALUES (1, 'Emergency');
INSERT INTO public.admissiontype VALUES (2, 'Transfer');
INSERT INTO public.admissiontype VALUES (3, 'Inpatient');
INSERT INTO public.admissiontype VALUES (4, 'Outpatient');


--
-- TOC entry 4875 (class 0 OID 16882)
-- Dependencies: 220
-- Data for Name: department; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.department VALUES (1, 'General');
INSERT INTO public.department VALUES (2, 'Emergency');
INSERT INTO public.department VALUES (3, 'Surgery');
INSERT INTO public.department VALUES (4, 'Obstetrics');
INSERT INTO public.department VALUES (5, 'Rehabilitation');
INSERT INTO public.department VALUES (6, 'Paediatrics');


--
-- TOC entry 4871 (class 0 OID 16867)
-- Dependencies: 216
-- Data for Name: patient; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.patient VALUES ('dwilson', 'Pass5432', 'David', 'Wilson', '4455667788');
INSERT INTO public.patient VALUES ('etylor', 'Passlmno', 'Eva', 'Taylor', '5566778899');
INSERT INTO public.patient VALUES ('faderson', 'Passrstu', 'Frank', 'Anderson', '6677889900');
INSERT INTO public.patient VALUES ('gthomas', 'Pass1357', 'Grace', 'Thomas', '7788990011');
INSERT INTO public.patient VALUES ('smartinez', 'Pass2468', 'Stan', 'Martinez', '8899001122');
INSERT INTO public.patient VALUES ('lroberts', 'Pass1122', 'Laura', 'Roberts', '9900112233');


--
-- TOC entry 4886 (class 0 OID 0)
-- Dependencies: 221
-- Name: admission_admissionid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.admission_admissionid_seq', 14, true);


--
-- TOC entry 4887 (class 0 OID 0)
-- Dependencies: 217
-- Name: admissiontype_admissiontypeid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.admissiontype_admissiontypeid_seq', 1, false);


--
-- TOC entry 4888 (class 0 OID 0)
-- Dependencies: 219
-- Name: department_deptid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.department_deptid_seq', 1, false);


--
-- TOC entry 4710 (class 2606 OID 16866)
-- Name: administrator administrator_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.administrator
    ADD CONSTRAINT administrator_pkey PRIMARY KEY (username);


--
-- TOC entry 4722 (class 2606 OID 16898)
-- Name: admission admission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admission
    ADD CONSTRAINT admission_pkey PRIMARY KEY (admissionid);


--
-- TOC entry 4714 (class 2606 OID 16880)
-- Name: admissiontype admissiontype_admissiontypename_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admissiontype
    ADD CONSTRAINT admissiontype_admissiontypename_key UNIQUE (admissiontypename);


--
-- TOC entry 4716 (class 2606 OID 16878)
-- Name: admissiontype admissiontype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admissiontype
    ADD CONSTRAINT admissiontype_pkey PRIMARY KEY (admissiontypeid);


--
-- TOC entry 4718 (class 2606 OID 16889)
-- Name: department department_deptname_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_deptname_key UNIQUE (deptname);


--
-- TOC entry 4720 (class 2606 OID 16887)
-- Name: department department_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.department
    ADD CONSTRAINT department_pkey PRIMARY KEY (deptid);


--
-- TOC entry 4712 (class 2606 OID 16871)
-- Name: patient patient_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patient
    ADD CONSTRAINT patient_pkey PRIMARY KEY (patientid);


--
-- TOC entry 4723 (class 2606 OID 16914)
-- Name: admission admission_administrator_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admission
    ADD CONSTRAINT admission_administrator_fkey FOREIGN KEY (administrator) REFERENCES public.administrator(username);


--
-- TOC entry 4724 (class 2606 OID 16899)
-- Name: admission admission_admissiontype_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admission
    ADD CONSTRAINT admission_admissiontype_fkey FOREIGN KEY (admissiontype) REFERENCES public.admissiontype(admissiontypeid);


--
-- TOC entry 4725 (class 2606 OID 16904)
-- Name: admission admission_department_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admission
    ADD CONSTRAINT admission_department_fkey FOREIGN KEY (department) REFERENCES public.department(deptid);


--
-- TOC entry 4726 (class 2606 OID 16909)
-- Name: admission admission_patient_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admission
    ADD CONSTRAINT admission_patient_fkey FOREIGN KEY (patient) REFERENCES public.patient(patientid);


-- Completed on 2025-08-20 22:18:58

--
-- PostgreSQL database dump complete
--

