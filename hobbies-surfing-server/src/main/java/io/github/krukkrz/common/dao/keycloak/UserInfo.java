package io.github.krukkrz.common.dao.keycloak;

public record UserInfo(
    String sub,
    Boolean email_verified,
    String preferred_username,
    RealmAccess realm_access
) {
}
