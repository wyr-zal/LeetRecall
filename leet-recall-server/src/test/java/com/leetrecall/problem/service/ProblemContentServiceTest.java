package com.leetrecall.problem.service;

import com.leetrecall.common.enums.Difficulty;
import com.leetrecall.common.exception.BusinessException;
import com.leetrecall.problem.dto.ProblemContentUpdateDTO;
import com.leetrecall.problem.entity.Problem;
import com.leetrecall.problem.entity.ProblemMistake;
import com.leetrecall.problem.entity.ProblemTag;
import com.leetrecall.problem.entity.RecallQuestion;
import com.leetrecall.problem.entity.Tag;
import com.leetrecall.problem.mapper.ProblemMapper;
import com.leetrecall.problem.mapper.ProblemMistakeMapper;
import com.leetrecall.problem.mapper.ProblemTagMapper;
import com.leetrecall.problem.mapper.RecallQuestionMapper;
import com.leetrecall.problem.mapper.TagMapper;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.mockito.junit.jupiter.MockitoSettings;
import org.mockito.quality.Strictness;

import java.time.Clock;
import java.time.Instant;
import java.time.ZoneId;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
@MockitoSettings(strictness = Strictness.LENIENT)
class ProblemContentServiceTest {

    @Mock private ProblemMapper problemMapper;
    @Mock private ProblemTagMapper problemTagMapper;
    @Mock private TagMapper tagMapper;
    @Mock private RecallQuestionMapper recallQuestionMapper;
    @Mock private ProblemMistakeMapper problemMistakeMapper;

    private ProblemContentService service;

    @BeforeEach
    void setUp() {
        Clock clock = Clock.fixed(Instant.parse("2026-08-19T09:00:00Z"), ZoneId.of("Asia/Shanghai"));
        service = new ProblemContentService(
                problemMapper, problemTagMapper, tagMapper, recallQuestionMapper, problemMistakeMapper, clock);
    }

    @Test
    void shouldReturnEveryTagInsteadOfTheFirstFour() {
        when(problemMapper.selectById(1L)).thenReturn(activeProblem());
        when(recallQuestionMapper.selectList(any())).thenReturn(List.of(question(11L, "Q1", "A1", 1)));
        when(problemMistakeMapper.selectList(any())).thenReturn(List.of());
        when(problemTagMapper.selectAllTagNames(1L))
                .thenReturn(List.of("数组", "哈希表", "桶排序", "堆", "计数", "排序"));

        var result = service.get(1L);

        assertThat(result.tags()).containsExactly("数组", "哈希表", "桶排序", "堆", "计数", "排序");
        assertThat(result.recallQuestions()).singleElement()
                .satisfies(question -> assertThat(question.id()).isEqualTo(11L));
    }

    @Test
    void shouldKeepQuestionIdsForUntouchedQuestions() {
        when(problemMapper.selectById(1L)).thenReturn(activeProblem());
        when(recallQuestionMapper.selectList(any())).thenReturn(List.of(
                question(11L, "旧问题一", "旧答案一", 1),
                question(12L, "旧问题二", "旧答案二", 2)
        ));
        when(problemMistakeMapper.selectList(any())).thenReturn(List.of());
        when(problemTagMapper.selectAllTagNames(1L)).thenReturn(List.of());

        service.update(1L, request(List.of(
                new ProblemContentUpdateDTO.RecallQuestionInput(11L, "改过的问题一", "改过的答案一"),
                new ProblemContentUpdateDTO.RecallQuestionInput(12L, "旧问题二", "旧答案二")
        )));

        ArgumentCaptor<RecallQuestion> captor = ArgumentCaptor.forClass(RecallQuestion.class);
        verify(recallQuestionMapper, org.mockito.Mockito.atLeastOnce()).updateById(captor.capture());
        assertThat(captor.getAllValues()).extracting(RecallQuestion::getId).containsOnly(11L, 12L);
        verify(recallQuestionMapper, never()).insert(any(RecallQuestion.class));
        verify(recallQuestionMapper, never()).deleteById(any(Long.class));
    }

    @Test
    void shouldParkKeptQuestionsOnNegativeOrdersBeforeRenumbering() {
        when(problemMapper.selectById(1L)).thenReturn(activeProblem());
        when(recallQuestionMapper.selectList(any())).thenReturn(List.of(
                question(11L, "第一", "答一", 1),
                question(12L, "第二", "答二", 2)
        ));
        when(problemMistakeMapper.selectList(any())).thenReturn(List.of());
        when(problemTagMapper.selectAllTagNames(1L)).thenReturn(List.of());

        // 交换顺序：若不先挪到负号位，重排会撞 UNIQUE (problem_id, sort_order)
        service.update(1L, request(List.of(
                new ProblemContentUpdateDTO.RecallQuestionInput(12L, "第二", "答二"),
                new ProblemContentUpdateDTO.RecallQuestionInput(11L, "第一", "答一")
        )));

        ArgumentCaptor<RecallQuestion> captor = ArgumentCaptor.forClass(RecallQuestion.class);
        verify(recallQuestionMapper, org.mockito.Mockito.atLeastOnce()).updateById(captor.capture());
        List<Integer> orders = captor.getAllValues().stream().map(RecallQuestion::getSortOrder).toList();
        assertThat(orders.subList(0, 2)).allMatch(order -> order < 0);
        assertThat(orders.subList(2, 4)).containsExactly(1, 2);
    }

