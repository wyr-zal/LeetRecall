package com.leetrecall.problem.service;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.leetrecall.common.exception.ErrorCode;
import com.leetrecall.problem.dto.CodeAnnotationSaveDTO;
import com.leetrecall.problem.entity.Problem;
import com.leetrecall.problem.entity.ProblemCodeAnnotation;
import com.leetrecall.problem.mapper.ProblemCodeAnnotationMapper;
import com.leetrecall.problem.mapper.ProblemMapper;
import com.leetrecall.problem.vo.CodeAnnotationVO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 默写答案代码上的选区批注。锚点由前端按 problem.full_code 计算，这里只负责存取，
 * 代码变更后的重定位在前端完成（位置失配时按 anchorText 的第 occurrenceIndex 次出现兜底）。
 */
@Service
@RequiredArgsConstructor
public class ProblemCodeAnnotationService {
    private final ProblemMapper problemMapper;
    private final ProblemCodeAnnotationMapper annotationMapper;

    public List<CodeAnnotationVO> list(Long problemId) {
        requireProblem(problemId);
        return annotationMapper.selectList(Wrappers.<ProblemCodeAnnotation>lambdaQuery()
                        .eq(ProblemCodeAnnotation::getProblemId, problemId)
                        .orderByAsc(ProblemCodeAnnotation::getStartLine)
                        .orderByAsc(ProblemCodeAnnotation::getStartColumn)
                        .orderByAsc(ProblemCodeAnnotation::getId))
                .stream()
                .map(this::toView)
                .toList();
    }

    @Transactional
    public CodeAnnotationVO create(Long problemId, CodeAnnotationSaveDTO request) {
        requireProblem(problemId);
        LocalDateTime now = LocalDateTime.now();
        ProblemCodeAnnotation annotation = new ProblemCodeAnnotation();
        annotation.setProblemId(problemId);
        applyRequest(annotation, request);
        annotation.setCreatedAt(now);
        annotation.setUpdatedAt(now);
        annotationMapper.insert(annotation);
        return toView(annotation);
    }

    @Transactional
    public CodeAnnotationVO update(Long problemId, Long annotationId, CodeAnnotationSaveDTO request) {
        requireProblem(problemId);
        ProblemCodeAnnotation annotation = requireAnnotation(problemId, annotationId);
        applyRequest(annotation, request);
        annotation.setUpdatedAt(LocalDateTime.now());
        annotationMapper.updateById(annotation);
        return toView(annotation);
    }

    @Transactional
    public void delete(Long problemId, Long annotationId) {
        requireProblem(problemId);
        ProblemCodeAnnotation annotation = requireAnnotation(problemId, annotationId);
        annotationMapper.deleteById(annotation.getId());
    }

    private void applyRequest(ProblemCodeAnnotation annotation, CodeAnnotationSaveDTO request) {
        String label = request.label() == null || request.label().isBlank() ? null : request.label().trim();
        annotation.setLabel(label);
        annotation.setAnchorText(request.anchorText());
        annotation.setOccurrenceIndex(request.occurrenceIndex());
        annotation.setStartLine(request.startLine());
        annotation.setStartColumn(request.startColumn());
        annotation.setEndLine(request.endLine());
        annotation.setEndColumn(request.endColumn());
        annotation.setContentMarkdown(request.contentMarkdown());
    }

    private ProblemCodeAnnotation requireAnnotation(Long problemId, Long annotationId) {
        ProblemCodeAnnotation annotation = annotationMapper.selectOne(
                Wrappers.<ProblemCodeAnnotation>lambdaQuery()
                        .eq(ProblemCodeAnnotation::getId, annotationId)
                        .eq(ProblemCodeAnnotation::getProblemId, problemId));
        if (annotation == null) {
            throw ErrorCode.CODE_ANNOTATION_NOT_FOUND.exception();
        }
        return annotation;
    }

    private void requireProblem(Long problemId) {
        Problem problem = problemMapper.selectById(problemId);
        if (problem == null || !Integer.valueOf(1).equals(problem.getStatus())) {
            throw ErrorCode.PROBLEM_NOT_FOUND.exception();
        }
    }

    private CodeAnnotationVO toView(ProblemCodeAnnotation annotation) {
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
}
