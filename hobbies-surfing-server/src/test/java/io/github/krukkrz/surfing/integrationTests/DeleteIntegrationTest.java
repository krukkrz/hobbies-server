package io.github.krukkrz.surfing.integrationTests;

import io.javalin.testtools.JavalinTest;
import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;

import static io.github.krukkrz.application.context.ApplicationContext.mongoSpotsDao;
import static io.github.krukkrz.utils.SpotGenerator.generateSpot;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

public class DeleteIntegrationTest extends AbstractIntegrationTest {

    @Test
    public void deletesSpotFromDb() {
        JavalinTest.test(app, (server, client) -> {
            //GIVEN
            var spot = generateSpot();
            mongoSpotsDao().save(spot);

            var ref = spot.getRef();
            //WHEN
            var response = client.delete("/spots/" + ref, null, authorizationHeaders);

            //THEN
            assertEquals(response.code(), 204);
            assertTrue(mongoSpotsDao().findByRef(ref.toString()).isEmpty());
        });
    }
}
