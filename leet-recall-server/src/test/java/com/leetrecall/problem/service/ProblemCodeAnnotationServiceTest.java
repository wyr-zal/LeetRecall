package com.leetrecall.problem.service;

import com.leetrecall.common.exception.BusinessException;
import com.leetrecall.problem.dto.CodeAnnotationSaveDTO;
import com.leetrecall.problem.entity.Problem;
import com.leetrecall.problem.entity.ProblemCodeAnnotation;
import com.leetrecall.problem.mapper.ProblemCodeAnnotationMapper;
import com.leetrecall.problem.mapper.ProblemMapper;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.LocalDateTime;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class ProblemCodeAnnotationServiceTest {
    @Mock private ProblemMapper problemMapper;
    @Mock private ProblemCodeAnnotationMapper annotationMapper;

    private ProblemCodeAnnotationService service;

    @BeforeEach
    void setUp() {
        service = new ProblemCodeAnnotationService(problemMapper, annotationMapper);
    }

    @Test
    void shouldListAnnotationsInCodeOrder() {
        when(problemMapper.selectById(1L)).thenReturn(activeProblem(1L));
        ProblemCodeAnnotation first = annotation(11L, 1L, 3, 5);
        ProblemCodeAnnotation second = annotation(12L, 1L, 8, 1);
        when(annotationMapper.selectList(any())).thenReturn(List.of(first, second));

        var result = service.list(1L);

        assertThat(result).extracting(item -> item.id()).containsExactly(11L, 12L);
        assertThat(result.get(0).anchorText()).isEqualTo("for (int i = 0; i < n; i++)");
    }

    @Test
    void shouldCreateAnnotationWithTrimmedOptionalLabel() {
        when(problemMapper.selectById(1L)).thenReturn(activeProblem(1L));
        ArgumentCaptor<ProblemCodeAnnotation> captor = ArgumentCaptor.forClass(ProblemCodeAnnotation.class);
        when(annotationMapper.insert(any(ProblemCodeAnnotation.class))).thenAnswer(invocation -> {
            ProblemCodeAnnotation saved = invocation.getArgument(0);
            saved.setId(20L);
            return 1;
        });

        var result = service.create(1L, request("  循环边界  "));

        verify(annotationMapper).insert(captor.capture());
        assertThat(captor.getValue().getLabel()).isEqualTo("循环边界");
        assertThat(captor.getValue().getProblemId()).isEqualTo(1L);
        assertThat(captor.getValue().getCreatedAt()).isNotNull();
        assertThat(result.id()).isEqualTo(20L);
        assertThat(result.label()).isEqualTo("循环边界");
    }

    @Test
    void shouldUpdateOnlyAnnotationBelongingToTheProblem() {
        when(problemMapper.selectById(1L)).thenReturn(activeProblem(1L));
        ProblemCodeAnnotation existing = annotation(21L, 1L, 2, 3);
        when(annotationMapper.selectOne(any())).thenReturn(existing);

        var result = service.update(1L, 21L, request("更新说明"));

        verify(annotationMapper).updateById(existing);
        assertThat(existing.getLabel()).isEqualTo("更新说明");
        assertThat(existing.getContentMarkdown()).isEqualTo("## 批注内容");
        assertThat(existing.getUpdatedAt()).isNotNull();
        assertThat(result.id()).isEqualTo(21L);
    }

    @Test
    void shouldDeleteAnnotationBelongingToTheProblem() {
        when(problemMapper.selectById(1L)).thenReturn(activeProblem(1L));
        ProblemCodeAnnotation existing = annotation(31L, 1L, 2, 3);
        when(annotationMapper.selectOne(any())).thenReturn(existing);

        service.delete(1L, 31L);

        verify(annotationMapper).deleteById(31L);
    }

    @Test
    void shouldRejectAnnotationFromAnotherProblem() {
        when(problemMapper.selectById(1L)).thenReturn(activeProblem(1L));
        when(annotationMapper.selectOne(any())).thenReturn(null);

        assertThatThrownBy(() -> service.update(1L, 99L, request("说明")))
                .isInstanceOf(BusinessException.class)
                .hasMessage("代码批注不存在");
        verify(annotationMapper, never()).updateById(any(ProblemCodeAnnotation.class));
    }

    @Test
    void shouldRejectMissingProblemBeforeAccessingAnnotations() {
        when(problemMapper.selectById(99L)).thenReturn(null);

        assertThatThrownBy(() -> service.list(99L))
                .isInstanceOf(BusinessException.class)
                .hasMessage("题目不存在");
        verify(annotationMapper, never()).selectList(any());
    }

    private CodeAnnotationSaveDTO request(String label) {
        return new CodeAnnotationSaveDTO(
                label,
                "for (int i = 0; i < n; i++)",
                0,
                3,
                5,
                3,
                28,
                "## 批注内容"
        );
    }

    private ProblemCodeAnnotation annotation(Long id, Long problemId, int line, int column) {
        ProblemCodeAnnotation annotation = new ProblemCodeAnnotation();
        annotation.setId(id);
        annotation.setProblemId(problemId);
        annotation.setLabel("循环边界");
        annotation.setAnchorText("for (int i = 0; i < n; i++)");
        annotation.setOccurrenceIndex(0);
        annotation.setStartLine(line);
        annotation.setStartColumn(column);
        annotation.setEndLine(line);
        annotation.setEndColumn(column + annotation.getAnchorText().length());
        annotation.setContentMarkdown("说明");
        annotation.setCreatedAt(LocalDateTime.now());
        annotation.setUpdatedAt(LocalDateTime.now());
        return annotation;
    }

    private Problem activeProblem(Long id) {
        Problem problem = new Problem();
        problem.setId(id);
        problem.setStatus(1);
        return problem;
    }
}
