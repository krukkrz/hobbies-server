package io.github.krukkrz.application.database.dao.keycloak;

public record UserInfo(
    String sub,
    Boolean email_verified,
    String preferred_username,
    RealmAccess realm_access
) {
}
