package com.leetrecall.offline.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.leetrecall.common.response.ApiResponse;
import com.leetrecall.offline.service.OfflineService;
import com.leetrecall.offline.vo.OfflinePackVO;
import lombok.RequiredArgsConstructor;
import org.springframework.http.CacheControl;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.request.WebRequest;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.HexFormat;

@RestController
@RequestMapping("/api/offline")
@RequiredArgsConstructor
public class OfflineController {

    private final OfflineService offlineService;
    private final ObjectMapper objectMapper;

    /**
     * 返回全部启用题目的离线快照。ETag 由响应正文内容哈希生成，
     * 客户端带 If-None-Match 时命中直接 304，避免重复下载。
     */
    @GetMapping("/pack")
    public ResponseEntity<byte[]> getPack(WebRequest request) throws JsonProcessingException {
        OfflinePackVO pack = offlineService.buildPack();
        byte[] body = objectMapper.writeValueAsBytes(ApiResponse.success(pack));
        String etag = "\"" + sha256(body) + "\"";
        String ifNoneMatch = request.getHeader(HttpHeaders.IF_NONE_MATCH);
        if (etagMatches(ifNoneMatch, etag)) {
            return ResponseEntity.status(HttpStatus.NOT_MODIFIED)
                    .eTag(etag)
                    .cacheControl(CacheControl.noCache())
                    .build();
        }
        return ResponseEntity.ok()
                .eTag(etag)
                .cacheControl(CacheControl.noCache())
                .contentType(MediaType.APPLICATION_JSON)
                .body(body);
    }

    /** If-None-Match 按弱比较：网关 gzip 会把强 ETag 改写为 W/ 形式，需忽略该前缀。 */
    private static boolean etagMatches(String ifNoneMatch, String etag) {
        if (ifNoneMatch == null) {
            return false;
        }
        for (String candidate : ifNoneMatch.split(",")) {
            String value = candidate.strip();
            if (value.startsWith("W/")) {
                value = value.substring(2);
            }
            if (etag.equals(value)) {
                return true;
            }
        }
        return false;
    }

    private static String sha256(byte[] bytes) {
        try {
            return HexFormat.of().formatHex(MessageDigest.getInstance("SHA-256").digest(bytes));
        } catch (NoSuchAlgorithmException exception) {
            throw new IllegalStateException("SHA-256 不可用", exception);
        }
    }
}