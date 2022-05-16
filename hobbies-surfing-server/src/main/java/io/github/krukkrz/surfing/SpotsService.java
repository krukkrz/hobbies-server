package io.github.krukkrz.surfing;

import io.github.krukkrz.surfing.dto.SpotDto;
import io.github.krukkrz.surfing.model.Spot;

import java.util.List;
import java.util.NoSuchElementException;
import java.util.UUID;
import java.util.stream.Collectors;

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

    public List<SpotDto> findAll() {
        return repository.findAll()
            .stream()
            .map(Spot::toDto)
            .collect(Collectors.toList());
    }

    public SpotDto findByRef(String ref) {
        return repository.findByRef(ref)
            .map(Spot::toDto)
            .orElseThrow(() -> new NoSuchElementException("Spot not found"));
    }
}
