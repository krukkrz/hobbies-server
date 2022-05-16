package io.github.krukkrz.common.dao;

import io.github.krukkrz.surfing.model.Spot;

import java.util.List;
import java.util.Optional;

public interface Dao<T> {
    void save(T entity);
    List<T> findAll();
    Optional<Spot> findByRef(String ref);
}
