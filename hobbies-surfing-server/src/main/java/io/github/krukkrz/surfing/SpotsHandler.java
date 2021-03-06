package io.github.krukkrz.surfing;

import com.fasterxml.jackson.core.JsonProcessingException;
import io.github.krukkrz.surfing.dto.SpotDto;
import io.javalin.http.Context;

import java.util.UUID;

import static io.github.krukkrz.application.context.ApplicationContext.objectMapper;
import static io.github.krukkrz.application.context.ApplicationContext.spotsService;

public class SpotsHandler {

    public static void handleCreate(Context ctx) {
        try {
            var spotDto = objectMapper().readValue(ctx.body(), SpotDto.class);
            spotsService().create(spotDto);
            ctx.status(201);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
            ctx.status(400);
        }
    }

    public static void handleReadAll(Context ctx) {
        var spots = spotsService().findAll();
        ctx.json(spots);
        ctx.status(200);
    }

    public static void handleReadByRef(Context ctx) {
        var spot = spotsService().findByRef(ctx.pathParam("ref"));
        ctx.json(spot);
        ctx.status(200);
    }

    public static void handleUpdate(Context ctx) throws JsonProcessingException {
        var spotDto = objectMapper().readValue(ctx.body(), SpotDto.class);
        var updated = spotsService().update(spotDto);
        ctx.json(updated);
        ctx.status(200);
    }

    public static void handleDelete(Context ctx) {
        var ref = UUID.fromString(ctx.pathParam("ref"));
        spotsService().delete(ref);
        ctx.status(204);
    }
}
