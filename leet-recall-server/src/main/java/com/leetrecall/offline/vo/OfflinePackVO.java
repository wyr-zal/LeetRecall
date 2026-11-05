package com.leetrecall.offline.vo;

import java.util.List;

/**
 * 离线资料包。不含生成时间等易变字段，保证相同数据能算出相同 ETag。
 */
public record OfflinePackVO(
        int schemaVersion,
        int problemCount,
        List<OfflineProblemVO> problems
) {
}