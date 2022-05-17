package io.github.krukkrz.surfing.integrationTests;

import io.javalin.testtools.JavalinTest;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;

import static io.github.krukkrz.application.context.ApplicationContext.objectMapper;
import static io.github.krukkrz.utils.SpotGenerator.generateSpotDto;
import static org.junit.jupiter.api.Assertions.assertEquals;

public class CreateSpotTest extends AbstractIntegrationTest {

    @Test
    public void savesSpotInDatabase() {
        JavalinTest.test(app, (server, client) -> {
            //GIVEN
            var spotDto = generateSpotDto();
            var json = objectMapper().writeValueAsString(spotDto);

            //WHEN
            var response = client.post("/spots", json, r -> {r.addHeader("Authorization", "Bearer token");});

            //THEN
            assertEquals(response.code(), 201);
            response.close();
        });
    }
}