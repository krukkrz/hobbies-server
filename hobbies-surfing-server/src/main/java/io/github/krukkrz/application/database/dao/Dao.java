package io.github.krukkrz.application.database.dao;

import io.github.krukkrz.surfing.model.Spot;

import java.util.List;
import java.util.Optional;

public interface Dao<T> {
    void save(T entity, String userId);
    List<T> findAll(String userId);
    Optional<Spot> findByRef(String ref, String userId);
    T update(Spot spot, String userId);
    void delete(String ref, String userId);
}
