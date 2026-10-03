package com.leetrecall.review.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.leetrecall.common.enums.Difficulty;
import com.leetrecall.common.enums.MasteryLevel;
import com.leetrecall.externalimport.mapper.ExternalImportDraftMapper;
import com.leetrecall.problem.entity.Problem;
import com.leetrecall.problem.entity.RecallQuestion;
import com.leetrecall.problem.mapper.ProblemMapper;
import com.leetrecall.problem.mapper.ProblemMistakeMapper;
import com.leetrecall.problem.mapper.ProblemTagMapper;
import com.leetrecall.problem.mapper.RecallQuestionMapper;
import com.leetrecall.problem.vo.ProblemLastActivityVO;
import com.leetrecall.problem.vo.ProblemTagNameVO;
import com.leetrecall.review.dto.ReviewSubmitDTO;
import com.leetrecall.review.entity.ProblemProgress;
import com.leetrecall.review.entity.ReviewRecord;
import com.leetrecall.review.mapper.ProblemProgressMapper;
import com.leetrecall.review.mapper.ReviewRecordMapper;
import com.leetrecall.review.vo.ReviewQueueRow;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.Clock;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class ReviewServiceTest {

    @Mock private ProblemMapper problemMapper;
    @Mock private ProblemTagMapper problemTagMapper;
    @Mock private RecallQuestionMapper recallQuestionMapper;
    @Mock private ProblemMistakeMapper problemMistakeMapper;
    @Mock private ProblemProgressMapper problemProgressMapper;
    @Mock private ReviewRecordMapper reviewRecordMapper;
    @Mock private ExternalImportDraftMapper externalImportDraftMapper;

    private ReviewService reviewService;

    @BeforeEach
    void setUp() {
        Clock clock = Clock.fixed(
                Instant.parse("2026-07-23T12:00:00Z"),
                ZoneId.of("Asia/Shanghai")
        );
        reviewService = new ReviewService(
                problemMapper,
                problemTagMapper,
                recallQuestionMapper,
                problemMistakeMapper,
                problemProgressMapper,
                reviewRecordMapper,
                externalImportDraftMapper,
                new ReviewScheduler(),
                new ObjectMapper(),
                clock
        );
    }

    @Test
    void shouldBuildTodayQueueAndCompletedCount() {
        ReviewQueueRow completed = queueRow(1L, true, MasteryLevel.KNOWN);
        ReviewQueueRow pending = queueRow(8L, false, null);
        when(problemMapper.selectTodayReviewRows(any(LocalDateTime.class), any(LocalDateTime.class)))
                .thenReturn(List.of(completed, pending));
        ProblemTagNameVO pendingTag = new ProblemTagNameVO();
        pendingTag.setProblemId(8L);
        pendingTag.setName("递归");
        ProblemTagNameVO completedTag = new ProblemTagNameVO();
        completedTag.setProblemId(1L);
        completedTag.setName("树");
        when(problemTagMapper.selectTagNamesByProblemIds(List.of(1L, 8L)))
                .thenReturn(List.of(pendingTag, completedTag));
        when(problemMapper.selectLastActivityByProblemIds(List.of(1L, 8L)))
                .thenReturn(List.of());

        var result = reviewService.getTodayQueue();

        assertThat(result.total()).isEqualTo(2);
        assertThat(result.completed()).isEqualTo(1);
        assertThat(result.items()).extracting("problemId").containsExactly(1L, 8L);
        assertThat(result.items().get(0).todayResult()).isEqualTo(MasteryLevel.KNOWN);
    }

    @Test
    void shouldExposeAllHundredQueueRowsInMapperOrder() {
        List<ReviewQueueRow> rows = java.util.stream.IntStream.rangeClosed(1, 100)
                .mapToObj(number -> queueRow((long) number, number == 1, number == 1 ? MasteryLevel.KNOWN : null))
                .toList();
        when(problemMapper.selectTodayReviewRows(any(LocalDateTime.class), any(LocalDateTime.class)))
                .thenReturn(rows);
        when(problemTagMapper.selectTagNamesByProblemIds(any())).thenReturn(List.of());
        when(problemMapper.selectLastActivityByProblemIds(any())).thenReturn(List.of());

        var result = reviewService.getTodayQueue();

        assertThat(result.total()).isEqualTo(100);
        assertThat(result.completed()).isEqualTo(1);
        assertThat(result.items()).extracting("leetcodeNumber")
                .containsExactlyElementsOf(java.util.stream.IntStream.rangeClosed(1, 100).boxed().toList());
    }

    @Test
    void shouldExposeLastReviewedTimeAndKeepUntouchedProblemsNull() {
        when(problemMapper.selectTodayReviewRows(any(LocalDateTime.class), any(LocalDateTime.class)))
                .thenReturn(List.of(queueRow(1L, false, null), queueRow(8L, false, null)));
        when(problemTagMapper.selectTagNamesByProblemIds(List.of(1L, 8L))).thenReturn(List.of());
        ProblemLastActivityVO touched = new ProblemLastActivityVO();
        touched.setProblemId(1L);
        touched.setLastActivityAt(LocalDateTime.of(2026, 7, 20, 9, 30));
        ProblemLastActivityVO untouched = new ProblemLastActivityVO();
        untouched.setProblemId(8L);
        untouched.setLastActivityAt(null);
        when(problemMapper.selectLastActivityByProblemIds(List.of(1L, 8L)))
                .thenReturn(List.of(touched, untouched));

        var result = reviewService.getTodayQueue();

        assertThat(result.items().get(0).lastReviewedAt())
                .isEqualTo(LocalDateTime.of(2026, 7, 20, 9, 30));
        assertThat(result.items().get(1).lastReviewedAt()).isNull();
    }

    @Test
    void shouldExposeContentUpdatedTimeAlongsideReviewTime() {
        when(problemMapper.selectTodayReviewRows(any(LocalDateTime.class), any(LocalDateTime.class)))
                .thenReturn(List.of(queueRow(1L, false, null), queueRow(8L, false, null)));
        when(problemTagMapper.selectTagNamesByProblemIds(List.of(1L, 8L))).thenReturn(List.of());
        ProblemLastActivityVO importedOnly = new ProblemLastActivityVO();
        importedOnly.setProblemId(1L);
        importedOnly.setLastActivityAt(null);
        importedOnly.setContentUpdatedAt(LocalDateTime.of(2026, 9, 4, 11, 1, 27));
        ProblemLastActivityVO reviewedAndImported = new ProblemLastActivityVO();
        reviewedAndImported.setProblemId(8L);
        reviewedAndImported.setLastActivityAt(LocalDateTime.of(2026, 8, 19, 7, 39, 45));
        reviewedAndImported.setContentUpdatedAt(LocalDateTime.of(2026, 8, 19, 15, 6, 42));
        when(problemMapper.selectLastActivityByProblemIds(List.of(1L, 8L)))
                .thenReturn(List.of(importedOnly, reviewedAndImported));

        var result = reviewService.getTodayQueue();

        assertThat(result.items().get(0).lastReviewedAt()).isNull();
        assertThat(result.items().get(0).contentUpdatedAt())
                .isEqualTo(LocalDateTime.of(2026, 9, 4, 11, 1, 27));
        assertThat(result.items().get(1).lastReviewedAt())
                .isEqualTo(LocalDateTime.of(2026, 8, 19, 7, 39, 45));
        assertThat(result.items().get(1).contentUpdatedAt())
                .isEqualTo(LocalDateTime.of(2026, 8, 19, 15, 6, 42));
    }

    @Test
    void shouldExposeTheCorrectAnswerForEachRecallQuestion() {
        Problem problem = new Problem();
        problem.setId(1L);
        problem.setLeetcodeNumber(1);
        problem.setTitle("两数之和");
        problem.setDifficulty(Difficulty.EASY);
        problem.setDescriptionMarkdown("给定一个整数数组和目标值，返回两个下标。");
        problem.setStatus(1);

        RecallQuestion question = new RecallQuestion();
        question.setId(10L);
        question.setProblemId(1L);
        question.setQuestionText("哈希表中保存什么？");
        question.setAnswerText("数字到下标的映射。");

        when(problemMapper.selectById(1L)).thenReturn(problem);
        when(recallQuestionMapper.selectList(any())).thenReturn(List.of(question));
        when(problemMistakeMapper.selectList(any())).thenReturn(List.of());
        when(problemTagMapper.selectTagNames(1L, 4)).thenReturn(List.of("哈希表"));
        var result = reviewService.getProblemDetail(1L);

        assertThat(result.descriptionMarkdown()).contains("目标值");
        assertThat(result.recallQuestions()).singleElement().satisfies(item -> {
            assertThat(item.question()).isEqualTo("哈希表中保存什么？");
            assertThat(item.answer()).isEqualTo("数字到下标的映射。");
        });
    }

    @Test
    void shouldPersistForgotFuzzyAndKnownWithExpectedIntervals() {
        Problem problem = new Problem();
        problem.setId(1L);
        problem.setStatus(1);
        when(problemMapper.selectById(1L)).thenReturn(problem);

        assertThat(submitWithExistingProgress(MasteryLevel.FORGOT, 12).nextIntervalDays()).isEqualTo(1);
        assertThat(submitWithExistingProgress(MasteryLevel.FUZZY, 12).nextIntervalDays()).isEqualTo(3);
        assertThat(submitWithExistingProgress(MasteryLevel.KNOWN, 12).nextIntervalDays()).isEqualTo(24);
        verify(reviewRecordMapper, org.mockito.Mockito.times(3)).insert(any(ReviewRecord.class));
        verify(problemProgressMapper, org.mockito.Mockito.times(3)).updateById(any(ProblemProgress.class));
    }

    private com.leetrecall.review.vo.ReviewSubmitVO submitWithExistingProgress(
            MasteryLevel result,
            int interval
    ) {
        ProblemProgress progress = new ProblemProgress();
        progress.setId(1L);
        progress.setProblemId(1L);
        progress.setReviewIntervalDays(interval);
        progress.setReviewCount(2);
        when(problemProgressMapper.selectOne(any())).thenReturn(progress);
        return reviewService.submit(1L, new ReviewSubmitDTO(result, List.of(), false, true, 85));
    }

    private ReviewQueueRow queueRow(Long id, boolean completed, MasteryLevel todayResult) {
        ReviewQueueRow row = new ReviewQueueRow();
        row.setProblemId(id);
        row.setLeetcodeNumber(id.intValue());
        row.setTitle("题目" + id);
        row.setDifficulty(Difficulty.MEDIUM);
        row.setMasteryLevel(MasteryLevel.NEW);
        row.setCompleted(completed);
        row.setTodayResult(todayResult);
        return row;
    }
}
