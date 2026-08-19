package com.leetrecall.importdata.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.leetrecall.common.enums.Difficulty;
import com.leetrecall.hot100.model.Hot100Manifest;
import com.leetrecall.hot100.service.Hot100ManifestService;
import com.leetrecall.dictation.mapper.DictationTemplateMapper;
import com.leetrecall.importdata.dto.ProblemCreateDTO;
import com.leetrecall.problem.entity.Problem;
import com.leetrecall.problem.entity.ProblemNote;
import com.leetrecall.problem.entity.RecallQuestion;
import com.leetrecall.problem.entity.Tag;
import com.leetrecall.problem.mapper.ProblemMapper;
import com.leetrecall.problem.mapper.ProblemMistakeMapper;
import com.leetrecall.problem.mapper.ProblemNoteMapper;
import com.leetrecall.problem.mapper.ProblemTagMapper;
import com.leetrecall.problem.mapper.RecallQuestionMapper;
import com.leetrecall.problem.mapper.TagMapper;
import com.leetrecall.review.mapper.ProblemProgressMapper;
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
import java.util.Map;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.doAnswer;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class ProblemImportServiceTest {

    @Mock private ProblemMapper problemMapper;
    @Mock private TagMapper tagMapper;
    @Mock private ProblemTagMapper problemTagMapper;
    @Mock private RecallQuestionMapper recallQuestionMapper;
    @Mock private ProblemMistakeMapper problemMistakeMapper;
    @Mock private DictationTemplateMapper dictationTemplateMapper;
    @Mock private ProblemProgressMapper problemProgressMapper;
    @Mock private ProblemNoteMapper problemNoteMapper;
    @Mock private Hot100ManifestService hot100ManifestService;

    private ProblemImportService service;

    @BeforeEach
    void setUp() {
        Clock clock = Clock.fixed(Instant.parse("2026-07-28T02:00:00Z"), ZoneId.of("Asia/Shanghai"));
        service = new ProblemImportService(
                problemMapper,
                tagMapper,
                problemTagMapper,
                recallQuestionMapper,
                problemMistakeMapper,
                dictationTemplateMapper,
                problemProgressMapper,
                problemNoteMapper,
                new ObjectMapper(),
                clock,
                hot100ManifestService
        );
    }

    @Test
    void shouldPersistRecallAnswersAndCreateNewProgress() {
        when(problemMapper.selectOne(any())).thenReturn(null);
        when(hot100ManifestService.findByNumber(1)).thenReturn(new Hot100Manifest.Hot100Problem(
                1, "哈希", 1, "两数之和", Difficulty.EASY,
                "https://leetcode.cn/problems/two-sum/"
        ));
        doAnswer(invocation -> {
            invocation.getArgument(0, Problem.class).setId(99L);
            return 1;
        }).when(problemMapper).insert(any(Problem.class));
        Tag tag = new Tag();
        tag.setId(7L);
        tag.setName("哈希表");
        when(tagMapper.selectOne(any())).thenReturn(tag);

        service.upsertExternal(request(), List.of(
                "避免使用同一个元素两次。",
                "保存数字到下标的映射。",
                "时间 O(n)，空间 O(n)。"
        ));

        ArgumentCaptor<RecallQuestion> questions = ArgumentCaptor.forClass(RecallQuestion.class);
        verify(recallQuestionMapper, times(3)).insert(questions.capture());
        ArgumentCaptor<Problem> savedProblem = ArgumentCaptor.forClass(Problem.class);
        verify(problemMapper).insert(savedProblem.capture());
        assertThat(savedProblem.getValue().getHot100Order()).isEqualTo(1);
        assertThat(questions.getAllValues())
                .extracting(RecallQuestion::getAnswerText)
                .containsExactly(
                        "避免使用同一个元素两次。",
                        "保存数字到下标的映射。",
                        "时间 O(n)，空间 O(n)。"
                );
    }

    @Test
    void shouldReplaceOnlyContentChildrenWhenProblemAlreadyExists() {
        Problem existing = new Problem();
        existing.setId(42L);
        existing.setLeetcodeNumber(1);
        when(problemMapper.selectOne(any())).thenReturn(existing);
        when(hot100ManifestService.findByNumber(1)).thenReturn(new Hot100Manifest.Hot100Problem(
                1, "哈希", 1, "两数之和", Difficulty.EASY,
                "https://leetcode.cn/problems/two-sum/"
        ));
        Tag tag = new Tag(); tag.setId(7L); tag.setName("哈希表");
        when(tagMapper.selectOne(any())).thenReturn(tag);

        var result = service.upsertExternal(request(), List.of("答一", "答二", "答三"));

        assertThat(result.problemId()).isEqualTo(42L);
        verify(problemMapper).updateById(existing);
        verify(problemMapper, never()).insert(any(Problem.class));
        verify(recallQuestionMapper).delete(any());
        verify(problemMistakeMapper).delete(any());
        verify(problemTagMapper).delete(any());
        verify(dictationTemplateMapper).delete(any());
        verify(problemProgressMapper, never()).insert(any(com.leetrecall.review.entity.ProblemProgress.class));
    }

    @Test
    void shouldWriteTheImportedNoteWhenTheProblemHasNoneYet() {
        Problem existing = new Problem();
        existing.setId(42L);
        existing.setLeetcodeNumber(1);
        when(problemMapper.selectOne(any())).thenReturn(existing);
        when(hot100ManifestService.findByNumber(1)).thenReturn(new Hot100Manifest.Hot100Problem(
                1, "哈希", 1, "两数之和", Difficulty.EASY,
                "https://leetcode.cn/problems/two-sum/"
        ));
        Tag tag = new Tag(); tag.setId(7L); tag.setName("哈希表");
        when(tagMapper.selectOne(any())).thenReturn(tag);
        when(problemNoteMapper.selectOne(any())).thenReturn(null);

        service.upsertExternal(request("## 我的笔记\n先查补数再写入。"), List.of("答一", "答二", "答三"));

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
        when(hot100ManifestService.findByNumber(1)).thenReturn(new Hot100Manifest.Hot100Problem(
                1, "哈希", 1, "两数之和", Difficulty.EASY,
                "https://leetcode.cn/problems/two-sum/"
        ));
        Tag tag = new Tag(); tag.setId(7L); tag.setName("哈希表");
        when(tagMapper.selectOne(any())).thenReturn(tag);
        ProblemNote handwritten = new ProblemNote();
        handwritten.setId(5L);
        handwritten.setProblemId(42L);
        handwritten.setContentMarkdown("我自己写的笔记");
        when(problemNoteMapper.selectOne(any())).thenReturn(handwritten);

        service.upsertExternal(request("## AI 生成的笔记"), List.of("答一", "答二", "答三"));

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
        when(hot100ManifestService.findByNumber(1)).thenReturn(new Hot100Manifest.Hot100Problem(
                1, "哈希", 1, "两数之和", Difficulty.EASY,
                "https://leetcode.cn/problems/two-sum/"
        ));
        Tag tag = new Tag(); tag.setId(7L); tag.setName("哈希表");
        when(tagMapper.selectOne(any())).thenReturn(tag);
        ProblemNote blankNote = new ProblemNote();
        blankNote.setId(5L);
        blankNote.setProblemId(42L);
        blankNote.setContentMarkdown("   ");
        when(problemNoteMapper.selectOne(any())).thenReturn(blankNote);

        service.upsertExternal(request("## AI 生成的笔记"), List.of("答一", "答二", "答三"));

        verify(problemNoteMapper).updateById(blankNote);
        assertThat(blankNote.getContentMarkdown()).isEqualTo("## AI 生成的笔记");
    }

    @Test
    void shouldNotTouchTheNoteTableWhenTheJsonHasNoNote() {
        when(problemMapper.selectOne(any())).thenReturn(null);
        when(hot100ManifestService.findByNumber(1)).thenReturn(new Hot100Manifest.Hot100Problem(
                1, "哈希", 1, "两数之和", Difficulty.EASY,
                "https://leetcode.cn/problems/two-sum/"
        ));
        doAnswer(invocation -> {
            invocation.getArgument(0, Problem.class).setId(99L);
            return 1;
        }).when(problemMapper).insert(any(Problem.class));
        Tag tag = new Tag(); tag.setId(7L); tag.setName("哈希表");
        when(tagMapper.selectOne(any())).thenReturn(tag);

        service.upsertExternal(request(), List.of("答一", "答二", "答三"));

        verify(problemNoteMapper, never()).selectOne(any());
        verify(problemNoteMapper, never()).insert(any(ProblemNote.class));
        verify(problemNoteMapper, never()).updateById(any(ProblemNote.class));
    }

    private ProblemCreateDTO request() {
        return request(null);
    }

    private ProblemCreateDTO request(String noteMarkdown) {
        return new ProblemCreateDTO(
                1,
                "两数之和",
                Difficulty.EASY,
                "给定一个整数数组和目标值，返回两个下标。",
                noteMarkdown,
                List.of("哈希表"),
                "遍历时查找补数。",
                "先查再存。",
                List.of("不能复用同一元素"),
                "class Solution {}",
                "return new int[] {};",
                List.of("问题一", "问题二", "问题三"),
                "return {{blank_1}};",
                Map.of("blank_1", "result"),
                List.of("哈希表")
        );
    }
}
