package io.github.krukkrz.surfing;

import io.github.krukkrz.surfing.model.Spot;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import static io.github.krukkrz.utils.SpotGenerator.generateSpotDto;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
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
        var captor = ArgumentCaptor.forClass(Spot.class);

        //WHEN
        service.create(spotDto);

        //THEN
        verify(repository).save(captor.capture());
        var value = captor.getValue();
        assertEquals(value.getCoolness(), spotDto.coolness());
        assertEquals(value.getCountry(), spotDto.country());
        assertEquals(value.getSurfingType(), spotDto.surfingType());
        assertEquals(value.getEndDate(), spotDto.endDate());
        assertEquals(value.getStartDate(), spotDto.startDate());
        assertEquals(value.getLink(), spotDto.link());
        assertEquals(value.getName(), spotDto.name());
    }

    @Test
    public void create_generatesRefForObject() {
        //GIVEN
        var spotDto = generateSpotDto();
        var captor = ArgumentCaptor.forClass(Spot.class);

        //WHEN
        service.create(spotDto);

        //THEN
        verify(repository).save(captor.capture());
        var value = captor.getValue();
        assertNotNull(value.getRef());
    }
}