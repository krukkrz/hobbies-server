package io.github.krukkrz.common.dao.mongo;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import io.github.krukkrz.common.dao.Dao;
import io.github.krukkrz.common.exceptions.MultipleEntitiesFound;
import io.github.krukkrz.surfing.model.Spot;
import org.bson.Document;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import static com.mongodb.client.model.Filters.eq;
import static io.github.krukkrz.application.context.ApplicationContext.mongoDatabase;
import static io.github.krukkrz.application.context.ApplicationContext.objectMapper;

public class MongoSpotsDao implements Dao<Spot> {

    private final MongoCollection<Document> collection;

    public MongoSpotsDao() {
        this.collection = mongoDatabase().getCollection("spots");
    }

    @Override
    public void save(Spot spot) {
        Document document = new Document();
        document.put("name", spot.getName());
        document.put("ref", spot.getRef().toString());
        document.put("country", spot.getCountry());
        document.put("link", spot.getLink());
        document.put("coolness", spot.getCoolness().name());
        document.put("startDate", spot.getStartDate().toString());
        document.put("endDate", spot.getEndDate().toString());
        document.put("surfingType", spot.getSurfingType().name());
        collection.insertOne(document);
    }

    @Override
    public List<Spot> findAll() {
        MongoCursor<Document> cursor = collection.find().iterator();
        var documents = new ArrayList<Document>();
        while (cursor.hasNext()) {
            documents.add(cursor.next());
        }
        cursor.close();
        return documents.stream().map(this::toSpot).toList();
    }

    @Override
    public Optional<Spot> findByRef(String ref) {
        var cursor = collection.find(eq("ref", ref)).iterator();
        var documents = new ArrayList<Document>();
        while (cursor.hasNext()) {
            documents.add(cursor.next());
        }
        cursor.close();
        if (documents.size() > 1) throw new MultipleEntitiesFound();
        return documents.stream().map(this::toSpot).findAny();
    }

    private Spot toSpot(Document document) {
        try {
            return objectMapper().readValue(document.toJson(), Spot.class);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }
}
