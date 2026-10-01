package com.leetrecall.problem.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.leetrecall.common.exception.BusinessException;
import com.leetrecall.common.exception.ErrorCode;
import com.leetrecall.problem.dto.ProblemContentUpdateDTO;
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
import com.leetrecall.problem.vo.ProblemContentVO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Clock;
import java.time.LocalDateTime;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 快速复习页「编辑模式」的读写服务。
 *
 * 刻意不复用 ProblemImportService.updateExternalLearningMaterials：外部导入会整体替换
 * recall_question / problem_mistake / dictation_template，使 questionId 重置，
 * 从而废掉 localStorage 草稿与 review_record.user_recall_json 的关联。
 *
 * 本服务只持有题目内容相关的 Mapper，不接触 problem_note、problem_progress、review_record、
 * dictation_template 与 dictation_record，也不改写 problem.full_code（它与默写模板之间存在
 * 「答案回填后逐字符还原」不变量）和 problem.hot100_order（全局唯一键）。
 */
@Service
@RequiredArgsConstructor
public class ProblemContentService {

    private static final Pattern FENCE_PATTERN = Pattern.compile("^\\s{0,3}(`{3,}|~{3,})(.*)$");

    private final ProblemMapper problemMapper;
    private final ProblemTagMapper problemTagMapper;
    private final TagMapper tagMapper;
    private final RecallQuestionMapper recallQuestionMapper;
    private final ProblemMistakeMapper problemMistakeMapper;
    private final Clock applicationClock;

    public ProblemContentVO get(Long problemId) {
        Problem problem = requireProblem(problemId);
        List<ProblemContentVO.RecallQuestionContentVO> questions = selectQuestions(problemId).stream()
                .map(question -> new ProblemContentVO.RecallQuestionContentVO(
                        question.getId(),
                        question.getQuestionText(),
                        blankWhenNull(question.getAnswerText())
                ))
                .toList();
        List<String> mistakes = problemMistakeMapper.selectList(
                        new LambdaQueryWrapper<ProblemMistake>()
                                .eq(ProblemMistake::getProblemId, problemId)
                                .orderByAsc(ProblemMistake::getSortOrder)
                ).stream()
                .map(ProblemMistake::getContent)
                .toList();
        return new ProblemContentVO(
                problem.getId(),
                problem.getLeetcodeNumber(),
                problem.getTitle(),
                problem.getDifficulty(),
                blankWhenNull(problem.getDescriptionMarkdown()),
                problemTagMapper.selectAllTagNames(problemId),
                questions,
                blankWhenNull(problem.getHint()),
                blankWhenNull(problem.getCoreIdea()),
                mistakes,
                blankWhenNull(problem.getKeyCode())
        );
    }

    @Transactional
    public ProblemContentVO update(Long problemId, ProblemContentUpdateDTO request) {
        Problem problem = requireProblem(problemId);
        requireClosedFences(request.descriptionMarkdown(), "descriptionMarkdown");
        LocalDateTime now = LocalDateTime.now(applicationClock);

        problem.setTitle(request.title().strip());
        problem.setDifficulty(request.difficulty());
        problem.setDescriptionMarkdown(request.descriptionMarkdown().strip());
        problem.setHint(request.hint().strip());
        problem.setCoreIdea(request.coreIdea().strip());
        problem.setKeyCode(request.keyCode().strip());
        problem.setUpdatedAt(now);
        problemMapper.updateById(problem);

        replaceTags(problemId, request.tags(), now);
        syncRecallQuestions(problemId, request.recallQuestions(), now);
        replaceMistakes(problemId, request.mistakes(), now);
        return get(problemId);
    }

    /**
     * 回忆问答按 id 差分：界面保留的行沿用原 id，新增行插入，移除行删除。
     * recall_question 有 UNIQUE (problem_id, sort_order)，直接重排会在中间态撞唯一键，
     * 因此保留行先挪到负号临时位，再统一落到最终顺序。
     */
    private void syncRecallQuestions(Long problemId,
                                     List<ProblemContentUpdateDTO.RecallQuestionInput> inputs,
                                     LocalDateTime now) {
        Map<Long, RecallQuestion> existingById = new LinkedHashMap<>();
        for (RecallQuestion question : selectQuestions(problemId)) {
            existingById.put(question.getId(), question);
        }

        Set<Long> keptIds = new LinkedHashSet<>();
        for (ProblemContentUpdateDTO.RecallQuestionInput input : inputs) {
            if (input.id() == null) continue;
            if (!existingById.containsKey(input.id()) || !keptIds.add(input.id())) {
                throw ErrorCode.INVALID_REQUEST.exception();
            }
        }

        for (Long existingId : existingById.keySet()) {
            if (!keptIds.contains(existingId)) recallQuestionMapper.deleteById(existingId);
        }

        int parkedOrder = 0;
        for (Long keptId : keptIds) {
            RecallQuestion parked = new RecallQuestion();
            parked.setId(keptId);
            parked.setSortOrder(--parkedOrder);
            recallQuestionMapper.updateById(parked);
        }

        for (int index = 0; index < inputs.size(); index++) {
            ProblemContentUpdateDTO.RecallQuestionInput input = inputs.get(index);
            if (input.id() != null) continue;
            RecallQuestion created = new RecallQuestion();
            created.setProblemId(problemId);
            created.setQuestionText(input.question().strip());
            created.setAnswerText(input.answer().strip());
            created.setSortOrder(index + 1);
            created.setCreatedAt(now);
            created.setUpdatedAt(now);
            recallQuestionMapper.insert(created);
        }

        for (int index = 0; index < inputs.size(); index++) {
            ProblemContentUpdateDTO.RecallQuestionInput input = inputs.get(index);
            if (input.id() == null) continue;
            RecallQuestion updated = new RecallQuestion();
            updated.setId(input.id());
            updated.setQuestionText(input.question().strip());
            updated.setAnswerText(input.answer().strip());
            updated.setSortOrder(index + 1);
            updated.setUpdatedAt(now);
            recallQuestionMapper.updateById(updated);
        }
    }

