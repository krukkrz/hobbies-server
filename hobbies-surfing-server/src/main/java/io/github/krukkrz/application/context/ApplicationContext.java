package io.github.krukkrz.application.context;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoDatabase;
import io.github.krukkrz.auth.Auth;
import io.github.krukkrz.common.dao.keycloak.KeycloakClient;
import io.github.krukkrz.common.dao.mongo.MongoSpotsDao;
import io.github.krukkrz.surfing.SpotsRepository;
import io.github.krukkrz.surfing.SpotsService;
import lombok.extern.slf4j.Slf4j;
import okhttp3.OkHttpClient;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Optional;
import java.util.Properties;

@Slf4j
public class ApplicationContext {

    private static KeycloakClient keycloakClient;
    private static Auth auth;
    private static OkHttpClient okHttpClient;
    private static ObjectMapper objectMapper;
    private static Properties props;
    private static MongoDatabase mongoDatabase;
    private static MongoSpotsDao mongoSpotsDao;
    private static SpotsRepository spotsRepository;
    private static SpotsService spotsService;

    private static boolean isTest = false;

    public static void runTestMode() {
        isTest = true;
    }

    public static SpotsService spotsService() {
        if (spotsService == null) {
            spotsService = new SpotsService(spotsRepository());
        }
        return spotsService;
    }

    public static SpotsRepository spotsRepository() {
        if (spotsRepository == null) {
            spotsRepository = new SpotsRepository(mongoSpotsDao());
        }
        return spotsRepository;
    }

    public static MongoSpotsDao mongoSpotsDao() {
        if (mongoSpotsDao == null) {
            mongoSpotsDao = new MongoSpotsDao();
        }
        return mongoSpotsDao;
    }

    public static void useEmbeddedMongodb(MongoDatabase db) {
        mongoDatabase = db;
    }

    public static MongoDatabase mongoDatabase() {
        if (mongoDatabase == null && !isTest) {
            MongoClient mongoClient = MongoClients.create("mongodb://mongouser:mongopass@localhost:27017");
            mongoDatabase = mongoClient.getDatabase("surfing_spots");
        }
        return mongoDatabase;
    }

    public static Properties props() {
        if (isTest && props == null) {
            log.info("Test run - test app.properties file");
            props = new Properties();
            File propertiesFile = new File("src/test/resources/app.properties");

            try {
                props.load(new FileInputStream(propertiesFile));
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
            return props;
        }

        if (props == null) {
            props = new Properties();
            String rootPath = Optional.ofNullable(
                    Thread.currentThread()
                        .getContextClassLoader()
                        .getResource("")
                )
                .orElseThrow(() -> new RuntimeException("No properties file found..."))
                .getPath();

            try {
                props.load(new FileInputStream(rootPath + "app.properties"));
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }
        return props;
    }

    public static KeycloakClient keycloakClient() {
        if (keycloakClient == null) {
            keycloakClient = new KeycloakClient(props().getProperty("keycloak.user_info_url"));
        }
        return keycloakClient;
    }

    public static Auth auth() {
        if (auth == null) {
            auth = new Auth(keycloakClient());
        }
        return auth;
    }

    public static OkHttpClient okHttpClient() {
        if (okHttpClient == null) {
            okHttpClient = new OkHttpClient();
        }
        return okHttpClient;
    }

    public static ObjectMapper objectMapper() {
        if (objectMapper == null) {
            objectMapper = new ObjectMapper();
            objectMapper.findAndRegisterModules();
            objectMapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
        }
        return objectMapper;
    }
}
