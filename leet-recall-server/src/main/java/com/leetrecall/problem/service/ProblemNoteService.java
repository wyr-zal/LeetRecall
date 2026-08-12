package com.leetrecall.problem.service;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.leetrecall.common.exception.ErrorCode;
import com.leetrecall.problem.entity.Problem;
import com.leetrecall.problem.entity.ProblemNote;
import com.leetrecall.problem.mapper.ProblemMapper;
import com.leetrecall.problem.mapper.ProblemNoteMapper;
import com.leetrecall.problem.vo.ProblemNoteVO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;

@Service
@RequiredArgsConstructor
public class ProblemNoteService {
    private final ProblemMapper problemMapper;
    private final ProblemNoteMapper problemNoteMapper;

    public ProblemNoteVO get(Long problemId) {
        requireProblem(problemId);
        ProblemNote note = findByProblemId(problemId);
        if (note == null) {
            return new ProblemNoteVO(problemId, "", null);
        }
        return toView(note);
    }

    @Transactional
    public ProblemNoteVO save(Long problemId, String markdown) {
        requireProblem(problemId);
        ProblemNote note = findByProblemId(problemId);
        LocalDateTime now = LocalDateTime.now();
        if (note == null) {
            note = new ProblemNote();
            note.setProblemId(problemId);
            note.setContentMarkdown(markdown);
            note.setCreatedAt(now);
            note.setUpdatedAt(now);
            problemNoteMapper.insert(note);
        } else {
            note.setContentMarkdown(markdown);
            note.setUpdatedAt(now);
            problemNoteMapper.updateById(note);
        }
        return toView(note);
    }

    private ProblemNote findByProblemId(Long problemId) {
        return problemNoteMapper.selectOne(Wrappers.<ProblemNote>lambdaQuery()
                .eq(ProblemNote::getProblemId, problemId));
    }

    private void requireProblem(Long problemId) {
        Problem problem = problemMapper.selectById(problemId);
        if (problem == null || !Integer.valueOf(1).equals(problem.getStatus())) {
            throw ErrorCode.PROBLEM_NOT_FOUND.exception();
        }
    }

    private ProblemNoteVO toView(ProblemNote note) {
        return new ProblemNoteVO(note.getProblemId(), note.getContentMarkdown(), note.getUpdatedAt());
    }
}
