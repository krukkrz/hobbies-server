package io.github.krukkrz.application;

import io.javalin.core.JavalinConfig;
import lombok.extern.slf4j.Slf4j;

import java.util.function.Consumer;

import static io.github.krukkrz.application.context.ApplicationContext.auth;
import static io.github.krukkrz.common.HeaderUtils.cleanHeaders;

@Slf4j
public class Config {
    public static Consumer<JavalinConfig> appConfig = config -> {
        var auth = auth();
        config.accessManager(auth.accessManager);
        config.requestLogger((ctx, ms) -> {
            log.info("New {} incoming request: {} {}", ctx.method(), cleanHeaders(ctx.headerMap()), ctx.body());
            log.info("Response [{}]: {}", ctx.status(), ctx.resultString());
        });
    };
}
