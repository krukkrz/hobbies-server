package io.github.krukkrz.application.database.dao;

import io.github.krukkrz.surfing.model.Spot;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public interface Dao<T> {
    void save(T entity);
    List<T> findAll();
    Optional<Spot> findByRef(String ref);
    T update(Spot spot);

    void delete(String ref);
}
