package com.leetrecall.importdata.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.leetrecall.common.enums.Language;
import com.leetrecall.common.exception.ErrorCode;
import com.leetrecall.dictation.entity.DictationTemplate;
import com.leetrecall.dictation.mapper.DictationTemplateMapper;
import com.leetrecall.importdata.dto.ProblemLearningMaterialsImportDTO;
import com.leetrecall.importdata.vo.ProblemCreatedVO;
import com.leetrecall.problem.entity.Problem;
import com.leetrecall.problem.entity.ProblemMistake;
import com.leetrecall.problem.entity.ProblemNote;
import com.leetrecall.problem.entity.RecallQuestion;
import com.leetrecall.problem.mapper.ProblemMapper;
import com.leetrecall.problem.mapper.ProblemMistakeMapper;
import com.leetrecall.problem.mapper.ProblemNoteMapper;
import com.leetrecall.problem.mapper.RecallQuestionMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Clock;
import java.time.LocalDateTime;

@Service
@RequiredArgsConstructor
public class ProblemImportService {

    private final ProblemMapper problemMapper;
    private final RecallQuestionMapper recallQuestionMapper;
    private final ProblemMistakeMapper problemMistakeMapper;
    private final DictationTemplateMapper dictationTemplateMapper;
    private final ProblemNoteMapper problemNoteMapper;
    private final ObjectMapper objectMapper;
    private final Clock applicationClock;

    /** 更新已有题目的学习资料，不创建题目，也不改官方字段、标签或学习进度。 */
    @Transactional
    public ProblemCreatedVO updateExternalLearningMaterials(ProblemLearningMaterialsImportDTO request) {
        LocalDateTime now = LocalDateTime.now(applicationClock);
        Problem problem = problemMapper.selectOne(new LambdaQueryWrapper<Problem>()
                .eq(Problem::getLeetcodeNumber, request.leetcodeNumber()));
        if (problem == null) throw ErrorCode.EXTERNAL_IMPORT_TARGET_NOT_FOUND.exception();
        problemMapper.update(null, new UpdateWrapper<Problem>()
                .eq("id", problem.getId())
                .set("core_idea", request.coreIdea().strip())
                .set("hint", request.hint().strip())
                .set("key_code", request.keyCode().strip())
                .set("full_code", request.fullCode().strip())
                .set("updated_at", now));

        recallQuestionMapper.delete(new LambdaQueryWrapper<RecallQuestion>().eq(RecallQuestion::getProblemId, problem.getId()));
        problemMistakeMapper.delete(new LambdaQueryWrapper<ProblemMistake>().eq(ProblemMistake::getProblemId, problem.getId()));
        dictationTemplateMapper.delete(new LambdaQueryWrapper<DictationTemplate>().eq(DictationTemplate::getProblemId, problem.getId()));
        persistChildren(problem.getId(), request, now);
        persistNoteWhenAbsent(problem.getId(), request.noteMarkdown(), now);
        return new ProblemCreatedVO(problem.getId(), problem.getLeetcodeNumber(), problem.getTitle());
    }

    private void persistChildren(Long problemId, ProblemLearningMaterialsImportDTO request, LocalDateTime now) {
        for (int index = 0; index < request.recallQuestions().size(); index++) {
            RecallQuestion question = new RecallQuestion();
            ProblemLearningMaterialsImportDTO.RecallQuestion imported = request.recallQuestions().get(index);
            question.setProblemId(problemId); question.setQuestionText(imported.question().strip());
            question.setAnswerText(imported.answer().strip()); question.setSortOrder(index + 1); question.setCreatedAt(now); question.setUpdatedAt(now);
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

    /** 笔记是用户手写内容，导入只补空白：没有记录时新建，记录内容为空白时填充，已有内容直接跳过。 */
    private void persistNoteWhenAbsent(Long problemId, String noteMarkdown, LocalDateTime now) {
        if (noteMarkdown == null || noteMarkdown.isBlank()) return;
        ProblemNote existing = problemNoteMapper.selectOne(new LambdaQueryWrapper<ProblemNote>()
                .eq(ProblemNote::getProblemId, problemId));
        if (existing == null) {
            ProblemNote note = new ProblemNote();
            note.setProblemId(problemId);
            note.setContentMarkdown(noteMarkdown.strip());
            note.setCreatedAt(now);
            note.setUpdatedAt(now);
            problemNoteMapper.insert(note);
            return;
        }
        if (existing.getContentMarkdown() != null && !existing.getContentMarkdown().isBlank()) return;
        existing.setContentMarkdown(noteMarkdown.strip());
        existing.setUpdatedAt(now);
        problemNoteMapper.updateById(existing);
    }

    private String writeJson(Object value) {
        try {
            return objectMapper.writeValueAsString(value);
        } catch (JsonProcessingException exception) {
            throw new IllegalStateException("无法序列化导入数据", exception);
        }
    }
}
