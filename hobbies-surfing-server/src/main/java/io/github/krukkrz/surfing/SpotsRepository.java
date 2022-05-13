package io.github.krukkrz.surfing;

import io.github.krukkrz.dao.Dao;
import io.github.krukkrz.surfing.model.Spot;

public class SpotsRepository {

    private final Dao<Spot> dao;

    public SpotsRepository(Dao<Spot> dao) {
        this.dao = dao;
    }

    public Spot save(Spot spot) {
        return dao.save(spot);
    }
}
