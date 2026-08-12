package com.leetrecall.dictation.service;

import org.junit.jupiter.api.Test;

import java.math.BigDecimal;
import java.util.Map;

import static org.assertj.core.api.Assertions.assertThat;

class DictationScorerTest {

    private final DictationScorer scorer = new DictationScorer();

    @Test
    void shouldIgnoreWhitespaceAndTrailingSemicolon() {
        var result = scorer.score(
                Map.of("blank_1", " root == q ;\n", "blank_2", "left != null"),
                Map.of("blank_1", "root==q", "blank_2", "right != null"),
                false
        );
        assertThat(result.correctCount()).isEqualTo(1);
        assertThat(result.accuracy()).isEqualByComparingTo(new BigDecimal("50.00"));
    }

    @Test
    void viewedAnswerShouldCapAccuracyAtSixty() {
        var result = scorer.score(
                Map.of("blank_1", "root", "blank_2", "left"),
                Map.of("blank_1", "root", "blank_2", "left"),
                true
        );
        assertThat(result.correctCount()).isEqualTo(2);
        assertThat(result.accuracy()).isEqualByComparingTo("60");
    }
}

