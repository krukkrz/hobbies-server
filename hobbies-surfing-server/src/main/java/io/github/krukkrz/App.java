package io.github.krukkrz;

import io.github.krukkrz.auth.UnauthorizedException;
import io.github.krukkrz.surfing.SpotsHandler;
import io.javalin.Javalin;

import static io.github.krukkrz.application.context.ApplicationContext.auth;
import static io.github.krukkrz.auth.Role.REGULAR_USER;
import static io.javalin.Javalin.create;
import static io.javalin.apibuilder.ApiBuilder.get;
import static io.javalin.apibuilder.ApiBuilder.path;
import static io.javalin.apibuilder.ApiBuilder.post;

public class App {
    public static void main(String[] args) {
        var auth = auth();

        var app = create(
            config -> config.accessManager(auth.accessManager)
        ).start(8081);

        app.routes(() -> {
            path("hello", () -> {
                get(ctx -> ctx.result("hello world!"), REGULAR_USER);
            });
            path("spots", () -> {
                post(SpotsHandler::handleCreate, REGULAR_USER);
            });
        }).exception(UnauthorizedException.class, (e, ctx) -> ctx.status(401));
    }
}
