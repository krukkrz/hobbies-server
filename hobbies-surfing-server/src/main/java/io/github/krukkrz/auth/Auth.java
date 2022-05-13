package io.github.krukkrz.auth;

import io.github.krukkrz.auth.keycloak.KeycloakClient;
import io.javalin.core.security.AccessManager;

import java.util.Collections;
import java.util.Set;
import java.util.stream.Collectors;

import static io.github.krukkrz.application.ApplicationContext.auth;
import static java.util.Collections.emptySet;

public class Auth {

    private final KeycloakClient keycloakClient;

    public Auth(KeycloakClient keycloakClient) {
        this.keycloakClient = keycloakClient;
    }

    public AccessManager accessManager = (handler, ctx, permittedRoles) -> {
        var userRoles = getUserRoles(ctx.header("Authorization"));
        if (permittedRoles.stream().anyMatch(userRoles::contains)) {
            handler.handle(ctx);
        } else {
            ctx.status(401).result("Unauthorized");
        }
    };

    public Set<Role> getUserRoles(String bearerToken) {
        if (bearerToken == null) return emptySet();
        var token = bearerToken.substring(7);
        var userInfo = keycloakClient.getUserInfo(token);
        return userInfo.realm_access().roles()
            .stream()
            .map(String::toUpperCase)
            .map(Role::valueOf)
            .collect(Collectors.toSet());
    }
}
