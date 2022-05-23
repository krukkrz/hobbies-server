package io.github.krukkrz.surfing.integrationTests;

import io.github.krukkrz.utils.AbstractIntegrationTest;
import io.javalin.testtools.JavalinTest;
import org.junit.jupiter.api.Test;

import static io.github.krukkrz.application.context.ApplicationContext.mongoSpotsDao;
import static io.github.krukkrz.application.context.ApplicationContext.objectMapper;
import static io.github.krukkrz.utils.SpotGenerator.generateSpotDto;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

public class CreateIntegrationTest extends AbstractIntegrationTest {

    @Test
    public void savesSpotInDatabase() {
        JavalinTest.test(app, (server, client) -> {
            //GIVEN
            var token = actAsDefaultUser();
            var spotDto = generateSpotDto();
            var json = objectMapper().writeValueAsString(spotDto);

            //WHEN
            var response = client.post("/spots", json, r -> authorizationHeaders(r, token));

            //THEN
            assertEquals(response.code(), 201);
            response.close();

            assertTrue(mongoSpotsDao().findAll("user-" + token).stream().anyMatch(
                    spot -> spot.getRef() != null
                            && spot.getCountry().equals(spotDto.country())
                            && spot.getCoolness().equals(spotDto.coolness())
                            && spot.getLink().equals(spotDto.link())
                            && spot.getName().equals(spotDto.name())
                            && spot.getStartDate().equals(spotDto.startDate())
                            && spot.getEndDate().equals(spotDto.endDate())
                            && spot.getSurfingType().equals(spotDto.surfingType())
            ));
        });
    }
}
