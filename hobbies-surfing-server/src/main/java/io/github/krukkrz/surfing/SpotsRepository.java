package io.github.krukkrz.surfing;

import io.github.krukkrz.common.dao.Dao;
import io.github.krukkrz.surfing.model.Spot;

public class SpotsRepository {

    private final Dao<Spot> dao;

    public SpotsRepository(Dao<Spot> dao) {
        this.dao = dao;
    }

    public void save(Spot spot) {
        dao.save(spot);
    }
}
