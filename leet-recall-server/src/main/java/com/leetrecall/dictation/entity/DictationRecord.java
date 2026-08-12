package com.leetrecall.dictation.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.leetrecall.common.enums.Language;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@TableName("dictation_record")
public class DictationRecord {
    @TableId(type = IdType.AUTO)
    private Long id;
    private Long problemId;
    private Language language;
    private String submittedAnswerJson;
    private String templateCodeSnapshot;
    private String answerJsonSnapshot;
    private Integer correctCount;
    private Integer totalCount;
    private BigDecimal accuracy;
    private Boolean viewedAnswer;
    private Integer durationSeconds;
    private LocalDateTime createdAt;
}
