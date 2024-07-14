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
-- Name: active_storage_attachments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.active_storage_attachments (
    id bigint NOT NULL,
    name character varying NOT NULL,
    record_type character varying NOT NULL,
    record_id bigint NOT NULL,
    blob_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL
);


--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.active_storage_attachments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.active_storage_attachments_id_seq OWNED BY public.active_storage_attachments.id;


--
-- Name: active_storage_blobs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.active_storage_blobs (
    id bigint NOT NULL,
    key character varying NOT NULL,
    filename character varying NOT NULL,
    content_type character varying,
    metadata text,
    service_name character varying NOT NULL,
    byte_size bigint NOT NULL,
    checksum character varying NOT NULL,
    created_at timestamp without time zone NOT NULL
);


--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.active_storage_blobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.active_storage_blobs_id_seq OWNED BY public.active_storage_blobs.id;


--
-- Name: active_storage_variant_records; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.active_storage_variant_records (
    id bigint NOT NULL,
    blob_id bigint NOT NULL,
    variation_digest character varying NOT NULL
);


--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.active_storage_variant_records_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.active_storage_variant_records_id_seq OWNED BY public.active_storage_variant_records.id;


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
-- Name: appointment_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.appointment_settings (
    id bigint NOT NULL,
    dietitian_id bigint NOT NULL,
    time_step integer DEFAULT 5 NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: appointment_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.appointment_settings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: appointment_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.appointment_settings_id_seq OWNED BY public.appointment_settings.id;


--
-- Name: appointments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.appointments (
    id bigint NOT NULL,
    start_date date,
    time_start time without time zone,
    time_end time without time zone,
    status integer DEFAULT 0 NOT NULL,
    dietitian_id bigint NOT NULL,
    patient_id bigint NOT NULL,
    appointment_type integer DEFAULT 0 NOT NULL,
    title character varying DEFAULT ''::character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: appointments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.appointments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: appointments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.appointments_id_seq OWNED BY public.appointments.id;


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
-- Name: availabilities; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.availabilities (
    id bigint NOT NULL,
    time_start time without time zone,
    time_end time without time zone,
    dietitian_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: availabilities_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.availabilities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: availabilities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.availabilities_id_seq OWNED BY public.availabilities.id;


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
    total_conversion numeric(8,2) DEFAULT 0.0 NOT NULL,
    target_conversion numeric(8,2) DEFAULT 0.0 NOT NULL,
    target_currency character varying DEFAULT 'VES'::character varying NOT NULL,
    target_currency_code character varying DEFAULT 'Bs'::character varying NOT NULL,
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
    total numeric(8,2) DEFAULT 0.0,
    sub_total numeric(8,2) DEFAULT 0.0,
    total_conversion numeric(8,2) DEFAULT 0.0 NOT NULL,
    sub_total_conversion numeric(8,2) DEFAULT 0.0 NOT NULL,
    target_conversion numeric(8,2) DEFAULT 0.0 NOT NULL,
    target_currency character varying DEFAULT 'VES'::character varying NOT NULL,
    target_currency_code character varying DEFAULT 'Bs'::character varying NOT NULL,
    description character varying,
    code character varying,
    billing_type integer DEFAULT 0,
    status integer DEFAULT 0,
    dietitian_id bigint NOT NULL,
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
-- Name: bmr_factors; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.bmr_factors (
    id bigint NOT NULL,
    base_value numeric(8,4),
    base_height numeric(8,4),
    base_weight numeric(8,4),
    base_age numeric(8,4),
    name character varying,
    "position" integer DEFAULT 0 NOT NULL,
    source integer DEFAULT 1 NOT NULL,
    gender_id bigint NOT NULL,
    created_by_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: bmr_factors_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.bmr_factors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: bmr_factors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.bmr_factors_id_seq OWNED BY public.bmr_factors.id;


--
-- Name: comments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.comments (
    id bigint NOT NULL,
    message text,
    seen boolean DEFAULT false,
    comment_type integer DEFAULT 0,
    user_id bigint NOT NULL,
    entry_id integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.comments_id_seq OWNED BY public.comments.id;


--
-- Name: conditions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.conditions (
    id bigint NOT NULL,
    name character varying,
    description character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: conditions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.conditions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: conditions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.conditions_id_seq OWNED BY public.conditions.id;


--
-- Name: contact_us; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.contact_us (
    id bigint NOT NULL,
    email character varying,
    seen boolean DEFAULT false,
    read_by_id bigint,
    first_name character varying,
    last_name character varying,
    string character varying,
    message text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: contact_us_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.contact_us_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: contact_us_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.contact_us_id_seq OWNED BY public.contact_us.id;


--
-- Name: conversations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.conversations (
    id bigint NOT NULL,
    dietitian_id bigint NOT NULL,
    patient_id bigint NOT NULL,
    title character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: conversations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.conversations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: conversations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.conversations_id_seq OWNED BY public.conversations.id;


--
-- Name: diet_ingredients; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.diet_ingredients (
    id bigint NOT NULL,
    diet_meal_time_id bigint,
    meal_id bigint,
    instructions character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: diet_ingredients_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.diet_ingredients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: diet_ingredients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.diet_ingredients_id_seq OWNED BY public.diet_ingredients.id;


--
-- Name: diet_meal_times; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.diet_meal_times (
    id bigint NOT NULL,
    diet_meal_week_id bigint,
    meal_time integer DEFAULT 0,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: diet_meal_times_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.diet_meal_times_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: diet_meal_times_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.diet_meal_times_id_seq OWNED BY public.diet_meal_times.id;


--
-- Name: diet_meal_weeks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.diet_meal_weeks (
    id bigint NOT NULL,
    diet_id bigint,
    day_of_week integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: diet_meal_weeks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.diet_meal_weeks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: diet_meal_weeks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.diet_meal_weeks_id_seq OWNED BY public.diet_meal_weeks.id;


--
-- Name: diets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.diets (
    id bigint NOT NULL,
    name character varying,
    description character varying,
    dietitian_id bigint NOT NULL,
    patient_id bigint NOT NULL,
    session_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: diets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.diets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: diets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.diets_id_seq OWNED BY public.diets.id;


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
-- Name: entries; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.entries (
    id bigint NOT NULL,
    description text,
    seen boolean DEFAULT false,
    entry_type integer DEFAULT 0,
    user_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: entries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.entries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: entries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.entries_id_seq OWNED BY public.entries.id;


--
-- Name: genders; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.genders (
    id bigint NOT NULL,
    name character varying,
    description text,
    created_by_id integer,
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
-- Name: global_configurations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.global_configurations (
    id bigint NOT NULL,
    currency character varying DEFAULT '0'::character varying NOT NULL,
    currency_code character varying DEFAULT '0'::character varying NOT NULL,
    target_currency character varying DEFAULT '1'::character varying NOT NULL,
    target_currency_code character varying DEFAULT '0'::character varying NOT NULL,
    target_conversion numeric(8,2) DEFAULT 1.0,
    bmr_source integer DEFAULT 1 NOT NULL,
    created_by_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: global_configurations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.global_configurations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: global_configurations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.global_configurations_id_seq OWNED BY public.global_configurations.id;


--
-- Name: indicator_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.indicator_types (
    id bigint NOT NULL,
    name character varying,
    description text,
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
    name character varying,
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
-- Name: instant_sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.instant_sessions (
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
    gender_id integer NOT NULL,
    date date,
    activity_factor_id integer,
    created_by_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: instant_sessions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.instant_sessions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: instant_sessions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.instant_sessions_id_seq OWNED BY public.instant_sessions.id;


--
-- Name: meals; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.meals (
    id bigint NOT NULL,
    name character varying,
    type_of_use integer DEFAULT 0,
    meal_type integer DEFAULT 0,
    description character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: meals_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.meals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: meals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.meals_id_seq OWNED BY public.meals.id;


--
-- Name: notes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.notes (
    id bigint NOT NULL,
    message text NOT NULL,
    seen boolean DEFAULT false,
    conversation_id bigint NOT NULL,
    user_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: notes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.notes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.notes_id_seq OWNED BY public.notes.id;


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.notifications (
    id bigint NOT NULL,
    notification_type integer DEFAULT 0,
    seen boolean DEFAULT false,
    content character varying NOT NULL,
    associated_object_type character varying,
    associated_object_id bigint,
    sender_id bigint,
    recipient_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.notifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.notifications_id_seq OWNED BY public.notifications.id;


--
-- Name: organization_memberships; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.organization_memberships (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    organization_id bigint NOT NULL,
    is_admin integer DEFAULT 0,
    org_role character varying DEFAULT 'Standard'::character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: organization_memberships_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.organization_memberships_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: organization_memberships_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.organization_memberships_id_seq OWNED BY public.organization_memberships.id;


--
-- Name: organizations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.organizations (
    id bigint NOT NULL,
    name character varying,
    description text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: organizations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.organizations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: organizations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.organizations_id_seq OWNED BY public.organizations.id;


--
-- Name: packages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.packages (
    id bigint NOT NULL,
    name character varying,
    description character varying,
    weeks integer DEFAULT 0,
    session_quantity integer DEFAULT 0,
    price numeric(8,2),
    status integer DEFAULT 0,
    "position" integer DEFAULT 0,
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
-- Name: patient_conditions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.patient_conditions (
    id bigint NOT NULL,
    patient_id bigint NOT NULL,
    condition_id bigint,
    created_by_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: patient_conditions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.patient_conditions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: patient_conditions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.patient_conditions_id_seq OWNED BY public.patient_conditions.id;


--
-- Name: patient_packages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.patient_packages (
    id bigint NOT NULL,
    package_id bigint NOT NULL,
    patient_id bigint NOT NULL,
    date date,
    status integer DEFAULT 0,
    dietitian_id bigint NOT NULL,
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
    code character varying,
    status integer DEFAULT 0,
    dietitian_id bigint NOT NULL,
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
-- Name: restricted_ingredient_conditions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.restricted_ingredient_conditions (
    id bigint NOT NULL,
    meal_id bigint,
    condition_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: restricted_ingredient_conditions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.restricted_ingredient_conditions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: restricted_ingredient_conditions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.restricted_ingredient_conditions_id_seq OWNED BY public.restricted_ingredient_conditions.id;


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
    age integer,
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
    bmr numeric(8,4),
    metabolic_age integer,
    physical_complexion integer,
    initial boolean,
    date date,
    patient_id bigint NOT NULL,
    patient_package_id bigint NOT NULL,
    dietitian_id bigint NOT NULL,
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
-- Name: socket_clients; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.socket_clients (
    id bigint NOT NULL,
    client_channel_id character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: socket_clients_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.socket_clients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: socket_clients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.socket_clients_id_seq OWNED BY public.socket_clients.id;


--
-- Name: tasks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tasks (
    id bigint NOT NULL,
    title character varying,
    description text,
    status integer DEFAULT 0 NOT NULL,
    dietitian_id bigint NOT NULL,
    patient_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tasks_id_seq OWNED BY public.tasks.id;


--
-- Name: user_roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_roles (
    id bigint NOT NULL,
    user_id bigint,
    role_id bigint,
    created_by_id bigint,
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
    password_digest character varying,
    first_name character varying NOT NULL,
    last_name character varying NOT NULL,
    email character varying DEFAULT ''::character varying,
    username character varying DEFAULT ''::character varying,
    organization_id bigint,
    patient_id bigint,
    slug character varying,
    age integer,
    date_of_birth date,
    gender_id integer,
    status integer,
    bmr_factor_source integer DEFAULT 1,
    dietitian_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    searchable tsvector GENERATED ALWAYS AS ((setweight(to_tsvector('english'::regconfig, COALESCE(lower((first_name)::text), ''::text)), 'A'::"char") || setweight(to_tsvector('english'::regconfig, COALESCE(lower((last_name)::text), ''::text)), 'A'::"char"))) STORED
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
-- Name: active_storage_attachments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_attachments ALTER COLUMN id SET DEFAULT nextval('public.active_storage_attachments_id_seq'::regclass);


--
-- Name: active_storage_blobs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_blobs ALTER COLUMN id SET DEFAULT nextval('public.active_storage_blobs_id_seq'::regclass);


--
-- Name: active_storage_variant_records id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_variant_records ALTER COLUMN id SET DEFAULT nextval('public.active_storage_variant_records_id_seq'::regclass);


--
-- Name: activity_factors id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.activity_factors ALTER COLUMN id SET DEFAULT nextval('public.activity_factors_id_seq'::regclass);


--
-- Name: appointment_settings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.appointment_settings ALTER COLUMN id SET DEFAULT nextval('public.appointment_settings_id_seq'::regclass);


--
-- Name: appointments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.appointments ALTER COLUMN id SET DEFAULT nextval('public.appointments_id_seq'::regclass);


--
-- Name: availabilities id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.availabilities ALTER COLUMN id SET DEFAULT nextval('public.availabilities_id_seq'::regclass);


--
-- Name: billing_items id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.billing_items ALTER COLUMN id SET DEFAULT nextval('public.billing_items_id_seq'::regclass);


--
-- Name: billings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.billings ALTER COLUMN id SET DEFAULT nextval('public.billings_id_seq'::regclass);


--
-- Name: bmr_factors id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bmr_factors ALTER COLUMN id SET DEFAULT nextval('public.bmr_factors_id_seq'::regclass);


--
-- Name: comments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comments ALTER COLUMN id SET DEFAULT nextval('public.comments_id_seq'::regclass);


--
-- Name: conditions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.conditions ALTER COLUMN id SET DEFAULT nextval('public.conditions_id_seq'::regclass);


--
-- Name: contact_us id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contact_us ALTER COLUMN id SET DEFAULT nextval('public.contact_us_id_seq'::regclass);


--
-- Name: conversations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.conversations ALTER COLUMN id SET DEFAULT nextval('public.conversations_id_seq'::regclass);


--
-- Name: diet_ingredients id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.diet_ingredients ALTER COLUMN id SET DEFAULT nextval('public.diet_ingredients_id_seq'::regclass);


--
-- Name: diet_meal_times id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.diet_meal_times ALTER COLUMN id SET DEFAULT nextval('public.diet_meal_times_id_seq'::regclass);


--
-- Name: diet_meal_weeks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.diet_meal_weeks ALTER COLUMN id SET DEFAULT nextval('public.diet_meal_weeks_id_seq'::regclass);


--
-- Name: diets id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.diets ALTER COLUMN id SET DEFAULT nextval('public.diets_id_seq'::regclass);


--
-- Name: discounts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.discounts ALTER COLUMN id SET DEFAULT nextval('public.discounts_id_seq'::regclass);


--
-- Name: entries id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entries ALTER COLUMN id SET DEFAULT nextval('public.entries_id_seq'::regclass);


--
-- Name: genders id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.genders ALTER COLUMN id SET DEFAULT nextval('public.genders_id_seq'::regclass);


--
-- Name: global_configurations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.global_configurations ALTER COLUMN id SET DEFAULT nextval('public.global_configurations_id_seq'::regclass);


--
-- Name: indicator_types id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.indicator_types ALTER COLUMN id SET DEFAULT nextval('public.indicator_types_id_seq'::regclass);


--
-- Name: indicators id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.indicators ALTER COLUMN id SET DEFAULT nextval('public.indicators_id_seq'::regclass);


--
-- Name: instant_sessions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.instant_sessions ALTER COLUMN id SET DEFAULT nextval('public.instant_sessions_id_seq'::regclass);


--
-- Name: meals id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.meals ALTER COLUMN id SET DEFAULT nextval('public.meals_id_seq'::regclass);


--
-- Name: notes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notes ALTER COLUMN id SET DEFAULT nextval('public.notes_id_seq'::regclass);


--
-- Name: notifications id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications ALTER COLUMN id SET DEFAULT nextval('public.notifications_id_seq'::regclass);


--
-- Name: organization_memberships id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organization_memberships ALTER COLUMN id SET DEFAULT nextval('public.organization_memberships_id_seq'::regclass);


--
-- Name: organizations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organizations ALTER COLUMN id SET DEFAULT nextval('public.organizations_id_seq'::regclass);


--
-- Name: packages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.packages ALTER COLUMN id SET DEFAULT nextval('public.packages_id_seq'::regclass);


--
-- Name: patient_conditions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.patient_conditions ALTER COLUMN id SET DEFAULT nextval('public.patient_conditions_id_seq'::regclass);


--
-- Name: patient_packages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.patient_packages ALTER COLUMN id SET DEFAULT nextval('public.patient_packages_id_seq'::regclass);


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
-- Name: restricted_ingredient_conditions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.restricted_ingredient_conditions ALTER COLUMN id SET DEFAULT nextval('public.restricted_ingredient_conditions_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: sessions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions ALTER COLUMN id SET DEFAULT nextval('public.sessions_id_seq'::regclass);


--
-- Name: socket_clients id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.socket_clients ALTER COLUMN id SET DEFAULT nextval('public.socket_clients_id_seq'::regclass);


--
-- Name: tasks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tasks ALTER COLUMN id SET DEFAULT nextval('public.tasks_id_seq'::regclass);


--
-- Name: user_roles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_roles ALTER COLUMN id SET DEFAULT nextval('public.user_roles_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: active_storage_attachments active_storage_attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT active_storage_attachments_pkey PRIMARY KEY (id);


--
-- Name: active_storage_blobs active_storage_blobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_blobs
    ADD CONSTRAINT active_storage_blobs_pkey PRIMARY KEY (id);


--
-- Name: active_storage_variant_records active_storage_variant_records_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_variant_records
    ADD CONSTRAINT active_storage_variant_records_pkey PRIMARY KEY (id);


--
-- Name: activity_factors activity_factors_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.activity_factors
    ADD CONSTRAINT activity_factors_pkey PRIMARY KEY (id);


--
-- Name: appointment_settings appointment_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.appointment_settings
    ADD CONSTRAINT appointment_settings_pkey PRIMARY KEY (id);


--
-- Name: appointments appointments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: availabilities availabilities_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.availabilities
    ADD CONSTRAINT availabilities_pkey PRIMARY KEY (id);


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
-- Name: bmr_factors bmr_factors_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bmr_factors
    ADD CONSTRAINT bmr_factors_pkey PRIMARY KEY (id);


--
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: conditions conditions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.conditions
    ADD CONSTRAINT conditions_pkey PRIMARY KEY (id);


--
-- Name: contact_us contact_us_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contact_us
    ADD CONSTRAINT contact_us_pkey PRIMARY KEY (id);


--
-- Name: conversations conversations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.conversations
    ADD CONSTRAINT conversations_pkey PRIMARY KEY (id);


--
-- Name: diet_ingredients diet_ingredients_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.diet_ingredients
    ADD CONSTRAINT diet_ingredients_pkey PRIMARY KEY (id);


--
-- Name: diet_meal_times diet_meal_times_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.diet_meal_times
    ADD CONSTRAINT diet_meal_times_pkey PRIMARY KEY (id);


--
-- Name: diet_meal_weeks diet_meal_weeks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.diet_meal_weeks
    ADD CONSTRAINT diet_meal_weeks_pkey PRIMARY KEY (id);


--
-- Name: diets diets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.diets
    ADD CONSTRAINT diets_pkey PRIMARY KEY (id);


--
-- Name: discounts discounts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.discounts
    ADD CONSTRAINT discounts_pkey PRIMARY KEY (id);


--
-- Name: entries entries_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entries
    ADD CONSTRAINT entries_pkey PRIMARY KEY (id);


--
-- Name: genders genders_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.genders
    ADD CONSTRAINT genders_pkey PRIMARY KEY (id);


--
-- Name: global_configurations global_configurations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.global_configurations
    ADD CONSTRAINT global_configurations_pkey PRIMARY KEY (id);


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
-- Name: instant_sessions instant_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.instant_sessions
    ADD CONSTRAINT instant_sessions_pkey PRIMARY KEY (id);


--
-- Name: meals meals_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.meals
    ADD CONSTRAINT meals_pkey PRIMARY KEY (id);


--
-- Name: notes notes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notes
    ADD CONSTRAINT notes_pkey PRIMARY KEY (id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: organization_memberships organization_memberships_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organization_memberships
    ADD CONSTRAINT organization_memberships_pkey PRIMARY KEY (id);


--
-- Name: organizations organizations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organizations
    ADD CONSTRAINT organizations_pkey PRIMARY KEY (id);


--
-- Name: packages packages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.packages
    ADD CONSTRAINT packages_pkey PRIMARY KEY (id);


--
-- Name: patient_conditions patient_conditions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.patient_conditions
    ADD CONSTRAINT patient_conditions_pkey PRIMARY KEY (id);


--
-- Name: patient_packages patient_packages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.patient_packages
    ADD CONSTRAINT patient_packages_pkey PRIMARY KEY (id);


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
-- Name: restricted_ingredient_conditions restricted_ingredient_conditions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.restricted_ingredient_conditions
    ADD CONSTRAINT restricted_ingredient_conditions_pkey PRIMARY KEY (id);


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
-- Name: socket_clients socket_clients_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.socket_clients
    ADD CONSTRAINT socket_clients_pkey PRIMARY KEY (id);


--
-- Name: tasks tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);


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
-- Name: index_active_storage_attachments_on_blob_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_active_storage_attachments_on_blob_id ON public.active_storage_attachments USING btree (blob_id);


--
-- Name: index_active_storage_attachments_uniqueness; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_active_storage_attachments_uniqueness ON public.active_storage_attachments USING btree (record_type, record_id, name, blob_id);


--
-- Name: index_active_storage_blobs_on_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_active_storage_blobs_on_key ON public.active_storage_blobs USING btree (key);


--
-- Name: index_active_storage_variant_records_uniqueness; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_active_storage_variant_records_uniqueness ON public.active_storage_variant_records USING btree (blob_id, variation_digest);


--
-- Name: index_activity_factors_on_created_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_activity_factors_on_created_by_id ON public.activity_factors USING btree (created_by_id);


--
-- Name: index_appointment_settings_on_dietitian_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_appointment_settings_on_dietitian_id ON public.appointment_settings USING btree (dietitian_id);


--
-- Name: index_appointments_on_dietitian_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_appointments_on_dietitian_id ON public.appointments USING btree (dietitian_id);


--
-- Name: index_appointments_on_patient_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_appointments_on_patient_id ON public.appointments USING btree (patient_id);


--
-- Name: index_availabilities_on_dietitian_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_availabilities_on_dietitian_id ON public.availabilities USING btree (dietitian_id);


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
-- Name: index_bmr_factors_on_created_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bmr_factors_on_created_by_id ON public.bmr_factors USING btree (created_by_id);


--
-- Name: index_bmr_factors_on_gender_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bmr_factors_on_gender_id ON public.bmr_factors USING btree (gender_id);


--
-- Name: index_comments_on_entry_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_comments_on_entry_id ON public.comments USING btree (entry_id);


--
-- Name: index_comments_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_comments_on_user_id ON public.comments USING btree (user_id);


--
-- Name: index_contact_us_on_read_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_contact_us_on_read_by_id ON public.contact_us USING btree (read_by_id);


--
-- Name: index_conversations_on_dietitian_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_conversations_on_dietitian_id ON public.conversations USING btree (dietitian_id);


--
-- Name: index_conversations_on_patient_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_conversations_on_patient_id ON public.conversations USING btree (patient_id);


--
-- Name: index_diet_ingredients_on_diet_meal_time_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_diet_ingredients_on_diet_meal_time_id ON public.diet_ingredients USING btree (diet_meal_time_id);


--
-- Name: index_diet_ingredients_on_meal_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_diet_ingredients_on_meal_id ON public.diet_ingredients USING btree (meal_id);


--
-- Name: index_diet_meal_times_on_diet_meal_week_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_diet_meal_times_on_diet_meal_week_id ON public.diet_meal_times USING btree (diet_meal_week_id);


--
-- Name: index_diet_meal_weeks_on_diet_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_diet_meal_weeks_on_diet_id ON public.diet_meal_weeks USING btree (diet_id);


--
-- Name: index_diets_on_dietitian_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_diets_on_dietitian_id ON public.diets USING btree (dietitian_id);


--
-- Name: index_diets_on_patient_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_diets_on_patient_id ON public.diets USING btree (patient_id);


--
-- Name: index_diets_on_session_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_diets_on_session_id ON public.diets USING btree (session_id);


--
-- Name: index_discounts_on_created_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_discounts_on_created_by_id ON public.discounts USING btree (created_by_id);


--
-- Name: index_entries_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_entries_on_user_id ON public.entries USING btree (user_id);


--
-- Name: index_genders_on_created_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_genders_on_created_by_id ON public.genders USING btree (created_by_id);


--
-- Name: index_global_configurations_on_created_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_global_configurations_on_created_by_id ON public.global_configurations USING btree (created_by_id);


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
-- Name: index_instant_sessions_on_created_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_instant_sessions_on_created_by_id ON public.instant_sessions USING btree (created_by_id);


--
-- Name: index_notes_on_conversation_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_notes_on_conversation_id ON public.notes USING btree (conversation_id);


--
-- Name: index_notes_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_notes_on_user_id ON public.notes USING btree (user_id);


--
-- Name: index_notifications_on_associated_object; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_notifications_on_associated_object ON public.notifications USING btree (associated_object_type, associated_object_id);


--
-- Name: index_notifications_on_recipient_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_notifications_on_recipient_id ON public.notifications USING btree (recipient_id);


--
-- Name: index_notifications_on_sender_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_notifications_on_sender_id ON public.notifications USING btree (sender_id);


--
-- Name: index_organization_memberships_on_organization_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_organization_memberships_on_organization_id ON public.organization_memberships USING btree (organization_id);


--
-- Name: index_organization_memberships_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_organization_memberships_on_user_id ON public.organization_memberships USING btree (user_id);


--
-- Name: index_packages_on_created_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_packages_on_created_by_id ON public.packages USING btree (created_by_id);


--
-- Name: index_patient_conditions_on_condition_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_patient_conditions_on_condition_id ON public.patient_conditions USING btree (condition_id);


--
-- Name: index_patient_conditions_on_created_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_patient_conditions_on_created_by_id ON public.patient_conditions USING btree (created_by_id);


--
-- Name: index_patient_conditions_on_patient_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_patient_conditions_on_patient_id ON public.patient_conditions USING btree (patient_id);


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
-- Name: index_restricted_ingredient_conditions_on_condition_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_restricted_ingredient_conditions_on_condition_id ON public.restricted_ingredient_conditions USING btree (condition_id);


--
-- Name: index_restricted_ingredient_conditions_on_meal_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_restricted_ingredient_conditions_on_meal_id ON public.restricted_ingredient_conditions USING btree (meal_id);


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
-- Name: index_tasks_on_dietitian_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_tasks_on_dietitian_id ON public.tasks USING btree (dietitian_id);


--
-- Name: index_tasks_on_patient_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_tasks_on_patient_id ON public.tasks USING btree (patient_id);


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
-- Name: index_users_on_dietitian_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_dietitian_id ON public.users USING btree (dietitian_id);


--
-- Name: index_users_on_organization_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_organization_id ON public.users USING btree (organization_id);


--
-- Name: index_users_on_patient_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_patient_id ON public.users USING btree (patient_id);


--
-- Name: index_users_on_searchable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_searchable ON public.users USING gin (searchable);


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
-- Name: users fk_rails_0d8854de6b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT fk_rails_0d8854de6b FOREIGN KEY (dietitian_id) REFERENCES public.users(id);


--
-- Name: conversations fk_rails_0d97bf7491; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.conversations
    ADD CONSTRAINT fk_rails_0d97bf7491 FOREIGN KEY (dietitian_id) REFERENCES public.users(id);


--
-- Name: diets fk_rails_1b34e32294; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.diets
    ADD CONSTRAINT fk_rails_1b34e32294 FOREIGN KEY (session_id) REFERENCES public.sessions(id);


--
-- Name: sessions fk_rails_1c002106d8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT fk_rails_1c002106d8 FOREIGN KEY (patient_package_id) REFERENCES public.patient_packages(id);


--
-- Name: diet_ingredients fk_rails_1f31e50afd; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.diet_ingredients
    ADD CONSTRAINT fk_rails_1f31e50afd FOREIGN KEY (diet_meal_time_id) REFERENCES public.diet_meal_times(id);


--
-- Name: payments fk_rails_1fb182b99e; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT fk_rails_1fb182b99e FOREIGN KEY (created_by_id) REFERENCES public.users(id);


--
-- Name: patient_packages fk_rails_20c4f97101; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.patient_packages
    ADD CONSTRAINT fk_rails_20c4f97101 FOREIGN KEY (dietitian_id) REFERENCES public.users(id);


--
-- Name: tasks fk_rails_2157c8f834; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT fk_rails_2157c8f834 FOREIGN KEY (dietitian_id) REFERENCES public.users(id);


--
-- Name: conversations fk_rails_29baf71c50; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.conversations
    ADD CONSTRAINT fk_rails_29baf71c50 FOREIGN KEY (patient_id) REFERENCES public.users(id);


--
-- Name: diet_meal_weeks fk_rails_2bbb96b5c5; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.diet_meal_weeks
    ADD CONSTRAINT fk_rails_2bbb96b5c5 FOREIGN KEY (diet_id) REFERENCES public.diets(id);


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
-- Name: patient_conditions fk_rails_344693fe12; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.patient_conditions
    ADD CONSTRAINT fk_rails_344693fe12 FOREIGN KEY (created_by_id) REFERENCES public.users(id);


--
-- Name: diets fk_rails_3900be8572; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.diets
    ADD CONSTRAINT fk_rails_3900be8572 FOREIGN KEY (patient_id) REFERENCES public.users(id);


--
-- Name: availabilities fk_rails_3c3dad846f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.availabilities
    ADD CONSTRAINT fk_rails_3c3dad846f FOREIGN KEY (dietitian_id) REFERENCES public.users(id);


--
-- Name: packages fk_rails_438d68f470; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.packages
    ADD CONSTRAINT fk_rails_438d68f470 FOREIGN KEY (created_by_id) REFERENCES public.users(id);


--
-- Name: contact_us fk_rails_48680d88f3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contact_us
    ADD CONSTRAINT fk_rails_48680d88f3 FOREIGN KEY (read_by_id) REFERENCES public.users(id);


--
-- Name: notifications fk_rails_4aea6afa11; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT fk_rails_4aea6afa11 FOREIGN KEY (recipient_id) REFERENCES public.users(id);


--
-- Name: payment_billing_items fk_rails_54ccdfeceb; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payment_billing_items
    ADD CONSTRAINT fk_rails_54ccdfeceb FOREIGN KEY (billing_item_id) REFERENCES public.billing_items(id);


--
-- Name: patient_conditions fk_rails_5835c89fa4; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.patient_conditions
    ADD CONSTRAINT fk_rails_5835c89fa4 FOREIGN KEY (patient_id) REFERENCES public.users(id);


--
-- Name: tasks fk_rails_58d62f3802; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT fk_rails_58d62f3802 FOREIGN KEY (patient_id) REFERENCES public.users(id);


--
-- Name: patient_packages fk_rails_607b3bce29; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.patient_packages
    ADD CONSTRAINT fk_rails_607b3bce29 FOREIGN KEY (patient_id) REFERENCES public.users(id);


--
-- Name: billings fk_rails_68db0bce0b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.billings
    ADD CONSTRAINT fk_rails_68db0bce0b FOREIGN KEY (patient_id) REFERENCES public.users(id);


--
-- Name: payments fk_rails_77edb17a11; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT fk_rails_77edb17a11 FOREIGN KEY (dietitian_id) REFERENCES public.users(id);


--
-- Name: sessions fk_rails_79ce2af0c3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT fk_rails_79ce2af0c3 FOREIGN KEY (dietitian_id) REFERENCES public.users(id);


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
-- Name: appointment_settings fk_rails_8582e4a496; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.appointment_settings
    ADD CONSTRAINT fk_rails_8582e4a496 FOREIGN KEY (dietitian_id) REFERENCES public.users(id);


--
-- Name: notifications fk_rails_8780923399; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT fk_rails_8780923399 FOREIGN KEY (sender_id) REFERENCES public.users(id);


--
-- Name: indicators fk_rails_87e1e553c1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.indicators
    ADD CONSTRAINT fk_rails_87e1e553c1 FOREIGN KEY (indicator_type_id) REFERENCES public.indicator_types(id);


--
-- Name: bmr_factors fk_rails_8f419dbf82; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bmr_factors
    ADD CONSTRAINT fk_rails_8f419dbf82 FOREIGN KEY (created_by_id) REFERENCES public.users(id);


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
-- Name: active_storage_variant_records fk_rails_993965df05; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_variant_records
    ADD CONSTRAINT fk_rails_993965df05 FOREIGN KEY (blob_id) REFERENCES public.active_storage_blobs(id);


--
-- Name: restricted_ingredient_conditions fk_rails_9b7c9ee3e4; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.restricted_ingredient_conditions
    ADD CONSTRAINT fk_rails_9b7c9ee3e4 FOREIGN KEY (meal_id) REFERENCES public.meals(id);


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
-- Name: diet_meal_times fk_rails_afb36dc25b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.diet_meal_times
    ADD CONSTRAINT fk_rails_afb36dc25b FOREIGN KEY (diet_meal_week_id) REFERENCES public.diet_meal_weeks(id);


--
-- Name: sessions fk_rails_b1767efc49; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT fk_rails_b1767efc49 FOREIGN KEY (patient_id) REFERENCES public.users(id);


--
-- Name: roles fk_rails_b41292c88f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT fk_rails_b41292c88f FOREIGN KEY (created_by_id) REFERENCES public.users(id);


--
-- Name: active_storage_attachments fk_rails_c3b3935057; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT fk_rails_c3b3935057 FOREIGN KEY (blob_id) REFERENCES public.active_storage_blobs(id);


--
-- Name: appointments fk_rails_c63da04ab4; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT fk_rails_c63da04ab4 FOREIGN KEY (patient_id) REFERENCES public.users(id);


--
-- Name: bmr_factors fk_rails_c8cc5f72da; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bmr_factors
    ADD CONSTRAINT fk_rails_c8cc5f72da FOREIGN KEY (gender_id) REFERENCES public.genders(id);


--
-- Name: restricted_ingredient_conditions fk_rails_c905c45025; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.restricted_ingredient_conditions
    ADD CONSTRAINT fk_rails_c905c45025 FOREIGN KEY (condition_id) REFERENCES public.conditions(id);


--
-- Name: billings fk_rails_cf7922da93; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.billings
    ADD CONSTRAINT fk_rails_cf7922da93 FOREIGN KEY (dietitian_id) REFERENCES public.users(id);


--
-- Name: diet_ingredients fk_rails_d9b61a00f3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.diet_ingredients
    ADD CONSTRAINT fk_rails_d9b61a00f3 FOREIGN KEY (meal_id) REFERENCES public.meals(id);


--
-- Name: appointments fk_rails_deeb08c2c3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT fk_rails_deeb08c2c3 FOREIGN KEY (dietitian_id) REFERENCES public.users(id);


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
-- Name: patient_conditions fk_rails_f51d791a3d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.patient_conditions
    ADD CONSTRAINT fk_rails_f51d791a3d FOREIGN KEY (condition_id) REFERENCES public.conditions(id);


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
-- Name: global_configurations fk_rails_f8cfbd3f2a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.global_configurations
    ADD CONSTRAINT fk_rails_f8cfbd3f2a FOREIGN KEY (created_by_id) REFERENCES public.users(id);


--
-- Name: diets fk_rails_fa39051349; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.diets
    ADD CONSTRAINT fk_rails_fa39051349 FOREIGN KEY (dietitian_id) REFERENCES public.users(id);


--
-- Name: indicators fk_rails_fb5b988de2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.indicators
    ADD CONSTRAINT fk_rails_fb5b988de2 FOREIGN KEY (gender_id) REFERENCES public.genders(id);


--
-- Name: instant_sessions fk_rails_fbe8f523e0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.instant_sessions
    ADD CONSTRAINT fk_rails_fbe8f523e0 FOREIGN KEY (created_by_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20240215142825'),
('20240215142824'),
('20240215142823'),
('20240215030832'),
('20240215030831'),
('20240215030710'),
('20240215030633'),
('20240215030514'),
('20230520144416'),
('20230518222715'),
('20230513012452'),
('20230512114154'),
('20230512113427'),
('20230512111331'),
('20230506023959'),
('20230506023259'),
('20230428123646'),
('20230426032019'),
('20230425202941'),
('20230424202529'),
('20230424202528'),
('20230418173331'),
('20220905011432'),
('20220904013013'),
('20220904011508'),
('20220828213041'),
('20220828213040'),
('20220828213039'),
('20220828213037'),
('20220828212915'),
('20220828212844'),
('20210523031431'),
('20210518184058'),
('20210518184055'),
('20210518183902'),
('20210515174951'),
('20210515174948'),
('20210510193801'),
('20210509221513'),
('20210509221321'),
('20210509221320'),
('20210509221319'),
('20210509221318');

