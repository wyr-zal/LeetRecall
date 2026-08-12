package com.leetrecall.hot100.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.leetrecall.common.exception.ErrorCode;
import com.leetrecall.hot100.model.Hot100Manifest;
import com.leetrecall.hot100.model.Hot100OfficialSource;
import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.Locale;

@Service
@RequiredArgsConstructor
public class Hot100ManifestService {
    private final ObjectMapper objectMapper;
    private Hot100Manifest manifest;
    private Hot100OfficialSource officialSource;

    @PostConstruct
    void loadManifest() {
        try (var input = new ClassPathResource("hot100-manifest.json").getInputStream();
             var officialInput = new ClassPathResource("hot100-official-source.json").getInputStream()) {
            manifest = objectMapper.readValue(input, Hot100Manifest.class);
            officialSource = objectMapper.readValue(officialInput, Hot100OfficialSource.class);
            if (manifest.problems().size() != 100 || officialSource.problems().size() != 100
                    || manifest.problems().stream().map(Hot100Manifest.Hot100Problem::leetcodeNumber).distinct().count() != 100
                    || officialSource.problems().stream().map(Hot100OfficialSource.OfficialProblem::leetcodeNumber).distinct().count() != 100) {
                throw new IllegalStateException("Hot100 清单和官方题包必须各含 100 个唯一题目");
            }
            if (manifest.problems().stream().anyMatch(problem -> problem.problemUrl() == null
                    || !problem.problemUrl().toLowerCase(Locale.ROOT).startsWith("https://leetcode.cn/problems/"))) {
                throw new IllegalStateException("Hot100 题目链接必须全部指向力扣中文站");
            }
        } catch (IOException exception) {
            throw new IllegalStateException("无法加载 Hot100 题包", exception);
        }
    }

    public Hot100Manifest getManifest() { return manifest; }

    public Hot100Manifest.Hot100Problem requireByNumber(Integer number) {
        Hot100Manifest.Hot100Problem problem = findByNumber(number);
        if (problem == null) throw ErrorCode.HOT100_PROBLEM_NOT_FOUND.exception();
        return problem;
    }

    public Hot100Manifest.Hot100Problem findByNumber(Integer number) {
        if (number == null) return null;
        return manifest.problems().stream().filter(problem -> problem.leetcodeNumber() == number).findFirst().orElse(null);
    }

    public Hot100OfficialSource.OfficialProblem requireOfficialByNumber(Integer number) {
        requireByNumber(number);
        return officialSource.problems().stream()
                .filter(problem -> problem.leetcodeNumber() == number)
                .findFirst()
                .orElseThrow(() -> new IllegalStateException("Hot100 官方题包缺少题号 " + number));
    }
}
