package io.github.krukkrz.surfing.integrationTests;

import com.fasterxml.jackson.core.JsonProcessingException;
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
import io.github.krukkrz.auth.UnauthorizedException;
import io.github.krukkrz.common.dao.keycloak.KeycloakClient;
import io.github.krukkrz.common.dao.keycloak.RealmAccess;
import io.github.krukkrz.common.dao.keycloak.UserInfo;
import io.javalin.Javalin;
import okhttp3.Request;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;

import java.io.IOException;
import java.util.List;
import java.util.function.Consumer;

import static io.github.krukkrz.application.context.ApplicationContext.objectMapper;
import static io.github.krukkrz.application.context.ApplicationContext.runTestMode;
import static io.github.krukkrz.application.context.ApplicationContext.useEmbeddedMongodb;
import static io.github.krukkrz.application.context.ApplicationContext.useMockedKeycloakClient;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

public abstract class AbstractIntegrationTest {

    private static final String DATABASE_NAME = "embedded";

    private MongodExecutable mongodExe;
    private MongodProcess mongod;
    private MongoClient mongo;
    private KeycloakClient mockedKeycloakClient;

    protected Javalin app;

    @BeforeEach
    public void setup() throws IOException, UnauthorizedException {
        runTestMode();

        MongodStarter starter = MongodStarter.getDefaultInstance();
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

        useEmbeddedMongodb(db);
        mockedKeycloakClient = mock(KeycloakClient.class);
        useMockedKeycloakClient(mockedKeycloakClient);
        app = App.getApp();

        when(mockedKeycloakClient.getUserInfo(any()))
                .thenReturn(new UserInfo("sub", true, "username", new RealmAccess(List.of("regular_user"))));
    }

    @AfterEach
    public void after() {
        if (this.mongod != null) {
            this.mongod.stop();
            this.mongodExe.stop();
        }
    }

    protected Consumer<Request.Builder> authorizationHeaders = r -> {
        r.addHeader("Authorization", "Bearer token");
    };
}
