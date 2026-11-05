package com.leetrecall.offline.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.leetrecall.common.enums.Difficulty;
import com.leetrecall.common.enums.Language;
import com.leetrecall.dictation.entity.DictationTemplate;
import com.leetrecall.dictation.mapper.DictationTemplateMapper;
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
import com.leetrecall.problem.vo.ProblemTagNameVO;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.LocalDateTime;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.anyList;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class OfflineServiceTest {

    @Mock private ProblemMapper problemMapper;
    @Mock private ProblemTagMapper problemTagMapper;
    @Mock private RecallQuestionMapper recallQuestionMapper;
    @Mock private ProblemMistakeMapper problemMistakeMapper;
    @Mock private ProblemNoteMapper problemNoteMapper;
    @Mock private ProblemCodeAnnotationMapper annotationMapper;
    @Mock private DictationTemplateMapper templateMapper;

    private OfflineService offlineService;

    @BeforeEach
    void setUp() {
        offlineService = new OfflineService(
                problemMapper,
                problemTagMapper,
                recallQuestionMapper,
                problemMistakeMapper,
                problemNoteMapper,
                annotationMapper,
                templateMapper,
                new ObjectMapper()
        );
    }

    @Test
    void buildsCompletePackForEveryEnabledProblem() {
        Problem problem = problem(1L, 1, 1, "两数之和");
        when(problemMapper.selectAllEnabledForOffline()).thenReturn(List.of(problem));
        when(problemTagMapper.selectTagNamesByProblemIds(anyList())).thenReturn(List.of(tag(1L, "数组")));
        when(recallQuestionMapper.selectList(org.mockito.ArgumentMatchers.any()))
                .thenReturn(List.of(question(11L, "为什么用哈希表？", "把查找降到 O(1)。")));
        when(problemMistakeMapper.selectList(org.mockito.ArgumentMatchers.any()))
                .thenReturn(List.of(mistake("先想暴力解。")));
        when(problemNoteMapper.selectList(org.mockito.ArgumentMatchers.any()))
                .thenReturn(List.of(note(1L, "## 笔记\n\n用 HashMap。")));
        when(annotationMapper.selectList(org.mockito.ArgumentMatchers.any()))
                .thenReturn(List.of(annotation(1L, "for 循环")));
        when(templateMapper.selectList(org.mockito.ArgumentMatchers.any()))
                .thenReturn(List.of(template(1L, "    return 1;")));

        OfflinePackVO pack = offlineService.buildPack();

        assertThat(pack.schemaVersion()).isEqualTo(1);
        assertThat(pack.problemCount()).isEqualTo(1);
        OfflineProblemVO item = pack.problems().getFirst();
        assertThat(item.problemId()).isEqualTo(1L);
        assertThat(item.leetcodeNumber()).isEqualTo(1);
        assertThat(item.hot100Order()).isEqualTo(1);
        assertThat(item.title()).isEqualTo("两数之和");
        assertThat(item.difficulty()).isEqualTo(Difficulty.EASY);
        assertThat(item.tags()).containsExactly("数组");
        assertThat(item.descriptionMarkdown()).isEqualTo("题面");
        assertThat(item.hint()).isEqualTo("提示");
        assertThat(item.coreIdea()).isEqualTo("核心思路");
        assertThat(item.keyCode()).isEqualTo("关键代码");
        assertThat(item.fullCode()).isEqualTo("完整代码");
        assertThat(item.recallQuestions()).hasSize(1);
        assertThat(item.recallQuestions().getFirst().answer()).isEqualTo("把查找降到 O(1)。");
        assertThat(item.mistakes()).containsExactly("先想暴力解。");
        assertThat(item.annotations()).hasSize(1);
        assertThat(item.annotations().getFirst().contentMarkdown()).isEqualTo("批注正文");
        assertThat(item.noteMarkdown()).isEqualTo("## 笔记\n\n用 HashMap。");
        assertThat(item.noteUpdatedAt()).isEqualTo(LocalDateTime.of(2026, 11, 5, 10, 0));
        assertThat(item.dictationAnswers()).containsEntry("blank_1", "    return 1;");
        assertThat(item.keywords()).containsExactly("哈希表");
        assertThat(item.templateCode()).contains("    {{blank_1}}");
        assertThat(item.updatedAt()).isEqualTo(LocalDateTime.of(2026, 11, 5, 9, 0));
    }

    @Test
    void keepsProblemWithoutTemplateOrNoteReadable() {
        when(problemMapper.selectAllEnabledForOffline()).thenReturn(List.of(problem(2L, 2, 2, "无资料")));
        when(problemTagMapper.selectTagNamesByProblemIds(anyList())).thenReturn(List.of());
        when(recallQuestionMapper.selectList(org.mockito.ArgumentMatchers.any())).thenReturn(List.of());
        when(problemMistakeMapper.selectList(org.mockito.ArgumentMatchers.any())).thenReturn(List.of());
        when(problemNoteMapper.selectList(org.mockito.ArgumentMatchers.any())).thenReturn(List.of());
        when(annotationMapper.selectList(org.mockito.ArgumentMatchers.any())).thenReturn(List.of());
        when(templateMapper.selectList(org.mockito.ArgumentMatchers.any())).thenReturn(List.of());

        OfflineProblemVO item = offlineService.buildPack().problems().getFirst();

        assertThat(item.templateCode()).isEmpty();
        assertThat(item.dictationAnswers()).isEmpty();
        assertThat(item.keywords()).isEmpty();
        assertThat(item.noteMarkdown()).isEmpty();
        assertThat(item.noteUpdatedAt()).isNull();
    }

    @Test
    void ignoresBrokenTemplateJsonInsteadOfFailingTheWholePack() {
        when(problemMapper.selectAllEnabledForOffline()).thenReturn(List.of(problem(3L, 3, 3, "坏模板")));
        when(problemTagMapper.selectTagNamesByProblemIds(anyList())).thenReturn(List.of());
        when(recallQuestionMapper.selectList(org.mockito.ArgumentMatchers.any())).thenReturn(List.of());
        when(problemMistakeMapper.selectList(org.mockito.ArgumentMatchers.any())).thenReturn(List.of());
        when(problemNoteMapper.selectList(org.mockito.ArgumentMatchers.any())).thenReturn(List.of());
        when(annotationMapper.selectList(org.mockito.ArgumentMatchers.any())).thenReturn(List.of());
        DictationTemplate broken = template(3L, "答案");
        broken.setAnswerJson("{not json");
        broken.setKeywordJson("not json");
        when(templateMapper.selectList(org.mockito.ArgumentMatchers.any())).thenReturn(List.of(broken));

        OfflineProblemVO item = offlineService.buildPack().problems().getFirst();

        assertThat(item.dictationAnswers()).isEmpty();
        assertThat(item.keywords()).isEmpty();
        assertThat(item.templateCode()).isEqualTo("class Solution {\n{{blank_1}}\n}");
    }

    private Problem problem(Long id, int leetcodeNumber, int hot100Order, String title) {
        Problem problem = new Problem();
        problem.setId(id);
        problem.setLeetcodeNumber(leetcodeNumber);
        problem.setHot100Order(hot100Order);
        problem.setTitle(title);
        problem.setDifficulty(Difficulty.EASY);
        problem.setDescriptionMarkdown("题面");
        problem.setCoreIdea("核心思路");
        problem.setHint("提示");
        problem.setKeyCode("关键代码");
        problem.setFullCode("完整代码");
        problem.setStatus(1);
        problem.setCreatedAt(LocalDateTime.of(2026, 11, 1, 9, 0));
        problem.setUpdatedAt(LocalDateTime.of(2026, 11, 5, 9, 0));
        return problem;
    }

    private ProblemTagNameVO tag(Long problemId, String name) {
        ProblemTagNameVO tag = new ProblemTagNameVO();
        tag.setProblemId(problemId);
        tag.setName(name);
        return tag;
    }

    private RecallQuestion question(Long id, String question, String answer) {
        RecallQuestion row = new RecallQuestion();
        row.setId(id);
        row.setProblemId(1L);
        row.setQuestionText(question);
        row.setAnswerText(answer);
        row.setSortOrder(1);
        return row;
    }

    private ProblemMistake mistake(String content) {
        ProblemMistake row = new ProblemMistake();
        row.setId(1L);
        row.setProblemId(1L);
        row.setContent(content);
        row.setSortOrder(1);
        return row;
    }

    private ProblemNote note(Long problemId, String markdown) {
        ProblemNote row = new ProblemNote();
        row.setId(1L);
        row.setProblemId(problemId);
        row.setContentMarkdown(markdown);
        row.setUpdatedAt(LocalDateTime.of(2026, 11, 5, 10, 0));
        return row;
    }

    private ProblemCodeAnnotation annotation(Long problemId, String anchorText) {
        ProblemCodeAnnotation row = new ProblemCodeAnnotation();
        row.setId(1L);
        row.setProblemId(problemId);
        row.setLabel("关键");
        row.setAnchorText(anchorText);
        row.setOccurrenceIndex(0);
        row.setStartLine(1);
        row.setStartColumn(0);
        row.setEndLine(1);
        row.setEndColumn(5);
        row.setContentMarkdown("批注正文");
        row.setCreatedAt(LocalDateTime.of(2026, 11, 2, 9, 0));
        row.setUpdatedAt(LocalDateTime.of(2026, 11, 2, 9, 0));
        return row;
    }

    private DictationTemplate template(Long problemId, String answer) {
        DictationTemplate template = new DictationTemplate();
        template.setId(1L);
        template.setProblemId(problemId);
        template.setLanguage(Language.JAVA);
        template.setTemplateCode("class Solution {\n{{blank_1}}\n}");
        template.setAnswerJson("{\"blank_1\":\"" + answer + "\"}");
        template.setKeywordJson("[\"哈希表\"]");
        template.setUpdatedAt(LocalDateTime.of(2026, 11, 4, 9, 0));
        return template;
    }
}