package io.github.krukkrz.surfing.integrationTests;

import io.github.krukkrz.common.ErrorResponse;
import io.github.krukkrz.surfing.dto.SpotDto;
import io.javalin.testtools.JavalinTest;
import org.junit.jupiter.api.Test;

import static io.github.krukkrz.application.context.ApplicationContext.mongoSpotsDao;
import static io.github.krukkrz.application.context.ApplicationContext.objectMapper;
import static io.github.krukkrz.utils.SpotGenerator.generateSpot;
import static io.github.krukkrz.utils.SpotGenerator.generateSpotDto;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

public class UpdateIntegrationTest extends AbstractIntegrationTest {

    @Test
    public void updatesSpotExistingInDb() {
        JavalinTest.test(app, (server, client) -> {
            //GIVEN
            var spotDto = generateSpotDto("Updated Spot Name");
            var ref = spotDto.ref();

            var spot = generateSpot();
            spot.setRef(ref);
            spot.setName("Spot Name");
            mongoSpotsDao().save(spot);

            var json = objectMapper().writeValueAsString(spotDto);

            //WHEN
            var response = client.put("/spots", json, authorizationHeaders);
            var updated = objectMapper().readValue(response.body().string(), SpotDto.class);

            //THEN
            assertEquals(response.code(), 204);
            assertEquals(updated, spotDto);
        });
    }

    @Test
    public void createsNewSpotIfNoneFoundInDbForGivenRef() {
        JavalinTest.test(app, (server, client) -> {
            //GIVEN
            var spotDto = generateSpotDto("Updated Spot Name");
            var json = objectMapper().writeValueAsString(spotDto);

            //WHEN
            var response = client.put("/spots", json, authorizationHeaders);
            var updated = objectMapper().readValue(response.body().string(), SpotDto.class);

            //THEN
            assertEquals(response.code(), 204);
            assertEquals(updated, spotDto);
        });
    }

    @Test
    public void returnsServerErrorWhenMultipleSpotsFoundForTheSameRef() {
        JavalinTest.test(app, (server, client) -> {
            //GIVEN
            var spotDto = generateSpotDto("Updated Spot Name");
            var ref = spotDto.ref();

            var spot = generateSpot();
            spot.setRef(ref);
            spot.setName("Spot Name");
            mongoSpotsDao().save(spot);
            mongoSpotsDao().save(spot);

            var json = objectMapper().writeValueAsString(spotDto);

            //WHEN
            var response = client.put("/spots", json, authorizationHeaders);
            var error = objectMapper().readValue(response.body().string(), ErrorResponse.class);

            //THEN
            assertEquals(response.code(), 500);
            assertNotNull(error.message());
        });
    }
}
