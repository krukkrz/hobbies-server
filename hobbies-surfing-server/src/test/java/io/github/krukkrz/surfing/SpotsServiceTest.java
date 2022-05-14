package io.github.krukkrz.surfing;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import static io.github.krukkrz.utils.SpotGenerator.generateSpot;
import static io.github.krukkrz.utils.SpotGenerator.generateSpotDto;
import static org.mockito.Mockito.verify;

@ExtendWith(MockitoExtension.class)
public class SpotsServiceTest {

    @Mock
    private SpotsRepository repository;

    private SpotsService service;

    @BeforeEach
    public void setup() {
        service = new SpotsService(repository);
    }

    @Test
    public void create_convertsDtoToEntityAndSavesItToRepository() {
        //GIVEN
        var spotDto = generateSpotDto();
        var spot = generateSpot();

        //WHEN
        service.create(spotDto);

        //THEN
        verify(repository).save(spot);
    }
}