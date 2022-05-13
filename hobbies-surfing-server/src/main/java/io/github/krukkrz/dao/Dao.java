package io.github.krukkrz.dao;

public interface Dao<T> {
    T save(T entity);
}
