package com.leetrecall.dictation.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.leetrecall.common.enums.Language;
import com.leetrecall.dictation.dto.DictationSubmitDTO;
import com.leetrecall.dictation.entity.DictationTemplate;
import com.leetrecall.dictation.mapper.DictationAnswerViewMapper;
import com.leetrecall.dictation.mapper.DictationRecordMapper;
import com.leetrecall.dictation.mapper.DictationTemplateMapper;
import com.leetrecall.problem.entity.Problem;
import com.leetrecall.problem.mapper.ProblemMapper;
import com.leetrecall.problem.mapper.ProblemMistakeMapper;
import com.leetrecall.problem.mapper.ProblemTagMapper;
import com.leetrecall.problem.mapper.RecallQuestionMapper;
import org.junit.jupiter.api.Test;
import org.mockito.ArgumentCaptor;

import java.time.Clock;
import java.util.Map;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

class DictationServiceSnapshotTest {
    @Test
    void savesTheTemplateAndCorrectAnswersUsedByThisSubmission() {
        DictationTemplateMapper templateMapper = mock(DictationTemplateMapper.class);
        DictationRecordMapper recordMapper = mock(DictationRecordMapper.class);
        DictationAnswerViewMapper answerViewMapper = mock(DictationAnswerViewMapper.class);
        ProblemMapper problemMapper = mock(ProblemMapper.class);
        Problem problem = new Problem(); problem.setId(1L); problem.setStatus(1);
        when(problemMapper.selectById(1L)).thenReturn(problem);
        DictationTemplate template = new DictationTemplate();
        template.setProblemId(1L); template.setLanguage(Language.JAVA); template.setTemplateCode("class Solution { {{blank_1}} }"); template.setAnswerJson("{\"blank_1\":\"return;\"}");
        when(templateMapper.selectOne(any())).thenReturn(template);
        when(answerViewMapper.selectCount(any())).thenReturn(0L);
        DictationService service = new DictationService(templateMapper, recordMapper, answerViewMapper, problemMapper,
                mock(ProblemTagMapper.class), mock(ProblemMistakeMapper.class), mock(RecallQuestionMapper.class),
                new DictationScorer(), new ObjectMapper(), Clock.systemUTC());

        service.submit(1L, "session", new DictationSubmitDTO(Map.of("blank_1", "return;"), false, 12));

        ArgumentCaptor<com.leetrecall.dictation.entity.DictationRecord> captor = ArgumentCaptor.forClass(com.leetrecall.dictation.entity.DictationRecord.class);
        org.mockito.Mockito.verify(recordMapper).insert(captor.capture());
        assertThat(captor.getValue().getTemplateCodeSnapshot()).isEqualTo(template.getTemplateCode());
        assertThat(captor.getValue().getAnswerJsonSnapshot()).isEqualTo(template.getAnswerJson());
    }
}
