package io.github.krukkrz.utils;

import io.github.krukkrz.surfing.dto.SpotDto;
import io.github.krukkrz.surfing.model.Spot;

import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

import static io.github.krukkrz.surfing.model.Coolness.SUPER_COOL;
import static io.github.krukkrz.surfing.model.SurfingType.SURFING;

public class SpotGenerator {
    private static final UUID uuid = UUID.fromString("c8e30656-d48e-11ec-9d64-0242ac120002");

    public static List<SpotDto> generateSpotDtos() {
        return List.of(
            generateSpotDto(),
            generateSpotDto()
        );
    }

    public static List<Spot> generateSpots() {
        return List.of(
            generateSpot(),
            generateSpot()
        );
    }

    public static Spot generateSpot() {
        return Spot.builder()
            .name("spot-name")
            .ref(uuid)
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
            .ref(uuid)
            .link("thisislink.com")
            .country("Spain")
            .startDate(LocalDate.of(2022, 2, 11))
            .endDate(LocalDate.of(2022, 2, 21))
            .surfingType(SURFING)
            .coolness(SUPER_COOL)
            .build();
    }
}
