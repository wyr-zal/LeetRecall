package com.leetrecall.dictation.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.leetrecall.common.enums.Language;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("dictation_template")
public class DictationTemplate {
    @TableId(type = IdType.AUTO)
    private Long id;
    private Long problemId;
    private Language language;
    private String templateCode;
    private String answerJson;
    private String keywordJson;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}

