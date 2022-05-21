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

    public void save(Spot spot) {
        dao.save(spot);
    }

    public List<Spot> findAll() {
        return dao.findAll();
    }

    public Optional<Spot> findByRef(String ref) {
        return dao.findByRef(ref);
    }

    public Spot update(Spot spot) {
        return dao.update(spot);
    }

    public void delete(UUID ref) {
        dao.delete(ref.toString());
    }
}
