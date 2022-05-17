package io.github.krukkrz;

import io.github.krukkrz.application.ExceptionHandler;
import io.github.krukkrz.auth.UnauthorizedException;
import io.github.krukkrz.common.ErrorResponse;
import io.github.krukkrz.surfing.SpotsHandler;
import io.javalin.Javalin;
import lombok.extern.slf4j.Slf4j;

import java.util.NoSuchElementException;

import static io.github.krukkrz.application.Config.appConfig;
import static io.github.krukkrz.application.ExceptionHandler.handleUnauthorizedException;
import static io.github.krukkrz.auth.Role.REGULAR_USER;
import static io.javalin.Javalin.create;
import static io.javalin.apibuilder.ApiBuilder.get;
import static io.javalin.apibuilder.ApiBuilder.path;
import static io.javalin.apibuilder.ApiBuilder.post;

@Slf4j
public class App {

    private static Javalin app;

    public static void main(String[] args) {
        getApp().start(8081);
    }

    public static Javalin getApp() {
        app = create(appConfig)
                .routes(() -> {
                    path("hello", () -> {
                        get(ctx -> ctx.result("hello world!"), REGULAR_USER);
                    });
                    path("spots", () -> {
                        get(SpotsHandler::handleReadAll, REGULAR_USER);
                        get("/{ref}", SpotsHandler::handleReadByRef, REGULAR_USER);
                        post(SpotsHandler::handleCreate, REGULAR_USER);
                    });
                })
                .exception(UnauthorizedException.class, ExceptionHandler::handleUnauthorizedException)
                .exception(NoSuchElementException.class, ExceptionHandler::handleNoSuchElementException);
        return app;
    }
}
