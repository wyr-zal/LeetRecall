package com.leetrecall.dictation.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("dictation_answer_view")
public class DictationAnswerView {
    @TableId(type = IdType.AUTO)
    private Long id;
    private Long problemId;
    private String sessionId;
    private LocalDateTime viewedAt;
}

