package com.leetrecall.dictation.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.leetrecall.common.enums.Language;
import com.leetrecall.dictation.entity.DictationTemplate;
import com.leetrecall.dictation.mapper.DictationAnswerViewMapper;
import com.leetrecall.dictation.mapper.DictationRecordMapper;
import com.leetrecall.dictation.mapper.DictationTemplateMapper;
import com.leetrecall.dictation.vo.DictationProblemDetailVO;
import com.leetrecall.problem.entity.Problem;
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

class DictationServiceIndentTest {

    private DictationService buildService(String templateCode, String answerJson) {
        DictationTemplateMapper templateMapper = mock(DictationTemplateMapper.class);
        ProblemMapper problemMapper = mock(ProblemMapper.class);
        ProblemTagMapper tagMapper = mock(ProblemTagMapper.class);
        ProblemMistakeMapper mistakeMapper = mock(ProblemMistakeMapper.class);
        RecallQuestionMapper recallQuestionMapper = mock(RecallQuestionMapper.class);
        Problem problem = new Problem();
        problem.setId(1L);
        problem.setStatus(1);
        problem.setLeetcodeNumber(215);
        problem.setTitle("数组中的第K个最大元素");
        when(problemMapper.selectById(1L)).thenReturn(problem);
        DictationTemplate template = new DictationTemplate();
        template.setProblemId(1L);
        template.setLanguage(Language.JAVA);
        template.setTemplateCode(templateCode);
        template.setAnswerJson(answerJson);
        when(templateMapper.selectOne(any())).thenReturn(template);
        when(tagMapper.selectTagNames(anyLong(), anyInt())).thenReturn(List.of());
        when(mistakeMapper.selectList(any())).thenReturn(List.of());
        when(recallQuestionMapper.selectList(any())).thenReturn(List.of());
        return new DictationService(templateMapper, mock(DictationRecordMapper.class),
                mock(DictationAnswerViewMapper.class), problemMapper, tagMapper, mistakeMapper,
                recallQuestionMapper, new DictationScorer(), new ObjectMapper(), Clock.systemUTC());
    }

    @Test
    void addsAnswerIndentationToTopLevelPlaceholderLines() {
        String templateCode = "class Solution {\n    int f() {\n{{blank_1}}\n    }\n}";
        String answerJson = "{\"blank_1\":\"        return 1;\"}";

        DictationProblemDetailVO detail = buildService(templateCode, answerJson).getProblemDetail(1L);

        assertThat(detail.templateCode())
                .isEqualTo("class Solution {\n    int f() {\n        {{blank_1}}\n    }\n}");
    }

    @Test
    void keepsTemplateUnchangedWhenAnswerHasNoIndentOrKeyMissing() {
        String templateCode = "{{blank_1}}\n{{blank_2}}\ninline {{blank_3}} stays";
        String answerJson = "{\"blank_1\":\"class A {}\",\"blank_3\":\"    x\"}";

        DictationProblemDetailVO detail = buildService(templateCode, answerJson).getProblemDetail(1L);

        assertThat(detail.templateCode()).isEqualTo(templateCode);
    }
}
