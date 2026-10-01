package com.leetrecall.importdata.service;

import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.leetrecall.common.enums.Difficulty;
import com.leetrecall.dictation.mapper.DictationTemplateMapper;
import com.leetrecall.importdata.dto.ProblemLearningMaterialsImportDTO;
import com.leetrecall.problem.entity.Problem;
import com.leetrecall.problem.entity.ProblemNote;
import com.leetrecall.problem.entity.RecallQuestion;
import com.leetrecall.problem.mapper.ProblemMapper;
import com.leetrecall.problem.mapper.ProblemMistakeMapper;
import com.leetrecall.problem.mapper.ProblemNoteMapper;
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

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.isNull;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

@ExtendWith(MockitoExtension.class)
class ProblemImportServiceTest {

    @Mock private ProblemMapper problemMapper;
    @Mock private RecallQuestionMapper recallQuestionMapper;
    @Mock private ProblemMistakeMapper problemMistakeMapper;
    @Mock private DictationTemplateMapper dictationTemplateMapper;
    @Mock private ProblemNoteMapper problemNoteMapper;

    private ProblemImportService service;

    @BeforeEach
    void setUp() {
        Clock clock = Clock.fixed(Instant.parse("2026-07-28T02:00:00Z"), ZoneId.of("Asia/Shanghai"));
        service = new ProblemImportService(
                problemMapper,
                recallQuestionMapper,
                problemMistakeMapper,
                dictationTemplateMapper,
                problemNoteMapper,
                new ObjectMapper(),
                clock
        );
    }

    @Test
    void doesNotCreateAnImportTargetWhenOfficialProblemIsMissing() {
        when(problemMapper.selectOne(any())).thenReturn(null);

        assertThatThrownBy(() -> service.updateExternalLearningMaterials(request(null)))
                .hasMessage("题库中不存在该官方题目，外部导入不能新建题目");

        verify(problemMapper, never()).insert(any(Problem.class));
        verify(problemMapper, never()).updateById(any(Problem.class));
        verify(recallQuestionMapper, never()).delete(any());
        verify(problemMistakeMapper, never()).delete(any());
        verify(dictationTemplateMapper, never()).delete(any());
        verify(problemNoteMapper, never()).selectOne(any());
    }

    @Test
    void shouldReplaceOnlyLearningMaterialsAndPreserveOfficialFields() {
        Problem existing = new Problem();
        existing.setId(42L);
        existing.setLeetcodeNumber(1);
        existing.setHot100Order(1);
        existing.setTitle("官方标题");
        existing.setDifficulty(Difficulty.EASY);
        existing.setDescriptionMarkdown("官方题面");
        existing.setStatus(1);
        when(problemMapper.selectOne(any())).thenReturn(existing);

        var result = service.updateExternalLearningMaterials(request(null));

        assertThat(result.problemId()).isEqualTo(42L);
        assertThat(existing.getTitle()).isEqualTo("官方标题");
        assertThat(existing.getDifficulty()).isEqualTo(Difficulty.EASY);
        assertThat(existing.getDescriptionMarkdown()).isEqualTo("官方题面");
        assertThat(existing.getHot100Order()).isEqualTo(1);
        assertThat(existing.getStatus()).isEqualTo(1);
        ArgumentCaptor<UpdateWrapper<Problem>> update = ArgumentCaptor.forClass(UpdateWrapper.class);
        verify(problemMapper).update(isNull(), update.capture());
        assertThat(update.getValue().getSqlSet())
                .contains("core_idea", "hint", "key_code", "full_code", "updated_at")
                .doesNotContain("title", "difficulty", "description_markdown", "hot100_order", "status");
        verify(problemMapper, never()).insert(any(Problem.class));
        verify(problemMapper, never()).updateById(any(Problem.class));
        verify(recallQuestionMapper).delete(any());
        verify(problemMistakeMapper).delete(any());
        verify(dictationTemplateMapper).delete(any());
        ArgumentCaptor<RecallQuestion> questions = ArgumentCaptor.forClass(RecallQuestion.class);
        verify(recallQuestionMapper, times(3)).insert(questions.capture());
        assertThat(questions.getAllValues()).extracting(RecallQuestion::getAnswerText)
                .containsExactly("答一", "答二", "答三");
    }

