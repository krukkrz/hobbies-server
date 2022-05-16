package io.github.krukkrz.surfing.integrationTests;

import com.mongodb.BasicDBObject;
import com.mongodb.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import de.flapdoodle.embed.mongo.MongodExecutable;
import de.flapdoodle.embed.mongo.MongodProcess;
import de.flapdoodle.embed.mongo.MongodStarter;
import de.flapdoodle.embed.mongo.config.MongodConfig;
import de.flapdoodle.embed.mongo.config.Net;
import de.flapdoodle.embed.mongo.distribution.Version;
import de.flapdoodle.embed.process.runtime.Network;
import io.github.krukkrz.App;
import io.javalin.Javalin;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;

import java.io.IOException;
import java.util.Date;

import static io.github.krukkrz.application.context.ApplicationContext.mongoDatabase;
import static io.github.krukkrz.application.context.ApplicationContext.runTestMode;
import static io.github.krukkrz.application.context.ApplicationContext.useEmbeddedMongodb;
import static org.junit.jupiter.api.Assertions.assertEquals;

public abstract class AbstractIntegrationTest {

    private static final String DATABASE_NAME = "embedded";

    private MongodExecutable mongodExe;
    private MongodProcess mongod;
    private MongoClient mongo;

    protected Javalin app;

    @BeforeEach
    public void setup() throws IOException {
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
        app = App.getApp();
    }

    @AfterEach
    public void afterEach() {
        if (this.mongod != null) {
            this.mongod.stop();
            this.mongodExe.stop();
        }
    }

    //    @Test
    public void shouldCreateNewObjectInEmbeddedMongoDb() {
        // given
        mongoDatabase().createCollection("testCollection");
        MongoCollection<BasicDBObject> col = mongoDatabase().getCollection("testCollection", BasicDBObject.class);

        // when
        col.insertOne(new BasicDBObject("testDoc", new Date()));

        // then
        assertEquals(1L, col.countDocuments());
    }
}
