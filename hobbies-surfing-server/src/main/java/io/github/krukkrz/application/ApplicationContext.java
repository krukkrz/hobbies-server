package io.github.krukkrz.application;

import com.fasterxml.jackson.databind.ObjectMapper;
import io.github.krukkrz.auth.Auth;
import io.github.krukkrz.auth.keycloak.KeycloakClient;
import okhttp3.OkHttpClient;

public class ApplicationContext {

    private static KeycloakClient keycloakClient;
    private static Auth auth;
    private static OkHttpClient okHttpClient;
    private static ObjectMapper objectMapper;

    public static KeycloakClient keycloakClient() {
        if (keycloakClient == null) keycloakClient = new KeycloakClient();
        return keycloakClient;
    }

    public static Auth auth() {
        if (auth == null) auth = new Auth(keycloakClient());
        return auth;
    }

    public static OkHttpClient okHttpClient() {
        if (okHttpClient == null) okHttpClient = new OkHttpClient();
        return okHttpClient;
    }

    public static ObjectMapper objectMapper() {
        if (objectMapper == null) objectMapper = new ObjectMapper();
        return objectMapper;
    }
}
