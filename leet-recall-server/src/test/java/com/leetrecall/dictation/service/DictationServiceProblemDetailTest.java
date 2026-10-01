package com.leetrecall.dictation.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.leetrecall.common.enums.Difficulty;
import com.leetrecall.common.enums.Language;
import com.leetrecall.dictation.entity.DictationTemplate;
import com.leetrecall.dictation.mapper.DictationAnswerViewMapper;
import com.leetrecall.dictation.mapper.DictationRecordMapper;
import com.leetrecall.dictation.mapper.DictationTemplateMapper;
import com.leetrecall.dictation.vo.DictationProblemDetailVO;
import com.leetrecall.problem.entity.Problem;
import com.leetrecall.problem.entity.RecallQuestion;
import com.leetrecall.problem.mapper.ProblemMapper;
import com.leetrecall.problem.mapper.ProblemMistakeMapper;
import com.leetrecall.problem.mapper.ProblemTagMapper;
import com.leetrecall.problem.mapper.RecallQuestionMapper;
import org.junit.jupiter.api.Test;

import java.time.Clock;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyInt;
import static org.mockito.ArgumentMatchers.anyLong;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

/** 默写页左栏（题面 / 回忆问答 / 核心思路）依赖详情接口透传，这里锁住这些字段。 */
class DictationServiceProblemDetailTest {

    @Test
    void exposesDescriptionRecallQuestionsAndCoreIdeaForTheLeftPane() {
        Problem problem = buildProblem();
        problem.setDifficulty(Difficulty.MEDIUM);
        problem.setDescriptionMarkdown("给定两个字符串 s 和 p");
        problem.setCoreIdea("滑动窗口");
        RecallQuestionMapper recallQuestionMapper = mock(RecallQuestionMapper.class);
        DictationService service = buildService(problem, recallQuestionMapper);

        RecallQuestion question = new RecallQuestion();
        question.setId(7L);
        question.setQuestionText("窗口何时收缩？");
        question.setAnswerText("cnt 出现负数时");
        when(recallQuestionMapper.selectList(any())).thenReturn(List.of(question));

        DictationProblemDetailVO detail = service.getProblemDetail(1L);

        assertThat(detail.difficulty()).isEqualTo(Difficulty.MEDIUM);
        assertThat(detail.descriptionMarkdown()).isEqualTo("给定两个字符串 s 和 p");
        assertThat(detail.coreIdea()).isEqualTo("滑动窗口");
        assertThat(detail.recallQuestions()).singleElement().satisfies(item -> {
            assertThat(item.id()).isEqualTo(7L);
            assertThat(item.question()).isEqualTo("窗口何时收缩？");
            assertThat(item.answer()).isEqualTo("cnt 出现负数时");
        });
    }

    @Test
    void fallsBackToEmptyTextWhenDescriptionOrCoreIdeaIsMissing() {
        DictationProblemDetailVO detail = buildService(buildProblem(), mock(RecallQuestionMapper.class))
                .getProblemDetail(1L);

        assertThat(detail.descriptionMarkdown()).isEmpty();
        assertThat(detail.coreIdea()).isEmpty();
        assertThat(detail.recallQuestions()).isEmpty();
    }

    private Problem buildProblem() {
        Problem problem = new Problem();
        problem.setId(1L);
        problem.setStatus(1);
        problem.setLeetcodeNumber(438);
        problem.setTitle("找到字符串中所有字母异位词");
        return problem;
    }

    private DictationService buildService(Problem problem, RecallQuestionMapper recallQuestionMapper) {
        DictationTemplateMapper templateMapper = mock(DictationTemplateMapper.class);
        ProblemMapper problemMapper = mock(ProblemMapper.class);
        ProblemTagMapper tagMapper = mock(ProblemTagMapper.class);
        ProblemMistakeMapper mistakeMapper = mock(ProblemMistakeMapper.class);
        DictationTemplate template = new DictationTemplate();
        template.setProblemId(1L);
        template.setLanguage(Language.JAVA);
        template.setTemplateCode("class Solution { {{blank_1}} }");
        template.setAnswerJson("{\"blank_1\":\"return;\"}");
        when(problemMapper.selectById(1L)).thenReturn(problem);
        when(templateMapper.selectOne(any())).thenReturn(template);
        when(tagMapper.selectTagNames(anyLong(), anyInt())).thenReturn(List.of());
        when(mistakeMapper.selectList(any())).thenReturn(List.of());
        when(recallQuestionMapper.selectList(any())).thenReturn(List.of());
        return new DictationService(templateMapper, mock(DictationRecordMapper.class),
                mock(DictationAnswerViewMapper.class), problemMapper, tagMapper, mistakeMapper,
                recallQuestionMapper, new DictationScorer(), new ObjectMapper(), Clock.systemUTC());
    }
}
