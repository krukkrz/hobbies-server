package io.github.krukkrz.common.dao;

import java.util.List;

public interface Dao<T> {
    void save(T entity);
    List<T> findAll();
}
