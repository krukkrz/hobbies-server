package io.github.krukkrz;

import io.github.krukkrz.auth.Auth;
import io.javalin.Javalin;
import io.javalin.core.security.AccessManager;

import static io.github.krukkrz.application.ApplicationContext.auth;
import static io.github.krukkrz.auth.Role.REGULAR_USER;
import static io.javalin.apibuilder.ApiBuilder.get;
import static io.javalin.apibuilder.ApiBuilder.path;

public class App {
    public static void main(String[] args) {
        var auth = auth();

        var app = Javalin.create(
            config -> config.accessManager(auth.accessManager)
        ).start(8081);


        app.routes(() -> {
            path("hello", () -> {
                get(ctx -> ctx.result("hello world!"), REGULAR_USER);
            });
        });
    }


}
