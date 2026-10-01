package com.leetrecall.dictation.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.leetrecall.common.enums.Language;
import com.leetrecall.common.exception.ErrorCode;
import com.leetrecall.common.response.PageResponse;
import com.leetrecall.dictation.dto.DictationSubmitDTO;
import com.leetrecall.dictation.entity.DictationAnswerView;
import com.leetrecall.dictation.entity.DictationRecord;
import com.leetrecall.dictation.entity.DictationTemplate;
import com.leetrecall.dictation.mapper.DictationAnswerViewMapper;
import com.leetrecall.dictation.mapper.DictationRecordMapper;
import com.leetrecall.dictation.mapper.DictationTemplateMapper;
import com.leetrecall.dictation.vo.DictationAnswerVO;
import com.leetrecall.dictation.vo.DictationProblemDetailVO;
import com.leetrecall.dictation.vo.DictationQueueItemVO;
import com.leetrecall.dictation.vo.DictationRecordDetailVO;
import com.leetrecall.dictation.vo.DictationRecordVO;
import com.leetrecall.dictation.vo.DictationSubmitVO;
import com.leetrecall.dictation.vo.TodayDictationQueueVO;
import com.leetrecall.problem.entity.Problem;
import com.leetrecall.problem.entity.ProblemMistake;
import com.leetrecall.problem.entity.RecallQuestion;
import com.leetrecall.problem.mapper.ProblemMapper;
import com.leetrecall.problem.mapper.ProblemMistakeMapper;
import com.leetrecall.problem.mapper.ProblemTagMapper;
import com.leetrecall.problem.mapper.RecallQuestionMapper;
import com.leetrecall.review.vo.RecallQuestionVO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.Clock;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service
@RequiredArgsConstructor
public class DictationService {

    private static final TypeReference<Map<String, String>> STRING_MAP = new TypeReference<>() { };
    private static final TypeReference<List<String>> STRING_LIST = new TypeReference<>() { };
    private static final Pattern BLANK_LINE = Pattern.compile("\\{\\{([a-z][a-z0-9_]*)}}");

    private final DictationTemplateMapper templateMapper;
    private final DictationRecordMapper recordMapper;
    private final DictationAnswerViewMapper answerViewMapper;
    private final ProblemMapper problemMapper;
    private final ProblemTagMapper problemTagMapper;
    private final ProblemMistakeMapper problemMistakeMapper;
    private final RecallQuestionMapper recallQuestionMapper;
    private final DictationScorer scorer;
    private final ObjectMapper objectMapper;
    private final Clock applicationClock;

    public TodayDictationQueueVO getTodayQueue() {
        LocalDate today = LocalDate.now(applicationClock);
        var rows = templateMapper.selectTodayRows(today.atStartOfDay(), today.plusDays(1).atStartOfDay());
        var items = rows.stream()
                .map(row -> new DictationQueueItemVO(
                        row.getProblemId(),
                        row.getLeetcodeNumber(),
                        row.getTitle(),
                        Boolean.TRUE.equals(row.getCompleted()),
                        row.getAccuracy()
                ))
                .toList();
        int completed = (int) items.stream().filter(DictationQueueItemVO::completed).count();
        return new TodayDictationQueueVO(items.size(), completed, items);
    }

