package io.github.krukkrz;

import io.github.krukkrz.auth.UnauthorizedException;
import io.javalin.Javalin;

import static io.github.krukkrz.application.context.ApplicationContext.auth;
import static io.github.krukkrz.application.context.ApplicationContext.spotsRepository;
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
            path("dbtest", () -> {
                get(ctx -> {
                    spotsRepository().test();
                    ctx.result("Check DB!");
                }, REGULAR_USER);
            });
        }).exception(UnauthorizedException.class, (e, ctx) -> ctx.status(401));
    }


}
