package com.leetrecall.offline.service;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.leetrecall.common.enums.Language;
import com.leetrecall.dictation.entity.DictationTemplate;
import com.leetrecall.dictation.mapper.DictationTemplateMapper;
import com.leetrecall.dictation.service.DictationService;
import com.leetrecall.offline.vo.OfflinePackVO;
import com.leetrecall.offline.vo.OfflineProblemVO;
import com.leetrecall.problem.entity.Problem;
import com.leetrecall.problem.entity.ProblemCodeAnnotation;
import com.leetrecall.problem.entity.ProblemMistake;
import com.leetrecall.problem.entity.ProblemNote;
import com.leetrecall.problem.entity.RecallQuestion;
import com.leetrecall.problem.mapper.ProblemCodeAnnotationMapper;
import com.leetrecall.problem.mapper.ProblemMapper;
import com.leetrecall.problem.mapper.ProblemMistakeMapper;
import com.leetrecall.problem.mapper.ProblemNoteMapper;
import com.leetrecall.problem.mapper.ProblemTagMapper;
import com.leetrecall.problem.mapper.RecallQuestionMapper;
import com.leetrecall.problem.vo.CodeAnnotationVO;
import com.leetrecall.problem.vo.ProblemTagNameVO;
import com.leetrecall.review.vo.RecallQuestionVO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import java.util.function.Function;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class OfflineService {

    private static final int SCHEMA_VERSION = 1;
    private static final TypeReference<Map<String, String>> STRING_MAP = new TypeReference<>() { };
    private static final TypeReference<List<String>> STRING_LIST = new TypeReference<>() { };

    private final ProblemMapper problemMapper;
    private final ProblemTagMapper problemTagMapper;
    private final RecallQuestionMapper recallQuestionMapper;
    private final ProblemMistakeMapper problemMistakeMapper;
    private final ProblemNoteMapper problemNoteMapper;
    private final ProblemCodeAnnotationMapper annotationMapper;
    private final DictationTemplateMapper templateMapper;
    private final ObjectMapper objectMapper;

    @Transactional(readOnly = true)
    public OfflinePackVO buildPack() {
        List<Problem> problems = problemMapper.selectAllEnabledForOffline();
        if (problems.isEmpty()) {
            return new OfflinePackVO(SCHEMA_VERSION, 0, List.of());
        }
        List<Long> problemIds = problems.stream().map(Problem::getId).toList();

        Map<Long, List<String>> tagsByProblem = problemTagMapper
                .selectTagNamesByProblemIds(problemIds).stream()
                .collect(Collectors.groupingBy(
                        ProblemTagNameVO::getProblemId,
                        LinkedHashMap::new,
                        Collectors.mapping(ProblemTagNameVO::getName, Collectors.toList())
                ));
        Map<Long, List<RecallQuestion>> questionsByProblem = group(
                recallQuestionMapper.selectList(Wrappers.<RecallQuestion>lambdaQuery()
                        .in(RecallQuestion::getProblemId, problemIds)
                        .orderByAsc(RecallQuestion::getSortOrder)
                        .orderByAsc(RecallQuestion::getId)),
                RecallQuestion::getProblemId
        );
        Map<Long, List<ProblemMistake>> mistakesByProblem = group(
                problemMistakeMapper.selectList(Wrappers.<ProblemMistake>lambdaQuery()
                        .in(ProblemMistake::getProblemId, problemIds)
                        .orderByAsc(ProblemMistake::getSortOrder)
                        .orderByAsc(ProblemMistake::getId)),
                ProblemMistake::getProblemId
        );
        Map<Long, ProblemNote> notesByProblem = problemNoteMapper
                .selectList(Wrappers.<ProblemNote>lambdaQuery()
                        .in(ProblemNote::getProblemId, problemIds))
                .stream()
                .collect(Collectors.toMap(ProblemNote::getProblemId, note -> note, (left, right) -> left));
        Map<Long, List<ProblemCodeAnnotation>> annotationsByProblem = group(
                annotationMapper.selectList(Wrappers.<ProblemCodeAnnotation>lambdaQuery()
                        .in(ProblemCodeAnnotation::getProblemId, problemIds)
                        .orderByAsc(ProblemCodeAnnotation::getStartLine)
                        .orderByAsc(ProblemCodeAnnotation::getStartColumn)
                        .orderByAsc(ProblemCodeAnnotation::getId)),
                ProblemCodeAnnotation::getProblemId
        );
        Map<Long, DictationTemplate> templatesByProblem = templateMapper
                .selectList(Wrappers.<DictationTemplate>lambdaQuery()
                        .in(DictationTemplate::getProblemId, problemIds)
                        .eq(DictationTemplate::getLanguage, Language.JAVA))
                .stream()
                .collect(Collectors.toMap(DictationTemplate::getProblemId, template -> template, (left, right) -> left));

        List<OfflineProblemVO> items = problems.stream()
                .map(problem -> toItem(
                        problem,
                        tagsByProblem.getOrDefault(problem.getId(), List.of()),
                        questionsByProblem.getOrDefault(problem.getId(), List.of()),
                        mistakesByProblem.getOrDefault(problem.getId(), List.of()),
                        notesByProblem.get(problem.getId()),
                        annotationsByProblem.getOrDefault(problem.getId(), List.of()),
                        templatesByProblem.get(problem.getId())
                ))
                .toList();
        return new OfflinePackVO(SCHEMA_VERSION, items.size(), items);
    }

    private OfflineProblemVO toItem(
            Problem problem,
            List<String> tags,
            List<RecallQuestion> questions,
            List<ProblemMistake> mistakes,
            ProblemNote note,
            List<ProblemCodeAnnotation> annotations,
            DictationTemplate template
    ) {
        Map<String, String> answers = template == null
                ? Map.of()
                : parseMap(template.getAnswerJson());
        String templateCode = template == null || template.getTemplateCode() == null
                ? ""
                : DictationService.indentPlaceholders(template.getTemplateCode(), answers);

        return new OfflineProblemVO(
                problem.getId(),
                problem.getLeetcodeNumber(),
                problem.getHot100Order(),
                problem.getTitle(),
                problem.getDifficulty(),
                tags,
                blankWhenNull(problem.getDescriptionMarkdown()),
                questions.stream()
                        .map(question -> new RecallQuestionVO(
                                question.getId(),
                                question.getQuestionText(),
                                blankWhenNull(question.getAnswerText())
                        ))
                        .toList(),
                blankWhenNull(problem.getHint()),
                blankWhenNull(problem.getCoreIdea()),
                mistakes.stream().map(ProblemMistake::getContent).toList(),
                blankWhenNull(problem.getKeyCode()),
                blankWhenNull(problem.getFullCode()),
                templateCode,
                answers,
                template == null ? List.of() : parseList(template.getKeywordJson()),
                note == null ? "" : blankWhenNull(note.getContentMarkdown()),
                note == null ? null : note.getUpdatedAt(),
                annotations.stream().map(this::toAnnotationView).toList(),
                problem.getUpdatedAt()
        );
    }

    private CodeAnnotationVO toAnnotationView(ProblemCodeAnnotation annotation) {
        return new CodeAnnotationVO(
                annotation.getId(),
                annotation.getProblemId(),
                annotation.getLabel(),
                annotation.getAnchorText(),
                annotation.getOccurrenceIndex(),
                annotation.getStartLine(),
                annotation.getStartColumn(),
                annotation.getEndLine(),
                annotation.getEndColumn(),
                annotation.getContentMarkdown(),
                annotation.getCreatedAt(),
                annotation.getUpdatedAt()
        );
    }

    private Map<String, String> parseMap(String json) {
        if (json == null || json.isBlank()) return Map.of();
        try {
            // TreeMap 保证同一份数据每次序列化顺序一致，ETag 不会因 Map 顺序抖动。
            return new TreeMap<>(objectMapper.readValue(json, STRING_MAP));
        } catch (JsonProcessingException exception) {
            return Map.of();
        }
    }

    private List<String> parseList(String json) {
        if (json == null || json.isBlank()) return List.of();
        try {
            return objectMapper.readValue(json, STRING_LIST);
        } catch (JsonProcessingException exception) {
            return List.of();
        }
    }

    private static <T> Map<Long, List<T>> group(List<T> rows, Function<T, Long> key) {
        return rows.stream().collect(Collectors.groupingBy(
                key,
                LinkedHashMap::new,
                Collectors.toList()
        ));
    }

    private static String blankWhenNull(String value) {
        return value == null ? "" : value;
    }
}