    public DictationProblemDetailVO getProblemDetail(Long problemId) {
        Problem problem = requireProblem(problemId);
        DictationTemplate template = requireTemplate(problemId);
        List<RecallQuestionVO> recallQuestions = recallQuestionMapper.selectList(
                        new LambdaQueryWrapper<RecallQuestion>()
                                .eq(RecallQuestion::getProblemId, problemId)
                                .orderByAsc(RecallQuestion::getSortOrder)
                ).stream()
                .map(question -> new RecallQuestionVO(
                        question.getId(),
                        question.getQuestionText(),
                        question.getAnswerText()
                ))
                .toList();
        List<String> mistakes = problemMistakeMapper.selectList(
                        new LambdaQueryWrapper<ProblemMistake>()
                                .eq(ProblemMistake::getProblemId, problemId)
                                .orderByAsc(ProblemMistake::getSortOrder)
                                .last("LIMIT 4")
                ).stream()
                .map(ProblemMistake::getContent)
                .toList();
        return new DictationProblemDetailVO(
                problemId,
                problem.getLeetcodeNumber(),
                problem.getTitle(),
                problem.getDifficulty(),
                problemTagMapper.selectTagNames(problemId, 2),
                problem.getDescriptionMarkdown() == null ? "" : problem.getDescriptionMarkdown(),
                recallQuestions,
                problem.getCoreIdea() == null ? "" : problem.getCoreIdea(),
                template.getLanguage(),
                indentPlaceholders(template.getTemplateCode(), readMap(template.getAnswerJson())),
                readList(template.getKeywordJson()),
                mistakes
        );
    }

    @Transactional
    public DictationAnswerVO viewAnswer(Long problemId, String sessionId) {
        Problem problem = requireProblem(problemId);
        DictationTemplate template = requireTemplate(problemId);
        long existing = answerViewMapper.selectCount(
                new LambdaQueryWrapper<DictationAnswerView>()
                        .eq(DictationAnswerView::getProblemId, problemId)
                        .eq(DictationAnswerView::getSessionId, sessionId)
        );
        if (existing == 0) {
            DictationAnswerView view = new DictationAnswerView();
            view.setProblemId(problemId);
            view.setSessionId(sessionId);
            view.setViewedAt(LocalDateTime.now(applicationClock));
            answerViewMapper.insert(view);
        }
        return new DictationAnswerVO(readMap(template.getAnswerJson()), problem.getFullCode());
    }

    @Transactional
    public DictationSubmitVO submit(Long problemId, String sessionId, DictationSubmitDTO request) {
        requireProblem(problemId);
        DictationTemplate template = requireTemplate(problemId);
        boolean recordedAnswerView = answerViewMapper.selectCount(
                new LambdaQueryWrapper<DictationAnswerView>()
                        .eq(DictationAnswerView::getProblemId, problemId)
                        .eq(DictationAnswerView::getSessionId, sessionId)
        ) > 0;
        boolean viewedAnswer = recordedAnswerView || request.viewedAnswer();
        Map<String, String> correctAnswers = readMap(template.getAnswerJson());
        DictationScorer.ScoreResult score = scorer.score(request.answers(), correctAnswers, viewedAnswer);

        DictationRecord record = new DictationRecord();
        record.setProblemId(problemId);
        record.setLanguage(Language.JAVA);
        record.setSubmittedAnswerJson(writeJson(request.answers()));
        record.setTemplateCodeSnapshot(template.getTemplateCode());
        record.setAnswerJsonSnapshot(template.getAnswerJson());
        record.setCorrectCount(score.correctCount());
        record.setTotalCount(score.totalCount());
        record.setAccuracy(score.accuracy());
        record.setViewedAnswer(viewedAnswer);
        record.setDurationSeconds(request.durationSeconds());
        record.setCreatedAt(LocalDateTime.now(applicationClock));
        recordMapper.insert(record);

        return new DictationSubmitVO(
                score.correctCount(),
                score.totalCount(),
                score.accuracy(),
                viewedAnswer,
                score.items()
        );
    }

    public PageResponse<DictationRecordVO> getRecords(Long problemId, int page, int pageSize) {
        requireProblem(problemId);
        Page<DictationRecord> recordPage = recordMapper.selectPage(
                Page.of(page, pageSize),
                new LambdaQueryWrapper<DictationRecord>()
                        .eq(DictationRecord::getProblemId, problemId)
                        .orderByDesc(DictationRecord::getCreatedAt)
        );
        List<DictationRecordVO> items = recordPage.getRecords().stream()
                .map(record -> new DictationRecordVO(
                        record.getId(),
                        record.getCreatedAt(),
                        record.getAccuracy(),
                        record.getDurationSeconds(),
                        Boolean.TRUE.equals(record.getViewedAnswer())
                ))
                .toList();
        return new PageResponse<>(recordPage.getCurrent(), recordPage.getSize(), recordPage.getTotal(), items);
    }