    /** 易错点没有对外暴露 id，也没有其他表引用，整组重建即可。 */
    private void replaceMistakes(Long problemId, List<String> mistakes, LocalDateTime now) {
        problemMistakeMapper.delete(new LambdaQueryWrapper<ProblemMistake>()
                .eq(ProblemMistake::getProblemId, problemId));
        for (int index = 0; index < mistakes.size(); index++) {
            ProblemMistake mistake = new ProblemMistake();
            mistake.setProblemId(problemId);
            mistake.setContent(mistakes.get(index).strip());
            mistake.setSortOrder(index + 1);
            mistake.setCreatedAt(now);
            mistake.setUpdatedAt(now);
            problemMistakeMapper.insert(mistake);
        }
    }

    private void replaceTags(Long problemId, List<String> tags, LocalDateTime now) {
        problemTagMapper.delete(new LambdaQueryWrapper<ProblemTag>()
                .eq(ProblemTag::getProblemId, problemId));
        Set<String> applied = new LinkedHashSet<>();
        for (String rawTag : tags) {
            String tagName = rawTag.strip();
            // problem_tag 有 UNIQUE (problem_id, tag_id)，界面重复输入同名标签要先去重。
            if (!applied.add(tagName)) continue;
            Tag tag = tagMapper.selectOne(new LambdaQueryWrapper<Tag>().eq(Tag::getName, tagName));
            if (tag == null) {
                tag = new Tag();
                tag.setName(tagName);
                tag.setCreatedAt(now);
                tagMapper.insert(tag);
            }
            ProblemTag link = new ProblemTag();
            link.setProblemId(problemId);
            link.setTagId(tag.getId());
            problemTagMapper.insert(link);
        }
    }

    private List<RecallQuestion> selectQuestions(Long problemId) {
        return recallQuestionMapper.selectList(new LambdaQueryWrapper<RecallQuestion>()
                .eq(RecallQuestion::getProblemId, problemId)
                .orderByAsc(RecallQuestion::getSortOrder));
    }

    /** 未闭合的代码围栏会让题面渲染失真，必须拦住。 */
    private void requireClosedFences(String markdown, String field) {
        String[] lines = markdown.replace("\r\n", "\n").split("\n", -1);
        Character openingCharacter = null;
        int openingLength = 0;
        int openingLine = 0;
        String openingMarker = null;
        for (int index = 0; index < lines.length; index++) {
            Matcher fence = FENCE_PATTERN.matcher(lines[index]);
            if (!fence.matches()) continue;
            String marker = fence.group(1);
            String suffix = fence.group(2);
            if (openingCharacter == null) {
                openingCharacter = marker.charAt(0);
                openingLength = marker.length();
                openingLine = index + 1;
                openingMarker = marker;
            } else if (marker.charAt(0) == openingCharacter && marker.length() >= openingLength && suffix.isBlank()) {
                openingCharacter = null;
                openingLength = 0;
                openingLine = 0;
                openingMarker = null;
            }
        }
        if (openingCharacter != null) {
            throw new BusinessException(
                    ErrorCode.IMPORT_FORMAT_ERROR.getCode(),
                    field + " 第 " + openingLine + " 行：代码围栏 " + openingMarker + " 未闭合，请在代码块末尾补上同类型围栏"
            );
        }
    }

    private Problem requireProblem(Long problemId) {
        Problem problem = problemMapper.selectById(problemId);
        if (problem == null || !Integer.valueOf(1).equals(problem.getStatus())) {
            throw ErrorCode.PROBLEM_NOT_FOUND.exception();
        }
        return problem;
    }

    private String blankWhenNull(String value) {
        return value == null ? "" : value;
    }
}
