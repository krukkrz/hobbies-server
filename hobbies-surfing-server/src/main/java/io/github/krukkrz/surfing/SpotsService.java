package io.github.krukkrz.surfing;

import io.github.krukkrz.surfing.dto.SpotDto;

import java.util.UUID;

import static io.github.krukkrz.surfing.dto.SpotDto.toEntity;

public class SpotsService {

    private final SpotsRepository repository;

    public SpotsService(SpotsRepository repository) {
        this.repository = repository;
    }

    public void create(SpotDto spotDto) {
        var entity = toEntity(spotDto);
        entity.setRef(UUID.randomUUID());
        repository.save(entity);
    }
}
