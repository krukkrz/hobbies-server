package io.github.krukkrz.utils;

import io.github.krukkrz.surfing.dto.SpotDto;
import io.github.krukkrz.surfing.model.Spot;

import java.time.LocalDate;

import static io.github.krukkrz.surfing.model.Coolness.SUPER_COOL;
import static io.github.krukkrz.surfing.model.SurfingType.SURFING;

public class SpotGenerator {
    public static Spot generateSpot() {
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

    public static SpotDto generateSpotDto() {
        return SpotDto.builder()
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
