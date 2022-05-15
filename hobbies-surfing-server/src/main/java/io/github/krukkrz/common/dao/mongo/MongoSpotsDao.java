package io.github.krukkrz.common.dao.mongo;

import com.mongodb.client.MongoCollection;
import io.github.krukkrz.common.dao.Dao;
import io.github.krukkrz.surfing.model.Spot;
import org.bson.Document;

import java.util.List;

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
        document.put("country", spot.getCountry());
        document.put("link", spot.getLink());
        document.put("coolness", spot.getCoolness().name());
        document.put("startDate", spot.getStartDate());
        document.put("endDate", spot.getEndDate());
        document.put("surfingType", spot.getSurfingType().name());
        collection.insertOne(document);
    }

    @Override
    public List<Spot> findAll() {
        return null;
    }
}
