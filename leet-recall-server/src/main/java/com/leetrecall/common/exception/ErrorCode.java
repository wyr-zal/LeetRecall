package com.leetrecall.common.exception;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum ErrorCode {
    INVALID_REQUEST(40000, "请求参数错误"),
    PROBLEM_NOT_FOUND(40001, "题目不存在"),
    DICTATION_TEMPLATE_NOT_FOUND(40002, "默写模板不存在"),
    IMPORT_FORMAT_ERROR(40003, "Markdown 格式错误"),
    DUPLICATE_PROBLEM(40004, "题号已存在"),
    HOT100_PROBLEM_NOT_FOUND(40005, "不在已冻结的 Hot100 题单中"),
    EXTERNAL_IMPORT_DRAFT_NOT_FOUND(40006, "外部 JSON 草稿不存在"),
    EXTERNAL_IMPORT_NOT_READY(40007, "JSON 尚未通过全部硬校验"),
    EXTERNAL_IMPORT_OVERWRITE_CONFIRMATION_REQUIRED(40008, "覆盖已有题目前必须明确确认"),
    CODE_ANNOTATION_NOT_FOUND(40009, "代码批注不存在"),
    INTERNAL_ERROR(50000, "服务暂时不可用");

    private final int code;
    private final String message;

    public BusinessException exception() {
        return new BusinessException(code, message);
    }
}
