package io.github.krukkrz.application.database.dao.mongo;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.mongodb.MongoException;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.model.ReplaceOptions;
import com.mongodb.client.model.UpdateOptions;
import com.mongodb.client.model.Updates;
import io.github.krukkrz.application.database.dao.Dao;
import io.github.krukkrz.common.exceptions.MultipleEntitiesFound;
import io.github.krukkrz.surfing.model.Spot;
import lombok.extern.slf4j.Slf4j;
import org.bson.Document;
import org.bson.types.ObjectId;
import org.jetbrains.annotations.NotNull;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import static com.mongodb.client.model.Filters.eq;
import static com.mongodb.client.model.Updates.*;
import static com.mongodb.client.model.Updates.set;
import static io.github.krukkrz.application.context.ApplicationContext.mongoDatabase;
import static io.github.krukkrz.application.context.ApplicationContext.objectMapper;

@Slf4j
public class MongoSpotsDao implements Dao<Spot> {

    private final MongoCollection<Document> collection;

    public MongoSpotsDao() {
        this.collection = mongoDatabase().getCollection("spots");
    }

    @Override
    public void save(Spot spot) {
        if (spot.get_id() == null) {
            spot.set_id(new ObjectId());
        }
        Document document = spotToDocument(spot);
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
        if (documents.size() > 1) {
            throw new MultipleEntitiesFound("Multiple spots found");
        }
        return documents.stream().map(this::toSpot).findAny();
    }

    @Override
    public Spot update(Spot spot) {
        var ref = String.valueOf(spot.getRef());
        var existingSpot = findByRef(ref);
        existingSpot.ifPresent(s -> spot.set_id(s.get_id()));

        var updates = combine(
                set("name", spot.getName()),
                set("ref", spot.getRef().toString()),
                set("country", spot.getCountry()),
                set("link", spot.getLink()),
                set("coolness", spot.getCoolness().name()),
                set("startDate", spot.getStartDate().toString()),
                set("endDate", spot.getEndDate().toString()),
                set("surfingType", spot.getSurfingType().name())
        );

        var spotId = Optional.ofNullable(spot.get_id());
        var filter = eq("_id", spotId.orElse(new ObjectId()).toString() );
        try {
            var result = collection.updateOne(filter, updates, getUpsertOptions());
            log.info("Updated {} documents", result.getMatchedCount());
        } catch (MongoException e) {
            log.error(e.getMessage());
        }
        return findByRef(ref).get();
    }

    @Override
    public void delete(String ref) {
        var deleteResult = collection.deleteOne(eq("ref", ref));
        log.info("Removed {} documents", deleteResult.getDeletedCount());
    }

    @NotNull
    private UpdateOptions getUpsertOptions() {
        return new UpdateOptions().upsert(true);
    }

    private Spot toSpot(Document document) {
        try {
            return objectMapper().readValue(document.toJson(), Spot.class);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    @NotNull
    private Document spotToDocument(Spot spot) {
        Document document = new Document();
        document.put("_id", spot.get_id().toString());
        document.put("name", spot.getName());
        document.put("ref", spot.getRef().toString());
        document.put("country", spot.getCountry());
        document.put("link", spot.getLink());
        document.put("coolness", spot.getCoolness().name());
        document.put("startDate", spot.getStartDate().toString());
        document.put("endDate", spot.getEndDate().toString());
        document.put("surfingType", spot.getSurfingType().name());
        return document;
    }
}
