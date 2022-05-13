package io.github.krukkrz.auth.keycloak;

import okhttp3.Request;
import okhttp3.ResponseBody;

import java.io.IOException;

import static io.github.krukkrz.application.ApplicationContext.objectMapper;
import static io.github.krukkrz.application.ApplicationContext.okHttpClient;

public class KeycloakClient {
    //todo take it from yml
    private String userInfoEndpoint = "http://localhost:8080/auth/realms/master/protocol/openid-connect/userinfo";

    public UserInfo getUserInfo(String token) {
        Request request = new Request.Builder()
            .url(userInfoEndpoint)
            .addHeader("Authorization", "Bearer " + token)
            .build();
        ResponseBody responseBody = null;
        try {
            responseBody = okHttpClient().newCall(request).execute().body();
            //todo debug why not working
            return objectMapper().readValue(responseBody.string(), UserInfo.class);
        } catch (IOException e) {
            e.printStackTrace();
            //todo handle unouthorised
            throw new RuntimeException(e);
        }
    }
}
