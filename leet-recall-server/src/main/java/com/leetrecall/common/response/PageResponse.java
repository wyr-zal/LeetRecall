package com.leetrecall.common.response;

import java.util.List;

public record PageResponse<T>(long page, long pageSize, long total, List<T> items) {
}

