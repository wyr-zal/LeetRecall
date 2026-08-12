package com.leetrecall.problem.service;

import com.leetrecall.common.exception.BusinessException;
import com.leetrecall.problem.entity.Problem;
import com.leetrecall.problem.entity.ProblemNote;
import com.leetrecall.problem.mapper.ProblemMapper;
import com.leetrecall.problem.mapper.ProblemNoteMapper;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class ProblemNoteServiceTest {
    @Mock private ProblemMapper problemMapper;
    @Mock private ProblemNoteMapper problemNoteMapper;

    private ProblemNoteService service;

    @BeforeEach
    void setUp() {
        service = new ProblemNoteService(problemMapper, problemNoteMapper);
    }

    @Test
    void shouldReturnEmptyMarkdownWhenTheProblemHasNoNote() {
        when(problemMapper.selectById(1L)).thenReturn(activeProblem(1L));
        when(problemNoteMapper.selectOne(any())).thenReturn(null);

        var result = service.get(1L);

        assertThat(result.problemId()).isEqualTo(1L);
        assertThat(result.markdown()).isEmpty();
        assertThat(result.updatedAt()).isNull();
    }

    @Test
    void shouldCreateANoteForTheProblem() {
        when(problemMapper.selectById(1L)).thenReturn(activeProblem(1L));
        when(problemNoteMapper.selectOne(any())).thenReturn(null);
        ArgumentCaptor<ProblemNote> captor = ArgumentCaptor.forClass(ProblemNote.class);

        var result = service.save(1L, "## 核心思路");

        verify(problemNoteMapper).insert(captor.capture());
        assertThat(captor.getValue().getContentMarkdown()).isEqualTo("## 核心思路");
        assertThat(result.markdown()).isEqualTo("## 核心思路");
    }

    @Test
    void shouldUpdateAnExistingNoteWithoutCreatingAnotherRow() {
        when(problemMapper.selectById(1L)).thenReturn(activeProblem(1L));
        ProblemNote existing = new ProblemNote();
        existing.setId(9L);
        existing.setProblemId(1L);
        existing.setContentMarkdown("旧笔记");
        when(problemNoteMapper.selectOne(any())).thenReturn(existing);

        var result = service.save(1L, "**新笔记**");

        verify(problemNoteMapper).updateById(existing);
        verify(problemNoteMapper, never()).insert(any(ProblemNote.class));
        assertThat(result.markdown()).isEqualTo("**新笔记**");
    }

    @Test
    void shouldRejectNotesForMissingProblems() {
        when(problemMapper.selectById(99L)).thenReturn(null);

        assertThatThrownBy(() -> service.get(99L))
                .isInstanceOf(BusinessException.class)
                .hasMessage("题目不存在");
    }

    private Problem activeProblem(Long id) {
        Problem problem = new Problem();
        problem.setId(id);
        problem.setStatus(1);
        return problem;
    }
}
