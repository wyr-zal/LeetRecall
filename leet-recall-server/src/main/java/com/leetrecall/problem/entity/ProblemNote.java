package com.leetrecall.problem.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("problem_note")
public class ProblemNote {
    @TableId(type = IdType.AUTO)
    private Long id;
    private Long problemId;
    private String contentMarkdown;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
