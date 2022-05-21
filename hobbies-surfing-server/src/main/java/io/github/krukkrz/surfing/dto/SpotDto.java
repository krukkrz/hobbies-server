package io.github.krukkrz.surfing.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.github.krukkrz.surfing.model.Coolness;
import io.github.krukkrz.surfing.model.Spot;
import io.github.krukkrz.surfing.model.SurfingType;
import lombok.Builder;

import java.time.LocalDate;
import java.util.UUID;

@Builder
public record SpotDto(
        UUID ref,
        String name,
        String link,
        String country,
        @JsonFormat(pattern = "yyyy-MM-dd")
        LocalDate startDate,
        @JsonFormat(pattern = "yyyy-MM-dd")
        LocalDate endDate,
        SurfingType surfingType,
        Coolness coolness
) {

    public static Spot toEntity(SpotDto dto) {
        return Spot.builder()
                .ref(dto.ref())
                .name(dto.name())
                .link(dto.link())
                .country(dto.country())
                .surfingType(dto.surfingType())
                .startDate(dto.startDate())
                .endDate(dto.endDate())
                .coolness(dto.coolness())
                .build();
    }
}
