package io.github.krukkrz.auth;

import io.javalin.core.security.RouteRole;

public enum Role implements RouteRole {
    REGULAR_USER;

    public static Role fromString(String role) {
        try {
            return Role.valueOf(role);
        } catch (IllegalArgumentException e) {
            return null;
        }
    }
}
