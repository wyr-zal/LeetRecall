package com.leetrecall.review.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.leetrecall.common.enums.MasteryLevel;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("review_record")
public class ReviewRecord {
    @TableId(type = IdType.AUTO)
    private Long id;
    private Long problemId;
    private MasteryLevel reviewResult;
    private String userRecallJson;
    private Boolean usedHint;
    private Boolean viewedAnswer;
    private Integer durationSeconds;
    private Integer previousIntervalDays;
    private Integer nextIntervalDays;
    private LocalDateTime reviewedAt;
    private LocalDateTime createdAt;
}

