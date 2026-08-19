package com.leetrecall.problem.controller;

import com.leetrecall.common.response.ApiResponse;
import com.leetrecall.problem.dto.ProblemContentUpdateDTO;
import com.leetrecall.problem.dto.ProblemNoteUpdateDTO;
import com.leetrecall.problem.service.ProblemContentService;
import com.leetrecall.problem.service.ProblemNoteService;
import com.leetrecall.problem.service.ProblemService;
import com.leetrecall.problem.vo.ProblemContentVO;
import com.leetrecall.problem.vo.ProblemNoteVO;
import com.leetrecall.problem.vo.ProblemSearchItemVO;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/problems")
@RequiredArgsConstructor
public class ProblemController {
    private final ProblemService problemService;
    private final ProblemNoteService problemNoteService;
    private final ProblemContentService problemContentService;

    @GetMapping("/search")
    public ApiResponse<List<ProblemSearchItemVO>> search(@RequestParam(defaultValue = "") String keyword) {
        return ApiResponse.success(problemService.search(keyword));
    }

    @GetMapping("/{problemId}/note")
    public ApiResponse<ProblemNoteVO> getNote(@PathVariable Long problemId) {
        return ApiResponse.success(problemNoteService.get(problemId));
    }

    @PutMapping("/{problemId}/note")
    public ApiResponse<ProblemNoteVO> saveNote(
            @PathVariable Long problemId,
            @Valid @RequestBody ProblemNoteUpdateDTO request
    ) {
        return ApiResponse.success(problemNoteService.save(problemId, request.markdown()));
    }

    @GetMapping("/{problemId}/content")
    public ApiResponse<ProblemContentVO> getContent(@PathVariable Long problemId) {
        return ApiResponse.success(problemContentService.get(problemId));
    }

    @PutMapping("/{problemId}/content")
    public ApiResponse<ProblemContentVO> updateContent(
            @PathVariable Long problemId,
            @Valid @RequestBody ProblemContentUpdateDTO request
    ) {
        return ApiResponse.success(problemContentService.update(problemId, request));
    }
}
