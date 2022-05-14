package io.github.krukkrz.surfing;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.github.krukkrz.application.context.ApplicationContext;
import io.github.krukkrz.surfing.dto.SpotDto;
import io.javalin.http.Context;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.MockedStatic;

import static io.github.krukkrz.application.context.ApplicationContext.objectMapper;
import static io.github.krukkrz.utils.SpotGenerator.generateSpotDto;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.mockStatic;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

public class SpotsHandlerTest {


    private SpotsService service;
    private ObjectMapper objectMapper;
    private Context ctx;

    @BeforeEach
    public void setup() {
        ctx = mock(Context.class);
        service = mock(SpotsService.class);
        MockedStatic<ApplicationContext> mockedApplicationContext = mockStatic(ApplicationContext.class);
        mockedApplicationContext.when(ApplicationContext::spotsService).thenReturn(service);

        objectMapper = new ObjectMapper();
        objectMapper.findAndRegisterModules();
        mockedApplicationContext.when(ApplicationContext::objectMapper).thenReturn(objectMapper);
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