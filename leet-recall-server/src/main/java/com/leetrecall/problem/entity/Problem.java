package com.leetrecall.problem.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.leetrecall.common.enums.Difficulty;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("problem")
public class Problem {
    @TableId(type = IdType.AUTO)
    private Long id;
    private Integer leetcodeNumber;
    private Integer hot100Order;
    private String title;
    private Difficulty difficulty;
    private String descriptionMarkdown;
    private String coreIdea;
    private String hint;
    private String keyCode;
    private String fullCode;
    private Integer status;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
