package com.leetrecall.review.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.leetrecall.common.enums.MasteryLevel;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("problem_progress")
public class ProblemProgress {
    @TableId(type = IdType.AUTO)
    private Long id;
    private Long problemId;
    private MasteryLevel masteryLevel;
    private Integer reviewIntervalDays;
    private Integer reviewCount;
    private LocalDateTime lastReviewAt;
    private LocalDateTime nextReviewAt;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}

