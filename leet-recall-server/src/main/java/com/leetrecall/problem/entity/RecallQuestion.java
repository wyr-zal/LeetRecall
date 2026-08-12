package com.leetrecall.problem.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("recall_question")
public class RecallQuestion {
    @TableId(type = IdType.AUTO)
    private Long id;
    private Long problemId;
    private String questionText;
    private String answerText;
    private Integer sortOrder;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}

