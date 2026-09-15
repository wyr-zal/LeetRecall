package com.leetrecall.problem.vo;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class ProblemLastActivityVO {
    private Long problemId;
    private LocalDateTime lastActivityAt;
    /** 题目内容最后一次被用户更新的时间；只有存在外部导入记录的题目才有值。 */
    private LocalDateTime contentUpdatedAt;
}
