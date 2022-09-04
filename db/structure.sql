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
-- Name: activity_factors; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.activity_factors (
    id bigint NOT NULL,
    name character varying,
    description text,
    value numeric(8,3),
    created_by_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: activity_factors_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.activity_factors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: activity_factors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.activity_factors_id_seq OWNED BY public.activity_factors.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: billing_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.billing_items (
    id bigint NOT NULL,
    description character varying,
    item_type integer DEFAULT 0,
    quantity integer DEFAULT 1,
    amount numeric(8,2) DEFAULT 0.0,
    total numeric(8,2) DEFAULT 0.0,
    billing_id bigint NOT NULL,
    itemable_type character varying,
    itemable_id bigint,
    status integer DEFAULT 0,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: billing_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.billing_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: billing_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.billing_items_id_seq OWNED BY public.billing_items.id;


--
-- Name: billings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.billings (
    id bigint NOT NULL,
    sub_total numeric(8,2) DEFAULT 0.0,
    total numeric(8,2) DEFAULT 0.0,
    description character varying,
    code character varying,
    billing_type integer DEFAULT 0,
    dietitian_id bigint,
    patient_id bigint NOT NULL,
    created_by_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: billings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.billings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: billings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.billings_id_seq OWNED BY public.billings.id;


--
-- Name: discounts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.discounts (
    id bigint NOT NULL,
    name character varying NOT NULL,
    description character varying,
    discount_type integer DEFAULT 0,
    amount numeric(8,2) DEFAULT 0.0,
    status integer DEFAULT 0,
    created_by_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: discounts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.discounts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: discounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.discounts_id_seq OWNED BY public.discounts.id;


--
-- Name: genders; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.genders (
    id bigint NOT NULL,
    name character varying,
    description text,
    created_by_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: genders_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.genders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: genders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.genders_id_seq OWNED BY public.genders.id;


--
-- Name: indicator_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.indicator_types (
    id bigint NOT NULL,
    name text,
    description character varying,
    created_by_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: indicator_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.indicator_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: indicator_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.indicator_types_id_seq OWNED BY public.indicator_types.id;


--
-- Name: indicators; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.indicators (
    id bigint NOT NULL,
    value_min numeric(8,2),
    value_max numeric(8,2),
    description character varying,
    "position" integer,
    gender_id bigint NOT NULL,
    indicator_type_id bigint NOT NULL,
    created_by_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: indicators_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.indicators_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: indicators_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.indicators_id_seq OWNED BY public.indicators.id;


--
-- Name: packages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.packages (
    id bigint NOT NULL,
    name character varying,
    description character varying,
    weeks integer,
    price numeric(8,2),
    status integer DEFAULT 0,
    created_by_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: packages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.packages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: packages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.packages_id_seq OWNED BY public.packages.id;


--
-- Name: patient_packages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.patient_packages (
    id bigint NOT NULL,
    package_id bigint NOT NULL,
    patient_id bigint NOT NULL,
    date date,
    status integer DEFAULT 0,
    dietitian_id integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: patient_packages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.patient_packages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: patient_packages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.patient_packages_id_seq OWNED BY public.patient_packages.id;


--
-- Name: patients; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.patients (
    id bigint NOT NULL,
    first_name character varying,
    last_name character varying,
    slug character varying,
    age integer,
    date_of_bird date,
    gender_id integer NOT NULL,
    dietitian_id bigint NOT NULL,
    status integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    searchable tsvector GENERATED ALWAYS AS ((setweight(to_tsvector('english'::regconfig, (COALESCE(first_name, ''::character varying))::text), 'A'::"char") || setweight(to_tsvector('english'::regconfig, (COALESCE(last_name, ''::character varying))::text), 'B'::"char"))) STORED
);


--
-- Name: patients_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.patients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: patients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.patients_id_seq OWNED BY public.patients.id;


--
-- Name: payment_billing_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payment_billing_items (
    id bigint NOT NULL,
    payment_id bigint NOT NULL,
    billing_item_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: payment_billing_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.payment_billing_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: payment_billing_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.payment_billing_items_id_seq OWNED BY public.payment_billing_items.id;


--
-- Name: payments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payments (
    id bigint NOT NULL,
    status integer,
    code character varying,
    dietitian_id bigint,
    billing_id bigint NOT NULL,
    created_by_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: payments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.payments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.payments_id_seq OWNED BY public.payments.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.products (
    id bigint NOT NULL,
    name character varying NOT NULL,
    description character varying,
    code character varying,
    price numeric(8,2) DEFAULT 0.0,
    new_price numeric(8,2) DEFAULT 0.0,
    status integer DEFAULT 0,
    created_by_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.roles (
    id bigint NOT NULL,
    name character varying,
    description text,
    created_by_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sessions (
    id bigint NOT NULL,
    weight numeric(8,2),
    height numeric(8,2),
    waist numeric(8,2),
    hip numeric(8,2),
    high_abdomen numeric(8,2),
    low_abdomen numeric(8,2),
    imc numeric(8,2),
    ideal_weight numeric(8,2),
    body_grease numeric(8,2),
    visceral_grease numeric(8,2),
    muscle_mass numeric(8,2),
    bone_mass numeric(8,2),
    water_percentage integer,
    bmr integer,
    metabolic_age integer,
    physical_complexion integer,
    date date,
    patient_id bigint NOT NULL,
    patient_package_id bigint NOT NULL,
    dietitian_id integer,
    activity_factor_id integer,
    created_by_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: sessions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.sessions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sessions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.sessions_id_seq OWNED BY public.sessions.id;


--
-- Name: user_roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_roles (
    id bigint NOT NULL,
    user_id bigint,
    role_id bigint,
    created_by_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: user_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_roles_id_seq OWNED BY public.user_roles.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    first_name character varying NOT NULL,
    last_name character varying NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    patient_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: activity_factors id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.activity_factors ALTER COLUMN id SET DEFAULT nextval('public.activity_factors_id_seq'::regclass);


--
-- Name: billing_items id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.billing_items ALTER COLUMN id SET DEFAULT nextval('public.billing_items_id_seq'::regclass);


--
-- Name: billings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.billings ALTER COLUMN id SET DEFAULT nextval('public.billings_id_seq'::regclass);


--
-- Name: discounts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.discounts ALTER COLUMN id SET DEFAULT nextval('public.discounts_id_seq'::regclass);


--
-- Name: genders id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.genders ALTER COLUMN id SET DEFAULT nextval('public.genders_id_seq'::regclass);


--
-- Name: indicator_types id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.indicator_types ALTER COLUMN id SET DEFAULT nextval('public.indicator_types_id_seq'::regclass);


--
-- Name: indicators id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.indicators ALTER COLUMN id SET DEFAULT nextval('public.indicators_id_seq'::regclass);


--
-- Name: packages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.packages ALTER COLUMN id SET DEFAULT nextval('public.packages_id_seq'::regclass);


--
-- Name: patient_packages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.patient_packages ALTER COLUMN id SET DEFAULT nextval('public.patient_packages_id_seq'::regclass);


--
-- Name: patients id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.patients ALTER COLUMN id SET DEFAULT nextval('public.patients_id_seq'::regclass);


--
-- Name: payment_billing_items id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_billing_items ALTER COLUMN id SET DEFAULT nextval('public.payment_billing_items_id_seq'::regclass);


--
-- Name: payments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments ALTER COLUMN id SET DEFAULT nextval('public.payments_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: sessions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions ALTER COLUMN id SET DEFAULT nextval('public.sessions_id_seq'::regclass);


--
-- Name: user_roles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_roles ALTER COLUMN id SET DEFAULT nextval('public.user_roles_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: activity_factors activity_factors_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.activity_factors
    ADD CONSTRAINT activity_factors_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: billing_items billing_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.billing_items
    ADD CONSTRAINT billing_items_pkey PRIMARY KEY (id);


--
-- Name: billings billings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.billings
    ADD CONSTRAINT billings_pkey PRIMARY KEY (id);


--
-- Name: discounts discounts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.discounts
    ADD CONSTRAINT discounts_pkey PRIMARY KEY (id);


--
-- Name: genders genders_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.genders
    ADD CONSTRAINT genders_pkey PRIMARY KEY (id);


--
-- Name: indicator_types indicator_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.indicator_types
    ADD CONSTRAINT indicator_types_pkey PRIMARY KEY (id);


--
-- Name: indicators indicators_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.indicators
    ADD CONSTRAINT indicators_pkey PRIMARY KEY (id);


--
-- Name: packages packages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.packages
    ADD CONSTRAINT packages_pkey PRIMARY KEY (id);


--
-- Name: patient_packages patient_packages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.patient_packages
    ADD CONSTRAINT patient_packages_pkey PRIMARY KEY (id);


--
-- Name: patients patients_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.patients
    ADD CONSTRAINT patients_pkey PRIMARY KEY (id);


--
-- Name: payment_billing_items payment_billing_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_billing_items
    ADD CONSTRAINT payment_billing_items_pkey PRIMARY KEY (id);


--
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: user_roles user_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_activity_factors_on_created_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_activity_factors_on_created_by_id ON public.activity_factors USING btree (created_by_id);


--
-- Name: index_billing_items_on_billing_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_billing_items_on_billing_id ON public.billing_items USING btree (billing_id);


--
-- Name: index_billing_items_on_itemable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_billing_items_on_itemable ON public.billing_items USING btree (itemable_type, itemable_id);


--
-- Name: index_billings_on_created_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_billings_on_created_by_id ON public.billings USING btree (created_by_id);


--
-- Name: index_billings_on_dietitian_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_billings_on_dietitian_id ON public.billings USING btree (dietitian_id);


--
-- Name: index_billings_on_patient_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_billings_on_patient_id ON public.billings USING btree (patient_id);


--
-- Name: index_discounts_on_created_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_discounts_on_created_by_id ON public.discounts USING btree (created_by_id);


--
-- Name: index_genders_on_created_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_genders_on_created_by_id ON public.genders USING btree (created_by_id);


--
-- Name: index_indicator_types_on_created_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_indicator_types_on_created_by_id ON public.indicator_types USING btree (created_by_id);


--
-- Name: index_indicators_on_created_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_indicators_on_created_by_id ON public.indicators USING btree (created_by_id);


--
-- Name: index_indicators_on_gender_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_indicators_on_gender_id ON public.indicators USING btree (gender_id);


--
-- Name: index_indicators_on_indicator_type_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_indicators_on_indicator_type_id ON public.indicators USING btree (indicator_type_id);


--
-- Name: index_packages_on_created_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_packages_on_created_by_id ON public.packages USING btree (created_by_id);


--
-- Name: index_patient_packages_on_dietitian_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_patient_packages_on_dietitian_id ON public.patient_packages USING btree (dietitian_id);


--
-- Name: index_patient_packages_on_package_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_patient_packages_on_package_id ON public.patient_packages USING btree (package_id);


--
-- Name: index_patient_packages_on_patient_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_patient_packages_on_patient_id ON public.patient_packages USING btree (patient_id);


--
-- Name: index_patients_on_dietitian_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_patients_on_dietitian_id ON public.patients USING btree (dietitian_id);


--
-- Name: index_patients_on_searchable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_patients_on_searchable ON public.patients USING gin (searchable);


--
-- Name: index_payment_billing_items_on_billing_item_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_payment_billing_items_on_billing_item_id ON public.payment_billing_items USING btree (billing_item_id);


--
-- Name: index_payment_billing_items_on_payment_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_payment_billing_items_on_payment_id ON public.payment_billing_items USING btree (payment_id);


--
-- Name: index_payments_on_billing_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_payments_on_billing_id ON public.payments USING btree (billing_id);


--
-- Name: index_payments_on_created_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_payments_on_created_by_id ON public.payments USING btree (created_by_id);


--
-- Name: index_payments_on_dietitian_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_payments_on_dietitian_id ON public.payments USING btree (dietitian_id);


--
-- Name: index_products_on_created_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_products_on_created_by_id ON public.products USING btree (created_by_id);


--
-- Name: index_roles_on_created_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_roles_on_created_by_id ON public.roles USING btree (created_by_id);


--
-- Name: index_sessions_on_created_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_sessions_on_created_by_id ON public.sessions USING btree (created_by_id);


--
-- Name: index_sessions_on_dietitian_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_sessions_on_dietitian_id ON public.sessions USING btree (dietitian_id);


--
-- Name: index_sessions_on_patient_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_sessions_on_patient_id ON public.sessions USING btree (patient_id);


--
-- Name: index_sessions_on_patient_package_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_sessions_on_patient_package_id ON public.sessions USING btree (patient_package_id);


--
-- Name: index_user_roles_on_created_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_user_roles_on_created_by_id ON public.user_roles USING btree (created_by_id);


--
-- Name: index_user_roles_on_role_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_user_roles_on_role_id ON public.user_roles USING btree (role_id);


--
-- Name: index_user_roles_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_user_roles_on_user_id ON public.user_roles USING btree (user_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_patient_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_patient_id ON public.users USING btree (patient_id);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: billings fk_rails_03463ff770; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.billings
    ADD CONSTRAINT fk_rails_03463ff770 FOREIGN KEY (created_by_id) REFERENCES public.users(id);


--
-- Name: sessions fk_rails_06dd15b0cb; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT fk_rails_06dd15b0cb FOREIGN KEY (created_by_id) REFERENCES public.users(id);


--
-- Name: sessions fk_rails_1c002106d8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT fk_rails_1c002106d8 FOREIGN KEY (patient_package_id) REFERENCES public.patient_packages(id);


--
-- Name: payments fk_rails_1fb182b99e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT fk_rails_1fb182b99e FOREIGN KEY (created_by_id) REFERENCES public.users(id);


--
-- Name: user_roles fk_rails_318345354e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT fk_rails_318345354e FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: user_roles fk_rails_3369e0d5fc; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT fk_rails_3369e0d5fc FOREIGN KEY (role_id) REFERENCES public.roles(id);


--
-- Name: packages fk_rails_438d68f470; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.packages
    ADD CONSTRAINT fk_rails_438d68f470 FOREIGN KEY (created_by_id) REFERENCES public.users(id);


--
-- Name: payment_billing_items fk_rails_54ccdfeceb; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_billing_items
    ADD CONSTRAINT fk_rails_54ccdfeceb FOREIGN KEY (billing_item_id) REFERENCES public.billing_items(id);


--
-- Name: patients fk_rails_57d37f5f60; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.patients
    ADD CONSTRAINT fk_rails_57d37f5f60 FOREIGN KEY (dietitian_id) REFERENCES public.users(id);


--
-- Name: patient_packages fk_rails_607b3bce29; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.patient_packages
    ADD CONSTRAINT fk_rails_607b3bce29 FOREIGN KEY (patient_id) REFERENCES public.patients(id);


--
-- Name: billings fk_rails_68db0bce0b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.billings
    ADD CONSTRAINT fk_rails_68db0bce0b FOREIGN KEY (patient_id) REFERENCES public.patients(id);


--
-- Name: payments fk_rails_77edb17a11; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT fk_rails_77edb17a11 FOREIGN KEY (dietitian_id) REFERENCES public.users(id);


--
-- Name: indicators fk_rails_800b3b2974; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.indicators
    ADD CONSTRAINT fk_rails_800b3b2974 FOREIGN KEY (created_by_id) REFERENCES public.users(id);


--
-- Name: payments fk_rails_837047548b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT fk_rails_837047548b FOREIGN KEY (billing_id) REFERENCES public.billings(id);


--
-- Name: indicators fk_rails_87e1e553c1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.indicators
    ADD CONSTRAINT fk_rails_87e1e553c1 FOREIGN KEY (indicator_type_id) REFERENCES public.indicator_types(id);


--
-- Name: payment_billing_items fk_rails_91651f5469; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_billing_items
    ADD CONSTRAINT fk_rails_91651f5469 FOREIGN KEY (payment_id) REFERENCES public.payments(id);


--
-- Name: user_roles fk_rails_983264fab9; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT fk_rails_983264fab9 FOREIGN KEY (created_by_id) REFERENCES public.users(id);


--
-- Name: discounts fk_rails_ac5b431054; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.discounts
    ADD CONSTRAINT fk_rails_ac5b431054 FOREIGN KEY (created_by_id) REFERENCES public.users(id);


--
-- Name: products fk_rails_aefb4f3a33; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT fk_rails_aefb4f3a33 FOREIGN KEY (created_by_id) REFERENCES public.users(id);


--
-- Name: sessions fk_rails_b1767efc49; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT fk_rails_b1767efc49 FOREIGN KEY (patient_id) REFERENCES public.patients(id);


--
-- Name: roles fk_rails_b41292c88f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT fk_rails_b41292c88f FOREIGN KEY (created_by_id) REFERENCES public.users(id);


--
-- Name: billings fk_rails_cf7922da93; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.billings
    ADD CONSTRAINT fk_rails_cf7922da93 FOREIGN KEY (dietitian_id) REFERENCES public.users(id);


--
-- Name: billing_items fk_rails_e41b35a10a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.billing_items
    ADD CONSTRAINT fk_rails_e41b35a10a FOREIGN KEY (billing_id) REFERENCES public.billings(id);


--
-- Name: activity_factors fk_rails_e577712133; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.activity_factors
    ADD CONSTRAINT fk_rails_e577712133 FOREIGN KEY (created_by_id) REFERENCES public.users(id);


--
-- Name: genders fk_rails_f673e6b598; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.genders
    ADD CONSTRAINT fk_rails_f673e6b598 FOREIGN KEY (created_by_id) REFERENCES public.users(id);


--
-- Name: patient_packages fk_rails_f7b95554e5; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.patient_packages
    ADD CONSTRAINT fk_rails_f7b95554e5 FOREIGN KEY (package_id) REFERENCES public.packages(id);


--
-- Name: indicator_types fk_rails_f8a203afce; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.indicator_types
    ADD CONSTRAINT fk_rails_f8a203afce FOREIGN KEY (created_by_id) REFERENCES public.users(id);


--
-- Name: indicators fk_rails_fb5b988de2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.indicators
    ADD CONSTRAINT fk_rails_fb5b988de2 FOREIGN KEY (gender_id) REFERENCES public.genders(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20210509221320'),
('20210509221321'),
('20210509221513'),
('20210510172855'),
('20210510193801'),
('20210515174948'),
('20210515174951'),
('20210518183902'),
('20210518184055'),
('20210518184058'),
('20210523031431'),
('20220828212844'),
('20220828212915'),
('20220828213037'),
('20220828213039'),
('20220828213040'),
('20220828213041'),
('20220904011508'),
('20220904013013');


