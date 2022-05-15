package io.github.krukkrz.auth;

import io.github.krukkrz.common.dao.keycloak.KeycloakClient;
import io.github.krukkrz.common.dao.keycloak.RealmAccess;
import io.github.krukkrz.common.dao.keycloak.UserInfo;
import io.javalin.http.Context;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.List;

import static io.github.krukkrz.auth.Role.REGULAR_USER;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
public class AuthTest {

    @Mock
    private KeycloakClient keycloakClient;

    private final Context ctx = mock(Context.class);

    private Auth auth;

    @BeforeEach
    public void setup() {
        auth = new Auth(keycloakClient);
    }

    @Test
    public void getRoles_returnsRoles() throws UnauthorizedException {
        //GIVEN
        var bearerToken = "Bearer token";
        var token = "token";
        var userInfo = new UserInfo(
            "sub",
            true,
            "username",
            new RealmAccess(List.of("regular_user"))
        );

        when(keycloakClient.getUserInfo(token)).thenReturn(userInfo);

        //WHEN
        var userRoles = auth.getUserRoles(bearerToken);

        //THEN
        assertTrue(userRoles.contains(REGULAR_USER));
    }
}