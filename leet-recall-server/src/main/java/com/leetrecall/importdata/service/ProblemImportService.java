package com.leetrecall.importdata.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.leetrecall.common.enums.Language;
import com.leetrecall.common.enums.MasteryLevel;
import com.leetrecall.common.exception.ErrorCode;
import com.leetrecall.hot100.service.Hot100ManifestService;
import com.leetrecall.dictation.entity.DictationTemplate;
import com.leetrecall.dictation.mapper.DictationTemplateMapper;
import com.leetrecall.importdata.dto.ProblemCreateDTO;
import com.leetrecall.importdata.vo.ProblemCreatedVO;
import com.leetrecall.problem.entity.Problem;
import com.leetrecall.problem.entity.ProblemMistake;
import com.leetrecall.problem.entity.ProblemTag;
import com.leetrecall.problem.entity.RecallQuestion;
import com.leetrecall.problem.entity.Tag;
import com.leetrecall.problem.mapper.ProblemMapper;
import com.leetrecall.problem.mapper.ProblemMistakeMapper;
import com.leetrecall.problem.mapper.ProblemTagMapper;
import com.leetrecall.problem.mapper.RecallQuestionMapper;
import com.leetrecall.problem.mapper.TagMapper;
import com.leetrecall.review.entity.ProblemProgress;
import com.leetrecall.review.mapper.ProblemProgressMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Clock;
import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ProblemImportService {

    private final ProblemMapper problemMapper;
    private final TagMapper tagMapper;
    private final ProblemTagMapper problemTagMapper;
    private final RecallQuestionMapper recallQuestionMapper;
    private final ProblemMistakeMapper problemMistakeMapper;
    private final DictationTemplateMapper dictationTemplateMapper;
    private final ProblemProgressMapper problemProgressMapper;
    private final ObjectMapper objectMapper;
    private final Clock applicationClock;
    private final Hot100ManifestService hot100ManifestService;

    /**
     * 外部 JSON 导入专用覆盖入口：复用 problem.id，并只重建题目内容子表。
     * progress、note、review_record、dictation_record 和 answer_view 均不触碰。
     */
    @Transactional
    public ProblemCreatedVO upsertExternal(ProblemCreateDTO request, List<String> recallAnswers) {
        List<String> normalizedRecallAnswers = recallAnswers == null ? List.of() : List.copyOf(recallAnswers);
        if (normalizedRecallAnswers.size() != request.recallQuestions().size()) {
            throw ErrorCode.INVALID_REQUEST.exception();
        }
        LocalDateTime now = LocalDateTime.now(applicationClock);
        Problem problem = problemMapper.selectOne(new LambdaQueryWrapper<Problem>()
                .eq(Problem::getLeetcodeNumber, request.leetcodeNumber()));
        boolean existing = problem != null;
        if (!existing) {
            problem = new Problem();
            problem.setLeetcodeNumber(request.leetcodeNumber());
            problem.setStatus(1);
            problem.setCreatedAt(now);
        }
        var hot100Problem = hot100ManifestService.findByNumber(request.leetcodeNumber());
        problem.setStatus(1);
        problem.setHot100Order(hot100Problem == null ? null : hot100Problem.order());
        problem.setTitle(request.title().strip());
        problem.setDifficulty(request.difficulty());
        problem.setDescriptionMarkdown(request.descriptionMarkdown().strip());
        problem.setCoreIdea(request.coreIdea().strip());
        problem.setHint(request.hint().strip());
        problem.setKeyCode(request.keyCode().strip());
        problem.setFullCode(request.fullCode().strip());
        problem.setUpdatedAt(now);
        if (existing) problemMapper.updateById(problem); else problemMapper.insert(problem);

        recallQuestionMapper.delete(new LambdaQueryWrapper<RecallQuestion>().eq(RecallQuestion::getProblemId, problem.getId()));
        problemMistakeMapper.delete(new LambdaQueryWrapper<ProblemMistake>().eq(ProblemMistake::getProblemId, problem.getId()));
        problemTagMapper.delete(new LambdaQueryWrapper<ProblemTag>().eq(ProblemTag::getProblemId, problem.getId()));
        dictationTemplateMapper.delete(new LambdaQueryWrapper<DictationTemplate>().eq(DictationTemplate::getProblemId, problem.getId()));
        persistChildren(problem.getId(), request, normalizedRecallAnswers, now);
        if (!existing) {
            ProblemProgress progress = new ProblemProgress();
            progress.setProblemId(problem.getId());
            progress.setMasteryLevel(MasteryLevel.NEW);
            progress.setReviewIntervalDays(0);
            progress.setReviewCount(0);
            progress.setNextReviewAt(now);
            progress.setCreatedAt(now);
            progress.setUpdatedAt(now);
            problemProgressMapper.insert(progress);
        }
        return new ProblemCreatedVO(problem.getId(), problem.getLeetcodeNumber(), problem.getTitle());
    }

    private void persistChildren(Long problemId, ProblemCreateDTO request, List<String> recallAnswers, LocalDateTime now) {
        for (String rawTag : request.tags()) {
            String tagName = rawTag.strip();
            Tag tag = tagMapper.selectOne(new LambdaQueryWrapper<Tag>().eq(Tag::getName, tagName));
            if (tag == null) {
                tag = new Tag(); tag.setName(tagName); tag.setCreatedAt(now); tagMapper.insert(tag);
            }
            ProblemTag problemTag = new ProblemTag(); problemTag.setProblemId(problemId); problemTag.setTagId(tag.getId()); problemTagMapper.insert(problemTag);
        }
        for (int index = 0; index < request.recallQuestions().size(); index++) {
            RecallQuestion question = new RecallQuestion();
            question.setProblemId(problemId); question.setQuestionText(request.recallQuestions().get(index).strip());
            question.setAnswerText(recallAnswers.get(index).strip()); question.setSortOrder(index + 1); question.setCreatedAt(now); question.setUpdatedAt(now);
            recallQuestionMapper.insert(question);
        }
        for (int index = 0; index < request.mistakes().size(); index++) {
            ProblemMistake mistake = new ProblemMistake();
            mistake.setProblemId(problemId); mistake.setContent(request.mistakes().get(index).strip()); mistake.setSortOrder(index + 1); mistake.setCreatedAt(now); mistake.setUpdatedAt(now);
            problemMistakeMapper.insert(mistake);
        }
        DictationTemplate template = new DictationTemplate();
        template.setProblemId(problemId); template.setLanguage(Language.JAVA); template.setTemplateCode(request.dictationTemplate().strip());
        template.setAnswerJson(writeJson(request.dictationAnswers())); template.setKeywordJson(writeJson(request.keywords())); template.setCreatedAt(now); template.setUpdatedAt(now);
        dictationTemplateMapper.insert(template);
    }

    private String writeJson(Object value) {
        try {
            return objectMapper.writeValueAsString(value);
        } catch (JsonProcessingException exception) {
            throw new IllegalStateException("无法序列化导入数据", exception);
        }
    }
}
