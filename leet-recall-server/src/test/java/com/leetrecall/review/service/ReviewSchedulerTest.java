package com.leetrecall.review.service;

import com.leetrecall.common.enums.MasteryLevel;
import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;

class ReviewSchedulerTest {

    private final ReviewScheduler scheduler = new ReviewScheduler();

    @Test
    void forgotShouldResetToOneDay() {
        assertThat(scheduler.nextInterval(MasteryLevel.FORGOT, 24)).isEqualTo(1);
    }

    @Test
    void fuzzyShouldScheduleThreeDays() {
        assertThat(scheduler.nextInterval(MasteryLevel.FUZZY, 12)).isEqualTo(3);
    }

    @Test
    void knownShouldStartAtThreeThenDoubleWithThirtyDayCap() {
        assertThat(scheduler.nextInterval(MasteryLevel.KNOWN, 0)).isEqualTo(3);
        assertThat(scheduler.nextInterval(MasteryLevel.KNOWN, 3)).isEqualTo(6);
        assertThat(scheduler.nextInterval(MasteryLevel.KNOWN, 24)).isEqualTo(30);
        assertThat(scheduler.nextInterval(MasteryLevel.KNOWN, 30)).isEqualTo(30);
    }

    @Test
    void newCannotBeSubmittedAsReviewResult() {
        assertThatThrownBy(() -> scheduler.nextInterval(MasteryLevel.NEW, 0))
                .isInstanceOf(IllegalArgumentException.class);
    }
}

