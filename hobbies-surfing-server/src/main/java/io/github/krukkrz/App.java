package io.github.krukkrz;

import io.github.krukkrz.application.ExceptionHandler;
import io.github.krukkrz.auth.UnauthorizedException;
import io.github.krukkrz.common.ErrorResponse;
import io.github.krukkrz.common.exceptions.ForbiddenException;
import io.github.krukkrz.common.exceptions.MultipleEntitiesFound;
import io.github.krukkrz.surfing.SpotsHandler;
import io.javalin.Javalin;
import lombok.extern.slf4j.Slf4j;

import java.util.NoSuchElementException;

import static io.github.krukkrz.application.Config.appConfig;
import static io.github.krukkrz.auth.Role.REGULAR_USER;
import static io.javalin.Javalin.create;
import static io.javalin.apibuilder.ApiBuilder.delete;
import static io.javalin.apibuilder.ApiBuilder.get;
import static io.javalin.apibuilder.ApiBuilder.path;
import static io.javalin.apibuilder.ApiBuilder.post;
import static io.javalin.apibuilder.ApiBuilder.put;

@Slf4j
public class App {

    private static Javalin app;

    public static void main(String[] args) {
        getApp().start(8081);
    }

    public static Javalin getApp() {
        app = create(appConfig)
                .routes(() -> {
                    path("spots", () -> {
                        get(SpotsHandler::handleReadAll, REGULAR_USER);
                        get("/{ref}", SpotsHandler::handleReadByRef, REGULAR_USER);
                        post(SpotsHandler::handleCreate, REGULAR_USER);
                        put(SpotsHandler::handleUpdate, REGULAR_USER);
                        delete("/{ref}", SpotsHandler::handleDelete, REGULAR_USER);
                    });
                })
                .exception(UnauthorizedException.class, ExceptionHandler::handleUnauthorizedException)
                .exception(NoSuchElementException.class, ExceptionHandler::handleNoSuchElementException)
                .exception(MultipleEntitiesFound.class, ExceptionHandler::handleMultipleEntitiesException)
                .exception(ForbiddenException.class, ExceptionHandler::handleForbiddenException)
                .exception(RuntimeException.class, ExceptionHandler::handleRuntimeException);
        return app;
    }
}
