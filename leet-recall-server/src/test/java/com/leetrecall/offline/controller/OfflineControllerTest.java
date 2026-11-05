package com.leetrecall.offline.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import com.leetrecall.offline.service.OfflineService;
import com.leetrecall.offline.vo.OfflinePackVO;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.header;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@ExtendWith(MockitoExtension.class)
class OfflineControllerTest {

    @Mock private OfflineService offlineService;

    private MockMvc mockMvc;

    @BeforeEach
    void setUp() {
        ObjectMapper objectMapper = new ObjectMapper().registerModule(new JavaTimeModule());
        mockMvc = MockMvcBuilders
                .standaloneSetup(new OfflineController(offlineService, objectMapper))
                .build();
    }

    @Test
    void returnsPackWithEtagAndRevalidatesWith304() throws Exception {
        when(offlineService.buildPack()).thenReturn(new OfflinePackVO(1, 0, List.of()));

        MvcResult first = mockMvc.perform(get("/api/offline/pack"))
                .andExpect(status().isOk())
                .andExpect(header().exists(HttpHeaders.ETAG))
                .andExpect(header().string(HttpHeaders.CACHE_CONTROL, "no-cache"))
                .andExpect(content().contentTypeCompatibleWith(MediaType.APPLICATION_JSON))
                .andReturn();

        String etag = first.getResponse().getHeader(HttpHeaders.ETAG);
        assertThat(etag).isNotBlank();

        mockMvc.perform(get("/api/offline/pack").header(HttpHeaders.IF_NONE_MATCH, etag))
                .andExpect(status().isNotModified())
                .andExpect(header().string(HttpHeaders.ETAG, etag));

        verify(offlineService, times(2)).buildPack();
    }

    @Test
    void changesEtagWhenPackContentChanges() throws Exception {
        when(offlineService.buildPack()).thenReturn(
                new OfflinePackVO(1, 0, List.of()),
                new OfflinePackVO(1, 1, List.of())
        );

        String first = mockMvc.perform(get("/api/offline/pack"))
                .andReturn().getResponse().getHeader(HttpHeaders.ETAG);
        String second = mockMvc.perform(get("/api/offline/pack"))
                .andReturn().getResponse().getHeader(HttpHeaders.ETAG);

        assertThat(first).isNotEqualTo(second);
    }

    @Test
    void acceptsWeakEtagAddedByGatewayCompression() throws Exception {
        when(offlineService.buildPack()).thenReturn(new OfflinePackVO(1, 0, List.of()));

        String etag = mockMvc.perform(get("/api/offline/pack"))
                .andReturn().getResponse().getHeader(HttpHeaders.ETAG);

        mockMvc.perform(get("/api/offline/pack").header(HttpHeaders.IF_NONE_MATCH, "W/" + etag))
                .andExpect(status().isNotModified());
    }
}