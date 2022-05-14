package io.github.krukkrz.surfing.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Setter
@Getter
@Builder
@AllArgsConstructor
@EqualsAndHashCode
public class Spot {
    private String id;
    private String name;
    private String link;
    private String country;
    private LocalDate startDate;
    private LocalDate endDate;
    private SurfingType surfingType;
    private Coolness coolness;
}
