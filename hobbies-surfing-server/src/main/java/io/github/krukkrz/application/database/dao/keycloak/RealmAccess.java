package io.github.krukkrz.application.database.dao.keycloak;

import java.util.List;

public record RealmAccess(List<String> roles) {
}
