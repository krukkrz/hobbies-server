package io.github.krukkrz.utils;

import com.mongodb.MongoClient;
import com.mongodb.client.MongoDatabase;
import de.flapdoodle.embed.mongo.MongodExecutable;
import de.flapdoodle.embed.mongo.MongodProcess;
import de.flapdoodle.embed.mongo.MongodStarter;
import de.flapdoodle.embed.mongo.config.MongodConfig;
import de.flapdoodle.embed.mongo.config.Net;
import de.flapdoodle.embed.mongo.distribution.Version;
import de.flapdoodle.embed.process.runtime.Network;
import io.github.krukkrz.App;
import io.github.krukkrz.application.database.dao.keycloak.KeycloakClient;
import io.github.krukkrz.application.database.dao.keycloak.RealmAccess;
import io.github.krukkrz.application.database.dao.keycloak.UserInfo;
import io.github.krukkrz.auth.UnauthorizedException;
import io.javalin.Javalin;
import okhttp3.Request;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;

import java.io.IOException;
import java.util.List;
import java.util.function.Consumer;

import static io.github.krukkrz.application.context.ApplicationContext.clearContext;
import static io.github.krukkrz.application.context.ApplicationContext.runTestMode;
import static io.github.krukkrz.application.context.ApplicationContext.setMongoDatabase;
import static io.github.krukkrz.application.context.ApplicationContext.useMockedKeycloakClient;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

public abstract class AbstractIntegrationTest {

    private static final String DATABASE_NAME = "embedded";

    private MongodExecutable mongodExe;
    private MongodProcess mongod;
    private MongoClient mongo;
    private static KeycloakClient mockedKeycloakClient;

    protected Javalin app;
    private static final MongodStarter starter = MongodStarter.getDefaultInstance();


    @BeforeEach
    public void setup() throws IOException, UnauthorizedException {
        runTestMode();

        String bindIp = "localhost";
        int port = 12345;
        MongodConfig mongodConfig = MongodConfig.builder()
                .version(Version.Main.PRODUCTION)
                .net(new Net(bindIp, port, Network.localhostIsIPv6()))
                .build();

        this.mongodExe = starter.prepare(mongodConfig);
        this.mongod = mongodExe.start();
        this.mongo = new MongoClient(bindIp, port);

        MongoDatabase db = mongo.getDatabase(DATABASE_NAME);
        setMongoDatabase(db);
        mockedKeycloakClient = mock(KeycloakClient.class);
        useMockedKeycloakClient(mockedKeycloakClient);
        app = App.getApp();
    }

    @AfterEach
    public void teardown() {
        if (mongod != null) {
            mongod.stop();
            mongodExe.stop();
        }
        clearContext();
    }

    protected static void actAsUserWithToken(String token) throws UnauthorizedException {
        when(mockedKeycloakClient.getUserInfo(token))
                .thenReturn(new UserInfo("user-" + token, true, "username", new RealmAccess(List.of("regular_user"))));
    }

    protected static String actAsDefaultUser() throws UnauthorizedException {
        var token = "default";
        actAsUserWithToken(token);
        return token;
    }

    protected void authorizationHeaders(Request.Builder r, String token) {
        r.addHeader("Authorization", "Bearer "+token);
        r.addHeader("Content-type", "application/json");
    }
}
