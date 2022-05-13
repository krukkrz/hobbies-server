package io.github.krukkrz.application;

import com.fasterxml.jackson.databind.ObjectMapper;
import io.github.krukkrz.auth.Auth;
import io.github.krukkrz.auth.keycloak.KeycloakClient;
import okhttp3.OkHttpClient;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.Optional;
import java.util.Properties;

public class ApplicationContext {

    private static KeycloakClient keycloakClient;
    private static Auth auth;
    private static OkHttpClient okHttpClient;
    private static ObjectMapper objectMapper;
    private static Properties props;

    public static Properties props() {
        if (props == null) {
            props = new Properties();
            String rootPath = Optional.ofNullable(
                    Thread.currentThread()
                        .getContextClassLoader()
                        .getResource("")
                )
                .orElseThrow(() -> new RuntimeException("No properties file found..."))
                .getPath();

            try {
                props.load(new FileInputStream(rootPath + "app.properties"));
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }
        return props;
    }

    public static KeycloakClient keycloakClient() {
        if (keycloakClient == null) {
            keycloakClient = new KeycloakClient(props().getProperty("keycloak.user_info_url"));
        }
        return keycloakClient;
    }

    public static Auth auth() {
        if (auth == null) {
            auth = new Auth(keycloakClient());
        }
        return auth;
    }

    public static OkHttpClient okHttpClient() {
        if (okHttpClient == null) {
            okHttpClient = new OkHttpClient();
        }
        return okHttpClient;
    }

    public static ObjectMapper objectMapper() {
        if (objectMapper == null) {
            objectMapper = new ObjectMapper();
        }
        return objectMapper;
    }
}