    @Test
    void shouldWriteTheImportedNoteWhenTheProblemHasNoneYet() {
        Problem existing = new Problem();
        existing.setId(42L);
        existing.setLeetcodeNumber(1);
        when(problemMapper.selectOne(any())).thenReturn(existing);
        when(problemNoteMapper.selectOne(any())).thenReturn(null);

        service.updateExternalLearningMaterials(request("## 我的笔记\n先查补数再写入。"));

        ArgumentCaptor<ProblemNote> saved = ArgumentCaptor.forClass(ProblemNote.class);
        verify(problemNoteMapper).insert(saved.capture());
        assertThat(saved.getValue().getProblemId()).isEqualTo(42L);
        assertThat(saved.getValue().getContentMarkdown()).isEqualTo("## 我的笔记\n先查补数再写入。");
        verify(problemNoteMapper, never()).updateById(any(ProblemNote.class));
    }

    @Test
    void shouldKeepAHandwrittenNoteInsteadOfOverwritingItOnImport() {
        Problem existing = new Problem();
        existing.setId(42L);
        existing.setLeetcodeNumber(1);
        when(problemMapper.selectOne(any())).thenReturn(existing);
        ProblemNote handwritten = new ProblemNote();
        handwritten.setId(5L);
        handwritten.setProblemId(42L);
        handwritten.setContentMarkdown("我自己写的笔记");
        when(problemNoteMapper.selectOne(any())).thenReturn(handwritten);

        service.updateExternalLearningMaterials(request("## AI 生成的笔记"));

        assertThat(handwritten.getContentMarkdown()).isEqualTo("我自己写的笔记");
        verify(problemNoteMapper, never()).insert(any(ProblemNote.class));
        verify(problemNoteMapper, never()).updateById(any(ProblemNote.class));
    }

    @Test
    void shouldFillAnEmptyNoteRowWithTheImportedNote() {
        Problem existing = new Problem();
        existing.setId(42L);
        existing.setLeetcodeNumber(1);
        when(problemMapper.selectOne(any())).thenReturn(existing);
        ProblemNote blankNote = new ProblemNote();
        blankNote.setId(5L);
        blankNote.setProblemId(42L);
        blankNote.setContentMarkdown("   ");
        when(problemNoteMapper.selectOne(any())).thenReturn(blankNote);

        service.updateExternalLearningMaterials(request("## AI 生成的笔记"));

        verify(problemNoteMapper).updateById(blankNote);
        assertThat(blankNote.getContentMarkdown()).isEqualTo("## AI 生成的笔记");
    }

    @Test
    void shouldNotTouchTheNoteTableWhenTheJsonHasNoNote() {
        Problem existing = new Problem();
        existing.setId(42L);
        existing.setLeetcodeNumber(1);
        when(problemMapper.selectOne(any())).thenReturn(existing);

        service.updateExternalLearningMaterials(request(null));

        verify(problemNoteMapper, never()).selectOne(any());
        verify(problemNoteMapper, never()).insert(any(ProblemNote.class));
        verify(problemNoteMapper, never()).updateById(any(ProblemNote.class));
    }

    private ProblemLearningMaterialsImportDTO request(String noteMarkdown) {
        return new ProblemLearningMaterialsImportDTO(
                1,
                noteMarkdown,
                "遍历时查找补数。",
                "先查再存。",
                List.of("不能复用同一元素"),
                "class Solution {}",
                "return new int[] {};",
                List.of(
                        new ProblemLearningMaterialsImportDTO.RecallQuestion("问题一", "答一"),
                        new ProblemLearningMaterialsImportDTO.RecallQuestion("问题二", "答二"),
                        new ProblemLearningMaterialsImportDTO.RecallQuestion("问题三", "答三")
                ),
                "return {{blank_1}};",
                java.util.Map.of("blank_1", "result"),
                List.of("补数")
        );
    }
}
