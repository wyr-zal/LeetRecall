package com.leetrecall.problem.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.leetrecall.problem.entity.Problem;
import com.leetrecall.problem.vo.ProblemSearchItemVO;
import com.leetrecall.review.vo.ReviewQueueRow;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.time.LocalDateTime;
import java.util.List;

public interface ProblemMapper extends BaseMapper<Problem> {

    @Select("""
            SELECT p.id AS problem_id, p.leetcode_number, p.title, p.difficulty,
                   COALESCE(pp.mastery_level, 'NEW') AS mastery_level,
                   CASE WHEN EXISTS (
                       SELECT 1 FROM review_record rr
                       WHERE rr.problem_id = p.id
                         AND rr.reviewed_at >= #{dayStart}
                         AND rr.reviewed_at < #{dayEnd}
                   ) THEN TRUE ELSE FALSE END AS completed,
                   (
                       SELECT rr2.review_result FROM review_record rr2
                       WHERE rr2.problem_id = p.id
                         AND rr2.reviewed_at >= #{dayStart}
                         AND rr2.reviewed_at < #{dayEnd}
                       ORDER BY rr2.reviewed_at DESC LIMIT 1
                   ) AS today_result
            FROM problem p
            LEFT JOIN problem_progress pp ON pp.problem_id = p.id
            WHERE p.status = 1
              AND (
                  pp.next_review_at IS NULL
                  OR pp.next_review_at < #{dayEnd}
                  OR EXISTS (
                      SELECT 1 FROM review_record today_rr
                      WHERE today_rr.problem_id = p.id
                        AND today_rr.reviewed_at >= #{dayStart}
                        AND today_rr.reviewed_at < #{dayEnd}
                  )
              )
            ORDER BY completed ASC,
                     COALESCE(p.hot100_order, 2147483647) ASC,
                     p.leetcode_number ASC
            """)
    List<ReviewQueueRow> selectTodayReviewRows(
            @Param("dayStart") LocalDateTime dayStart,
            @Param("dayEnd") LocalDateTime dayEnd
    );

    @Select("""
            SELECT id AS problem_id, leetcode_number, title
            FROM problem
            WHERE status = 1
              AND (title LIKE CONCAT('%', #{keyword}, '%')
                   OR CAST(leetcode_number AS CHAR) LIKE CONCAT('%', #{keyword}, '%'))
            ORDER BY COALESCE(hot100_order, 2147483647), leetcode_number
            LIMIT 8
            """)
    List<ProblemSearchItemVO> search(@Param("keyword") String keyword);
}
