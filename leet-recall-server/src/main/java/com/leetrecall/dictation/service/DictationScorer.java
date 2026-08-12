package com.leetrecall.dictation.service;

import com.leetrecall.dictation.vo.DictationResultItemVO;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.List;
import java.util.Map;

@Component
public class DictationScorer {

    public ScoreResult score(
            Map<String, String> submitted,
            Map<String, String> correctAnswers,
            boolean viewedAnswer
    ) {
        List<DictationResultItemVO> items = correctAnswers.entrySet().stream()
                .map(entry -> {
                    String submittedAnswer = submitted.getOrDefault(entry.getKey(), "");
                    boolean correct = normalize(submittedAnswer).equals(normalize(entry.getValue()));
                    return new DictationResultItemVO(
                            entry.getKey(), submittedAnswer, entry.getValue(), correct
                    );
                })
                .toList();
        int correctCount = (int) items.stream().filter(DictationResultItemVO::correct).count();
        int totalCount = items.size();
        BigDecimal accuracy = totalCount == 0
                ? BigDecimal.ZERO
                : BigDecimal.valueOf(correctCount)
                        .multiply(BigDecimal.valueOf(100))
                        .divide(BigDecimal.valueOf(totalCount), 2, RoundingMode.HALF_UP);
        if (viewedAnswer && accuracy.compareTo(BigDecimal.valueOf(60)) > 0) {
            accuracy = BigDecimal.valueOf(60);
        }
        return new ScoreResult(correctCount, totalCount, accuracy, items);
    }

    public String normalize(String answer) {
        if (answer == null) return "";
        return answer.strip()
                .replaceAll(";+\\s*$", "")
                .replaceAll("\\s+", "");
    }

    public record ScoreResult(
            int correctCount,
            int totalCount,
            BigDecimal accuracy,
            List<DictationResultItemVO> items
    ) {
    }
}

