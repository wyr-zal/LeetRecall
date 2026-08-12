package com.leetrecall.externalimport.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("external_import_draft")
public class ExternalImportDraft {
    @TableId(type = IdType.AUTO) private Long id;
    private Integer leetcodeNumber;
    private String status;
    private String requestPayloadJson;
    private String contentJson;
    private String draftPayloadJson;
    private String validationErrorsJson;
    private String formatVersion;
    private Long publishedProblemId;
    private LocalDateTime publishedAt;
    private Boolean compilePassed;
    private String compileOutput;
    private Boolean overwriteExisting;
    private LocalDateTime confirmedAt;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
