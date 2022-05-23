package io.github.krukkrz.surfing;

import com.fasterxml.jackson.core.JsonProcessingException;
import io.github.krukkrz.surfing.dto.SpotDto;
import io.javalin.http.Context;
import org.jetbrains.annotations.Nullable;

import java.util.UUID;

import static io.github.krukkrz.application.context.ApplicationContext.objectMapper;
import static io.github.krukkrz.application.context.ApplicationContext.spotsService;
import static io.github.krukkrz.common.Constants.USER_ID_SESSION_ATTRIBUTE;

public class SpotsHandler {

    public static void handleCreate(Context ctx) {
        try {
            var spotDto = objectMapper().readValue(ctx.body(), SpotDto.class);
            spotsService().create(spotDto, getUserId(ctx));
            ctx.status(201);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
            ctx.status(400);
        }
    }

    public static void handleReadAll(Context ctx) {
        var spots = spotsService().findAll(getUserId(ctx));
        ctx.json(spots);
        ctx.status(200);
    }

    public static void handleReadByRef(Context ctx) {
        var spot = spotsService().findByRef(ctx.pathParam("ref"), getUserId(ctx));
        ctx.json(spot);
        ctx.status(200);
    }

    public static void handleUpdate(Context ctx) throws JsonProcessingException {
        var spotDto = objectMapper().readValue(ctx.body(), SpotDto.class);
        var updated = spotsService().update(spotDto, getUserId(ctx));
        ctx.json(updated);
        ctx.status(200);
    }

    public static void handleDelete(Context ctx) {
        var ref = UUID.fromString(ctx.pathParam("ref"));
        spotsService().delete(ref, getUserId(ctx));
        ctx.status(204);
    }

    @Nullable
    private static String getUserId(Context ctx) {
        return ctx.sessionAttribute(USER_ID_SESSION_ATTRIBUTE);
    }
}