    @Test
    void shouldInsertAddedQuestionsAndDeleteRemovedOnes() {
        when(problemMapper.selectById(1L)).thenReturn(activeProblem());
        when(recallQuestionMapper.selectList(any())).thenReturn(List.of(
                question(11L, "保留", "答一", 1),
                question(12L, "将被删除", "答二", 2)
        ));
        when(problemMistakeMapper.selectList(any())).thenReturn(List.of());
        when(problemTagMapper.selectAllTagNames(1L)).thenReturn(List.of());

        service.update(1L, request(List.of(
                new ProblemContentUpdateDTO.RecallQuestionInput(11L, "保留", "答一"),
                new ProblemContentUpdateDTO.RecallQuestionInput(null, "新增的问题", "新增的答案")
        )));

        verify(recallQuestionMapper).deleteById(12L);
        ArgumentCaptor<RecallQuestion> captor = ArgumentCaptor.forClass(RecallQuestion.class);
        verify(recallQuestionMapper).insert(captor.capture());
        assertThat(captor.getValue().getQuestionText()).isEqualTo("新增的问题");
        assertThat(captor.getValue().getSortOrder()).isEqualTo(2);
    }

    @Test
    void shouldRejectQuestionIdsThatBelongToAnotherProblem() {
        when(problemMapper.selectById(1L)).thenReturn(activeProblem());
        when(recallQuestionMapper.selectList(any())).thenReturn(List.of(question(11L, "Q", "A", 1)));

        assertThatThrownBy(() -> service.update(1L, request(List.of(
                new ProblemContentUpdateDTO.RecallQuestionInput(999L, "越界的问题", "答案")
        )))).isInstanceOf(BusinessException.class).hasMessage("请求参数错误");
    }

    @Test
    void shouldDeduplicateTagsBeforeLinkingThem() {
        when(problemMapper.selectById(1L)).thenReturn(activeProblem());
        when(recallQuestionMapper.selectList(any())).thenReturn(List.of(question(11L, "Q", "A", 1)));
        when(problemMistakeMapper.selectList(any())).thenReturn(List.of());
        when(problemTagMapper.selectAllTagNames(1L)).thenReturn(List.of());
        Tag existing = new Tag();
        existing.setId(7L);
        existing.setName("数组");
        when(tagMapper.selectOne(any())).thenReturn(existing);

        var payload = new ProblemContentUpdateDTO(
                "347. 前 K 个高频元素", Difficulty.MEDIUM, "题面", List.of("数组", "数组"),
                List.of(new ProblemContentUpdateDTO.RecallQuestionInput(11L, "Q", "A")),
                "提示", "核心思路", List.of("易错点"), "关键代码");

        service.update(1L, payload);

        verify(problemTagMapper, org.mockito.Mockito.times(1)).insert(any(ProblemTag.class));
    }

    @Test
    void shouldRejectUnclosedCodeFencesInTheDescription() {
        when(problemMapper.selectById(1L)).thenReturn(activeProblem());

        var payload = new ProblemContentUpdateDTO(
                "标题", Difficulty.MEDIUM, "开头\n```java\nint a = 1;\n", List.of(),
                List.of(new ProblemContentUpdateDTO.RecallQuestionInput(null, "Q", "A")),
                "提示", "核心思路", List.of(), "关键代码");

        assertThatThrownBy(() -> service.update(1L, payload))
                .isInstanceOf(BusinessException.class)
                .hasMessageContaining("代码围栏")
                .hasMessageContaining("第 2 行");
    }

    @Test
    void shouldNeverTouchNotesProgressOrDictationData() {
        when(problemMapper.selectById(1L)).thenReturn(activeProblem());
        when(recallQuestionMapper.selectList(any())).thenReturn(List.of(question(11L, "Q", "A", 1)));
        when(problemMistakeMapper.selectList(any())).thenReturn(List.of());
        when(problemTagMapper.selectAllTagNames(1L)).thenReturn(List.of());

        service.update(1L, request(List.of(
                new ProblemContentUpdateDTO.RecallQuestionInput(11L, "Q", "A")
        )));

        // 该服务的依赖里根本没有 note/progress/dictation 的 Mapper，这里断言主表字段没被越权改动。
        ArgumentCaptor<Problem> captor = ArgumentCaptor.forClass(Problem.class);
        verify(problemMapper).updateById(captor.capture());
        Problem saved = captor.getValue();
        assertThat(saved.getFullCode()).isEqualTo("原有完整代码");
        assertThat(saved.getHot100Order()).isEqualTo(74);
        assertThat(saved.getLeetcodeNumber()).isEqualTo(347);
        assertThat(saved.getTitle()).isEqualTo("347. 前 K 个高频元素");
    }

    @Test
    void shouldRejectMissingProblems() {
        when(problemMapper.selectById(99L)).thenReturn(null);

        assertThatThrownBy(() -> service.get(99L))
                .isInstanceOf(BusinessException.class)
                .hasMessage("题目不存在");
    }

    private ProblemContentUpdateDTO request(List<ProblemContentUpdateDTO.RecallQuestionInput> questions) {
        return new ProblemContentUpdateDTO(
                "347. 前 K 个高频元素", Difficulty.MEDIUM, "题面内容", List.of("数组"),
                questions, "提示", "核心思路", List.of("易错点一"), "关键代码");
    }

    private Problem activeProblem() {
        Problem problem = new Problem();
        problem.setId(1L);
        problem.setLeetcodeNumber(347);
        problem.setHot100Order(74);
        problem.setStatus(1);
        problem.setTitle("旧标题");
        problem.setDifficulty(Difficulty.MEDIUM);
        problem.setFullCode("原有完整代码");
        return problem;
    }

    private RecallQuestion question(Long id, String text, String answer, int order) {
        RecallQuestion question = new RecallQuestion();
        question.setId(id);
        question.setProblemId(1L);
        question.setQuestionText(text);
        question.setAnswerText(answer);
        question.setSortOrder(order);
        return question;
    }
}
