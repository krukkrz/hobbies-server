package io.github.krukkrz.auth.keycloak;

import java.util.List;

public record RealmAccess(List<String> roles) {
}
