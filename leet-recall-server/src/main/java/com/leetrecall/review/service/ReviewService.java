package com.leetrecall.review.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.leetrecall.common.enums.MasteryLevel;
import com.leetrecall.common.exception.ErrorCode;
import com.leetrecall.problem.entity.Problem;
import com.leetrecall.problem.entity.ProblemMistake;
import com.leetrecall.problem.entity.RecallQuestion;
import com.leetrecall.problem.mapper.ProblemMapper;
import com.leetrecall.problem.mapper.ProblemMistakeMapper;
import com.leetrecall.problem.mapper.ProblemTagMapper;
import com.leetrecall.problem.mapper.RecallQuestionMapper;
import com.leetrecall.review.dto.ReviewSubmitDTO;
import com.leetrecall.review.entity.ProblemProgress;
import com.leetrecall.review.entity.ReviewRecord;
import com.leetrecall.review.mapper.ProblemProgressMapper;
import com.leetrecall.review.mapper.ReviewRecordMapper;
import com.leetrecall.review.vo.RecallQuestionVO;
import com.leetrecall.review.vo.ReviewProblemDetailVO;
import com.leetrecall.review.vo.ReviewQueueItemVO;
import com.leetrecall.review.vo.ReviewSubmitVO;
import com.leetrecall.review.vo.TodayReviewQueueVO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Clock;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ReviewService {

    private final ProblemMapper problemMapper;
    private final ProblemTagMapper problemTagMapper;
    private final RecallQuestionMapper recallQuestionMapper;
    private final ProblemMistakeMapper problemMistakeMapper;
    private final ProblemProgressMapper problemProgressMapper;
    private final ReviewRecordMapper reviewRecordMapper;
    private final ReviewScheduler reviewScheduler;
    private final ObjectMapper objectMapper;
    private final Clock applicationClock;

    public TodayReviewQueueVO getTodayQueue() {
        LocalDate today = LocalDate.now(applicationClock);
        LocalDateTime dayStart = today.atStartOfDay();
        LocalDateTime dayEnd = today.plusDays(1).atStartOfDay();
        List<ReviewQueueItemVO> items = problemMapper.selectTodayReviewRows(dayStart, dayEnd).stream()
                .map(row -> new ReviewQueueItemVO(
                        row.getProblemId(),
                        row.getLeetcodeNumber(),
                        row.getTitle(),
                        row.getDifficulty(),
                        problemTagMapper.selectTagNames(row.getProblemId(), 4),
                        row.getMasteryLevel(),
                        Boolean.TRUE.equals(row.getCompleted()),
                        row.getTodayResult()
                ))
                .toList();
        int completed = (int) items.stream().filter(ReviewQueueItemVO::completed).count();
        return new TodayReviewQueueVO(items.size(), completed, items);
    }

    public int getReviewStreak() {
        List<LocalDate> dates = reviewRecordMapper.selectReviewDatesDesc();
        if (dates.isEmpty()) {
            return 0;
        }
        LocalDate today = LocalDate.now(applicationClock);
        LocalDate cursor = dates.getFirst().equals(today) ? today : today.minusDays(1);
        int streak = 0;
        for (LocalDate date : dates) {
            if (date.equals(cursor)) {
                streak++;
                cursor = cursor.minusDays(1);
            } else if (date.isBefore(cursor)) {
                break;
            }
        }
        return streak;
    }

    public ReviewProblemDetailVO getProblemDetail(Long problemId) {
        Problem problem = requireProblem(problemId);
        List<RecallQuestionVO> questions = recallQuestionMapper.selectList(
                        new LambdaQueryWrapper<RecallQuestion>()
                                .eq(RecallQuestion::getProblemId, problemId)
                                .orderByAsc(RecallQuestion::getSortOrder)
                ).stream()
                .map(question -> new RecallQuestionVO(
                        question.getId(),
                        question.getQuestionText(),
                        question.getAnswerText()
                ))
                .toList();
        List<String> mistakes = problemMistakeMapper.selectList(
                        new LambdaQueryWrapper<ProblemMistake>()
                                .eq(ProblemMistake::getProblemId, problemId)
                                .orderByAsc(ProblemMistake::getSortOrder)
                ).stream()
                .map(ProblemMistake::getContent)
                .toList();
        return new ReviewProblemDetailVO(
                problem.getId(),
                problem.getLeetcodeNumber(),
                problem.getTitle(),
                problem.getDifficulty(),
                problem.getDescriptionMarkdown() == null ? "" : problem.getDescriptionMarkdown(),
                problemTagMapper.selectTagNames(problemId, 4),
                questions,
                problem.getHint(),
                problem.getCoreIdea(),
                mistakes,
                problem.getKeyCode()
        );
    }

    @Transactional
    public ReviewSubmitVO submit(Long problemId, ReviewSubmitDTO request) {
        requireProblem(problemId);
        if (request.result() == MasteryLevel.NEW) {
            throw ErrorCode.INVALID_REQUEST.exception();
        }

        LocalDateTime now = LocalDateTime.now(applicationClock);
        ProblemProgress progress = problemProgressMapper.selectOne(
                new LambdaQueryWrapper<ProblemProgress>().eq(ProblemProgress::getProblemId, problemId)
        );
        if (progress == null) {
            progress = new ProblemProgress();
            progress.setProblemId(problemId);
            progress.setMasteryLevel(MasteryLevel.NEW);
            progress.setReviewIntervalDays(0);
            progress.setReviewCount(0);
            progress.setCreatedAt(now);
        }

        int previousInterval = progress.getReviewIntervalDays() == null ? 0 : progress.getReviewIntervalDays();
        int nextInterval = reviewScheduler.nextInterval(request.result(), previousInterval);
        LocalDateTime nextReviewAt = now.plusDays(nextInterval);

        ReviewRecord record = new ReviewRecord();
        record.setProblemId(problemId);
        record.setReviewResult(request.result());
        record.setUserRecallJson(writeJson(request.recallAnswers()));
        record.setUsedHint(request.usedHint());
        record.setViewedAnswer(request.viewedAnswer());
        record.setDurationSeconds(request.durationSeconds());
        record.setPreviousIntervalDays(previousInterval);
        record.setNextIntervalDays(nextInterval);
        record.setReviewedAt(now);
        record.setCreatedAt(now);
        reviewRecordMapper.insert(record);

        progress.setMasteryLevel(request.result());
        progress.setReviewIntervalDays(nextInterval);
        progress.setReviewCount((progress.getReviewCount() == null ? 0 : progress.getReviewCount()) + 1);
        progress.setLastReviewAt(now);
        progress.setNextReviewAt(nextReviewAt);
        progress.setUpdatedAt(now);
        if (progress.getId() == null) {
            problemProgressMapper.insert(progress);
        } else {
            problemProgressMapper.updateById(progress);
        }
        return new ReviewSubmitVO(nextReviewAt, nextInterval);
    }

    private Problem requireProblem(Long problemId) {
        Problem problem = problemMapper.selectById(problemId);
        if (problem == null || !Integer.valueOf(1).equals(problem.getStatus())) {
            throw ErrorCode.PROBLEM_NOT_FOUND.exception();
        }
        return problem;
    }

    private String writeJson(Object value) {
        try {
            return objectMapper.writeValueAsString(value);
        } catch (JsonProcessingException exception) {
            throw new IllegalStateException("无法序列化复习答案", exception);
        }
    }
}
