package com.leetrecall.dictation.vo;

import lombok.Data;

import java.math.BigDecimal;

@Data
public class DictationQueueRow {
    private Long problemId;
    private Integer leetcodeNumber;
    private String title;
    private Boolean completed;
    private BigDecimal accuracy;
}

