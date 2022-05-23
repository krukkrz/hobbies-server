package io.github.krukkrz.auth;

import io.github.krukkrz.surfing.model.Spot;
import io.github.krukkrz.utils.AbstractIntegrationTest;
import io.javalin.testtools.JavalinTest;
import org.junit.jupiter.api.Test;

import java.util.List;
import java.util.UUID;

import static io.github.krukkrz.application.context.ApplicationContext.mongoSpotsDao;
import static io.github.krukkrz.application.context.ApplicationContext.objectMapper;
import static io.github.krukkrz.utils.SpotGenerator.generateSpotDto;
import static io.github.krukkrz.utils.SpotGenerator.generateSpotWithIdForUser;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;

public class AuthIntegrationTest extends AbstractIntegrationTest {

    @Test
    public void otherUserCannotReadOthersSpots() {
        JavalinTest.test(app, ((server, client) -> {
            //GIVEN
            var token = actAsDefaultUser();
            var spotToSave = generateSpotWithIdForUser(token);
            var anotherSpot = generateSpotWithIdForUser(token);
            var ref = UUID.randomUUID();
            mongoSpotsDao().save(anotherSpot, null);
            spotToSave.setRef(ref);
            mongoSpotsDao().save(spotToSave, null);

            var otherToken = "other";
            actAsUserWithToken(otherToken);

            //WHEN
            var response = client.get("/spots/" + ref, r -> authorizationHeaders(r, otherToken));

            //THEN
            assertEquals(response.code(), 404);
        }));
    }

    @Test
    public void userFetchesAllSpotsCreatedByThem() {
        JavalinTest.test(app, ((server, client) -> {
            //GIVEN
            var token = actAsDefaultUser();
            var spot = generateSpotWithIdForUser(token);
            var spot2 = generateSpotWithIdForUser(token);
            mongoSpotsDao().save(spot, token);
            mongoSpotsDao().save(spot2, token);

            var otherToken = "other";
            actAsUserWithToken(otherToken);
            var spot3 = generateSpotWithIdForUser(otherToken);
            mongoSpotsDao().save(spot3, otherToken);

            //WHEN
            var response = client.get("/spots", r -> authorizationHeaders(r, otherToken));

            //THEN
            var spots = (List<Spot>) objectMapper().readValue(response.body().string(), List.class);
            assertEquals(1, spots.size());
        }));
    }

    @Test
    public void userCreatesSpotsInTheirContext() {
        JavalinTest.test(app, ((server, client) -> {
            //GIVEN
            var token = actAsDefaultUser();
            var spot = generateSpotWithIdForUser(token);
            var spot2 = generateSpotWithIdForUser(token);
            mongoSpotsDao().save(spot, null);
            mongoSpotsDao().save(spot2, null);

            var otherToken = "other";
            actAsUserWithToken(otherToken);
            var spotDto = generateSpotDto();
            var json = objectMapper().writeValueAsString(spotDto);

            //WHEN
            var response = client.post("/spots", json, r -> authorizationHeaders(r, otherToken));

            //THEN
            assertEquals(response.code(), 201);
            assertEquals(mongoSpotsDao().findAll("user-" + otherToken).size(), 1);
        }));
    }

    @Test
    public void userCanNotDeleteOthersSpots() {
        JavalinTest.test(app, (server, client) -> {
            //GIVEN
            var token = actAsDefaultUser();
            var spot = generateSpotWithIdForUser(token);
            mongoSpotsDao().save(spot, token);
            var ref = spot.getRef();

            var otherToken = "other";
            actAsUserWithToken(otherToken);

            //WHEN
            var response = client.delete("/spots/" + ref, null, r -> authorizationHeaders(r, otherToken));

            //THEN
            assertEquals(response.code(), 204);
            assertFalse(mongoSpotsDao().findByRef(ref.toString(), token).isEmpty());
        });
    }

    @Test
    public void userCanNotUpdateOthersSpots() {
        JavalinTest.test(app, (server, client) -> {
            //GIVEN
            var token = actAsDefaultUser();
            var spotDto = generateSpotDto("Updated Spot Name");
            var ref = spotDto.ref();

            var spot = generateSpotWithIdForUser(token);
            spot.setRef(ref);
            var originalSpotName = "Spot Name";
            spot.setName(originalSpotName);
            mongoSpotsDao().save(spot, token);

            var json = objectMapper().writeValueAsString(spotDto);

            var otherToken = "other";
            actAsUserWithToken(otherToken);

            //WHEN
            var response = client.put("/spots", json, r -> authorizationHeaders(r, otherToken));

            //THEN
            assertEquals(403, response.code());
            assertEquals(originalSpotName, mongoSpotsDao().findByRef(ref.toString(), token).get().getName());
        });
    }
}
