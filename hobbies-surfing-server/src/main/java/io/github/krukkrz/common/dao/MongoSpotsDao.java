package io.github.krukkrz.common.dao;

import com.mongodb.client.MongoCollection;
import io.github.krukkrz.surfing.model.Spot;
import org.bson.Document;

import static io.github.krukkrz.application.context.ApplicationContext.mongoDatabase;

public class MongoSpotsDao implements Dao<Spot> {

    private final MongoCollection<Document> collection;

    public MongoSpotsDao() {
        this.collection = mongoDatabase().getCollection("spots");
    }

    @Override
    public void save(Spot spot) {
        Document document = new Document();
        document.put("name", spot.getName());
        collection.insertOne(document);
    }
}
