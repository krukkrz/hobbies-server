package io.github.krukkrz.auth;

import io.github.krukkrz.application.database.dao.keycloak.KeycloakClient;
import io.github.krukkrz.application.database.dao.keycloak.RealmAccess;
import io.github.krukkrz.application.database.dao.keycloak.UserInfo;
import io.javalin.core.security.AccessManager;
import org.jetbrains.annotations.NotNull;

import java.util.Set;
import java.util.stream.Collectors;

import static java.util.Collections.emptyList;

public class Auth {

    private final KeycloakClient keycloakClient;
    public AccessManager accessManager = (handler, ctx, permittedRoles) -> {
        var userInfo = getUserInfo(ctx.header("Authorization"));
        var userRoles = getUserRoles(userInfo);

        if (permittedRoles.stream().anyMatch(userRoles::contains)) {
            ctx.sessionAttribute("userId", userInfo.sub());
            handler.handle(ctx);
        } else {
            ctx.status(401).result("Unauthorized");
        }
    };

    @NotNull
    public Set<Role> getUserRoles(UserInfo userInfo) {
        return userInfo.realm_access().roles()
                .stream()
                .map(String::toUpperCase)
                .map(Role::fromString)
                .collect(Collectors.toSet());
    }

    public Auth(KeycloakClient keycloakClient) {
        this.keycloakClient = keycloakClient;
    }

    public UserInfo getUserInfo(String bearerToken) throws UnauthorizedException {
        if (bearerToken == null) {
            return new UserInfo("", false, "", new RealmAccess(emptyList()));
        }
        var token = bearerToken.substring(7);
        return keycloakClient.getUserInfo(token);
    }
}
