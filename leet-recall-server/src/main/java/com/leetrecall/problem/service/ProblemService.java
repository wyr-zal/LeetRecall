package com.leetrecall.problem.service;

import com.leetrecall.problem.mapper.ProblemMapper;
import com.leetrecall.problem.vo.ProblemSearchItemVO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ProblemService {
    private final ProblemMapper problemMapper;

    public List<ProblemSearchItemVO> search(String keyword) {
        String normalized = keyword == null ? "" : keyword.strip();
        if (normalized.isEmpty()) {
            return List.of();
        }
        return problemMapper.search(normalized);
    }
}

