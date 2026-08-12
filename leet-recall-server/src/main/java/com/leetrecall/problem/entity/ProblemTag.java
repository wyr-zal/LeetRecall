package com.leetrecall.problem.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@Data
@TableName("problem_tag")
public class ProblemTag {
    @TableId(type = IdType.AUTO)
    private Long id;
    private Long problemId;
    private Long tagId;
}

