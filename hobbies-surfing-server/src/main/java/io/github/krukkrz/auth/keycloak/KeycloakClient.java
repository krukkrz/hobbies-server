package io.github.krukkrz.auth.keycloak;

import io.github.krukkrz.auth.UnauthorizedException;
import okhttp3.Request;
import okhttp3.Response;

import java.io.IOException;

import static io.github.krukkrz.application.ApplicationContext.objectMapper;
import static io.github.krukkrz.application.ApplicationContext.okHttpClient;

public class KeycloakClient {
    //todo take it from yml
    private final String userInfoEndpoint = "http://localhost:8080/auth/realms/master/protocol/openid-connect/userinfo";

    public UserInfo getUserInfo(String token) throws UnauthorizedException {
        Request request = new Request.Builder()
            .url(userInfoEndpoint)
            .addHeader("Authorization", "Bearer " + token)
            .build();
        try {
            var response = okHttpClient().newCall(request).execute();
            handle401Response(response);
            var objectMapper = objectMapper();
            return objectMapper.readValue(response.body().string(), UserInfo.class);
        } catch (IOException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    private void handle401Response(Response response) throws UnauthorizedException {
        if (response.code() == 401) {
            throw new UnauthorizedException();
        }
    }
}
