package io.github.krukkrz.application;

import io.github.krukkrz.auth.UnauthorizedException;
import io.github.krukkrz.common.ErrorResponse;
import io.javalin.http.Context;

import java.util.NoSuchElementException;

public class ExceptionHandler {

    public static void handleUnauthorizedException(UnauthorizedException e, Context ctx) {
        ctx.status(401);
    }

    public static void handleNoSuchElementException(NoSuchElementException e, Context ctx) {
        ctx.status(404);
        ctx.json(new ErrorResponse(e.getMessage()));
    }
}