    public DictationRecordDetailVO getRecordDetail(Long problemId, Long recordId) {
        DictationRecord record = recordMapper.selectOne(
                new LambdaQueryWrapper<DictationRecord>()
                        .eq(DictationRecord::getId, recordId)
                        .eq(DictationRecord::getProblemId, problemId)
        );
        if (record == null) {
            throw ErrorCode.PROBLEM_NOT_FOUND.exception();
        }
        Map<String, String> submitted = readMap(record.getSubmittedAnswerJson());
        String snapshot = record.getAnswerJsonSnapshot();
        boolean legacySnapshot = snapshot == null || snapshot.isBlank();
        Map<String, String> correct = legacySnapshot ? Map.of() : readMap(snapshot);
        List<String> incorrect = correct.entrySet().stream()
                .filter(entry -> !scorer.normalize(entry.getValue())
                        .equals(scorer.normalize(submitted.get(entry.getKey()))))
                .map(Map.Entry::getKey)
                .toList();
        return new DictationRecordDetailVO(
                record.getId(),
                indentPlaceholders(record.getTemplateCodeSnapshot(), correct),
                submitted, correct, incorrect,
                Boolean.TRUE.equals(record.getViewedAnswer()), legacySnapshot
        );
    }

    /**
     * 导入契约要求占位符顶格独占一行、缩进保存在答案里；展示时把答案首行缩进
     * 补到占位符前，让空位落在代码规范的位置。评分按去空白比较，不受影响。
     */
    private String indentPlaceholders(String templateCode, Map<String, String> answers) {
        if (templateCode == null || answers == null || answers.isEmpty()) return templateCode;
        String[] lines = templateCode.split("\n", -1);
        for (int index = 0; index < lines.length; index++) {
            Matcher matcher = BLANK_LINE.matcher(lines[index]);
            if (!matcher.matches()) continue;
            String answer = answers.get(matcher.group(1));
            if (answer == null) continue;
            String indent = leadingWhitespace(answer);
            if (!indent.isEmpty()) lines[index] = indent + lines[index];
        }
        return String.join("\n", lines);
    }

    private String leadingWhitespace(String text) {
        int end = 0;
        while (end < text.length() && (text.charAt(end) == ' ' || text.charAt(end) == '\t')) end++;
        return text.substring(0, end);
    }

    private Problem requireProblem(Long problemId) {
        Problem problem = problemMapper.selectById(problemId);
        if (problem == null || !Integer.valueOf(1).equals(problem.getStatus())) {
            throw ErrorCode.PROBLEM_NOT_FOUND.exception();
        }
        return problem;
    }

    private DictationTemplate requireTemplate(Long problemId) {
        DictationTemplate template = templateMapper.selectOne(
                new LambdaQueryWrapper<DictationTemplate>()
                        .eq(DictationTemplate::getProblemId, problemId)
                        .eq(DictationTemplate::getLanguage, Language.JAVA)
        );
        if (template == null) {
            throw ErrorCode.DICTATION_TEMPLATE_NOT_FOUND.exception();
        }
        return template;
    }

    private Map<String, String> readMap(String json) {
        try {
            return objectMapper.readValue(json, STRING_MAP);
        } catch (JsonProcessingException exception) {
            throw new IllegalStateException("默写答案数据格式错误", exception);
        }
    }

    private List<String> readList(String json) {
        if (json == null || json.isBlank()) return List.of();
        try {
            return objectMapper.readValue(json, STRING_LIST);
        } catch (JsonProcessingException exception) {
            throw new IllegalStateException("默写关键词数据格式错误", exception);
        }
    }

    private String writeJson(Object value) {
        try {
            return objectMapper.writeValueAsString(value);
        } catch (JsonProcessingException exception) {
            throw new IllegalStateException("无法序列化默写答案", exception);
        }
    }
}
