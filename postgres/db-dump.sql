--
-- PostgreSQL database dump
--

-- Dumped from database version 14.2 (Debian 14.2-1.pgdg110+1)
-- Dumped by pg_dump version 14.2 (Debian 14.2-1.pgdg110+1)

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
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


--
-- Name: client; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    value character varying(4000),
    name character varying(255) NOT NULL
);


--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


--
-- Name: client_session; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


--
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


--
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


--
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


--
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


--
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


--
-- Name: component; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


--
-- Name: component_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(4000)
);


--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


--
-- Name: credential; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255)
);


--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024)
);


--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36)
);


--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL
);


--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL
);


--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


--
-- Name: realm; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode character varying(15) NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy character varying(20),
    logic character varying(20),
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL
);


--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


--
-- Name: user_session; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


--
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
0fea02a8-1a54-4be0-afd1-3a979e82b2a0	\N	auth-cookie	master	d45c6ea2-a4c2-45b4-9985-d49fdf4f77a3	2	10	f	\N	\N
b2bb28ca-da6f-496a-9937-acf9f5ec7ddd	\N	auth-spnego	master	d45c6ea2-a4c2-45b4-9985-d49fdf4f77a3	3	20	f	\N	\N
ac7835b8-83b4-43aa-8b42-991259f03868	\N	identity-provider-redirector	master	d45c6ea2-a4c2-45b4-9985-d49fdf4f77a3	2	25	f	\N	\N
c0791c14-86a3-49fc-9bf8-d4d54c8f6b0d	\N	\N	master	d45c6ea2-a4c2-45b4-9985-d49fdf4f77a3	2	30	t	6280b903-5008-45d1-9c2c-058d5ee7a483	\N
f53b9d40-c241-4b81-9738-46926313dbcd	\N	auth-username-password-form	master	6280b903-5008-45d1-9c2c-058d5ee7a483	0	10	f	\N	\N
32bad694-1d15-4491-adc2-e752215c9700	\N	\N	master	6280b903-5008-45d1-9c2c-058d5ee7a483	1	20	t	75471aa9-df2d-4795-9f6f-7eda530d0c60	\N
10b8fa48-6a9e-4f54-a3bb-c1a37654a251	\N	conditional-user-configured	master	75471aa9-df2d-4795-9f6f-7eda530d0c60	0	10	f	\N	\N
b4c05703-b457-41a0-8e17-e64d0f318aac	\N	auth-otp-form	master	75471aa9-df2d-4795-9f6f-7eda530d0c60	0	20	f	\N	\N
19cc866c-7b4d-4a17-a627-8b909ab8b3cd	\N	direct-grant-validate-username	master	067fafa8-30af-4821-b005-5e6cc7455bb1	0	10	f	\N	\N
0e57e92b-0518-4b9a-bc9d-ff73d6fcb876	\N	direct-grant-validate-password	master	067fafa8-30af-4821-b005-5e6cc7455bb1	0	20	f	\N	\N
20a3cee2-f3ed-485a-bc46-7a782f8edc11	\N	\N	master	067fafa8-30af-4821-b005-5e6cc7455bb1	1	30	t	78057754-56ce-4d29-b6bb-33a32215c792	\N
e9cd7ba3-48bb-4396-b1c0-a679518d3b9f	\N	conditional-user-configured	master	78057754-56ce-4d29-b6bb-33a32215c792	0	10	f	\N	\N
12904227-c46d-472b-80b1-d20194b44cb8	\N	direct-grant-validate-otp	master	78057754-56ce-4d29-b6bb-33a32215c792	0	20	f	\N	\N
eace36be-60dd-43c0-b4c9-e372884799c7	\N	registration-page-form	master	62c824b6-212c-41a3-907a-59aabdfc38a7	0	10	t	929993a9-07c3-4936-973d-5b1ce7bc950f	\N
3c19e897-1715-44d8-b94e-047258664f31	\N	registration-user-creation	master	929993a9-07c3-4936-973d-5b1ce7bc950f	0	20	f	\N	\N
fe3c8a2a-ab2e-459b-ad04-43babef77f79	\N	registration-profile-action	master	929993a9-07c3-4936-973d-5b1ce7bc950f	0	40	f	\N	\N
b2c2e725-36ce-4c3c-93ab-b8d42f24640c	\N	registration-password-action	master	929993a9-07c3-4936-973d-5b1ce7bc950f	0	50	f	\N	\N
8d1d73b0-f7ba-4355-b598-ea14d95b9061	\N	registration-recaptcha-action	master	929993a9-07c3-4936-973d-5b1ce7bc950f	3	60	f	\N	\N
5b8a9b12-ee96-4f8d-90ff-4d8e0bcc092e	\N	reset-credentials-choose-user	master	4d294674-b890-4e5b-85b1-131c9bac093f	0	10	f	\N	\N
fb61f233-126a-450e-87cc-028891649ce4	\N	reset-credential-email	master	4d294674-b890-4e5b-85b1-131c9bac093f	0	20	f	\N	\N
3786362d-1578-4027-9cb4-383601c48ab1	\N	reset-password	master	4d294674-b890-4e5b-85b1-131c9bac093f	0	30	f	\N	\N
2b53980b-cc03-47cd-b12b-ca7d6cb3c9f5	\N	\N	master	4d294674-b890-4e5b-85b1-131c9bac093f	1	40	t	6fc159fa-b7b4-4720-a65e-ca6dd78c9088	\N
5633802a-11b9-46f6-967c-48d7673355ef	\N	conditional-user-configured	master	6fc159fa-b7b4-4720-a65e-ca6dd78c9088	0	10	f	\N	\N
757a4c3c-f0f4-4854-9bce-a5a13e73342d	\N	reset-otp	master	6fc159fa-b7b4-4720-a65e-ca6dd78c9088	0	20	f	\N	\N
8336c08b-48ba-436f-a508-7009ee591cfd	\N	client-secret	master	3eba3d3a-435a-41d7-a597-b69d36f3d00a	2	10	f	\N	\N
84fa46d0-4bda-42a9-a1a0-98ec5b875123	\N	client-jwt	master	3eba3d3a-435a-41d7-a597-b69d36f3d00a	2	20	f	\N	\N
ccfc1b80-513d-4c7a-950e-8723ac57bff2	\N	client-secret-jwt	master	3eba3d3a-435a-41d7-a597-b69d36f3d00a	2	30	f	\N	\N
9e22a70f-8f26-4826-aebf-c1f5fa20dbe1	\N	client-x509	master	3eba3d3a-435a-41d7-a597-b69d36f3d00a	2	40	f	\N	\N
7d920230-7b31-4d62-adde-c8c3f755ede5	\N	idp-review-profile	master	00c537c9-6ea3-43ff-934b-b4c81c6f89d1	0	10	f	\N	4cfc873e-04e3-42a5-9a64-66f1a2f20804
df86edb5-cd7a-4d21-b908-79b853aa8380	\N	\N	master	00c537c9-6ea3-43ff-934b-b4c81c6f89d1	0	20	t	c6d7da66-1e55-41e9-a97f-1be21966d70e	\N
abf5e4a8-9ade-44f8-89b3-08a818cd96da	\N	idp-create-user-if-unique	master	c6d7da66-1e55-41e9-a97f-1be21966d70e	2	10	f	\N	9fba46ba-35c1-4d35-ba53-ca91bc4e8c5e
40d26f56-d886-4ee3-a815-1bb586f0aa15	\N	\N	master	c6d7da66-1e55-41e9-a97f-1be21966d70e	2	20	t	c106e329-4089-4979-a12e-8009d32827fb	\N
5954ad2f-2d17-4892-8901-c507e3f5eb00	\N	idp-confirm-link	master	c106e329-4089-4979-a12e-8009d32827fb	0	10	f	\N	\N
f37999d5-7c82-4fff-8618-336dfa551a5e	\N	\N	master	c106e329-4089-4979-a12e-8009d32827fb	0	20	t	8a412c15-5945-4d5f-b700-fca90a2a63fe	\N
3ec55c33-0e5a-42fc-8050-a91a587c3ceb	\N	idp-email-verification	master	8a412c15-5945-4d5f-b700-fca90a2a63fe	2	10	f	\N	\N
59d16a69-09ab-457c-b370-cda0b49bfd50	\N	\N	master	8a412c15-5945-4d5f-b700-fca90a2a63fe	2	20	t	9cf8e708-39d3-44fd-98a8-2c9754377159	\N
6e814906-98de-4ed6-bc50-85148c6a6623	\N	idp-username-password-form	master	9cf8e708-39d3-44fd-98a8-2c9754377159	0	10	f	\N	\N
f043ecf2-3d42-4f41-8f32-eb453c127383	\N	\N	master	9cf8e708-39d3-44fd-98a8-2c9754377159	1	20	t	c7fc7199-1c41-499c-a3bb-7de66f2032b3	\N
b3823000-bf4e-4b7a-96ec-fc11164460fb	\N	conditional-user-configured	master	c7fc7199-1c41-499c-a3bb-7de66f2032b3	0	10	f	\N	\N
1b11ae0a-eaef-4fa3-ba25-9bf6b6affc2b	\N	auth-otp-form	master	c7fc7199-1c41-499c-a3bb-7de66f2032b3	0	20	f	\N	\N
8f163145-b2ed-4332-8d96-105730d569e9	\N	http-basic-authenticator	master	4c0dd171-d2c0-4847-a652-4e76b43d40d8	0	10	f	\N	\N
7acb931c-6329-482f-8f36-bc5822093208	\N	docker-http-basic-authenticator	master	757ddd25-64ef-4f2d-9bc4-27bff84dc42e	0	10	f	\N	\N
09f061ba-933d-42a1-816e-ae3570f15a96	\N	no-cookie-redirect	master	d760c452-c2f1-4dcb-90f2-fe3253b2babf	0	10	f	\N	\N
07c773ba-f355-4c47-9957-7d5d27935e4b	\N	\N	master	d760c452-c2f1-4dcb-90f2-fe3253b2babf	0	20	t	3ec18894-9470-4f9b-921d-84d93506f424	\N
4f927d2d-42c3-4c6f-a32f-18e6e534503d	\N	basic-auth	master	3ec18894-9470-4f9b-921d-84d93506f424	0	10	f	\N	\N
90487866-5c69-4ec7-aaeb-63b40b3d1ef4	\N	basic-auth-otp	master	3ec18894-9470-4f9b-921d-84d93506f424	3	20	f	\N	\N
dcb785d1-4c8f-48f3-9f56-2986825da6ae	\N	auth-spnego	master	3ec18894-9470-4f9b-921d-84d93506f424	3	30	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
d45c6ea2-a4c2-45b4-9985-d49fdf4f77a3	browser	browser based authentication	master	basic-flow	t	t
6280b903-5008-45d1-9c2c-058d5ee7a483	forms	Username, password, otp and other auth forms.	master	basic-flow	f	t
75471aa9-df2d-4795-9f6f-7eda530d0c60	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
067fafa8-30af-4821-b005-5e6cc7455bb1	direct grant	OpenID Connect Resource Owner Grant	master	basic-flow	t	t
78057754-56ce-4d29-b6bb-33a32215c792	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
62c824b6-212c-41a3-907a-59aabdfc38a7	registration	registration flow	master	basic-flow	t	t
929993a9-07c3-4936-973d-5b1ce7bc950f	registration form	registration form	master	form-flow	f	t
4d294674-b890-4e5b-85b1-131c9bac093f	reset credentials	Reset credentials for a user if they forgot their password or something	master	basic-flow	t	t
6fc159fa-b7b4-4720-a65e-ca6dd78c9088	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	master	basic-flow	f	t
3eba3d3a-435a-41d7-a597-b69d36f3d00a	clients	Base authentication for clients	master	client-flow	t	t
00c537c9-6ea3-43ff-934b-b4c81c6f89d1	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	master	basic-flow	t	t
c6d7da66-1e55-41e9-a97f-1be21966d70e	User creation or linking	Flow for the existing/non-existing user alternatives	master	basic-flow	f	t
c106e329-4089-4979-a12e-8009d32827fb	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	master	basic-flow	f	t
8a412c15-5945-4d5f-b700-fca90a2a63fe	Account verification options	Method with which to verity the existing account	master	basic-flow	f	t
9cf8e708-39d3-44fd-98a8-2c9754377159	Verify Existing Account by Re-authentication	Reauthentication of existing account	master	basic-flow	f	t
c7fc7199-1c41-499c-a3bb-7de66f2032b3	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
4c0dd171-d2c0-4847-a652-4e76b43d40d8	saml ecp	SAML ECP Profile Authentication Flow	master	basic-flow	t	t
757ddd25-64ef-4f2d-9bc4-27bff84dc42e	docker auth	Used by Docker clients to authenticate against the IDP	master	basic-flow	t	t
d760c452-c2f1-4dcb-90f2-fe3253b2babf	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	master	basic-flow	t	t
3ec18894-9470-4f9b-921d-84d93506f424	Authentication Options	Authentication options.	master	basic-flow	f	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
4cfc873e-04e3-42a5-9a64-66f1a2f20804	review profile config	master
9fba46ba-35c1-4d35-ba53-ca91bc4e8c5e	create unique user config	master
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
4cfc873e-04e3-42a5-9a64-66f1a2f20804	missing	update.profile.on.first.login
9fba46ba-35c1-4d35-ba53-ca91bc4e8c5e	false	require.password.update.after.registration
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
abd43275-b8e2-46a1-82ef-7ab5f190791b	t	f	master-realm	0	f	\N	\N	t	\N	f	master	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
e107f0b2-639f-4168-a5ac-2939cb6fec9d	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	master	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
7aace810-2788-4d92-b0a5-32277701a059	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	master	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
e92bb830-4149-4146-95ec-32367a414170	t	f	broker	0	f	\N	\N	t	\N	f	master	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
fadb8b8b-105a-4891-83e1-330b7a900ce4	t	f	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	master	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
b46a317c-1e54-4b90-8149-b53e59d4b600	t	f	admin-cli	0	t	\N	\N	f	\N	f	master	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
cac2492c-7a21-4b8a-b7d8-4c9e38afc58d	t	t	hobby_bff	0	t	\N	\N	f	\N	f	master	openid-connect	-1	f	f	\N	f	client-secret	\N	\N	\N	t	f	t	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_attributes (client_id, value, name) FROM stdin;
7aace810-2788-4d92-b0a5-32277701a059	S256	pkce.code.challenge.method
fadb8b8b-105a-4891-83e1-330b7a900ce4	S256	pkce.code.challenge.method
cac2492c-7a21-4b8a-b7d8-4c9e38afc58d	true	backchannel.logout.session.required
cac2492c-7a21-4b8a-b7d8-4c9e38afc58d	false	backchannel.logout.revoke.offline.tokens
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
28538276-848e-4fa9-a9ed-2d46016a23a2	offline_access	master	OpenID Connect built-in scope: offline_access	openid-connect
987defe6-55bf-4c82-8d26-242bcadef052	role_list	master	SAML role list	saml
9312b4f1-657b-472f-b5c8-b2f3e6d9e6d3	profile	master	OpenID Connect built-in scope: profile	openid-connect
c8a45fe5-4f62-43ae-a539-6cda8c9981bd	email	master	OpenID Connect built-in scope: email	openid-connect
688b7dd6-22f0-4a3e-af32-9903536208ba	address	master	OpenID Connect built-in scope: address	openid-connect
41d2f0a1-20c3-4ecc-9c46-05fff6e2b9de	phone	master	OpenID Connect built-in scope: phone	openid-connect
262d9cce-9b78-4308-bbc4-732f9aa5b659	roles	master	OpenID Connect scope for add user roles to the access token	openid-connect
099b2eeb-c833-4ddd-8983-48b1d08e98b5	web-origins	master	OpenID Connect scope for add allowed web origins to the access token	openid-connect
f311c685-d4df-4b3e-ab4c-1974f58f1357	microprofile-jwt	master	Microprofile - JWT built-in scope	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
28538276-848e-4fa9-a9ed-2d46016a23a2	true	display.on.consent.screen
28538276-848e-4fa9-a9ed-2d46016a23a2	${offlineAccessScopeConsentText}	consent.screen.text
987defe6-55bf-4c82-8d26-242bcadef052	true	display.on.consent.screen
987defe6-55bf-4c82-8d26-242bcadef052	${samlRoleListScopeConsentText}	consent.screen.text
9312b4f1-657b-472f-b5c8-b2f3e6d9e6d3	true	display.on.consent.screen
9312b4f1-657b-472f-b5c8-b2f3e6d9e6d3	${profileScopeConsentText}	consent.screen.text
9312b4f1-657b-472f-b5c8-b2f3e6d9e6d3	true	include.in.token.scope
c8a45fe5-4f62-43ae-a539-6cda8c9981bd	true	display.on.consent.screen
c8a45fe5-4f62-43ae-a539-6cda8c9981bd	${emailScopeConsentText}	consent.screen.text
c8a45fe5-4f62-43ae-a539-6cda8c9981bd	true	include.in.token.scope
688b7dd6-22f0-4a3e-af32-9903536208ba	true	display.on.consent.screen
688b7dd6-22f0-4a3e-af32-9903536208ba	${addressScopeConsentText}	consent.screen.text
688b7dd6-22f0-4a3e-af32-9903536208ba	true	include.in.token.scope
41d2f0a1-20c3-4ecc-9c46-05fff6e2b9de	true	display.on.consent.screen
41d2f0a1-20c3-4ecc-9c46-05fff6e2b9de	${phoneScopeConsentText}	consent.screen.text
41d2f0a1-20c3-4ecc-9c46-05fff6e2b9de	true	include.in.token.scope
262d9cce-9b78-4308-bbc4-732f9aa5b659	true	display.on.consent.screen
262d9cce-9b78-4308-bbc4-732f9aa5b659	${rolesScopeConsentText}	consent.screen.text
262d9cce-9b78-4308-bbc4-732f9aa5b659	false	include.in.token.scope
099b2eeb-c833-4ddd-8983-48b1d08e98b5	false	display.on.consent.screen
099b2eeb-c833-4ddd-8983-48b1d08e98b5		consent.screen.text
099b2eeb-c833-4ddd-8983-48b1d08e98b5	false	include.in.token.scope
f311c685-d4df-4b3e-ab4c-1974f58f1357	false	display.on.consent.screen
f311c685-d4df-4b3e-ab4c-1974f58f1357	true	include.in.token.scope
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
e107f0b2-639f-4168-a5ac-2939cb6fec9d	9312b4f1-657b-472f-b5c8-b2f3e6d9e6d3	t
e107f0b2-639f-4168-a5ac-2939cb6fec9d	c8a45fe5-4f62-43ae-a539-6cda8c9981bd	t
e107f0b2-639f-4168-a5ac-2939cb6fec9d	099b2eeb-c833-4ddd-8983-48b1d08e98b5	t
e107f0b2-639f-4168-a5ac-2939cb6fec9d	262d9cce-9b78-4308-bbc4-732f9aa5b659	t
e107f0b2-639f-4168-a5ac-2939cb6fec9d	688b7dd6-22f0-4a3e-af32-9903536208ba	f
e107f0b2-639f-4168-a5ac-2939cb6fec9d	f311c685-d4df-4b3e-ab4c-1974f58f1357	f
e107f0b2-639f-4168-a5ac-2939cb6fec9d	41d2f0a1-20c3-4ecc-9c46-05fff6e2b9de	f
e107f0b2-639f-4168-a5ac-2939cb6fec9d	28538276-848e-4fa9-a9ed-2d46016a23a2	f
7aace810-2788-4d92-b0a5-32277701a059	9312b4f1-657b-472f-b5c8-b2f3e6d9e6d3	t
7aace810-2788-4d92-b0a5-32277701a059	c8a45fe5-4f62-43ae-a539-6cda8c9981bd	t
7aace810-2788-4d92-b0a5-32277701a059	099b2eeb-c833-4ddd-8983-48b1d08e98b5	t
7aace810-2788-4d92-b0a5-32277701a059	262d9cce-9b78-4308-bbc4-732f9aa5b659	t
7aace810-2788-4d92-b0a5-32277701a059	688b7dd6-22f0-4a3e-af32-9903536208ba	f
7aace810-2788-4d92-b0a5-32277701a059	f311c685-d4df-4b3e-ab4c-1974f58f1357	f
7aace810-2788-4d92-b0a5-32277701a059	41d2f0a1-20c3-4ecc-9c46-05fff6e2b9de	f
7aace810-2788-4d92-b0a5-32277701a059	28538276-848e-4fa9-a9ed-2d46016a23a2	f
b46a317c-1e54-4b90-8149-b53e59d4b600	9312b4f1-657b-472f-b5c8-b2f3e6d9e6d3	t
b46a317c-1e54-4b90-8149-b53e59d4b600	c8a45fe5-4f62-43ae-a539-6cda8c9981bd	t
b46a317c-1e54-4b90-8149-b53e59d4b600	099b2eeb-c833-4ddd-8983-48b1d08e98b5	t
b46a317c-1e54-4b90-8149-b53e59d4b600	262d9cce-9b78-4308-bbc4-732f9aa5b659	t
b46a317c-1e54-4b90-8149-b53e59d4b600	688b7dd6-22f0-4a3e-af32-9903536208ba	f
b46a317c-1e54-4b90-8149-b53e59d4b600	f311c685-d4df-4b3e-ab4c-1974f58f1357	f
b46a317c-1e54-4b90-8149-b53e59d4b600	41d2f0a1-20c3-4ecc-9c46-05fff6e2b9de	f
b46a317c-1e54-4b90-8149-b53e59d4b600	28538276-848e-4fa9-a9ed-2d46016a23a2	f
e92bb830-4149-4146-95ec-32367a414170	9312b4f1-657b-472f-b5c8-b2f3e6d9e6d3	t
e92bb830-4149-4146-95ec-32367a414170	c8a45fe5-4f62-43ae-a539-6cda8c9981bd	t
e92bb830-4149-4146-95ec-32367a414170	099b2eeb-c833-4ddd-8983-48b1d08e98b5	t
e92bb830-4149-4146-95ec-32367a414170	262d9cce-9b78-4308-bbc4-732f9aa5b659	t
e92bb830-4149-4146-95ec-32367a414170	688b7dd6-22f0-4a3e-af32-9903536208ba	f
e92bb830-4149-4146-95ec-32367a414170	f311c685-d4df-4b3e-ab4c-1974f58f1357	f
e92bb830-4149-4146-95ec-32367a414170	41d2f0a1-20c3-4ecc-9c46-05fff6e2b9de	f
e92bb830-4149-4146-95ec-32367a414170	28538276-848e-4fa9-a9ed-2d46016a23a2	f
abd43275-b8e2-46a1-82ef-7ab5f190791b	9312b4f1-657b-472f-b5c8-b2f3e6d9e6d3	t
abd43275-b8e2-46a1-82ef-7ab5f190791b	c8a45fe5-4f62-43ae-a539-6cda8c9981bd	t
abd43275-b8e2-46a1-82ef-7ab5f190791b	099b2eeb-c833-4ddd-8983-48b1d08e98b5	t
abd43275-b8e2-46a1-82ef-7ab5f190791b	262d9cce-9b78-4308-bbc4-732f9aa5b659	t
abd43275-b8e2-46a1-82ef-7ab5f190791b	688b7dd6-22f0-4a3e-af32-9903536208ba	f
abd43275-b8e2-46a1-82ef-7ab5f190791b	f311c685-d4df-4b3e-ab4c-1974f58f1357	f
abd43275-b8e2-46a1-82ef-7ab5f190791b	41d2f0a1-20c3-4ecc-9c46-05fff6e2b9de	f
abd43275-b8e2-46a1-82ef-7ab5f190791b	28538276-848e-4fa9-a9ed-2d46016a23a2	f
fadb8b8b-105a-4891-83e1-330b7a900ce4	9312b4f1-657b-472f-b5c8-b2f3e6d9e6d3	t
fadb8b8b-105a-4891-83e1-330b7a900ce4	c8a45fe5-4f62-43ae-a539-6cda8c9981bd	t
fadb8b8b-105a-4891-83e1-330b7a900ce4	099b2eeb-c833-4ddd-8983-48b1d08e98b5	t
fadb8b8b-105a-4891-83e1-330b7a900ce4	262d9cce-9b78-4308-bbc4-732f9aa5b659	t
fadb8b8b-105a-4891-83e1-330b7a900ce4	688b7dd6-22f0-4a3e-af32-9903536208ba	f
fadb8b8b-105a-4891-83e1-330b7a900ce4	f311c685-d4df-4b3e-ab4c-1974f58f1357	f
fadb8b8b-105a-4891-83e1-330b7a900ce4	41d2f0a1-20c3-4ecc-9c46-05fff6e2b9de	f
fadb8b8b-105a-4891-83e1-330b7a900ce4	28538276-848e-4fa9-a9ed-2d46016a23a2	f
cac2492c-7a21-4b8a-b7d8-4c9e38afc58d	9312b4f1-657b-472f-b5c8-b2f3e6d9e6d3	t
cac2492c-7a21-4b8a-b7d8-4c9e38afc58d	c8a45fe5-4f62-43ae-a539-6cda8c9981bd	t
cac2492c-7a21-4b8a-b7d8-4c9e38afc58d	099b2eeb-c833-4ddd-8983-48b1d08e98b5	t
cac2492c-7a21-4b8a-b7d8-4c9e38afc58d	262d9cce-9b78-4308-bbc4-732f9aa5b659	t
cac2492c-7a21-4b8a-b7d8-4c9e38afc58d	688b7dd6-22f0-4a3e-af32-9903536208ba	f
cac2492c-7a21-4b8a-b7d8-4c9e38afc58d	f311c685-d4df-4b3e-ab4c-1974f58f1357	f
cac2492c-7a21-4b8a-b7d8-4c9e38afc58d	41d2f0a1-20c3-4ecc-9c46-05fff6e2b9de	f
cac2492c-7a21-4b8a-b7d8-4c9e38afc58d	28538276-848e-4fa9-a9ed-2d46016a23a2	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
28538276-848e-4fa9-a9ed-2d46016a23a2	45caa9b3-9b15-4e28-abf4-a1065d04d94d
\.


