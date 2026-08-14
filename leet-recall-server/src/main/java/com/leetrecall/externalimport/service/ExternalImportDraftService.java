package com.leetrecall.externalimport.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.leetrecall.common.exception.ErrorCode;
import com.leetrecall.externalimport.dto.ExternalImportDraftRequest;
import com.leetrecall.externalimport.entity.ExternalImportDraft;
import com.leetrecall.externalimport.mapper.ExternalImportDraftMapper;
import com.leetrecall.externalimport.model.ExternalImportPayload;
import com.leetrecall.externalimport.vo.ExternalImportDraftResponse;
import com.leetrecall.externalimport.vo.ExternalImportImpactVO;
import com.leetrecall.hot100.model.Hot100Manifest;
import com.leetrecall.hot100.model.Hot100OfficialSource;
import com.leetrecall.hot100.service.Hot100ManifestService;
import com.leetrecall.importdata.service.ProblemImportService;
import com.leetrecall.importdata.vo.ProblemCreatedVO;
import com.leetrecall.problem.entity.Problem;
import com.leetrecall.problem.mapper.ProblemMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Clock;
import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ExternalImportDraftService {
    private static final String FORMAT_VERSION = "external-json-v1";

    private final ExternalImportDraftMapper draftMapper;
    private final Hot100ManifestService hot100ManifestService;
    private final ExternalImportValidator validator;
    private final ProblemImportService problemImportService;
    private final ProblemMapper problemMapper;
    private final ObjectMapper objectMapper;
    private final Clock applicationClock;

    public ExternalImportDraftResponse create(ExternalImportDraftRequest request) {
        Hot100Manifest.Hot100Problem expected = hot100ManifestService.requireByNumber(request.hot100Number());
        Hot100OfficialSource.OfficialProblem official = hot100ManifestService.requireOfficialByNumber(request.hot100Number());
        ExternalImportValidator.ValidationResult result = validator.validateRaw(request.content(), expected, official);
        ExternalImportDraft draft = new ExternalImportDraft();
        LocalDateTime now = LocalDateTime.now(applicationClock);
        draft.setLeetcodeNumber(request.hot100Number());
        draft.setStatus(result.ready() ? "READY" : "INVALID");
        draft.setRequestPayloadJson(writeJson(java.util.Map.of("hot100Number", request.hot100Number(), "format", FORMAT_VERSION)));
        draft.setContentJson(validator.sanitizeForStorage(request.content()));
        draft.setDraftPayloadJson(result.payload() == null ? null : writeJson(result.payload()));
        draft.setValidationErrorsJson(writeJson(result.errors()));
        draft.setFormatVersion(FORMAT_VERSION);
        draft.setCompilePassed(result.compilePassed());
        draft.setCompileOutput(result.compileOutput());
        draft.setOverwriteExisting(existingProblem(request.hot100Number()) != null);
        draft.setCreatedAt(now); draft.setUpdatedAt(now);
        draftMapper.insert(draft);
        return response(draft);
    }

    public ExternalImportDraftResponse get(Long draftId) { return response(requireDraft(draftId)); }

    public ExternalImportDraftResponse update(Long draftId, ExternalImportDraftRequest request) {
        ExternalImportDraft draft = requireDraft(draftId);
        if ("IMPORTED".equals(draft.getStatus())) throw ErrorCode.EXTERNAL_IMPORT_NOT_READY.exception();
        Hot100Manifest.Hot100Problem expected = hot100ManifestService.requireByNumber(request.hot100Number());
        if (!request.hot100Number().equals(draft.getLeetcodeNumber())) throw ErrorCode.INVALID_REQUEST.exception();
        Hot100OfficialSource.OfficialProblem official = hot100ManifestService.requireOfficialByNumber(request.hot100Number());
        ExternalImportValidator.ValidationResult result = validator.validateRaw(request.content(), expected, official);
        draft.setContentJson(validator.sanitizeForStorage(request.content()));
        draft.setDraftPayloadJson(result.payload() == null ? null : writeJson(result.payload()));
        draft.setValidationErrorsJson(writeJson(result.errors()));
        draft.setStatus(result.ready() ? "READY" : "INVALID");
        draft.setCompilePassed(result.compilePassed()); draft.setCompileOutput(result.compileOutput());
        draft.setOverwriteExisting(existingProblem(request.hot100Number()) != null);
        draft.setUpdatedAt(LocalDateTime.now(applicationClock)); draftMapper.updateById(draft);
        return response(draft);
    }

    @Transactional
    public ExternalImportDraftResponse confirm(Long draftId, boolean confirmOverwrite) {
        ExternalImportDraft draft = requireDraft(draftId);
        if ("IMPORTED".equals(draft.getStatus())) return response(draft);
        // 只允许确认上一轮已经通过的草稿；确认时仍会对净化后的白名单内容重新校验。
        if (!"READY".equals(draft.getStatus())) throw ErrorCode.EXTERNAL_IMPORT_NOT_READY.exception();
        Hot100Manifest.Hot100Problem expected = hot100ManifestService.requireByNumber(draft.getLeetcodeNumber());
        Hot100OfficialSource.OfficialProblem official = hot100ManifestService.requireOfficialByNumber(draft.getLeetcodeNumber());
        ExternalImportValidator.ValidationResult result = validator.validateRaw(draft.getDraftPayloadJson(), expected, official);
        if (!result.ready()) {
            draft.setStatus("INVALID"); draft.setValidationErrorsJson(writeJson(result.errors()));
            draft.setCompilePassed(result.compilePassed()); draft.setCompileOutput(result.compileOutput()); draft.setUpdatedAt(LocalDateTime.now(applicationClock)); draftMapper.updateById(draft);
            throw ErrorCode.EXTERNAL_IMPORT_NOT_READY.exception();
        }
        Problem existing = existingProblem(draft.getLeetcodeNumber());
        if (existing != null && !confirmOverwrite) throw ErrorCode.EXTERNAL_IMPORT_OVERWRITE_CONFIRMATION_REQUIRED.exception();
        ProblemCreatedVO created = problemImportService.upsertExternal(validator.toProblemCreate(result.payload()), validator.recallAnswers(result.payload()));
        LocalDateTime now = LocalDateTime.now(applicationClock);
        draft.setStatus("IMPORTED"); draft.setPublishedProblemId(created.problemId()); draft.setPublishedAt(now); draft.setConfirmedAt(now);
        draft.setUpdatedAt(now); draftMapper.updateById(draft);
        return response(draft);
    }

    private ExternalImportDraft requireDraft(Long draftId) {
        ExternalImportDraft draft = draftMapper.selectById(draftId);
        if (draft == null) throw ErrorCode.EXTERNAL_IMPORT_DRAFT_NOT_FOUND.exception();
        return draft;
    }

    private Problem existingProblem(Integer number) {
        return problemMapper.selectOne(new LambdaQueryWrapper<Problem>().eq(Problem::getLeetcodeNumber, number));
    }

    private ExternalImportDraftResponse response(ExternalImportDraft draft) {
        JsonNode payload = readPayload(draft.getDraftPayloadJson());
        return new ExternalImportDraftResponse(draft.getId(), draft.getStatus(), draft.getLeetcodeNumber(), draft.getContentJson(), payload,
                readErrors(draft.getValidationErrorsJson()), draft.getCompilePassed(), draft.getCompileOutput(), draft.getPublishedProblemId(),
                impact(draft.getLeetcodeNumber()), draft.getConfirmedAt(), draft.getCreatedAt(), draft.getUpdatedAt());
    }

    private ExternalImportImpactVO impact(Integer number) {
        Problem problem = existingProblem(number);
        return new ExternalImportImpactVO(problem != null, problem == null ? null : problem.getId(),
                List.of("题目 ID", "学习进度", "笔记", "复习记录", "历史默写记录"),
                List.of("题面、核心思路、提示、易错点、回忆问答、Java 代码、当前默写模板"), problem != null);
    }

    private List<String> readErrors(String json) {
        if (json == null || json.isBlank()) return List.of();
        try { return objectMapper.readValue(json, objectMapper.getTypeFactory().constructCollectionType(List.class, String.class)); }
        catch (JsonProcessingException exception) { return List.of("校验错误数据损坏"); }
    }

    private JsonNode readPayload(String json) {
        if (json == null || json.isBlank()) return null;
        try {
            return objectMapper.readTree(json);
        } catch (JsonProcessingException exception) {
            throw new IllegalStateException("外部 JSON 草稿数据已损坏", exception);
        }
    }

    private String writeJson(Object value) {
        try { return objectMapper.writeValueAsString(value); }
        catch (JsonProcessingException exception) { throw new IllegalStateException("无法保存外部 JSON 草稿", exception); }
    }
}
