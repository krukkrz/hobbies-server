package io.github.krukkrz.surfing;

import io.github.krukkrz.dao.Dao;
import io.github.krukkrz.surfing.model.Spot;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.LocalDate;

import static io.github.krukkrz.surfing.model.Coolness.SUPER_COOL;
import static io.github.krukkrz.surfing.model.SurfingType.SURFING;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
public class SpotsServiceTest {

    @Mock
    private Dao<Spot> dao;

    private SpotsRepository spotsRepository;

    @BeforeEach
    public void setup() {
        spotsRepository = new SpotsRepository(dao);
    }

    @Test
    public void save_savesSurfSpotToDbAndReturnsSavedObject() {
        //GIVEN
        var spot = buildSpot();

        var savedSpot = buildSpot();
        savedSpot.setId("spot_id");
        when(dao.save(any())).thenReturn(savedSpot);

        //WHEN
        var actual = spotsRepository.save(spot);

        //THEN
        assertNotNull(actual.getId());
        assertEquals(actual.getName(), spot.getName());
        assertEquals(actual.getLink(), spot.getLink());
        assertEquals(actual.getCountry(), spot.getCountry());
        assertEquals(actual.getStartDate(), spot.getStartDate());
        assertEquals(actual.getEndDate(), spot.getEndDate());
        assertEquals(actual.getSurfingType(), spot.getSurfingType());
        assertEquals(actual.getCoolness(), spot.getCoolness());
    }

    private Spot buildSpot() {
        return Spot.builder()
            .name("spot-name")
            .link("thisislink.com")
            .country("Spain")
            .startDate(LocalDate.of(2022, 2, 11))
            .endDate(LocalDate.of(2022, 2, 21))
            .surfingType(SURFING)
            .coolness(SUPER_COOL)
            .build();
    }
}