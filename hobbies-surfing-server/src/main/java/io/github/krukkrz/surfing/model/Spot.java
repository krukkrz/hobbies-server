package io.github.krukkrz.surfing.model;

import io.github.krukkrz.surfing.dto.SpotDto;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;
import java.util.UUID;

@Setter
@Getter
@Builder
@AllArgsConstructor
@EqualsAndHashCode
public class Spot {
    private String id;
    private UUID ref;
    private String name;
    private String link;
    private String country;
    private LocalDate startDate;
    private LocalDate endDate;
    private SurfingType surfingType;
    private Coolness coolness;

    public static SpotDto toDto(Spot spot) {
        return SpotDto.builder()
            .ref(spot.getRef())
            .name(spot.getName())
            .startDate(spot.getStartDate())
            .endDate(spot.getEndDate())
            .surfingType(spot.getSurfingType())
            .coolness(spot.getCoolness())
            .link(spot.getLink())
            .country(spot.getCountry())
            .build();
    }
}
