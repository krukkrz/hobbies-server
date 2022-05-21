package io.github.krukkrz.surfing.integrationTests;

import io.github.krukkrz.surfing.model.Spot;
import io.javalin.testtools.JavalinTest;
import org.junit.jupiter.api.Test;

import java.util.List;
import java.util.UUID;

import static io.github.krukkrz.application.context.ApplicationContext.mongoSpotsDao;
import static io.github.krukkrz.application.context.ApplicationContext.objectMapper;
import static io.github.krukkrz.utils.SpotGenerator.generateSpot;
import static io.github.krukkrz.utils.SpotGenerator.generateSpotWithId;
import static org.junit.jupiter.api.Assertions.assertEquals;

public class ReadIntegrationTest extends AbstractIntegrationTest{

    @Test
    public void fetchesAllSpotsFromDb() {
        JavalinTest.test(app, ((server, client) -> {
            //GIVEN
            var spot = generateSpotWithId();
            var spot2 = generateSpotWithId();
            mongoSpotsDao().save(spot);
            mongoSpotsDao().save(spot2);

            //WHEN
            var response = client.get("/spots", authorizationHeaders);

            //THEN
            var spots = (List<Spot>) objectMapper().readValue(response.body().string(), List.class);
            assertEquals(spots.size(), 2);
        }));
    }

    @Test
    public void fetchesSpotByRefFromDb() {
        JavalinTest.test(app, ((server, client) -> {
            //GIVEN
            var spotToSave = generateSpotWithId();
            var anotherSpot = generateSpotWithId();
            var ref = UUID.randomUUID();
            mongoSpotsDao().save(anotherSpot);
            spotToSave.setRef(ref);
            mongoSpotsDao().save(spotToSave);

            //WHEN
            var response = client.get("/spots/"+ref, authorizationHeaders);

            //THEN
            var spotByRef = objectMapper().readValue(response.body().string(), Spot.class);
            assertEquals(spotByRef.getRef(), ref);
        }));
    }
}
