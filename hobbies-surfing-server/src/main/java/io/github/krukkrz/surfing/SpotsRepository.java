package io.github.krukkrz.surfing;

import io.github.krukkrz.common.dao.Dao;
import io.github.krukkrz.surfing.model.Spot;

import java.util.List;

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
}
