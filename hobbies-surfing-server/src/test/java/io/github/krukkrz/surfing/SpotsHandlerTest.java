package io.github.krukkrz.surfing;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.github.krukkrz.application.context.ApplicationContext;
import io.github.krukkrz.surfing.dto.SpotDto;
import io.javalin.http.Context;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.MockedStatic;

import java.util.List;
import java.util.NoSuchElementException;

import static io.github.krukkrz.utils.SpotGenerator.generateSpotDto;
import static io.github.krukkrz.utils.SpotGenerator.generateSpotDtos;
import static java.util.Collections.emptyList;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.mockStatic;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

public class SpotsHandlerTest {


    private SpotsService service;
    private ObjectMapper objectMapper;
    private Context ctx;
    private MockedStatic<ApplicationContext> mockedApplicationContext;

    @BeforeEach
    public void setup() {
        ctx = mock(Context.class);
        service = mock(SpotsService.class);
        mockedApplicationContext = mockStatic(ApplicationContext.class);
        mockedApplicationContext.when(ApplicationContext::spotsService).thenReturn(service);
        objectMapper = new ObjectMapper();
        objectMapper.findAndRegisterModules();
        mockedApplicationContext.when(ApplicationContext::objectMapper).thenReturn(objectMapper);
    }

    @AfterEach
    public void after() {
        mockedApplicationContext.close();
    }

    @Test
    public void handleReadByRef_fetchSpotByRefFromServiceAndReturnsIt() {
        //GIVEN
        var spot = generateSpotDto();
        var ref = "ref";
        when(ctx.pathParam("ref")).thenReturn(ref);
        when(service.findByRef(ref)).thenReturn(spot);

        //WHEN
        SpotsHandler.handleReadByRef(ctx);

        //THEN
        verify(ctx).status(200);
        verify(ctx).json(spot);
    }

    @Test
    public void handleReadAll_fetchAllSpotsFromService() {
        //GIVEN
        var spots = generateSpotDtos();
        when(service.findAll()).thenReturn(spots);

        //WHEN
        SpotsHandler.handleReadAll(ctx);

        //THEN
        verify(ctx).status(200);
        verify(ctx).json(spots);
    }

    @Test
    public void handleReadAll_returnsEmptyListIfNoObjectsInDb() {
        //GIVEN
        List<SpotDto> spots = emptyList();
        when(service.findAll()).thenReturn(spots);

        //WHEN
        SpotsHandler.handleReadAll(ctx);

        //THEN
        verify(ctx).status(200);
        verify(ctx).json(spots);
    }

    @Test
    public void handleCreate_acceptsDtoAndPassItToService() throws JsonProcessingException {
        //GIVEN
        var spotDto = generateSpotDto();
        var json = objectMapper.writeValueAsString(spotDto);
        when(ctx.body()).thenReturn(String.valueOf(json));

        //WHEN
        SpotsHandler.handleCreate(ctx);

        //THEN
        verify(service).create(spotDto);
        verify(ctx).status(201);
    }
}