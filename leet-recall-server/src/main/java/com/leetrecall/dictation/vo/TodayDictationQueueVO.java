package com.leetrecall.dictation.vo;

import java.util.List;

public record TodayDictationQueueVO(int total, int completed, List<DictationQueueItemVO> items) {
}

