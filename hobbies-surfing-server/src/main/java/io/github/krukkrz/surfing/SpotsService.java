package io.github.krukkrz.surfing;

import io.github.krukkrz.surfing.dto.SpotDto;

import static io.github.krukkrz.surfing.dto.SpotDto.toEntity;

public class SpotsService {

    private final SpotsRepository repository;

    public SpotsService(SpotsRepository repository) {
        this.repository = repository;
    }

    public void create(SpotDto spotDto) {
        repository.save(toEntity(spotDto));
    }
}
