package io.github.krukkrz.surfing;

import io.github.krukkrz.application.database.dao.Dao;
import io.github.krukkrz.surfing.model.Spot;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public class SpotsRepository {

    private final Dao<Spot> dao;

    public SpotsRepository(Dao<Spot> dao) {
        this.dao = dao;
    }

    public void save(Spot spot, String userId) {
        dao.save(spot, userId);
    }

    public List<Spot> findAll(String userId) {
        return dao.findAll(userId);
    }

    public Optional<Spot> findByRef(String ref, String userId) {
        return dao.findByRef(ref, userId);
    }

    public Spot update(Spot spot, String userId) {
        return dao.update(spot, userId);
    }

    public void delete(UUID ref, String userId) {
        dao.delete(ref.toString(), userId);
    }
}
