package com.leetrecall.dictation.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.leetrecall.dictation.entity.DictationTemplate;
import com.leetrecall.dictation.vo.DictationQueueRow;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.time.LocalDateTime;
import java.util.List;

public interface DictationTemplateMapper extends BaseMapper<DictationTemplate> {

    @Select("""
            SELECT p.id AS problem_id, p.leetcode_number, p.title,
                   CASE WHEN EXISTS (
                       SELECT 1 FROM dictation_record dr
                       WHERE dr.problem_id = p.id
                         AND dr.created_at >= #{dayStart}
                         AND dr.created_at < #{dayEnd}
                   ) THEN TRUE ELSE FALSE END AS completed,
                   (
                       SELECT dr2.accuracy FROM dictation_record dr2
                       WHERE dr2.problem_id = p.id
                         AND dr2.created_at >= #{dayStart}
                         AND dr2.created_at < #{dayEnd}
                       ORDER BY dr2.created_at DESC LIMIT 1
                   ) AS accuracy
            FROM dictation_template dt
            JOIN problem p ON p.id = dt.problem_id
            WHERE p.status = 1 AND dt.language = 'JAVA'
            ORDER BY completed ASC,
                     COALESCE(p.hot100_order, 2147483647) ASC,
                     p.leetcode_number ASC
            """)
    List<DictationQueueRow> selectTodayRows(
            @Param("dayStart") LocalDateTime dayStart,
            @Param("dayEnd") LocalDateTime dayEnd
    );
}
