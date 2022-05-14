package io.github.krukkrz.surfing;

import io.github.krukkrz.common.dao.Dao;
import io.github.krukkrz.surfing.model.Spot;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import static io.github.krukkrz.utils.SpotGenerator.generateSpot;
import static org.mockito.Mockito.verify;

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
}