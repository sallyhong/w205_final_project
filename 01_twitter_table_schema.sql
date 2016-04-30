--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.2
-- Dumped by pg_dump version 9.5.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: twitter; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE twitter (
    tweet character varying(255),
    created_at timestamp without time zone,
    favorite_count integer,
    favorited boolean,
    filter_level character varying(255),
    id_str character varying(255),
    lang character varying(255),
    retweet_count integer,
    retweeted boolean,
    source character varying(255),
    timestamp_ms character varying(255),
    truncated boolean,
    user_description character varying(255),
    user_favourites_count integer,
    user_followers_count integer,
    user_friends_count integer,
    user_id_str character varying(255),
    user_location character varying(255),
    user_name character varying(255),
    user_profile_image_url character varying(255),
    user_screen_name character varying(255),
    user_statuses_count integer,
    user_time_zone character varying(255),
    hashtags character varying(255),
    urls character varying(255),
    user_timezone_country character varying(255),
    polarity double precision,
    sentiment character varying(255)
);


ALTER TABLE twitter OWNER TO postgres;

--
-- PostgreSQL database dump complete
--

