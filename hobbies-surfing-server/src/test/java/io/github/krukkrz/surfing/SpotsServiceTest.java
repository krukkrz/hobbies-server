package io.github.krukkrz.surfing;

import io.github.krukkrz.surfing.dto.SpotDto;
import io.github.krukkrz.surfing.model.Spot;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.List;

import static io.github.krukkrz.utils.SpotGenerator.generateSpotDto;
import static io.github.krukkrz.utils.SpotGenerator.generateSpots;
import static java.util.Collections.emptyList;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

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
    public void findAll_returnsListOfSpotsFromRepository() {
        //GIVEN
        var spots = generateSpots();
        when(repository.findAll()).thenReturn(spots);

        //WHEN
        var actual = service.findAll();

        //THEN
        assertSpotsListEqualsDtosList(spots, actual);
    }

    @Test
    public void findAll_returnsEmptyListIfNoSpotsInRepository() {
        //GIVEN
        when(repository.findAll()).thenReturn(emptyList());

        //WHEN
        var actual = service.findAll();

        //THEN
        assertTrue(actual.isEmpty());
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
        var actual = captor.getValue();
        assertSpotDtoEqualsSpot(spotDto, actual);
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

    private void assertSpotDtoEqualsSpot(SpotDto spotDto, Spot spot) {
        assertEquals(spot.getCoolness(), spotDto.coolness());
        assertEquals(spot.getCountry(), spotDto.country());
        assertEquals(spot.getSurfingType(), spotDto.surfingType());
        assertEquals(spot.getEndDate(), spotDto.endDate());
        assertEquals(spot.getStartDate(), spotDto.startDate());
        assertEquals(spot.getLink(), spotDto.link());
        assertEquals(spot.getName(), spotDto.name());
    }

    private void assertSpotsListEqualsDtosList(List<Spot> spots, List<SpotDto> actual) {
        actual.forEach(dto -> {
            var matchingSpot = spots.stream()
                .filter(spot -> spot.getRef().equals(dto.ref()))
                .toList()
                .get(0);
            assertSpotDtoEqualsSpot(dto, matchingSpot);
        });
    }
}