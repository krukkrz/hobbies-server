package io.github.krukkrz.common.dao.keycloak;

import io.github.krukkrz.auth.UnauthorizedException;
import okhttp3.Request;
import okhttp3.Response;

import java.io.IOException;

import static io.github.krukkrz.application.context.ApplicationContext.objectMapper;
import static io.github.krukkrz.application.context.ApplicationContext.okHttpClient;

public class KeycloakClient {

    private final String userInfoEndpoint;

    public KeycloakClient(String userInfoEndpoint) {
        this.userInfoEndpoint = userInfoEndpoint;
    }


    public UserInfo getUserInfo(String token) throws UnauthorizedException {
        Request request = new Request.Builder()
            .url(userInfoEndpoint)
            .addHeader("Authorization", "Bearer " + token)
            .build();
        try {
            var response = okHttpClient().newCall(request).execute();
            handle401Response(response);
            var objectMapper = objectMapper();
            var userInfo = objectMapper.readValue(response.body().string(), UserInfo.class);
            response.close();
            return userInfo;
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
