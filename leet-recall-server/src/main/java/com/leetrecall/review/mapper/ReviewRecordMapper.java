package com.leetrecall.review.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.leetrecall.review.entity.ReviewRecord;
import org.apache.ibatis.annotations.Select;

import java.time.LocalDate;
import java.util.List;

public interface ReviewRecordMapper extends BaseMapper<ReviewRecord> {
    @Select("""
            SELECT DISTINCT DATE(reviewed_at)
            FROM review_record
            ORDER BY DATE(reviewed_at) DESC
            LIMIT 365
            """)
    List<LocalDate> selectReviewDatesDesc();
}
