package com.leetrecall.problem.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("problem_code_annotation")
public class ProblemCodeAnnotation {
    @TableId(type = IdType.AUTO)
    private Long id;
    private Long problemId;
    private String anchorText;
    private Integer occurrenceIndex;
    private Integer startLine;
    private Integer startColumn;
    private Integer endLine;
    private Integer endColumn;
    private String label;
    private String contentMarkdown;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
