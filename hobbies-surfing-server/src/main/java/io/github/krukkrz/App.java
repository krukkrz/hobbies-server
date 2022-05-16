package io.github.krukkrz;

import io.github.krukkrz.auth.UnauthorizedException;
import io.github.krukkrz.common.ErrorResponse;
import io.github.krukkrz.surfing.SpotsHandler;
import io.javalin.Javalin;
import lombok.extern.slf4j.Slf4j;

import java.util.NoSuchElementException;

import static io.github.krukkrz.application.context.ApplicationContext.auth;
import static io.github.krukkrz.auth.Role.REGULAR_USER;
import static io.github.krukkrz.common.HeaderUtils.cleanHeaders;
import static io.javalin.Javalin.create;
import static io.javalin.apibuilder.ApiBuilder.get;
import static io.javalin.apibuilder.ApiBuilder.path;
import static io.javalin.apibuilder.ApiBuilder.post;

@Slf4j
public class App {

    private static Javalin app;

    public static void main(String[] args) {
        getApp();
    }

    public static Javalin getApp() {
        var auth = auth();
        app = create(
            config -> {
                config.accessManager(auth.accessManager);
                config.requestLogger((ctx, ms) -> {
                    log.info("New {} incoming request: {} {}", ctx.method(), cleanHeaders(ctx.headerMap()), ctx.body());
                    log.info("Response [{}]: {}", ctx.status(), ctx.resultString());
                });
            }
        ).start(8081);

        app.routes(() -> {
                path("hello", () -> {
                    get(ctx -> ctx.result("hello world!"), REGULAR_USER);
                });
                path("spots", () -> {
                    get(SpotsHandler::handleReadAll, REGULAR_USER);
                    get("/{ref}", SpotsHandler::handleReadByRef, REGULAR_USER);
                    post(SpotsHandler::handleCreate, REGULAR_USER);
                });
            }).exception(UnauthorizedException.class, (e, ctx) -> ctx.status(401))
            .exception(NoSuchElementException.class, (e, ctx) -> {
                ctx.status(404);
                ctx.json(new ErrorResponse(e.getMessage()));
            });
        return app;
    }
}
