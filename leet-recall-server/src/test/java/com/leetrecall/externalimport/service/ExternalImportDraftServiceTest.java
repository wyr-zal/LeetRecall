package com.leetrecall.externalimport.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.leetrecall.common.enums.Difficulty;
import com.leetrecall.common.exception.BusinessException;
import com.leetrecall.externalimport.entity.ExternalImportDraft;
import com.leetrecall.externalimport.mapper.ExternalImportDraftMapper;
import com.leetrecall.externalimport.model.ExternalImportPayload;
import com.leetrecall.hot100.model.Hot100Manifest;
import com.leetrecall.hot100.model.Hot100OfficialSource;
import com.leetrecall.hot100.service.Hot100ManifestService;
import com.leetrecall.importdata.dto.ProblemCreateDTO;
import com.leetrecall.importdata.service.ProblemImportService;
import com.leetrecall.importdata.vo.ProblemCreatedVO;
import com.leetrecall.problem.entity.Problem;
import com.leetrecall.problem.mapper.ProblemMapper;
import com.leetrecall.problem.mapper.RecallQuestionMapper;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.Clock;
import java.time.Instant;
import java.time.ZoneId;
import java.util.List;
import java.util.Map;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anySet;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class ExternalImportDraftServiceTest {
    @Mock private ExternalImportDraftMapper draftMapper;
    @Mock private Hot100ManifestService hot100ManifestService;
    @Mock private ExternalImportValidator validator;
    @Mock private ProblemImportService problemImportService;
    @Mock private ProblemMapper problemMapper;
    @Mock private RecallQuestionMapper recallQuestionMapper;

    private ExternalImportDraftService service;
    private final ObjectMapper objectMapper = new ObjectMapper();
    private final Hot100Manifest.Hot100Problem expected = new Hot100Manifest.Hot100Problem(
            1, "哈希", 1, "两数之和", Difficulty.EASY, "https://leetcode.cn/problems/two-sum/");
    private final Hot100OfficialSource.OfficialProblem official = new Hot100OfficialSource.OfficialProblem(
            "哈希", 1, "两数之和", Difficulty.EASY, "https://leetcode.cn/problems/two-sum/", 1,
            "题面", List.of("数组"), "class Solution { public int[] twoSum(int[] nums, int target) { } }");

    @BeforeEach
    void setUp() {
        service = new ExternalImportDraftService(draftMapper, hot100ManifestService, validator, problemImportService,
                problemMapper, recallQuestionMapper, objectMapper,
                Clock.fixed(Instant.parse("2026-08-12T04:00:00Z"), ZoneId.of("Asia/Shanghai")));
    }

    @Test
    void doesNotConfirmAnInvalidDraftEvenIfItsNormalizedPayloadLooksValid() throws Exception {
        ExternalImportDraft draft = draft("INVALID");
        draft.setDraftPayloadJson(objectMapper.writeValueAsString(payload()));
        when(draftMapper.selectById(7L)).thenReturn(draft);

        assertThatThrownBy(() -> service.confirm(7L, true))
                .isInstanceOf(BusinessException.class)
                .hasMessage("JSON 尚未通过全部硬校验");

        verify(problemImportService, never()).upsertExternal(any(), any());
        verify(validator, never()).validateRaw(any(), any(), any(), anySet());
    }

    @Test
    void requiresExplicitConfirmationBeforeOverwritingAnExistingProblem() throws Exception {
        ExternalImportDraft draft = readyDraft();
        Problem existing = new Problem(); existing.setId(42L);
        when(draftMapper.selectById(7L)).thenReturn(draft);
        when(problemMapper.selectOne(any())).thenReturn(existing);
        readyValidation();

        assertThatThrownBy(() -> service.confirm(7L, false))
                .isInstanceOf(BusinessException.class)
                .hasMessage("覆盖已有题目前必须明确确认");

        verify(problemImportService, never()).upsertExternal(any(), any());
    }

    @Test
    void importsAReadyDraftAndMarksItImported() throws Exception {
        ExternalImportDraft draft = readyDraft();
        when(draftMapper.selectById(7L)).thenReturn(draft);
        when(problemMapper.selectOne(any())).thenReturn(null);
        readyValidation();
        ExternalImportPayload payload = payload();
        ProblemCreateDTO create = new ProblemCreateDTO(1, "两数之和", Difficulty.EASY, "题面", List.of("数组"),
                "核心思路", "提示", List.of("易错点一", "易错点二"), "class Solution {}", "class Solution {}",
                List.of("问题一足够具体", "问题二足够具体", "问题三足够具体"), "class Solution {}", Map.of(), List.of("数组"));
        when(validator.toProblemCreate(payload)).thenReturn(create);
        when(validator.recallAnswers(payload)).thenReturn(List.of("答一", "答二", "答三"));
        when(problemImportService.upsertExternal(create, List.of("答一", "答二", "答三")))
                .thenReturn(new ProblemCreatedVO(99L, 1, "两数之和"));

        var response = service.confirm(7L, false);

        assertThat(response.status()).isEqualTo("IMPORTED");
        assertThat(response.publishedProblemId()).isEqualTo(99L);
        ArgumentCaptor<ExternalImportDraft> saved = ArgumentCaptor.forClass(ExternalImportDraft.class);
        verify(draftMapper).updateById(saved.capture());
        assertThat(saved.getValue().getConfirmedAt()).isNotNull();
        assertThat(saved.getValue().getPublishedProblemId()).isEqualTo(99L);
    }

    private ExternalImportDraft draft(String status) {
        ExternalImportDraft draft = new ExternalImportDraft();
        draft.setId(7L); draft.setLeetcodeNumber(1); draft.setStatus(status); draft.setFormatVersion("external-json-v1");
        draft.setValidationErrorsJson("[]"); draft.setCreatedAt(java.time.LocalDateTime.now()); draft.setUpdatedAt(java.time.LocalDateTime.now());
        return draft;
    }

    private ExternalImportDraft readyDraft() throws Exception {
        ExternalImportDraft draft = draft("READY");
        draft.setDraftPayloadJson(objectMapper.writeValueAsString(payload()));
        return draft;
    }

    private void readyValidation() throws Exception {
        ExternalImportPayload payload = payload();
        requiredHot100Lookups();
        when(recallQuestionMapper.selectList(any())).thenReturn(List.of());
        when(validator.validateRaw(any(), eq(expected), eq(official), anySet()))
                .thenReturn(new ExternalImportValidator.ValidationResult(payload, List.of(), true, ""));
    }

    private void requiredHot100Lookups() {
        when(hot100ManifestService.requireByNumber(1)).thenReturn(expected);
        when(hot100ManifestService.requireOfficialByNumber(1)).thenReturn(official);
    }

    private ExternalImportPayload payload() {
        return new ExternalImportPayload(1, "两数之和", Difficulty.EASY, "题面", List.of("数组"), "核心思路", "提示",
                List.of("易错点一", "易错点二"), "class Solution {}", "class Solution {}",
                List.of(new ExternalImportPayload.RecallQuestion("问题一足够具体", "答一"), new ExternalImportPayload.RecallQuestion("问题二足够具体", "答二"), new ExternalImportPayload.RecallQuestion("问题三足够具体", "答三")),
                new ExternalImportPayload.Dictation("JAVA", "class Solution {}", Map.of(), List.of("数组")));
    }
}