--
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_session_role (role_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
24973f8c-a86d-4bbd-86f8-db9305f4510b	Trusted Hosts	master	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
49ef7488-9f15-4265-94db-fb61e622f58e	Consent Required	master	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
4cffd63a-d1a1-49c2-a24e-f636d8811063	Full Scope Disabled	master	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
0aa1e9b8-28ca-4fad-90ed-e09725c9ce84	Max Clients Limit	master	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
ec7ba164-98dc-42b6-90b2-75225af107ab	Allowed Protocol Mapper Types	master	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
5d169512-851d-4cc0-9783-439e53286c45	Allowed Client Scopes	master	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
44ca3d03-7d96-460a-b37f-2e7a8fe6ceb8	Allowed Protocol Mapper Types	master	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	authenticated
3259d1a9-5d27-4f62-bc6d-6a0c67803b06	Allowed Client Scopes	master	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	authenticated
6aafda6c-1ff0-4190-828b-c72d5b422e3a	rsa-generated	master	rsa-generated	org.keycloak.keys.KeyProvider	master	\N
a00f4333-e99f-4408-b7f3-a35232044ebe	rsa-enc-generated	master	rsa-enc-generated	org.keycloak.keys.KeyProvider	master	\N
3c7689e6-ffc3-4a13-9b87-d9b36c149306	hmac-generated	master	hmac-generated	org.keycloak.keys.KeyProvider	master	\N
ffb99885-48e7-4123-81ab-19af587eab13	aes-generated	master	aes-generated	org.keycloak.keys.KeyProvider	master	\N
87a90bc8-dfaf-438e-88c3-02a942d09069	\N	master	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	master	\N
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
2eb0e0cf-e828-403b-8180-41a5b071eec4	24973f8c-a86d-4bbd-86f8-db9305f4510b	host-sending-registration-request-must-match	true
e6f6d66c-727b-4a79-8563-80bf825cee64	24973f8c-a86d-4bbd-86f8-db9305f4510b	client-uris-must-match	true
19c80809-2d76-433f-ad5d-eb889e0cfd73	5d169512-851d-4cc0-9783-439e53286c45	allow-default-scopes	true
81327e31-164e-4364-8da8-5207484f1100	3259d1a9-5d27-4f62-bc6d-6a0c67803b06	allow-default-scopes	true
7637ca7d-9ebb-471c-afef-f5a6f06beae9	ec7ba164-98dc-42b6-90b2-75225af107ab	allowed-protocol-mapper-types	saml-user-property-mapper
ef4bce7e-40a6-45b8-88a3-697527ab0125	ec7ba164-98dc-42b6-90b2-75225af107ab	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
3e3f3e8a-f272-4695-8d26-064b44e4ea37	ec7ba164-98dc-42b6-90b2-75225af107ab	allowed-protocol-mapper-types	saml-role-list-mapper
083259e4-214e-495b-89c5-0f02a7195eae	ec7ba164-98dc-42b6-90b2-75225af107ab	allowed-protocol-mapper-types	oidc-full-name-mapper
0f4cd78f-a422-44c6-ba72-62d663c06c15	ec7ba164-98dc-42b6-90b2-75225af107ab	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
50857ef0-685c-4689-8033-9a133930f6e6	ec7ba164-98dc-42b6-90b2-75225af107ab	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
bab7ea67-d241-4904-981b-14ae756d05a3	ec7ba164-98dc-42b6-90b2-75225af107ab	allowed-protocol-mapper-types	saml-user-attribute-mapper
33a7cbf4-2939-4a20-8ca2-15bb609ec3ee	ec7ba164-98dc-42b6-90b2-75225af107ab	allowed-protocol-mapper-types	oidc-address-mapper
e22d213f-3607-46aa-a0d9-a17aa401a0f5	0aa1e9b8-28ca-4fad-90ed-e09725c9ce84	max-clients	200
35d5fad7-c656-4a5d-bfcc-5d32b212df01	44ca3d03-7d96-460a-b37f-2e7a8fe6ceb8	allowed-protocol-mapper-types	oidc-address-mapper
02908967-acdc-44eb-bef9-86d8f8854df6	44ca3d03-7d96-460a-b37f-2e7a8fe6ceb8	allowed-protocol-mapper-types	saml-user-property-mapper
e81f943b-d0ee-4add-a151-a02909d1f69e	44ca3d03-7d96-460a-b37f-2e7a8fe6ceb8	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
b8927db1-5e0e-487b-b5a4-998a03d99dc0	44ca3d03-7d96-460a-b37f-2e7a8fe6ceb8	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
41f8c1d9-34ab-4305-8206-6be76eb0375e	44ca3d03-7d96-460a-b37f-2e7a8fe6ceb8	allowed-protocol-mapper-types	saml-role-list-mapper
1ad1b1d7-a7cb-488d-8bc4-e0130dd41529	44ca3d03-7d96-460a-b37f-2e7a8fe6ceb8	allowed-protocol-mapper-types	oidc-full-name-mapper
8bc985a0-a3c2-44ec-8b8b-cad8150b70a4	44ca3d03-7d96-460a-b37f-2e7a8fe6ceb8	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
63d8fc12-fafc-4b2a-a9cf-f906c22dadf0	44ca3d03-7d96-460a-b37f-2e7a8fe6ceb8	allowed-protocol-mapper-types	saml-user-attribute-mapper
3ffcb37e-7bff-49c6-927d-e2ec321224f1	ffb99885-48e7-4123-81ab-19af587eab13	priority	100
6ee9a122-b3c1-41d5-af09-61041fa59301	ffb99885-48e7-4123-81ab-19af587eab13	kid	5c754f9b-f16e-46a1-b76c-184b3f740f72
46edf06c-a32d-478a-b08c-9c584a1b0321	ffb99885-48e7-4123-81ab-19af587eab13	secret	pPzQfE4VS8WgqV-sA5ixRg
cb0cdc6b-881d-45f9-9634-ebcd063ea865	a00f4333-e99f-4408-b7f3-a35232044ebe	privateKey	MIIEpAIBAAKCAQEAzb1/LGpAcJXiVeddNCAVjsLXLQK9GbhrPcW+ICKBFlAj58ZM2r/8+KJBZya4X5I6AY4XPT7fLWKP14bZznXA6GN0OX97E4cx1quPHOKJOKP9nfta5YoLP5On+1bQLv++Y6BVUgeYHV5Gtv49KStBOEwLmwrJYTT8rjH/vFRmYQNHAfMovJ00PGZ+xSoQ31iifwYZzjCYk8OR8FhgVuRTXJELi/N6yIsevlUQ9Bq7gsC6S8LJBVk18/5DXy3g6LeBgbwDp4BfBDO6rMr0bxTcDqNFIMEYexPzU42FsyFEiyzayyUlDAkZVNm0teYH/ex1SeYLFuHd6151YgYWAmb2gQIDAQABAoIBAQCNJJM6RSowEqNTi4XFXL1tUv2LQ3W3T21C04W7RfCI/jGjr8bJyywg5i84NLgH2Kkyp+gJfDhfSl6j3T9PBDlzM8doKqykmPr36nojtsWstdQnrWiOUEWnOATlyIjJtWlHr5bYz5zriOG6aHBM7f+wP3s2wg+lQFSYrHRlHwGdSwdPNIBp+mirndnyNqHsGLIKRDf7XQNIcQDabs0hdQ55IbZjKZ2dBdqUu/LcqgG6aft95lVX0x9dnRmpH9IJORPUvvaxABpXjrSlOUL6cw/rFj1oZ4+iFsX6XZZzENptbvUTpdQ0ren6OzDzR5/g6cL8DV6M3bvJBRjdeQxNhhgBAoGBAOtOhvevnfDV6q8BYRUSOGsvyu7qwonOM8F4q1FFdiw51/8DJIp0e355facZuLz63ev0Qo/SNhsCMyN+/7Yez2q0/kpqCuqy9bt1m3CnGuhl283T/8dZ9xVMU6uJkx+uMkQRD2Asqawgo6jh4s7Tds1Hf3p2c33zuSw8L6wHhv0pAoGBAN/VVjznIK7eJ/cHp1fMysWYiJerAjL/7zzQr5ESJYtEtAqAm+qkZPJK6H9lPe0yLqlPG+Z9EJIDH4kn0xdsXxYsqCh6L5rPda6/wt+APmcBqSvfxHWyqMGBpfyvzL8FAsYV8jGuWN/yll6mUjEZpEdoKTEu8A57jt0Vs46Q6IGZAoGAdT/b4O+RM8BkAHAff/BkTIS0CfjQlvo4r98A/q4uBDuOdXOLcbI5FvxSsEEQ3Jnkmv5LbH7ClxKxiK5vnMAden5Vd57/cZNa/t3LZobd0Y9vx1Ar05nwlJxD1OXoeZDDW0dk8fdPVIWvBygHbCfSutc1nkAHrGsVigUze/UEPoECgYEAvmE4DmkP1WxDVct+vCEFvvc0Brx/DF2/YFynV561rDTtZZlqBDN7YNHx2pmECIGMSplsw6hQNcDOS9xBoUSdw8CL7pGud+BI2i9kUrFDYl15REX5VZp2CtB5G+lzHm3mpBD6hOMj2Kb+2tZgRj7nCY1ArAKeT9Mr+kOBC5uZBtECgYBGDQ93ptjmZ7Z5FbwA96XVuMXtbaPU+7iecHWITBlF5o88nd7tJvIe4Tyomg1128zW2i+HbPRTRWq0w4RmGzsuD37PHM1VDb8f8lIT6+uSXQi2O6d+FSknFp/FUrOT3kQ7dNmmszmtn/j3hVsVdVkGIUxhU/fHDOontATSsX+kQQ==
436e4822-f079-4c6c-894d-7a637ed51f7d	a00f4333-e99f-4408-b7f3-a35232044ebe	keyUse	ENC
e950a030-9965-433b-adc3-181dcae948e6	a00f4333-e99f-4408-b7f3-a35232044ebe	priority	100
edc7a675-b3b8-4a37-9058-716bcb41482b	a00f4333-e99f-4408-b7f3-a35232044ebe	certificate	MIICmzCCAYMCBgGA5nvz9DANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjIwNTIxMTE1NzA0WhcNMzIwNTIxMTE1ODQ0WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDNvX8sakBwleJV5100IBWOwtctAr0ZuGs9xb4gIoEWUCPnxkzav/z4okFnJrhfkjoBjhc9Pt8tYo/XhtnOdcDoY3Q5f3sThzHWq48c4ok4o/2d+1rligs/k6f7VtAu/75joFVSB5gdXka2/j0pK0E4TAubCslhNPyuMf+8VGZhA0cB8yi8nTQ8Zn7FKhDfWKJ/BhnOMJiTw5HwWGBW5FNckQuL83rIix6+VRD0GruCwLpLwskFWTXz/kNfLeDot4GBvAOngF8EM7qsyvRvFNwOo0UgwRh7E/NTjYWzIUSLLNrLJSUMCRlU2bS15gf97HVJ5gsW4d3rXnViBhYCZvaBAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAI90hPDbZZnXYGHfFVBaSxa01Ntx5XmYP3YDAMFx6yoU8PPcTekKd+0xPSt0bCJI0k9ZzYptiAMsjY32cwS8n+d1Ws6nhH02BPr4ZctteK8toOOOqRi5+3XS08iwLWavoSLQIQ1YrhQtK1xMMyqLmNWGz5QKXSPTSbov3m21hbQ+syv3WXm4eHAGq1Dr5tdBWGZag9us2os/UtiUkFM/6K3f0OERbUDN9pfRLqcAonSBX7Rm2cLM6hfMcp8+WOe9w4Dgr9V2Jp18s3LmWG9HCggnROxq6sgSiSS38LYLM4syS9wK9+Y0T3ywaMAvOl9eOIqguUtMzQQiDiVmtWGTsy8=
84ff2c96-5132-4bec-9794-87b3c0317fc6	a00f4333-e99f-4408-b7f3-a35232044ebe	algorithm	RSA-OAEP
a9da1f0e-6fba-472b-9877-d1e36b246c76	3c7689e6-ffc3-4a13-9b87-d9b36c149306	priority	100
599de4ce-934e-4dbb-a9c0-844e8df513d2	3c7689e6-ffc3-4a13-9b87-d9b36c149306	secret	CwjxfH6h4gq8Qcsaud6y1VhS9ZwW37GNr5U0xas3SSfFQ_xFgZozjoyG0kv-qfNlEOjUv0DxsAhodA-yNhhSEQ
b0f912cc-6ae3-4e8b-a84b-4e9ad2c53d7f	3c7689e6-ffc3-4a13-9b87-d9b36c149306	kid	40424b93-22ed-40e2-ac69-6c8a3e305fae
fb357b5c-311e-4fe0-94c3-5b010c976a6b	3c7689e6-ffc3-4a13-9b87-d9b36c149306	algorithm	HS256
f545c0ab-4265-4a3e-8003-c9de2ceb7c4b	6aafda6c-1ff0-4190-828b-c72d5b422e3a	priority	100
9b5bc2ab-1d44-49de-b910-a1ae389cf21c	6aafda6c-1ff0-4190-828b-c72d5b422e3a	certificate	MIICmzCCAYMCBgGA5nvxfzANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjIwNTIxMTE1NzA0WhcNMzIwNTIxMTE1ODQ0WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCa7KM+vEchtq5tBsiwnQgLmiWdkta6f8TyorY/w+bGwbQKgYzX4uIZFgA9HjnSMkM/3GebWiMU2+nooqWWdeUL9yXmTmmLwsTQOFBiTE/bdtW0C1r+DEwqJAGUKnmtKNVo2zHYPwiJA40ww/+LYfYtmdNNg8v3oDs2GdGlRhPapjHAcqrJkdIBNlsV6yBJMrTxFkaPaF2aYkUeoFZ+CczbQFbyvz7hcAFbzndUIXNjc2oXkioOkBkUqLgkW/BRDzgGxC/tA7QiBUeglIAU9cDAsDnoOWo9okC/jCUn9q7GCJAmhzhOIiiLukfwGVc+ckwrrOcBMfAuG84ZtHosQ+4XAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAGZ/0IMdvsXBCwiCFkHiSZmGMPUCYsjK3EHwhUjXrOY8g6dt01MUbxbS5Pgek1vc+zcRgkvUcuIDIJBlG7KSSZfLSxDCTcLqPLSQajkUnc5ZNeEzjbGVQ/AUedmBcza+tNaVuijO122bI1CvmpxziajE2t1ncnGo3K7yaACezUbW3qqX2AUdtnthELe7hBXO6Hq+CxmLv3ZY5eLKEp+gsrpI74QiP8xqlaJh7LNugWGrqz+wvcTqvkVoNXHnX0+IK6DRFZexGA7PK/hjduBm84z1UUpS79pSrP4ck2BE0y7H08FY7EvGYVCEATjG7QZjMM1nHziR+C7d8q3O8NNBIH4=
d00a2409-c0ed-47d3-bc2c-ef5abe2382d0	6aafda6c-1ff0-4190-828b-c72d5b422e3a	privateKey	MIIEogIBAAKCAQEAmuyjPrxHIbaubQbIsJ0IC5olnZLWun/E8qK2P8PmxsG0CoGM1+LiGRYAPR450jJDP9xnm1ojFNvp6KKllnXlC/cl5k5pi8LE0DhQYkxP23bVtAta/gxMKiQBlCp5rSjVaNsx2D8IiQONMMP/i2H2LZnTTYPL96A7NhnRpUYT2qYxwHKqyZHSATZbFesgSTK08RZGj2hdmmJFHqBWfgnM20BW8r8+4XABW853VCFzY3NqF5IqDpAZFKi4JFvwUQ84BsQv7QO0IgVHoJSAFPXAwLA56DlqPaJAv4wlJ/auxgiQJoc4TiIoi7pH8BlXPnJMK6znATHwLhvOGbR6LEPuFwIDAQABAoIBACxkYEaKtqsvaH2vMvSAmpyQd/TV7ZeVIv8Ppr9QyCDtwkQ8aPo3degQSNM6hQD5DBIRetKmGmVQuo7BhEc/0vkBwadjkpTMo46yhD4Wdc+CFqw3kMQ5C94LYTRuk10N1VDtdjPro+t2zA9MKj5rPJpGeKi+ekSjcjQHY+5CzU+aW4cHBHWGQE5CSfXTxoahdaomTGsTZxUFXUlqoIz+M2UlqyAWD8zsZogmuTHB2RonS58FhsY4zl97M4EXYn5rNXM9jOzin5vLfwdobpaAjwXvhlf+T+6ouLHNyzX7LxA21Wsek0BiHVUAaZD2GR3rz6JkurFuBadGcs3ZPzSVUukCgYEAyI8Fxm7N1ig+VZGM3D5m00OCslhFaQIzZ6GzYmk4LaKOsdYnt5JePRWJL6CQqUyn12UASqgxadpr5ELVGebtrZh1xdB4o6dysoIIopGejmctgLzaPD5bxkRdPfkp/kZS+z49XdtVfP5KC8opPn2c406dk/HLO341SemIS4rhWB0CgYEAxcAzvS6E7F4zy8TvJP76Oigah84PxdECg+nZM2UIzM2OpbODEW5Wy1CZsyvpFmAFsL0bBA94UZHtEMkuV7gZEDKxRfdqRacKIEdT56uDSjMIcDBdquHxhHdp/6fgNdEb3pOh3ybx1eSGUzj1nd81Dz4I44vTnNqYY4xr247MEMMCgYA8A6hLv75ydipo+pv3D+k/ELWcXpOun4z4VsfSDABWj405pAbQhMkUaExb5yVCtACJkNysenYG4ehlLqaMELFQwA2F+yMOfb3xsr2YwBB9NlzEaD65xkM6KhzovZWWVD7ilbZRTp/fPky0CHOdEoOO9Whr6+/Pxq11h59UU6Oo9QKBgDmTKT02cxsCnmAAmYQS/LW8AWVy2GLG5M2VY1i0XOiMHLEf39ROZNTTRbzF1xpdoKqBlIENJAHT08rkWCrP/fQaXkS5sWZQKQGW4tX7uMD8tMM9QbhECnZ/8guuS/g/Rrb6EtIO27Bj1bwbRF/PoforHJlrl5P+jQnG04xcOgvTAoGAEFx//fW8rdLd0YNaSAgPz0V91AicH27Cm5rTDKAgrD4R67rHNnkubb3TRYBWV5/TWZ9pI4asPDiNhl25hl6+aN3HXZL0Yi+zw9YqVf2CZPWduyra2h7V/cL9DUYTXlcfA0Nj4sKwLcZBi8CqIMIegEBH5BY6cadEKcRJcZ6sRIc=
b4079b78-6c26-40cc-9852-058441a0597f	6aafda6c-1ff0-4190-828b-c72d5b422e3a	keyUse	SIG
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.composite_role (composite, child_role) FROM stdin;
af89f514-69ea-4263-a537-a0703ae0fd33	ef9c8793-60e1-41e1-bcd8-0736a0c4a075
af89f514-69ea-4263-a537-a0703ae0fd33	44e01069-6e81-457e-9bc8-e913360c5651
af89f514-69ea-4263-a537-a0703ae0fd33	5354d44d-6fb9-4cb2-ae9c-0b01fe635289
af89f514-69ea-4263-a537-a0703ae0fd33	a213c824-39b1-4235-9b33-8b0e9a9c6239
af89f514-69ea-4263-a537-a0703ae0fd33	ac81a7bc-84da-4bb0-9707-d13402494629
af89f514-69ea-4263-a537-a0703ae0fd33	8b1c2bf4-2a6d-4fbc-ac89-1c4a97e3afe9
af89f514-69ea-4263-a537-a0703ae0fd33	1aa21bdd-def2-4edc-a115-e8d584db2c43
af89f514-69ea-4263-a537-a0703ae0fd33	7481e787-a408-4d21-90f8-70c94d784092
af89f514-69ea-4263-a537-a0703ae0fd33	c391fcd5-b53b-4cee-b2a6-18fe4fb50502
af89f514-69ea-4263-a537-a0703ae0fd33	6e2c146d-f1bd-46c9-898f-27c88c6fbedc
af89f514-69ea-4263-a537-a0703ae0fd33	42827a64-acda-4a5b-af5b-550cb419638e
af89f514-69ea-4263-a537-a0703ae0fd33	c9490a1d-569a-4952-bbc5-ac96bc21bf69
af89f514-69ea-4263-a537-a0703ae0fd33	b1328195-c934-48eb-bc88-cf35200bfe5e
af89f514-69ea-4263-a537-a0703ae0fd33	590b064b-0ff3-47d2-92af-edf3d97e270d
af89f514-69ea-4263-a537-a0703ae0fd33	4d7c888b-1f96-4264-a29a-cb30b273984c
af89f514-69ea-4263-a537-a0703ae0fd33	86fdcc86-0bcc-499d-93de-ebb8f2c4c0e5
af89f514-69ea-4263-a537-a0703ae0fd33	b11954cb-7676-4ce5-9a29-bccb5af6ce97
af89f514-69ea-4263-a537-a0703ae0fd33	03cdede0-e7ea-459e-9d9a-f199c9a88b97
ac81a7bc-84da-4bb0-9707-d13402494629	86fdcc86-0bcc-499d-93de-ebb8f2c4c0e5
a213c824-39b1-4235-9b33-8b0e9a9c6239	03cdede0-e7ea-459e-9d9a-f199c9a88b97
a213c824-39b1-4235-9b33-8b0e9a9c6239	4d7c888b-1f96-4264-a29a-cb30b273984c
28fcb3c5-22d0-4a78-a368-856f4ab31853	15348e6c-bbe2-438b-9e1d-0333a3d4af76
28fcb3c5-22d0-4a78-a368-856f4ab31853	fb555894-c425-46fe-8896-41aeda07570f
fb555894-c425-46fe-8896-41aeda07570f	8f4d1934-0536-463b-92b6-22f962dc75aa
1a921673-589a-46ec-9ffc-00ce43d207d0	08b8e776-f4b7-4382-b6b4-e991a667d1df
af89f514-69ea-4263-a537-a0703ae0fd33	d3f711a5-249c-42b7-9323-a15d8ca86365
28fcb3c5-22d0-4a78-a368-856f4ab31853	2c6b4e7f-2a7c-465d-9375-aa9aead86875
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
772e1482-b9ec-499c-ad08-4feddd9a27f4	\N	password	c5f56978-e86f-491b-8796-91097740ac38	1653134325209	\N	{"value":"+IDkoyrKxZD1IalVfnjP6i166Y4kQAEXfBE9XyVmF4QHg/nLpqcx64U9MAWlkAVdVMdKrO3+kp12BrJGi6Cx6w==","salt":"vpBT58wnsakYgN13vnPptg==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
f9b11e00-266d-4a10-a995-3b7d367a9075	\N	password	efe79764-f86e-40a3-a4d7-6545e9c34e07	1653134479724	\N	{"value":"EthCXJSB6WbOPc+3dSJwRsrKtLjkMIbkdjM9M10gnWw9+mqc/XPaomQ051/wM6Xald+CYzWeuHIBap67BYbN8g==","salt":"bg9MAyKzJN/x+0FJWszHxQ==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2022-05-21 11:58:33.177695	1	EXECUTED	7:4e70412f24a3f382c82183742ec79317	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	3.5.4	\N	\N	3134312590
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2022-05-21 11:58:33.203169	2	MARK_RAN	7:cb16724583e9675711801c6875114f28	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	3.5.4	\N	\N	3134312590
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2022-05-21 11:58:33.298941	3	EXECUTED	7:0310eb8ba07cec616460794d42ade0fa	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	3.5.4	\N	\N	3134312590
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2022-05-21 11:58:33.304308	4	EXECUTED	7:5d25857e708c3233ef4439df1f93f012	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	3.5.4	\N	\N	3134312590
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2022-05-21 11:58:33.496882	5	EXECUTED	7:c7a54a1041d58eb3817a4a883b4d4e84	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	3.5.4	\N	\N	3134312590
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2022-05-21 11:58:33.511856	6	MARK_RAN	7:2e01012df20974c1c2a605ef8afe25b7	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	3.5.4	\N	\N	3134312590
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2022-05-21 11:58:33.658625	7	EXECUTED	7:0f08df48468428e0f30ee59a8ec01a41	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	3.5.4	\N	\N	3134312590
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2022-05-21 11:58:33.662825	8	MARK_RAN	7:a77ea2ad226b345e7d689d366f185c8c	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	3.5.4	\N	\N	3134312590
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2022-05-21 11:58:33.686018	9	EXECUTED	7:a3377a2059aefbf3b90ebb4c4cc8e2ab	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	3.5.4	\N	\N	3134312590
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2022-05-21 11:58:33.880009	10	EXECUTED	7:04c1dbedc2aa3e9756d1a1668e003451	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	3.5.4	\N	\N	3134312590
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2022-05-21 11:58:33.961801	11	EXECUTED	7:36ef39ed560ad07062d956db861042ba	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	3134312590
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2022-05-21 11:58:33.964314	12	MARK_RAN	7:d909180b2530479a716d3f9c9eaea3d7	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	3134312590
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2022-05-21 11:58:33.999763	13	EXECUTED	7:cf12b04b79bea5152f165eb41f3955f6	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	3134312590
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2022-05-21 11:58:34.024797	14	EXECUTED	7:7e32c8f05c755e8675764e7d5f514509	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	3.5.4	\N	\N	3134312590
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2022-05-21 11:58:34.026595	15	MARK_RAN	7:980ba23cc0ec39cab731ce903dd01291	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	3134312590
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2022-05-21 11:58:34.028014	16	MARK_RAN	7:2fa220758991285312eb84f3b4ff5336	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	3.5.4	\N	\N	3134312590
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2022-05-21 11:58:34.029416	17	EXECUTED	7:d41d8cd98f00b204e9800998ecf8427e	empty		\N	3.5.4	\N	\N	3134312590
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2022-05-21 11:58:34.102421	18	EXECUTED	7:91ace540896df890cc00a0490ee52bbc	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	3.5.4	\N	\N	3134312590
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2022-05-21 11:58:34.166239	19	EXECUTED	7:c31d1646dfa2618a9335c00e07f89f24	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	3.5.4	\N	\N	3134312590
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2022-05-21 11:58:34.170774	20	EXECUTED	7:df8bc21027a4f7cbbb01f6344e89ce07	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	3.5.4	\N	\N	3134312590
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-05-21 11:58:37.57878	45	EXECUTED	7:6a48ce645a3525488a90fbf76adf3bb3	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	3.5.4	\N	\N	3134312590
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2022-05-21 11:58:34.18163	21	MARK_RAN	7:f987971fe6b37d963bc95fee2b27f8df	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	3.5.4	\N	\N	3134312590
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2022-05-21 11:58:34.185618	22	MARK_RAN	7:df8bc21027a4f7cbbb01f6344e89ce07	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	3.5.4	\N	\N	3134312590
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2022-05-21 11:58:34.315406	23	EXECUTED	7:ed2dc7f799d19ac452cbcda56c929e47	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	3.5.4	\N	\N	3134312590
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2022-05-21 11:58:34.320965	24	EXECUTED	7:80b5db88a5dda36ece5f235be8757615	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	3.5.4	\N	\N	3134312590
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2022-05-21 11:58:34.322708	25	MARK_RAN	7:1437310ed1305a9b93f8848f301726ce	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	3.5.4	\N	\N	3134312590
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2022-05-21 11:58:34.813086	26	EXECUTED	7:b82ffb34850fa0836be16deefc6a87c4	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	3.5.4	\N	\N	3134312590
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2022-05-21 11:58:34.952712	27	EXECUTED	7:9cc98082921330d8d9266decdd4bd658	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	3.5.4	\N	\N	3134312590
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2022-05-21 11:58:34.95626	28	EXECUTED	7:03d64aeed9cb52b969bd30a7ac0db57e	update tableName=RESOURCE_SERVER_POLICY		\N	3.5.4	\N	\N	3134312590
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2022-05-21 11:58:35.027843	29	EXECUTED	7:f1f9fd8710399d725b780f463c6b21cd	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	3.5.4	\N	\N	3134312590
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2022-05-21 11:58:35.056166	30	EXECUTED	7:53188c3eb1107546e6f765835705b6c1	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	3.5.4	\N	\N	3134312590
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2022-05-21 11:58:35.077995	31	EXECUTED	7:d6e6f3bc57a0c5586737d1351725d4d4	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	3.5.4	\N	\N	3134312590
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2022-05-21 11:58:35.102654	32	EXECUTED	7:454d604fbd755d9df3fd9c6329043aa5	customChange		\N	3.5.4	\N	\N	3134312590
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2022-05-21 11:58:35.112619	33	EXECUTED	7:57e98a3077e29caf562f7dbf80c72600	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	3134312590
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2022-05-21 11:58:35.114096	34	MARK_RAN	7:e4c7e8f2256210aee71ddc42f538b57a	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	3.5.4	\N	\N	3134312590
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2022-05-21 11:58:35.156757	35	EXECUTED	7:09a43c97e49bc626460480aa1379b522	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	3.5.4	\N	\N	3134312590
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2022-05-21 11:58:35.164082	36	EXECUTED	7:26bfc7c74fefa9126f2ce702fb775553	addColumn tableName=REALM		\N	3.5.4	\N	\N	3134312590
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2022-05-21 11:58:35.172982	37	EXECUTED	7:a161e2ae671a9020fff61e996a207377	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	3134312590
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2022-05-21 11:58:35.176316	38	EXECUTED	7:37fc1781855ac5388c494f1442b3f717	addColumn tableName=FED_USER_CONSENT		\N	3.5.4	\N	\N	3134312590
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2022-05-21 11:58:35.186598	39	EXECUTED	7:13a27db0dae6049541136adad7261d27	addColumn tableName=IDENTITY_PROVIDER		\N	3.5.4	\N	\N	3134312590
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2022-05-21 11:58:35.187946	40	MARK_RAN	7:550300617e3b59e8af3a6294df8248a3	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	3.5.4	\N	\N	3134312590
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2022-05-21 11:58:35.189159	41	MARK_RAN	7:e3a9482b8931481dc2772a5c07c44f17	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	3.5.4	\N	\N	3134312590
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2022-05-21 11:58:35.195919	42	EXECUTED	7:72b07d85a2677cb257edb02b408f332d	customChange		\N	3.5.4	\N	\N	3134312590
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2022-05-21 11:58:37.56262	43	EXECUTED	7:a72a7858967bd414835d19e04d880312	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	3.5.4	\N	\N	3134312590
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2022-05-21 11:58:37.568006	44	EXECUTED	7:94edff7cf9ce179e7e85f0cd78a3cf2c	addColumn tableName=USER_ENTITY		\N	3.5.4	\N	\N	3134312590
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-05-21 11:58:37.590288	46	EXECUTED	7:e64b5dcea7db06077c6e57d3b9e5ca14	customChange		\N	3.5.4	\N	\N	3134312590
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-05-21 11:58:37.595788	47	MARK_RAN	7:fd8cf02498f8b1e72496a20afc75178c	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	3.5.4	\N	\N	3134312590
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-05-21 11:58:37.794138	48	EXECUTED	7:542794f25aa2b1fbabb7e577d6646319	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	3.5.4	\N	\N	3134312590
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-05-21 11:58:37.800234	49	EXECUTED	7:edad604c882df12f74941dac3cc6d650	addColumn tableName=REALM		\N	3.5.4	\N	\N	3134312590
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2022-05-21 11:58:37.858171	50	EXECUTED	7:0f88b78b7b46480eb92690cbf5e44900	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	3.5.4	\N	\N	3134312590
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2022-05-21 11:58:38.373926	51	EXECUTED	7:d560e43982611d936457c327f872dd59	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	3.5.4	\N	\N	3134312590
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2022-05-21 11:58:38.378163	52	EXECUTED	7:c155566c42b4d14ef07059ec3b3bbd8e	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	3134312590
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2022-05-21 11:58:38.381845	53	EXECUTED	7:b40376581f12d70f3c89ba8ddf5b7dea	update tableName=REALM		\N	3.5.4	\N	\N	3134312590
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2022-05-21 11:58:38.384633	54	EXECUTED	7:a1132cc395f7b95b3646146c2e38f168	update tableName=CLIENT		\N	3.5.4	\N	\N	3134312590
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2022-05-21 11:58:38.390506	55	EXECUTED	7:d8dc5d89c789105cfa7ca0e82cba60af	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	3.5.4	\N	\N	3134312590
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2022-05-21 11:58:38.399074	56	EXECUTED	7:7822e0165097182e8f653c35517656a3	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	3.5.4	\N	\N	3134312590
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2022-05-21 11:58:38.457381	57	EXECUTED	7:c6538c29b9c9a08f9e9ea2de5c2b6375	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	3.5.4	\N	\N	3134312590
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2022-05-21 11:58:38.899776	58	EXECUTED	7:6d4893e36de22369cf73bcb051ded875	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	3.5.4	\N	\N	3134312590
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2022-05-21 11:58:38.935974	59	EXECUTED	7:57960fc0b0f0dd0563ea6f8b2e4a1707	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	3.5.4	\N	\N	3134312590
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2022-05-21 11:58:38.943456	60	EXECUTED	7:2b4b8bff39944c7097977cc18dbceb3b	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	3.5.4	\N	\N	3134312590
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2022-05-21 11:58:38.956637	61	EXECUTED	7:2aa42a964c59cd5b8ca9822340ba33a8	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	3.5.4	\N	\N	3134312590
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2022-05-21 11:58:38.963287	62	EXECUTED	7:9ac9e58545479929ba23f4a3087a0346	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	3.5.4	\N	\N	3134312590
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2022-05-21 11:58:38.974312	63	EXECUTED	7:14d407c35bc4fe1976867756bcea0c36	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	3.5.4	\N	\N	3134312590
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2022-05-21 11:58:38.978663	64	EXECUTED	7:241a8030c748c8548e346adee548fa93	update tableName=REQUIRED_ACTION_PROVIDER		\N	3.5.4	\N	\N	3134312590
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2022-05-21 11:58:38.981492	65	EXECUTED	7:7d3182f65a34fcc61e8d23def037dc3f	update tableName=RESOURCE_SERVER_RESOURCE		\N	3.5.4	\N	\N	3134312590
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2022-05-21 11:58:39.029087	66	EXECUTED	7:b30039e00a0b9715d430d1b0636728fa	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	3.5.4	\N	\N	3134312590
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2022-05-21 11:58:39.068764	67	EXECUTED	7:3797315ca61d531780f8e6f82f258159	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	3.5.4	\N	\N	3134312590
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2022-05-21 11:58:39.074027	68	EXECUTED	7:c7aa4c8d9573500c2d347c1941ff0301	addColumn tableName=REALM		\N	3.5.4	\N	\N	3134312590
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2022-05-21 11:58:39.111909	69	EXECUTED	7:b207faee394fc074a442ecd42185a5dd	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	3.5.4	\N	\N	3134312590
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2022-05-21 11:58:39.117094	70	EXECUTED	7:ab9a9762faaba4ddfa35514b212c4922	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	3.5.4	\N	\N	3134312590
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2022-05-21 11:58:39.120337	71	EXECUTED	7:b9710f74515a6ccb51b72dc0d19df8c4	addColumn tableName=RESOURCE_SERVER		\N	3.5.4	\N	\N	3134312590
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-05-21 11:58:39.127637	72	EXECUTED	7:ec9707ae4d4f0b7452fee20128083879	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	3134312590
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-05-21 11:58:39.145448	73	EXECUTED	7:3979a0ae07ac465e920ca696532fc736	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	3134312590
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-05-21 11:58:39.146938	74	MARK_RAN	7:5abfde4c259119d143bd2fbf49ac2bca	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	3134312590
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-05-21 11:58:39.171293	75	EXECUTED	7:b48da8c11a3d83ddd6b7d0c8c2219345	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	3.5.4	\N	\N	3134312590
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-05-21 11:58:39.207963	76	EXECUTED	7:a73379915c23bfad3e8f5c6d5c0aa4bd	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	3.5.4	\N	\N	3134312590
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2022-05-21 11:58:39.21197	77	EXECUTED	7:39e0073779aba192646291aa2332493d	addColumn tableName=CLIENT		\N	3.5.4	\N	\N	3134312590
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2022-05-21 11:58:39.213235	78	MARK_RAN	7:81f87368f00450799b4bf42ea0b3ec34	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	3.5.4	\N	\N	3134312590
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2022-05-21 11:58:39.248616	79	EXECUTED	7:20b37422abb9fb6571c618148f013a15	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	3.5.4	\N	\N	3134312590
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2022-05-21 11:58:39.250455	80	MARK_RAN	7:1970bb6cfb5ee800736b95ad3fb3c78a	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	3.5.4	\N	\N	3134312590
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-05-21 11:58:39.282135	81	EXECUTED	7:45d9b25fc3b455d522d8dcc10a0f4c80	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	3.5.4	\N	\N	3134312590
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-05-21 11:58:39.289302	82	MARK_RAN	7:890ae73712bc187a66c2813a724d037f	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	3134312590
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-05-21 11:58:39.292959	83	EXECUTED	7:0a211980d27fafe3ff50d19a3a29b538	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	3134312590
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-05-21 11:58:39.294469	84	MARK_RAN	7:a161e2ae671a9020fff61e996a207377	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	3134312590
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-05-21 11:58:39.332189	85	EXECUTED	7:01c49302201bdf815b0a18d1f98a55dc	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	3.5.4	\N	\N	3134312590
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2022-05-21 11:58:39.3412	86	EXECUTED	7:3dace6b144c11f53f1ad2c0361279b86	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	3.5.4	\N	\N	3134312590
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2022-05-21 11:58:39.353383	87	EXECUTED	7:578d0b92077eaf2ab95ad0ec087aa903	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	3.5.4	\N	\N	3134312590
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2022-05-21 11:58:39.362683	88	EXECUTED	7:c95abe90d962c57a09ecaee57972835d	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	3.5.4	\N	\N	3134312590
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-05-21 11:58:39.371592	89	EXECUTED	7:f1313bcc2994a5c4dc1062ed6d8282d3	addColumn tableName=REALM; customChange		\N	3.5.4	\N	\N	3134312590
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-05-21 11:58:39.386364	90	EXECUTED	7:90d763b52eaffebefbcbde55f269508b	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	3.5.4	\N	\N	3134312590
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-05-21 11:58:39.429632	91	EXECUTED	7:d554f0cb92b764470dccfa5e0014a7dd	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	3134312590
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-05-21 11:58:39.444053	92	EXECUTED	7:73193e3ab3c35cf0f37ccea3bf783764	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	3.5.4	\N	\N	3134312590
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-05-21 11:58:39.445513	93	MARK_RAN	7:90a1e74f92e9cbaa0c5eab80b8a037f3	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	3.5.4	\N	\N	3134312590
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-05-21 11:58:39.463285	94	EXECUTED	7:5b9248f29cd047c200083cc6d8388b16	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	3.5.4	\N	\N	3134312590
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-05-21 11:58:39.46518	95	MARK_RAN	7:64db59e44c374f13955489e8990d17a1	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	3.5.4	\N	\N	3134312590
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-05-21 11:58:39.469165	96	EXECUTED	7:329a578cdb43262fff975f0a7f6cda60	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	3.5.4	\N	\N	3134312590
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-05-21 11:58:39.567705	97	EXECUTED	7:fae0de241ac0fd0bbc2b380b85e4f567	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	3134312590
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-05-21 11:58:39.569151	98	MARK_RAN	7:075d54e9180f49bb0c64ca4218936e81	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	3134312590
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-05-21 11:58:39.618072	99	MARK_RAN	7:06499836520f4f6b3d05e35a59324910	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	3134312590
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-05-21 11:58:39.663866	100	EXECUTED	7:fad08e83c77d0171ec166bc9bc5d390a	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	3134312590
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-05-21 11:58:39.665607	101	MARK_RAN	7:3d2b23076e59c6f70bae703aa01be35b	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	3134312590
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-05-21 11:58:39.698148	102	EXECUTED	7:1a7f28ff8d9e53aeb879d76ea3d9341a	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	3.5.4	\N	\N	3134312590
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-05-21 11:58:39.704976	103	EXECUTED	7:2fd554456fed4a82c698c555c5b751b6	customChange		\N	3.5.4	\N	\N	3134312590
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2022-05-21 11:58:39.70957	104	EXECUTED	7:b06356d66c2790ecc2ae54ba0458397a	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	3.5.4	\N	\N	3134312590
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
1001	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
master	28538276-848e-4fa9-a9ed-2d46016a23a2	f
master	987defe6-55bf-4c82-8d26-242bcadef052	t
master	9312b4f1-657b-472f-b5c8-b2f3e6d9e6d3	t
master	c8a45fe5-4f62-43ae-a539-6cda8c9981bd	t
master	688b7dd6-22f0-4a3e-af32-9903536208ba	f
master	41d2f0a1-20c3-4ecc-9c46-05fff6e2b9de	f
master	262d9cce-9b78-4308-bbc4-732f9aa5b659	t
master	099b2eeb-c833-4ddd-8983-48b1d08e98b5	t
master	f311c685-d4df-4b3e-ab4c-1974f58f1357	f
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.keycloak_group (id, name, parent_group, realm_id) FROM stdin;
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
28fcb3c5-22d0-4a78-a368-856f4ab31853	master	f	${role_default-roles}	default-roles-master	master	\N	\N
af89f514-69ea-4263-a537-a0703ae0fd33	master	f	${role_admin}	admin	master	\N	\N
ef9c8793-60e1-41e1-bcd8-0736a0c4a075	master	f	${role_create-realm}	create-realm	master	\N	\N
44e01069-6e81-457e-9bc8-e913360c5651	abd43275-b8e2-46a1-82ef-7ab5f190791b	t	${role_create-client}	create-client	master	abd43275-b8e2-46a1-82ef-7ab5f190791b	\N
5354d44d-6fb9-4cb2-ae9c-0b01fe635289	abd43275-b8e2-46a1-82ef-7ab5f190791b	t	${role_view-realm}	view-realm	master	abd43275-b8e2-46a1-82ef-7ab5f190791b	\N
a213c824-39b1-4235-9b33-8b0e9a9c6239	abd43275-b8e2-46a1-82ef-7ab5f190791b	t	${role_view-users}	view-users	master	abd43275-b8e2-46a1-82ef-7ab5f190791b	\N
ac81a7bc-84da-4bb0-9707-d13402494629	abd43275-b8e2-46a1-82ef-7ab5f190791b	t	${role_view-clients}	view-clients	master	abd43275-b8e2-46a1-82ef-7ab5f190791b	\N
8b1c2bf4-2a6d-4fbc-ac89-1c4a97e3afe9	abd43275-b8e2-46a1-82ef-7ab5f190791b	t	${role_view-events}	view-events	master	abd43275-b8e2-46a1-82ef-7ab5f190791b	\N
1aa21bdd-def2-4edc-a115-e8d584db2c43	abd43275-b8e2-46a1-82ef-7ab5f190791b	t	${role_view-identity-providers}	view-identity-providers	master	abd43275-b8e2-46a1-82ef-7ab5f190791b	\N
7481e787-a408-4d21-90f8-70c94d784092	abd43275-b8e2-46a1-82ef-7ab5f190791b	t	${role_view-authorization}	view-authorization	master	abd43275-b8e2-46a1-82ef-7ab5f190791b	\N
c391fcd5-b53b-4cee-b2a6-18fe4fb50502	abd43275-b8e2-46a1-82ef-7ab5f190791b	t	${role_manage-realm}	manage-realm	master	abd43275-b8e2-46a1-82ef-7ab5f190791b	\N
6e2c146d-f1bd-46c9-898f-27c88c6fbedc	abd43275-b8e2-46a1-82ef-7ab5f190791b	t	${role_manage-users}	manage-users	master	abd43275-b8e2-46a1-82ef-7ab5f190791b	\N
42827a64-acda-4a5b-af5b-550cb419638e	abd43275-b8e2-46a1-82ef-7ab5f190791b	t	${role_manage-clients}	manage-clients	master	abd43275-b8e2-46a1-82ef-7ab5f190791b	\N
c9490a1d-569a-4952-bbc5-ac96bc21bf69	abd43275-b8e2-46a1-82ef-7ab5f190791b	t	${role_manage-events}	manage-events	master	abd43275-b8e2-46a1-82ef-7ab5f190791b	\N
b1328195-c934-48eb-bc88-cf35200bfe5e	abd43275-b8e2-46a1-82ef-7ab5f190791b	t	${role_manage-identity-providers}	manage-identity-providers	master	abd43275-b8e2-46a1-82ef-7ab5f190791b	\N
590b064b-0ff3-47d2-92af-edf3d97e270d	abd43275-b8e2-46a1-82ef-7ab5f190791b	t	${role_manage-authorization}	manage-authorization	master	abd43275-b8e2-46a1-82ef-7ab5f190791b	\N
4d7c888b-1f96-4264-a29a-cb30b273984c	abd43275-b8e2-46a1-82ef-7ab5f190791b	t	${role_query-users}	query-users	master	abd43275-b8e2-46a1-82ef-7ab5f190791b	\N
86fdcc86-0bcc-499d-93de-ebb8f2c4c0e5	abd43275-b8e2-46a1-82ef-7ab5f190791b	t	${role_query-clients}	query-clients	master	abd43275-b8e2-46a1-82ef-7ab5f190791b	\N
b11954cb-7676-4ce5-9a29-bccb5af6ce97	abd43275-b8e2-46a1-82ef-7ab5f190791b	t	${role_query-realms}	query-realms	master	abd43275-b8e2-46a1-82ef-7ab5f190791b	\N
03cdede0-e7ea-459e-9d9a-f199c9a88b97	abd43275-b8e2-46a1-82ef-7ab5f190791b	t	${role_query-groups}	query-groups	master	abd43275-b8e2-46a1-82ef-7ab5f190791b	\N
15348e6c-bbe2-438b-9e1d-0333a3d4af76	e107f0b2-639f-4168-a5ac-2939cb6fec9d	t	${role_view-profile}	view-profile	master	e107f0b2-639f-4168-a5ac-2939cb6fec9d	\N
fb555894-c425-46fe-8896-41aeda07570f	e107f0b2-639f-4168-a5ac-2939cb6fec9d	t	${role_manage-account}	manage-account	master	e107f0b2-639f-4168-a5ac-2939cb6fec9d	\N
8f4d1934-0536-463b-92b6-22f962dc75aa	e107f0b2-639f-4168-a5ac-2939cb6fec9d	t	${role_manage-account-links}	manage-account-links	master	e107f0b2-639f-4168-a5ac-2939cb6fec9d	\N
ac93e82e-722e-4d8d-8fd2-04a372ecb81c	e107f0b2-639f-4168-a5ac-2939cb6fec9d	t	${role_view-applications}	view-applications	master	e107f0b2-639f-4168-a5ac-2939cb6fec9d	\N
08b8e776-f4b7-4382-b6b4-e991a667d1df	e107f0b2-639f-4168-a5ac-2939cb6fec9d	t	${role_view-consent}	view-consent	master	e107f0b2-639f-4168-a5ac-2939cb6fec9d	\N
1a921673-589a-46ec-9ffc-00ce43d207d0	e107f0b2-639f-4168-a5ac-2939cb6fec9d	t	${role_manage-consent}	manage-consent	master	e107f0b2-639f-4168-a5ac-2939cb6fec9d	\N
e772afa7-50e6-4c35-9c58-70db989cdee6	e107f0b2-639f-4168-a5ac-2939cb6fec9d	t	${role_delete-account}	delete-account	master	e107f0b2-639f-4168-a5ac-2939cb6fec9d	\N
fa62c6e1-3aab-434c-a38c-cf66b15bac59	e92bb830-4149-4146-95ec-32367a414170	t	${role_read-token}	read-token	master	e92bb830-4149-4146-95ec-32367a414170	\N
d3f711a5-249c-42b7-9323-a15d8ca86365	abd43275-b8e2-46a1-82ef-7ab5f190791b	t	${role_impersonation}	impersonation	master	abd43275-b8e2-46a1-82ef-7ab5f190791b	\N
45caa9b3-9b15-4e28-abf4-a1065d04d94d	master	f	${role_offline-access}	offline_access	master	\N	\N
a43d70dd-73f1-427b-85b8-d620605a0b3b	master	f	${role_uma_authorization}	uma_authorization	master	\N	\N
2c6b4e7f-2a7c-465d-9375-aa9aead86875	master	f	\N	regular_user	master	\N	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.migration_model (id, version, update_time) FROM stdin;
h7jdr	16.1.0	1653134322
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
0ade5afa-7d8d-4fb5-8d91-d5b62745b7f3	audience resolve	openid-connect	oidc-audience-resolve-mapper	7aace810-2788-4d92-b0a5-32277701a059	\N
e891d88d-765d-4fcd-804b-ceb3c0735d7a	locale	openid-connect	oidc-usermodel-attribute-mapper	fadb8b8b-105a-4891-83e1-330b7a900ce4	\N
09c2495a-39ac-4a73-bc00-0a7fa5a7e6ef	role list	saml	saml-role-list-mapper	\N	987defe6-55bf-4c82-8d26-242bcadef052
c4f29b26-05b7-4277-9825-87c01c6e66cc	full name	openid-connect	oidc-full-name-mapper	\N	9312b4f1-657b-472f-b5c8-b2f3e6d9e6d3
7020bfc8-5123-422d-8bbe-627b635046f1	family name	openid-connect	oidc-usermodel-property-mapper	\N	9312b4f1-657b-472f-b5c8-b2f3e6d9e6d3
d5c04a96-a274-452f-a1e2-74e0effb5cfe	given name	openid-connect	oidc-usermodel-property-mapper	\N	9312b4f1-657b-472f-b5c8-b2f3e6d9e6d3
de6e4ab1-ec75-4bc5-84ca-207ce24268f6	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	9312b4f1-657b-472f-b5c8-b2f3e6d9e6d3
f9d392f5-779d-4c9a-b3bc-132f56622e43	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	9312b4f1-657b-472f-b5c8-b2f3e6d9e6d3
74224636-315a-4a95-9add-15218fe19a69	username	openid-connect	oidc-usermodel-property-mapper	\N	9312b4f1-657b-472f-b5c8-b2f3e6d9e6d3
e8ed7d01-0f8e-484b-8318-842282654de3	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	9312b4f1-657b-472f-b5c8-b2f3e6d9e6d3
091a3ee0-0283-4954-83d2-26b0bc3285d2	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	9312b4f1-657b-472f-b5c8-b2f3e6d9e6d3
41c0bb69-4391-4330-adca-ca1496231e8c	website	openid-connect	oidc-usermodel-attribute-mapper	\N	9312b4f1-657b-472f-b5c8-b2f3e6d9e6d3
b1f2d24d-67f3-4f7e-9835-1ce60eeb7f7d	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	9312b4f1-657b-472f-b5c8-b2f3e6d9e6d3
99a72b14-cb28-4d78-a85e-1caad83e07c7	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	9312b4f1-657b-472f-b5c8-b2f3e6d9e6d3
4c626d0f-22fe-4fe1-9a91-67cb0a6a0435	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	9312b4f1-657b-472f-b5c8-b2f3e6d9e6d3
edea1992-3b4c-4331-a59b-fd8f853242b4	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	9312b4f1-657b-472f-b5c8-b2f3e6d9e6d3
2fa2007e-1d1e-4e7f-8eda-0745d44ee1f0	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	9312b4f1-657b-472f-b5c8-b2f3e6d9e6d3
db6f4fe4-e76e-44df-9c91-a15071437579	email	openid-connect	oidc-usermodel-property-mapper	\N	c8a45fe5-4f62-43ae-a539-6cda8c9981bd
2357e6f2-979c-45bc-973c-aefaed358f64	email verified	openid-connect	oidc-usermodel-property-mapper	\N	c8a45fe5-4f62-43ae-a539-6cda8c9981bd
6ff04c1a-89bd-4b3c-ac6d-c0b3d6e692b0	address	openid-connect	oidc-address-mapper	\N	688b7dd6-22f0-4a3e-af32-9903536208ba
7288551f-ead5-4ddc-b277-ea2137b720f2	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	41d2f0a1-20c3-4ecc-9c46-05fff6e2b9de
616187da-564c-4fc6-9296-d6298adc6c4c	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	41d2f0a1-20c3-4ecc-9c46-05fff6e2b9de
ecade6aa-3b21-4997-8724-606d5b0f8082	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	262d9cce-9b78-4308-bbc4-732f9aa5b659
7565b5ce-7c8a-4d67-ae17-b210c815ea39	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	262d9cce-9b78-4308-bbc4-732f9aa5b659
58683e20-8b1f-4ca8-80c3-27a57db28be3	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	262d9cce-9b78-4308-bbc4-732f9aa5b659
4542240f-f67d-42ee-aa00-e8ce56b0ba53	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	099b2eeb-c833-4ddd-8983-48b1d08e98b5
c333517f-2e1c-4fe6-a7d4-14c8012ebef5	upn	openid-connect	oidc-usermodel-property-mapper	\N	f311c685-d4df-4b3e-ab4c-1974f58f1357
110382a7-55a2-4396-8b40-3b7002f70b8e	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	f311c685-d4df-4b3e-ab4c-1974f58f1357
59e8300e-0cec-4787-ac07-ecc3133ff22f	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	cac2492c-7a21-4b8a-b7d8-4c9e38afc58d	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
e891d88d-765d-4fcd-804b-ceb3c0735d7a	true	userinfo.token.claim
e891d88d-765d-4fcd-804b-ceb3c0735d7a	locale	user.attribute
e891d88d-765d-4fcd-804b-ceb3c0735d7a	true	id.token.claim
e891d88d-765d-4fcd-804b-ceb3c0735d7a	true	access.token.claim
e891d88d-765d-4fcd-804b-ceb3c0735d7a	locale	claim.name
e891d88d-765d-4fcd-804b-ceb3c0735d7a	String	jsonType.label
09c2495a-39ac-4a73-bc00-0a7fa5a7e6ef	false	single
09c2495a-39ac-4a73-bc00-0a7fa5a7e6ef	Basic	attribute.nameformat
09c2495a-39ac-4a73-bc00-0a7fa5a7e6ef	Role	attribute.name
c4f29b26-05b7-4277-9825-87c01c6e66cc	true	userinfo.token.claim
c4f29b26-05b7-4277-9825-87c01c6e66cc	true	id.token.claim
c4f29b26-05b7-4277-9825-87c01c6e66cc	true	access.token.claim
7020bfc8-5123-422d-8bbe-627b635046f1	true	userinfo.token.claim
7020bfc8-5123-422d-8bbe-627b635046f1	lastName	user.attribute
7020bfc8-5123-422d-8bbe-627b635046f1	true	id.token.claim
7020bfc8-5123-422d-8bbe-627b635046f1	true	access.token.claim
7020bfc8-5123-422d-8bbe-627b635046f1	family_name	claim.name
7020bfc8-5123-422d-8bbe-627b635046f1	String	jsonType.label
d5c04a96-a274-452f-a1e2-74e0effb5cfe	true	userinfo.token.claim
d5c04a96-a274-452f-a1e2-74e0effb5cfe	firstName	user.attribute
d5c04a96-a274-452f-a1e2-74e0effb5cfe	true	id.token.claim
d5c04a96-a274-452f-a1e2-74e0effb5cfe	true	access.token.claim
d5c04a96-a274-452f-a1e2-74e0effb5cfe	given_name	claim.name
d5c04a96-a274-452f-a1e2-74e0effb5cfe	String	jsonType.label
de6e4ab1-ec75-4bc5-84ca-207ce24268f6	true	userinfo.token.claim
de6e4ab1-ec75-4bc5-84ca-207ce24268f6	middleName	user.attribute
de6e4ab1-ec75-4bc5-84ca-207ce24268f6	true	id.token.claim
de6e4ab1-ec75-4bc5-84ca-207ce24268f6	true	access.token.claim
de6e4ab1-ec75-4bc5-84ca-207ce24268f6	middle_name	claim.name
de6e4ab1-ec75-4bc5-84ca-207ce24268f6	String	jsonType.label
f9d392f5-779d-4c9a-b3bc-132f56622e43	true	userinfo.token.claim
f9d392f5-779d-4c9a-b3bc-132f56622e43	nickname	user.attribute
f9d392f5-779d-4c9a-b3bc-132f56622e43	true	id.token.claim
f9d392f5-779d-4c9a-b3bc-132f56622e43	true	access.token.claim
f9d392f5-779d-4c9a-b3bc-132f56622e43	nickname	claim.name
f9d392f5-779d-4c9a-b3bc-132f56622e43	String	jsonType.label
74224636-315a-4a95-9add-15218fe19a69	true	userinfo.token.claim
74224636-315a-4a95-9add-15218fe19a69	username	user.attribute
74224636-315a-4a95-9add-15218fe19a69	true	id.token.claim
74224636-315a-4a95-9add-15218fe19a69	true	access.token.claim
74224636-315a-4a95-9add-15218fe19a69	preferred_username	claim.name
74224636-315a-4a95-9add-15218fe19a69	String	jsonType.label
e8ed7d01-0f8e-484b-8318-842282654de3	true	userinfo.token.claim
e8ed7d01-0f8e-484b-8318-842282654de3	profile	user.attribute
e8ed7d01-0f8e-484b-8318-842282654de3	true	id.token.claim
e8ed7d01-0f8e-484b-8318-842282654de3	true	access.token.claim
e8ed7d01-0f8e-484b-8318-842282654de3	profile	claim.name
e8ed7d01-0f8e-484b-8318-842282654de3	String	jsonType.label
091a3ee0-0283-4954-83d2-26b0bc3285d2	true	userinfo.token.claim
091a3ee0-0283-4954-83d2-26b0bc3285d2	picture	user.attribute
091a3ee0-0283-4954-83d2-26b0bc3285d2	true	id.token.claim
091a3ee0-0283-4954-83d2-26b0bc3285d2	true	access.token.claim
091a3ee0-0283-4954-83d2-26b0bc3285d2	picture	claim.name
091a3ee0-0283-4954-83d2-26b0bc3285d2	String	jsonType.label
41c0bb69-4391-4330-adca-ca1496231e8c	true	userinfo.token.claim
41c0bb69-4391-4330-adca-ca1496231e8c	website	user.attribute
41c0bb69-4391-4330-adca-ca1496231e8c	true	id.token.claim
41c0bb69-4391-4330-adca-ca1496231e8c	true	access.token.claim
41c0bb69-4391-4330-adca-ca1496231e8c	website	claim.name
41c0bb69-4391-4330-adca-ca1496231e8c	String	jsonType.label
b1f2d24d-67f3-4f7e-9835-1ce60eeb7f7d	true	userinfo.token.claim
b1f2d24d-67f3-4f7e-9835-1ce60eeb7f7d	gender	user.attribute
b1f2d24d-67f3-4f7e-9835-1ce60eeb7f7d	true	id.token.claim
b1f2d24d-67f3-4f7e-9835-1ce60eeb7f7d	true	access.token.claim
b1f2d24d-67f3-4f7e-9835-1ce60eeb7f7d	gender	claim.name
b1f2d24d-67f3-4f7e-9835-1ce60eeb7f7d	String	jsonType.label
99a72b14-cb28-4d78-a85e-1caad83e07c7	true	userinfo.token.claim
99a72b14-cb28-4d78-a85e-1caad83e07c7	birthdate	user.attribute
99a72b14-cb28-4d78-a85e-1caad83e07c7	true	id.token.claim
99a72b14-cb28-4d78-a85e-1caad83e07c7	true	access.token.claim
99a72b14-cb28-4d78-a85e-1caad83e07c7	birthdate	claim.name
99a72b14-cb28-4d78-a85e-1caad83e07c7	String	jsonType.label
4c626d0f-22fe-4fe1-9a91-67cb0a6a0435	true	userinfo.token.claim
4c626d0f-22fe-4fe1-9a91-67cb0a6a0435	zoneinfo	user.attribute
4c626d0f-22fe-4fe1-9a91-67cb0a6a0435	true	id.token.claim
4c626d0f-22fe-4fe1-9a91-67cb0a6a0435	true	access.token.claim
4c626d0f-22fe-4fe1-9a91-67cb0a6a0435	zoneinfo	claim.name
4c626d0f-22fe-4fe1-9a91-67cb0a6a0435	String	jsonType.label
edea1992-3b4c-4331-a59b-fd8f853242b4	true	userinfo.token.claim
edea1992-3b4c-4331-a59b-fd8f853242b4	locale	user.attribute
edea1992-3b4c-4331-a59b-fd8f853242b4	true	id.token.claim
edea1992-3b4c-4331-a59b-fd8f853242b4	true	access.token.claim
edea1992-3b4c-4331-a59b-fd8f853242b4	locale	claim.name
edea1992-3b4c-4331-a59b-fd8f853242b4	String	jsonType.label
2fa2007e-1d1e-4e7f-8eda-0745d44ee1f0	true	userinfo.token.claim
2fa2007e-1d1e-4e7f-8eda-0745d44ee1f0	updatedAt	user.attribute
2fa2007e-1d1e-4e7f-8eda-0745d44ee1f0	true	id.token.claim
2fa2007e-1d1e-4e7f-8eda-0745d44ee1f0	true	access.token.claim
2fa2007e-1d1e-4e7f-8eda-0745d44ee1f0	updated_at	claim.name
2fa2007e-1d1e-4e7f-8eda-0745d44ee1f0	String	jsonType.label
db6f4fe4-e76e-44df-9c91-a15071437579	true	userinfo.token.claim
db6f4fe4-e76e-44df-9c91-a15071437579	email	user.attribute
db6f4fe4-e76e-44df-9c91-a15071437579	true	id.token.claim
db6f4fe4-e76e-44df-9c91-a15071437579	true	access.token.claim
db6f4fe4-e76e-44df-9c91-a15071437579	email	claim.name
db6f4fe4-e76e-44df-9c91-a15071437579	String	jsonType.label
2357e6f2-979c-45bc-973c-aefaed358f64	true	userinfo.token.claim
2357e6f2-979c-45bc-973c-aefaed358f64	emailVerified	user.attribute
2357e6f2-979c-45bc-973c-aefaed358f64	true	id.token.claim
2357e6f2-979c-45bc-973c-aefaed358f64	true	access.token.claim
2357e6f2-979c-45bc-973c-aefaed358f64	email_verified	claim.name
2357e6f2-979c-45bc-973c-aefaed358f64	boolean	jsonType.label
6ff04c1a-89bd-4b3c-ac6d-c0b3d6e692b0	formatted	user.attribute.formatted
6ff04c1a-89bd-4b3c-ac6d-c0b3d6e692b0	country	user.attribute.country
6ff04c1a-89bd-4b3c-ac6d-c0b3d6e692b0	postal_code	user.attribute.postal_code
6ff04c1a-89bd-4b3c-ac6d-c0b3d6e692b0	true	userinfo.token.claim
6ff04c1a-89bd-4b3c-ac6d-c0b3d6e692b0	street	user.attribute.street
6ff04c1a-89bd-4b3c-ac6d-c0b3d6e692b0	true	id.token.claim
6ff04c1a-89bd-4b3c-ac6d-c0b3d6e692b0	region	user.attribute.region
6ff04c1a-89bd-4b3c-ac6d-c0b3d6e692b0	true	access.token.claim
6ff04c1a-89bd-4b3c-ac6d-c0b3d6e692b0	locality	user.attribute.locality
7288551f-ead5-4ddc-b277-ea2137b720f2	true	userinfo.token.claim
7288551f-ead5-4ddc-b277-ea2137b720f2	phoneNumber	user.attribute
7288551f-ead5-4ddc-b277-ea2137b720f2	true	id.token.claim
7288551f-ead5-4ddc-b277-ea2137b720f2	true	access.token.claim
7288551f-ead5-4ddc-b277-ea2137b720f2	phone_number	claim.name
7288551f-ead5-4ddc-b277-ea2137b720f2	String	jsonType.label
616187da-564c-4fc6-9296-d6298adc6c4c	true	userinfo.token.claim
616187da-564c-4fc6-9296-d6298adc6c4c	phoneNumberVerified	user.attribute
616187da-564c-4fc6-9296-d6298adc6c4c	true	id.token.claim
616187da-564c-4fc6-9296-d6298adc6c4c	true	access.token.claim
616187da-564c-4fc6-9296-d6298adc6c4c	phone_number_verified	claim.name
616187da-564c-4fc6-9296-d6298adc6c4c	boolean	jsonType.label
ecade6aa-3b21-4997-8724-606d5b0f8082	true	multivalued
ecade6aa-3b21-4997-8724-606d5b0f8082	foo	user.attribute
ecade6aa-3b21-4997-8724-606d5b0f8082	true	access.token.claim
ecade6aa-3b21-4997-8724-606d5b0f8082	realm_access.roles	claim.name
ecade6aa-3b21-4997-8724-606d5b0f8082	String	jsonType.label
7565b5ce-7c8a-4d67-ae17-b210c815ea39	true	multivalued
7565b5ce-7c8a-4d67-ae17-b210c815ea39	foo	user.attribute
7565b5ce-7c8a-4d67-ae17-b210c815ea39	true	access.token.claim
7565b5ce-7c8a-4d67-ae17-b210c815ea39	resource_access.${client_id}.roles	claim.name
7565b5ce-7c8a-4d67-ae17-b210c815ea39	String	jsonType.label
c333517f-2e1c-4fe6-a7d4-14c8012ebef5	true	userinfo.token.claim
c333517f-2e1c-4fe6-a7d4-14c8012ebef5	username	user.attribute
c333517f-2e1c-4fe6-a7d4-14c8012ebef5	true	id.token.claim
c333517f-2e1c-4fe6-a7d4-14c8012ebef5	true	access.token.claim
c333517f-2e1c-4fe6-a7d4-14c8012ebef5	upn	claim.name
c333517f-2e1c-4fe6-a7d4-14c8012ebef5	String	jsonType.label
110382a7-55a2-4396-8b40-3b7002f70b8e	true	multivalued
110382a7-55a2-4396-8b40-3b7002f70b8e	foo	user.attribute
110382a7-55a2-4396-8b40-3b7002f70b8e	true	id.token.claim
110382a7-55a2-4396-8b40-3b7002f70b8e	true	access.token.claim
110382a7-55a2-4396-8b40-3b7002f70b8e	groups	claim.name
110382a7-55a2-4396-8b40-3b7002f70b8e	String	jsonType.label
59e8300e-0cec-4787-ac07-ecc3133ff22f	foo	user.attribute
59e8300e-0cec-4787-ac07-ecc3133ff22f	true	access.token.claim
59e8300e-0cec-4787-ac07-ecc3133ff22f	realm_access.roles	claim.name
59e8300e-0cec-4787-ac07-ecc3133ff22f	String	jsonType.label
59e8300e-0cec-4787-ac07-ecc3133ff22f	true	multivalued
59e8300e-0cec-4787-ac07-ecc3133ff22f	true	userinfo.token.claim
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
master	60	300	3600	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	abd43275-b8e2-46a1-82ef-7ab5f190791b	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	d45c6ea2-a4c2-45b4-9985-d49fdf4f77a3	62c824b6-212c-41a3-907a-59aabdfc38a7	067fafa8-30af-4821-b005-5e6cc7455bb1	4d294674-b890-4e5b-85b1-131c9bac093f	3eba3d3a-435a-41d7-a597-b69d36f3d00a	2592000	f	900	t	f	757ddd25-64ef-4f2d-9bc4-27bff84dc42e	0	f	0	0	28fcb3c5-22d0-4a78-a368-856f4ab31853
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
cibaBackchannelTokenDeliveryMode	master	poll
cibaExpiresIn	master	120
cibaAuthRequestedUserHint	master	login_hint
parRequestUriLifespan	master	60
cibaInterval	master	5
displayName	master	Keycloak
displayNameHtml	master	<div class="kc-logo-text"><span>Keycloak</span></div>
bruteForceProtected	master	false
permanentLockout	master	false
maxFailureWaitSeconds	master	900
minimumQuickLoginWaitSeconds	master	60
waitIncrementSeconds	master	60
quickLoginCheckMilliSeconds	master	1000
maxDeltaTimeSeconds	master	43200
failureFactor	master	30
actionTokenGeneratedByAdminLifespan	master	43200
actionTokenGeneratedByUserLifespan	master	300
oauth2DeviceCodeLifespan	master	600
oauth2DevicePollingInterval	master	600
defaultSignatureAlgorithm	master	RS256
offlineSessionMaxLifespanEnabled	master	false
offlineSessionMaxLifespan	master	5184000
clientSessionIdleTimeout	master	0
clientSessionMaxLifespan	master	0
clientOfflineSessionIdleTimeout	master	0
clientOfflineSessionMaxLifespan	master	0
webAuthnPolicyRpEntityName	master	keycloak
webAuthnPolicySignatureAlgorithms	master	ES256
webAuthnPolicyRpId	master	
webAuthnPolicyAttestationConveyancePreference	master	not specified
webAuthnPolicyAuthenticatorAttachment	master	not specified
webAuthnPolicyRequireResidentKey	master	not specified
webAuthnPolicyUserVerificationRequirement	master	not specified
webAuthnPolicyCreateTimeout	master	0
webAuthnPolicyAvoidSameAuthenticatorRegister	master	false
webAuthnPolicyRpEntityNamePasswordless	master	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	master	ES256
webAuthnPolicyRpIdPasswordless	master	
webAuthnPolicyAttestationConveyancePreferencePasswordless	master	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	master	not specified
webAuthnPolicyRequireResidentKeyPasswordless	master	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	master	not specified
webAuthnPolicyCreateTimeoutPasswordless	master	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	master	false
client-policies.profiles	master	{"profiles":[]}
client-policies.policies	master	{"policies":[]}
_browser_header.contentSecurityPolicyReportOnly	master	
_browser_header.xContentTypeOptions	master	nosniff
_browser_header.xRobotsTag	master	none
_browser_header.xFrameOptions	master	SAMEORIGIN
_browser_header.xXSSProtection	master	1; mode=block
_browser_header.contentSecurityPolicy	master	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.strictTransportSecurity	master	max-age=31536000; includeSubDomains
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
master	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	master
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.redirect_uris (client_id, value) FROM stdin;
e107f0b2-639f-4168-a5ac-2939cb6fec9d	/realms/master/account/*
7aace810-2788-4d92-b0a5-32277701a059	/realms/master/account/*
fadb8b8b-105a-4891-83e1-330b7a900ce4	/admin/master/console/*
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
b9f231f0-1dd0-47ba-9baf-f595285bb96d	VERIFY_EMAIL	Verify Email	master	t	f	VERIFY_EMAIL	50
058878c8-cbfa-4c50-82e1-8e9602de5f6b	UPDATE_PROFILE	Update Profile	master	t	f	UPDATE_PROFILE	40
c41f4e17-ce1e-477a-8a4b-b4681e129ac7	CONFIGURE_TOTP	Configure OTP	master	t	f	CONFIGURE_TOTP	10
81a6c27b-ebec-4c5a-badb-d9b1b1f356f3	UPDATE_PASSWORD	Update Password	master	t	f	UPDATE_PASSWORD	30
75acaad7-755a-4fd9-811a-f81abd0c868b	terms_and_conditions	Terms and Conditions	master	f	f	terms_and_conditions	20
90ac62a7-ac59-40bc-9152-fa98e23f7ebb	update_user_locale	Update User Locale	master	t	f	update_user_locale	1000
686b0233-0ee0-40c4-abc8-7948ff4b83e3	delete_account	Delete Account	master	f	f	delete_account	60
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_uris (resource_id, value) FROM stdin;
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
7aace810-2788-4d92-b0a5-32277701a059	fb555894-c425-46fe-8896-41aeda07570f
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_attribute (name, value, user_id, id) FROM stdin;
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
c5f56978-e86f-491b-8796-91097740ac38	\N	7a5e92a9-ae4d-44d7-a1bd-55ede87f3cc7	f	t	\N	\N	\N	master	admin	1653134325176	\N	0
efe79764-f86e-40a3-a4d7-6545e9c34e07	\N	a97de053-229e-481a-9d88-28e879d29485	t	t	\N	\N	\N	master	byku	1653134442277	\N	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_group_membership (group_id, user_id) FROM stdin;
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
28fcb3c5-22d0-4a78-a368-856f4ab31853	c5f56978-e86f-491b-8796-91097740ac38
af89f514-69ea-4263-a537-a0703ae0fd33	c5f56978-e86f-491b-8796-91097740ac38
28fcb3c5-22d0-4a78-a368-856f4ab31853	efe79764-f86e-40a3-a4d7-6545e9c34e07
2c6b4e7f-2a7c-465d-9375-aa9aead86875	efe79764-f86e-40a3-a4d7-6545e9c34e07
\.


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_session_note (user_session, name, value) FROM stdin;
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.web_origins (client_id, value) FROM stdin;
fadb8b8b-105a-4891-83e1-330b7a900ce4	+
\.


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: databasechangeloglock pk_databasechangeloglock; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT pk_databasechangeloglock PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_css_preload; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_offline_css_preload ON public.offline_client_session USING btree (client_id, offline_flag);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_offline_uss_by_usersess; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_offline_uss_by_usersess ON public.offline_user_session USING btree (realm_id, offline_flag, user_session_id);


--
-- Name: idx_offline_uss_createdon; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_offline_uss_createdon ON public.offline_user_session USING btree (created_on);


--
-- Name: idx_offline_uss_preload; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_offline_uss_preload ON public.offline_user_session USING btree (offline_flag, created_on, user_session_id);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

