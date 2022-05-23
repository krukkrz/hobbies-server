package io.github.krukkrz.surfing.integrationTests;

import io.github.krukkrz.utils.AbstractIntegrationTest;
import io.javalin.testtools.JavalinTest;
import org.junit.jupiter.api.Test;

import static io.github.krukkrz.application.context.ApplicationContext.mongoSpotsDao;
import static io.github.krukkrz.utils.SpotGenerator.generateSpotWithIdForUser;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertTrue;

public class DeleteIntegrationTest extends AbstractIntegrationTest {

    @Test
    public void deletesSpotFromDb() {
        JavalinTest.test(app, (server, client) -> {
            //GIVEN
            var token = actAsDefaultUser();
            var spot = generateSpotWithIdForUser(token);
            mongoSpotsDao().save(spot, token);
            var ref = spot.getRef();

            //WHEN
            var response = client.delete("/spots/" + ref, null, r -> authorizationHeaders(r, token));

            //THEN
            assertEquals(response.code(), 204);
            response.close();
            assertTrue(mongoSpotsDao().findByRef(ref.toString(), "user-" + token).isEmpty());
        });
    }
}
