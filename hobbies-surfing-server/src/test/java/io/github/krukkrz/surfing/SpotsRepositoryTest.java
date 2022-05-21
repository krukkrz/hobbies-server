package io.github.krukkrz.surfing;

import io.github.krukkrz.application.database.dao.Dao;
import io.github.krukkrz.common.exceptions.MultipleEntitiesFound;
import io.github.krukkrz.surfing.model.Spot;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Optional;
import java.util.UUID;

import static io.github.krukkrz.utils.SpotGenerator.generateSpot;
import static io.github.krukkrz.utils.SpotGenerator.generateSpots;
import static java.util.Collections.emptyList;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
public class SpotsRepositoryTest {

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
        var spot = generateSpot();

        //WHEN
        spotsRepository.save(spot);

        //THEN
        verify(dao).save(spot);
    }

    @Test
    public void findAll_returnsAllSavedSurfSpots() {
        //GIVEN
        var spots = generateSpots();
        when(dao.findAll()).thenReturn(spots);

        //WHEN
        var actual = spotsRepository.findAll();

        //THEN
        assertEquals(actual, spots);
    }

    @Test
    public void findAll_returnsEmptyListIfNoSpotsSaved() {
        //GIVEN
        when(dao.findAll()).thenReturn(emptyList());

        //WHEN
        var actual = spotsRepository.findAll();

        //THEN
        assertTrue(actual.isEmpty());
    }

    @Test
    public void findByRef_returnsOptionalWithSpotIfFound() {
        //GIVEN
        var ref = "ref";
        var spot = generateSpot();
        when(dao.findByRef(ref)).thenReturn(Optional.of(spot));

        //WHEN
        var actual = spotsRepository.findByRef(ref);

        //THEN
        assertFalse(actual.isEmpty());
        assertEquals(actual.get(), spot);
    }

    @Test
    public void findByRef_returnsEmptyOptionalIfNoSuchSpotInDb() {
        //GIVEN
        var ref = "ref";
        when(dao.findByRef(ref)).thenReturn(Optional.empty());

        //WHEN
        var actual = spotsRepository.findByRef(ref);

        //THEN
        assertTrue(actual.isEmpty());
    }

    @Test
    public void findByRef_throwsExceptionIfTwoDocumentsWithSameRefFound() {
        //GIVEN
        var ref = "ref";
        when(dao.findByRef(ref)).thenThrow(new MultipleEntitiesFound("Multiple spots found"));

        //WHEN //THEN
        assertThrows(MultipleEntitiesFound.class, () -> spotsRepository.findByRef(ref));
    }

    @Test
    public void update_callsDaoToUpdateSpotAndReturnsUpdatedOne() {
        //GIVEN
        var ref = UUID.randomUUID();
        var spot = generateSpot();
        spot.setRef(ref);
        when(dao.update(spot)).thenReturn(spot);

        //WHEN
        var actual = spotsRepository.update(spot);

        //THEN
        assertEquals(actual, spot);
    }
}