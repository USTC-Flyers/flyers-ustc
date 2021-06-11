--
-- PostgreSQL database dump
--

-- Dumped from database version 13.2 (Ubuntu 13.2-1.pgdg18.04+1)
-- Dumped by pg_dump version 13.2 (Ubuntu 13.2-1.pgdg18.04+1)

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
-- Name: account_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account_user (
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    id character varying(255) NOT NULL
);


ALTER TABLE public.account_user OWNER TO postgres;

--
-- Name: account_user_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account_user_groups (
    id integer NOT NULL,
    user_id character varying(255) NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.account_user_groups OWNER TO postgres;

--
-- Name: account_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.account_user_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_user_groups_id_seq OWNER TO postgres;

--
-- Name: account_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.account_user_groups_id_seq OWNED BY public.account_user_groups.id;


--
-- Name: account_user_user_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account_user_user_permissions (
    id integer NOT NULL,
    user_id character varying(255) NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.account_user_user_permissions OWNER TO postgres;

--
-- Name: account_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.account_user_user_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_user_user_permissions_id_seq OWNER TO postgres;

--
-- Name: account_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.account_user_user_permissions_id_seq OWNED BY public.account_user_user_permissions.id;


--
-- Name: account_userprofile; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account_userprofile (
    id integer NOT NULL,
    nickname character varying(255),
    school integer,
    contact character varying(254),
    is_verified boolean NOT NULL,
    role integer NOT NULL,
    "enrolledYear" character varying(255),
    "isUndergrad" boolean,
    final_program character varying(255),
    university character varying(255) NOT NULL,
    final_university_id integer,
    related_user_id character varying(255) NOT NULL
);


ALTER TABLE public.account_userprofile OWNER TO postgres;

--
-- Name: account_userprofile_followed; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account_userprofile_followed (
    id integer NOT NULL,
    from_userprofile_id integer NOT NULL,
    to_userprofile_id integer NOT NULL
);


ALTER TABLE public.account_userprofile_followed OWNER TO postgres;

--
-- Name: account_userprofile_followed_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.account_userprofile_followed_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_userprofile_followed_id_seq OWNER TO postgres;

--
-- Name: account_userprofile_followed_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.account_userprofile_followed_id_seq OWNED BY public.account_userprofile_followed.id;


--
-- Name: account_userprofile_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.account_userprofile_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_userprofile_id_seq OWNER TO postgres;

--
-- Name: account_userprofile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.account_userprofile_id_seq OWNED BY public.account_userprofile.id;


--
-- Name: admissions_admissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admissions_admissions (
    id integer NOT NULL,
    related_program character varying(255) NOT NULL,
    result boolean NOT NULL,
    "enrolledSemester" character varying(255) NOT NULL,
    comments text,
    summary text,
    created_time timestamp with time zone NOT NULL,
    upvoted_count integer NOT NULL,
    related_background_id integer NOT NULL,
    related_university_id integer NOT NULL,
    related_user_id character varying(255) NOT NULL,
    CONSTRAINT admissions_admissions_upvoted_count_check CHECK ((upvoted_count >= 0))
);


ALTER TABLE public.admissions_admissions OWNER TO postgres;

--
-- Name: admissions_admissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.admissions_admissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.admissions_admissions_id_seq OWNER TO postgres;

--
-- Name: admissions_admissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.admissions_admissions_id_seq OWNED BY public.admissions_admissions.id;


--
-- Name: admissions_admissions_upvoted; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admissions_admissions_upvoted (
    id integer NOT NULL,
    admissions_id integer NOT NULL,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.admissions_admissions_upvoted OWNER TO postgres;

--
-- Name: admissions_admissions_upvoted_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.admissions_admissions_upvoted_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.admissions_admissions_upvoted_id_seq OWNER TO postgres;

--
-- Name: admissions_admissions_upvoted_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.admissions_admissions_upvoted_id_seq OWNED BY public.admissions_admissions_upvoted.id;


--
-- Name: admissions_background; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admissions_background (
    id integer NOT NULL,
    major character varying(255),
    gpa double precision,
    rank character varying(255),
    apply_for character varying(255),
    "TOEFL" character varying(255),
    "GRE" character varying(256),
    score character varying(256),
    "researchSpec" text,
    "referSpec" text,
    tags character varying(255)[],
    comments text,
    summary text,
    upvoted_count integer NOT NULL,
    related_user_id character varying(255) NOT NULL,
    CONSTRAINT admissions_background_upvoted_count_check CHECK ((upvoted_count >= 0))
);


ALTER TABLE public.admissions_background OWNER TO postgres;

--
-- Name: admissions_background_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.admissions_background_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.admissions_background_id_seq OWNER TO postgres;

--
-- Name: admissions_background_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.admissions_background_id_seq OWNED BY public.admissions_background.id;


--
-- Name: admissions_background_upvoted; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admissions_background_upvoted (
    id integer NOT NULL,
    background_id integer NOT NULL,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.admissions_background_upvoted OWNER TO postgres;

--
-- Name: admissions_background_upvoted_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.admissions_background_upvoted_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.admissions_background_upvoted_id_seq OWNER TO postgres;

--
-- Name: admissions_background_upvoted_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.admissions_background_upvoted_id_seq OWNED BY public.admissions_background_upvoted.id;


--
-- Name: admissions_program; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admissions_program (
    id integer NOT NULL,
    name character varying(256) NOT NULL,
    full_name character varying(256) NOT NULL,
    related_university_id integer NOT NULL
);


ALTER TABLE public.admissions_program OWNER TO postgres;

--
-- Name: admissions_program_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.admissions_program_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.admissions_program_id_seq OWNER TO postgres;

--
-- Name: admissions_program_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.admissions_program_id_seq OWNED BY public.admissions_program.id;


--
-- Name: admissions_university; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admissions_university (
    id integer NOT NULL,
    area character varying(256) NOT NULL,
    school_name character varying(256) NOT NULL,
    school_name_cn character varying(256) NOT NULL,
    short_name character varying(256) NOT NULL
);


ALTER TABLE public.admissions_university OWNER TO postgres;

--
-- Name: admissions_university_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.admissions_university_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.admissions_university_id_seq OWNER TO postgres;

--
-- Name: admissions_university_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.admissions_university_id_seq OWNED BY public.admissions_university.id;


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id character varying(255) NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO postgres;

--
-- Name: forum_comment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.forum_comment (
    id integer NOT NULL,
    content text NOT NULL,
    action integer NOT NULL,
    created_time timestamp with time zone NOT NULL,
    upvoted_count integer NOT NULL,
    related_comment_thread_id integer NOT NULL,
    related_user_id character varying(255) NOT NULL,
    CONSTRAINT forum_comment_upvoted_count_check CHECK ((upvoted_count >= 0))
);


ALTER TABLE public.forum_comment OWNER TO postgres;

--
-- Name: forum_comment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.forum_comment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.forum_comment_id_seq OWNER TO postgres;

--
-- Name: forum_comment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.forum_comment_id_seq OWNED BY public.forum_comment.id;


--
-- Name: forum_comment_upvoted; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.forum_comment_upvoted (
    id integer NOT NULL,
    comment_id integer NOT NULL,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.forum_comment_upvoted OWNER TO postgres;

--
-- Name: forum_comment_upvoted_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.forum_comment_upvoted_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.forum_comment_upvoted_id_seq OWNER TO postgres;

--
-- Name: forum_comment_upvoted_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.forum_comment_upvoted_id_seq OWNED BY public.forum_comment_upvoted.id;


--
-- Name: forum_commentthread; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.forum_commentthread (
    id integer NOT NULL,
    content text NOT NULL,
    action integer NOT NULL,
    created_time timestamp with time zone NOT NULL,
    is_anonymous boolean NOT NULL,
    upvoted_count integer NOT NULL,
    related_topic_id integer NOT NULL,
    related_user_id character varying(255) NOT NULL,
    CONSTRAINT forum_commentthread_upvoted_count_check CHECK ((upvoted_count >= 0))
);


ALTER TABLE public.forum_commentthread OWNER TO postgres;

--
-- Name: forum_commentthread_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.forum_commentthread_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.forum_commentthread_id_seq OWNER TO postgres;

--
-- Name: forum_commentthread_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.forum_commentthread_id_seq OWNED BY public.forum_commentthread.id;


--
-- Name: forum_commentthread_upvoted; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.forum_commentthread_upvoted (
    id integer NOT NULL,
    commentthread_id integer NOT NULL,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.forum_commentthread_upvoted OWNER TO postgres;

--
-- Name: forum_commentthread_upvoted_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.forum_commentthread_upvoted_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.forum_commentthread_upvoted_id_seq OWNER TO postgres;

--
-- Name: forum_commentthread_upvoted_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.forum_commentthread_upvoted_id_seq OWNED BY public.forum_commentthread_upvoted.id;


--
-- Name: forum_notification; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.forum_notification (
    id integer NOT NULL,
    created_time timestamp with time zone NOT NULL,
    ref_obj_name character varying(255) NOT NULL,
    ref_obj_id integer NOT NULL,
    message text,
    is_read boolean NOT NULL,
    operation integer NOT NULL,
    related_user_id character varying(255) NOT NULL
);


ALTER TABLE public.forum_notification OWNER TO postgres;

--
-- Name: forum_notification_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.forum_notification_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.forum_notification_id_seq OWNER TO postgres;

--
-- Name: forum_notification_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.forum_notification_id_seq OWNED BY public.forum_notification.id;


--
-- Name: forum_topic; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.forum_topic (
    id integer NOT NULL,
    followed_count integer NOT NULL,
    action integer NOT NULL,
    hit_count integer NOT NULL,
    comment_count integer NOT NULL,
    upvoted_count integer NOT NULL,
    is_valid boolean NOT NULL,
    current_version_id integer,
    group_id integer,
    CONSTRAINT forum_topic_comment_count_check CHECK ((comment_count >= 0)),
    CONSTRAINT forum_topic_followed_count_check CHECK ((followed_count >= 0)),
    CONSTRAINT forum_topic_hit_count_check CHECK ((hit_count >= 0)),
    CONSTRAINT forum_topic_upvoted_count_check CHECK ((upvoted_count >= 0))
);


ALTER TABLE public.forum_topic OWNER TO postgres;

--
-- Name: forum_topic_followed; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.forum_topic_followed (
    id integer NOT NULL,
    topic_id integer NOT NULL,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.forum_topic_followed OWNER TO postgres;

--
-- Name: forum_topic_followed_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.forum_topic_followed_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.forum_topic_followed_id_seq OWNER TO postgres;

--
-- Name: forum_topic_followed_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.forum_topic_followed_id_seq OWNED BY public.forum_topic_followed.id;


--
-- Name: forum_topic_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.forum_topic_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.forum_topic_id_seq OWNER TO postgres;

--
-- Name: forum_topic_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.forum_topic_id_seq OWNED BY public.forum_topic.id;


--
-- Name: forum_topic_upvoted; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.forum_topic_upvoted (
    id integer NOT NULL,
    topic_id integer NOT NULL,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.forum_topic_upvoted OWNER TO postgres;

--
-- Name: forum_topic_upvoted_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.forum_topic_upvoted_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.forum_topic_upvoted_id_seq OWNER TO postgres;

--
-- Name: forum_topic_upvoted_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.forum_topic_upvoted_id_seq OWNED BY public.forum_topic_upvoted.id;


--
-- Name: forum_topicrevision; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.forum_topicrevision (
    id integer NOT NULL,
    revision_number integer NOT NULL,
    title text NOT NULL,
    content text NOT NULL,
    image character varying(100) NOT NULL,
    file character varying(100) NOT NULL,
    created_time timestamp with time zone NOT NULL,
    is_valid boolean NOT NULL,
    related_topic_id integer,
    related_user_id character varying(255) NOT NULL
);


ALTER TABLE public.forum_topicrevision OWNER TO postgres;

--
-- Name: forum_topicrevision_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.forum_topicrevision_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.forum_topicrevision_id_seq OWNER TO postgres;

--
-- Name: forum_topicrevision_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.forum_topicrevision_id_seq OWNED BY public.forum_topicrevision.id;


--
-- Name: account_user_groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_user_groups ALTER COLUMN id SET DEFAULT nextval('public.account_user_groups_id_seq'::regclass);


--
-- Name: account_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.account_user_user_permissions_id_seq'::regclass);


--
-- Name: account_userprofile id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_userprofile ALTER COLUMN id SET DEFAULT nextval('public.account_userprofile_id_seq'::regclass);


--
-- Name: account_userprofile_followed id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_userprofile_followed ALTER COLUMN id SET DEFAULT nextval('public.account_userprofile_followed_id_seq'::regclass);


--
-- Name: admissions_admissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admissions_admissions ALTER COLUMN id SET DEFAULT nextval('public.admissions_admissions_id_seq'::regclass);


--
-- Name: admissions_admissions_upvoted id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admissions_admissions_upvoted ALTER COLUMN id SET DEFAULT nextval('public.admissions_admissions_upvoted_id_seq'::regclass);


--
-- Name: admissions_background id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admissions_background ALTER COLUMN id SET DEFAULT nextval('public.admissions_background_id_seq'::regclass);


--
-- Name: admissions_background_upvoted id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admissions_background_upvoted ALTER COLUMN id SET DEFAULT nextval('public.admissions_background_upvoted_id_seq'::regclass);


--
-- Name: admissions_program id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admissions_program ALTER COLUMN id SET DEFAULT nextval('public.admissions_program_id_seq'::regclass);


--
-- Name: admissions_university id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admissions_university ALTER COLUMN id SET DEFAULT nextval('public.admissions_university_id_seq'::regclass);


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: forum_comment id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forum_comment ALTER COLUMN id SET DEFAULT nextval('public.forum_comment_id_seq'::regclass);


--
-- Name: forum_comment_upvoted id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forum_comment_upvoted ALTER COLUMN id SET DEFAULT nextval('public.forum_comment_upvoted_id_seq'::regclass);


--
-- Name: forum_commentthread id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forum_commentthread ALTER COLUMN id SET DEFAULT nextval('public.forum_commentthread_id_seq'::regclass);


--
-- Name: forum_commentthread_upvoted id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forum_commentthread_upvoted ALTER COLUMN id SET DEFAULT nextval('public.forum_commentthread_upvoted_id_seq'::regclass);


--
-- Name: forum_notification id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forum_notification ALTER COLUMN id SET DEFAULT nextval('public.forum_notification_id_seq'::regclass);


--
-- Name: forum_topic id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forum_topic ALTER COLUMN id SET DEFAULT nextval('public.forum_topic_id_seq'::regclass);


--
-- Name: forum_topic_followed id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forum_topic_followed ALTER COLUMN id SET DEFAULT nextval('public.forum_topic_followed_id_seq'::regclass);


--
-- Name: forum_topic_upvoted id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forum_topic_upvoted ALTER COLUMN id SET DEFAULT nextval('public.forum_topic_upvoted_id_seq'::regclass);


--
-- Name: forum_topicrevision id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forum_topicrevision ALTER COLUMN id SET DEFAULT nextval('public.forum_topicrevision_id_seq'::regclass);


--
-- Data for Name: account_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.account_user (password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined, id) FROM stdin;
pbkdf2_sha256$216000$QPYJJBTuAKGq$CYw7SPB5Zf7QaB1OsvZAp07BKMIn/h4RdTDz2YonqsQ=	\N	t	flyers				t	t	2021-06-02 10:49:23.714378+08	
\.


--
-- Data for Name: account_user_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.account_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: account_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.account_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: account_userprofile; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.account_userprofile (id, nickname, school, contact, is_verified, role, "enrolledYear", "isUndergrad", final_program, university, final_university_id, related_user_id) FROM stdin;
\.


--
-- Data for Name: account_userprofile_followed; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.account_userprofile_followed (id, from_userprofile_id, to_userprofile_id) FROM stdin;
\.


--
-- Data for Name: admissions_admissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admissions_admissions (id, related_program, result, "enrolledSemester", comments, summary, created_time, upvoted_count, related_background_id, related_university_id, related_user_id) FROM stdin;
\.


--
-- Data for Name: admissions_admissions_upvoted; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admissions_admissions_upvoted (id, admissions_id, user_id) FROM stdin;
\.


--
-- Data for Name: admissions_background; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admissions_background (id, major, gpa, rank, apply_for, "TOEFL", "GRE", score, "researchSpec", "referSpec", tags, comments, summary, upvoted_count, related_user_id) FROM stdin;
\.


--
-- Data for Name: admissions_background_upvoted; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admissions_background_upvoted (id, background_id, user_id) FROM stdin;
\.


--
-- Data for Name: admissions_program; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admissions_program (id, name, full_name, related_university_id) FROM stdin;
1	BA	MS in Business Analytics	3
2	Bioinfomatics	MS in Bioinformatics	3
3	I/O Psych	PhD in Industrial/Organizational Behavior	3
4	JMC	MA in Journalism and Mass Communication	3
5	Statistics	PhD in Statistics	3
6	Big Data in Culture & Society	MA in Big Data in Culture & Society	5
7	BME	PhD in MRC DTP Studentships	5
8	CE	MS in Telecommunications & Internet Technology	5
9	CS	MS in Advanced Computing	5
10	DS	MSc in Data Science	5
11	Medical Imaging	PhD in Smart Medical Imaging CDT	5
12	Biological Engineering	PhD in Chemical and Biological Engineering	6
13	Biology	MS in Plant Science	6
14	Chemical Engineering	MS in Chemical and Biological Engineering	6
15	Chemical Engineering	PhD in Energy Resources and Petroleum Engineering	6
16	Computer Science	MS in Computer Science	6
17	Computer Science	PhD in Computer Science	6
18	EE	MS in Electrical Engineering	6
19	Electrical Engineering	MS in Electrical Engineering	6
20	Electrical Engineering	PhD in Electrical Engineering	6
21	Environmental Engineering	MS in Environmental Science and Engineering	6
22	Environmental Engineering	PhD in Environmental Science and Engineering	6
23	Geosciences	MS in Marine Science	6
24	Geosciences	PhD in Marine Science	6
25	Materials	MS in Material Science and Engineering	6
26	Materials	PhD in Material Science and Engineering	6
27	Mathematics	MS in Applied Mathematics & Computational Science Program	6
28	Mechanical Engineering	MS in Mechanical Engineering	6
29	Mechanical Engineering	PhD in Mechanical Engineering	6
30	Mineral Engineering	MS in Energy Resources and Petroleum Engineering	6
31	Plant Science	PhD in Plant Science	6
32	Statistics	MS in Statistics	6
33	Statistics	PhD in Statistics	6
34	Accounting	MSc in Accounting	7
35	Agriculture	MSc in Soil Sciences	7
36	Agriculture	PhD in Soil Sciences	7
37	Architecture	MSc in Architecture and Building Sciences	7
38	Architecture	PhD in Architecture and Building Sciences	7
39	Basic Medicine	MSc in Physiology	7
40	Basic Medicine	PhD in Physiology	7
41	Biological Agricultural Engineering	MSc in Agricultural Engineering	7
42	Biological Agricultural Engineering	PhD in Agricultural Engineering	7
43	Biology	MSc in Microbiology	7
44	Biology	PhD in Zoology	7
45	Chemical Engineering	MSc in Chemical Engineering	7
46	Chemical Engineering	PhD in Chemical Engineering	7
47	Chemistry	MSc in Chemistry	7
48	Chemistry	PhD in Chemistry	7
49	Communication	MA in Mass Communication	7
50	Communication	PhD in Communication and Digital Media	7
51	Computer Engineering	MSc in Computer Engineering	7
52	Computer Engineering	PhD in Computer Engineering	7
53	Computer Science	MSc in Computer Science	7
54	Computer Science	PhD in Computer Science	7
55	Design	MSc in Urban Design	7
56	Economics	MSc in Agricultural Economics	7
57	Economics	PhD in Economics	7
58	Education	MA in Educational Administration	7
59	Education	PhD in Art Education	7
60	Electrical Engineering	MSc in Electrical Engineering	7
61	Electrical Engineering	PhD in Electrical Engineering	7
62	English	MA in English (Literature)	7
63	English	PhD in Arabic Applied Linguistics	7
64	Finance	MSc in Finance	7
65	Food Science And Technology	MSc in Clinical Nutrition	7
66	Food Science And Technology	PhD in Human Nutrition	7
67	Geography	MA in Geography	7
68	Geosciences	MSc in Geology	7
69	Geosciences	PhD in Geography	7
70	History	MA in National History of KSA	7
71	History	PhD in History	7
72	Human Resource Management	MSc in Human Resources Management	7
73	Industrial Engineering	MSc in Industrial Engineering	7
74	Industrial Engineering	PhD in Industrial Engineering	7
75	Information Systems	MA in Information and Library Science	7
76	Information Systems	PhD in Information Systems	7
77	Language	MA in Arabic Language	7
78	Language	PhD in Applied Linguistics	7
79	Law	Master of Law (Private Law)	7
80	Literature	PhD in Arabic Language and its Literature	7
81	Materials	MSc in Material Engineering	7
82	Mathematics	MSc in Mathematics	7
83	Mathematics	PhD in Mathematics	7
84	Mechanical Engineering	MSc in Mechanical Engineering	7
85	Mechanical Engineering	PhD in Mechanical Engineering	7
86	Medicine	MSc in Pharmacy (Pharmacology/Toxicology)	7
87	Medicine	PhD in Pharmacology and Toxicology	7
88	Nursing	MSc in Nursing	7
89	Nursing	PhD in Nursing	7
90	Nutrition	MSc in Human Nutrition	7
91	Pharmacy	MSc in Pharmaceutics	7
92	Pharmacy	PhD in Pharmaceutics	7
93	Physics	MSc in Physics	7
94	Physics	PhD in Physics	7
95	Plant Science	MSc in Horticulture, Crops Science, Range Science and Forestry	7
96	Plant Science	PhD in Horticulture, Crops Science, Range Science and Forestry	7
97	Political Science	MA in Political Science	7
98	Political Science	PhD in Political Science	7
99	Psychology	MA in Psychology	7
100	Public Affairs	Master in Public Administration	7
101	Public Affairs	PhD in Public Administration	7
102	Public Health	MSc in Health and Hospital Administration	7
103	Sociology	MA in Sociology	7
104	Sociology	PhD in Social Studies (Sociology, Social Service)	7
105	Statistics	MSc in Statistics	7
106	Statistics	PhD in Statistics	7
107	Urban Planning	MSc in Urban Planning	7
108	Water Resources Engineering	MSc in Water Desalination Engineering	7
109	Water Resources Engineering	PhD in Civil Engineering	7
110	AMSC	PhD in Applied Mathematics, Statistics & Computational Science	11
111	BME	PhD in Bioengineering	11
112	Business Analytics	MS in Business Analytics	11
113	Chemical	PhD in Chemistry	11
114	CivilEngineering	MS in Civil Engineering	11
115	CS	MS in Computer Science	11
116	CS	PhD in Computer Science	11
117	Cybersecurity	MEng in Cybersecurity	11
118	Earth Science	PhD in Earth Science	11
119	ECE	MS in Electrical and Computer Engineering	11
120	ECE	PhD in Electrical and Computer Engineering	11
121	Finance	Master of Finance	11
122	HCI	Master of Human-Computer Interaction	11
123	Information Management	Master of Information Management	11
124	Information Systems	MS in Information Systems	11
125	IS	PhD in Information Systems	11
126	Marketing	PhD in Marketing	11
127	Materials	PhD in Materials Science and Engineering	11
128	Mathematical	PhD in Mathematical	11
129	ME	MS in Mechanical Engineering	11
130	Physics	PhD in Physics	11
131	Robotics	MEng in Robotics	11
132	SE	MS in Software Engineering	11
133	Transportation	PhD in Transportation Engineering	11
134	Accounting	MS in Accounting and Fundamental Analysis	12
135	Actuarial Science	MS in Actuarial Science	12
136	AM	PhD in Applied Math	12
137	Applied Analytics	MS in Applied Analytics	12
138	Applied Statistics	MS in Applied Statistics	12
139	AppliedMath	MS in Applied Mathematics	12
140	BA	MS in Business Analysis	12
141	Biostat	MPH in Biostatistics	12
142	BME	MS in Biomedical Engineering	12
143	BME	PhD in Biomedical Engineering	12
144	Bridge-CS	MS Bridge in Computer Science	12
145	CE	MS in Computer Engineering	12
146	CivilEngineering	MS in Civil Engineering	12
147	CivilEngineering 	PhD in Civil Engineering and Engineering Mechanics	12
148	CMBS	PhD in Cellular, Molecular, and Biomedical Studies	12
149	CS	MS in Computer Science	12
150	CS	PhD in Computer Science	12
151	DBMI	PhD in Biomedical Informatics	12
152	Design and Development of Digital Games	MA in Design and Development of Digital Games	12
153	DRO	PhD in Decision, Risk, and Operations	12
154	DS	MS in Data Science	12
155	Earth-Environmental	MS in Earth and Environmental Engineering	12
156	Ecology, Evolution & Environmental Biology	PhD in Ecology & Evolutionary Biology	12
157	Econ	MS in Economics	12
158	Economics	Master of Arts in Economics	12
159	Education Policy	MA in Education Policy	12
160	EE	MS in Electrical Engineering	12
161	EE	PhD in Electrical Engineering	12
162	Epidemiology	MS in Epidemiology	12
163	ERM	MS in Enterprise Risk Management	12
164	FE	MS in Financial Engineering	12
165	Finance	PhD in Finance	12
166	Healthcare	Master of Healthcare Administration	12
167	IEOR	PhD in Industrial Engineering and Operations Research	12
168	International Education Development	MA in International Education Development	12
169	LA	MS in Learning Analytics	12
170	MAFN	MA in Mathematics of Finance	12
171	Management Science & Engineering	MS in Management Science and Engineering	12
172	Marketing	MS in Marketing Science	12
173	Materials	MS in Materials Science	12
174	ME	MS in Engineering Mechanics	12
175	ME	PhD in Mechanical Engineering	12
176	MFA	Visual Arts MFA	12
177	MFE	MS in Financial Economics	12
178	MIA	Master of International Affairs	12
179	MJ	MA in Journalism	12
180	MPA	Master of Public Administration	12
181	MSBA	MS in Business Analytics	12
182	Operations research	MS in Operations Research	12
183	Philosophy	MA in Philosophy and Education	12
184	Physics	PhD in Physics	12
185	Public Administration	Master of Public Administration	12
186	PublicHealth	PhD in Public Health	12
187	QMSS	MA in Quantitative Methods in the Social Science	12
188	QMSS	MA in Quantitative Methods in the Social Sciences	12
189	Real Estate Development	MS in Real Estate Development	12
190	Social Work	Master of Social Work	12
191	Statistics	MA in Statistics	12
192	Statistics	PhD in Statistics	12
193	Statistics-Hybrid	MA in Statistics-Hybrid	12
194	Strategic Communication	MA in Strategic Communication	12
195	TEIT	MA in Instructional Technology and Media	12
196	BME	Meng in Biomedical Engineering	13
197	Business Analytics	Master of Business Analytics	13
198	CivilEngineering	Meng in Civil Engineering	13
199	CivilEngineering	PhD in Civil Engineering	13
200	CS	MSc in Computer Science	13
201	CS	PhD in Computer Science	13
402	Robotics	MSc in Robotics	20
202	Data Science	Master of Data Science	13
203	ECE	MEng in Electrical and Computer Engineering	13
204	ECE	MS in Electrical and Computer Engineering	13
205	Econ	PhD in Economics	13
206	Economics	MA in Economics	13
207	EE	PhD in Electrical and Computer Engineering	13
208	LLED	Ph.D. in Language and Literacy Education	13
209	ME	PhD in Mechanical Engineering	13
210	MGEM	Master of Geomatics for Environmental Management	13
211	Physics	Master of Science in Physics	13
212	Planning	PhD in Planning	13
213	Statistics	MSc in Statistics	13
214	Stats	PhD in Statistics	13
215	Accounting	PhD in Accountancy	14
216	Agriculture	MS in Forestry	14
217	Agriculture	PhD in Animal Sciences	14
218	Anthropology	MA in Anthropology(Track One and Track Two)	14
219	Anthropology	PhD in Anthropology(Track One and Track Two)	14
220	Aquaculture	PhD in Fisheries and Wildlife Sciences	14
221	Biology	MS in Plant Stress Biology	14
222	Biology	PhD in Plant Stress Biology	14
223	Biomedical Engineering	MEng in Biological Engineering	14
224	Biostatistics	MA in Statistics with emphasis in Biostatistics	14
225	Chemical Engineering	MS in Chemical Engineering	14
226	Chemical Engineering	PhD in Chemical Engineering	14
227	Chemistry	PhD in Chemistry	14
228	Communication	MA in Desin with Digital Media	14
229	Computer Engineering	MS in Computer Engineering	14
230	Computer Engineering	PhD in Electrical and Computer Engineering	14
231	Drama And Film	MFA in Art	14
232	Economics	MS in Agricultural and Applied Economics	14
233	Economics	PhD in Agribusiness and Organizational Economics	14
234	Education	MA in Special Education	14
235	Education	EDd in Special Education	14
236	Electrical Engineering	MS in Electrical Engineering	14
237	Electronic Engineering	Master of Physics & Astronomy: Optics	14
238	English	MA in English	14
239	English	PhD in English	14
240	Environmental Science	PhD in Human Environmental Sciences	14
241	Fine Arts	PhD in Theatre	14
242	Geosciences	MS in Geological Sciences	14
243	Geosciences	PhD in Geological Sciences	14
244	Industrial Engineering	MEng in Industrial and Manufacturing Systems Engineering	14
245	Industrial Engineering	PhD in Industrial Engineering	14
246	Information Systems	PhD in Informatics	14
247	ISLT	PhD in Information Science & Learning Technologies	14
248	Language	MA in French	14
249	Language	PhD in Romance Languages, French and Spanish	14
250	Law	JD (Juris Doctor)	14
251	Law	LLM in American Law	14
252	Literature	PhD in Classical Studies	14
253	Marketing	PhD in Marketing	14
254	Materials	PhD in Physics & Astronomy: Polymer Physics/Science (Experimental)	14
255	Mathematics	MST in Mathematics	14
256	Mathematics	PhD in Mathematics	14
257	Mba	JD/MBA	14
258	Mba	MBA (Master of Business Administration)	14
259	Philosophy	MA in Philosophy	14
260	Philosophy	PhD in Philosophy	14
261	Physics	Master of Physics & Astronomy: Astronomy	14
262	Physics	PhD in Physics & Astronomy: Astrophysics	14
263	Plant Science	MS in Horticulture	14
264	Political Science	MA in Political Science	14
265	Political Science	PhD in Political Science	14
266	Psychology	PhD in Psychology	14
267	Public Health	Master of Public Health	14
268	Public Health	PhD in Health and Rehabilitation Science	14
269	Social Work	MSW (Master of Social Work)	14
270	Social Work	PhD in Social Work	14
271	Sociology	MS in Rural Sociology	14
272	Sociology	PhD in Sociology	14
273	Statistics	MA in statistics	14
274	Statistics	PhD in statistics	14
275	Textile And Light Industry	MS in Textile and Apparel Management	14
276	Textile And Light Industry	PhD in Textile and Apparel Management	14
277	Water Resources Engineering	MS in Water Resources	14
278	Water Resources Engineering	PhD in Water Resources	14
279	Basic Medicine	PhD in Neurosciences and Cognitive Sciences	15
280	Biology	MS in Biological Sciences	15
281	Biology	PhD in Biochemistry	15
282	Biomedical Engineering	PhD in Chemical and Biochemical Engineering	15
283	Chemical Engineering	MS in Chemical and Biochemical Engineering	15
284	Chemistry	MS in Chemistry	15
285	Chemistry	PhD in Chemistry	15
286	Communication	MA in Intercultural Communication	15
287	Computer Engineering	MS in Computer Engineering	15
288	Computer Engineering	PhD in Human-Centered Computing	15
289	Computer Science	MS in Computer Science	15
290	Computer Science	PhD in Computer Science	15
291	Education	MA in Teaching English to Speakers of Other Languages	15
292	EE	PhD in Electrical Engineering	15
293	Electrical Engineering	MS in Electrical Engineering	15
294	Electrical Engineering	PhD in Electrical Engineering	15
295	Electronic Engineering	Master of Physics Graduate Program: Quantum Optics and Quantum Information	15
296	Electronic Engineering	PhD in Physics Graduate Program: Quantum Optics and Quantum Information	15
297	Environmental Engineering	MS in Environmental Engineering	15
298	Environmental Engineering	PhD in Environmental Engineering	15
299	Environmental Science	MS in Geography and Environmental Systems	15
300	Environmental Science	PhD in Marine, Estuarine and Environmental Sciences	15
301	Fine Arts	MFA in Intermedia and Digital Arts	15
302	Geophysics	PhD in Geography and Environmental Systems	15
303	Geosciences	MS in Marine, Estuarine and Environmental Sciences	15
304	Health	MS in Emergency Health Services	15
305	Health	PhD in Gerontology	15
306	Information Systems	MS in Information Systems	15
307	Information Systems	PhD in Information Systems	15
308	Language	PhD in Language, Literacy and Culture	15
309	Law	JD/PhD in Public Policy	15
310	Mathematics	MS in Applied Mathematics	15
311	Mathematics	PhD in Applied Mathematics	15
312	Mechanical Engineering	MS in Mechanical Engineering	15
313	Mechanical Engineering	PhD in Mechanical Engineering	15
314	Physics	Master of Physics Graduate Program: Condensed Matter Physics	15
315	Physics	PhD in Atmospheric Physics	15
316	Psychology	PhD in Human Services Psychology	15
317	Public Affairs	MPS in Biotechnology	15
318	Public Affairs	MPA/PhD in Public Policy	15
319	Public Management Administration	Master of Public Policy	15
320	Public Policy Analysis	PhD in Public Policy	15
321	Sociology	MA in Applied Sociology	15
322	Statistics	MS in Statistics	15
323	Statistics	PhD in Statistics	15
324	History	MA of History	17
325	Philosophy	Master of Philosophy	17
326	Philosophy	PhD in Philosophy	17
327	Analytics	MS in Analytics	18
328	Bioinfo	MS in Bioinformatics	18
329	Chemical	PhD in Chemical Engineering	18
330	Civil Engineering	MS in Civil Engineering	18
331	Computational Science Engineering	MS in Computational Science and Engineering	18
332	CS	BS in Computer Science 	18
333	CS	MS in Computer Science	18
334	CS	PhD in Computer Science	18
335	CSE	PhD in Computational Science Engineering	18
336	Cybersecurity	MS in Cybersecurity	18
337	Digital Media	MS in Digital Media	18
338	ECE	MS in Electrical and Computer Engineering	18
339	ECE	PhD in Electrical and Computer Engineering	18
340	ECE-Shenzhen	MS in ECE-Shenzhen	18
341	Environmental Engineering	MS in Environmental Engineering	18
342	Human-Centered Computing	PhD in Human-Centered Computing	18
343	Industrial Engineering	MS in Industrial Engineering	18
344	ISE	PhD in Industrial and Systems Engineering	18
345	ITM	PhD in Information Technology Management 	18
346	Joint Georgia Tech & Emory University Biomedical Engineering	Joint Georgia Tech & Emory University Biomedical Engineering	18
347	Materials	PhD in Materials Science and Engineering	18
348	Math	PhD in Mathematics	18
349	ME	MS in Mechanical Engineering	18
350	ME	PhD in Mechanical Engineering	18
351	MID	Master of industrial design	18
352	MSHCI	MS in Human Computer Interaction	18
353	MSOR	MS in Operations Research	18
354	Music Technology	MS in Music Technology	18
355	Nuclear and Radiological Engineering	PhD in Nuclear and Radiological Engineering	18
356	OMSCS	Online Master of Science in Computer Science	18
357	QCF	MS in Quantitative and Computational Finance	18
358	Robotics	MS in Robotics	18
359	Robotics	PhD in Robotics	18
360	Statistics	MS in Statistics	18
361	Supply Chain Engineering	MS in Supply Chain Engineering	18
362	Transportation	PhD in Transportation	18
363	AA	MS in AeroAstro	19
364	Applied Mathematics	PhD in Applied Mathematics	19
365	Business Analytics	Master of Business Analytics	19
366	CEE	Meng in Civil and Environmental Engineering	19
367	Chemical	PhD in Chemical Engineering	19
368	Chemistry	PhD in Chemistry	19
369	CS	MS in Computer Science	19
370	CS	PhD in Computer Science	19
371	EECS	PhD in EECS	19
372	Finance	Master of Finance	19
373	Finance	PhD in Finance	19
374	IDM	MS in Integrated Design & Management	19
375	IDSS	PhD in Social & Engineering Systems	19
376	IT	PhD in Information Technology	19
377	Linguistics	PhD in Linguistics and Philosophy	19
378	Materials	PhD in Materials Science and Engineering	19
379	ME	MS in Mechanical Engineering	19
380	ME	PhD in Mechanical Engineering 	19
381	Media Arts and Sciences	PhD in Media Arts and Sciences	19
382	Media Lab	Media Lab	19
383	NSE	PhD in Nuclear Science and Engineering	19
384	ORC	MS in Operations Research	19
385	Physics	PhD in Physics	19
386	Supply Chain Management	MS in Supply Chain Management	19
387	Technology & Policy	MS in Technology and Policy	19
388	Transportation	PhD in Transportation	19
389	CS	MSc in Computer Science	20
390	CyberSecurity	MS in Cyber Security	20
391	DH	MS in Digital Humanities	20
392	DS	MS in Data Science	20
393	ECE	MS in Electrical and Computer Engineering	20
394	EDEE	PhD in Electrical Engineering	20
395	EDIC	PhD in Computer and Communication Sciences	20
396	EE	Electrical and Electronic Engineering	20
397	Life Science Engineering	Master in Life Sciences Engineering	20
398	Mathematics	MSc in Mathematics	20
399	ME	MSc in Mechanical Engineering	20
400	MFE	Master of Finance engineering 	20
401	MTE	MS in Management of Technology & Entrepreneurship	20
403	Business Intelligence & Analytics	MS in Business Intelligence and Analytics	21
404	CS	MS in Computer Science	21
405	CS	PhD in Computer Science	21
406	DataScience	MS in Data Science	21
407	ECE	MS in Electrical and Computer Engineering	21
408	ECE	PhD in Electrical and Computer Engineering	21
409	Engineering Management	MS in Construction Engineering and Management	21
410	Financial	PhD in Financial Engineering	21
411	IS	MS in Information Systems	21
412	MachineLearning	MS in Machine Learning	21
413	MFE	MS in Financial Engineering	21
414	Ocean	MS in Ocean Engineering	21
415	systems engineering	MEng in Systems Engineering	21
416	Applied Statistics	MS in Applied Statistics	22
417	Business Analytics	MS in Business Analytics	22
418	Construction Project Management	MS in Construction Project Management	22
419	CS	MS in Computer Science	22
420	CS	PhD in Computer Science	22
421	Data Science	MS in Data Science	22
422	ECE	PhD in Electrical and Computer Engineering	22
423	EE	MEng in Electrical and Computer Engineering	22
424	FinMath	MS in Financial Mathematics	22
425	IT	MS in Information Technology	22
426	Marketing&Innovation	MS in Marketing & Innovation	22
427	Materials	MS in Materials Science and Engineering	22
428	Math	PhD in Mathematical Sciences	22
429	MCS	Master of Computer Science	22
430	ME	MS in Mechanical Engineering	22
431	ME	PhD in Mechanical Engineering	22
432	Robotics	MS in Robotics Engineering	22
433	AE	PhD in Aeronautics	23
434	Applied Math	PhD in Applied and Computational Mathematics	23
435	Chemical	PhD in Chemical Engineering	23
436	Chemistry	PhD in Chemistry	23
437	CS	MS in Computer Science	23
438	CS	PhD in Computer Science	23
439	EE	MS in Electronic Engineering	23
440	EE	PhD in Electronic Engineering	23
441	Materials	PhD in Materials	23
442	Physics	PhD in Physics	23
443	BME	PhD in Biomedical Engineering	24
444	Business Analytics	MS In Business Analytics	24
445	CS	MS in Computer Science	24
446	CS	PhD in Computer Science	24
447	EE	MS in Electrical Engineering	24
448	EE	PhD in Electrical Engineering	24
449	IT	MS in Information Technology	24
450	Materials	MS in Materials Engineering	24
451	Math	PhD in Mathematics	24
452	ME	PhD in Mechanical Engineering	24
453	Quantitative Finance and Risk Analytics	MS in Quantitative Finance and Risk Analytics	24
454	Transportation	PhD in Transportation Engineering	24
455	Applied Statistics	MS in Applied Statistics	25
456	CS	MS in Computer Science	25
457	CS	PhD in Computer Science	25
458	Data Science	MS in Data Science	25
459	Game Design and Development	MS in Game Design and Development	25
460	HCI	MS in Human-Computer Interaction	25
461	Image Science	MS in Image Science	25
462	Industrial Design	MA in Industrial Design	25
463	MBA	Master of Business Administration	25
464	Visual Communication Design	MS in Visual Communication Design	25
465	CS	MS in Computer Science	26
466	CS	PhD in Computer Science	26
467	Data Science	Master of Data Science	26
468	Design	Master of Design	26
469	ITM	MS in Information Tech and Management	26
470	CS	MS in Computer Science	27
471	CS	PhD in Computer Science	27
472	IS	MS in Information Systems	27
473	MSIE	MS in Industrial Engineering	27
474	Aerospace	MS in Aerospace Engineering	28
475	Architecture	MS in Naval Architecture	28
476	Biological Engineering	MS in Industrial and Environmental Biotechnology	28
477	Biomedical Engineering	MS in Medical Biotechnology	28
478	BME	MSc in Medical Engineering	28
479	Chemical Engineering	MS in Chemical Engineering for Energy and Environment	28
480	Civil Engineering	MS in Civil and Architectural Engineering	28
481	Communication	MS in Communication Systems	28
482	Computer Science	MS in Information and Network Engineering	28
483	Design	MS in Integrated Product Design	28
484	Electrical Engineering	MS in Electric Power Engineering	28
485	Entrepreneurship	MS in Entrepreneurship and Innovation Management	28
486	Environmental Engineering	MS in Environmental Engineering and Sustainable Infrastructure	28
487	Fine Arts	MS in Architectural Lighting Design	28
488	Machine Learning	Machine Learning	28
489	Management	MS in Production Engineering and Management	28
490	Materials	MS in Engineering Materials Science	28
491	Mathematics	MS in Applied and Computational Mathematics	28
492	Mechanical Engineering	MS in Engineering Mechanics	28
493	MSCR	 Master's Programme, Systems, Control and Robotics	28
494	Nuclear Engineering	MS in Nuclear Energy Engineering	28
495	Physics	MS in Engineering Physics	28
496	Software Engineering	MS in Software Engineering of Distributed Systems	28
497	Urban Planning	MS in Sustainable Urban Planning and Design	28
498	CD	MFA in Communications Design	29
499	Information Experience Design	MS in Information Experience Design	29
500	GlobalHealth	Master in Global Health	30
501	Medicine	Master of Toxicology	30
502	Design	PhD in Art & Design	35
503	Fine Arts	PhD in Art & Design	35
504	Business Analytics	MS in Business Analytics and Project Management	40
505	CS	MS in Computer Science and Engineering	40
506	CS	PhD in Computer Science and Engineering	40
507	Financial Risk Management	MS in Financial Risk Management	40
508	Materials	PhD in Materials Science	40
509	Statistics	MS in Statistics	40
510	Statistics	PhD in Statistics	40
511	BME	PhD in Biomedical Engineering	44
512	Business Analytics	MS in Business Analytics	44
513	Computational Linguistics	MS in Computational Linguistics	44
514	CS	MS in Computer Science	44
515	CS	PhD in Computer Science	44
516	Data Science	MS in Data Science	44
517	ECE	MS in Electrical and Computer Engineering	44
518	ECE	PhD in Electrical and Computer Engineering	44
519	Finance	MS in Finance	44
520	linguistics	BS in Linguistics	44
521	Marketing	MS in Marketing Analytics	44
522	Optics	MS in Optics	44
523	Optics	PhD in Optics	44
524	PublicHealth	PhD in Public Health	44
525	Statistics	MA in Statistics	44
526	Statistics	PhD in Statistics	44
527	TEAM	MS in Technical Entrepreneurship and Management	44
528	Accounting	MSc in Accounting, Valuation & Financial Management	45
529	Economics	MSc in Economics	45
530	Economics	PhD in Economics	45
531	Finance	MSc in Finance	45
532	Finance	PhD in Finance	45
533	Accounting	Master of Professional Accounting (International Student Pathway)	51
534	Area Studies	MA in Canadian and American Studies	51
535	Biological Engineering	MSc in Biotechnology	51
536	Biological Engineering	PhD in Biotechnology	51
537	Biology	Master of Sustainability: Sustainability Science and Society	51
538	Biology	PhD in Biological Sciences	51
539	Chemistry	MSc in Chemistry	51
540	Chemistry	PhD in Chemistry	51
541	Computer Science	MSc in Computer Science	51
542	Economics	Master of Business Economics	51
543	Education	MA in Health and Physical Education	51
544	English	MA in English	51
545	Exercise And Sport Science	MA in Leisure Studies	51
546	Geology	MSc in Earth Sciences	51
547	Geosciences	MA in Geography	51
548	Health	Master of Professional Kinesiology	51
549	History	MA in History	51
550	Language	MA in Applied Linguistics	51
551	Law	MA in Social Justice and Equity Studies	51
552	Materials	MSc in Materials Physics	51
553	Mathematics	MSc in Mathematics and Statistics	51
554	Mba	MBA	51
555	Philosophy	MA in Philosophy	51
556	Physics	MSc in Physics	51
557	Physics	PhD in Physics	51
558	Political Science	MA in Political Science	51
559	Psychology	MA in Psychology	51
560	Psychology	PhD in Psychology	51
561	Public Health	MA in Community Health	51
562	Sociology	MA in Critical Sociology	51
563	Sociology	PhD in Interdisciplinary Humanities	51
564	Architecture	March in Architecture & Urbanism	52
565	Design	MSc in Design + Make	52
566	History	MA in History & Critical Thinking	52
567	Accounting	MAcc (Master of Accountancy)	55
568	Anthropology	MA in Anthropology	55
569	Basic Medicine	MS in Neuroscience	55
570	Basic Medicine	PhD in Neuroscience	55
571	Biology	MS in Biochemistry	55
572	Biology	PhD in Biology	55
573	Biomedical Engineering	MS in Genetics and Biotechnology	55
574	Chemical Engineering	MS in Chemical Engineering	55
575	Chemical Engineering	PhD in Chemical Engineering	55
576	Chemistry	MS in Chemistry	55
577	Chemistry	PhD in Chemistry	55
578	Civil Engineering	MS in Civil Engineering	55
579	Communication	MA in Mass Communication	55
580	Computer Engineering	MS in Electrical and Computer Engineering	55
581	Computer Engineering	PhD in Electrical and Computer Engineering	55
582	Computer Science	MS in Computer Science	55
583	Computer Science	PhD in Computer Science	55
584	Drama And Film	MM in Composition	55
585	ECE	MS in Electrical and Computer Engineering	55
586	Education	MA in Art Education	55
587	Education	PhD in Educational Inquiry, Measurement and Evaluation	55
588	English	MA in English	55
589	Entrepreneurship	MEd in Educational Leadership	55
590	Environmental Science	MS in Environmental Science	55
591	Exercise And Sport Science	MS in Exercise Sciences	55
592	Exercise And Sport Science	PhD in Exercise Sciences	55
593	Fine Art	MFA in Studio Art	55
594	Food Science And Technology	MS in Food Science	55
595	Geosciences	MS in Geology	55
596	Health	MS in Marriage and Family Therapy	55
597	Health	PhD in Marriage and Family Therapy	55
598	Information Systems	MISM ( Master of Information Systems Management)	55
599	Law	JD (Juris Doctor)	55
600	Law	LLM (Master of Laws)	55
601	Literature	MA in Comparative Studies	55
602	Mathematics	MS in Mathematics	55
603	Mathematics	PhD in Mathematics	55
604	Mba	MBA	55
605	Mechanical Engineering	MS in Mechanical Engineering	55
606	Mechanical Engineering	PhD in Mechanical Engineering	55
607	Medicine	PhD in Clinical Psychology	55
608	Music And Dance	MA in Musicology	55
609	Natural Conservation And Ecology	MS in Wildlife and Wildlands Conservation	55
610	Natural Conservation And Ecology	PhD in Wildlife and Wildlands Conservation	55
611	Physics	MS in Physics	55
612	Physics	PhD in Physics	55
613	Psychology	MS in Instructional Psychology and Technology	55
614	Psychology	PhD in Psychology	55
615	Public Health	MPH (Mater of Public Health)	55
616	Public Management Administration	MPA (Master of Public Administration)	55
617	Social Work	MSW (Master of Social Work)	55
618	Sociology	MS in Sociology	55
619	Sociology	PhD in Marriage, Family and Human Development	55
620	Statistics	MS in Statistics	55
621	Water Resources Engineering	PhD in Civil Engineering	55
622	Applied Data Science	MS in Applied Data Science	63
623	Applied Statistics	MS in Applied Statistics	63
624	Biology	MS in Biology	63
625	business analytics	MS in Business Analytics	63
626	CE	MS in Computer Engineering	63
627	ChemEng	MS in Chemical Engineering	63
628	CS	MS in Computer Science	63
629	CS	Phd in Computer Science	63
630	Cybersecurity	MS in Cybersecurity	63
631	EE	MS in Electrical Engineering	63
632	InfoManagement	MS in Information Management	63
633	Math	MS in Mathematics	63
634	MPA	MS in Professional Accounting	63
635	PR	MS in Public Relations	63
636	Accounting	MPAcc (Master of Professional Accounting)	64
637	Agriculture	MAgr in Food Science	64
638	Agriculture	PhD in Small Animal Clinical Sciences	64
639	Anthropology	MA in Anthropology	64
640	Area Studies	MA in Indigenous Studies	64
641	Area Studies	PhD in Indigenous Studies	64
642	Biology	MSc in Anatomy and Cell Biology	64
643	Biology	PhD in Anatomy and Cell Biology	64
644	Chemistry	MSc in Chemistry	64
645	Chemistry	PhD in Chemistry	64
646	Computer Science	MSc in Computer Science	64
647	Computer Science	PhD in Computer Science	64
648	Economics	MSc in Agricultural Economics	64
649	Economics	PhD in Agricultural Economics	64
650	Education	MEd in Educational Administration	64
651	Education	PhD in Educational Administration	64
652	Electrical Engineering	MEng in Electrical Engineering	64
653	Electrical Engineering	PhD in Electrical Engineering	64
654	English	MA in English	64
655	English	PhD in English	64
656	Entrepreneurship	MEd in Leadership in Post-Secondary Education	64
657	Exercise And Sport Science	MSc in Kinesiology	64
658	Exercise And Sport Science	PhD in Kinesiology	64
659	Finance	MSc in Finance	64
660	Fine Art	MFA in Studio Art	64
661	Geography	PhD in Geography	64
662	Geophysics	MSc in Geography	64
663	History	MA in Archaeology	64
664	History	PhD in History	64
665	Law	Master of Laws (LL.M.)	64
666	Marketing	MSc in Marketing	64
667	Mathematics	Master of Mathematics	64
668	Mathematics	PhD in Mathematics	64
669	Mba	MBA	64
670	Medicine	PhD in Pharmacology	64
671	Nursing	Master of Nursing - Primary Health Care Nurse Practitioner	64
672	Nursing	Doctor of Philosophy in Nursing	64
673	Philosophy	MA in Philosophy	64
674	Political Science	MA in Political Studies	64
675	Psychology	PhD in Psychology	64
676	Public Health	Master of Public Health	64
677	Public Health	PhD in Community and Population Health Sciences	64
678	Religion	MA in Religion and Culture	64
679	Sociology	MA in Sociology	64
680	Sociology	PhD in Sociology	64
681	Veterinary Medicine	Master of Veterinary Science in Veterinary Pathology	64
682	Veterinary Medicine	PhD in Veterinary Pathology	64
683	Water Resources Engineering	Master of Water Security	64
684	Philosophy	MPhil of Philosophy	68
685	Philosophy	PhD in Philosophy	68
686	Astronomy	MS in Astronomy and Astrophysics	69
687	Business Analytics	MS in Business Analytics	69
688	CE	MS in Computer Engineering (Computer Systems)	69
689	CivilEng	PhD in Civil, Environmental and Sustainable Engineering	69
690	Construction Management and Technology	MS in Construction Management and Technology	69
691	CS	BS in Computer Science	69
692	CS	MS in Computer Science	69
693	CS	PhD in Computer Science	69
694	EE	MS in Electrical Engineering	69
695	EE	PhD in Electrical Engineering	69
696	Indusrial Engineering	MS in Indusrial Engineering	69
697	Industrial Engineering	Phd in Industrial Engineering	69
698	IS	PhD in Information Systems	69
699	Materials	PhD in Materials Science and Engineering	69
700	MIS	MS in Information System Management	69
701	Robotics	MS in Robotics and Autonomous Systems	69
702	SE	MS in Software Engineering	69
703	Statistics	PhD in Statistics	69
704	Accounting	Master of Accountancy	71
705	Aerospace	MAE (Master of Aerospace Engineering)	71
706	Aerospace	PhD in Aerospace Engineering	71
707	Agriculture	MAg in Poultry Science	71
708	Agriculture	PhD in Forestry	71
709	Animal Science	MS in Poultry Science	71
710	Animal Science	PhD in Poultry Science	71
711	Architecture	Master of Landscape Architecture	71
712	Area Studies	Master of Hispanic Studies (MHS)	71
713	Biological Engineering	MS in Biosystems Engineering	71
714	Biology	MAg in Entomology	71
715	Biology	PhD in Entomology	71
716	Chemical Engineering	MS in Chemical Engineering	71
717	Chemical Engineering	PhD in Chemical Engineering	71
718	Chemistry	MS in Chemistry	71
719	Chemistry	PhD in Chemistry	71
720	Civil Engineering	MS in Civil Engineering	71
721	Civil Engineering	PhD in Civil Engineering	71
722	Communication	Master of Technical and Professional Communication (MTPC)	71
723	CyberSecurity	MS in Cybersecurity Engineering	71
724	Design	MID (Master of Industrial Design)	71
725	Economics	MS in Economics	71
726	Economics	PhD in Applied Economics, Liberal Arts	71
727	Education	MEd/MS in Reading Education	71
728	Education	PhD in Administration of Elementary and Secondary Education	71
729	English	MA in English	71
730	English	PhD in English	71
731	Environmental Science	Master of Natural Resources	71
732	Exercise And Sport Science	PhD in Kinesiology	71
733	Finance	MS in Finance	71
734	Finance	PhD in Business, Finance concentration	71
735	Fine Arts	MS in Consumer and Design Sciences	71
736	Fine Arts	PhD in Consumer and Design Sciences	71
737	Geology	MS in Geology	71
738	Health	MS in Exercise Science	71
739	Health	Doctor of Audiology (AuD)	71
740	History	MA in History	71
741	History	PhD in History	71
742	Industrial Engineering	MS in Industrial and Systems Engineering	71
743	Industrial Engineering	PhD in Industrial and Systems Engineering	71
744	Information Systems	MS in Information Systems	71
745	Information Systems	PhD in Business, Information Systems concentration	71
746	Language	MA in Spanish	71
747	Marketing	MEd in Business/Marketing Education	71
748	Materials	MME (Master of Materials Engineering)	71
749	Materials	PhD in Materials Engineering	71
750	Mathematics	MS in Mathematics	71
751	Mathematics	PhD in Mathematics	71
752	Mba	MBA	71
753	Mechanical Engineering	MME (Master of Mechanical Engineering)	71
754	Mechanical Engineering	PhD in Mechanical Engineering	71
755	Nutrition	MS in Nutrition	71
756	Pharmacy	PhD in Pharmaceutical Sciences	71
757	Physics	Master of Physics: Condensed Matter Physics	71
758	Physics	PhD in Physics: Plasma and Fusion	71
759	Plant Science	MS in Horticulture	71
760	Psychology	PhD in Cognitive and Behavioral Sciences	71
761	Public Health	MS in Health Outcomes Research and Policy	71
762	Public Health	PhD in Nutrition	71
763	Social Work	Master of Social Work	71
764	Social Work	PhD in Human Development and Family Studies	71
765	Sociology	MA in Sociology	71
766	Statistics	Master of Probability and Statistics	71
767	Urban Planning	Master of Community Planning	71
768	Water Resources Engineering	MCE (Master of Civil Engineering)	71
769	CS	MS in Computer Science	76
770	CS	PhD in Computer Science	76
771	Accounting	MS in Accounting	79
772	Childhood	MEd in Early Childhood Education	79
773	Finance	MS in Finance	79
774	Social Work	MS in Social Work	79
775	Advertising	MS in Advertising	80
776	AI	MS in Artificial Intelligence	80
777	Applied Business Analytics	MS in Applied Business Analytics	80
778	Applied Mathematics	PhD in Pure and Applied Mathematics	80
779	Bioinfo	MS in Bioinformatics	80
780	Bioinformatics	PhD in Bioinformatics	80
781	Biostatistics	MS in Biostatistics	80
782	Biostatistics	PhD in Biostatistics	80
783	BME	PhD in Biomedical Engineering	80
784	Business Analytics	MS in Business Analytics	80
785	Computer Information Systems	MS in Computer Information Systems	80
786	CS	MS in Computer Science	80
787	CS	PhD in Computer Science	80
788	CS-Cyber Security	MS in CS-Cyber Security	80
789	CS-Data-Centric Computing	MS in Computer Science with Specialization in Data-Centric Computing	80
790	ECE	MS in Electronic Engineering	80
791	ECE	PhD in Electronic Engineering	80
792	Economics	Master of Arts in Economics	80
793	Educational Leadership and Policy Studies	EdD in Educational Leadership & Policy Studies	80
794	Marketing	MS in Global Marketing Management	80
795	Materials	MS in Materials Science and Engineering	80
796	Math	PhD in Mathematics	80
797	Mathematical Finance	MS in Mathematical Finance	80
798	MCBB	MA in in Molecular Biology, Cell Biology and Biochemistry	80
799	MCP	Master of City Planning	80
800	MCR	MS in Marketing Communication Research	80
801	ME	MS in Mechanical Engineering	80
802	ME	PhD in Mechanical Engineering	80
803	MPH	MPH in Epidemiology and Biostatistics	80
804	MSMS	MS in Media Science with a concentration in Marketing Communication Research	80
805	PR	MS in Public Relations	80
806	PublicHealth	PhD in Public Health	80
807	RemoteSensing	MS in Remote Sensing & Geospatial Sciences	80
808	SCM	MS in Supply Chain Management	80
809	SE	MS in Systems Engineering	80
810	Social Work	Master of Social Work	80
811	Software Development	MS in Software Development	80
812	Statistical Practice	MS in Statistical Practice	80
813	Statistical Practise	MS in Statistical Practise	80
814	Statistics	MA in Statistics	80
815	Statistics	PhD in Statistics	80
816	Business Analytics	MS in Business Analytics	83
817	Computational Linguistics	MA in Computational Linguistics	83
818	CS	MS in the Computer Sciences	83
819	CS	PhD in Computer Science	83
820	MA in International Economics and Finance	MA in International Economics and Finance	83
821	Molecular & Cell Biology	MS in Molecular and Cell Biology	83
822	MSF	MS in Finance	83
823	Psychology	MA in Psychology	83
824	Strategic Analysis	MS in Strategic Analytics	83
825	Applied Math	PhD in Applied Mathematics	84
826	Biostat	MS in Biostat	84
827	Biostatistics	PhD in Biostatistics	84
828	BME	MS in Biomedical Engineering	84
829	BME	PhD in Biomedical Engineering	84
830	CS	ScM - Computer Science	84
831	CS	Phd in Computer Science	84
832	DataScience	MS in Data Science	84
833	DS	MS in Data Science	84
834	Engineering-ECE	MS in Engineering-ECE	84
835	Engineering-ECE	PhD in Engineering-ECE	84
836	Fluids and Thermal Science	PhD in Fluids and Thermal Science	84
837	MSAR	Master of Social Analysis and Research 	84
838	Physics	MS in Physics	84
839	Physics	PhD in Physics	84
840	Program in Innovation Management and Entrepreneurship	MS in Innovation Management and Entrepreneurship	84
841	EM	MS in Engineering Management	91
842	MSCS	MS in Computer Science	91
843	Aerosol Particle	PhD in Aerosol Particle	99
844	Arts Management	Master of Arts Management	99
845	BIDA	Business Intelligence & Data Analytics	99
846	Biosciences	Phd in Biological Sciences	99
847	BME	MS in Biomedical Engineering	99
848	BME	PhD in Biomedical Engineering	99
849	CEE-CS	MS in CEE and Integrated Study in Computer Science	99
850	ChemEng	Master of Chemical Engineering	99
851	CivilEng	MS in Civil and Environmental Engineering	99
852	CivilEng	PhD in Civil and Environmental Engineering	99
853	Computational Biology	MS in Computational Biology	99
854	Computational Design	MS in Computational Design	99
855	CPCB	PhD in Computational Biology	99
856	CS	MS in Computer Science	99
857	CS	PhD in Computer Science	99
858	Design	Master of Arts in Design	99
859	ECE	MS in Electrical and Computer Engineering	99
860	ECE	PhD in Electrical and Computer Engineering	99
861	ECE-SV	MS in ECE in Silicon Valley	99
862	ETC	Entertainment Technology Center	99
863	ETIM	MS in Engineering and Technology Innovation Management	99
864	ETIM-ECE-Dual	ETIM Dual Masters Degree	99
865	HCI	Master of Human-Computer Interaction	99
866	HCI	PhD in Human-Computer Interaction	99
867	INI-MSIN	MS in Information Networking	99
868	ISM	PhD in Information System Management	99
869	LT	Master of Language Technologies	99
870	LT	PhD in Language Technologies	99
871	Material	MS in Materials Science	99
872	Materials	PhD in Materials Science	99
873	Math	PhD in Mathematical Science	99
874	MCDS	Master of Computational Data Science	99
875	MDes	Master of Design	99
876	ME	MS in Mechanical Engineering	99
877	ME	PhD in Mechanical Engineering	99
878	METALS	Masters of Educational Technology and Applied Learning Science	99
879	MIIPS	Master of Integrated Innovation for Products & Services	99
880	MIIS	Master of Science in Intelligent Information Systems	99
881	MISM	Master of Information Systems Management	99
882	MISM-Global-21Month	Master of Information Systems Management (Global) 21-Month Track	99
883	MITS	Master of Information Technology Strategy	99
884	ML	MS in Machine Learning	99
885	ML	PhD in Machine Learning	99
886	MPS	Master of Professional Studies	99
887	MRSD	MS in Robotic Systems Development	99
888	MSAII	MS in Artificial Intelligence and Innovation	99
889	MSAS	MS in Automated Science: Biological Experimentation	99
890	MSCF	MS in Computational Finance	99
891	MSCV	MS in Computer Vision	99
892	MSE	Master of Software Engineering	99
893	MSE-Embedded Systems	MSE – Embedded Systems	99
894	MSE-Pro	MSE for Professional	99
895	MSE-Scalable Systems	MSE – Scalable Systems	99
896	MSHCA	MS in Health Care Analytics & Information Technology	99
897	MSIS	MS in Information Security	99
898	MSISPM	MS in Information Security Policy & Management	99
899	MSIT	MS in Information Technology	99
900	MSIT-PE	MSIT in Privacy Engineering	99
901	MSMITE(MSIT-MOB)	MS in Mobile and IoT Engineering	99
902	MSMT	MS in Music and Technology	99
903	MSPPM	MS in Public Policy & Management	99
904	MSR	MS in Robotics	99
905	MSSE-SV	MS in Software Engineering - Silicon Valley	99
906	MSSM-SV	MS in Software Management- Silicon Valley	99
907	Robotics	PhD in Robotics	99
908	SE	Master of Science in Software Engineering	99
909	Statistical Practice	Master of Statistical Practice	99
910	Statistics	PhD in Statistics	99
911	Aerospace	MS in Aeronautical Engineering	100
912	Aerospace	PhD in Aerospace Engineering	100
913	Architectural Engineering	MS in Building and Architectural Engineering	100
914	Architecture	MS in Landscape Architecture: Land Landscape Heritage	100
915	Architecture	PhD in Architecture, Built Environment and Construction Engineering	100
916	Biological Engineering	PhD in Bioengineering	100
917	Biomedical Engineering	MS in Biomedical Engineering	100
918	Business Analytics	Master in Business Analytics and Big Data	100
919	Business Analytics	PhD in Data Analytics and Decision Sciences	100
920	Chemical Engineering	MS in Chemical Engineering	100
921	Chemistry	PhD in Industrial Chemistry and Chemical Engineering	100
922	Civil Engineering	PhD in Structural Seismic and Geotechnical Engineering	100
923	Computer Engineering	MS in Computer Science and Engineering	100
924	Design	MS in Integrated Product Design	100
925	Design	PhD in Architectural, Urban and Interior Design	100
926	Electrical Engineering	MS in Electrical Engineering	100
927	Electrical Engineering	PhD in Electrical Engineering	100
928	Electronic Engineering	MS in Electronics Engineering	100
929	Environmental Engineering	PhD in Environmental and Infrastructure Engineering	100
930	Finance	Master in Fintech, Finance and Digital Innovation	100
931	Fine Arts	MS in Architectural Design and History	100
932	Geoinformatics	MS in Geoinformatics Engineering	100
933	Industrial Engineering	MS in Product-Service System Design/MS in Management Engineering	100
934	Information Systems	PhD in Information Technology	100
935	Marketing	Master in Marketing Management, Omnichannel and Consumer Analytics	100
936	Materials	MS in Materials Engineering and Nanotechnology	100
937	Materials	PhD in Materials Engineering	100
938	Mba	MBA	100
939	Mechanical Engineering	MS in Mechanical Engineering	100
940	Mechanical Engineering	PhD in Mechanical Engineering	100
941	Music And Dance	MS in Music and Acoustic Engineering	100
942	Nuclear Engineering	MS in Nuclear Engineering	100
943	Physics	MS in Engineering Physics	100
944	Physics	PhD in Physics	100
945	Supply Chain And Logistics	Master in Supply Chain and Procurement Management	100
946	Urban Planning	MS in Environmental and Land Planning Engineering	100
947	Water Resources Engineering	MS in Civil Engineering for Risk Mitigation	100
948	BA	MS in Business Analysis 	104
949	BME	PhD in Biomedical Engineering	104
950	CE	MS in Computer Engineering	104
951	CS	MS in Computer Science	104
952	EE	MS in Electrical Engineering	104
953	EE	PhD in Electronic Engineering	104
954	Finance	MSM in Finance	104
955	Math	PhD in Mathematics	104
956	Nursing	PhD in Nursing	104
957	ORSCM	MS in Operation Research and Supply Chain Management	104
958	Systems & Control Engineering	MS in Systems and Control Engineering	104
959	Systems Biology and Bioinformatics	MS in Systems Biology and Bioinformatics	104
960	CS	PhD in Computer Science	105
961	EE	MS in Electrical Engineering	105
962	EE	PhD in Electrical Engineering	105
963	BME	PhD in Biomedical Engineering (5 years)	106
964	EE	PhD in Electrical Engineering	106
965	Biomedical	PhD in Biomolecular Engineering and Bioinformatics	111
966	CE	MS in Computer Engineering	111
967	Computational Media	PhD in Computational Media	111
968	CS	MS in Computer Science and Engineering	111
969	CS	PhD in Computer Science and Engineering	111
970	TIM	PhD in Technology and Information Management	111
971	BME	PhD in Biomedical Engineering	112
972	Data Science	PhD in Data Science	112
973	Media and Communication	PhD in Media and Communication	112
974	MFE	MS in Financial Engineering	112
975	MKT	MS in Marketing	112
976	Geography	PhD in Geography	118
977	IT	MS in Information Technology	118
978	MSBA	MS in Business analytics	118
979	Construction Science and Management	Master of Construction Science and Management	119
980	CS	MS in Computer Science	119
981	ECE	PhD in Electrical Engineering	119
982	MBA	MBA	119
983	CS-Professional	MS in Computer Science-Professional	123
984	Economics	Master of Arts in Economics	123
985	Stat	PhD in Statistics	123
986	ECE	Phd in Electrical Engineering	126
987	Statistics	PhD in Statistics	126
988	Anthropology	MA in Anthropology	129
989	Anthropology	PhD in Anthropology	129
990	Area Studies	MA in Hispanic Studies	129
991	Biology	MSc in Biochemistry and Microbiology	129
992	Biology	PhD in Biology	129
993	Chemistry	MSc in Chemistry	129
994	Chemistry	PhD in Chemistry	129
995	Computer Engineering	MEng in Electrical and Computer Engineering	129
996	Computer Engineering	PhD in Electrical and Computer Engineering	129
997	Computer Science	MSc in Computer Science	129
998	Computer Science	PhD in Computer Science	129
999	Data Science	MEng in Applied Data Science	129
1000	Drama And Film	MA in Theatre	129
1001	Drama And Film	PhD in Theatre	129
1002	Economics	MA in Economics	129
1003	Economics	PhD in Economics	129
1004	Education	MEd in Curriculum and Instruction 	129
1005	Education	PhD in Curriculum and Instruction	129
1006	English	MA in English	129
1007	English	PhD in English	129
1008	Entrepreneurship	MA in Leadership Studies	129
1009	Entrepreneurship	PhD in Leadership Studies	129
1010	Environmental Science	MSc in Environmental Studies	129
1011	Environmental Science	PhD in Environmental Studies	129
1012	Fine Art	MFA in Studio Art	129
1013	Fine Arts	MA in Music	129
1014	Fine Arts	PhD in Musicology	129
1015	Geology	MSc in Earth and Ocean Sciences	129
1016	Geophysics	MSc in Geography	129
1017	Geophysics	PhD in Geography	129
1018	Geosciences	PhD in Earth and Ocean Sciences	129
1019	Health	MSc in Kinesiology	129
1020	Health	PhD in Kinesiology	129
1021	History	MA in Art History and Visual Studies	129
1022	History	PhD in Art History and Visual Studies	129
1023	Language	Master of Indigenous Language Revitalization	129
1024	Law	LLM (Master of Laws)	129
1025	Law	PhD in Law	129
1026	Mathematics	MSc in Mathematics and Statistics	129
1027	Mathematics	PhD in Mathematics and Statistics	129
1028	Mba	MBA	129
1029	Mechanical Engineering	MASc in Mechanical Engineering	129
1030	Mechanical Engineering	PhD in Mechanical Engineering	129
1031	Music And Dance	MMus in Music Technology	129
1032	Music And Dance	PhD in Musicology with Performance	129
1033	Nursing	Master of Nursing	129
1034	Nursing	PhD in Nursing	129
1035	Philosophy	MA in Philosophy	129
1036	Philosophy	PhD in Philosophy	129
1037	Physics	MSc in Condensed Matter Physics: Theoretical Condensed Matter  Physics	129
1038	Physics	PhD in Astronomy	129
1039	Political Science	MA in Cultural, Social and Political Thought	129
1040	Political Science	PhD in Cultural, Social and Political Thought	129
1041	Psychology	MA in Psychology	129
1042	Psychology	PhD in Educational Psychology	129
1043	Public Affairs	MPA On Campus	129
1044	Public Affairs	PhD in Public Administration	129
1045	Public Health	Masters of Public Health	129
1046	Social Work	Master of Social Work (MSW)-Advanced program	129
1047	Sociology	MA in Cultural, Social and Political Thought Program (Home Department:Political Science)	129
1048	Sociology	PhD in Sociology	129
1049	Water Resources Engineering	MASc in Civil Engineering	129
1050	Water Resources Engineering	PhD in Civil Engineering	129
1051	Accounting	MPS in Management – Accounting	135
1052	AEM	MPS in Applied Economics and Management	135
1053	Applied Physics	PhD in Applied Physics	135
1054	Applied Statistics	MPS in Applied Statistics: Data Science	135
1055	BCMB	Biochemistry, Structural Biology, Cell Biology, Developmental Biology and Molecular Biology	135
1056	Biological and Environmental Engineering	MS in Biological and Environmental Engineering	135
1057	Biostat&DS	MS in Biostatistics and Data Science	135
1058	BME	MEng in Biomedical Engineering	135
1059	CFEM	Financial Engineering Concentration and Cornell Financial Engineering Manhattan	135
1060	Chemical	MS in Chemical Engineering	135
1061	Civil Engineering	MS in Civil and Environmental Engineering	135
1062	CivilEnv	MEng in Civil and Environmental Engineering	135
1063	Communication	PhD in Communication	135
1064	CompBio	PhD in Computational Biology	135
1065	CS	MEng in Computer Science	135
1066	CS	MS in Computer Science	135
1067	CS	PhD in Computer Science	135
1068	Data Analytics	Meng in Data Analytics	135
1069	DP	MA in Developmental Psychology	135
1070	ECE	MEng in Electrical and Computer Engineering	135
1071	ECE	PhD in Electrical and Computer Engineering	135
1072	EM	Meng in Engineering Management	135
1073	Health Informatics	MS in Health Informatics	135
1074	HER	MS in Human Environment Relations	135
1075	IEOR	PhD in Operations Research and Information Engineering	135
1076	InfoSci	PhD in Information Science	135
1077	Materials	MS in Materials Science and Engineering	135
1078	Materials	PhD in Materials Science and Engineering	135
1079	ME	MEng in Mechanical Engineering	135
1080	ME	MS in Mechanical Engineering	135
1081	ME	PhD in Mechanical Engineering	135
1082	MILR	Masters in Human Resource Studies	135
1083	MPA	Master of Public Administration	135
1084	MPS-IS	MPS in Information Science	135
1085	MPS-Management	MPS in Management	135
1086	MS-CB	MS in Computational Biology	135
1087	ORIE	MS in Industrial and Systems Engineering	135
1088	Physics	PhD in Physics	135
1089	Statistics	PhD in Statistics	135
1090	System Engineering	Meng in Systems Engineering	135
1091	Accounting	MS in Accountancy	136
1092	MENG	Engineering (MENG)	136
1093	Water Resources Engineering	MS in Civil Engineering	136
1094	CS	MS in Computer Science	139
1095	CS	PhD in Computer Science	139
1096	CSDA	MS in CS with Concentration in Digital Arts	139
1097	Engineering-EE	PhD in Engineering	139
1098	Liberal Studies	MA in Liberal Studies	139
1099	MSEM	MS in Engineering Management	139
1100	QBS	MS in Quantitative Biomedical Sciences	139
1101	QBS	PhD in Quantitative Biomedical Sciences	139
1102	Game Programming	MS in Game Programming	141
1103	HCI	MS in Human-Computer Interaction	141
1104	Predictive Analytics	MS in Predictive Analytics	141
1105	Biostatistics	PhD in Biostatistics	143
1106	CS	MS in Computer Science	143
1107	EE	PhD in Electrical and Computer Engineering	143
1108	IS	PhD in Information Sciences	143
1109	Material	MS in Materials Science and Engineering	143
1110	Analytical Political Economy	MA in Analytical Political Economy	144
1111	Biostatistics	Master of Biostatistics	144
1112	Biostatistics	PhD in Biostatistics	144
1113	BME	MS in Biomedical Engineering	144
1114	Business Analytics	MQM in Business Analytics	144
1115	Chemistry	PhD in Chemistry	144
1116	Civil and Environmental Engineering	MS in Civil and Environmental Engineering	144
1117	Civil Engineering	MS in Civil Engineering	144
1118	CMAC	MA in Computational Media and art culture	144
1119	Computational Biology and Bioinformatics	PhD in Computational Biology and Bioinformatics	144
1120	CS	MS in Computer Science	144
1121	CS	PhD in Computer Science	144
1122	ECE	Meng in Electrical and Computer Engineering	144
1123	ECE	MS in Electrical and Computer Engineering	144
1124	ECE-Kunshan	MS in Electrical and Computer Engineering-Kunshan	144
1125	Economics	MA in Economics	144
1126	Economics & Computation	MS in Economics and Computation	144
1127	EE	PhD in Electrical and Computer Engineering	144
1128	FinTech	Meng in Financial Technology	144
1129	FinTech	Master of Engineering in Financial Technology	144
1130	Management Studies	Master of Management Studies	144
1131	Materials	MS in Materials Science and Engineering	144
1132	Materials	PhD in Materials Science	144
1133	Math	PhD in Mathematics	144
1134	ME	MEng in Mechanical Engineering	144
1135	MEM	MPP/Master of Environmental Management	144
1136	MEMS	MS in Mechanical Engineering and Materials Science	144
1137	MIDP	Master of International Development Policy Program	144
1138	MIDS	Master in Interdisciplinary Data Science	144
1139	MPP	Master of Public Policy	144
1140	MQM	MQM:Business Analytics	144
1141	Statistical and Economic Modeling	MS in Statistical and Economic Modeling	144
1142	Statistics	MS in Statistical Science	144
1143	Statistics	PhD in Statistical Science	144
1144	Electrical Engineering	MS/PhD Electronic Engineering	148
1145	Electronic Engineering	Master of Electronic Engineering	148
1146	Electronic Engineering	PhD in Electronic Engineering	148
1147	Mechanical Engineering	Master of Mechanical Engineering	148
1148	Mechanical Engineering	PhD in Mechanical Engineering	148
1149	Analytics	MS in Analytics	151
1150	AppliedEconomics	Master of Applied Economics	151
1151	Bioinfo	MS in Bioinformatics	151
1152	Biostat	MS in Biostatistics	151
1153	Communication	MS in Communication, Culture, and Technology 	151
1154	CS	MS in Computer Science	151
1155	CS	PhD in Computer Science	151
1156	Data Science and Analytics	MS in Data Science and Analytics	151
1157	Economics	Masters of Science in Economics	151
1158	IMC	MS in Integrated Marketing Communications	151
1159	Linguistics	MS in Applied Linguistics	151
1160	Mathematics & Statistics	MS in Mathematics and Statistics	151
1161	Public Policy	Master of Public Policy	151
1162	Economics	MS in Economics and Finance: Economics Program	152
1163	MPFM	MS in Specialized Economic Analysis: Macroeconomic Policy and Financial Markets	152
1164	TFD	MS in Specialized Economic Analysis: International Trade, Finance, and Development	152
1165	Aquaculture	PhD in Aquaculture	153
1166	Biomedical Engineering	PhD in Biotechnology	153
1167	Chemistry	PhD in Theoretical Chemistry and Computational Modelling	153
1168	Communication	PhD in Information and Communication	153
1169	Economics	PhD in Economics	153
1170	Education	PhD in Physical Activity Physical Education and Sport	153
1171	Geosciences	PhD in Earth Sciences	153
1172	History	PhD in History of Science	153
1173	Language	PhD in Cognitive Science and Language	153
1174	Literature	PhD in Contemporary Philosophy and Classical Studies	153
1175	Materials	PhD in Nanosciences	153
1176	Nursing	PhD in Nursing and Health	153
1177	Nutrition	PhD in Food and Nutrition	153
1178	Physics	PhD in Physics	153
1179	Political Science	PhD in Law and Political Science	153
1180	Psychology	PhD in Social and Organizational Psychology	153
1181	Public Health	PhD in International Doctorate in Transdisciplinary Global Health Solutions	153
1182	Sociology	PhD in Gender Studies in Cultures Societies and Policies	153
1183	Bioinformatics	PhD in Bioinformatics	156
1184	Biostatistics	Master of Public Health in Biostatistics	156
1185	Biostatistics	Master of Science in Public Health in Biostatistics	156
1186	Biostatistics	PhD in Biostatistics	156
1187	CS	MS in Computer Science	156
1188	CS	PhD in Computer Science	156
1189	Epidemiology	MS in Epidemiology	156
1190	ISOM	PhD in Information Systems and Operations Management	156
1191	Math	MS in Mathematics	156
1192	MSBA	MS in Business Analytics	156
1193	Earth Science	PhD in Earth Science	159
1194	IS	Master of Science in Information	159
1195	Materials	PhD in Materials Science and Engineering	159
1196	Statistics	MS in Statistics: Statistical Data Science	159
1197	Statistics	PhD in Statistics	159
1198	AppliedPsychological	MS in Applied Psychological Methods	160
1199	BusinessAnalytics	MS in Business Analytics	160
1200	CS	MS in Computer Science	160
1201	Data Science	MS in Data Science	160
1202	Economics	PHD in Economics	160
1203	MSGF	MS in Global Finance	160
1204	MSMI	MS in Marketing Intelligence	160
1205	MSQF	MS in Quantitative Finance	160
1206	CS	MA in Computer Game	165
1207	CS	PhD in Computer Science	165
1208	Economics	PhD in Economics	165
1209	Statistics	PhD in Statistical Science	165
1210	Asian Studies	MA in Asian Studies	166
1211	Biostatistics	MPH in Biostatistics	166
1212	Biostatistics	MPH in Biostatistics	166
1213	Business Analytics	MS in Business Analytics	166
1214	CS	MS in Computer Science	166
1215	CS	PhD in Computer Science	166
1216	CS-Cyber Security	MS in Computer Science-Cybersecurity	166
1217	Data Science	MS in Data Science	166
1218	EE	MS in Electrical Engineering	166
1219	English	MA in English	166
1220	International Affairs	MA in International Affairs	166
1221	IST	MS in Information Systems Technology	166
1222	ME	MS in Mechanical and Aerospace Engineering	166
1223	MPH	Master in Public Health	166
1224	MSF	MS in Finance	166
1225	Physics	PhD in Physics	166
1226	Statistics	MS in Statistics	166
1227	Statistics	PhD in Statistics	166
1228	CS	PhD in Computer Science	167
1229	Math&Stat	PhD in Mathematics and Statistics	167
1230	Biostat	PhD in Biostatistics	171
1231	Biostatistics	MS in Biostatistics	171
1232	Biostatistics	PhD in Biostatistics	171
1233	SBMI	PhD in Biomedical Informatics	171
1234	Accounting	MS in Accounting	172
1235	Biology	MS in Biological Sciences: Integrative and Organismal Biology	172
1236	Biology	PhD in Molecular and Evolutionary Systems Biology	172
1237	Chemical Engineering	MEng in Chemical Engineering	172
1238	Chemical Engineering	PhD in Chemical Engineering	172
1239	Chemistry	MS in Chemistry	172
1240	Chemistry	PhD in Chemistry	172
1241	Computer Engineering	MEng in Electrical and Computer Engineering	172
1242	Computer Engineering	PhD in Electrical and Computer Engineering	172
1243	Computer Science	MS in Computer Science	172
1244	Computer Science	PhD in Computer Science	172
1245	Economics	MA in Analytical Economics	172
1246	Economics	PhD in Economics	172
1247	Education	MEd in Educational Studies (Manchester)	172
1248	Education	PhD in Education	172
1249	English	MA in English: English Studies	172
1250	English	PhD in English: Literature	172
1251	Environmental Engineering	MS in Ocean Engineering	172
1252	Environmental Engineering	PhD in Ocean Engineering	172
1253	Environmental Science	MS in Natural Resources	172
1254	Exercise And Sport Science	MS in Kinesiology	172
1255	Fine Arts	MA in Music: Musicology	172
1256	Fine Arts	PhD in English (Composition)	172
1257	Geosciences	MS in Earth Sciences: Geology	172
1258	Geosciences	PhD in Earth and Environmental Sciences	172
1259	History	MA in History	172
1260	History	PhD in History	172
1261	Industrial Engineering	PhD in Systems Engineering	172
1262	Information Systems	MS in Information Technology in Manchester	172
1263	Language	MA in Spanish	172
1264	Law	JD (Juris Doctor)	172
1265	Law	LLM (Master of Laws)	172
1266	Materials	MS in Materials Science	172
1267	Materials	PhD in Materials Science and Engineering	172
1268	Mathematics	MS in Mathematics	172
1269	Mathematics	PhD in Mathematics	172
1270	Mba	MBA (Master of Bussiness Administration)	172
1271	Mechanical Engineering	MS in Mechanical Engineering	172
1272	Mechanical Engineering	PhD in Mechanical Engineering	172
1273	Oceanography	MS in Oceanography	172
1274	Oceanography	PhD in Oceanography	172
1275	Physics	MS in Physics	172
1276	Physics	PhD in Physics	172
1277	Political Science	MA in Political Science	172
1278	Psychology	PhD in Psychology	172
1279	Public Health	MPH (Master of Public Health)	172
1280	Public Policy Analysis	Master in Public Policy (MPP)	172
1281	Social Work	MS in Human Development and Family Studies	172
1282	Sociology	MA in Sociology	172
1283	Sociology	PhD in Sociology	172
1284	Statistics	MS in Statistics	172
1285	Statistics	PhD in Statistics	172
1286	Water Resources Engineering	MEng in Civil Engineering	172
1287	Water Resources Engineering	PhD in Civil Engineering	172
1288	Biomedical Informatics	Master of Biomedical Informatics	174
1289	Biostat	MS in Biostatistics	174
1290	CBQG	MS in Computational Biology and Quantitative Genetics	174
1291	CS	PhD in Computer Science	174
1292	CSE	MS in Computational Science and Engineering	174
1293	Data Science	MS in Data Science	174
1294	Education	MEd in Education 	174
1295	EE	MS in Engineering Sciences: Electrical Engineering	174
1296	EE	PhD in Engineering Sciences: Electrical Engineering	174
1297	Environ	PhD in Environmental Engineering	174
1298	Health Data Science	MS in Health Data Science	174
1299	Materials	PhD in Materials Science and Mechanical Engineering	174
1300	MBA	MBA2+2 	174
1301	MDE	Master in Design Engineering	174
1302	MDes	Master in Design Studies	174
1303	MPA/ID	Master of Public Administration in International Development	174
1304	MPH	Master of Public Health	174
1305	Psychology	MS in Psychology	174
1306	PublicHealth	PhD in Public Health	174
1307	Statistics	MS in Statistics	174
1308	Statistics	PhD in Statistics	174
1309	SysBio	PhD in Systems Biology	174
1310	Design	MFA in Interaction Design	181
1311	Drama And Film	MFA in Computer Arts	181
1312	Education	MA/MAT in Art Education	181
1313	English	MFA in Art Writing	181
1314	Fine Art	MFA in Fine Arts	181
1315	Fine Arts	MFA in Illustration as Visual Essay	181
1316	MFA-IXD	MFA Interaction Design	181
1317	Public Affairs	MPS in Directing	181
1318	Public Management Administration	MPS in Branding	181
1319	Biostatistics	PhD in Biostatistics	183
1320	CS	MS in Computer Science	183
1321	Finance	MS in Finance	183
1322	Geosciences	PhD in Geosciences	183
1323	Human Computer Interaction (HCI)	MS in Human-Computer Interaction Design	183
1324	Information Science	MA in Information Science	183
1325	Instructional Systems Technology	M.S.Ed. in Instructional Systems Technology	183
1326	IS	PhD in Information Systems	183
1327	MediaArts	PhD in Media Arts and Sciences	183
1328	Biostatistics	PhD in Biostatistics	184
1329	HCI	MS in Human-Computer Interaction	184
1330	Accounting	MSc in Accounting	185
1331	BME	PhD in Biomedical Engineering	185
1332	Business Analytics	MS in Business Analytics	185
1333	CEE	PhD in Civil and Environmental Engineering	185
1334	Chemical	PhD in Chemical and Biomolecular Engineering	185
1335	Communication	MS in Communication	185
1336	CS	MS in Computer Science	185
1337	CS	PhD in Computer Science	185
1338	Data Science	PhD in Data Science	185
1339	DSML	Msc in Data Science & Machine Learning	185
1340	ECE	PhD in Electrical and Computer Engineering	185
1341	EE	Meng in Electrical and Engineering	185
1342	EE	MS in Electrical Engineering	185
1343	Industry4	MSc in Industry 4.0	185
1344	ISEP	PhD in Integrative Sciences and Engineering	185
1345	Materials	PhD in Materials Science and Engineering	185
1346	Math	PhD in Mathematics	185
1347	ME	PhD in Mechanical Engineering	185
1348	MFE	MSc in Financial Engineering	185
1349	MKT	MSc in Marketing Analytics and Insights	185
1350	MQF	MS in Quantitative Finance	185
1351	MSF	MSc in Finance	185
1352	NGS	NGS	185
1353	QE	MS in Quantitative Economics	185
1354	SCM	MS in Supply Chain Management	185
1355	Statistics	MSc in Statistics by Coursework	185
1356	Accounting	Master of Accounting	186
1357	Accounting	PhD in Accounting	186
1358	Actuarial Science	Master of Actuarial Studies	186
1359	Actuarial Science	PhD in Actuarial Studies	186
1360	Anthropology	Master of Biological Anthropology (Advanced)	186
1361	BIS	MS in Business Information Systems	186
1362	Business Analytics	Master of Applied Data Analytics	186
1363	Chemistry	Mphil in Research School of Chemistry	186
1364	Chemistry	PhD in Research School of Chemistry	186
1365	Computer Engineering	Mphil in Computer System: Human-Centred Computing	186
1366	Computer Engineering	PhD in Computer System: Human-Centred Computing	186
1367	Computing	Master of Computing	186
1368	Criminology	Master of Criminology, Justice and Regulation	186
1369	CS	MS in Computer Science	186
1370	Design	Master of Design	186
1371	Economics	Master of Economic Policy	186
1372	Economics	PhD in Economics	186
1373	Electrical Engineering	MEng in Electrical Engineering	186
1374	Electronic Engineering	MEng in Photonics	186
1375	Entrepreneurship	Master of Entrepreneurship and Innovation	186
1376	Finance	Mphil in Finance	186
1377	Finance	PhD in Finance	186
1378	Fine Arts	Master of Design (Advanced)	186
1379	Geology	Mphil in Research School of Earth Sciences	186
1380	Geology	PhD in Research School of Earth Sciences	186
1381	History	Master of Museum and Heritage Studies (Advanced)	186
1382	Information Systems	Master of Business Information Systems (Advanced)	186
1383	Language	Master of Translation	186
1384	Language	PhD in Computer System: Programming Language Systems	186
1385	Law	Master of Laws	186
1386	Law	Juris Doctor	186
1387	Literature	Master of Classical Studies (Advanced)	186
1388	Management	Master of Project Management	186
1389	Marketing	Master of Marketing Management (Advanced)	186
1390	Materials	Mphil in Materials: Composite Materials	186
1391	Materials	PhD in Materials: Biomaterials	186
1392	Mathematics	Mphil in Mathematics: Analysis & geometry	186
1393	Mathematics	PhD in Mathematics: Computational mathematics	186
1394	Mba	Master of Business Administration	186
1395	Medicine	Doctor of Medicine and Surgery	186
1396	MSF	Master of Finance	186
1397	Philosophy	Mphil in Theory: Logic	186
1398	Philosophy	PhD in Theory: Logic	186
1399	Physics	Mphil in Research School of Astronomy and Astrophysics	186
1400	Physics	PhD in Research School of Astronomy and Astrophysics	186
1401	Political Science	Master of Political Science (Advanced)	186
1402	Psychology	Mphil in Psychology	186
1403	Psychology	PhD in Psychology	186
1404	Statistics	Mphil in Statistics	186
1405	Statistics	PhD in Statistics	186
1406	Urban Planning	Mphil in Intelligence: Planning and Optimisation	186
1407	Urban Planning	PhD in Intelligence: Planning and Optimisation	186
1408	CS	MS in Computer Science	198
1409	CS	PhD in Computer Science	198
1410	ECE	PhD in Electrical and Computer Engineering	198
1411	Environmental Sciences	PhD in Environmental Science	198
1412	HCI	MS in Human Computer Interaction	198
1413	Statistics	PhD in Statistics	198
1414	Bioinformatics	MS in Bioinformatics	199
1415	CS	MS in Computer Science	199
1416	Early Career MBA	Early Career MBA	199
1417	HFE	MS in Human Factors and Ergonomics	199
1418	Human Factor/Ergonomics	MS in Human Factor/Ergonomics	199
1419	ISE	MS in Industrial and System Engineering	199
1420	MSDA	MS in Data Analytics	199
1421	Software Engineering	MS in Software Engineering	199
1422	Applied Math & Stat	MS in Applied Mathematics and Statistics	201
1423	AppliedMath	PhD in Applied Mathematics and Statistics	201
1424	Biochemistry and Molecular Biology	MHS in Biochemistry and Molecular Biology	201
1425	Biostat	MS in Biostatistics	201
1426	Biostat	PhD in Biostatistics	201
1427	BME	MSE in Biomedical Engineering	201
1428	BME	PhD in Biomedical Engineering	201
1429	Business Analytics and Risk Management	MS in Business Analytics and Risk Management	201
1430	Chemical and Biomolecular Engineering	PhD in Chemical and Biomolecular Engineering	201
1431	Civil Engineering	MSE in Civil Engineering	201
1432	CMDB	PhD in Cell Molecular Developmental Biophysics	201
1433	Communication	MS in Communication	201
1434	CompThought	PhD in Comparative Thought and Literature	201
1435	CS	MS in Computer Science	201
1436	CS	PhD in Computer Science	201
1437	CS-MSEM	MSEM in Computer Science	201
1438	DALT	MS in Digital Age Learning and Technology	201
1439	DS	MSE in Data Science	201
1440	Earth Science	PhD in Earth and Planetary Sciences	201
1441	ECE	MSE in Electrical and Computer Engineering	201
1442	ECE	PhD in Electrical and Computer Engineering	201
1443	EDU	PhD in Education	201
1444	Finance	MS in Finance	201
1445	Financial Mathematics	MSE in Financial Mathematics	201
1446	Geography and Environmental Engineering	MSE in Geography and Environmental Engineering	201
1447	Global Disease Epdiemiology Control	MSPH in International Health, Global Disease Epidemiology and Control	201
1448	Health Sciences Informatics	PhD in Health Sciences Informatics	201
1449	International Economics	MA in International Economics	201
1450	ITGL	MS in International Teaching and Global Leadership	201
1451	Marketing	MS in Marketing	201
1452	Materials	MSE in Materials Science and Engineering	201
1453	Materials	PhD in Materials Science and Engineering	201
1454	ME	MS in Mechanical Engineering	201
1455	ME	PhD in Mechanical Engineering	201
1456	MHS	MHS in Epidemiology	201
1457	MMCM	Master of Computer Music	201
1458	MPA	Master of Public Management	201
1459	MSEM	MSEM in Engineering Management	201
1460	MSIS	MS in Information Systems	201
1461	MSSI	MS in Security Informatics	201
1462	Population, Family and Reproductive Health	MHSH in Population, Family and Reproductive Health	201
1463	Public Management	MA in Public Management	201
1464	Robotics	MSE in Robotics	201
1465	CS	MS in Computer Science	207
1466	CS	PhD in Computer Science	207
1467	ECE	MS in Electrical Engineering	207
1468	Economics	MS in Analytical Economics	207
1469	ISE	MEng in Industrial and System Engineering 	207
1470	ISE	MS in Industrial and Systems Engineering	207
1471	ISE	PhD in Industrial and Systems Engineering	207
1472	Materials	MS/MEng in Materials Science and Engineering	207
1473	MFE	MS in Financial Engineering	207
1474	Chemistry	PhD in Chemistry	208
1475	CS	MS in Computer Science	208
1476	Accounting	MS in Accounting Analytics	214
1477	Biology	MS in Bioinformatics	214
1478	Biology	PhD in Biological Sciences	214
1479	Biomedical Engineering	MS in Biomedical Engineering	214
1480	Biomedical Engineering	PhD in Biomedical Engineering	214
1481	Business Analytics	MS in Health Care Data Analytics	214
1482	Chemistry	MS in Chemistry	214
1483	Chemistry	PhD in Chemistry	214
1484	Communication	MA in Communication	214
1485	Computer Engineering	MS in Computing	214
1486	Computer Engineering	PhD in Electrical and Computer Engineering	214
1487	Computer Science	PhD in Computer Science	214
1488	Economics	MS in Applied Economics	214
1489	Education	MA in Educational Policy and Foundations	214
1490	Education	PhD in Educational Policy and Leadership	214
1491	English	MA in English	214
1492	English	PhD in English	214
1493	Health	MS in Exercise and Rehabilitation Science	214
1494	Health	Doctor of Physical Therapy (DPT)	214
1495	History	MA in History	214
1496	History	PhD in History	214
1497	Language	MA in Spanish	214
1498	Law	JD	214
1499	Law	LLM in Sports Law	214
1500	Mathematics	MS in Mathematics for Secondary School Teachers	214
1501	Mathematics	PhD in Computational Mathematical and Statistical Sciences	214
1502	Mba	MBA	214
1503	Mechanical Engineering	MS in Mechanical Engineering	214
1504	Mechanical Engineering	PhD in Mechanical Engineering	214
1505	Medicine	MS in Dental Biomaterials	214
1506	Medicine	PhD in Clinical Psychology	214
1507	Nursing	MS in Nursing	214
1508	Nursing	PhD in Nursing	214
1509	Philosophy	MA in Social and Applied Philosophy	214
1510	Philosophy	PhD in Philosophy	214
1511	Political Science	MA in Political Science	214
1512	Psychology	PhD in Counseling Psychology	214
1513	Public Management Administration	MA in International Affairs	214
1514	Religion	MA in Theology	214
1515	Religion	PhD in Religious Studies	214
1516	Statistics	MS in Applied Statistics	214
1517	Water Resources Engineering	MS in Civil, Construction and Environmental Engineering	214
1518	Water Resources Engineering	PhD in Civil, Construction and Environmental Engineering	214
1519	Computing and software	MEng in Computing and Software	216
1520	Design	Master of Engineering Design (MEng Design)	216
1521	ECE	MEng in Electrical and Computer Engineering	216
1522	ECE	PhD in Electrical and Computer Engineering	216
1523	Finance	Master of Finance  	216
1524	Operation Management	PhD in Management Science	216
1525	Statistics	MSc in Statistics	216
1526	Analytics	Master of Management in Analytics	217
1527	Bioresource	MSc in Bioresource Enigeering	217
1528	CS	MSc in Computer Science	217
1529	CS	PhD in Computer Science	217
1530	ECE	MEng in Electrical and Computer Engineering	217
1531	ECE	PhD in Electrical and Computer Engineering	217
1532	Geography	PhD in Geography	217
1533	Information Studies	Master of Information Studies	217
1534	IPN	MS in Integrated Program in Neuroscience	217
1535	Math&Stat	MS in Mathematics and Statistics	217
1536	ME	MEng in Mechanical Engineering	217
1537	MMF	Master of Management in Finance	217
1538	Physics	Master of Science in Physics	217
1539	Business Analytics	MS in Business Analytics	219
1540	CMSE	PhD in Computational Mathematics Science and Engineering	219
1541	CS	MS in Computer Science and Engineering	219
1542	CS	PhD in Computer Science and Engineering	219
1543	Media Information	PhD in Media and Information Studies	219
1544	Statistics	MS in Statistics	219
1545	Statistics	PhD in Statistics	219
1546	ComputerSecurity	MS in Computer Security	221
1547	CS	MS in Computer Science	221
1548	CSP	MSc in Communications and Signal Processing	221
1549	DS	MSc Data Science (Computer Science Data Informatics)	221
1550	EEE	PhD in Electrical & Electronic Engineering	221
1551	Finance	MS in Finance	221
1552	LLM	Transnational Dispute Resolution	221
1553	Mathematics	MS in Applied mathematics 	221
1554	MIS	MIS in Management and Information Systems	221
1555	Neuroimaging	MSc Neuroimaging for Clinical & Cognitive Neuroscience	221
1556	QF	MS in Quantitative Finance	221
1557	SCM	MS Operations, Project and Supply Chain Management	221
1558	Chemical Engineering	MS in Petroleum Engineering	225
1559	Computer Engineering	MS in Computer Engineering	225
1560	Computer Engineering	PhD in Computer Engineering	225
1561	Electrical Engineering	MS in Electrical Engineering	225
1562	Electrical Engineering	PhD in Electrical Engineering	225
1563	MAE	PhD in Mechanical and Aerospace Engineering	225
1564	Accounting	MSc in Accountancy and Control	231
1565	AI	MSc in Artificial Intelligence	231
1566	Anthropology	MSc in Cultural and Social Anthropology: Applied Anthropology	231
1567	Area Studies	MA in Latin American Studies	231
1568	bioinformatics and systems biology	MS in Bioinformatics and Systems Biology	231
1569	Biological Engineering	MSc in Biomedical Sciences: Medical Biology	231
1570	Biology	MSc in Biological Sciences: Neurobiology	231
1571	Communication	MSc in Communication Science: Entertainment Communication	231
1572	Computer Engineering	MSc in Software Engineering	231
1573	Computer Science	MSc in Security and Network Engineering	231
1574	Data Science	MSc in Information Studies: Data Science	231
1575	Drama And Film	MA in Theatre Studies	231
1576	Economics	MSc in Economics	231
1577	Education	Master of Child Development and Education	231
1578	English	MA in Literature, Culture and Society	231
1579	Entrepreneurship	MSc in Entrepreneurship	231
1580	Finance	MSc in Finance	231
1581	Financial Engineering	MSc in Actuarial Science and Mathematical Finance	231
1582	Fine Arts	MA in Music Studies	231
1583	Geophysics	MSc in Environmental Geography	231
1584	Geosciences	MSc in Earth Sciences: Environmental Management	231
1585	History	MA in Archaeology	231
1586	Information Systems	MA in Archival and Information Studies: Archival Studies	231
1587	Language	MA in Language and Society	231
1588	Law	LLM in European Private Law	231
1589	Literature	MA in Comparative Literature	231
1590	Marketing	MSc in Business Administration: Marketing	231
1591	Mathematics	MSc in Mathematics	231
1592	Mba	MBA	231
1593	Natural Conservation And Ecology	MA in Conservation and Restoration of Cultural Heritage	231
1594	Philosophy	MA in Philosophy (Research)	231
1595	Political Science	MSc in Political Theory	231
1596	Psychology	MSc in Psychology: Social Influence	231
1597	Public Affairs	MSc in International Relations	231
1598	Public Management Administration	MA in European Policy (European Studies)	231
1599	Public Policy Analysis	MSc in Public Policy and Governance	231
1600	Religion	MA in Religious Studies (Research)	231
1601	Sociology	MSc in Sociology: Gender, Sexuality and Society	231
1602	Strategy	MSc in Business Administration: Strategy	231
1603	Urban Planning	MSc in Urban and Regional Planning	231
1604	Actuarial Science	MSc in Econometrics, Operations Research and Actuarial Studies	233
1605	Area Studies	MA in Middle Eastern Studies	233
1606	Biology	MSc in Marine Biology	233
1607	Biomedical Engineering	MSc in Biomedical Engineering	233
1608	Chemical Engineering	MSc in Chemical Engineering	233
1609	Chemistry	MSc in Chemistry	233
1610	Communication	MA in Media Studies: Journalism	233
1611	Computer Engineering	MSc in Computing Science	233
1612	Drama And Film	MA in Arts & Culture: Film and Contemporary Audiovisual Media	233
1613	Economics	MSc in Economics	233
1614	Education	MSc in Educational Sciences: Learning in Interaction	233
1615	English	MA in Linguistics: Applied Linguistics	233
1616	Entrepreneurship	MA in Arts & Culture (research): Cultural Leadership	233
1617	Environmental Science	MSc in Energy and Environmental Sciences	233
1618	Epidemiology	MSc in Clinical and Psychosocial Epidemiology (research): Health Systems and Prevention	233
1619	Finance	MSc in Finance	233
1620	Geophysics	MSc in Economic Geography	233
1621	Geosciences	MSc in Cultural Geography	233
1622	History	MA in Archaeology (research)	233
1623	Human Resource Management	MSc in Human Resource Management	233
1624	Information Systems	MA in Communication & Information Studies: Information Science	233
1625	International Business	MSc in International Business and Management	233
1626	Law	LLM in International Commercial Law	233
1627	Literature	MA in Literary Studies: Writing, Editing and Mediating	233
1628	Management	MSc in Industrial Engineering and Management	233
1629	Marketing	MSc in Marketing	233
1630	Materials	MSc in Nanoscience	233
1631	Mathematics	MSc in Applied Mathematics	233
1632	Mechanical Engineering	MSc in Mechanical Engineering	233
1633	Medicine	MSc in Psychology: Clinical Psychology	233
1634	Music And Dance	MA in Arts & Culture: Music, Theatre and Performance Studies	233
1635	Operations	MSc in Technology and Operations Management	233
1636	Pharmacy	MSc in Medical and Pharmaceutical Drug Innovation	233
1637	Philosophy	MA in Philosophy (research)	233
1638	Physics	MSc in Physics	233
1639	Political Science	MSc in Philosophy, Politics and Economics	233
1640	Psychology	MSc in Psychology: Cognitive Psychology and Psychophysiology	233
1641	Public Affairs	MA in International Relations: International Relations and International Organization	233
1642	Public Management Administration	MA in International Relations: European Integration	233
1643	Religion	MA in Theology & Religious Studies (research)	233
1644	Sociology	MSc in Behavioural and Social Sciences (research)	233
1645	Supply Chain And Logistics	MSc in Supply Chain Management	233
1646	Urban Planning	MSc in Environmental and Infrastructure Planning	233
1647	Geosciences	Master of Geoscience	238
1648	Geosciences	PhD in Geoscience	238
1649	History	MA of History	240
1650	History	PhD in history	240
1651	Accountancy	MSc in Accountancy	242
1652	Analogue and Digital Integrated Circuit Design	MS in Analogue and Digital Integrated Circuit Design	242
1653	Analytics	MSc in Analytics	242
1654	Artificial Intelligence	MSc in Artificial Intelligence	242
1655	CSE	PhD in Computer Science and Engineering	242
1656	EBAC	MS in Enterprise Business Analytics	242
1657	ECE	MS in Electrical and Computer Engineering	242
1658	EE	PhD in Electronic Engineering	242
1659	Financial Engineering	MSc in Financial Engineering	242
1660	Information Systems	MSc in Information Systems	242
1661	KM	MSc in Knowledge Management	242
1662	Materials	PhD in Materials Science and Engineering	242
1663	Math	PhD in Mathematical	242
1664	MKT	MSc Marketing Science	242
1665	MSBA	MSc in Business Analytics	242
1666	MSF	MSc in Finance	242
1667	MTI	MA in Translation and Interpretation	242
1668	TIP	MS in Technopreneurship & Innovation	242
1669	Accounting	MS in Accounting	243
1670	Accounting	PhD in Business Administration: Accounting	243
1671	Anthropology	MA in Applied Anthropology	243
1672	Anthropology	PhD in Anthropology	243
1673	Architecture	MArch (Master of Architecture)	243
1674	Area Studies	MA in Hispanic Studies	243
1675	Area Studies	PhD in Hispanic Studies	243
1676	Biological Agricultural Engineering	MS in Biosystems and Agricultural Engineering	243
1677	Biological Agricultural Engineering	PhD in Biosystems and Agricultural Engineering	243
1678	Biology	MS in Entomology	243
1679	Biology	PhD in Biology	243
1680	Biomedical Engineering	MS in Biomedical Engineering	243
1681	Biomedical Engineering	PhD in Biomedical Engineering	243
1682	Chemical Engineering	MS in Chemical Engineering	243
1683	Chemical Engineering	PhD in Chemical Engineering	243
1684	Chemistry	MS in Chemistry	243
1685	Chemistry	PhD in Chemistry	243
1686	Communication	MA in Communication	243
1687	Communication	PhD in Communication	243
1688	Computer Science	MS in Computer Science	243
1689	Drama And Film	MFA in Creative Writing	243
1690	Drama And Film	DMA in Composition	243
1691	Economics	MS in Economics	243
1692	Economics	PhD in Economics	243
1693	Education	MS in Special Education	243
1694	Education	PhD in Special Education	243
1695	Electrical Engineering	MS in Electrical Engineering	243
1696	Electrical Engineering	PhD in Electrical Engineering	243
1697	English	MA in English	243
1698	English	PhD in English	243
1699	Entrepreneurship	MS in Community and Leadership Development	243
1700	Finance	MS in Finance	243
1701	Finance	PhD in Business Administration: Finance and Quantitative Methods	243
1702	Fine Arts	MS in Urban and Environmental Design	243
1703	Fine Arts	PhD in Music Theory	243
1704	Food Science And Technology	PhD in Food Science	243
1705	Geophysics	MA in Geography	243
1706	Geophysics	PhD in Geography	243
1707	Geosciences	MS in Geology	243
1708	Geosciences	PhD in Geology	243
1709	Health	MS in Nutritional Sciences	243
1710	Health	PhD in Exercise Science	243
1711	History	Master of Historic Preservation	243
1712	History	PhD in History	243
1713	Information Systems	MS in Information Communication Technology	243
1714	Language	MA in German	243
1715	Law	JD	243
1716	Marketing	MS in Retailing and Tourism Management	243
1717	Materials	MS in Materials Science and Engineering	243
1718	Materials	PhD in Materials Science and Engineering	243
1719	Mathematics	MS in Mathematics	243
1720	Mathematics	PhD in Mathematics	243
1721	Mba	JD/MBA	243
1722	Mba	MBA	243
1723	Mechanical Engineering	MS in Mechanical Engineering	243
1724	Mechanical Engineering	PhD in Mechanical Engineering	243
1725	Medicine	MS in Medical Sciences	243
1726	Medicine	PhD in Pharmacology	243
1727	Mineral Engineering	MS in Mining Engineering	243
1728	Mineral Engineering	PhD in Mining Engineering	243
1729	Music And Dance	MA/PhD in Musicology and Ethnomusicology	243
1730	Nursing	Doctor of Nursing Practice	243
1731	Pharmacy	PhD in Pharmaceutical Sciences	243
1732	Philosophy	PhD in Philosophy	243
1733	Physics	Master of Physics & Astronomy: Particle Theory	243
1734	Physics	PhD in Physics & Astronomy: Condensed Matter Physics	243
1735	Political Science	MA in Political Science	243
1736	Political Science	PhD in Political Science	243
1737	Psychology	MS in Educational Psychology	243
1738	Psychology	PhD in Psychology: Social Psychology	243
1739	Public Health	JD/MHA	243
1740	Public Health	Master of Public Health	243
1741	Social Work	MSW (Master of Social Work)	243
1742	Sociology	PhD in Sociology	243
1743	Statistics	MS in Statistics - Mathematical Statistics	243
1744	Statistics	PhD in Statistics - Mathematical Statistics	243
1745	Supply Chain And Logistics	PhD in Business Administration: Marketing and Supply Chain	243
1746	Veterinary Medicine	MS in Veterinary Science	243
1747	Veterinary Medicine	PhD in Veterinary Science	243
1748	Water Resources Engineering	MS in Civil Engineering	243
1749	BME	MS in Biomedical Engineering	247
1750	CE	MS in Computer Engineering	247
1751	CS	MS in Computer Science	247
1752	CS	PhD in Computer Science	247
1753	CS-Bridge	Bridge to Computer Science	247
1754	Cyber security	MS in Cybersecurity	247
1755	EE	MS in Electrical Engineering	247
1756	FE	MS in Financial Engineering	247
1757	Industrial Engineering	MS in Industrial Engineering	247
1758	Integrated Digital Media	MS in Integrated Digital Media	247
1759	Management of Technology	MS in Management of Technology	247
1760	Mathematics	MS in Mathematics	247
1761	ME	MS in Mechanical Engineering	247
1762	ME	PhD in Mechanical Engineering	247
1763	Robotics	MS in Mechatronics and Robotics	247
1764	Accounting	Master of Accounting	248
1765	Applied Statistics	MS in Applied Statistics for Social Science Research	248
1766	AppliedQuantitativeResearch	MA in Applied Quantitative	248
1767	Art and Archaeology	MA in History of Art and Archaeology	248
1768	BER	MA in Business and Economic Reporting	248
1769	BioInformatics	MS in Biomedical Informatics	248
1770	BIology	MS in Biology	248
1771	Biology	PhD in Biology	248
1772	BIOS	MPH in Biostatistics	248
1773	Biostatistics	MS in Biostatistics	248
1774	BIS	PhD in Biostatistics	248
1775	Business Analytics	MBA in Business Analytics	248
1776	CommunityAndInternationalHealth	MS in Community and International Health Concentration	248
1777	CS	MS in Computer Science	248
1778	CS	PhD in Computer Science	248
1779	CUSP	MS in Applied Urban Science & Informatics	248
1780	Data Analytics & Business Computing	MS in Data Analytics & Business Computing	248
1781	Data Science	MS in Data Science	248
1782	Data Science	PhD in Data Science	248
1783	EAS	PhD in East Asian Studies	248
1784	Economics	MA in Economics	248
1785	EDSP	MA in Education and Social Policy	248
1786	Integrated Marketing	MS in Integrated Marketing	248
1787	ITP	MPS in Interactive Telecommunications	248
1788	Management and System	MS in Management and Systems	248
1789	Mathematical Finance	MS in Mathematical Finance	248
1790	Mathematics	MS in Mathematics	248
1791	Mathematics	PhD in Mathematics	248
1792	MCC	MA in Media, Culture, and Communication 	248
1793	MPA	MPA in Public and Nonprofit Management and Policy	248
1794	MS-CEI	MS in Computing, Entrepreneurship and Innovation	248
1795	MSIS	MS in Information Systems	248
1796	MSIS	PhD in Information Systems	248
1797	MSPM	MS in Project Management	248
1798	MT	MM Music Technology	248
1799	Music	PhD in Music Technology	248
1800	Physics	PhD in Physics	248
1801	Public Administration	MS in Public Administration	248
1802	PublicHealth	PhD in Epidemiology	248
1803	Sackler	PhD in Sackler Institute of Graduate Biomedical Sciences	248
1804	Scientific Computing	MS in Scientific Computing	248
1805	SocialWork	MA in Social Work	248
1806	TESOL	MS in Teaching English to Speakers of Other Languages	248
1807	Physics	Master of Physics & Astronomy	249
1808	Physics	PhD in Physics&Astronomy	249
1809	Accounting	Master of Accounting Science	250
1810	Analytics	MS in Statistics: Analytics	250
1811	Applied Mathematics	MS in Applied Mathematics	250
1812	Bioinformatics	MS in Bioinformatics	250
1813	Chemical	PhD in Chemical Engineering	250
1814	Chemistry	PhD in Chemistry	250
1815	Civil Engineering	MS in Civil Engineering	250
1816	Communication	MA in Communication 	250
1817	Computational Engineering	MS in Computational Engineering	250
1818	CS	MS in Computer Science	250
1819	CS	PhD in Computer Science	250
1820	CS-Professional	Professional Master of Computer Science	250
1821	DELTA	Digital Environments for Learning, Teaching, & Agency	250
1822	Design	MA in Industrial Design	250
1823	ECE	PhD in Electrical and Computer Engineering	250
1824	ECE-Meng	Meng in Electrical and Computer Engineering	250
1825	EE	MS in Electrical and Computer Engineering	250
1826	Finance	Master of Science in Finance	250
1827	Geography	PhD in Geography	250
1828	GIS	MS in Geographic Information Science	250
1829	Indusrial Engineering	MS in Indusrial Engineering	250
1830	Industrial Engineering	PhD in Industrial Engineering	250
1831	IS	MS in Information Management	250
1832	IS	PhD in Information Sciences	250
1833	Library and Information Science	PhD in Library and Information Science	250
1834	Linguistics	BS in Linguistics	250
1835	Materials	MBA/MS in Materials Science and Engineering	250
1836	Materials	PhD in Materials Science and Engineering	250
1837	Mathematics	PhD in Mathematics	250
1838	ME	MS in Mechanical Engineering	250
1839	ME	PhD in Mechanical Engineering	250
1840	MHRIR	Master of Human Resources and Industrial Relations	250
1841	MSFE	MS in Financial Engineering	250
1842	MSPE	MS in Policy Economics	250
1843	Psychology	PhD in Psychology	250
1844	Statistics	MS in Statistics	250
1845	Statistics	PhD in Statistics	250
1846	Analytics	MS in Analytics	251
1847	Bioinformatics	PhD in Bioinformatics	251
1848	Civil Engineering	Master of Civil Engineering	251
1849	CS	MS in Computer Science	251
1850	CS	PhD in Computer Science	251
1851	Econ	PhD in Economics and Econometrics	251
1852	EE	MS in Electrical Engineering	251
1853	EE	PhD in Electrical Engineering	251
1854	Financial mathematics	Master of Financial Mathematics	251
1855	Industrial Engineering	MS in Industrial Engineering	251
1856	ME	MS in Mechanical Engineering	251
1857	MEM	MS in Engineering Management	251
1858	Statistics	MS in Statistics	251
1859	Statistics	PhD in Statistics	251
1860	Biostatistics	MS in Biostatistics	252
1861	Biostatistics	PhD in Biostatistics	252
1862	BME	PhD in Biomedical Engineering	252
1863	CS	MS in Computer Science	252
1864	CS	PhD in Computer Science	252
1865	Data Science and Analytics	MS in Data Science and Analytics	252
1866	geography	PhD in Geography	252
1867	Geosciences	PhD in Geological Sciences	252
1868	Information Science	MS in Library Science(MSLS)	252
1869	Information Science	PhD in Information and Library Science	252
1870	Math	PhD in Mathematics	252
1871	media and communication	MA in media and communication	252
1872	Nursing	PhD in Nursing	252
1873	PublicHealth	PhD in Public Health	252
1874	Statistics	MS in Statistics	252
1875	Statistics	PhD in Statistics	252
1876	ABBS	Arizona Biological and Biomedical Sciences	253
1877	Astronomy	PhD in Astronomy	253
1878	Biostatistics	PhD in Biostatistics	253
1879	CS	MS in Computer Science	253
1880	CS	Phd in Computer Science	253
1881	IE	MS in Industrial Engineering	253
1882	MIS	MS in Management Information Systems	253
1883	MIS	PhD in Management Information Systems	253
1884	Optical	MS in Optical Sciences	253
1885	Optical	PhD in Optical Sciences	253
1886	Statistics	PhD in Statistics	253
1887	System Industrial Engineering	PhD in System Industrial Engineering	253
1888	TLSS	PhD in Teaching, Learning, and Sociocultural Studies	253
1889	Biostat	PhD in Biostatistics	254
1890	CSE	Master in Computer Science	254
1891	CSE	PhD in Computer Science	254
1892	Math	PhD in Mathematics	254
1893	accounting	MS in Accounting	255
1894	Math	PhD in Mathematics	255
1895	Molecular and Developmental Biology	PhD in Molecular and Developmental Biology	255
1896	Accounting	Master of Professional Accounting	256
1897	Accounting	PhD in Accounting	256
1898	Business Analytics	Master of IT in Business: Analytics	256
1899	CE	MSc in Computing	256
1900	CS	PhD in Computer Science	256
1901	Economics	MSc in Economics	256
1902	Economics	PhD in Economics	256
1903	Entrepreneurship	MSc in CFO Leadership	256
1904	FE	MSc in Quantitative Finance	256
1905	Finance	PhD in Business: Finance	256
1906	Human Resource Management	PhD in Business: Organisational Behavior and Human Resources	256
1907	IS	PhD in Information System	256
1908	Law	JD	256
1909	Law	LLM in Judicial Studies	256
1910	Marketing	PhD in Business: Marketing	256
1911	Operations	PhD in Business: Operation Management	256
1912	Psychology	PhD in Psychology	256
1913	Strategy	PhD in Business: Strategy Manangement & Organisation	256
1914	Applied Mathematics	PhD in Applied Mathematics	257
1915	MMF	MS in Mathematical Finance	257
1916	Accounting	MS in Accounting	258
1917	Architecture	MFA in Interior Architecture	258
1918	Basic Medicine	MS in Genetic Counseling	258
1919	Biology	MS in Biology	258
1920	Biology	PhD in Medicinal Biochemistry	258
1921	Chemistry	MS in Chemistry	258
1922	Communication	MA in Communication Studies	258
1923	Communication	PhD in Communication Sciences and Disorders	258
1924	Computer Science	MS in Computer Science	258
1925	Design	MFA in Drama: Design	258
1926	Drama And Film	MFA in Studio Arts	258
1927	Economics	MA in Applied Economics	258
1928	Economics	PhD in Economics	258
1929	Education	MAT in Middles Grades Education	258
1930	Education	PhD in Educational Studies: Cultural Foundations	258
1931	English	MA in English	258
1932	English	PhD in English	258
1933	Exercise And Sport Science	MS in Kinesiology	258
1934	Exercise And Sport Science	PhD in Kinesiology	258
1935	Fine Arts	MFA in Drama: Theatre for Youth	258
1936	Food Science And Technology	MS in Nutrition	258
1937	Geophysics	MA in Applied Geography	258
1938	Geosciences	PhD in Geography	258
1939	Health	MS in Gerontology	258
1940	History	MA in History	258
1941	History	PhD in History	258
1942	Information Systems	Master of Library and Information Studies	258
1943	Information Systems	PhD in Information Systems	258
1944	Language	MEd in French Education	258
1945	Materials	MS in Nanoscience	258
1946	Materials	PhD in Nanoscience	258
1947	Mathematics	MA in Mathematics	258
1948	Mathematics	PhD in Computational Mathematics	258
1949	Mba	MBA (Master of Bussiness Administration)	258
1950	Medicine	MA in Speech-Language Pathology	258
1951	Medicine	PhD in Clinical Psychology	258
1952	Music And Dance	MA in Dance	258
1953	Music And Dance	DMA in Music	258
1954	Nursing	MS in Nursing: Nursing Administration	258
1955	Nursing	Doctor of Nursing Practice	258
1956	Nutrition	PhD in Nutrition	258
1957	Political Science	MA in Political Science	258
1958	Psychology	MA in Psychology	258
1959	Psychology	PhD in Cognitive, Developmental, or Social Psychology	258
1960	Public Affairs	MPA in Nonprofit Management	258
1961	Public Health	PhD in Environmental Health Science	258
1962	Public Management Administration	MPA in Community and Economic Development	258
1963	Social Work	Joint Master of Social Work	258
1964	Social Work	PhD in Human Development and Family Studies	258
1965	Sociology	MA in Women's and Gender Studies	258
1966	Textile And Light Industry	MS in Consumer, Apparel, and Retail Studies	258
1967	Textile And Light Industry	PhD in Consumer, Apparel, and Retail Studies	258
1968	Analytics	Professional Master's in Analytics	260
1969	Bioinformatics	MS in Bioinformatics	260
1970	Business analytics	MS in Business Analytics	260
1971	Chemical	MS in Chemical Engineering	260
1972	CivilEng	MS in Civil Engineering	260
1973	CivilEng	PhD in Civil Engineering	260
1974	CS	MS in Computer Science	260
1975	CS	PhD in Computer Science	260
1976	CS-ALIGN	Align Master’s Degree in Computer Science	260
1977	CSE	MS in Computer Systems Engineering	260
1978	CV-ML-Algorithm	MS in ECE-Computer Vision, Machine Learning, and Algorithms	260
1979	Cybersecurity	MS in Cybersecurity	260
1980	DAE	MS in Data Analytics Engineering	260
1981	DAM	MS in Data Architecture and Management	260
1982	DataScience	MS in Data Science	260
1983	ECE	MS in Electrical Engineering	260
1984	ECE	PhD in Electrical Engineering	260
1985	Engineering Management	MS in Engineering Management	260
1986	Experience Design	MS in Experience Design	260
1987	Finance	MS in Finance	260
1988	Game Science and Design	MS in Game Science and Design	260
1989	Industrial Engineering	MS in Industrial Engineering	260
1990	IS	MS in Information Systems	260
1991	ME	MS in Mechanical Engineering	260
1992	Operation Research	MS in Operations Research	260
1993	Robotics	MS in Robotics	260
1994	AI	MS in Artificial Intelligence	261
1995	Analytics	MS in Analytics	261
1996	AppliedPhysics	PhD in Applied Physics	261
1997	Biostat	MS in Biostatistics	261
1998	BME	MS in Biomedical Engineering	261
1999	BME	PhD in Biomedical Engineering	261
2000	CE	MS in Computer Engineering	261
2001	CE	PhD in Computer Engineering	261
2002	Chemical	PhD in Chemical and Biological Engineering	261
2003	Civil & Environmental Engineering	MS in Civil and Environmental Engineering	261
2004	Communication Studies	PhD in Communication Studies	261
2005	CS	MS in Computer Science	261
2006	CS	PhD in Computer Science	261
2007	DGP	Driskill Graduate Program in Life Sciences	261
2008	EDI	Engineering Design Innovation	261
2009	EE	MS in Electrical Engineering	261
2010	EE	PhD in Electrical Engineering	261
2011	ESAM	PhD in Engineering Sciences and Applied Mathematics	261
2012	Finance	PhD in Finance	261
2013	Health and Biomedical Informatics	PhD in Health and Biomedical Informatics	261
2014	iems	PhD in Industrial Engineering & Management Sciences	261
2015	IMC	Integrated Marketing Communications	261
2016	Information Systems	MS in Information Systems	261
2017	Integrated Marketing Communications	Master of Integrated Marketing Communications	261
2018	IT	MS in Information Technology	261
2019	LS	PhD in Learning Science	261
2020	Materials	MS in Materials Science and Engineering	261
2021	Materials	PhD in Materials Science and Engineering	261
2022	ME	MS in Mechanical Engineering	261
2023	ME	PhD in Mechanical Engineering	261
2024	MEM	MS of Engineering Management	261
2025	MJ	MA in Journalism	261
2026	Neuroscience	PhD in Neuroscience	261
2027	Physics	PhD in Physics	261
2028	project management	Master of Project Management	261
2029	PublicHealth	PhD in Public Health	261
2030	Robotics	MS In Robotics	261
2031	Statistics	MS in Statistics	261
2032	Statistics	PhD in Statistics	261
2033	Chemistry	PhD in Chemistry	271
2034	CS	BS in Computer science	271
2035	CS	Meng in Computer Science	271
2036	CS	MS in Computer Science	271
2037	CS	PhD in Computer Science	271
2038	EE	PhD in Electrical and Computer Engineering	271
2039	Robotics	Master of Science in Robotics	271
2040	Statistics	MS in Statistics	271
2041	Applied Statistics	Master of Applied Statistics	274
2042	Bioinformatics and Genomics	PhD in Bioinformatics and Genomics	274
2043	Biostatistics	PhD in Biostatistics	274
2044	Chemical	PhD in Chemical Engineering	274
2045	Chemistry	PhD in Chemistry	274
2046	Civil Engineering	MS in Civil Engineering	274
2047	CS	MS in Computer Science and Engineering	274
2048	CS	PhD in Computer Science and Engineering	274
2049	CSE-Meng	MEng in Computer Science and Engineering	274
2050	Curriculum	PhD in Curriculum and Instruction	274
2051	Economics	MA in Economics	274
2052	EE	MS in Electrical Engineering	274
2053	EE	PhD in Electrical Engineering	274
2054	Geosciences	PhD in Geosciences	274
2055	HCI	MS in Human-Computer Interaction	274
2056	I/O Psych	PhD in Industrial/Organizational Behavior	274
2057	Industrial Engineering	PhD in Industrial Engineering with a Minor in Operations Research	274
2058	Informatics	PhD in Informatics	274
2059	Materials	PhD in Materials Science and Engineering	274
2060	ME	MS in Engineering Mechanics	274
2061	METEO	MS in Meteorology and Atmospheric Science	274
2062	Physics	PhD in Physics	274
2063	Statistics	PhD in Statistics	274
2064	System Engineering	MS in Systems Engineering	274
2065	Transportation	PhD in Transportation Engineering	274
2066	Business Analytics	MS in Business Analytics	275
2067	Clinical Psychology	MA in Clinical Psychology	275
2068	MSAF	Master of Science in Applied Finance	275
2069	Accounting	Master/PgD in Professional Accounting	277
2070	Accounting	PhD in Accounting and Auditing	277
2071	Actuarial Science	MSc in Applied Mathematics for Science and Technology: Actuarial and Investment Science	277
2072	Aerospace	Mphil in Aerospace Engineering	277
2073	Aerospace	PhD in Aerospace Engineering	277
2074	Business Analytics	MSc in Business Analytics	277
2075	Chemistry	Mphil in Chemistry	277
2076	Chemistry	PhD in Chemistry	277
2077	Computer Engineering	Mphil in Human-Centered Computing	277
2078	Computer Engineering	PhD in Networking and Mobile Computing	277
2079	Design	MDes in Design Practices 	277
2080	Drama And Film	Mphil in Thin Film Optoelectronics	277
2081	Drama And Film	PhD in Thin Film Optoelectronics	277
2082	Economics	Mphil in Aviation Management and Economics	277
2083	Economics	PhD in Tourism Economics and Financial Management	277
2084	Education	MA in Guidance and Counselling	277
2085	Electrical Engineering	MSc in Electrical Engineering	277
2086	Electrical Engineering	PhD in Electrical Services	277
2087	Electronic Engineering	Mphil in Optics and Photonics	277
2088	Electronic Engineering	PhD in Photonics	277
2089	English	MA in English Studies for the Professions: English for the Professions	277
2090	Finance	Mphil in Corporate Finance and Asset Pricing	277
2091	Finance	PhD in Corporate Finance and Asset Pricing	277
2092	Human Resource Management	MSc in Human Resource Management	277
2093	Industrial Engineering	MSc/PgD in International Shipping and Transport Logistics	277
2094	Industrial Engineering	PhD in Transport and Logistics Management	277
2095	Information Systems	Mphil in Enterprise Information Systems and Quality Management	277
2096	Information Systems	PhD in Enterprise Information Systems and Quality Management	277
2097	Language	MA in Chinese Culture	277
2098	Language	Doctor of Applied Language Sciences	277
2099	Law	Mphil in Maritime Law and Shipping Finance	277
2100	Law	PhD in Maritime Law and Shipping Finance	277
2101	Management	MSc/PgD in Engineering Business Management	277
2102	Marketing	Mphil in Marketing	277
2103	Materials	Mphil in Advanced Materials and Processing	277
2104	Materials	PhD in Advanced Materials and Processing	277
2105	Mathematics	Mphil in Computational Mathematics	277
2106	Mathematics	PhD in Computational Mathematics	277
2107	Mba	Master of Business Administration	277
2108	Mechanical Engineering	MSc in Mechanical Engineering	277
2109	Medicine	MSc in Medical Laboratory Science	277
2110	Nursing	MSc in Nursing	277
2111	Operations	PhD in Operations Research	277
2112	Philosophy	Mphil in Neo-Confucian Philosophy and Learning	277
2113	Philosophy	PhD in Neo-Confucian Philosophy and Learning	277
2114	Physics	Mphil in Theoretical and Computational Physics	277
2115	Physics	PhD in Theoretical and Computational Physics	277
2116	Psychology	Master of Applied Psychology	277
2117	Social Work	Master of Social Work	277
2118	Social Work	PhD in Social Work and Human Service Management	277
2119	Statistics	Mphil in Applied Statistics	277
2120	Statistics	PhD in Applied Statistics	277
2121	Supply Chain And Logistics	Mphil in Supply Chain Management	277
2122	Supply Chain And Logistics	PhD in Supply Chain Management	277
2123	Water Resources Engineering	MPhil in Coastal and Hydraulic Engineering	277
2124	Water Resources Engineering	PhD in Coastal and Hydraulic Engineering	277
2125	AIAVC	MS in Artificial Intelligence and Advanced Visual Computing	278
2126	Economics	MS in Economics	278
2127	Civil and Environmental Engineering	PhD in Civil and Environmental Engineering	282
2128	Civil Engineering	MS in Civil and Environmental Engineering	282
2129	CS	MSE in Computer Science	282
2130	CS	PhD in Computer Science	282
2131	ECE	MS in Electrical Engineering	282
2132	ECE	PhD in Electrical and Computer Engineering	282
2133	Economics	PhD in Economics	282
2134	EE	PhD in EE	282
2135	Finance	Master in Finance	282
2136	Geoscience	PhD in Geoscience	282
2137	MAE	PhD in Mechanical and Aerospace Engineering	282
2138	MPA	Master of Public Affairs	282
2139	ORFE	MS in Operations Research and Financial Engineering	282
2140	ORFE	PhD in Operations Research & Financial Engineering	282
2141	Public Affairs	PhD in Public Affairs	282
2142	QCB	PhD in Quantitative and Computational Biology	282
2143	BAIM	MS in Business Analytics and Information Management	283
2144	CGT	MS in Computer Graphics Technology	283
2145	Chemical	PhD in Chemical Engineering	283
2146	Chemistry	PhD in Chemistry	283
2147	CIT	MS in Computer and Information Technology	283
2148	Civil Engineering	MS in Civil Engineering	283
2149	Communication	PhD in Communication	283
2150	CS	MS in Computer Science	283
2151	CS	PhD in Computer Science	283
2152	Design	MS in Industrial & Interaction design	283
2153	Diseases	PhD in Infectious Diseases, Host-Pathogen Interactions and Immunology	283
2154	ECE	MS in Electrical and Computer Engineering	283
2155	EE	MS in Electronic Engineering	283
2156	EE	PhD in Electronic Engineering	283
2157	ESE-IGP	PhD in Ecological Sciences & Engineering Interdisciplinary Graduate Program	283
2158	I/O Psych	PhD in Industrial/Organizational Behavior	283
2159	IE	PhD in Industrial Engineering	283
2160	Industrial Engineering	MS in Industrial Engineering	283
2161	Learning Design and Technology	MS in Education in Learning Design and Technology	283
2162	Linguistics	PhD in Linguistics	283
2163	Marketing	PhD in Marketing	283
2164	Materials	MS in Materials Engineering	283
2165	Materials	PhD in Materials Engineering	283
2166	ME	MS in Mechanical Engineering	283
2167	ME	PhD in Mechanical Engineering	283
2168	MIS	PhD in Management Information Systems 	283
2169	MSF	Master of Science in Finance	283
2170	Statistics	MS in Statistics	283
2171	Statistics	PhD in Statistics	283
2172	Transportation	PhD in Transportation Engineering	283
2173	Biostatistics	PhD in Biostatistics	285
2174	CE	MS in Computer Engineering	285
2175	Chemical	PhD in Chemical and Biomolecular Engineering	285
2176	Chemistry	PhD in Chemistry	285
2177	CS	Master of Computer Science	285
2178	CS	PhD in Computer Science	285
2179	DS	MS in Data Science	285
2180	ECE	PhD in Electrical and Computer Engineering	285
2181	Industrial Engineering	MS in Industrial Engineering	285
2182	Materials	MS in Materials Science	285
2183	Materials	PhD in Materials Science	285
2184	MCSE	Master of Computational Science and Engineering	285
2185	ME	MS in Mechanical Engineering	285
2186	MEE	Master of Electrical Engineering	285
2187	Psych	PhD in Industrial/Organizational Behavior	285
2188	Statistics	Master in Statistics	285
2189	Statistics	PhD in Statistics	285
2190	BME	MS in Biomedical Engineering	286
2191	CIS	MS in Comparative International Studies	286
2192	Computational Biology and Bioinformatics	MSc in Computational Biology and Bioinformatics	286
2193	CS	MSc in Computer Science	286
2194	CS	PhD in Computational Science	286
2195	CSE	MS in Computational Science and Engineering	286
2196	CyberSecurity	MS in Cyber Security	286
2197	Data Science	MSc in Data Science	286
2198	Earth	MSc in Earth Sciences	286
2199	ECE	MS in Electrical Engineering	286
2200	EEIT	MS in Electrical Engineering and Information Technology	286
2201	ES	MS in Environmental Sciences	286
2202	Geomatics	MS in Geomatics	286
2203	Materials	MSc in Materials Science	286
2204	ME	MSc in Mechanical Engineering	286
2205	MSRSC	MS in Robotics, Systems and Control	286
2206	MTEC	MS in Management, Technology, and Economics	286
2207	Pharmaceutical	MS in Pharmaceutical Sciences	286
2208	Quantitative Finance	MSc in Quantitative Finance	286
2209	RSC	MS in  Robotics, Systems and Control	286
2210	Statistics	MSc in Statistics	286
2211	Biology	MS in Biology	287
2212	Chemistry	MS in Chemistry and Business Studies	287
2213	Computer Science	PhD in Computational Science	287
2214	Economics	MA in Business and Economics	287
2215	Economics	PhD in Management and Economics	287
2216	English	MA in Computational Linguistics and Language Technology	287
2217	Environmental Science	MS in Quantitative Environmental Sciences	287
2218	Finance	PhD in Finance	287
2219	Financial Engineering	MS in Quantitative Finance	287
2220	Geology	MS in Earth System Science	287
2221	Geophysics	MS in Geography	287
2222	Geosciences	MS in Geography (Specialized Master)	287
2223	Geosciences	PhD in Geography	287
2224	GIS	MS in Geography	287
2225	Information Systems	MS in Informatics	287
2226	Information Systems	PhD in Informatics	287
2227	Law	Master of Law	287
2228	Literature	MA in English Literature	287
2229	Mathematics	MS in Mathematics	287
2230	Physics	MS in Physics	287
2231	Physics	PhD in Physics	287
2232	Statistics	MS in Biostatistics	287
2233	Chemistry	PhD in Chemistry	289
2234	CS	MS in Computer Science	289
2235	CS	PhD in Computer Science	289
2236	Earth Science	PhD in Earth Science	289
2237	EE	MS in Electrical Engineering	289
2238	EE	PhD in Electrical Engineering	289
2239	ME	PhD in Mechanical Engineering	289
2240	MSCE	MS in Computer Engineering	289
2241	Physics	PhD in Physics and Astronomy	289
2242	Stat	PhD in Statistics	289
2243	Statistics	MS in Statistics	289
2244	Statistics	PhD in Statistics	289
2245	Bio	PhD in Biomedical Sciences-Pharmacology, Cellular and Molecular	291
2246	Biostatistics	MS in Biostatistics	291
2247	Cell & Developmental Biology	MS in Cell & Developmental Biology	291
2248	Chemistry	PhD in Chemistry	291
2249	CIM	PhD in Communication, Information and Media	291
2250	CS	MS in Computer Science	291
2251	CS	PhD in Computer Science	291
2252	ECE	MS in Electrical and Computer Engineering	291
2253	ECE	PhD in Electrical and Computer Engineering	291
2254	Economics	PhD in Economics	291
2255	Industrial and Systems Engineering	MS in Industrial and Systems Engineering	291
2256	Industrial System Engineering	PhD in Industrial and Systems Engineering	291
2257	IT	Master of Information Technology	291
2258	Materials	MS in Materials Science and Engineering	291
2259	Math	PhD in Mathematics	291
2260	Mathematical Finance	MS in Mathematical Finance	291
2261	MBS-Analytics	MBS in Analytics	291
2262	MCRP	Master of City and Regional Planning	291
2263	ME	MS in Mechanical Engineering	291
2264	ME	PhD in Mechanical and Aerospace Engineering	291
2265	MSF	Master of Financial Analysis	291
2266	Physics	PhD in Physics	291
2267	Quantitative Finance	Master of Quantitative Finance	291
2268	Statistics	MS in Statistics	291
2269	Statistics	PhD in Statistics	291
2270	Business Analytics	MS in Business Analytics	293
2271	CS	MS in Computer Science	293
2272	Information Systems	MS in Information Systems	293
2273	Accounting	MPAC (Master of Professional Accounting)	294
2274	Business Analytics	MS in Business Analytics	294
2275	Computer Science	MS in Computer Science	294
2276	CS	MS in Computer Science	294
2277	Law	JD/MPAC	294
2278	CS	MS in Computer Science	296
2279	MIS	MS in Information Systems	296
2280	EM	MS in Engineering Management	297
2281	Statistics	MS in Statistics	297
2282	Accounting	PhD in Accounting	298
2283	Agriculture	MS in Crop Science	298
2284	Agriculture	PhD in Crop Science	298
2285	Anthropology	MA in Evolutionary Anthropology	298
2286	Anthropology	PhD in Anthropology	298
2287	Architecture	Master of Architecture	298
2288	Area Studies	PhD in American Studies	298
2289	Biology	MS in Entomology	298
2290	Biology	PhD in Molecular Plant Sciences	298
2291	Biomedical Engineering	PhD in Biological and Agricultural Engineering	298
2292	BME	MS in Biological and Agricultural Engineering	298
2293	Chemical Engineering	MS in Chemical Engineering	298
2294	Chemical Engineering	PhD in Chemical Engineering	298
2295	Chemistry	MS in Chemistry	298
2296	Chemistry	PhD in Chemistry	298
2297	Communication	Master of Arts in Communication	298
2298	Communication	PhD in Communication	298
2299	Computer Engineering	MS in Computer Engineering	298
2300	Computer Engineering	PhD in Electrical and Computer Engineering	298
2301	Computer Science	MS in Computer Science	298
2302	Computer Science	PhD in Computer Science	298
2303	Criminology	MA in Criminal Justice	298
2304	Econ	PhD in Economics and Econometrics	298
2305	Economics	MS in Applied Economics	298
2306	Economics	PhD in Agricultural Economics	298
2307	Education	MA in Education: Curriculum and Instruction	298
2308	Education	PhD in Education: Special Education	298
2309	Electrical Engineering	MS in Electrical Engineering	298
2310	English	MA in English	298
2311	English	PhD in English	298
2312	Entrepreneurship	EdD in Education: Educational Leadership	298
2313	Environmental Engineering	MS in Environmental Engineering (Non-Thesis)	298
2314	Environmental Science	MS in Natural Resource Sciences	298
2315	Environmental Science	PhD in Environmental and Natural Resource Sciences	298
2316	Financial Engineering	MS in Mathematics (Computational Finance Option)	298
2317	Fine Arts	MA in Music-without emphasis	298
2318	FineArt	Master of Fine Arts	298
2319	Food Science And Technology	MS in Food Science	298
2320	Food Science And Technology	PhD in Food Science	298
2321	Geosciences	MS in Geology	298
2322	Geosciences	PhD in Geology	298
2323	Health	MS in Dietetics, Nutrition and Exercise Physiology	298
2324	Health	DNP (Doctor of Nursing Practice)	298
2325	History	MA in History (thesis)	298
2326	History	PhD in History	298
2327	Information Systems	PhD in Management Information Systems	298
2328	Language	PhD in Education: Language, Literacy and Technology	298
2329	Law	PhD in Criminal Justice	298
2330	Management	PhD in Operations and Management Science	298
2331	Marketing	PhD in Marketing	298
2332	Materials	MS in Materials Science and Engineering (Thesis)	298
2333	Materials	PhD in Materials Science and Engineering	298
2334	Mathematics	MS in Mathematics	298
2335	Mathematics	PhD in Mathematics	298
2336	Mechanical Engineering	MS in Mechanical Engineering (thesis)	298
2337	Mechanical Engineering	PhD in Mechanical Engineering	298
2338	Medicine	MS in Plant Pathology	298
2339	Medicine	PhD in Clinical Psychology	298
2340	Music And Dance	MA in Music-Jazz Studies	298
2341	Nursing	Master of Nursing	298
2342	Pharmacy	PhD in Pharmaceutical Sciences	298
2343	Plant Science	PhD in Horticulture	298
2344	Political Science	PhD in Political Science	298
2345	Psychology	MA in Education: Educational Psychology	298
2346	Psychology	PhD in Experimental Psychology	298
2347	Public Affairs	MPA (Master of Public Affairs)	298
2348	Public Health	PhD in Immunology and Infectious Diseases	298
2349	Sociology	PhD in Sociology	298
2350	Statistics	MS in Statistics	298
2351	Statistics	PhD in Statistical Science	298
2352	Water Resources Engineering	MS in Civil Engineering (non-Thesis)	298
2353	Water Resources Engineering	PhD in Civil Engineering	298
2354	Accounting	MS in Accounting	305
2355	Analytics	MS in Analytics	305
2356	Applied Data Science	MS in Applied Data Science	305
2357	Applied Math	MS in Applied Mathematics	305
2358	Biostatistics	MS in Biostatistics	305
2359	Biostatistics	PhD in Biostatistics	305
2360	BME	PhD in Biomedical Engineering	305
2361	Business Analytics	MS in Business Analytics	305
2362	Chemical	MS in Chemical Engineering	305
2363	Chemical	PhD in Chemical Engineering	305
2364	CivilEng	MS in Civil & Environmental Engineering	305
2365	Communication Management	MS in Communication Management	305
2366	Communication-DS	MS in Communication Data Science	305
2367	Computer Engineering	MS in Computer Engineering	305
2368	CS	BS in Computer Science	305
2369	CS	MS in Computer Science	305
2370	CS	PhD in Computer Science	305
2371	CS-AI	MS in Computer Science-Artificial Intelligence	305
2372	CS-Data Science	MS in Computer Science–Data Science	305
2373	CS-Intelligent Robotics	MS in Computer Science-Intelligent Robotics	305
2374	CS-MCT	MS in Computer Science-Multimedia and Creative Technologies	305
2375	CS-SE	MS in Computer Science-Software Engineering	305
2376	CS-Security	MS in Computer Science-Computer Security	305
2377	CS37	MS in Computer Science-Scientists and Engineers	305
2378	Cybersecurity	MS in Cyber Security Engineering	305
2379	Data Informatics	MS in Data Informatics	305
2380	DigitalSocialMedia	MS in Digital Social Media	305
2381	EALC	PhD in East Asian Languages and Cultures	305
2382	Economics	MS in Applied Economics and Econometrics	305
2383	Educational Counseling	Master of Education in Educational Counseling	305
2384	EE	MS in Electrical Engineering	305
2385	EE	PhD in Electrical Engineering	305
2386	Epidemiology	PhD in Epidemiology 	305
2387	Finance	MS in Finance	305
2388	Finance	PhD in Finance	305
2389	Geosciences	PhD in Earth Science	305
2390	Global Supply Chain Management	MS in Global Supply Chain Management	305
2391	Healthcare Data Science	MS in Healthcare Data Science	305
2392	Industrial and Systems Engineering	MS in Industrial and Systems Engineering	305
2393	ISE	PhD in Industrial and Systems Engineering	305
2394	Marketing	MS in Marketing	305
2395	Marriage and Family Therapy	MS in Marriage and Family Therapy	305
2396	Materials	MS in Materials Science	305
2397	MathFin	MS in Mathematical Finance	305
2398	ME	MS in Mechanical Engineering	305
2399	ME	PhD in Mechanical Engineering	305
2400	MFE	MS in Financial Engineering	305
2401	Microbiology	MS in Molecular Microbiology and Immunology	305
2402	MJ	MA in Journalism	305
2403	MMSS	Master of Music Screen Scoring	305
2404	MPH	MPH in Molecular Epidemiology	305
2405	Pre-master Cyber Security	Pre-master Cyber Security	305
2406	Pre-master ECE-MLDS	Pre-master ECE-Machine Learning and Data Science	305
2407	Pre-master EE	Pre-master Electrical Engineering	305
2408	Public Policy	Master of Public Policy	305
2409	Public Policy	PhD in Public Policy and Management	305
2410	Social Work	Master of Social Work	305
2411	Statistics	MS in Statistics	305
2412	Biostatistics	PhD in Biostatistics	306
2413	Business Analytics	MS in Business Analytics	306
2414	CS	MS in Computer Science	306
2415	CS	PhD in Computer Science	306
2416	Engineering Management	MS in Engineering Management	306
2417	Statistics	M.S. in Applied Statistics and Data Analytics	306
2418	Statistics	PhD in Statistical Science	306
2419	Biomedical Engineering	MS in Biomedical Engineering	307
2420	Computer Engineering	MS in Electrical and Computer Engineering	307
2927	History	MA in History	372
2421	Computer Engineering	PhD in Electrical and Computer Engineering	307
2422	English	MA in English	307
2423	English	PhD in English	307
2424	CS	PhD in Computer Science	310
2425	ME	MS in Mechanical Engineering	310
2426	Transportation	PhD in Transportation Engineering	310
2427	CS	PhD in Computer Science	311
2428	EE	MEng in Electrical Engineering	311
2429	EE	PhD in Electronic Engineering and Telecommunications	311
2430	ME	PhD in Engineering	311
2431	AI	MS in Artificial Intellligence	312
2432	Chemistry	MSc in Instrumental Analytical Chemistry	312
2433	Chemistry	PhD in Chemistry	312
2434	Civil Engineering	MSc in Transportation Planning and Engineering (Behaviour)	312
2435	Design	MA in Fashion Design	312
2436	Drama And Film	MA in Film and Cultural Management	312
2437	Fine Art	MA in Fine Art	312
2438	Fine Arts	MSc in Unmanned Aircraft Systems Design	312
2439	Mechanical Engineering	MSc in Computational Engineering Design (Advanced Mechanical Engineering Science)	312
2440	MINDS	Machine Intelligence for Nano- Electronic Devices and Systems (MINDS	312
2441	Music And Dance	MA in International Music Management	312
2442	Music And Dance	PhD in Music	312
2443	Operations	MSc in Transportation Planning and Engineering (Operations)	312
2444	Textile And Light Industry	MPhil/PhD in Fashion and Textiles	312
2445	Urban Planning	MSc in Transportation Planning & Engineering	312
2446	Accounting	Master of Accounting	318
2447	AIM	PhD in Applied and Interdisciplinary Mathematics	318
2448	AP	PhD in Applied Physics	318
2449	Applied Economics	Master of Applied Economics	318
2450	Applied Statistics	MS in Applied Statistics	318
2451	Bioinfo	MS in Bioinformatics	318
2452	Biostatistics	MS in Biostatistics	318
2453	BME	MS in Biomedical Engineering	318
2454	Business Analytics	MS in Business Analytics	318
2455	Chemical	MS in Chemical Engineering	318
2456	Chemical	PhD in Chemical Engineering	318
2457	Chemistry	PhD in Chemistry	318
2458	Civil Engineering	MSE in Civil Engineering	318
2459	Computational Medicine and Bioinformatics	PhD in Computational Medicine and Bioinformatics	318
2460	CS	MS in Computer Science and Engineering	318
2461	CSE	PhD in Computer Science and Engineering	318
2462	Data Science	MS in Data Science	318
2463	Earth Science	PhD in Earth Science	318
2464	ECE	MEng in Electrical and Computer Engineering	318
2465	ECE	MS in Electrical and Computer Engineering	318
2466	ECE	PhD in Electrical and Computer Engineering	318
2467	Environmental Engineering	MS in Environmental Engineering	318
2468	Environmental Sustainability	MS in Environmental Sustainability	318
2469	FE	MS in Financial Engineering	318
2470	Finance	PhD in Finance	318
2471	Geosciences	PhD in Geosciences	318
2472	HILS	PhD in Health Infrastructures and Learning Systems	318
2473	Industrial & Operations Engineering	MS in Industrial & Operations Engineering	318
2474	Information	MS in Information	318
2475	Information	PhD in Information	318
2476	IOE	PhD in Industrial and Operations Engineering	318
2477	Macromolecular Science and Engineering	PhD in Macromolecular Science and Engineering	318
2478	Materials	MS in Materials Science and Engineering	318
2479	Materials	PhD in Materials Science and Engineering	318
2480	MDes in Integrative Design	MDes in Integrative Design	318
2481	ME	MSE in Mechanical Engineering	318
2482	ME	PhD in Mechanical Engineering	318
2483	Molecular, Cellular, and Developmental Biology	MS in Molecular, Cellular, and Developmental Biology	318
2484	Movement	MS in Movement Science	318
2485	MPP	Master of Public Policy	318
2486	Nutrition	MS in Nutritional Sciences	318
2487	Physics	PhD in Physics	318
2488	PublicHealth	PhD in Public Health	318
2489	QFRM	MS in Quantitative Finance and Risk Management	318
2490	Robotics	MS in Robotics	318
2491	Statistics	PhD in Statistics	318
2492	Supply Chain Management	Master of Supply Chain Management	318
2493	Survey Methodology	PhD in Survey Methodology	318
2494	Business Analytics	MS in Business Analytics 	319
2495	Public Management Administration	Master of Public Administration	319
2496	Aeronautics and Astronautics	PhD in Aeronautics and Astronautics	320
2497	BMI	MS in Biomedical Informatics	320
2498	CEE	PhD in Civil and Environmental Engineering	320
2499	Chemical	MS in Chemical Engineering	320
2500	Civil Engineering	MS in Civil Engineering	320
2501	CS	MS in Computer Science	320
2502	CS	PhD in Computer Science	320
2503	Design Impact	MS in Design Impact Engineering 	320
2504	Earth System Science	MS in Earth System Science	320
2505	EDS	MS in Education Data Science	320
2506	EE	MS in Electrical Engineering	320
2507	EE	PhD in Electrical Engineering	320
2508	HealthPolicy	PhD in Health Policy	320
2509	ICME	MS in Institute for Computational & Mathematical Engineering	320
2510	Management	MS in Management Science and Engineering	320
2511	Management	PhD in Management Science and Engineering	320
2512	Material	MS in Materials Science and Engineering	320
2513	Materials	PhD in Materials Science and Engineering	320
2514	MBA	Master of Business Administration	320
2515	ME	MS in Mechanical Engineering	320
2516	Music	PhD in Computer-Based Music Theory and Acoustics	320
2517	OIT	PhD in Operations, Information & Technology	320
2518	OrganizationalBehavior	PhD in Organizational Behavior	320
2519	SocialPsych	PhD in Social Psychology	320
2520	Stat:Data Science	MS in Statistics: Data Science	320
2521	Statistics	MS in Statistics	320
2522	Statistics	PhD in Statistics	320
2523	CS	Phd in Computer Science	321
2524	MPA	Master of Public Administration and Policy	321
2525	CS	MS in Computer Science	322
2526	CS	PhD in Computer Science	322
2527	MBA	MBA in Business Administration	322
2528	Statistics	MA in Statistics	322
2529	Bioinformatics and Biostatistics	MS in Bioinformatics and Biostatistics	323
2530	BME	MS in Chemical and Biological Engineering	323
2531	Chemical	PhD in Chemical Engineering	323
2532	CSE	MS in Computer Science and Engineering	323
2533	CSE	PhD in Computer Science and Engineering	323
2534	Data Science	MS in Engineering Science: Data Sciences	323
2535	industrial engineering	MS in Industrial Engineering	323
2536	Math	PhD in Mathematics	323
2537	ME	MS in Mechanical Engineering	323
2538	MIS	MS in Management Information Systems	323
2539	Pharmacology	MS in Pharmacology	323
2540	Applied Mathematics	PhD in Applied Mathematics and Statistics	324
2541	CS	MS in Computer Science	324
2542	CS	PhD in Computer Science	324
2543	ECE	MS in Electrical and Computer Engineering	324
2544	ECE	PhD in Electrical and Computer Engineering	324
2545	Econ	PhD in Economics and Econometrics	324
2546	Materials	MS in Materials Science and Engineering	324
2547	Molecular and cellular Pharmacology	MS in Biomedical Sciences: Molecular and Cellular Pharmacology	324
2548	Physics	PhD in Physics	324
2549	Qfin	MS in Quantitative Finance	324
2550	Statistics	MS in Statistics	324
2551	Statistics	PhD in Statistics	324
2552	BIOSTAT	PhD in Biostatistics	326
2553	Biostatistics	MS in Biostatistics	326
2554	BME	PhD in Biomedical Engineering	326
2555	Chemistry	MD/PhD in Chemistry	326
2556	CS	MS in Computer Science	326
2557	CS	PhD in Computer Science	326
2558	ECE	MS in Electrical and Computer Engineering	326
2559	ECE	PhD in Electrical and Computer Engineering	326
2560	Epidemiology	MS in Epidemiology	326
2561	Industrial Engineering	MS in Industrial Engineering	326
2562	INFECTIOUS DISEASES AND MICROBIOLOGY	PhD in Infectious Diseases and Microbiology	326
2563	IS	Master of Science in Information Science	326
2564	IS	PhD in Information Systems and Technology Management	326
2565	Materials	PhD in Materials Science and Engineering	326
2566	ME	PhD in Mechanical Engineering	326
2567	Statistics	MA in Statistics	326
2568	Statistics	PhD in Statistics	326
2569	Actuarial Science	MS in Actuarial Science	331
2570	BAMIS	PhD in Business Administration program, with a concentration in Management Information Systems	331
2571	CS	Phd in Computer Science	331
2572	ECE	PhD in Electrical and Computer Engineering	331
2573	Quantitative Finance and Risk Management	MS in Quantitative Finance and Risk Management	331
2574	Statistics	PhD in Statistics	331
2575	Biochemistry&biophysics	PhD in Biochemistry&Biophysics	332
2576	Chemical	PhD in Chemical Engineering	332
2577	Chemistry	PhD in Chemistry	332
2578	Civil Engineering	MS in Civil Engineering	332
2579	CMSS	PhD in Coastal and Marine System Science	332
2580	Construction Management	MS in Construction Management	332
2581	CS	MS in Computer Science	332
2582	CS	PhD in Computer Science	332
2583	CSE-CE	MS in Computer Engineering-CSE	332
2584	Earth Science	PhD in Earth Science	332
2585	ECE-CE	MS in Computer Engineering-ECE	332
2586	EE	MS in Electrical Engineering	332
2587	EE	PhD in Electrical Engineering	332
2588	Geosciences	PhD in Geosciences	332
2589	Industrial Engineering	MS in Industrial Engineering	332
2590	Materials	PhD in Materials Science and Engineering	332
2591	Math	PhD in Mathematics	332
2592	ME	MS in Mechanical Engineering	332
2593	ME	PhD in Mechanical Engineering	332
2594	MIS	MS in Management of Information Systems	332
2595	MUP	Master of Urban Planning	332
2596	Statistics	PhD in Statistics	332
2597	Agriculture	PhD in Advance Agriculture Technology and Science	333
2598	Biology	PhD in Human Biology	333
2599	Biomedical Engineering	PhD in Life Science and Bioengineering	333
2600	Geology	PhD in Earth Evolution Science	333
2601	Information Systems	PhD in Empowerment Informatics	333
2602	Chemical Engineering	MS in Petroleum Engineering	335
2603	Data Science	MS in Data Science	335
2604	Electrical Engineering	MS in Electrical Engineering	335
2605	Electrical Engineering	PhD in Electrical Engineering	335
2606	CS	MSc in Computer Science	337
2607	MSCS	MSc in Computer Science	337
2608	Computational and Applied Mathematics	PhD in Computational and Applied Mathematics	338
2609	CS	MS in Computer Science	338
2610	CS	PhD in Computer Science	338
2611	Data Analytics	MS in Data Analytics	338
2612	Data Science	MS in Data Science	338
2613	Economics	MS in Economics	338
2614	EE	MS in Electrical Engineering	338
2615	EE	PhD in Electrical Engineering	338
2616	ME	MS in Mechanical Engineering	338
2617	MSIM	MS In Innovation & Management	338
2618	Nutrition	MS in Nutrition	338
2619	Physics	MS in Physics	338
2620	Software Systems Development	MS in Software Systems Development	338
2621	Biostatistics	MS in Biostatistics	339
2622	Epidemiology	MS in Epidemiology	339
2623	Finance	Master of Finance	339
2624	Mathematics	MS in Mathematics	339
2625	Mathematics	PhD in Mathematics	339
2626	MPH	Master of Public Health	339
2627	Accounting	MSc in Accounting and Financial Management: Financial Accounting	341
2628	Anthropology	MA in Digital Humanities	341
2629	Atmospheric Science	MSc in Physics: Meteorology	341
2630	Biology	MSc in Chemistry: Biochemistry	341
2631	Biomedical Engineering	MSc in Applied Biotechnology	341
2632	Chemistry	MSc in Chemistry: Organic Chemistry	341
2633	Computer Science	MSc in Human-Computer Interaction	341
2634	CS	MS in Image Analysis and Machine Learning	341
2635	Design	MA in Game Design	341
2636	Economics	MSc in Economics	341
2637	Education	MA in Sociology of Education	341
2638	English	MA in English: English Linguistics	341
2639	Entrepreneurship	MSc in Sustainable Destination Development: Entrepreneurship for Destination Development	341
2640	Geology	MSc in Earth Science: Geology	341
2641	Geosciences	MSc in Earth Science: Palaeobiology	341
2642	History	MA in Early Modern History	341
2643	Information Systems	MSc in Information Systems	341
2644	International Business	MSc in Business and Management: International Business	341
2645	Language	MA in Language Technology	341
2646	Law	LLM in Intellectual Property Law	341
2647	Literature	MA in English: English Literature	341
2648	Management	MSc in Wind Power Project Management (two year)	341
2649	Marketing	MSc in Business and Management: Marketing	341
2650	Mathematics	MSc in Mathematics: Mathematics	341
2651	Natural Conservation And Ecology	MSc in Biology: Ecology and Conservation	341
2652	Pharmacy	MSc in Pharmaceutical Modelling	341
2653	Physics	MSc in Physics: Theoretical Physics - Quantum Fields and Strings	341
2654	Political Science	MSc in Political Science	341
2655	Public Health	MSc in Global Health	341
2656	Sociology	MA in the Humanities: Aesthetics	341
2657	Statistics	MSc in Statistics	341
2658	CS	MSc in Computing Science	343
2659	CS	PhD in Computing Science	343
2660	ECE	MSc in Electrical and Computer Enigeering	343
2661	MFM	Master of Financial Management	343
2662	Statistical Machine Learning	MS in Statistical Machine Learning	343
2663	Water Resources	MS in Water Resources	343
2664	Bio	PhD in Bioengineering	354
2665	Biostatistics	MA in Biostatistics	354
2666	Biostatistics	PhD in Biostatistics	354
2667	CEE	PhD in Civil & Environmental Engineering	354
2668	Chemistry	PhD in Chemistry	354
2669	Civil Engineering	MS in Civil Engineering	354
2670	CS	Meng in Computer Sciences	354
2671	CS	PhD in Computer Science	354
2672	ECON	PhD in Economics	354
2673	EE	PhD in Electrical Engineering	354
2674	EE-Meng	Meng in Electrical Engineering	354
2675	EECS 	Meng in EECS	354
2676	EECS	MS in Computer Sciences	354
2677	EECS-Data Science	Meng in EECS-Data Science and Systems	354
2678	EPM	MS in Engineering and Project Management	354
2679	EPS	PhD in Earth and Planetary Science	354
2680	ESPM	PhD in Environmental Policy, Science and Management	354
2681	Fintech	Berkeley FinTech Boot Camp	354
2682	IB	PhD in Integrative Biology	354
2683	IEOR	Meng in Industrial Engineering & Operations Research	354
2684	IEOR	PhD in Industrial Engineering and Operations Research	354
2685	Infectious Diseases and Vaccinology	MPH in Infectious Diseases and Vaccinology	354
2686	Information and Data Science	Online Master of Information and Data Science	354
2687	Journalism	MA in Journalism	354
2688	Material	Meng in Materials	354
2689	Material	PhD in Materials	354
2690	MDes	Master of Design	354
2691	MDP	MS in Development Practice	354
2692	ME	MS in Mechanical Engineering	354
2693	ME	PhD in Mechanical Engineering	354
2694	ME-Meng	Meng in Mechanical Engineering 	354
2695	MFE	Master of Financial Engineering	354
2696	MIS	Master of Information Management and Systems	354
2697	MPH	MPH in Infectious Disease and Vaccinology	354
2698	MPP	Master of Public Policy	354
2699	Statistics	MA in Statistics	354
2700	Statistics	PhD in Statistics	354
2701	Transportation	PhD in Transportation Engineering	354
2702	Applied Math	PhD in Applied Mathematics	355
2703	Biostatistics	MS in Biostatistics	355
2704	Biostatistics	PhD in Biostatistics	355
2705	Business Analytics	MS in Business Analytics	355
2706	Chemical	MS in Chemical Engineering	355
2707	Civil Engineering	MS in Civil Engineering	355
2708	CS	MS in Computer Science	355
2709	CS	PhD in Computer Science	355
2710	ECE	MS in Electrical and Computer Engineering	355
2711	ECE	PhD in Electrical and Computer Engineering	355
2712	Economics	MS in Economics	355
2713	Intergrative Genetics and Genomics	PhD in Intergrative Genetics and Genomics	355
2714	ME	MS in Mechanical and Aerospace Engineering	355
2715	ME	PhD in Mechanical and Aerospace Engineering	355
2716	Physics	MS in Physics	355
2717	Public Health	PhD in Public Health	355
2718	Statistics	MS in Statistics	355
2719	Statistics	PhD in Statistics	355
2720	Accounting	Master of Professional Accountancy	356
2721	Biotechnology	MS in Biotechnology	356
2722	BME	PhD in Biomedical Engineering	356
2723	CE	MS in Computer Engineering	356
2724	ChaMP	MS in Chemical and Materials Physics	356
2725	Civil Engineering	MS in Civil Engineering	356
2726	CS	MS in Computer Science	356
2727	CS	PhD in Computer Science	356
2728	EE	MS in Electrical Engineering	356
2729	EE	PhD in Electrical Engineering	356
2730	Engineering Management	MS in Engineering Management	356
2731	Informatics	MS in Informatics	356
2732	Informatics	PhD in Informatics	356
2733	Math	PhD in Mathematics	356
2734	MDS	Master of Data Science	356
2735	ME	MS in Mechanical and Aerospace Engineering	356
2736	MIE	Master of Innovation and Entrepreneurship	356
2737	MPP	Master of Public Policy	356
2738	MSBA	MS in Business Analytics	356
2739	MSWE	Master of Software Engineering	356
2740	NetworkedSystems	MS in Networked Systems	356
2741	Physics	PhD in Physics	356
2742	Software Engineering	MS in Software Engineering	356
2743	Statistics	MS in Statistics	356
2744	Statistics	PhD in Statistics	356
2745	AppliedStat	Master of Applied Statistics	357
2746	Bioengineering	PhD in Bioengineering	357
2747	Bioinformatics	PhD in Bioinformatics	357
2748	Biomathematics	PhD in Biomathematics	357
2749	Biostatistics	MS in Biostatistics	357
2750	BME	MS in Biomedical Engineering	357
2751	Business Analytics	MS in Business Analytics	357
2752	Chemistry	PhD in Chemistry	357
2753	Civil Engineering	MS in Civil Engineering	357
2754	CS	MS in Computer Science	357
2755	CS	PhD in Computer Science	357
2756	DS	Master in DataScience	357
2757	ECE	MS in Electrical and Computer Engineering	357
2758	Economics	PhD in Economics	357
2759	geography	PhD in Geography	357
2760	MAE	Master of Applied Economics 	357
2761	Material	MS in Materials Science and Engineering	357
2762	Material	PhD in Materials Science and Engineering	357
2763	ME	MS in Mechanical and Aerospace Engineering	357
2764	ME	PhD in Mechanical Engineering	357
2765	MENG	Master of Engineering	357
2766	MFE	Master of Financial Engineering	357
2767	MPP	Master of Public Policy	357
2768	Physics	PhD in Physics	357
2769	Public Policy	Master of Public Policy	357
2770	Social Welfare	Master of Social Welfare	357
2771	Statistics	MS in Statistics	357
2772	Statistics	PhD in Statistics	357
2773	CIS	PhD in Cognitive and Information Sciences 	358
2774	EECS	MS in Electrical Engineering and Computer Science	358
2775	EECS	PhD in Electrical Engineering and Computer Science	358
2776	ME	PhD in Mechanical Engineering	358
2777	Bioengineering	MS in Bioengineering	359
2778	Bioinformatics	PhD in Bioinformatics and Systems Biology	359
2779	Biostatistics	MS in Biostatistics	359
2780	BME	PhD in Bioengineering	359
2781	CE	MS in Computer Engineering	359
2782	Chemistry	PhD in Chemistry	359
2783	Cognitive Science	PhD in Cognitive Science	359
2784	CS	MS in Computer Science	359
2785	CS	PhD in Computer Science	359
2786	CSME	MS in Computational Science, Mathematics and Engineering	359
2787	Earth Science	PhD in Earth Sciences	359
2788	EC-78	MS in Electronic Circuits and Systems	359
2789	EC80	MS in Intelligence Systems, Robotics and Control	359
2790	ECE	MS in Electrical and Computer Engineering	359
2791	ECE	PhD in Electrical and Computer Engineering	359
2792	Economics	Master of Arts in Economics	359
2793	Economics	PhD in Economics	359
2794	Materials	MS in Materials Science	359
2795	Materials	PhD in Materials Science	359
2796	Math	PhD in Mathematics	359
2797	Math-ComputationalScience	PhD in Mathematics with a Specialization in Computational Science	359
2798	Math-Stat	PhD in Mathematics with a Specialization in Statistics	359
2799	ME	MS in Mechanical Engineering	359
2800	MLDS	MS in Machine Learning & Data Science Focus	359
2801	MPP	Master of Public Policy	359
2802	MSBA	MS in Business Analytics	359
2803	MSF	Master of Finance	359
2804	Music	PhD in Music	359
2805	Nanoengineering	PhD in Nanoengineering	359
2806	Statistics	MS in Statistics	359
2807	Structural Engineering	MS in Structural Engineering	359
2808	Basic Medicine	PhD in Neuroscience	360
2809	Biological Engineering	PhD in Biomedical Sciences	360
2810	Biology	PhD in Developmental and Stem Cell Biology	360
2811	Chemistry	PhD in Chemistry and Chemical Biology	360
2812	Pharmacy	PhD in Pharmaceutical Sciences and Pharmacogenomics	360
2813	Public Health	PhD in Epidemiology & Translational Science	360
2814	CS	MS in Computer Science	361
2815	CS	PhD in Computer Science	361
2816	EE	MS in Electrical & Computer Engineering	361
2817	EE	PhD in Electrical & Computer Engineering	361
2818	Geosciences	PhD in Earth Science	361
2819	management of technology	MS in Technology Management	361
2820	Materials	PhD in Materials	361
2821	Math	PhD in Mathematics	361
2822	ME	MS in Mechanical Engineering	361
2823	Physics	PhD in Physics	361
2824	stat	MA in Data Science	361
2825	Statistics	MA in Statistics	361
2928	History	PhD in History	372
2826	Statistics and Applied Probability	PhD in Statistics and Applied Probability	361
2827	 Communication-Media	MA in Communication and Media Studies	362
2828	CS	MSc in Computer Science	362
2829	CS	PhD in Computer Science	362
2830	EE	MEng in Electrical and Computer Engineering	362
2831	Analytics	MS in Analytics	364
2832	CAM	PhD in Computational and Applied Mathematics	364
2833	CNS	PhD in Computational Neuroscience	364
2834	Computational Analysis and Public Policy	MS in Computational Analysis & Public Policy	364
2835	Computational and Applied Mathematics	MS in Computational and Applied Mathematics	364
2836	CS	MS in Computer Science	364
2837	CS	PhD in Computer Science	364
2838	Econ	PhD in Economics	364
2839	Finance	PhD in Finance	364
2840	FinMath	Financial Mathematics	364
2841	Geosciences	PhD in Geosciences	364
2842	Linguistics	PhD in Linguistics	364
2843	MACSS	Masters in Computational Social Science	364
2844	MAPSS	Master of Arts Program in the Social Sciences	364
2845	Molecular Engineering	PhD in Molecular Engineering	364
2846	MPH	Master in Public Health	364
2847	MPP	Master of Public Policy	364
2848	OM	PhD in Management Science and Operations Management	364
2849	Public Policy	Master of Public Policy	364
2850	Public Policy	PhD in Public Policy	364
2851	Social Work	MS in Social Work	364
2852	Statistics	MS in Statistics	364
2853	Statistics	PhD in Statistics	364
2854	Applied Mathematics	MS in Applied Math	365
2855	Applied Mathematics	PhD in Applied Mathematics	365
2856	Chemistry	PhD in Chemistry	365
2857	Computational Linguistics	MS in Computational Linguistics	365
2858	CS	MS in Computer Science	365
2859	CS	Phd in Computer Science	365
2860	DS	MS in Data Science	365
2861	ECEE	MS in Electrical, Computer and Energy Engineering	365
2862	ECEE	Phd in Electrical, Computer and Energy Engineering	365
2863	Geosciences	PhD in Geological Sciences	365
2864	ME	MS in Mechanical Engineering	365
2865	Biostatistics	PhD in Biostatistics	366
2866	CSIS	PhD in Computer Science and Information Systems	366
2867	MURP	Master of Urban and Regional Planning	366
2868	Statistics	MS in Statistics	366
2869	Electrical Engineering	MS in Electrical Engineering	368
2870	Electrical Engineering	PhD in Electrical Engineering	368
2871	Finance	Master of Finance	368
2872	Financial Engineering	MFM in Financial Mathematics	368
2873	Mechanical Engineering	MS in Mechanical Engineering	368
2874	Bioinformatics and Computational Biology	MS in Bioinformatics & Computational Biology	369
2875	Chemical and Biological Engineering	PhD in Chemical and Biological Engineering	369
2876	CS	MS in Computer Science	369
2877	CS	PhD in Computer Science	369
2878	ECE	PhD in Electrical and Computer Engineering	369
2879	FSAN	PhD in Financial Services Analytics	369
2880	Materials	PhD in Materials Science and Engineering	369
2881	MBA	MBA/MS in International Business	369
2882	Data Science	MS in Data Science	370
2883	Statistics	PhD in Research Methods and Statistics	370
2884	Agricultural and Biological Engineering	PhD in Agricultural and Biological Engineering	371
2885	Biostatistics	MS in Biostatistics	371
2886	Biostatistics	PhD in Biostatistics	371
2887	Chemical	MEng in Chemical Engineering	371
2888	Chemistry	PhD in Chemistry	371
2889	Civil Engineering	MS in Civil Engineering	371
2890	CS	MS in Computer Science	371
2891	CS	PhD in Computer Science	371
2892	ECE	MS in Electrical and Computer Engineering	371
2893	ECE	PhD in Electrical and Computer Engineering	371
2894	ie	MEng in Industrial and Systems Engineering	371
2895	IS	PhD in Information Systems	371
2896	ISOM	MS in Information Systems and Operations Management	371
2897	MAMC	Master of Arts in Mass Communication 	371
2898	Management	MS in Construction Management	371
2899	Materials	PhD in Materials Science and Engineering	371
2900	Math	MS in Mathematics	371
2901	ME	MS in Mechanical Engineering	371
2902	Statistics	Master of Statistics	371
2903	Statistics	PhD in Statistics	371
2904	Agriculture	MSc in Plant Agriculture	372
2905	Agriculture	PhD in Food Science	372
2906	Animal Science	PhD in Animal Biosciences	372
2907	Anthropology	MA in Public Issues Anthropology	372
2908	Architecture	Master of Landscape Architecture	372
2909	Area Studies	MA in Latin American and Caribbean Studies	372
2910	Biology	MSc in Biophysics	372
2911	Biology	PhD in Integrative Biology	372
2912	Computer Science	Master of Cybersecurity and Threat Intelligence	372
2913	Computer Science	PhD in Computational Science	372
2914	Criminology	MA in Criminology and Criminal Justice Policy	372
2915	Drama And Film	MA in Theatre Studies	372
2916	Drama And Film	PhD in Theatre Studies	372
2917	Economics	MA in Economics	372
2918	Economics	PhD in Economics	372
2919	English	MA in English	372
2920	Environmental Science	MES in Environmental Sciences	372
2921	Environmental Science	PhD in Environmental Sciences	372
2922	Food Science And Technology	Masters of Applied Nutrition	372
2923	Geography	MA in Geography	372
2924	Geography	PhD in Geography	372
2925	Geophysics	MSc in Geography	372
2926	Health	MSc in Couple and Family Therapy	372
2929	Marketing	MSc in Marketing and Consumer Studies	372
2930	Mathematics	MSc in Mathematics	372
2931	Mathematics	PhD in Applied Mathematics	372
2932	Medicine	MSc in Toxicology	372
2933	Medicine	PhD in Toxicology	372
2934	Philosophy	PhD in Philosophy	372
2935	Plant Science	PhD in Plant Agriculture	372
2936	Political Science	MA in Political Science	372
2937	Political Science	PhD in Political Science	372
2938	Psychology	MA in Applied Social Psychology	372
2939	Psychology	PhD in Applied Social Psychology	372
2940	Public Affairs	MSc in International Development Studies	372
2941	Public Health	Master of Public Health	372
2942	Public Health	PhD in Human Health and Nutritional Sciences	372
2943	Sociology	MA in Sociology	372
2944	Sociology	PhD in Sociology	372
2945	Statistics	MSc in Statistics	372
2946	Urban Planning	MSc in Rural Planning and Development	372
2947	CS	MS in Computer Science	373
2948	CS	PhD in Computer Science	373
2949	Finance	MS in Finance	373
2950	Geosciences	PhD in Geosciences	373
2951	MIS	PhD in Management Information System	373
2952	Business Statistics	PhD in Business Statistics	375
2953	CS	MS in Computer Science	375
2954	CS	PhD in Computer Science	375
2955	ECE	MS in Electrical and Computer Engineering	375
2956	IE	MS in Industrial Engineering 	375
2957	Math	PhD in Mathematics	375
2958	MIS	MS in Management Information Systems	375
2959	BIDS	PhD in Biomedical Informatics and Data Science	376
2960	Biomedical	MS in Biomedical Engineering	376
2961	BME	PhD in Biomedical Engineering	376
2962	CE	MS in Computer Engineering	376
2963	Computational & Data Science	PhD in Computational & Data Sciences	376
2964	CS	MS in Computer Science	376
2965	CS	PhD in Computer Science	376
2966	Data Analytics and Statistics	MS in Data Analytics and Statistics	376
2967	EE	MS in Electrical Engineering	376
2968	EE	PhD in Electrical Engineering	376
2969	Energy, Environmental & Chemical Engineering	MEng in Energy, Environmental and Chemical Engineering	376
2970	Geosciences	PhD in Earth and Planetary Sciences	376
2971	ImagingScience	PhD in Imaging Science	376
2972	Information Systems Management	Master of Information Systems Management	376
2973	Literature	PhD in Comparative Literature	376
2974	Materials	PhD in Materials Science and Engineering	376
2975	ME	MS in Mechanical Engineering	376
2976	MSBA	MS in Business Analytics	376
2977	MSBDS	MS in Biostatistics and Data Science	376
2978	MSF	MS in Finance	376
2979	Robotics	MEng in Robotics	376
2980	Statistics	MA in Statistics	376
2981	Statistics	PhD in Statistics	376
2982	Supply Chain Management	MS in Supply Chain Management	376
2983	Systems Science & Mathematics	MS in Systems Science and Mathematics	376
2984	Actuarial Science	MS in Actuarial Science	378
2985	ECE	PhD in Electrical and Computer Engineering	378
2986	IS	PhD in Information Sciences	378
2987	ISE	MS in Industrial and Systems Engineering	378
2988	Nursing	PhD in Nursing	378
2989	Statistics	PhD in Statistics	378
2990	Accounting	MAcc (Master of Accounting)	380
2991	Accounting	PhD in Accounting	380
2992	Aerospace	MS in Aerospace Engineering	380
2993	Aerospace	PhD in Aerospace Engineering	380
2994	Anthropology	PhD in Anthropology	380
2995	Architectural Engineering	MS in Architectural Engineering	380
2996	Architecture	MA in Architecture	380
2997	Architecture	PhD in Architecture	380
2998	Biostatistics	PhD in Biostatistics	380
2999	Chemical Engineering	MS in Chemical Engineering	380
3000	Chemical Engineering	PhD in Chemical and Petroleum Engineering	380
3001	Chemistry	MS in Chemistry	380
3002	Chemistry	PhD in Chemistry	380
3003	Communication	MA in Communication Studies	380
3004	Communication	PhD in Communication Studies	380
3005	Computer Engineering	MS in Computer Engineering	380
3006	Drama And Film	DMA in Wind Conducting	380
3007	Economics	MA in Economics	380
3008	Economics	PhD in Economics	380
3009	Education	MSE in Special Education: Low-Incidence Disabilities	380
3010	Education	PhD in Educational Administration	380
3011	Electrical Engineering	MS in Electrical Engineering	380
3012	Electrical Engineering	PhD in Electrical Engineering	380
3013	English	MA in English	380
3014	English	PhD in Creative Writing	380
3015	Environmental Science	MS in Environmental Science	380
3016	Environmental Science	PhD in Environmental Science	380
3017	Finance	PhD in Finance	380
3018	Fine Arts	MME in Music Therapy	380
3019	Fine Arts	DMA in Church Music	380
3020	Geology	PhD in Geology	380
3021	Geosciences	MS in Geology	380
3022	Geosciences	PhD in Geosciences	380
3023	History	MA in Museum Studies	380
3024	History	PhD in History	380
3025	Human Resource Management	PhD in Human Resources Management	380
3026	Information Systems	MS in Information Technology	380
3027	Language	MA in Spanish	380
3028	Language	PhD in Child Language	380
3029	Law	SJD (Doctor of Juridical Science)	380
3030	Literature	MA in Classics	380
3031	Management	MS in Engineering Management	380
3032	Marketing	PhD in Marketing	380
3033	Mathematics	MA in Mathematics	380
3034	Mathematics	PhD in Mathematics	380
3035	Mba	MBA	380
3036	Mechanical Engineering	MS in Mechanical Engineering	380
3037	Mechanical Engineering	PhD in Mechanical Engineering	380
3038	Medicine	MS in Pharmacology and Toxicology	380
3039	Medicine	PhD in Pharmacology and Toxicology	380
3040	Music And Dance	MM in Carillon	380
3041	Music And Dance	PhD in Music Therapy	380
3042	Pharmacy	PhD in Pharmaceutical Chemistry	380
3043	Philosophy	MA in Philosophy	380
3044	Philosophy	PhD in Philosophy	380
3045	Physics	MS in Physics	380
3046	Physics	PhD in Physics	380
3047	Political Science	MA in Political Science	380
3048	Political Science	PhD in Political Science	380
3049	Psychology	PhD in School Psychology	380
3050	Religion	MA in Religious Studies	380
3051	Social Work	MSW (Master of Social Work)	380
3052	Social Work	PhD in Social Work	380
3053	Strategy	PhD in Strategic Management	380
3054	Supply Chain And Logistics	PhD in Decision Sciences and Supply Chain Management	380
3055	Urban Planning	MUP(Master of Urban Planning)	380
3056	Water Resources Engineering	Master of Civil Engineering	380
3057	Agriculture	Master of Forestry	382
3058	Agriculture	PhD in Forest Resources	382
3059	Animal Science	MS in Animal Sciences	382
3060	Aquaculture	MS in Aquaculture and Aquatic Resources	382
3061	Aquaculture	PhD in Aquaculture and Aquatic Resources	382
3062	Area Studies	MA in French: North American French Studies	382
3063	Biology	MS in Microbiology	382
3064	Biology	PhD in Microbiology	382
3065	Biomedical Engineering	MS in Biomedical Engineering	382
3066	Biomedical Engineering	PhD in Biomedical Engineering	382
3067	Chemical Engineering	MS in Chemical Engineering	382
3068	Chemical Engineering	PhD in Chemical Engineering	382
3069	Chemistry	MS in Chemistry	382
3070	Chemistry	PhD in Chemistry	382
3071	Communication	MA in Interdisciplinary Studies: New Media	382
3072	Communication	PhD in Communication and Mass Communication	382
3073	Computer Engineering	MS in Computer Engineering	382
3074	Computer Engineering	PhD in Electrical and Computer Engineering	382
3075	Computer Science	MS in Computer Science	382
3076	Computer Science	PhD in Computer Science	382
3077	Economics	MA in Economics	382
3078	Education	MEd in Secondary Education	382
3079	Education	PhD in Education: STEM Education	382
3080	Electrical Engineering	MS in Electrical Engineering	382
3081	English	MA in English	382
3082	Environmental Science	MS in Plant, Soil and Environmental Studies	382
3083	Exercise And Sport Science	MS in Kinesiology and Physical Education	382
3084	Fine Arts	MM in Music Education	382
3085	Food Science And Technology	MS in Food Science and Human Nutrition	382
3086	Food Science And Technology	PhD in Food and Nutrition Sciences	382
3087	Forestry	MS in Forest Resources	382
3088	Geology	PhD in Earth and Climate Sciences	382
3089	Geosciences	PSM in Marine Sciences	382
3090	Geosciences	PhD in Oceanography	382
3091	Health	MEd in Kinesiology and Physical Education	382
3092	History	MA in History	382
3093	History	PhD in History	382
3094	Information Systems	MS in Information Systems	382
3095	Information Systems	PhD in Spatial Information Science and Engineering	382
3096	Language	MA in French	382
3097	Mathematics	MA in Mathematics	382
3098	Mba	MBA	382
3099	Mechanical Engineering	MS in Mechanical Engineering	382
3100	Mechanical Engineering	PhD in Mechanical Engineering	382
3101	Medicine	MS in Botany and Plant Pathology	382
3102	Music And Dance	MM in Music Performance	382
3103	Natural Conservation And Ecology	MWC (Master of Wildlife Conservation)	382
3104	Natural Conservation And Ecology	PhD in Wildlife Ecology	382
3105	Nursing	MS in Nursing	382
3106	Physics	Master of Physics and Astronomy: Chemical Physics	382
3107	Physics	PhD in Physics and Astronomy: Chemical Physics	382
3108	Plant Science	MS in Horticulture	382
3109	Psychology	MA in Psychological Sciences	382
3110	Psychology	PhD in Psychology	382
3111	Public Affairs	MA in Global Policy: Environmental Policy	382
3112	Public Affairs	PhD in Anthropology and Environmental Policy	382
3113	Public Management Administration	MPS in Biochemistry	382
3114	Social Work	MSW (Master of Social Work)	382
3115	Water Resources Engineering	MS in Civil Engineering	382
3116	Water Resources Engineering	PhD in Civil Engineering	382
3117	Biostatistics	PhD in Biostatistics	383
3118	Chemistry	PhD in Chemistry	383
3119	CS	MS in Computer Science	383
3120	CS	PhD in Computer Science	383
3121	ECE	MS in Electrical and Computer Engineering	383
3122	ECE	PhD in Electrical and Computer Engineering	383
3123	Learning, Media, & Technology	MEd in Learning, Media, & Technology	383
3124	Materials	MS in Materials Science and Engineering	383
3125	Math & Statistics	PhD in Math & Statistics	383
3126	ME	PhD in Mechanical Engineering	383
3127	Physics	PhD in Physics	383
3128	Accounting	Master of Accounting	387
3129	Business Analytics	MS in Business Analytics	387
3130	CS	MS in Computer Science	387
3131	ECE	MS in Electrical and Computer Engineering	387
3132	ECE	PhD in Electrical and Computer Engineering	387
3133	Math	PhD in Mathematics	387
3134	MSF	MS in Finance	387
3135	PR	MA in Public Relations	387
3136	Bioinformatics and Computational Biology	MS in Bioinformatics and Computational Biology	388
3137	Biostatistics	MS in Biostatistics	388
3138	BME	PhD in Biomedical Engineering	388
3139	Business Analytics	MS in Business Analytics	388
3140	Chemistry	PhD in Chemistry	388
3141	CivilEng	MS in Structure Engineering	388
3142	CS	MS in Computer Science	388
3143	CS	PhD in Computer Science	388
3144	DataScience	MS in Data Science	388
3145	EE	MS in Electrical and Computer Engineering	388
3146	EE	PhD in Electrical Engineering	388
3147	geography	PhD in Geography	388
3148	I/O Psych	PhD in Industrial/Organizational Behavior	388
3149	Industrial engineering	MS in Industrial and Systems Engineering	388
3150	information science	PhD in Information Scienece	388
3151	ISE	PhD in Industrial and Systems Engineering	388
3152	Mathematics	PhD in Mathematics	388
3153	MCS	MCS in Computer Science	388
3154	ME	MS in Mechanical Engineering	388
3155	ME	PhD in Mechanical Engineering	388
3156	MFM	Master of Financial Mathematics	388
3157	MHRIR	MS in Human Resources & Industrial Relations	388
3158	MSF	MS in Finance	388
3159	Nursing	PhD in Nursing	388
3160	PublicHealth	PhD in Public Health	388
3161	Robotics	MS in Robotics	388
3162	Statistics	MS in Statistics	388
3163	Statistics	PhD in Statistics	388
3164	Computer Science	MS in Engineering Science: Computer Science	390
3165	Computer Science	PhD Degree in Engineering Science (Computer Science)	390
3166	Drama And Film	MFA in English	390
3167	English	MA in English	390
3168	English	PhD in English	390
3169	Environmental Engineering	MS in Environmental Engineering	390
3170	Environmental Engineering	PhD in Environmental Engineering	390
3171	AMCS	PhD in Applied Mathematics & Statistics	397
3172	Applied maths and computational science	MS in Applied maths and computational science	397
3173	Behavioral and Decision Science	Master of Behavioral and Decision Sciences	397
3174	Biology	PhD in Biology	397
3175	Biostatistics	MS in Biostatistics	397
3176	BME	MS in Bioengineering	397
3177	CGGT	MSE in Computer Graphics and Game Tech	397
3178	Chemical and Biomolecular Engineering	MSE in Chemical and Biomolecular Engineering	397
3179	Chemistry	PhD in Chemistry	397
3180	Communication	PhD in Communication	397
3181	CS	MS in Computer and Information Science	397
3182	CS	PhD in Computer and Information Science	397
3183	Data Science	MS in Data Science	397
3184	DataScience	MSE in Data Science	397
3185	EE	MS in Electrical Engineering	397
3186	EE	PhD in Electrical and Systems Engineering	397
3187	embdedSystems	MS in Embedded Systems	397
3188	Finance	PhD in Finance	397
3189	intercultural communication	MS in Intercultural Communication	397
3190	ITD	PhD in Operations, Information and Decisions	397
3191	LST	MSEd in Learning Sciences & Technologies	397
3192	Materials	MSE in Materials Science and Engineering	397
3193	Materials	PhD in Materials Science and Engineering	397
3194	MCIT	Master of Computer and Information Technology	397
3195	ME	MSE in Mechanical Engineering and Applied Mechanics	397
3196	ME	PhD in Mechanical Engineering and Applied Mechanics	397
3197	MIPD	MS in Integrated Product Design	397
3198	MPA	Master of Public Administration	397
3199	MUSA	Master of Urban Spatial Analytics	397
3200	Physics	PhD in Physics	397
3201	Public Administration	Master of Public Administration	397
3202	Public Health	Master of Public Health	397
3203	R/W/L	Ph.D. in Reading/Writing/Literacy	397
3204	Robotics	MSE in Robotics	397
3205	Scientific Computing	MSE in Scientific Computing	397
3206	SE	MS in Engineering in Systems Engineering	397
3207	SMART	MSEd in Statistics, Measurement, Assessment, and Research Technology	397
3208	Social Policy	MS in Social Policy	397
3209	Social welfare	PhD in Social Welfare	397
3210	Social Work	MSW (Master of Social Work)	397
3211	System engineering	MS in Systems Engineering	397
3212	TESOL	M.S.Ed. in Teaching English to Speakers of Other Languages	397
3213	Accounting	MS in Accountancy	399
3214	Applied and Computational Mathematics and Statistics	PhD in Applied and Computational Mathematics and Statistics	399
3215	Business Analytics	MS in Business Analytics	399
3216	Chemical	PhD in Chemical Engineering	399
3217	Computer Science and Engineering	MS in Computer Science and Engineering	399
3218	CS	MS in Computer Science	399
3219	CS	PhD in Computer Science	399
3220	ECE	MS in Electrical Engineering	399
3221	ECE	PhD in Electrical Engineering	399
3222	Economics	PhD in Economics	399
3223	Accounting	Master of Accountancy	400
3224	Accounting	PhD in Accounting	400
3225	Aerospace	MS in Aerospace Engineering	400
3226	Aerospace	PhD in Aerospace Engineering	400
3227	Anthropology	MA in Anthropology	400
3228	Anthropology	PhD in Anthropology	400
3229	Architecture	MS in Architecture	400
3230	Area Studies	MA in Native American Studies	400
3231	Biology	MS in Microbiology	400
3232	Biology	PhD in Microbiology	400
3233	Biomedical Engineering	MS in Biomedical Engineering	400
3234	Chemical Engineering	MS in Chemical Engineering	400
3235	Chemical Engineering	PhD in Chemical Engineering	400
3236	Communication	MA in Communication	400
3237	Communication	PhD in Communication	400
3238	Computer Engineering	MS in Electrical and Computer Engineering	400
3239	Data Science	MA in Managerial Economics with Big Data Emphasis	400
3240	Drama And Film	MFA in Dance	400
3241	Economics	MA in Managerial Economics + Data Emphasis	400
3242	Economics	PhD in Economics	400
3243	Education	Master of Education	400
3244	Education	PhD in Education	400
3245	Electronic Engineering	PhD in Physics & Astronomy: Optics (Experimental)	400
3246	English	MPW (Master of Professional Writing)	400
3247	English	PhD in English	400
3248	Entrepreneurship	PhD in Entrepreneurship and Economic Development	400
3249	Environmental Science	Master of Environmental Science	400
3250	Environmental Science	PhD in Environmental Science	400
3251	Finance	PhD in Finance	400
3252	Fine Arts	Master of Music	400
3253	Fine Arts	PhD in Music	400
3254	Geophysics	MS in Geophysics	400
3255	Geophysics	PhD in Geophysics	400
3256	Geosciences	MS in Geology	400
3257	Geosciences	PhD in Geosciences	400
3258	History	MA in History of Science, Technology and Medicine	400
3259	History	PhD in History	400
3260	Industrial Engineering	MS in Industrial and Systems Engineering (Non-Thesis)	400
3261	Industrial Engineering	PhD in Industrial and Systems Engineering	400
3262	Information Systems	MS in Management of Information Technology	400
3263	Information Systems	PhD in Management Information Systems	400
3264	International Business	PhD in Management and International Business	400
3265	Language	MA in French	400
3266	Language	PhD in Spanish	400
3267	Law	JD (Juris Doctor)	400
3268	Law	LLM in Law in US Legal Studies (For Foregin Educated Lawyers)	400
3269	Management	MS in Natural Gas Engineering and Management	400
3270	Marketing	PhD in Marketing	400
3271	Mathematics	MS in Mathematics	400
3272	Mathematics	PhD in Mathematics	400
3273	Mba	Full time MBA	400
3274	Mechanical Engineering	MS in Mechanical Engineering	400
3275	Mechanical Engineering	PhD in Mechanical Engineering	400
3276	Mineral Engineering	PhD in Petroleum Engineering	400
3277	Music And Dance	Master of Music Education	400
3278	Philosophy	MA in Philosophy	400
3279	Philosophy	PhD in Philosophy	400
3280	Physics	Master of Physics & Astronomy: Engineering Physics/Science	400
3281	Physics	PhD in Physics & Astronomy: Solar Physics (theoretical)	400
3282	Political Science	MA in Political Science	400
3283	Political Science	PhD in Political Science	400
3284	Psychology	MS in Psychology	400
3285	Psychology	PhD in Psychology	400
3286	Social Work	MSW (Master of Social Work)	400
3287	Supply Chain And Logistics	PhD in Supply Chain Management	400
3288	Urban Planning	Master of Regional and City Planning	400
3289	CS	MS in Computer Science	401
3290	CS	PhD in Computer Science	401
3291	Economics	MRes in Economics, Finance and Management	403
3292	Economics	PhD in Economics, Finance and Management	403
3293	Accounting	MS in Accounting	409
3294	Biology	MS in Biological and Environmental Sciences	409
3295	Biology	PhD in Biological and Environmental Sciences	409
3296	Chemical Engineering	MS in Chemical Engineering	409
3297	Chemical Engineering	PhD in Chemical Engineering	409
3298	Chemistry	MS in Chemistry (Non-Thesis Option)	409
3299	Chemistry	PhD in Chemistry	409
3300	Computer Science	PhD in Computer Science	409
3301	Drama And Film	MM in Music Performance	409
3302	Education	MA in Education	409
3303	Education	PhD in Education	409
3304	Electrical Engineering	MS in Electrical Engineering	409
3305	Electrical Engineering	PhD in Electrical Engineering	409
3306	English	MA in English	409
3307	English	PhD in English	409
3308	Environmental Engineering	MS in Ocean Engineering	409
3309	Environmental Engineering	PhD in Ocean Engineering	409
3310	Environmental Science	MESM (Master of Environmental Science and Management)	409
3311	Environmental Science	PhD in Environmental and Natural Resource Economics	409
3312	Food Science And Technology	MS in Nutrition and Food Sciences	409
3313	Geosciences	Master of Oceanography (MO)	409
3314	Geosciences	PhD in Oceanography	409
3315	Health	MS in Kinesiology	409
3316	History	MA in History/MLIS	409
3317	Industrial Engineering	MS in Systems Engineering	409
3318	Industrial Engineering	PhD in Industrial and Systems Engineering	409
3319	Information Systems	MA in Library and Information Studies	409
3320	Law	Master of Marine Affairs/JD	409
3321	Mathematics	MS in Mathematics	409
3322	Mathematics	PhD in Mathematics	409
3323	Mba	MBA	409
3324	Mechanical Engineering	MS in Mechanical Engineering and Applied Mechanics	409
3325	Mechanical Engineering	PhD in Mechanical Engineering and Applied Mechanics	409
3326	Medicine	MS in Speech-Language Pathology	409
3327	Medicine	PhD in Clinical Psychology	409
3328	Nursing	MS in Nursing	409
3329	Nursing	Doctor of Nursing Practice	409
3330	Oceanography	MS in Oceanography	409
3331	Pharmacy	MS in Pharmaceutical Sciences	409
3332	Pharmacy	PhD in Pharmaceutical Sciences	409
3333	Physics	MS in Physics (Non-Thesis Option)	409
3334	Physics	PhD in Physics	409
3532	cs	MSc in Computer Science	432
3335	Public Management Administration	MPA (Master of Public Administration)	409
3336	Social Work	MS in Human Development and Family Studies	409
3337	Statistics	MS in Statistics	409
3338	Textile And Light Industry	MS in Textiles, Fashion Merchandising and Design	409
3339	CS	MS in Computer Science	410
3340	MS-Marketing Intelligence	MS in marketing intelligence	410
3341	MSDS	MS in Data Science	410
3342	MSIS	MS in Information Systems	410
3343	DSBA	Master in Data Science & Busienss Analytics	411
3344	Finance	Master in Finance	411
3345	Marketing	MSc in Marketing Management and Digital	411
3346	Mba	Global MBA: Hospitality Management	411
3347	MF	Master in Finance	411
3348	Strategy	Advanced Master in Strategy & Management of International Business	411
3349	Business	MS in Business	412
3350	Statistics	MSc in Statistics	412
3351	Economics	MSc in Economics and Business Administration: Management of Innovation and Business Development	413
3352	Entrepreneurship	MSc in Economics and Business Administration: Accounting, Strategy and Control	413
3353	Finance	MSc in Economics and Business Administration: Finance and Strategic Management	413
3354	Fine Arts	MSc in Social Sciences in Management of Creative Business Processes: Strategic Design and Entrepreneurship	413
3355	Language	MSc in Business, Language and Culture: Business and Development Studies	413
3356	Marketing	MSc in Economics and Business Administration: International Marketing and Management	413
3357	Philosophy	MSc in Business Administration and Philosophy	413
3358	Political Science	MSc in International Business and Politics	413
3359	Sociology	MSc in Social Sciences in Management of Creative Business Processes: Management of Creative Business Processes	413
3360	ASE	MS in Aerospace Science and Engineering	415
3361	Biostatistics	MSc in Biostatistics	415
3362	Biostatistics	PhD in Biostatistics	415
3363	CS	MSc in Computer Science	415
3364	CS	PhD in Computer Science	415
3365	DPE	MA in Developmental Psychology and Education	415
3366	ECE	MEng in Electrical and Computer Engineering	415
3367	ECE 	MASc in Electrical and Computer Engineering 	415
3368	EE	PhD in Electrical and Computer Engineering	415
3369	Financial Insurance	Masters of Financial Insurance	415
3370	Geography	PhD in Geography	415
3371	Industrial Engineering	PhD in Industrial Engineering	415
3372	Information	Master of Information	415
3373	Management Analytics	Master of Management Analytics	415
3374	Math	PhD in Mathematics	415
3375	Mathematical Finance	Master of Mathematical Finance	415
3376	Mechanical	MEng in Mechanical and Industrial Engineering	415
3377	MFRM	Master of Financial Risk Management	415
3378	MMPA	Master of Management & Professional Accounting	415
3379	MSAC	MS in Applied Computing	415
3380	Physics	MS in Physics	415
3381	Physics	PhD in Physics	415
3382	Statistics	MS in Statistics	415
3383	Statistics	PhD in Statistics	415
3384	UTIAS	PhD in Aerospace Engineering	415
3385	Accounting-COHORT	Master of Science in Accounting Cohort	416
3386	Accounting-Flex	Master of Science in Accounting - Flex	416
3387	BME	PhD in Biomedical Engineering	416
3388	CE	MS in Computer Engineering	416
3389	CS	MS in Computer Science	416
3390	CS	PhD in Computer Science	416
3391	EE	MS in Electrical Engineering	416
3392	EE	PhD in Electrical Engineering	416
3393	Finance	MS in Finance	416
3394	InfoTech&Magt	MS in Information Technology and Management	416
3395	MSIS	PhD in Management Science, Information Systems Concentration	416
3396	Construction Engineering	MS in Construction Engineering	417
3397	CS	MS in Computer Science	417
3398	CS	PhD in Computer Science	417
3399	EE	PhD in Electrical and Computer Engineering	417
3400	Geosciences	PhD in Geosciences	417
3401	information systems	MS in Information Systems	417
3402	MEAE	Master of Entertainment Arts and Engineering	417
3403	MSD	MS in Software Development	417
3404	Software Development	Master of Software Development	417
3405	BAS	PhD in Business Analytics and Statistics	418
3406	EE	PhD in Electrical Engineering	418
3407	CS	MS in Computer Science	419
3408	CS	PhD in Computer Science	419
3409	Aerospace	PhD in Aerospace Engineering	420
3410	BA	MS in Business Analytics	420
3411	Chemistry	PhD in Chemistry	420
3412	Civil Engineering	MS in Civil Engineering	420
3413	CS	MS in Computer Science	420
3414	CS	PhD in Computer Science	420
3415	Economics	MA in Economics	420
3416	EE	MS in Electrical and Computer Engineering	420
3417	EE	PhD in Electrical and Computer Engineering	420
3418	Environmental Engineering	MS in Environmental and Water Resources Engineering	420
3419	Geosciences	PhD in Geosciences	420
3420	IEOR	MS in Operations Research and Industrial Engineering	420
3421	Information	PhD in Information Science	420
3422	Information Studies	MS in Information Studies	420
3423	IROM	PhD in Information, Risk, and Operations Management	420
3424	Materials	PhD in Materials Science and Engineering	420
3425	Math	MA in Mathematics	420
3426	Math	PhD in Mathematics	420
3427	MCRS	MS in Movement and Cognitive Rehabilitation Science	420
3428	ME	MS in Mechanical Engineering	420
3429	ME	PhD in Mechanical Engineering	420
3430	MIS	MS in Information Technology Management	420
3431	Pharmaceutical	PhD in Pharmaceutical 	420
3432	Physics	PhD in Physics: Statistical & Thermal Physics	420
3433	Statistics	PhD in Statistics	420
3434	Transportation	PhD in Transportation	420
3435	Electrical Engineering	MS in Electrical Engineering	423
3436	Finance	MS in Finance	423
3437	Mineral Engineering	MS in Petroleum Engineering	423
3438	Physics	MS in Physics	423
3439	Accounting	MS in Accounting	425
3440	BME	PhD in Biomedical Engineering	425
3441	Business Analytics	MS in Business Analytics	425
3442	CE	MS in Computer Engineering	425
3443	CE	Phd in Computer Engineering	425
3444	Commerce	MS in Commerce	425
3445	CS	MS in Computer Science	425
3446	CS	PhD in Computer Science	425
3447	Data Science	MS in Data Science	425
3448	ECE	PhD in Electrical and Computer Engineering	425
3449	EE	MS in Electrical Engineering	425
3450	ME	MEng in Mechanical and Aerospace Engineering	425
3451	MPRSE	MEd in Psych: Research, Statistics, Evaluation	425
3452	Public Policy	Master of Public Policy	425
3453	Statistics	MS in Statistics	425
3454	Statistics	PhD in Statistics	425
3455	System and Information Engineering	PhD in Systems and Information Engineering	425
3456	System Engineering	MS in System Engineering	425
3457	Applied Mathematics	PhD in Applied Mathematics	426
3458	BIT	PhD in Business Information Technology	426
3459	CS	MS in Computer Science	426
3460	CS	PhD in Computer Science	426
3461	ECE	MS in Electrical and Computer Engineering	426
3462	ECE	PhD in Electrical and Computer Engineering	426
3463	GISciences	MS in GISciences	426
3464	I/O Psych	PhD in Industrial/Organizational Behavior	426
3465	Industrial and systems engineering	MS in Industrial and Systems Engineering	426
3466	Internet Software Development	MEng in Internet Software Development	426
3467	ME	MS in Mechanical Engineering	426
3468	Statistics	PhD in Statistics	426
3469	Transportation	PhD in Transportation Engineering	426
3470	Design	MFA in Design: Visual Communications	427
3471	Public Health	MS in Biostatistics	427
3472	Social Work	PhD in Social Work	427
3473	Accounting	Master of Professional Accounting	429
3474	Applied Math	MS in Applied Math	429
3475	Applied Math	PhD in Applied Math	429
3476	Bioengineering	MS in Bioengineering	429
3477	Bioengineering	PhD in Bioengineering	429
3478	Biomedical Informatics	PhD in Biomedical Informatics	429
3479	Biostatistics	MS in Biostatistics	429
3480	Biostatistics	PhD in Biostatistics	429
3481	BME	PhD in Biomedical Engineering	429
3482	Business Analytics	MS in Business Analytics	429
3483	CFRM	MS in Computational Finance & Risk Management	429
3484	Chemical	MS in Chemical Engineering	429
3485	Chemistry	PhD in Chemistry	429
3486	Civil Engineering	MS in Civil Engineering	429
3487	Computational Linguistics	MS in Computational Linguists	429
3488	CS	MS in Computer Science	429
3489	CS	PhD in Computer Sciences	429
3490	CSSE-Bothell	MS in Computer Science & Software Engineering	429
3491	DataScience	MS in DataScience	429
3492	Earth Science	PhD in Earth Science	429
3493	EE	MS in Electrical Engineering	429
3494	EE	PhD in Electrical Engineering	429
3495	HCDE	MS in Human Centered Design & Engineering	429
3496	HCDE	PhD in Human-Computer Design and Engineering	429
3497	Industrial and System Engineering	PhD in Industrial and System Engineering	429
3498	IS	PhD in Information Systems	429
3499	Materials	MS in Materials Science and Engineering	429
3500	Materials	PhD in Materials Science and Engineering	429
3501	MCCN	Master of Communication in Communities & Networks	429
3502	ME	MS in Mechanical Engineering	429
3503	ME	PhD in Mechanical Engineering	429
3504	MHCID	Master of Human-Computer Interaction and Design	429
3505	MPA	Master of Public Administration	429
3506	MSIE	Master of Science in Industrial Engineering	429
3507	MSIM	MS in Information Management	429
3508	MSIS	Master of Science in Information Systems	429
3509	MSTI	Master of Science in Technology Innovation	429
3510	Public Policy & Management	PhD in Public Policy & Management	429
3511	PublicHealth	PhD in Public Health	429
3512	Statistics	MS in Statistics	429
3513	Statistics	PhD in Statistics	429
3514	Supply Chain Management	Master of Supply Chain Management	429
3515	Biostat	MS in Biostatistics 	430
3516	Biostatistics	PhD in Statistics: Biostatistics	430
3517	Civil Engineering	MS in Civil Engineering	430
3518	CS	MMath in Computer Science	430
3519	CS	PhD in Computer Science	430
3520	ECE	MEng in Electrical and Computer Engineering	430
3521	ECE	PhD in Electrical and Computer Engineering	430
3522	Management Science	MS in Management Science	430
3523	Management Science	PhD in Management Science	430
3524	MDSAI	Meng in Data Science and Artificial Intelligence-Coop	430
3525	MDSAI	MS in Data Science and Artificial Intelligence	430
3526	SDE	MASc in System Design Engineering	430
3527	Statistics	MMath in Statistics	430
3528	Accounting	Master of Accounting  (Nine-month) (Tacoma)	431
3529	Computer Science	Master of Cybersecurity and Leadership (Tacoma)	431
3530	Computer Science and Systems	MS in Computer Science and Systems	431
3531	Urban Planning	MA in Community Planning (Tacoma)	431
3533	ECE	MS in Electrical & Computer Engineering	432
3534	Ivey-Business analytics	MS in Business analytics	432
3535	Statistics	MS in Statistics	432
3536	Computer Science & Software Engineering	MS in Computer Science and Software Engineering (Bothell)	433
3537	CS	MS in Computer Science	433
3538	Accounting	MBA: Professional Accounting Specialization	434
3539	Actuarial Science	Master of Actuarial Science	434
3540	Biology	MSc in Chemistry and Biochemistry	434
3541	Biology	PhD in Biological Sciences	434
3542	Biomedical Engineering	Master of Medical Biotechnology	434
3543	Chemistry	PhD in Chemistry and Biochemistry	434
3544	Civil Engineering	MEng in Civil Engineering	434
3545	Civil Engineering	PhD in Civil Engineering	434
3546	Communication	MA in Communication and Social Justice	434
3547	Computer Engineering	Master of Applied Computing	434
3548	Computer Science	MSc in Computer Science	434
3549	Computer Science	PhD in Computer Science	434
3550	Criminology	MA in Criminology	434
3551	Economics	Master of Applied Economics and Policy	434
3552	Education	MEng in Education and Educational Studies	434
3553	Electrical Engineering	MEng in Electrical Engineering	434
3554	English	MA in English: Literature and Language	434
3555	Environmental Engineering	MASc in Environmental Engineering: Hydraulics	434
3556	Environmental Engineering	PhD in Environmental Engineering: Hydraulics	434
3557	Environmental Science	MSc in Environmental Science	434
3558	Environmental Science	PhD in Environmental Science	434
3559	Fine Arts	MFA in Film and Media Arts	434
3560	Geosciences	MSc in Earth Sciences	434
3561	Health	PhD in Kinesiology	434
3562	History	MA in History	434
3563	Industrial Engineering	MEng in Industrial Engineering	434
3564	Industrial Engineering	PhD in Industrial and Manufacturing Systems Engineering	434
3565	Law	LLM (Master of Laws)	434
3566	Law	MSW/JD	434
3567	Literature	MA in English: Literature and Creative Writing	434
3568	Materials	MEng in Engineering Materials	434
3569	Materials	PhD in Engineering Materials	434
3570	Mathematics	MSc in Mathematics and Statistics	434
3571	Mathematics	PhD in Mathematics and Statistics	434
3572	Mba	JD/MBA	434
3573	Mba	MBA for Managers and Professionals	434
3574	Mechanical Engineering	MASc in Mechanical Engineering	434
3575	Mechanical Engineering	MEng in Mechanical Engineering (Automotive Option)	434
3576	Medicine	MA in Clinical Psychology	434
3577	Medicine	PhD in Clinical Psychology	434
3578	Nursing	Master of Nursing	434
3579	Nursing	PhD in Nursing	434
3580	Philosophy	MA in Philosophy	434
3581	Physics	PhD in Physics	434
3582	Political Science	MA in Political Science	434
3583	Psychology	MA in Applied Social Psychology	434
3584	Psychology	PhD in Applied Social Psychology	434
3585	Social Work	MA in Social Work (Regular Track)	434
3586	Social Work	PhD in Social Work	434
3587	Sociology	MA in Sociology	434
3588	Sociology	PhD in Sociology: Social Justice	434
3589	Statistics	PhD in Statistics	434
3590	Accounting	Master of Professional Accounting	435
3591	Basic Medicine	Master of Clinical Exercise Physiology	435
3592	Biology	Master of Biological Science	435
3593	Biomedical Engineering	Master of Biotechnology	435
3594	Communication	Master of Science Communication	435
3595	Data Science	Master of Data Science	435
3596	Design	Master of Urban Design	435
3597	Economics	Master of Economics	435
3598	Education	Master of Teaching: Secondary	435
3599	Environmental Science	Master of Environmental Science	435
3600	Finance	Master of Applied Finance	435
3601	Geology	Master of Geoscience	435
3602	Geosciences	Master of Petroleum Geoscience	435
3603	Health	Master of Exercise Science	435
3604	Human Resource Management	Master of Human Resources and Employment Relations	435
3605	Information Systems	Master of Information Technology	435
3606	Language	Master of Translation Studies	435
3607	Law	Master of International Commercial Law	435
3608	Marketing	Master of Marketing	435
3609	Mba	MBA	435
3610	Pharmacy	Master of Pharmacy	435
3611	Physics	Master of Physics	435
3612	Psychology	Master of Business Psychology	435
3613	Public Affairs	Master of International Development	435
3614	Public Health	Master of Public Health (Coursework)	435
3615	Public Policy Analysis	Master of Public Policy	435
3616	Social Work	Master of Social Work	435
3617	Social Work	Doctor of Social Work	435
3618	Urban Planning	Master of Urban and Regional Planning	435
3619	Chemical Engineering	MS in Petroleum Engineering	437
3620	Chemical Engineering	PhD in Petroleum Engineering	437
3621	Biomedical Data Science	MS in Biomedical Data Science	440
3622	Business Analytics	MS in Business Analytics	440
3623	Chemical	PhD in Chemical Engineering	440
3624	Chemistry	PhD in Chemistry	440
3625	Civil Engineering	MS in Civil and Environmental Engineering	440
3626	CS	Master of Computer Sciences	440
3627	CS	PhD in Computer Sciences	440
3628	CS-PMP	Professional Master’s Program in Computer Sciences	440
3629	Economics	Master of Economics	440
3630	EE	MS in Electrical Engineering-Research	440
3631	EE	PhD in Electrical Engineering	440
3734	Nursing	Doctor of Nursing	458
3632	EE-MLSP	MS in Electrical Engineering-Machine Learning and Signal Processing	440
3633	Environmental Engineering	MS in Environmental Engineering and Science	440
3634	Geosciences	PhD in Geosciences	440
3635	IBio	PhD in Integrative Biology	440
3636	Indusrial Engineering	MS in Industrial Engineering	440
3637	LIS	MA in Library and Information Studies	440
3638	Mass Communications	PhD in Mass Communication	440
3639	Materials	MS in Materials Science and Engineering	440
3640	Materials	PhD in Materials Science and Engineering	440
3641	Math	PhD in Mathematics	440
3642	ME	PhD in Engineering Mechanics	440
3643	Microbiology	PhD in Microbiology Doctoral Training Program	440
3644	MJMC	MA in Journalism and Mass Communication	440
3645	MSI	MS in Information	440
3646	PublicHealth	PhD in Public Health	440
3647	SLA	PhD in Second Language Acquisition	440
3648	Statistics	MS in Statistics	440
3649	Statistics	PhD in Statistics	440
3650	Transportation	PhD in Transportation Engineering	440
3651	Biostatistics	PhD in Biostatistics	442
3652	BME	PhD in Biomedical Engineering	442
3653	Civil Engineering	MS in Civil Engineering	442
3654	CS	MS in Computer Science	442
3655	CS	PhD in Computer Science	442
3656	Data Science	MS in Data Science	442
3657	Economics	PhD in Economics	442
3658	EE	MS in Electrical Engineering	442
3659	EE	PhD in Electronic Engineering	442
3660	GPED	Graduate Program in Economic Development	442
3661	marketing	Master of Marketing	442
3662	ME	MS in Mechanical Engineering	442
3663	SPED	MEd in Special Education	442
3664	Accounting	MS in Accounting	444
3665	Business Analytics	MS in Business Analytics	444
3666	International Leaders Program	MS in International Leaders Program	444
3667	WFU&VT joint BME program	MS in Biomedical Engineering	444
3668	Biomedical	MS in Biomedical Engineering	448
3669	EE	PhD in Electrical Engineering	448
3670	Electrical Engineering	MS in Electrical Engineering	448
3671	English	MA in English	448
3672	English	PhD in English	448
3673	Industrial Engineering	MS in Industrial Engineering	448
3674	Industrial Engineering	PhD in Industrial Engineering	448
3675	Medicine	PhD in Pharmacology and Toxicology	448
3676	Pharmacy	PhD in Pharmaceutics	448
3677	Applied Math	PhD in Applied Mathematics	455
3678	Applied Physics	PhD in Applied Physics	455
3679	Asset Management	MS in Asset Management	455
3680	BBS	PhD in Biological and Biomedical Sciences	455
3681	Biostat	MPH in Biostatistics	455
3682	Biostatistics	MS in Biostatistics	455
3683	Biostatistics	PhD in Biostatistics	455
3684	BME	MS in Biomedical Engineering	455
3685	CEAS	MA in Council on East Asian Studies	455
3686	Chemical	PhD in Chemical Engineering	455
3687	Chronic disease epidemiology	MS in Chronic Disease Epidemiology	455
3688	CS	MS in Computer Science	455
3689	CS	PhD in Computer Science	455
3690	EE	MS in Electrical Engineering	455
3691	EE	PhD in Electrical Engineering	455
3692	HealthPolicy/Management	MS in HealthPolicy & Management	455
3693	IDE	MA in International and Development Economics	455
3694	International & Development Economics	MA in International Development and Economics	455
3695	Linguistics	PhD in Linguistics	455
3696	MA	Master of Global Affairs	455
3697	MBA	MBA in Silver Scholars	455
3698	ME	PhD in Mechanical Engineering	455
3699	MPH	Master in Public Health	455
3700	MSSDS	MS in Statistics and Data science	455
3701	PublicHealth	PhD in Public Health	455
3702	Statistics	MA in Statistics	455
3703	Statistics	PhD in Statistics	455
3704	STS		455
3705	YSE	PhD in School of the Environment	455
3706	Accounting	Master of Professional Accounting	458
3707	Aerospace	MEng in Aerospace Engineering	458
3708	Architecture	Master of Architecture/Master of Landscape Architecture	458
3709	Biomedical Engineering	Master of Biotechnology: Biomedical	458
3710	Chemical Engineering	Master of Petroleum Engineering (MPE)	458
3711	Communication	MA in Interpreting, Translation and Transcultural Communication	458
3712	Computer Engineering	Master of Computing and Innovation	458
3713	Computer Science	Master of Computer Science	458
3714	Data Science	Master of Data Science	458
3715	Design	Master of Planning: Urban Design	458
3716	Drama And Film	Master of Music: Performance and Pedagogy	458
3717	Economics	Master of Agribusiness	458
3718	Education	Master of Teaching: Middle and Secondary	458
3719	Electrical Engineering	MEng in Electrical Engineering	458
3720	Entrepreneurship	Master of Innovation and Entrepreneurship	458
3721	Environmental Engineering	MEng in Mining Engineering	458
3722	Finance	Master of Finance	458
3723	Geology	MSc in Petroleum Geoscience	458
3724	Health	Master of Clinical Science	458
3725	Law	Master of Business Law	458
3726	Management	Master of Applied Project Management	458
3727	Marketing	Master of Accounting and Marketing	458
3728	Mathematics	Master of Mathematical Sciences	458
3729	Mba	MBA	458
3730	Mechanical Engineering	MEng in Mechanical Engineering	458
3731	Medicine	MPhil in Surgery	458
3732	Medicine	Doctor of Clinical Dentistry	458
3733	Nursing	Master of Nursing Science	458
3735	Psychology	Master of Psychology: Health	458
3736	Psychology	PhD/Master of Psychology (Health)	458
3737	Public Affairs	Master of International Trade and Development	458
3738	Public Health	Master of Public Health	458
3739	Public Management Administration	Master of Environmental Policy and Management	458
3740	Urban Planning	Master of Planning	458
3741	Veterinary Medicine	Doctor of Veterinary Medicine	458
3742	Water Resources Engineering	MEng in Civil and Structural Engineering	458
3743	Accounting	Master of Accounting	462
3744	Actuarial Science	Master of Actuarial Studies	462
3745	Architecture	Master of Architecture	462
3746	Chemical Engineering	BEng in Chemical Engineering/Master of Advanced Engineering in Renewable and Sustainable Energy Engineering	462
3747	Data Science	Master of Data Science	462
3748	Economics	Master of Applied Economics and Econometrics: Applied Economics and Econometrics	462
3749	Education	MEd in Inclusive and Special Education	462
3750	Electrical Engineering	BEng in Mechatronics Engineering/Master of Advanced Engineering in Electrical Engineering	462
3751	English	Master of Applied Linguistics	462
3752	Entrepreneurship	Master of Leadership in Organisational Learning	462
3753	Finance	Master of Advanced Finance	462
3754	Fine Arts	Master of Design (Research)	462
3755	Geology	MS in Earth Science	462
3756	Geosciences	MS in Atmospheric Science	462
3757	Human Resource Management	Master of Human Resource Management	462
3758	Information Systems	Master of Information Technology	462
3759	International Business	Master of Business: International Business	462
3760	Language	Master of Interpreting and Translation Studies: Translation	462
3761	Law	LLM: Dispute Resolution	462
3762	Management	Master of Project Management	462
3763	Marketing	Master of Marketing	462
3764	Materials	BEng in Materials Engineering/Master of Advanced Engineering in Renewable and Sustainable Energy Engineering	462
3765	Mathematics	Master of Mathematics	462
3766	Mba	MBA	462
3767	Mechanical Engineering	Master of Advanced Engineering: Mechanical Engineering	462
3768	Medicine	Master of Clinical Embryology	462
3769	Medicine	PhD in Clinical Neuropsychology	462
3770	Nursing	Master of Advanced Nursing: Australian Nursing Studies	462
3771	Pharmacy	Bachelor of Pharmacy (Honours)/Master of Pharmacy	462
3772	Physics	MS in Astrophysics	462
3773	Public Health	Master of Public Health	462
3774	Social Work	Master of Social Work	462
3775	Supply Chain And Logistics	Master of Business: Supply Chain Management	462
3776	CS	PhD in Computer Science	465
3777	EE	PhD in Electronic Engineering	465
3778	Info Sys	Master of Information Systems	465
3779	IT	Information  technology	465
3780	Juris Doctor	Juris Doctor	465
3781	Management-Finance	Master of Management-Finance	465
3782	MSF	Master of Finance	465
3783	Accounting	Master of Commerce: Professional Accounting(32 units)	467
3784	Architecture	Master of Architecture	467
3785	Chemical Engineering	Master of Engineering: Chemical Engineering(32 units)	467
3786	Data Science	Master of Data Science(32 units)	467
3787	Economics	Master of Development Economics (32 Units)	467
3788	Electrical Engineering	Master of Engineering Science: Electrical Engineering(24 units)	467
3789	Entrepreneurship	Master of Business: Leadership(24 units)	467
3790	Finance	Master of Commerce: Applied Finance(24 units)	467
3791	Human Resource Management	Master of Business: Human Resource Management(32 units)	467
3792	Information Systems	Master of Business: Information Systems(32 units)	467
3793	International Business	Master of Business: International Business(24 units)	467
3794	Language	Master of Arts in Japanese Interpreting and Translation	467
3795	Law	Master of Laws (24 Units)	467
3796	Management	Master of Engineering Science (Management)	467
3797	Marketing	Master of Business: Marketing(24 units)	467
3798	Mba	MBA in Business Administration	467
3799	Mechanical Engineering	Master of Engineering: Mechanical Engineering(48 units)	467
3800	Medicine	Doctor of Clinical Dentistry: Prosthodontics	467
3801	Nursing	Master of Nursing Studies	467
3802	Pharmacy	Master of Pharmaceutical Industry Practice	467
3803	Statistics	MS in Statistics(32 units)	467
3804	Supply Chain And Logistics	Master of Business: Supply Chain Management(24 units)	467
3805	Water Resources Engineering	Master of Engineering: Urban Water Engineering(32 units)	467
3806	Accounting	Master of Professional Accounting	468
3807	Architecture	Master of Architecture	468
3808	Biomedical Engineering	MEng in Engineering - Biomedical Engineering	468
3809	BME	PhD in Biomedical Engineering	468
3810	Chemical Engineering	MEng in Chemical and Biomolecular Engineering	468
3811	Civil Engineering	MEng in Structural Engineering	468
3812	Commerce	MS in Commerce	468
3813	Criminology	Master of Criminology	468
3814	CS	MS in Computer Science	468
3815	Data Science	Master of Data Science	468
3816	Design	Master of Design: Strategic Design	468
3817	Economics	Master of Economics	468
3818	Education	Master of Teaching: School Counselling	468
3819	Electrical Engineering	MEng in Electrical Engineering (Professional)	468
3820	English	MA in Crosscultural and Applied Linguistics	468
3821	Entrepreneurship	Master of Project Leadership	468
3822	Fine Arts	Master of Architectural Science (Sustainable Design)	468
3823	History	Master of Museum and Heritage Studies	468
3824	Human Resource Management	MA in Human Resource Management and Industrial Relations	468
3825	International Business	MA in International Business	468
3826	Language	Master of Speech Language Pathology	468
3827	Law	Master of Labour Law and Relations	468
3828	Law	PhD in Law	468
3829	Management	Master of Project Management	468
3830	Mathematics	Master of Mathematical Sciences	468
3831	Mba	MBA in Professional Accounting	468
3832	ME	PhD in Engineering	468
3833	Mechanical Engineering	MEng in Mechanical Engineering (Professional)	468
3834	Medicine	Master of Medical Imaging Science	468
3835	Medicine	Doctor of Clinical Dentistry (Special Needs Dentistry)	468
3836	Natural Conservation And Ecology	Master of Urbanism: Heritage Conservation	468
3837	Nursing	Master of Nursing	468
3838	Pharmacy	Master of Pharmacy	468
3839	Physics	Master of Medical Physics	468
3840	Public Health	Master of Health Policy	468
3841	Social Work	MPhil in Social Work	468
3842	Social Work	PhD in Social Work	468
3843	Urban Planning	Master of Urban and Regional Planning	468
3844	Veterinary Medicine	Doctor of Veterinary Medicine	468
3845	Agriculture	MSc in Agriculture	472
3846	Animal Science	MSc in Animal Science	472
3847	Anthropology	MSc in Anthropology	472
3848	Anthropology	PhD in Anthropology	472
3849	Architecture	MSc in Landscape Architecture	472
3850	Area Studies	MA in African Studies	472
3851	Biological Agricultural Engineering	MSc in Food Science and Technology	472
3852	Biology	MSc in Biochemistry	472
3853	Chemistry	MSc in Chemistry	472
3854	Communication	MA in Cognition and Communication	472
3855	Computer Science	MSc in Computer Science	472
3856	Economics	MSc in Economics	472
3857	Environmental Science	MSc in Environmental Science	472
3858	Food Science And Technology	MSc in Human Nutrition	472
3859	Geophysics	MSc in Geography and Geoinformatics	472
3860	Geosciences	MSc in Geology-Geoscience	472
3861	Information Systems	MSc in Information Science and Cultural Communication	472
3862	Law	PhD at the Faculty of Law	472
3863	Materials	MSc in Nanoscience	472
3864	Mathematics	MSc in Mathematics	472
3865	Pharmacy	MSc in Pharmaceutical Sciences	472
3866	Physics	MSc in Physics?	472
3867	Political Science	MSc in Political Science	472
3868	Psychology	PhD in Psychology	472
3869	Public Health	MSc in Global Health	472
3870	Religion	PhD at the Faculty Theology	472
3871	Sociology	PhD at the Faculty of Humanities	472
3872	Statistics	MSc in Statistics	472
3873	Actuarial Science	MSc in Actuarial and Financial Engineering	476
3874	Anthropology	MSc in Social and Cultural Anthropology	476
3875	Architecture	MSc in Architecture (Brussels)	476
3876	Area Studies	MA in European Studies: Transnational and Global Perspectives	476
3877	Biochemical	MSc in Biochemical Engineering	476
3878	Biology	MSc in Biology	476
3879	Chemical Engineering	MSc in Chemical Engineering	476
3880	Chemistry	MSc in Chemistry	476
3881	Civil Engineering	MSc in Civil Engineering Technology	476
3882	Computer Science	MSc in Engineering: Computer Science	476
3883	Criminology	MSc in Criminology	476
3884	Economics	MSc in Business Economics	476
3885	Education	MSc in Educational Studies	476
3886	EE	Master of Electrical Engineering	476
3887	English	MA in Western Literature	476
3888	Financial Engineering	MSc in Actuarial and Financial Engineering	476
3889	History	MA in History	476
3890	Information Systems	MSc in Information Management	476
3891	Language	MA in Linguistics and Literature: English	476
3892	Law	LLM	476
3893	Materials	MSc in Materials Engineering	476
3894	Mathematics	MSc in Mathematics	476
3895	Mba	MBA (Brussels)	476
3896	Mechanical Engineering	MSc in Mechanical Engineering	476
3897	Natural Conservation And Ecology	MSc in Conservation of Monuments and Sites	476
3898	Philosophy	Research Master of Philosophy	476
3899	Physics	MSc in Physics	476
3900	Political Science	MSc in International Politics	476
3901	Psychology	MSc in Psychology: Theory and Research	476
3902	Public Health	MSc in Bioinformatics	476
3903	Religion	MA in Theology and Religious Studies	476
3904	Sociology	MA in Cultural Studies	476
3905	Statistics	MSc in Statistics	476
3906	Supply Chain And Logistics	MSc in Engineering: Logistics and Traffic	476
3907	CS	MS in Computer Science	488
3908	DS	MS in Data Science	488
3909	Advanced Design Informatics MSc-21months	MSc in Advanced Design Informatics	492
3910	AI	MS in Artificial Intelligence	492
3911	BA	MS in Business Analytics	492
3912	Bioinfo	MSc in Bioinformatics	492
3913	Biomed	MScR Biomedical Sciences	492
3914	CS	MS in Computer Science	492
3915	CyberSecurity	MS in Cyber Security, Privacy and Trust	492
3916	Design	MA in Design for Change	492
3917	DM	Design and digital Media	492
3918	DS	MSc in Data Science	492
3919	EE	MS in Signal Processing and Communications	492
3920	Electronics	MSc in Electronics	492
3921	Engineering	MPhil in Engineering	492
3922	EPM	MS in Environmental Protection and Management	492
3923	FinMath	MSc in Financial Mathematics	492
3924	HPCDS	MS in High Performance Computing with Data Science	492
3925	Human Geography and Environmental Sciences	PhD in Human Geography and Environmental Sciences	492
3926	LLM	Corporate Law	492
3927	Speech and Language Processing	MS in Speech and Language Processing	492
3928	Statistics and Operational Research	MS in Statistics and Operational Research	492
3929	Accounting	MSc in Accounting and Financial Management	493
3930	Area Studies	MA in European Studies, Social Science Track	493
3931	Biology	MSc in Genomics and Systems Biology	493
3932	Chemistry	MSc in Chemistry	493
3933	Communication	MSc in Communication	493
3934	Computer Science	MSc in Computer Science	493
3935	Data Science	MSc in Applied Data Science	493
3936	Design	MFA in Child Culture Design	493
3937	Drama And Film	MFA in Crafts, Ceramic Art	493
3938	Economics	MSc in Economics	493
3939	Education	International Master in Educational Research	493
3940	Entrepreneurship	MSc in Business Creation and Entrepreneurship in Biomedicine	493
3941	Environmental Science	MSc in Environmental Sciences	493
3942	Finance	MSc in Finance	493
3943	Fine Arts	MSc in Game Design & Technology	493
3944	Geophysics	MSc in Geography	493
3945	Geosciences	MSc in Marine Science	493
3946	Language	MSc in Language Technology (One year or Two years)	493
3947	Management	MSc in Software Engineering and Management	493
3948	Marketing	MSc in Marketing and Consumption	493
3949	Mathematics	MSc in Mathematical Sciences	493
3950	Music And Dance	MFA in Music: Improvisation and World Music performance	493
3951	Natural Conservation And Ecology	MSc in Conservation	493
3952	Pharmacy	MSc in Organic and Medicinal Chemistry	493
3953	Philosophy	MSc in Logic	493
3954	Physics	MSc in Physics	493
3955	Political Science	MSc in Political Science	493
3956	Psychology	MSc in Psychological Science	493
3957	Public Affairs	MSc in International Business and Trade	493
3958	Public Health	MSc in Global Health	493
3959	Public Management Administration	MSc in International Administration and Global Governance	493
3960	Religion	MA in Theology, Systematic Theology	493
3961	Social Work	MSc in Social Work and Human Rights	493
3962	Sociology	MSc in Sociology	493
3963	Strategy	MSc in Strategic Human Resource Management and Labour Relations	493
3964	Supply Chain And Logistics	MSc in Logistics and Transport Management	493
3965	Textile And Light Industry	MFA in Crafts, Textile Art	493
3966	CS	MSc in Computer Science	497
3967	Statistics	PhD in Applied Mathematics and Statistics	497
3968	Agriculture	MSc in Food Sciences	500
3969	Atmospheric Science	Master in Atmospheric Sciences	500
3970	Atmospheric Science	PhD in Atmospheric Sciences	500
3971	Basic Medicine	MSc in Genetics and Molecular Biosciences	500
3972	Biological Engineering	PhD in Microbiology and Biotechnology	500
3973	Biology	MSc in Plant Biology	500
3974	Biology	PhD in Wildlife Biology	500
3975	Chemistry	PhD in Chemistry and Molecular Sciences	500
3976	Communication	PhD in Psychology, Learning and Communication	500
3977	Computer Science	MSc in Computer Science	500
3978	Computer Science	PhD in Computer Science	500
3979	Data Science	MSc in Data Science	500
3980	Economics	MSc in Agricultural, Environmental and Resource Economics	500
3981	Economics	PhD in Economics	500
3982	Education	PhD in School, Education, Society and Culture	500
3983	English	MA in English Studies	500
3984	Environmental Science	PhD in Interdisciplinary Environmental Sciences	500
3985	Food Science And Technology	MSc in Human Nutrition and Food-Related Behaviour	500
3986	Geography	MSc in Geography	500
3987	Geosciences	MSc in Geology and Geophysics?	500
3988	Geosciences	PhD in Geosciences	500
3989	Health	PhD in Clinical Research	500
3990	History	PhD in History and Cultural Heritage	500
3991	Information Systems	MSc in Life Science Informatics	500
3992	International Business	Master in International Business Law	500
3993	Language	MA in Russian Studies	500
3994	Language	PhD in Language Studies	500
3995	Materials	MSc in Materials Research	500
3996	Materials	PhD in Materials Research and Nanoscience	500
3997	Mathematics	Master in Mathematics and Statistics	500
3998	Mathematics	PhD in Mathematics and Statistics	500
3999	Medicine	PhD in Clinical Veterinary Medicine	500
4000	Natural Conservation And Ecology	MSc in Ecology and Evolutionary Biology	500
4001	Philosophy	PhD in Philosophy, Arts and Society	500
4002	Physics	MSc in Particle Physics and Astrophysical Sciences	500
4003	Physics	PhD in Particle Physics and Universe Sciences	500
4004	Plant Science	PhD in Plant Sciences	500
4005	Political Science	MSc in Global Politics and Communication	500
4006	Political Science	PhD in Political, Societal and Regional Change	500
4007	Religion	PhD in Theology and Religious Studies	500
4008	Sociology	Master of Social Science in Contemporary Societies	500
4009	Sociology	PhD in Social Sciences	500
4010	Urban Planning	Master in Urban Studies & Planning	500
4011	Aerospace	MASc in Aerospace Engineering	503
4012	Aerospace	PhD in Aerospace Engineering	503
4013	Architecture	Master of Architecture	503
4014	Biomedical Engineering	MEng in Biomedical Engineering	503
4015	Biomedical Engineering	PhD in Biomedical Engineering	503
4016	Business Analytics	MSc in Data Science and Analytics	503
4017	Chemical Engineering	MEng in Chemical Engineering	503
4018	Chemical Engineering	PhD in Chemical Engineering	503
4019	Communication	Master of Professional Communication	503
4020	Computer Engineering	MEng in Electrical and Computer Engineering	503
4021	Computer Engineering	PhD in Electrical and Computer Engineering	503
4022	Computer Science	MASc in Computer Networks	503
4023	Computer Science	PhD in Computer Science	503
4024	Criminology	MA in Criminology and Social Justice	503
4025	Drama And Film	MA in Film and Photography Preservation and Collections Management	503
4026	Economics	PhD in Economics	503
4027	English	MA in English-Literatures of Modernity	503
4028	Entrepreneurship	Master of Engineering Innovation and Entrepreneurship	503
4029	Environmental Science	MASc in Environmental Applied Science and Management	503
4030	Environmental Science	PhD in Environmental Applied Science and Management	503
4031	Industrial Engineering	MEng in Mechanical and Industrial Engineering	503
4032	Industrial Engineering	PhD in Mechanical and Industrial Engineering	503
4033	Literature	MA in Literatures of Modernity	503
4034	Mathematics	MSc in Mathematics	503
4035	Mathematics	PhD in Mathematics	503
4036	Medicine	MA in Clinical Psychology	503
4037	Medicine	PhD in Clinical Psychology	503
4038	Nursing	Master of Nursing	503
4039	Philosophy	MA in Philosophy	503
4040	Physics	MSc in Biomedical Physics	503
4041	Physics	PhD in Biomedical Physics	503
4042	Psychology	MA in Psychology	503
4043	Psychology	PhD in Psychological Science	503
4044	Public Affairs	MA in Public Policy and Administration	503
4045	Public Health	Master of Health Administration: Community Care	503
4046	Public Management Administration	PhD in Policy Studies	503
4047	Social Work	Master of Social Work	503
4048	Sociology	MA in Early Childhood Studies	503
4049	Sociology	PhD in Communication and Culture	503
4050	Water Resources Engineering	MEng in Civil Engineering	503
4051	Water Resources Engineering	PhD in Civil Engineering	503
4052	CS	MSc in Computer Science	504
4053	CS	PhD in Computer Science	504
4054	Digital Media	MS in Digital Media	504
4055	Economics	MA in Economics	504
4056	MSE	MASc in Mechatronic Systems	504
4057	MSF	Master of Science in Finance	504
4058	SIAT	School of Interactive Arts & Technology	504
4059	STAT	MSc in Statistics	504
4060	AI	MS in Computer Science in Applied Artificial Intelligence	508
4061	CS	Master of Computer Science	508
4062	ECE-Meng	Meng in Electrical Engineering	508
4063	Information Studies	Master of Information Studies	508
4064	Physics	MS in Physics	508
4065	Science Systems Science	Master of Science Systems Science	508
4066	Advanced Spatial Analysis	PhD in Advanced Spatial Analysis	509
4067	BME	MRes Medical Physics and Biomedical Engineering	509
4068	Civil, Environmental and Geomatic Engineering	MPhil/PhD in Civil, Environmental and Geomatic Engineering	509
4069	Computational Finance	MSc in Computational Finance	509
4070	CS	MSc in Computer Science	509
4071	CS	MPhil/PhD in Computer Science	509
4072	Data Science	MSc in Data Science	509
4073	DEM	MS in Digital Engineering Management	509
4074	DSML	MSc in Data Science and Machine Learning	509
4075	ECON	PhD in Economics	509
4076	EE	MS in Connected Electronic and Photonic Systems MRes	509
4077	EnvironmentalSystem	MSc in Environmental Systems Engineering	509
4078	FinMath	MSc in Financial Mathematics	509
4079	FRM	MS in Financial Risk Management	509
4080	HCI	MS in Human Computer Interaction	509
4081	IIF	MSc in Infrastructure Investment and Finance	509
4082	IMLS	MS in Integrated Machine Learning Systems	509
4083	Information Security	MSc in Information Security	509
4084	Management	MSc in Management	509
4085	ML	MSc in Machine Learning	509
4086	MRes Biosciences	MRes in Biosciences	509
4087	MSBA	MS in Business Analytics	509
4088	MSF	MSc in Finance	509
4089	Neuroimaging	MS in Advanced Neuroimaging	509
4090	SDIC	MSc in Scientific and Data Intensive Computing	509
4091	BA	MS in Business Analytics	510
4092	Finance	Mater in Finance	510
4093	MFE	MS in Financial Engineering	510
4094	Big Data Technology	MSc in Big Data Technology	514
4095	Business Analytics	MSc in Business Analytics	514
4096	CBE	PhD in Bioengineering (Scientific Computation Concentration)	514
4097	CS	PhD in Computer Science	514
4098	Data-driven modelling	MSc in Data-Driven Modeling	514
4099	ECE	MPhil in Electronic and Computer Engineering	514
4100	Economics	MS in Economics	514
4101	EE	MSc in Electronic Engineering	514
4102	Fintech	MS in Financial Technology	514
4103	IS	PhD in Information Systems	514
4104	MAFM	MSc in Financial Mathematics	514
4105	Math	PhD in Mathematics	514
4106	ME	MS in Mechanical Engineering	514
4107	ME	PhD in Mechanical Engineering 	514
4108	MSC-IT	MSc in Information Technology	514
4109	Physics	PhD in Physics	514
4110	Accounting	MSc in Accounting	517
4111	Biostat	MS in Epidemiology & Biostatistics	517
4112	Communication	PhD in Communication	517
4113	CS	MPhil in Computer Science and Engineering	517
4114	CS	MS in Computer Science	517
4115	EE	MSc in Electronic Engineering	517
4116	Finance	MS in Finance	517
4117	Information Engineering	MSc in Information Engineering	517
4118	Math	PhD in Mathematics	517
4119	MSDS	MS in Data Science	517
4120	Physics 	Mphil in Physics	517
4121	PublicHealth	PhD in Public Health	517
4122	Statistics	MPhil in Statistics (Research-based)	517
4123	Cartography	MS in Cartography	518
4124	Data Engineering and Analytics	Data Engineering and Analytics	518
4125	Informatics	MS in Informatics	518
4126	Business Analytics	MSc in Business Analytics	522
4127	CivilEngineering	PhD in Civil and Environmental Engineering	522
4128	CS	MS in Computer Science	522
4129	DS	Master of Data Science	522
4130	Education	Master of Education	522
4131	EE	MSc in Electrical and Electronic Engineering	522
4132	Finance	MS in Finance	522
4133	Marketing	MS in Marketing	522
4134	ME	PhD in Mechanical Engineering	522
4135	Medicine	PhD in Medicine	522
4136	Stat	MS of Statistics	522
4137	STS	PhD in Science, technology and Society	522
4138	Communication	MA in Strategic Communication	525
4139	Data Science	MSc in Cyber Security and Big Data	525
4140	Design	MA in Design Innovation	525
4141	Finance	MSc in Digital Finance	525
4142	Fine Arts	MSc in Design Innovation Management	525
4143	History	MA in Media History	525
4144	Marketing	MSc in Digital Marketing	525
4145	Accounting	MSc in Accounting	526
4146	Architecture	MSc in Architecture	526
4147	Biological Engineering	MSc in Chemical, Biochemical and Materials Engineering: Fibre and Polymer Engineering	526
4148	Biology	MSc in Advanced Energy Solutions: Industrial Energy Processes and Sustainability	526
4149	Biomedical Engineering	MSc in Chemical, Biochemical and Materials Engineering: Functional Materials	526
4150	Chemical Engineering	MSc in Chemical, Biochemical and Materials Engineering: Chemical and Process Engineering	526
4151	Chemical Engineering	PhD in Chemical Engineering	526
4152	Chemistry	MSc in Chemical, Biochemical and Materials Engineering: Chemistry	526
4153	Computer Engineering	MSc in Computer, Communication and Information Sciences: Communications Engineering	526
4154	Design	MA in Fashion, Clothing and Textile Design	526
4155	Design	PhD in Arts, Design and Architecture	526
4156	Drama And Film	MA in Film and Television: Film Editing	526
4157	Economics	MSc in Economics	526
4158	Economics	PhD in Business, Economics and Finance	526
4159	Electrical Engineering	MSc in Automation and Electrical Engineering	526
4160	Electrical Engineering	PhD in Electrical Engineering	526
4161	Entrepreneurship	MSc in Entrepreneurship and Innovation Management	526
4162	Environmental Engineering	MSc in Water and Environmental Engineering	526
4163	Finance	MSc in Finance	526
4164	Fine Arts	MA in Collaborative and Industrial Design	526
4165	Information Systems	MSc in Information and Service Management	526
4166	International Business	MSc in Management and International Business	526
4167	Management	MSc in Industrial Engineering and Management	526
4168	Marketing	MSc in Marketing	526
4169	Materials	MSc in Electronics and Nanotechnology	526
4170	Mechanical Engineering	MSc in Mechanical Engineering	526
4171	Operations	MSc in Mathematics and Operations Research	526
4172	Physics	MSc in Engineering Physics	526
4173	Urban Planning	MSc in Spatial Planning and Transportation Engineering	526
4174	Economics	MA in Economics	527
4175	EE	MS in Electrical and Computer Engineering	527
4176	Statistics	PhD in Statistics	527
4177	Accounting	Master of Accountancy (MAcc)	541
4178	Biology	MPhil in Department of Biology	541
4179	Biology	PhD in Department of Biology	541
4180	Chemistry	MPhil in Department of Chemistry	541
4181	Chemistry	PhD in Department of Chemistry	541
4182	Communication	MPhil in School of Communication	541
4183	Communication	PhD in Communication	541
4184	Computer Science	MPhil in Department of Computer Science	541
4185	Computer Science	PhD in Department of Computer Science	541
4186	Drama And Film	MA in Producing for Film, Television and New Media	541
4187	Economics	MSc in Applied Economics	541
4188	Economics	PhD in Department of Economics	541
4189	Education	MPhil in Department of Education Studies	541
4190	Education	PhD in Department of Sport & Physical Education	541
4191	Finance	MSc in Applied Accounting and Finance	541
4192	Fine Arts	MFA in Film, Television and Digital Media	541
4193	Geophysics	MPhil in Department of Geography	541
4194	Geophysics	PhD in Department of Geography	541
4195	History	MPhil in Department of History	541
4196	History	PhD in Department of History	541
4197	Human Resource Management	Master of Human Resources Management (MHRM)	541
4198	Industrial Engineering	PhD in Department of Finance and Decision Sciences	541
4199	Information Systems	MSc in Advanced Information Systems	541
4200	Language	MPhil in School of Chinese Medicine	541
4201	Language	PhD in School of Chinese Medicine	541
4202	Law	PhD in Department of Accountancy and Law	541
4203	Literature	MA in Literary and Comparative Studies	541
4204	Literature	PhD in Department of English Language and Literature	541
4205	Marketing	PhD in Department of Marketing	541
4206	Mathematics	MPhil in Department of Mathematics	541
4207	Mathematics	PhD in Department of Mathematics	541
4208	Music And Dance	MPhil in Department of Music	541
4209	Music And Dance	PhD in Department of Music	541
4210	Physics	MPhil in Department of Physics	541
4211	Physics	PhD in Department of Physics	541
4212	Public Affairs	Master of Public Administration (MPA)	541
4213	Public Affairs	PhD in Department of Government and International Studies	541
4214	Public Health	MSc in Personal Health Management (Chinese Medicine) (MHM)	541
4215	Religion	MPhil in Department of Religion and Philosophy	541
4216	Religion	PhD in Department of Religion and Philosophy	541
4217	Social Work	Master of Social Work (MSW)	541
4218	Social Work	PhD in Department of Social Work	541
4219	Sociology	MPhil in Department of Sociology	541
4220	Sociology	PhD in Department of Sociology	541
4221	Statistics	MSc in Operational Research & Business Statistics	541
4222	Biostatistics	MPH in Biostatistics	543
4223	ChE	PhD in Chemical engineering	543
4224	Civil Engineering	MS in Civil Engineering	543
4225	CS	MS in Computer Science and Engineering	543
4226	CS	PhD in Computer Science and Engineering	543
4227	Earth Science	PhD in Earth Sciences	543
4228	EE	MS in Electrical and Computer Engineering	543
4229	EE	PhD in Electrical and Computer Engineering	543
4230	ET	PhD in Educational Studies, Learning Technologies	543
4231	Industrial system engineering	MS in Industrial and Systems Engineering	543
4232	Materials	MS in Materials Science and Engineering	543
4233	ME	MS in Mechanical Engineering	543
4234	ME	PhD in Mechanical Engineering	543
4235	MHRM	MS in Human Resource Management	543
4236	Nutrition	PhD in Nutrition	543
4237	Psychology	PhD in Psychology	543
4238	Statistics	MS in Statistics	543
4239	Statistics	PhD in Statistics	543
4240	T&L	Ph.D. in Foreign, Second and Multilingual Language Education	543
4241	Accounting and Finance	MSc in Accounting and Finance	544
4242	Applicable Mathematics	MSc in Applicable Mathematics	544
4243	ASDS	MS in Applied Social Data Science	544
4244	Economics and Mathematical Economics	MSc in Econometrics and Mathematical Economics	544
4245	Finance	MSc in Finance	544
4246	FinMath	MSc in Financial Mathematics	544
4247	MFE	MS in Finance and Economics	544
4248	MISD	MS in Management of Information Systems and Digital Innovation	544
4249	Operation Research&Analytics	MSc Operations Research & Analytics	544
4250	Risk and Finance	MS in Risk and Finance	544
4251	Statistics	MSc in Statistics	544
4252	Mathematics	Master of Mathematics	546
4253	Mathematics	PhD in Mathematics	546
4254	Civil Engineering	MFA in Transportation Systems and Design	550
4255	Design	MS in Environmental Design	550
4256	Drama And Film	MFA in Film	550
4257	Fine Arts	MFA in Industrial Design	550
4258	CSM	MS in Computer Games Technology 	551
4259	SE	MSc in Software Engineering	551
4260	AI Music	PhD in Artificial Intelligence and Music	553
4261	Materials	PhD in Materials Science	553
4262	Geosciences	Master of Earth and Planetary Systems Science	559
4263	Geosciences	PhD in Earth and Planetary Systems Science	559
4264	Basic Medicine	Master of Anatomy & Physiology	560
4265	Biology	PhD in Anatomy & Physiology	560
4266	Biology	Master of Biological Sciences	563
4267	Biology	PhD in Biological Sciences	563
4268	Chemistry	Master of Chemistry	563
4269	Chemistry	PhD in Chemistry	563
4270	Language	Master of Modern Languages	563
4271	Language	PhD in Modern Languages	563
4272	TDA	MS in Topology Data Science	563
4273	Water Resources Engineering	Master of Civil Engineering	563
4274	Water Resources Engineering	PhD in Civil Engineering	563
4275	Chemistry	Master of Chemistry	565
4276	Chemistry	PhD in Chemistry	565
4277	Area Studies	Master of Spanish Language and Latin-American Studies	568
4278	Atmospheric Science	Master of Meteorology and Oceanography: Climate Dynamics	568
4279	Biological Engineering	Master of Biomedical Sciences	568
4280	Biology	Master of Molecular Biology	568
4281	Drama And Film	Master of Fine Art	568
4282	English	Master of Linguistics	568
4283	Fine Arts	Master of Design	568
4284	Geology	Master of Earth Science	568
4285	Geophysics	Master of Physical Geography	568
4286	Geosciences	Master of Meteorology and Oceanography: Physical Oceanography	568
4287	Language	Master of French	568
4288	Mathematics	Master of Mathematics	568
4289	Music And Dance	Master of Music Performance or Composition	568
4290	Public Affairs	MPA	568
4291	Public Health	Master of Global Health	568
4292	Public Management Administration	Master of Global Development Theory and Practice	568
4293	Chemistry	Master of Chemistry	570
4294	Chemistry	PhD in Chemistry	570
4295	Materials	MS of Materials Science	570
4296	Materials	PhD in Materials Science	570
4297	Architectural Engineering	MSc in Architectural Engineering: Environmental Design	573
4298	CS	MS in Computer Science	573
4299	Design	MSc in Modern Building Design	573
4300	Fine Arts	MSc in Engineering Design	573
4301	Anthropology	MSc in Social Anthropology	574
4302	Architecture	Master of Architecture	574
4303	Area Studies	MA in European Studies	574
4304	Biological Agricultural Engineering	Master of Food Technology and Nutrition	574
4305	Biological Engineering	Master of Biotechnology	574
4306	Biology	Master of Biology	574
4307	Chemistry	Master of Chemistry in Physical Chemistry	574
4308	Communication	MSc in Strategic Communication	574
4309	Criminology	MSc in Cultural Criminology	574
4310	Design	Master of Industrial Design	574
4311	Drama And Film	MA in Film and Media History	574
4312	Economics	MSc in International Economics with a focus on China	574
4313	Electronic Engineering	Master of Embedded Electronics Engineering	574
4314	English	MA in Language and Linguistics: Spanish	574
4315	Entrepreneurship	MSc in Entrepreneurship and Innovation	574
4316	Environmental Science	Master of Environmental Studies and Sustainability Science	574
4317	Finance	MSc in Finance	574
4318	Fine Art	Master of Fine Arts	574
4319	Geography	Master of Physical Geography & Ecosystems Science	574
4320	Geophysics	Master of Human Geography	574
4321	Geosciences	Master of Atmospheric Sciences & Biogeochemical Cycles	574
4322	History	Master of Archaeology - Theory and Practice	574
4323	Industrial Engineering	Master of Logistics and Supply Chain Management	574
4324	Information Systems	Master of Geographical Information Systems	574
4325	Language	MA in Language and Linguistics: English	574
4326	Law	LLM in International Human Rights Law	574
4327	Literature	MA in Literature - Culture - Media: Yiddish Literature	574
4328	Machine Learning, Systems and Control 	MS in Machine Learning, Systems and Control 	574
4329	Marketing	MSc in International Marketing & Brand Management	574
4330	Materials	Master of Production and Materials Engineering	574
4331	Mathematics	Master of Mathematics	574
4332	Media	PhD in Media	574
4333	Medicine	Master of Medical Science	574
4334	Music	Master of Music: Jazz Improvisation	574
4335	Music And Dance	Master of Music: Vocal Studies	574
4336	Natural Conservation And Ecology	MSc in Human Ecology: Culture, Power and Sustainability	574
4337	Photonics	MS in Photonics	574
4338	Physics	Master of Physics: Theoretical physics	574
4339	Plant Science	Master of Biology in Plant Science	574
4340	Psychology	MSc in Psychology	574
4341	Public Affairs	Master of International Development and Management	574
4342	Public Health	Master of Public Health	574
4343	Public Management Administration	MSc in Environmental Management and Policy	574
4344	Sociology	MSc in Social Studies of Gender	574
4345	Statistics	Master of Mathematical Statistics	574
4346	Supply Chain And Logistics	MSc in Service Management: Supply Chain Management	574
4347	Water Resources Engineering	Master of Water Resources Engineering	574
4348	Accounting	MSc in Accounting	576
4349	Area Studies	MA in European Studies	576
4350	Basic Medicine	PhD in Biomedical Sciences	576
4351	Biological Engineering	PhD in Biomedical Sciences	576
4352	Communication	MA in Communication	576
4353	Communication	PhD in Communication	576
4354	Computer Engineering	MSc in Electrical and Computer Engineering	576
4355	Computer Engineering	PhD in Electrical and Computer Engineering	576
4356	Computer Science	MSc in Computer Science	576
4357	Computer Science	PhD in Computer Science	576
4358	Data Science	MSc in Data Science	576
4359	Economics	Master of Social Sciences in Economics	576
4360	Economics	PhD in Economics	576
4361	Education	Master of Education in Curriculum and Instruction	576
4362	Education	PhD in Education	576
4363	English	MA in English Studies	576
4364	English	PhD in Linguistics: English	576
4365	Finance	MSc in Finance	576
4366	History	MA in History	576
4367	History	PhD in History	576
4368	International Business	Master of Law in International Business Law	576
4369	Language	MA in Translation Studies	576
4370	Language	PhD in Applied Linguistics: Portuguese	576
4371	Law	Master of Law in Macau Law and Practice	576
4372	Law	PhD in Law	576
4373	Literature	PhD in Literary Studies: English	576
4374	Mathematics	MSc in Mathematics	576
4375	Mathematics	PhD in Mathematics	576
4376	Mba	MBA	576
4377	Physics	PhD in Applied Physics and Materials Engineering?	576
4378	Political Science	PhD in Political Science	576
4379	Psychology	Master of Education in Educational Psychology	576
4380	Psychology	PhD in Psychology	576
4381	Public Affairs	Master of Public Administration	576
4382	Public Affairs	PhD in Public Administration	576
4383	Public Policy Analysis	MA in International Relations and Public Policy?	576
4384	Religion	PhD in Philosophy and Religious Studies	576
4385	Sociology	Master of Education in Early Childhood Education and Child Development	576
4386	Sociology	PhD in Sociology	576
4387	Water Resources Engineering	MSc in Civil Engineering	576
4388	Water Resources Engineering	PhD in Civil Engineering	576
4389	APE	MS in Analysis and Policy in Economics	578
4390	PPD	MS in Public Policy and Development	578
4391	Applied Math	MSc in Applied Mathematics	580
4392	BMD	MS in Biomechanical Design	580
4393	CE	MSc in Computer Engineering	580
4394	CS	MSc in Computer Science	580
4395	EE	MSc in Electrical Engineering	580
4396	Embedded Systems	MSc in Embedded Systems	580
4397	Geo-engineering	MS in Geo-engineering	580
4398	GIS	MSc in Geomatics	580
4399	Management-Technology	MS in Management of Technology	580
4400	ME	MS in Mechanical Engineering	580
4401	Physics	MS in Applied Physics	580
4402	Architecture	MSc in Architecture, Building and Planning	581
4403	Biomedical Engineering	MSc in Biomedical Engineering	581
4404	Chemical Engineering	MSc in Chemical Engineering	581
4405	Communication	MSc in Science Education and Communication	581
4406	Computer Engineering	MSc in Computer Science and Engineering	581
4407	Design	MSc in Industrial Design	581
4408	Electrical Engineering	MSc in Electrical Engineering	581
4409	Electronic Engineering	MSc in Embedded Systems	581
4410	Mathematics	MSc in Industrial and Applied Mathematics	581
4411	Mechanical Engineering	MSc in Mechanical Engineering	581
4412	Operations	MSc in Operations Management and Logistics	581
4413	Physics	MSc in Applied Physics	581
4414	Anthropology	Master of Social Anthropology	589
4415	Atmospheric Science	Master of Meteorology and Oceanography	589
4416	Basic Medicine	Master of Cell Biology, Physiology, and Neuroscience	589
4417	Biology	Master of Molecular Biology and Biochemistry	589
4418	Chemistry	Master of Environmental Chemistry and Nuclear Chemistry	589
4419	Communication	Master of Chemistry Education and Communication	589
4420	Computer Science	Master of Computational Science: Bioscience	589
4421	Data Science	MS in Data Science	589
4422	Economics	Master of Economics	589
4423	Education	Master of Special Needs Education	589
4424	Electrical Engineering	Master of Microelectronics and Sensor Technology	589
4425	English	Master of English Literature, American and British Studies	589
4426	Entrepreneurship	MS in Entrepreneurship	589
4427	Geophysics	Master of Geophysics and Geodynamics	589
4428	Geosciences	Master of Environmental Geoscience	589
4429	History	Master of Modern International and Transnational History	589
4430	Information Systems	Master of Informatics: Robotics and Intelligent Systems	589
4431	Language	MA in Chinese Culture and Society	589
4432	Law	LLM in Maritime Law	589
4433	Materials	Master of Materials, Nanophysics and Quantum Technology	589
4434	Mathematics	Master of Mathematics	589
4435	Mechanical Engineering	Master of Mechanics	589
4436	Medicine	Master of Toxicology and Environmental Science	589
4437	Music And Dance	Master of Nordic Music	589
4438	Natural Conservation And Ecology	Master of Ecology and Evolution	589
4439	Philosophy	Master of Philosophy	589
4440	Physics	Master of Astronomy	589
4441	Public Health	MPhil in International Community Health	589
4442	Religion	Master of Religion and Diversity: Conflict and Coexistence	589
4443	Sociology	Master of Gender Studies	589
4444	Statistics	Master of Stochastic Modelling, Statistics and Risk Analysis: Statistics	589
4445	Architecture	MA in Interior Architecture	591
4446	Biology	MA in Nature–Culture–Sustainability Studies	591
4447	Communication	MFA in Digital + Media	591
4448	Design	Master of Industrial Design	591
4449	Drama And Film	MFA in Furniture Design	591
4450	Education	MA in Teaching + Learning in Art + Design	591
4451	Fine Art	MFA in Painting	591
4452	Fine Arts	MAT in Teaching + Learning in Art + Design	591
4453	Business Analytics	MS in Business Analytics	595
4454	CS	MS in Computer Science	595
4455	MentalHealth	MEd in Counseling - Clinical Mental Health	595
4456	Architectural Engineering	MSc in Architectural Engineering Design	599
4457	Architecture	MArch in Architecture	599
4458	Design	MA in Urban Design	599
4459	English	MA in Composition	599
4460	Fine Arts	MA in Theatre and Performance Studies	599
4461	Language	MA in Screen Translation	599
4462	Music And Dance	MA in Music Management	599
4463	Urban Planning	MSc in Real Estate Planning and Development	599
4464	CS	MS in Computer Science	603
4465	DS	MS in Data Science	603
4466	EE	MS in Image and Video Communications and Signal Processing	603
4467	EEE	MS in Optical Communications and Signal Processing	603
4468	MGM(MKT)	MS in Management (Marketing)	603
4469	AdvancedComputerScience	MPhil in Advanced Computer Science	605
4470	CEE	PhD in Engineering	605
4471	Econ	MPhil in Economics	605
4472	Engineering	PhD in Engineering	605
4473	FinanceEconomics	MPhil in Finance and Economics	605
4474	Management	MPhil in Management	605
4475	Mathematical Statistics	MASt in Mathematical Statistics	605
4476	MLMI	MPhil in Machine Learning and Machine Intelligence	605
4477	MPhCB	MPhil in Computational Biology	605
4478	PHSc	MPhil in Population Health Sciences	605
4479	StrategyMarketingOperations	MPhil in Strategy, Marketing and Operations	605
4480	DS	MS in Data Science	609
4481	EE	MSc Sensors and Imaging Systems	609
4482	IAFM	MS in International Accounting & Financial Management	609
4483	IT	MS in Information  Technology	609
4484	PDE	MS in Product Design Engineering	609
4485	PGT	MA in Information Management and Preservation	609
4486	Physics	MS in Physics	609
4487	Accounting	MSc in Finance & Accounting	611
4488	ACSE	MSc in Applied Computational Science and Engineering	611
4489	AML	MSc in Applied Machine Learning	611
4490	Applied Math	PhD in Applied Mathematics and Mathematical Physics	611
4491	Bioimaging	MRes Bioimaging Sciences	611
4492	Bioinfo	MSc in Bioinformatics and Theoretical Systems Biology	611
4493	BME	MS in Human and biological robotics	611
4494	Business analytics	MSc in Business analytics	611
4495	CivilEng	MS in Advanced Materials for Sustainable Infrastructure	611
4496	CivilEng	PhD in Civil and Structural Engineering	611
4497	Computing	PhD in Computing	611
4498	Computing-AI+ML	MSc in Computing (Artificial Intelligence and Machine Learning)	611
4499	Computing-Fin+Management	MSc in Computing (Management and Finance)	611
4500	Computing-SE	MS in Computing (Software Engineering)	611
4501	Computing-Security	MSc in Computing(Security and Reliability)	611
4502	CS	MSc in Computing Science	611
4503	CS Advanced	Advanced Computing 	611
4504	CSP	MSc in Communications and Signal Processing	611
4505	EE	MS in Electronic Engineering	611
4506	ESB	MS in Economics & Strategy for Business	611
4507	Financial Technology	MSc in Financial Technology	611
4508	Health Data Analytics	MSc in Health Data Analytics and Machine Learning	611
4509	IWM	MS Investment and Wealth Management	611
4510	Mathematical Finance	MSc in Mathematical Finance	611
4511	ME	MSc in Advanced Mechanical Engineering	611
4512	Medical Robotics	MRes Medical Robotics and Image-Guided Intervention	611
4513	Mres Photonics	MRes Photonics	611
4514	Neurotechnology	MRes in Neurotechnology	611
4515	Physics	Msc in Physics	611
4516	PublicHealth	PhD in Public Health	611
4517	RMFE	MS in Risk Management & Financial Engineering	611
4518	Soft Electronic Materials	MS in Soft Electronic Materials	611
4519	Statistics	MSc in Statistics	611
4520	Transport	MSc in Transport Engineering	611
4521	ACS	MSc in Advanced Computer Science	612
4522	CS	MSc in Cloud Computing	612
4523	Earth Observation	PhD in Earth Observation Sense CDT	613
4524	Geography	PhD in Geography	613
4525	Spatial Differences in the Governance of Smart Mobility	PhD in Spatial Differences in the Governance of Smart Mobility	613
4526	Chemical Biology	DPhil in Chemical Biology	616
4527	Clinical Research	DPhil in Clinical Medicine	616
4528	CS	MSc in Computer Science	616
4529	CS	DPhil in Computer Science	616
4530	Economics	MPhil in Economics	616
4531	EE	DPhil in Engineering Science	616
4532	Energy System	MSc in Energy Systems	616
4533	EngScience	DPhil in Engineering Science	616
4534	Financial Economics	MSc in Financial Economics	616
4535	GHScE	MSc in Global Health Science and Epidemiology	616
4536	Materials	DPhil in Materials	616
4537	Math	MS in Mathematical Sciences	616
4538	Mathematical and Computational Finance	MSc in Mathematical and Computational Finance	616
4539	MS EBSIPE	MS in Evidence-Based Social Intervention and Policy Evaluation	616
4540	NA	MPhil in Economics	616
4541	Science (by Research) in Engineering Science	MSc by Research in Engineering Science	616
4542	SCMP	MSc in Mathematical Modelling and Scientific Computing	616
4543	Social Data Science	MSc in Social Data Science	616
4544	Statistics	MSc in Statistical Science	616
4545	BA	MS in Business Analytics	619
4546	CS	MSc in Computer Science 	619
4547	CS	PhD in Computer Science	619
4548	Economics	MS in Economics and International Economics	619
4549	MIS	MSc Management of Information Systems & Digital Innovation	619
4550	CS	MSc in Computer Science	620
4551	HCI	MSc Human-Centred Interactive Technologies	620
4552	Architecture	MArch/MFA in Architecture and Lighting Design	623
4553	Design	MFA in Industrial Design	623
4554	Design	MFA in Lighting Design	623
4555	design and technology	MS in Design and Urban Ecologies	623
4556	Drama And Film	MFA in Fine Arts	623
4557	Entrepreneurship	MS in Strategic Design and Management	623
4558	Fine Arts	MS in Design and Urban Ecologies	623
4559	Strategy	Global Executive MS in Strategic Design and Management	623
4560	Textile And Light Industry	MFA in Textiles	623
4561	Communication	Mphil in London College of Communication (LCC)	625
4562	Communication	PhD in London College of Communication (LCC)	625
4563	Computer Engineering	Mphil in Creative Computing Institute (CCI)	625
4564	Computer Engineering	PhD in Creative Computing Institute (CCI)	625
4565	Entrepreneurship	MA in Fashion Entrepreneurship and Innovation	625
4566	Fine Art	MA in Fine Art	625
4567	Marketing	MA in Strategic Fashion Marketing	625
4568	Mba	LCF MBA	625
4569	Psychology	MSc in Applied Psychology in Fashion	625
4570	Textile And Light Industry	MA in Textile Design	625
\.


--
-- Data for Name: admissions_university; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admissions_university (id, area, school_name, school_name_cn, short_name) FROM stdin;
1	美国	Claremont Graduate University	克莱蒙特研究生大学	CGU
2	美国	California State University, Channel Islands	加利福尼亚州立大学-海峡群岛	CSUCI
3	美国	University of Georgia, Athens	佐治亚大学	UGA
4	美国	Scripps College	斯克利普斯学院	SCRIPPS
5	英国	King's College London	伦敦国王学院	KCL
6	沙特	King Abdullah University of Science and Technology	阿卜杜拉国王科技大学	KAUST
7	沙特	King Saud University	沙特国王大学	KSU.SA
8	沙特	King Fahd University of Petroleum & Minerals	法赫德国王石油与矿产大学	KFUPM.SA
9	加拿大	Queen's University at Kingston	皇后大学	QUEENSU.CA
10	美国	Roosevelt University	罗斯福大学	ROOSEVELT
11	美国	University of Maryland, College Park	马里兰大学	UMD
12	美国	Columbia University	哥伦比亚大学	COLUMBIA
13	加拿大	University of British Columbia	不列颠哥伦比亚大学	UBC
14	美国	University of Missouri, Columbia	美国密苏里哥伦比亚大学	MISSOURI
15	美国	University of Maryland, Baltimore County	马里兰大学巴尔的摩县分校	UMBC
16	美国	University of Massachusetts, Boston	马萨诸塞大学波士顿分校	UMB
17	德国	Humboldt University of Berlin	柏林洪堡大学	HU-BERLIN.DE
18	美国	Georgia Institute of Technology	佐治亚理工学院	GATECH
19	美国	Massachusetts Institute of Technology	麻省理工学院	MIT
20	瑞士	Swiss Federal Institute of Technology Lausanne	洛桑联邦理工学院	EPFL
21	美国	Stevens Institute of Technology	史蒂文斯理工学院	STEVENS
22	美国	Worcester Polytechnic Institute	伍斯特理工学院	WPI
23	美国	California Institute Of Technology	加州理工学院	CALTECH
24	美国	Rensselaer Polytechnic Institute	伦斯勒理工大学	RPI
25	美国	Rochester Institute of Technology	罗切斯特理工大学	RIT
26	美国	Illinois Institute of Technology	伊利诺伊斯理工大学	IIT
27	美国	New Jersey Institute of Technology	新泽西理工学院	NJIT
28	瑞典	KTH Royal Institute of Technology	瑞典皇家理工学院	KTH.SE
29	美国	Pratt Institute - Brooklyn	普瑞特艺术学院	PRATT
30	瑞典	Karolinska Institute	卡罗琳斯卡医学院	KI.SE
31	美国	Florida Institute of Technology	佛罗里达科技大学	FIT
32	德国	KIT, Karlsruhe Institute of Technology	卡尔斯鲁厄理工学院	KIT
33	美国	New Mexico Institute of Mining and Technology	新墨西哥矿业及科技学院	NMT
34	美国	New York Institute of Technology	纽约理工大学	NYIT
35	印尼	Bandung Institute of Technology	万隆理工学院	ITB.ID
36	美国	Southern California Institute of Architecture	南加州建筑学院	SCIARC
37	日本	Tokyo Institute of Technology	东京工业大学	TITECH
38	美国	Troy University	特洛伊大学	TROY
39	美国	University of Hawaii, Manoa	夏威夷大学	HAWAII
40	美国	University of Connecticut	康涅狄格大学	UCONN
41	美国	Barnard College	巴纳德学院	BARNARD
42	美国	wellesley College	韦尔斯利学院	WELLESLEY
43	美国	Northwestern Polytechnic University	西北理工大学	NPU
44	美国	University of Rochester	罗切斯特大学	ROCHESTER
45	瑞典	Stockholm School of Economics	斯德哥尔摩经济学院	HHS.SE
46	美国	Rockefeller University	洛克菲勒大学	ROCKEFELLER
47	美国	Occidental College	西方学院	OXY
48	美国	University of Arkansas, Little Rock	阿肯色州	UALR
49	瑞典	Stockholm University	斯德哥尔摩大学	SU.SE
50	台湾	Soochow University	台湾东吴大学	SCU.TW
51	加拿大	Brock University	布鲁克大学	BROCKU.CA
52	英国	Architectural Association	建筑联盟学院	AASCHOOL.UK
53	意大利	Bocconi University	博科尼大学	UNIBOCCONI.IT
54	美国	Colorado College	科罗拉多学院	COLORADOCOLLEGE
55	美国	Brigham Young University	杨百翰大学	BYU
56	韩国	Sungkyunkwan University	成均馆大学	SKKU
57	台湾	National Chung Cheng University	台湾中正大学	CCU.TW
58	韩国	Kyung Hee University	庆熙大学	KHU.KR
59	台湾	Chung Yuan Christian University	台湾中原大学	CYCU.TW
60	台湾	National Cheng Kung University	台湾成功大学	NCKU.TW
61	台湾	National Chiao Tung University	台湾交通大学	NCTU.TW
62	美国	California State Polytechnic University, Pomona	波莫纳加州理工大学	CPP
63	美国	Syracuse University	雪城大学	SYRACUSE
64	加拿大	University of Saskatchewan	萨斯喀彻温大学	USASK.CA
65	黎巴嫩	American University of Beirut	贝鲁特美国大学	AUB.LB
66	埃及	American University in Cairo	开罗美国大学	AUCEGYPT
67	美国	Amherst College	阿默斯特学院	AMHERST
68	英国	University of St Andrews	圣安德鲁斯大学	ST-ANDREWS.UK
69	美国	Arizona State University	亚利桑那州立大学	ASU
70	美国	Arkansas State university	阿肯色州立大学	ASTATE
71	美国	Auburn University	奥本大学	AUBURN
72	俄国	Bauman Moscow State Technical University	鲍曼大学	BMSTU.RU
73	美国	Ball State University	鲍尔州立大学	BALLSTATE
74	美国	Bard College	巴德学院	BARD
75	美国	Bates College	贝茨学院	BATES
76	美国	Baylor University	贝勒大学	BAYLOR
77	美国	Bentley University	本特利大学	BENTLEY
78	美国	Boise State University	博伊西州立大学	BOISE
79	美国	Boston College	波士顿学院	BC
80	美国	Boston University	波士顿大学	BU
81	美国	Bowdoin College	鲍登学院	BOWDOIN
82	美国	Bowling Green State University	博林格林州立大学	BGSU
83	美国	Brandeis University	布兰迪斯大学	BRANDEIS
84	美国	Brown University	布朗大学	BROWN
85	美国	Bryn Mawr College	布林莫尔学院	BRYNMAWR
86	美国	Bucknell University	巴克内尔大学	BUCKNELL
87	美国	California Polytechnic State University	加州州立理工大学	CALPOLY
88	美国	California State University, Chico	加州州立大学奇科分校	CALUNIVERSITY
89	美国	California State University, Dominguez Hills	加州州立大学多明格斯山分校	CSUDH
90	美国	California State University, Fresno	加州州立大学弗雷斯诺分校	FRESNOSTATE
91	美国	California State University, Fullerton	加州州立大学富尔顿分校	FULLERTON
92	美国	California State University, Long Beach	加州州立大学长滩分校	CSULB
93	美国	California State University, Los Angeles	加利福尼亚州立大学洛杉矶分校	CALSTATELA
94	美国	California State University, Northridge	加州州立大学北岭分校	CSUN
95	美国	California State University, Sacramento	加利福尼亚州立大学-萨克拉门托	CSUS
96	美国	California State University, San Bernardino	加州州立大学圣伯纳迪诺分校	CSUSB
97	美国	California State University, San Marcos	加州州立大学圣马科斯分校	CSUSM
98	美国	Carleton College	卡尔顿学院	CARLETON
99	美国	Carnegie Mellon University	卡内基·梅隆大学	CMU
100	意大利	Politecnico di Milano	米兰理工大学	POLIMI.IT
101	意大利	Politecnico di Torino	都灵理工大学	TORINO
102	美国	McNeese State University	麦克尼斯州立大学	MCNEESE
103	美国	City College of New York	纽约城市大学城市学院	CCNY.CUNY
104	美国	Case Western Reserve University	凯斯西储大学	CASE
105	美国	University of Central Florida	中佛罗里达大学	UCF
106	法国	Ecole Centrale Paris	法国中央理工学院	CENTRALESUPELEC.FR
107	美国	Central Michigan University	中央密歇根大学	CMICH
108	台湾	National Central University	台湾中央大学	NCU.TW
109	美国	Claremont McKenna College	克莱蒙特·麦肯纳学院	CMC
110	美国	Centre College	森特学院	CENTRE
111	美国	University of California, Santa Cruz	加利福尼亚大学圣克鲁兹分校	UCSC
112	香港	City University of Hong Kong	香港城市大学	CITYU
113	美国	City University of New York	纽约市立大学	CUNY
114	美国	City University Of New York, Queens College	美国纽约城市大学女王学院	QC.CUNY
115	美国	City University Of New York, Staten Island	纽约市立大学史泰登岛学院	CSI.CUNY
116	美国	City University Of New York, Lehman College	纽约城市大学	LEHMAN.CUNY
117	美国	Clarkson University	克拉克森大学	CLARKSON
118	美国	Clark University	克拉克大学	CLARKU
119	美国	Clemson University	克莱姆森大学	CLEMSON
120	美国	Colby College	科尔比学院	COLBY
121	美国	Colgate College	科尔盖特大学	COLGATE
122	美国	College of the Holy Cross	圣十字学院	HOLYCROSS
123	美国	University of Wisconsin, Milwaukee	威斯康星大学密尔沃基分校	UWM
124	台湾	National Chengchi University	台湾政治大学	NCCU.TW
125	美国	Colorado School of Mines	科罗拉多矿业学院	MINES
126	美国	Colorado State University	科罗拉多州立大学	COLORADOSTATE
127	加拿大	Concordia University	康考迪亚大学	CONCORDIA
128	美国	Connecticut College	康涅狄格学院	CONNCOLL
129	加拿大	University of Victoria	维多利亚大学	UVIC.CA
130	挪威	Oslo School of Architecture and Design	奥斯陆建筑与设计学院	AHO.NO
131	南非	University of Cape Town	开普敦大学	UCT.ZA
132	丹麦	Aarhus School of Architecture	奥胡斯建筑学院	AARCH.DK
133	新西兰	Victoria University of Wellington	惠灵顿维多利亚大学	VICTORIA.NZ
134	美国	Cooper Union	库伯高等科学艺术联盟学院	COOPER
135	美国	Cornell University	康奈尔大学	CORNELL
136	美国	San Diego State University	圣地亚哥州立大学	SDSU
137	美国	Dakota State University	达科他州立大学	DSU
138	美国	North Dakota State University	北达科他州立大学	NDSU
139	美国	Dartmouth College	达特茅斯学院	DARTMOUTH
140	美国	Davidson College	戴维森学院	DAVIDSON
141	美国	DePaul University	德保罗大学	DEPAUL
142	美国	Dickinson College	狄金森学院	DICKINSON
143	美国	Drexel University	德雷塞尔大学	DREXEL
144	美国	Duke University	杜克大学	DUKE
145	美国	Earlham College	厄勒姆学院	EARLHAM
146	美国	Northeastern Illinois University	东北伊利诺伊大学	NEIU
147	美国	Eastern Michigan University	东密歇根大学	EMICH
148	韩国	Seoul National University	首尔国立大学	SNU
149	美国	University of Missouri, Kansas City	Search Results\nWeb results\n\n密苏里大学堪萨斯分校	UMKC
150	美国	East Tennessee State University	东田纳西州立大学	ETSU
151	美国	Georgetown University	乔治敦大学	GEORGETOWN
152	西班牙	barcelona graduate school of economics	巴塞罗那经济学研究生院	BARCELONAGSE.ES
153	西班牙	University of Barcelona	巴塞罗那大学	UB.ES
154	西班牙	Universitat Autonoma de Barcelona	巴塞罗那自治大学	UAB.ES
155	美国	Emerson College	爱默生学院	EMERSON
156	美国	Emory University	埃默里大学	EMORY
157	美国	Florida Atlantic University	佛罗里达大西洋大学	FAU
158	美国	Florida International University	佛罗里达国际大学	FIU
159	美国	Florida State University	佛罗里达州立大学	FSU
160	美国	Fordham University	福特汉姆大学	FORDHAM
161	美国	Franklin & Marshall College	富兰克林马歇尔学院	FANDM
162	美国	Gannon University	加努恩大学	GANNON
163	瑞士	University of Geneva	日内瓦大学	UNIGE.CH
164	瑞士	Graduate Institute Geneva	日内瓦高级国际关系及发展学院	GRADUATEINSTITUTE.CH
165	美国	George Mason University	乔治梅森大学	GEORGEMASON
166	美国	George Washington University	乔治·华盛顿大学	GWU
167	美国	Georgia State University	佐治亚州立大学	GEORGIASTATE
168	美国	Gettysburg College	葛底斯堡学院	GETTYSBURG
169	美国	Grinnell College	格林内尔学院	GRINNELL
170	美国	Hamilton College	汉密尔顿学院	HAMILTON
171	美国	University of Texas health center at houston	德州大学休斯顿健康中心	UTHSC-H
172	美国	University of New Hampshire	新罕布什尔大学	UNH
173	美国	Harding University	哈町大学	HARDING
174	美国	Harvard University	哈佛大学	HARVARD
175	美国	Harvey Mudd College	哈维·穆德学院	HMC
176	美国	Haverford College	哈弗福德学院	HAVERFORD
177	德国	Heidelberg University	海德堡大学	UNI-HEIDELBERG.DE
178	美国	Hofstra University	霍夫斯特拉大学	HOFSTRA
179	美国	Howard University	霍华德大学	HOWARD
180	美国	Washington State University, Tri-Cities	华盛顿州立大学-三城分校	TRICITIES.WSU
181	美国	School of Visual Arts	纽约视觉艺术学院	SVA
182	美国	Indiana State University	印第安纳州立大学	INDSTATE
183	美国	Indiana University, Bloomington	印第安纳大学伯明顿分校	IUB
184	美国	Indiana Univ - Purdue Univ Indianapolis	印第安纳大学与普渡大学印第安纳波里斯联合分校	IUPUI
185	新加坡	National University of Singapore	新加坡国立大学	NUS
186	澳大利亚	Australian National University	澳大利亚国立大学	ANU
187	台湾	National Yang Ming University	台湾阳明大学	YM.TW
188	台湾	National Taiwan University	台湾大学	NTU.TW
189	台湾	National Changhua University of Education	台湾彰化师范大学	NCUE.TW
190	台湾	National Chiayi University	台湾嘉义大学	NCYU.TW
191	台湾	National Tsing Hua University	台湾清华大学	NTHU.TW
192	台湾	National Taiwan Normal University	台湾师范大学	NTNU.TW
193	台湾	National Taipei University	台北大学	NTPU.TW
194	台湾	National Taiwan University of Arts	台湾艺术大学	NTUA.TW
195	台湾	National Sun Yat-sen University	台湾中山大学	NSYSU.TW
196	台湾	National Taiwan University of Science and Technology	台湾科技大学	NTUST.TW
197	爱尔兰	National University of Ireland Galway	高威大学	NUIGALWAY.IE
198	美国	Iowa State University	爱荷华州立大学	IOWASTATE
199	美国	San Jose State University	圣何塞州立大学	SJSU
200	台湾	Fu Jen Catholic University	台湾辅仁大学	FJU.TW
201	美国	Johns Hopkins University	约翰斯·霍普金斯大学	JHU
202	美国	Kent State University	肯特州立大学	KENT
203	美国	Kenyon College	凯尼恩学院	KENYON
204	美国	Kettering University, Flint	凯特林大学	KETTERING
205	美国	Lafayette College	拉法耶特学院	LAFAYETTE
206	美国	Lamar University	拉玛尔大学	LAMAR
207	美国	Lehigh University	理海大学	LEHIGH
208	美国	University of Nebraska, Lincoln	内布拉斯加林肯大学	UNL
209	美国	Louisiana State University and A&M College	路易斯安那州立大学	LSU
210	美国	Louisiana Tech University	路易斯安那理工大学	LATECH
211	美国	Loyola University Chicago	芝加哥洛约拉大学	LUC
212	法国	Ecole Normale Superieure de Lyon	里昂高等师范学院	ENS-LYON.FR
213	美国	Macalester College	玛卡莱斯特学院	MACALESTER
214	美国	Marquette University	马凯特大学	MARQUETTE
215	美国	Marshall University	贝瑟尼学院	MARSHALL
216	加拿大	McMaster University	麦克马斯特大学	MCMASTER
217	加拿大	McGill University	麦吉尔大学	MCGILL
218	美国	Miami University	迈阿密大学-牛津	MIAMIOH
219	美国	Michigan State University	密歇根州立大学	MSU
220	美国	Michigan Technological University	密歇根理工大学	MTU
221	英国	University of Machester	曼彻斯特大学	MANCHESTER
222	美国	Middlebury College	明德学院	MIDDLEBURY
223	美国	Middle Tennessee State University	中田纳西州立大学	MTSU
224	美国	Mississippi State University	密西西比州立大学	MSSTATE
225	美国	Missouri University of Science and Technology	密苏里科技大学	MST
226	美国	Monmouth University	蒙莫斯大学	MONMOUTH
227	美国	University of Montana	蒙大拿大学	UMT
228	美国	Montclair State University	蒙特克莱尔州立大学	MONTCLAIR
229	美国	West Virginia University, Morgantown	西弗吉尼亚大学	WVU
230	美国	Mount Holyoke College	蒙特霍利约克学院	MTHOLYOKE
231	荷兰	University of Amsterdam	阿姆斯特丹大学	UVA.NL
232	荷兰	Vrije University Amsterdam	阿姆斯特丹自由大学	VU.NL
233	荷兰	University of Groningen	格罗宁根大学	RUG.NL
234	美国	University of Nevada, Las Vegas	拉斯维加斯大学	UNLV
235	荷兰	Radboud University Nijmegen	奈梅亨大学	RU.NL
236	荷兰	Erasmus University Rotterdam	伊拉斯姆斯大学	EUR.NL
237	荷兰	University of Twente	特文特大学	UTWENTE.NL
238	荷兰	Utrecht University	乌得勒支大学	UU.NL
239	荷兰	Tinbergen Institute	廷贝亨研究所	TINBERGEN.NL
240	荷兰	Leiden University	莱顿大学	UNIVERSITEITLEIDEN.NL
241	荷兰	Maastricht University	马斯特里赫特大学	MAASTRICHTUNIVERSITY.NL
242	新加坡	Nanyang Technology University	南洋理工大学	NTU
243	美国	University of Kentucky	肯塔基大学	UKY
244	挪威	Norwegian University of Science And Technology	挪威科技大学	NTNU.NO
245	美国	University of Nevada, Reno	内华达大学	UNR
246	美国	New Mexico State University	新墨西哥州立大学	NMSU
247	美国	New York University Tandon School of Engineering	纽约大学工学院	NYU.TANDON
248	美国	New York University	纽约大学	NYU
249	俄国	Novosibirsk State University	新西伯利亚国立大学	NSU.RU
250	美国	University of Illinois, Urbana-Champaign	伊利诺伊大学厄巴纳-香槟分校	UIUC
251	美国	North Carolina State University	北卡罗莱纳州立大学	NCSU
252	美国	University of North Carolina, Chapel Hill	北卡罗来纳大学教堂山分校	UNC
253	美国	University of Arizona	亚利桑那大学	ARIZONA
254	美国	University of South Carolina	南卡罗莱纳大学	SOUTHCAROLINA
255	美国	University of Cincinnati	辛辛那提大学	CINCINNATI
256	新加坡	Singapore Management University	新加坡管理学院	SMU.SG
257	美国	University of North Carolina, Charlotte	北卡罗来纳大学夏洛特分校	UNCC
258	美国	University of North Carolina, Greensboro	北卡罗来纳大学格林斯伯勒分校	UNCG
259	西班牙	Center for Monetary and Financial Studies	西班牙货币与金融研究中心	CEMFI
260	美国	Northeastern University	东北大学	NEU
261	美国	Northwestern University	西北大学	NORTHWESTERN
262	美国	Villanova University	维拉诺瓦大学	VILLANOVA
263	美国	Oakland University	奥克兰大学	OAKLAND
264	美国	Oberlin College	欧柏林学院	OBERLIN
265	美国	Ohio University	俄亥俄大学	OHIO
266	美国	Oklahoma State University	俄克拉何马州立大学	OKSTATE
267	美国	Old Dominion University	欧道明大学	ODU
268	美国	Tennessee Technological University	田纳西科技大学	TNTECH
269	马来西亚	Universiti Teknologi Malaysia	马来西亚理工大学	UTM.MY
270	美国	Oregon Health and Science University	俄勒冈健康与科学大学	OHSU
271	美国	Oregon State University	俄勒冈州立大学	OREGONSTATE
272	美国	Pace University	佩斯大学	PACE
273	西班牙	University Complutense Madrid	马德里康普斯顿大学	UCM.ES
274	美国	Pennsylvania State University	宾夕法尼亚州立大学	PENNSTATE
275	美国	Pepperdine University	佩珀代因大学	PEPPERDINE
276	美国	Pitzer College	匹泽学院	PITZER
277	香港	Hong Kong Polytechnic University	香港理工大学	POLYU
278	法国	Ecole Polytechnique	巴黎高等理工学院	POLYTECHNIQUE
279	西班牙	Polytechnic University of Catalonia	加泰罗尼亚理工大学	UPC
280	美国	Pomona College	波莫纳学院	POMONA
281	美国	Portland State University	波特兰州立大学	PDX
282	美国	Princeton University	普林斯顿大学	PRINCETON
283	美国	Purdue University, West Lafayette	普渡大学西拉法叶校区	PURDUE
284	美国	Reed College	里德学院	REED
285	美国	Rice University	莱斯大学	RICE
286	瑞士	ETH Zurich	苏黎世联邦理工学院	ETHZ
287	瑞士	University of Zurich	苏黎世大学	UZH.CH
288	美国	University of Richmond	里士满大学	RICHMOND
289	美国	University of California, Riverside	加州大学河滨分校	UCR
290	美国	Rose-Hulman Institute of Technology	罗斯-霍曼理工学院	ROSE-HULMAN
291	美国	Rutgers University	罗格斯大学	RUTGERS
292	美国	San Francisco State University	旧金山州立大学	SFSU
293	美国	Santa Clara University	圣塔克拉拉大学	SCU
294	美国	Seattle University	西雅图大学	SEATTLEU
295	日本	Kyushu University	九州大学	KYUSHU-U.JP
296	美国	Penn State Harrisburg	宾州州立大学哈里斯堡分校	PSU.HARRISBURG
297	美国	California State University, East Bay	加州州立大学东湾分校	CSUEASTBAY
298	美国	Washington State University	华盛顿州立大学	WSU
299	新加坡	Singapore University of Technology and Design	新加坡科技与设计大学	SUTD
300	法国	University of Paris-Sud	巴黎第十一大学	UNIVERSITE-PARIS-SACLAY.FR
301	美国	Chicago State University	芝加哥州立大学	CSU
302	美国	skidmore College	斯基德莫尔学院	SKIDMORE
303	美国	Smith College	史密斯学院	SMITH
304	美国	South Dakota State University	南达科他州立大学	SDSTATE
305	美国	University of Southern California	南加州大学	USC
306	美国	Southern Methodist University	南卫理公会大学	SMU
307	美国	Southern Illinois University, Carbondale	南伊利诺斯大学卡本代尔分校	SIU
308	美国	University of Southern Mississippi	南密西西比大学	USM
309	丹麦	University of Southern Denmark	南丹麦大学	SDU.DK
310	美国	University of South Florida	南佛罗里达大学	USF
311	澳大利亚	University of New South Wales	新南威尔士大学	UNSW
312	英国	University of Southampton	南安普顿大学	SOUTHAMPTON
313	美国	UT Southwestern Medical Center	德克萨斯大学西南医学中心	UTSOUTHWESTERN
314	美国	University of South Dakota	南达科他大学	USD
315	美国	University of Missouri, St. Louis	密苏里大学圣路易斯分校	UMSL
316	澳大利亚	University of South Australia	南澳大学	UNISA.AU
317	新西兰	University of Auckland	奥克兰大学-新西兰	AUCKLAND
318	美国	University of Michigan, Ann Arbor	密歇根大学安娜堡分校	UMICH
319	美国	University of Michigan-Dearborn	密歇根大学迪尔伯恩分校	UMDEARBORN
320	美国	Stanford University	斯坦福大学	STANFORD
321	美国	State University of New York, Albany	纽约州立大学奥尔巴尼分校	ALBANY
322	美国	State University of New York, Binghamton	纽约州立大学宾汉姆顿大学	BINGHAMTON
323	美国	State University of New York, Buffalo	纽约州立大学布法罗分校	BUFFALO
324	美国	State University of New York, Stony Brook	纽约州立大学石溪分校	STONYBROOK
325	美国	State University of New York, New Paltz	纽约州立大学	NEWPALTZ
326	美国	University of Pittsburgh	匹兹堡大学	PITT
327	俄国	Saint Petersburg State University	圣彼得堡国立大学	SPBU.RU
328	德国	University of Stuttgart	斯图加特大学	UNI-STUTTGART.DE
329	美国	Suffolk University	美国萨福克大学	SUFFOLK
330	美国	Swarthmore College	斯沃斯莫尔学院	SWARTHMORE
331	美国	Temple University	天普大学	TEMPLE
332	美国	Texas A&M University, College Station	德克萨斯A&M大学	TAMU
333	日本	University of Tsukuba	筑波大学	TSUKUBA.JP
334	美国	Texas State University	德克萨斯州立大学	TXSTATE
335	美国	Texas Tech University	德州理工大学	TTU
336	美国	Trinity College	牛津大学三一学院	TRINCOLL
337	爱尔兰	Trinity College Dublin, University of Dublin	都柏林三一学院	TCD.IE
338	美国	Tufts University	塔夫茨大学	TUFTS
339	美国	Tulane University	杜兰大学	TULANE
340	美国	Union College	Union College 联合学院	UNION
341	瑞典	Uppsala University	乌普萨拉大学	UU.SE
342	美国	University of Akron	阿克伦大学	UAKRON
343	加拿大	University of Alberta	阿尔伯塔大学	UALBERTA
344	美国	University of Alabama	阿拉巴马大学	UA
345	美国	University of Alaska, Fairbanks	阿拉斯加大学费尔班克斯分校	UAF
346	澳大利亚	Macquarie University	麦考瑞大学	MQ.AU
347	西班牙	Autonomous University of Madrid	马德里自治大学	UAM.ES
348	台湾	Yuan Ze University	台湾元智大学	YZU.TW
349	阿联酋	United Arab Emirates University	阿联酋大学	UAEU.AE
350	意大利	University of Padua	帕多瓦大学	UNIPD.IT
351	比利时	University of Antwerp	安特卫普大学	UANTWERPEN.BE
352	巴西	Universidade Estadual de Campinas	坎皮纳斯大学	UNICAMP.BR/UNICAMP
353	美国	University of Bridgeport	桥港大学	BRIDGEPORT
354	美国	University of California, Berkeley	加利福尼亚大学伯克利分校	BERKELEY
355	美国	University of California, Davis	加利福尼亚大学戴维斯分校	UCD
356	美国	University of California, Irvine	加利福尼亚大学尔湾分校	UCI
357	美国	University of California, Los Angeles	加利福尼亚大学洛杉矶分校	UCLA
358	美国	University of California, Merced	加州大学美熹德分校	MERCED
359	美国	University of California, San Diego	加利福尼亚大学圣迭戈分校	UCSD
360	美国	University of California, San Francisco	加利福尼亚大学旧金山分校	UCSF
361	美国	University of California, Santa Barbara	加州大学圣塔芭芭拉分校	UCSB
362	加拿大	University of Calgary	卡尔加里大学	UCALGARY
363	香港	Education University of Hong Kong	香港教育大学	EDUHK
364	美国	University of Chicago	芝加哥大学	UCHICAGO
365	美国	University of Colorado, Boulder	科罗拉多大学-波尔得	COLORADO
366	美国	University of Colorado, Denver	科罗拉多大学-丹佛	UCDENVER
367	美国	University of Colorado, Colorado Springs	科罗拉多大学	UCCS
368	美国	University of Dayton	戴顿大学	UDAYTON
369	美国	University of Delaware	特拉华大学	UDEL
370	美国	University of Denver	丹佛大学	DU
371	美国	University of Florida	佛罗里达大学	UFL
372	加拿大	University of Guelph	圭尔夫大学	UOGUELPH.CA
373	美国	University of Houston	休斯敦大学	HOUSTON
374	美国	University of Idaho	爱达荷大学	UIDAHO
375	美国	University of Illinois at Chicago	伊利诺伊大学芝加哥分校	UIC
376	美国	Washington University in St. Louis	圣路易斯华盛顿大学	WUSTL
377	美国	University of Louisiana, Lafayette	路易斯安那大学拉法叶分校	LOUISIANA
378	美国	University of Iowa	爱荷华大学	UIOWA
379	以色列	Hebrew University of Jerusalem	耶路撒冷希伯来大学	HUJI.IL
380	美国	University of Kansas	堪萨斯大学	KANSAS
381	德国	University Ulm	乌尔姆大学	UNI-ULM.DE
382	美国	University of Maine	缅因大学	UMAINE
383	美国	University of Massachusetts, Amherst	马萨诸塞大学安姆斯特分校	UMASS
384	美国	University of Massachusetts, Dartmouth	马萨诸塞大学达特茅斯分校	UMASSD
385	美国	University of Massachusetts, Lowell	马萨诸塞大学	UML
386	美国	University of Memphis	孟菲斯大学	MEMPHIS
387	美国	University of Miami	迈阿密大学	MIAMI
388	美国	University of Minnesota, Twin Cities	明尼苏达大学-双城	UMN
389	美国	University of Minnesota, Duluth	明尼苏达大学-杜鲁斯	UMN.DULUTH
390	美国	University of Mississippi	密西西比大学	OLEMISS
391	美国	University of Nebraska, Omaha	内布拉斯加大学奥马哈分校	UNOMAHA
392	英国	Brunel University London	布鲁内尔大学	BRUNEL.UK
393	美国	University of New Haven	纽海文大学	NEWHAVEN
394	美国	University of New Mexico	新墨西哥大学	UNM
395	美国	University of New Orleans	新奥尔良大学	UNO
396	美国	University of North Dakota	北达科他大学	UND
397	美国	University of Pennsylvania	宾夕法尼亚大学	UPENN
398	美国	University of North Texas	北德克萨斯州大学	UNT
399	美国	University of Notre Dame	圣母大学	NOTREDAME
400	美国	University of Oklahoma	俄克拉荷马大学	OKLAHOMA
401	美国	University of Oregon	俄勒冈大学	UOREGON
402	美国	University Of Phoenix	凤凰城大学	PHOENIX
403	西班牙	Pompeu Fabra University	庞培法布拉大学	UPF
404	葡萄牙	University of Porto	波尔图大学	UP.PT
405	法国	Ecole Normale Superieure de Cachan	卡尚高等师范学院	ENS.FR
406	意大利	Scuola Normale Superiore di Pisa	比萨高等师范学院	SNS.IT
407	法国	Université Paris Dauphin	巴黎第九大学	DAUPHINE.FR
408	意大利	Scuola Superiore SantAnna	比萨圣安娜大学	SANTANNAPISA.IT
409	美国	University of Rhode Island	罗德岛大学	URI
410	美国	University of San Francisco	旧金山大学	USFCA
411	法国	ESSEC Business School	埃塞克商学院	ESSEC.FR
412	加拿大	Dalhousie University	达尔豪斯大学	DALHOUSIE
413	丹麦	Copenhagen Business School	哥本哈根商学院	CBS.DK
414	挪威	BI Norwegian Business School	挪威管理学院	BI.NO
415	加拿大	University of Toronto	多伦多大学	UTORONTO
416	美国	University of Texas - Dallas	德克萨斯大学达拉斯分校	UTD
417	美国	University of Utah	犹他大学	UTAH
418	美国	University of Tennessee	田纳西大学	UTK
419	美国	University of Texas at Arlington	德克萨斯大学阿灵顿分校	ARLINGTON
420	美国	University of Texas at Austin	得克萨斯大学奥斯汀分校	AUSTIN
421	美国	University of Texas, San Antonio	德克萨斯大学圣安东尼奥分校	UTSA
422	美国	University of Toledo	托莱多大学	UTOLEDO
423	美国	University of Tulsa	塔尔萨大学	UTULSA
424	美国	University of Vermont	佛蒙特大学	UVM
425	美国	University of Virginia	弗吉尼亚大学	UVA
426	美国	Virginia Tech	弗吉尼亚理工大学	VIRGINIATECH
427	美国	Virginia Commonwealth University	弗吉尼亚联邦大学	VCU
428	美国	West Virginia University Institute of Technology	西弗吉尼亚大学理工学院	WVUTECH
429	美国	University of Washington, Seattle	华盛顿大学	UW
430	加拿大	University of Waterloo	滑铁卢大学	UWATERLOO
431	美国	University of Washington, Tacoma	华盛顿大学塔科马分校	UW.TACOMA
432	加拿大	University of Western Ontario	韦仕敦大学	UWO
433	美国	University of Washington, Bothell	华盛顿大学贝色分校	UW.BOTHELL
434	加拿大	University of Windsor	温莎大学	UWINDSOR.CA
435	澳大利亚	University of Western Australia	西澳大学	UWA.AU
436	美国	University of West Florida	西佛罗里达大学	UWF
437	美国	University of Wyoming	怀俄明大学	UWYO
438	美国	University of Wisconsin, La Crosse	威斯康星大学拉克罗斯分校	UWLAX
439	奥地利	Vienna University of Technology	维也纳工业大学	TUWIEN.AT
440	美国	University of Wisconsin, Madison	威斯康星大学麦迪逊分校	WISCONSIN
441	美国	Utah State University	犹他州立大学	USU
442	美国	Vanderbilt University	范德堡大学	VANDERBILT
443	美国	Vassar College	瓦萨学院	VASSAR
444	美国	Wake Forest University	维克森林大学	WFU
445	美国	Washington and Lee University	华盛顿与李大学	WLU
446	加拿大	Wilfrid Laurier University	威尔弗里德·劳雷尔大学	WLU.CA
447	美国	Washington State University, Vancouver	华盛顿州立大学-温哥华分校	VANCOUVER.WSU
448	美国	Wayne State University	美国韦恩州立大学	WAYNE
449	美国	Wesleyan University	维思大学	WESLEYAN
450	英国	University of Westminster	威斯敏斯特大学	WESTMINSTER.UK
451	美国	Whitman College	惠特曼学院	WHITMAN
452	美国	Wichita State University	威奇塔州立大学	WICHITA
453	美国	Williams College	威廉姆斯学院	WILLIAMS
454	美国	Wright State University	莱特州立大学	WRIGHT
455	美国	Yale University	耶鲁大学	YALE
456	日本	Hokkaido University	北海道大学	HOKUDAI.JP
457	阿根廷	Universidad de Buenos Aires	布宜诺斯艾利斯大学	UBA.AR
458	澳大利亚	University of Adelaide	阿德雷德大学	ADELAIDE.AU
459	澳大利亚	Deakin University	迪肯大学	DEAKIN.AU
460	澳大利亚	Griffith University	格里菲斯大学	GRIFFITHCOLLEGE.AU
461	澳大利亚	La Trobe University	拉筹伯大学	LATROBE.AU
462	澳大利亚	Monash University	莫纳什大学	MONASH
463	澳大利亚	University of Newcastle, Australia	纽卡斯尔大学-澳大利亚	NEWCASTLE.AU
464	澳大利亚	Queensland University of Technology	昆士兰科技大学	QUT.AU
465	澳大利亚	University of Melbourne	墨尔本大学	MELBOURNE
466	澳大利亚	University of Wollongong	卧龙岗大学	UOW.AU
467	澳大利亚	University of Queensland	昆士兰大学	QUEENSLAND
468	澳大利亚	University of Sydney	悉尼大学	SYDNEY.AU
469	澳大利亚	University of Tasmania	塔斯马尼亚大学	UTAS.AU
470	澳大利亚	University of Technology Sydney	悉尼科技大学	UTS.AU
471	阿根廷	Universidad Austral	阿根廷奥斯特拉尔大学	AUSTRAL.AR
472	丹麦	University of Copenhagen	哥本哈根大学	KU.DK
473	英国	Durham University	杜伦大学	DURHAM
474	瑞典	Chalmers University of Technology	查尔姆斯工业大学	CHALMERS.SE
475	德国	Eberhard Karls University of Tubingen	蒂宾根大学	UNI-TUEBINGEN.DE
476	比利时	Katholieke Universiteit Leuven	鲁汶大学	KULEUVEN
477	比利时	Vrije Universiteit Brussel	布鲁塞尔自由大学	ULB.BE
478	爱尔兰	Dublin City University	都柏林城市大学	DCU.IE
479	英国	Queen's University Belfast	贝尔法斯特女王大学	QUB.UK
480	爱尔兰	University College Dublin	都柏林大学学院	UCD.IE
481	欧洲	EIT Digital	EIT Digital Master School	EITDIGITAL
482	德国	Freie Universitaet Berlin	柏林自由大学	FU-BERLIN.DE
483	德国	Technische Universitat Darmstadt	达姆施塔特工业大学	TU-DARMSTADT.DE
484	巴西	Universidade Federal do Rio de Janeiro	里约热内卢联邦大学	UFRJ.BR
485	瑞士	University of Bern	伯尔尼大学	UNIBE.CH
486	意大利	University of Bologna	博洛尼亚大学	UNIBO.IT
487	瑞士	University of Basel	巴塞尔大学	UNIBAS.CH
488	意大利	Sapienza University of Rome	罗马第一大学	UNIROMA1.IT
489	意大利	University of Trento	特伦托大学	UNITN.IT
490	以色列	Ben Gurion University of The Negev	本古里安大学	IN.IL
491	法国	Sorbonne University Pierre and Marie Curie Campus	巴黎第六大学	SORBONNE-UNIVERSITE.FR
492	英国	University of Edinburgh	爱丁堡大学	EDINBURGH
493	瑞典	University of Gothenburg	哥德堡大学	GU.SE
494	丹麦	Technical university of denmark	丹麦理工大学	DTU.DK
495	美国	University of Arkansas	阿肯色大学	ARKANSAS
496	美国	Kansas State University	堪萨斯州立大学	KANSASSTATE
497	加拿大	Acadia University	阿卡迪亚大学	ACADIAU
498	加拿大	HEC Montréal	蒙特利尔高等商学院	HEC.CA
499	加拿大	Lakehead University	湖首大学	LAKEHEADU.CA
500	芬兰	University of Helsinki	赫尔辛基大学	HELSINKI.FI/YLIOPISTO
501	香港	Open University of Hong Kong	香港公开大学	OUHK
502	瑞典	Linkoping University	林雪平大学	LIU.SE
503	加拿大	Ryerson University	怀雅逊大学	RYERSON.CA
504	加拿大	Simon Fraser University	西蒙弗雷泽大学	SIMONFRASER
505	加拿大	Laval University	拉瓦尔大学	ULAVAL.CA
506	加拿大	University of Manitoba	曼尼托巴大学	MANITOBA.CA
507	加拿大	University of Montreal	蒙特利尔大学	UMONTREAL.CA
508	加拿大	University of Ottawa	渥太华大学	OTTAWA
509	英国	University College London	伦敦大学学院	UCL
510	美国	City University of New York, Baruch College	纽约市立大学柏鲁克分校	BARUCH
511	智利	University of Chile	智利大学	UCHILE.CL
512	瑞典	Umea University	于默奥大学	UMU.SE
513	英国	University of Sussex	萨塞克斯大学	SUSSEX.UK
514	香港	Hong Kong University of Science and Technology	香港科技大学	HKUST
515	澳门	Macau University of Science and Technology	澳门科技大学	MUST
516	法国	Strasbourg University	斯特拉斯堡大学	UNISTRA.FR
517	香港	Chinese University of Hong Kong	香港中文大学	CUHK
518	德国	Technical University of Munich	慕尼黑工业大学	TUM.DE
519	德国	Ludwig Maximilian University of Munich	慕尼黑大学	UNI-MUENCHEN.DE
520	丹麦	Aalborg University	奥尔堡大学	AAU.DK
521	丹麦	Aarhus University	奥胡斯大学	AU.DK
522	香港	University of Hong Kong	香港大学	HKU
523	台湾	Tamkang University	台湾淡江大学	TKU.TW
524	日本	Tohoku University	东北大学-日本	TOHOKU.JP
525	英国	Loughborough University	拉夫堡大学	LBORO.UK
526	芬兰	Aalto University	阿尔托大学	AALTO.FI
527	加拿大	Queen's University	女王大学	QUEENS
528	德国	University of Munster	明斯特大学	UNI-MUENSTER.DE
529	法国	Pantheon-Sorbonne University	巴黎第一大学	UNIV-PARIS1.FR
530	法国	University of Grenoble	格勒诺布尔大学	UNIV-GRENOBLE-ALPES.FR
531	德国	Berlin Institute of Technology	柏林工业大学	TU-BERLIN.DE
532	德国	Dresden University of Technology	德累斯顿工业大学	TU-DRESDEN.DE
533	德国	University of Bonn	波恩大学	UNI-BONN.DE
534	德国	Goethe University Frankfurt	法兰克福大学	UNI-FRANKFURT.DE
535	德国	University of Freiburg	弗莱堡大学	UNI-FREIBURG.DE
536	德国	University of Gottingen	哥廷根大学	UNI-GOETTINGEN.DE
537	德国	University of Hamburg	汉堡大学	UNI-HAMBURG.DE
538	德国	University of Cologn	科隆大学	UNI-KOELN.DE
539	德国	Johannes Gutenberg University of Mainz	美因茨大学	UNI-MAINZ.DE
540	英国	University of Essex	埃塞克斯大学	ESSEX.UK
541	香港	Hong Kong Baptist University	香港浸会大学	HKBU
542	香港	Lingnan University	岭南大学	HKLU
543	美国	Ohio State University	俄亥俄州立大学	OHIOSTATE
544	英国	London School of Economics and Political Science	伦敦政治经济学院	LSE
545	马来西亚	Universiti Malaya	马来亚大学	UM.MY
546	俄国	Lomonosov Moscow State University	莫斯科国立大学	MSU.RU
547	俄国	Moscow Institute of Physics and Technology	莫斯科物理技术学院	MIPT.RU
548	俄国	Tomsk State University	托木斯克国立大学	OMSU.RU
549	巴西	Universidade de S?o Paulo	圣保罗大学	WWW5.BR
550	美国	ArtCenter College of Design	艺术中心设计学院	ACCD
551	英国	City, University of London	伦敦大学城市学院	CITY.UK
552	爱尔兰	University College Cork	科克大学学院	UCC.IE
553	英国	Queen Mary University of London	伦敦玛丽女王大学	QMUL
554	法国	Toulouse School of Economics	图卢兹经济学院	TSE.FR
555	英国	Royal Holloway University of London	伦敦大学皇家霍洛威学院	RHUL.UK
556	葡萄牙	University of Lisbon	里斯本大学	ULISBOA.PT
557	以色列	Tel Aviv University	特拉维夫大学	TAU.IL
558	意大利	University of Milan	米兰大学	UNIMI.IT
559	日本	Hiroshima University	广岛大学	HIROSHIMA-U.JP
560	日本	Keio University	庆应义塾大学	KEIO.JP
561	日本	Kobe University	神户大学	KOBE-U.JP
562	韩国	Korea University	高丽大学	KOREA.KR
563	日本	Kyoto University	京都大学	KYOTO-U.JP
564	日本	Nagoya University	名古屋大学	EN.JP
565	日本	Osaka University	大阪大学	OSAKA-U.JP
566	日本	Tokyo Medical and Dental University	东京医科齿科大学	TMD.JP
567	日本	Waseda University	早稻田大学	WASEDA
568	挪威	University of Bergen	卑尔根大学	UIB.NO
569	韩国	Hanyang University	汉阳大学	HANYANG.KR
570	韩国	KAIST - Korea Advanced Institute of Science & Technology	韩国高等科技学院	KAIST.KR
571	韩国	Pohang University of Science And Technology	浦项科技大学	POSTECH.KR
572	韩国	Yonsei University	延世大学	YONSEI.KR
573	英国	University of Bath	巴斯大学	BATH.UK
574	瑞典	Lund University	隆德大学	LU.SE
575	西班牙	University of Navarra	纳瓦拉大学	UNAV
576	澳门	University of Macau	澳门大学	UMACAU
577	荷兰	Wageningen University	瓦格宁根大学	WUR
578	法国	Paris School of Economics	巴黎经济学院	PARISSCHOOLOFECONOMICS.FR
579	荷兰	Tilburg University	蒂尔堡大学	TILBURGUNIVERSITY
580	荷兰	Delft University of Technology	代尔夫特理工大学	TUDELFT
581	荷兰	Eindhoven University of Technology	埃因霍芬理工大学	TUE
582	新西兰	University of Canterbury	坎特伯雷大学	CANTERBURY.NZ
583	新西兰	University of Otago	奥塔戈大学	OTAGO.NZ
584	新西兰	University of Waikato	怀卡托大学	WAIKATO.NZ
585	英国	Birkbeck, University of London	伦敦大学伯克贝克学院	BBK.UK
586	英国	University of Birmingham	伯明翰大学	BIRMINGHAM
587	台湾	Feng Chia University	台湾逢甲大学	FCU.TW
588	挪威	Norwegian School of Economics	挪威经济学院	NHH.NO
589	挪威	University of Oslo	奥斯陆大学	UIO.NO
590	英国	University of East Anglia	东安格利亚大学	UEA.UK
591	美国	Rhode Island School of Design	罗德岛设计学院	RISD
592	法国	Ecole des Ponts ParisTec	巴黎高等路桥学院	ECOLEDESPONTS.FR
593	以色列	Israel Institute of Technology	以色列理工学院	TECHNION.IL
594	美国	University of Atlanta	亚特兰大大学	UOFA
595	美国	College of William & Mary	威廉与玛丽学院	WILLIAMMARY
596	英国	University of Reading	雷丁大学	READING.UK
597	西班牙	University Carlos III de Madrid: Getafe Campus	马德里卡洛斯三世大学	UC3M.ES
598	英国	University of Dundee	邓迪大学	DUNDEE.UK
599	英国	University of Sheffield	谢菲尔德大学	SHEFFIELD
600	瑞士	University of Lausanne	洛桑大学	UNIL.CH
601	英国	University of Aberdeen	阿伯丁大学	ABDN.UK
602	英国	Aston University	阿斯顿大学	ASTON.UK
603	英国	University of Bristol	布里斯托大学	BRISTOL
604	英国	Oxford Brookes University	牛津布鲁克斯大学	BROOKES.UK
605	英国	University of Cambridge	剑桥大学	CAMBRIDGE
606	英国	Cardiff University	卡迪夫大学	CARDIFF.UK
607	英国	Cranfield University	克兰菲尔德大学	CRANFIELD.UK
608	英国	University of Exeter	埃克塞特大学	EXETER.UK
609	英国	University of Glasgow	格拉斯哥大学	GLASGOW
610	英国	Heriot-Watt University	赫瑞瓦特大学	HW.UK
611	英国	Imperial College London	帝国理工学院	IMPERIAL
612	英国	University of Leicester	莱斯特大学	LE.UK
613	英国	University of Leeds	利兹大学	LEEDS
614	英国	University of Liverpool	利物浦大学	LIVERPOOL
615	英国	University of Nottingham	诺丁汉大学	NOTTINGHAM
616	英国	University of Oxford	牛津大学	OXFORD
617	英国	University of Strathclyde	斯凯莱德大学	STRATH.UK
618	英国	University of Surrey	萨里大学	SURREY.UK
619	英国	University of Warwick	华威大学	WARWICK.UK
620	英国	University of York	约克大学	YORK
621	英国	Lancaster University	兰卡斯特大学	LANCASTER.UK
622	英国	Newcastle University	纽卡斯尔大学	NCL
623	美国	Parsons School of Art and Design	帕森斯设计学院	PARSONS
624	美国	California College of the Arts	加州艺术学院	CCA
625	英国	University of the Arts London	伦敦艺术大学	ARTS.UK
\.


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group (id, name) FROM stdin;
1	申请主版
2	少年班学院
3	数学科学学院
4	物理学院
5	管理学院
6	化学与材料科学学院
7	生命科学学院
8	地球和空间科学学院
9	工程科学学院
10	信息科学技术学院
11	人文与社会科学学院
12	核科学技术学院
13	计算机科学与技术学院
14	环境科学与光电技术学院
15	微电子学院
16	网络空间安全学院
17	软件学院
18	大数据学院
19	国家同步辐射实验室
20	火灾科学国家重点实验室
21	合肥微尺度物质科学国家实验室（筹）
22	环境科学与工程系
23	生命科学与医学部
24	flyers-admin
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add content type	4	add_contenttype
14	Can change content type	4	change_contenttype
15	Can delete content type	4	delete_contenttype
16	Can view content type	4	view_contenttype
17	Can add session	5	add_session
18	Can change session	5	change_session
19	Can delete session	5	delete_session
20	Can view session	5	view_session
21	Can add user	6	add_user
22	Can change user	6	change_user
23	Can delete user	6	delete_user
24	Can view user	6	view_user
25	Can add user profile	7	add_userprofile
26	Can change user profile	7	change_userprofile
27	Can delete user profile	7	delete_userprofile
28	Can view user profile	7	view_userprofile
29	Can add university	8	add_university
30	Can change university	8	change_university
31	Can delete university	8	delete_university
32	Can view university	8	view_university
33	Can add program	9	add_program
34	Can change program	9	change_program
35	Can delete program	9	delete_program
36	Can view program	9	view_program
37	Can add background	10	add_background
38	Can change background	10	change_background
39	Can delete background	10	delete_background
40	Can view background	10	view_background
41	Can add admissions	11	add_admissions
42	Can change admissions	11	change_admissions
43	Can delete admissions	11	delete_admissions
44	Can view admissions	11	view_admissions
45	Can add topic	12	add_topic
46	Can change topic	12	change_topic
47	Can delete topic	12	delete_topic
48	Can view topic	12	view_topic
49	Can add topic revision	13	add_topicrevision
50	Can change topic revision	13	change_topicrevision
51	Can delete topic revision	13	delete_topicrevision
52	Can view topic revision	13	view_topicrevision
53	Can add notification	14	add_notification
54	Can change notification	14	change_notification
55	Can delete notification	14	delete_notification
56	Can view notification	14	view_notification
57	Can add comment thread	15	add_commentthread
58	Can change comment thread	15	change_commentthread
59	Can delete comment thread	15	delete_commentthread
60	Can view comment thread	15	view_commentthread
61	Can add comment	16	add_comment
62	Can change comment	16	change_comment
63	Can delete comment	16	delete_comment
64	Can view comment	16	view_comment
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	contenttypes	contenttype
5	sessions	session
6	account	user
7	account	userprofile
8	admissions	university
9	admissions	program
10	admissions	background
11	admissions	admissions
12	forum	topic
13	forum	topicrevision
14	forum	notification
15	forum	commentthread
16	forum	comment
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2021-06-02 10:49:16.574061+08
2	contenttypes	0002_remove_content_type_name	2021-06-02 10:49:16.5807+08
3	auth	0001_initial	2021-06-02 10:49:16.598702+08
4	auth	0002_alter_permission_name_max_length	2021-06-02 10:49:16.6172+08
5	auth	0003_alter_user_email_max_length	2021-06-02 10:49:16.621875+08
6	auth	0004_alter_user_username_opts	2021-06-02 10:49:16.626505+08
7	auth	0005_alter_user_last_login_null	2021-06-02 10:49:16.631249+08
8	auth	0006_require_contenttypes_0002	2021-06-02 10:49:16.633233+08
9	auth	0007_alter_validators_add_error_messages	2021-06-02 10:49:16.637888+08
10	auth	0008_alter_user_username_max_length	2021-06-02 10:49:16.642554+08
11	auth	0009_alter_user_last_name_max_length	2021-06-02 10:49:16.64725+08
12	auth	0010_alter_group_name_max_length	2021-06-02 10:49:16.652202+08
13	auth	0011_update_proxy_permissions	2021-06-02 10:49:16.659276+08
14	auth	0012_alter_user_first_name_max_length	2021-06-02 10:49:16.663815+08
15	account	0001_initial	2021-06-02 10:49:16.677434+08
16	admissions	0001_initial	2021-06-02 10:49:16.717781+08
17	account	0002_auto_20210601_0414	2021-06-02 10:49:16.799149+08
18	admin	0001_initial	2021-06-02 10:49:16.851534+08
19	admin	0002_logentry_remove_auto_add	2021-06-02 10:49:16.870085+08
20	admin	0003_logentry_add_action_flag_choices	2021-06-02 10:49:16.880421+08
21	forum	0001_initial	2021-06-02 10:49:17.047787+08
22	sessions	0001_initial	2021-06-02 10:49:17.120249+08
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
\.


--
-- Data for Name: forum_comment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.forum_comment (id, content, action, created_time, upvoted_count, related_comment_thread_id, related_user_id) FROM stdin;
\.


--
-- Data for Name: forum_comment_upvoted; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.forum_comment_upvoted (id, comment_id, user_id) FROM stdin;
\.


--
-- Data for Name: forum_commentthread; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.forum_commentthread (id, content, action, created_time, is_anonymous, upvoted_count, related_topic_id, related_user_id) FROM stdin;
\.


--
-- Data for Name: forum_commentthread_upvoted; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.forum_commentthread_upvoted (id, commentthread_id, user_id) FROM stdin;
\.


--
-- Data for Name: forum_notification; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.forum_notification (id, created_time, ref_obj_name, ref_obj_id, message, is_read, operation, related_user_id) FROM stdin;
\.


--
-- Data for Name: forum_topic; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.forum_topic (id, followed_count, action, hit_count, comment_count, upvoted_count, is_valid, current_version_id, group_id) FROM stdin;
\.


--
-- Data for Name: forum_topic_followed; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.forum_topic_followed (id, topic_id, user_id) FROM stdin;
\.


--
-- Data for Name: forum_topic_upvoted; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.forum_topic_upvoted (id, topic_id, user_id) FROM stdin;
\.


--
-- Data for Name: forum_topicrevision; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.forum_topicrevision (id, revision_number, title, content, image, file, created_time, is_valid, related_topic_id, related_user_id) FROM stdin;
\.


--
-- Name: account_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.account_user_groups_id_seq', 1, false);


--
-- Name: account_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.account_user_user_permissions_id_seq', 1, false);


--
-- Name: account_userprofile_followed_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.account_userprofile_followed_id_seq', 1, false);


--
-- Name: account_userprofile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.account_userprofile_id_seq', 1, false);


--
-- Name: admissions_admissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.admissions_admissions_id_seq', 1, false);


--
-- Name: admissions_admissions_upvoted_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.admissions_admissions_upvoted_id_seq', 1, false);


--
-- Name: admissions_background_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.admissions_background_id_seq', 1, false);


--
-- Name: admissions_background_upvoted_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.admissions_background_upvoted_id_seq', 1, false);


--
-- Name: admissions_program_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.admissions_program_id_seq', 4570, true);


--
-- Name: admissions_university_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.admissions_university_id_seq', 625, true);


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 24, true);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 64, true);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 1, false);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 16, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 22, true);


--
-- Name: forum_comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.forum_comment_id_seq', 1, false);


--
-- Name: forum_comment_upvoted_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.forum_comment_upvoted_id_seq', 1, false);


--
-- Name: forum_commentthread_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.forum_commentthread_id_seq', 1, false);


--
-- Name: forum_commentthread_upvoted_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.forum_commentthread_upvoted_id_seq', 1, false);


--
-- Name: forum_notification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.forum_notification_id_seq', 1, false);


--
-- Name: forum_topic_followed_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.forum_topic_followed_id_seq', 1, false);


--
-- Name: forum_topic_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.forum_topic_id_seq', 1, false);


--
-- Name: forum_topic_upvoted_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.forum_topic_upvoted_id_seq', 1, false);


--
-- Name: forum_topicrevision_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.forum_topicrevision_id_seq', 1, false);


--
-- Name: account_user_groups account_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_user_groups
    ADD CONSTRAINT account_user_groups_pkey PRIMARY KEY (id);


--
-- Name: account_user_groups account_user_groups_user_id_group_id_4d09af3e_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_user_groups
    ADD CONSTRAINT account_user_groups_user_id_group_id_4d09af3e_uniq UNIQUE (user_id, group_id);


--
-- Name: account_user account_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_user
    ADD CONSTRAINT account_user_pkey PRIMARY KEY (id);


--
-- Name: account_user_user_permissions account_user_user_permis_user_id_permission_id_48bdd28b_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_user_user_permissions
    ADD CONSTRAINT account_user_user_permis_user_id_permission_id_48bdd28b_uniq UNIQUE (user_id, permission_id);


--
-- Name: account_user_user_permissions account_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_user_user_permissions
    ADD CONSTRAINT account_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: account_user account_user_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_user
    ADD CONSTRAINT account_user_username_key UNIQUE (username);


--
-- Name: account_userprofile_followed account_userprofile_foll_from_userprofile_id_to_u_5fe7a621_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_userprofile_followed
    ADD CONSTRAINT account_userprofile_foll_from_userprofile_id_to_u_5fe7a621_uniq UNIQUE (from_userprofile_id, to_userprofile_id);


--
-- Name: account_userprofile_followed account_userprofile_followed_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_userprofile_followed
    ADD CONSTRAINT account_userprofile_followed_pkey PRIMARY KEY (id);


--
-- Name: account_userprofile account_userprofile_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_userprofile
    ADD CONSTRAINT account_userprofile_pkey PRIMARY KEY (id);


--
-- Name: account_userprofile account_userprofile_related_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_userprofile
    ADD CONSTRAINT account_userprofile_related_user_id_key UNIQUE (related_user_id);


--
-- Name: admissions_admissions admissions_admissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admissions_admissions
    ADD CONSTRAINT admissions_admissions_pkey PRIMARY KEY (id);


--
-- Name: admissions_admissions_upvoted admissions_admissions_up_admissions_id_user_id_d44847f0_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admissions_admissions_upvoted
    ADD CONSTRAINT admissions_admissions_up_admissions_id_user_id_d44847f0_uniq UNIQUE (admissions_id, user_id);


--
-- Name: admissions_admissions_upvoted admissions_admissions_upvoted_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admissions_admissions_upvoted
    ADD CONSTRAINT admissions_admissions_upvoted_pkey PRIMARY KEY (id);


--
-- Name: admissions_background admissions_background_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admissions_background
    ADD CONSTRAINT admissions_background_pkey PRIMARY KEY (id);


--
-- Name: admissions_background admissions_background_related_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admissions_background
    ADD CONSTRAINT admissions_background_related_user_id_key UNIQUE (related_user_id);


--
-- Name: admissions_background_upvoted admissions_background_up_background_id_user_id_c6a3c639_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admissions_background_upvoted
    ADD CONSTRAINT admissions_background_up_background_id_user_id_c6a3c639_uniq UNIQUE (background_id, user_id);


--
-- Name: admissions_background_upvoted admissions_background_upvoted_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admissions_background_upvoted
    ADD CONSTRAINT admissions_background_upvoted_pkey PRIMARY KEY (id);


--
-- Name: admissions_program admissions_program_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admissions_program
    ADD CONSTRAINT admissions_program_pkey PRIMARY KEY (id);


--
-- Name: admissions_university admissions_university_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admissions_university
    ADD CONSTRAINT admissions_university_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: forum_comment forum_comment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forum_comment
    ADD CONSTRAINT forum_comment_pkey PRIMARY KEY (id);


--
-- Name: forum_comment_upvoted forum_comment_upvoted_comment_id_user_id_094978de_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forum_comment_upvoted
    ADD CONSTRAINT forum_comment_upvoted_comment_id_user_id_094978de_uniq UNIQUE (comment_id, user_id);


--
-- Name: forum_comment_upvoted forum_comment_upvoted_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forum_comment_upvoted
    ADD CONSTRAINT forum_comment_upvoted_pkey PRIMARY KEY (id);


--
-- Name: forum_commentthread forum_commentthread_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forum_commentthread
    ADD CONSTRAINT forum_commentthread_pkey PRIMARY KEY (id);


--
-- Name: forum_commentthread_upvoted forum_commentthread_upvo_commentthread_id_user_id_3f6770a4_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forum_commentthread_upvoted
    ADD CONSTRAINT forum_commentthread_upvo_commentthread_id_user_id_3f6770a4_uniq UNIQUE (commentthread_id, user_id);


--
-- Name: forum_commentthread_upvoted forum_commentthread_upvoted_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forum_commentthread_upvoted
    ADD CONSTRAINT forum_commentthread_upvoted_pkey PRIMARY KEY (id);


--
-- Name: forum_notification forum_notification_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forum_notification
    ADD CONSTRAINT forum_notification_pkey PRIMARY KEY (id);


--
-- Name: forum_topic forum_topic_current_version_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forum_topic
    ADD CONSTRAINT forum_topic_current_version_id_key UNIQUE (current_version_id);


--
-- Name: forum_topic_followed forum_topic_followed_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forum_topic_followed
    ADD CONSTRAINT forum_topic_followed_pkey PRIMARY KEY (id);


--
-- Name: forum_topic_followed forum_topic_followed_topic_id_user_id_f1c7e3d5_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forum_topic_followed
    ADD CONSTRAINT forum_topic_followed_topic_id_user_id_f1c7e3d5_uniq UNIQUE (topic_id, user_id);


--
-- Name: forum_topic forum_topic_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forum_topic
    ADD CONSTRAINT forum_topic_pkey PRIMARY KEY (id);


--
-- Name: forum_topic_upvoted forum_topic_upvoted_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forum_topic_upvoted
    ADD CONSTRAINT forum_topic_upvoted_pkey PRIMARY KEY (id);


--
-- Name: forum_topic_upvoted forum_topic_upvoted_topic_id_user_id_a0c975c0_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forum_topic_upvoted
    ADD CONSTRAINT forum_topic_upvoted_topic_id_user_id_a0c975c0_uniq UNIQUE (topic_id, user_id);


--
-- Name: forum_topicrevision forum_topicrevision_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forum_topicrevision
    ADD CONSTRAINT forum_topicrevision_pkey PRIMARY KEY (id);


--
-- Name: forum_topicrevision forum_topicrevision_related_topic_id_revisio_ae061a67_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forum_topicrevision
    ADD CONSTRAINT forum_topicrevision_related_topic_id_revisio_ae061a67_uniq UNIQUE (related_topic_id, revision_number);


--
-- Name: account_user_groups_group_id_6c71f749; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX account_user_groups_group_id_6c71f749 ON public.account_user_groups USING btree (group_id);


--
-- Name: account_user_groups_user_id_14345e7b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX account_user_groups_user_id_14345e7b ON public.account_user_groups USING btree (user_id);


--
-- Name: account_user_groups_user_id_14345e7b_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX account_user_groups_user_id_14345e7b_like ON public.account_user_groups USING btree (user_id varchar_pattern_ops);


--
-- Name: account_user_id_c5b04240_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX account_user_id_c5b04240_like ON public.account_user USING btree (id varchar_pattern_ops);


--
-- Name: account_user_user_permissions_permission_id_66c44191; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX account_user_user_permissions_permission_id_66c44191 ON public.account_user_user_permissions USING btree (permission_id);


--
-- Name: account_user_user_permissions_user_id_cc42d270; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX account_user_user_permissions_user_id_cc42d270 ON public.account_user_user_permissions USING btree (user_id);


--
-- Name: account_user_user_permissions_user_id_cc42d270_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX account_user_user_permissions_user_id_cc42d270_like ON public.account_user_user_permissions USING btree (user_id varchar_pattern_ops);


--
-- Name: account_user_username_d393f583_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX account_user_username_d393f583_like ON public.account_user USING btree (username varchar_pattern_ops);


--
-- Name: account_userprofile_final_university_id_4c2bc7cf; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX account_userprofile_final_university_id_4c2bc7cf ON public.account_userprofile USING btree (final_university_id);


--
-- Name: account_userprofile_followed_from_userprofile_id_bfdb59c8; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX account_userprofile_followed_from_userprofile_id_bfdb59c8 ON public.account_userprofile_followed USING btree (from_userprofile_id);


--
-- Name: account_userprofile_followed_to_userprofile_id_0a37e8a4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX account_userprofile_followed_to_userprofile_id_0a37e8a4 ON public.account_userprofile_followed USING btree (to_userprofile_id);


--
-- Name: account_userprofile_related_user_id_26580f76_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX account_userprofile_related_user_id_26580f76_like ON public.account_userprofile USING btree (related_user_id varchar_pattern_ops);


--
-- Name: admissions_admissions_related_background_id_afc1bb18; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX admissions_admissions_related_background_id_afc1bb18 ON public.admissions_admissions USING btree (related_background_id);


--
-- Name: admissions_admissions_related_university_id_bd06c8f3; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX admissions_admissions_related_university_id_bd06c8f3 ON public.admissions_admissions USING btree (related_university_id);


--
-- Name: admissions_admissions_related_user_id_af971e32; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX admissions_admissions_related_user_id_af971e32 ON public.admissions_admissions USING btree (related_user_id);


--
-- Name: admissions_admissions_related_user_id_af971e32_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX admissions_admissions_related_user_id_af971e32_like ON public.admissions_admissions USING btree (related_user_id varchar_pattern_ops);


--
-- Name: admissions_admissions_upvoted_admissions_id_f283ddfe; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX admissions_admissions_upvoted_admissions_id_f283ddfe ON public.admissions_admissions_upvoted USING btree (admissions_id);


--
-- Name: admissions_admissions_upvoted_user_id_90ea1235; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX admissions_admissions_upvoted_user_id_90ea1235 ON public.admissions_admissions_upvoted USING btree (user_id);


--
-- Name: admissions_admissions_upvoted_user_id_90ea1235_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX admissions_admissions_upvoted_user_id_90ea1235_like ON public.admissions_admissions_upvoted USING btree (user_id varchar_pattern_ops);


--
-- Name: admissions_background_related_user_id_47fa25c4_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX admissions_background_related_user_id_47fa25c4_like ON public.admissions_background USING btree (related_user_id varchar_pattern_ops);


--
-- Name: admissions_background_upvoted_background_id_96f3c832; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX admissions_background_upvoted_background_id_96f3c832 ON public.admissions_background_upvoted USING btree (background_id);


--
-- Name: admissions_background_upvoted_user_id_14ba5953; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX admissions_background_upvoted_user_id_14ba5953 ON public.admissions_background_upvoted USING btree (user_id);


--
-- Name: admissions_background_upvoted_user_id_14ba5953_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX admissions_background_upvoted_user_id_14ba5953_like ON public.admissions_background_upvoted USING btree (user_id varchar_pattern_ops);


--
-- Name: admissions_program_related_university_id_9edcf70a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX admissions_program_related_university_id_9edcf70a ON public.admissions_program USING btree (related_university_id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_admin_log_user_id_c564eba6_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_user_id_c564eba6_like ON public.django_admin_log USING btree (user_id varchar_pattern_ops);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: forum_comment_related_comment_thread_id_513d1e47; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX forum_comment_related_comment_thread_id_513d1e47 ON public.forum_comment USING btree (related_comment_thread_id);


--
-- Name: forum_comment_related_user_id_d5133249; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX forum_comment_related_user_id_d5133249 ON public.forum_comment USING btree (related_user_id);


--
-- Name: forum_comment_related_user_id_d5133249_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX forum_comment_related_user_id_d5133249_like ON public.forum_comment USING btree (related_user_id varchar_pattern_ops);


--
-- Name: forum_comment_upvoted_comment_id_d6cd14fa; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX forum_comment_upvoted_comment_id_d6cd14fa ON public.forum_comment_upvoted USING btree (comment_id);


--
-- Name: forum_comment_upvoted_user_id_8f986020; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX forum_comment_upvoted_user_id_8f986020 ON public.forum_comment_upvoted USING btree (user_id);


--
-- Name: forum_comment_upvoted_user_id_8f986020_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX forum_comment_upvoted_user_id_8f986020_like ON public.forum_comment_upvoted USING btree (user_id varchar_pattern_ops);


--
-- Name: forum_commentthread_related_topic_id_316c5604; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX forum_commentthread_related_topic_id_316c5604 ON public.forum_commentthread USING btree (related_topic_id);


--
-- Name: forum_commentthread_related_user_id_bdc6bb16; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX forum_commentthread_related_user_id_bdc6bb16 ON public.forum_commentthread USING btree (related_user_id);


--
-- Name: forum_commentthread_related_user_id_bdc6bb16_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX forum_commentthread_related_user_id_bdc6bb16_like ON public.forum_commentthread USING btree (related_user_id varchar_pattern_ops);


--
-- Name: forum_commentthread_upvoted_commentthread_id_23c88a4f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX forum_commentthread_upvoted_commentthread_id_23c88a4f ON public.forum_commentthread_upvoted USING btree (commentthread_id);


--
-- Name: forum_commentthread_upvoted_user_id_6c67752f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX forum_commentthread_upvoted_user_id_6c67752f ON public.forum_commentthread_upvoted USING btree (user_id);


--
-- Name: forum_commentthread_upvoted_user_id_6c67752f_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX forum_commentthread_upvoted_user_id_6c67752f_like ON public.forum_commentthread_upvoted USING btree (user_id varchar_pattern_ops);


--
-- Name: forum_notification_related_user_id_9ca3827e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX forum_notification_related_user_id_9ca3827e ON public.forum_notification USING btree (related_user_id);


--
-- Name: forum_notification_related_user_id_9ca3827e_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX forum_notification_related_user_id_9ca3827e_like ON public.forum_notification USING btree (related_user_id varchar_pattern_ops);


--
-- Name: forum_topic_followed_topic_id_c4eb3fe4; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX forum_topic_followed_topic_id_c4eb3fe4 ON public.forum_topic_followed USING btree (topic_id);


--
-- Name: forum_topic_followed_user_id_3cf89024; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX forum_topic_followed_user_id_3cf89024 ON public.forum_topic_followed USING btree (user_id);


--
-- Name: forum_topic_followed_user_id_3cf89024_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX forum_topic_followed_user_id_3cf89024_like ON public.forum_topic_followed USING btree (user_id varchar_pattern_ops);


--
-- Name: forum_topic_group_id_ff89b624; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX forum_topic_group_id_ff89b624 ON public.forum_topic USING btree (group_id);


--
-- Name: forum_topic_upvoted_topic_id_9926f317; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX forum_topic_upvoted_topic_id_9926f317 ON public.forum_topic_upvoted USING btree (topic_id);


--
-- Name: forum_topic_upvoted_user_id_5fdfc441; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX forum_topic_upvoted_user_id_5fdfc441 ON public.forum_topic_upvoted USING btree (user_id);


--
-- Name: forum_topic_upvoted_user_id_5fdfc441_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX forum_topic_upvoted_user_id_5fdfc441_like ON public.forum_topic_upvoted USING btree (user_id varchar_pattern_ops);


--
-- Name: forum_topicrevision_related_topic_id_35003e0f; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX forum_topicrevision_related_topic_id_35003e0f ON public.forum_topicrevision USING btree (related_topic_id);


--
-- Name: forum_topicrevision_related_user_id_cb3216fe; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX forum_topicrevision_related_user_id_cb3216fe ON public.forum_topicrevision USING btree (related_user_id);


--
-- Name: forum_topicrevision_related_user_id_cb3216fe_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX forum_topicrevision_related_user_id_cb3216fe_like ON public.forum_topicrevision USING btree (related_user_id varchar_pattern_ops);


--
-- Name: account_user_groups account_user_groups_group_id_6c71f749_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_user_groups
    ADD CONSTRAINT account_user_groups_group_id_6c71f749_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: account_user_groups account_user_groups_user_id_14345e7b_fk_account_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_user_groups
    ADD CONSTRAINT account_user_groups_user_id_14345e7b_fk_account_user_id FOREIGN KEY (user_id) REFERENCES public.account_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: account_user_user_permissions account_user_user_pe_permission_id_66c44191_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_user_user_permissions
    ADD CONSTRAINT account_user_user_pe_permission_id_66c44191_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: account_user_user_permissions account_user_user_pe_user_id_cc42d270_fk_account_u; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_user_user_permissions
    ADD CONSTRAINT account_user_user_pe_user_id_cc42d270_fk_account_u FOREIGN KEY (user_id) REFERENCES public.account_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: account_userprofile_followed account_userprofile__from_userprofile_id_bfdb59c8_fk_account_u; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_userprofile_followed
    ADD CONSTRAINT account_userprofile__from_userprofile_id_bfdb59c8_fk_account_u FOREIGN KEY (from_userprofile_id) REFERENCES public.account_userprofile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: account_userprofile_followed account_userprofile__to_userprofile_id_0a37e8a4_fk_account_u; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_userprofile_followed
    ADD CONSTRAINT account_userprofile__to_userprofile_id_0a37e8a4_fk_account_u FOREIGN KEY (to_userprofile_id) REFERENCES public.account_userprofile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: account_userprofile account_userprofile_final_university_id_4c2bc7cf_fk_admission; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_userprofile
    ADD CONSTRAINT account_userprofile_final_university_id_4c2bc7cf_fk_admission FOREIGN KEY (final_university_id) REFERENCES public.admissions_university(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: account_userprofile account_userprofile_related_user_id_26580f76_fk_account_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_userprofile
    ADD CONSTRAINT account_userprofile_related_user_id_26580f76_fk_account_user_id FOREIGN KEY (related_user_id) REFERENCES public.account_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: admissions_admissions_upvoted admissions_admission_admissions_id_f283ddfe_fk_admission; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admissions_admissions_upvoted
    ADD CONSTRAINT admissions_admission_admissions_id_f283ddfe_fk_admission FOREIGN KEY (admissions_id) REFERENCES public.admissions_admissions(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: admissions_admissions admissions_admission_related_background_i_afc1bb18_fk_admission; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admissions_admissions
    ADD CONSTRAINT admissions_admission_related_background_i_afc1bb18_fk_admission FOREIGN KEY (related_background_id) REFERENCES public.admissions_background(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: admissions_admissions admissions_admission_related_university_i_bd06c8f3_fk_admission; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admissions_admissions
    ADD CONSTRAINT admissions_admission_related_university_i_bd06c8f3_fk_admission FOREIGN KEY (related_university_id) REFERENCES public.admissions_university(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: admissions_admissions admissions_admission_related_user_id_af971e32_fk_account_u; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admissions_admissions
    ADD CONSTRAINT admissions_admission_related_user_id_af971e32_fk_account_u FOREIGN KEY (related_user_id) REFERENCES public.account_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: admissions_admissions_upvoted admissions_admission_user_id_90ea1235_fk_account_u; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admissions_admissions_upvoted
    ADD CONSTRAINT admissions_admission_user_id_90ea1235_fk_account_u FOREIGN KEY (user_id) REFERENCES public.account_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: admissions_background_upvoted admissions_backgroun_background_id_96f3c832_fk_admission; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admissions_background_upvoted
    ADD CONSTRAINT admissions_backgroun_background_id_96f3c832_fk_admission FOREIGN KEY (background_id) REFERENCES public.admissions_background(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: admissions_background admissions_backgroun_related_user_id_47fa25c4_fk_account_u; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admissions_background
    ADD CONSTRAINT admissions_backgroun_related_user_id_47fa25c4_fk_account_u FOREIGN KEY (related_user_id) REFERENCES public.account_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: admissions_background_upvoted admissions_backgroun_user_id_14ba5953_fk_account_u; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admissions_background_upvoted
    ADD CONSTRAINT admissions_backgroun_user_id_14ba5953_fk_account_u FOREIGN KEY (user_id) REFERENCES public.account_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: admissions_program admissions_program_related_university_i_9edcf70a_fk_admission; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admissions_program
    ADD CONSTRAINT admissions_program_related_university_i_9edcf70a_fk_admission FOREIGN KEY (related_university_id) REFERENCES public.admissions_university(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_account_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_account_user_id FOREIGN KEY (user_id) REFERENCES public.account_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: forum_comment forum_comment_related_comment_thre_513d1e47_fk_forum_com; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forum_comment
    ADD CONSTRAINT forum_comment_related_comment_thre_513d1e47_fk_forum_com FOREIGN KEY (related_comment_thread_id) REFERENCES public.forum_commentthread(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: forum_comment forum_comment_related_user_id_d5133249_fk_account_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forum_comment
    ADD CONSTRAINT forum_comment_related_user_id_d5133249_fk_account_user_id FOREIGN KEY (related_user_id) REFERENCES public.account_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: forum_comment_upvoted forum_comment_upvoted_comment_id_d6cd14fa_fk_forum_comment_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forum_comment_upvoted
    ADD CONSTRAINT forum_comment_upvoted_comment_id_d6cd14fa_fk_forum_comment_id FOREIGN KEY (comment_id) REFERENCES public.forum_comment(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: forum_comment_upvoted forum_comment_upvoted_user_id_8f986020_fk_account_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forum_comment_upvoted
    ADD CONSTRAINT forum_comment_upvoted_user_id_8f986020_fk_account_user_id FOREIGN KEY (user_id) REFERENCES public.account_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: forum_commentthread_upvoted forum_commentthread__commentthread_id_23c88a4f_fk_forum_com; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forum_commentthread_upvoted
    ADD CONSTRAINT forum_commentthread__commentthread_id_23c88a4f_fk_forum_com FOREIGN KEY (commentthread_id) REFERENCES public.forum_commentthread(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: forum_commentthread forum_commentthread_related_topic_id_316c5604_fk_forum_topic_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forum_commentthread
    ADD CONSTRAINT forum_commentthread_related_topic_id_316c5604_fk_forum_topic_id FOREIGN KEY (related_topic_id) REFERENCES public.forum_topic(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: forum_commentthread forum_commentthread_related_user_id_bdc6bb16_fk_account_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forum_commentthread
    ADD CONSTRAINT forum_commentthread_related_user_id_bdc6bb16_fk_account_user_id FOREIGN KEY (related_user_id) REFERENCES public.account_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: forum_commentthread_upvoted forum_commentthread_upvoted_user_id_6c67752f_fk_account_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forum_commentthread_upvoted
    ADD CONSTRAINT forum_commentthread_upvoted_user_id_6c67752f_fk_account_user_id FOREIGN KEY (user_id) REFERENCES public.account_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: forum_notification forum_notification_related_user_id_9ca3827e_fk_account_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forum_notification
    ADD CONSTRAINT forum_notification_related_user_id_9ca3827e_fk_account_user_id FOREIGN KEY (related_user_id) REFERENCES public.account_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: forum_topic forum_topic_current_version_id_a1fa34f8_fk_forum_top; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forum_topic
    ADD CONSTRAINT forum_topic_current_version_id_a1fa34f8_fk_forum_top FOREIGN KEY (current_version_id) REFERENCES public.forum_topicrevision(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: forum_topic_followed forum_topic_followed_topic_id_c4eb3fe4_fk_forum_topic_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forum_topic_followed
    ADD CONSTRAINT forum_topic_followed_topic_id_c4eb3fe4_fk_forum_topic_id FOREIGN KEY (topic_id) REFERENCES public.forum_topic(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: forum_topic_followed forum_topic_followed_user_id_3cf89024_fk_account_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forum_topic_followed
    ADD CONSTRAINT forum_topic_followed_user_id_3cf89024_fk_account_user_id FOREIGN KEY (user_id) REFERENCES public.account_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: forum_topic forum_topic_group_id_ff89b624_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forum_topic
    ADD CONSTRAINT forum_topic_group_id_ff89b624_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: forum_topic_upvoted forum_topic_upvoted_topic_id_9926f317_fk_forum_topic_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forum_topic_upvoted
    ADD CONSTRAINT forum_topic_upvoted_topic_id_9926f317_fk_forum_topic_id FOREIGN KEY (topic_id) REFERENCES public.forum_topic(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: forum_topic_upvoted forum_topic_upvoted_user_id_5fdfc441_fk_account_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forum_topic_upvoted
    ADD CONSTRAINT forum_topic_upvoted_user_id_5fdfc441_fk_account_user_id FOREIGN KEY (user_id) REFERENCES public.account_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: forum_topicrevision forum_topicrevision_related_topic_id_35003e0f_fk_forum_topic_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forum_topicrevision
    ADD CONSTRAINT forum_topicrevision_related_topic_id_35003e0f_fk_forum_topic_id FOREIGN KEY (related_topic_id) REFERENCES public.forum_topic(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: forum_topicrevision forum_topicrevision_related_user_id_cb3216fe_fk_account_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forum_topicrevision
    ADD CONSTRAINT forum_topicrevision_related_user_id_cb3216fe_fk_account_user_id FOREIGN KEY (related_user_id) REFERENCES public.account_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

